using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Radzen;
using Radzen.Blazor;
using UI.Models;
using UI.Services;

namespace UI.Pages.Index.Component.PatternStep
{
    public partial class PatternDetailComponent : ComponentBase
    {
        [Parameter]
        public Pattern PatternData { get; set; }

        [Inject]
        protected DialogService DialogService { get; set; }

        [Inject]
        protected NotificationService NotificationService { get; set; }

        [Inject]
        protected GlobalService Globals { get; set; }

        [Inject]
        protected PatternService PatternService { get; set; }

        protected bool btnDisable { get; set; } = true;
        protected RadzenDataGrid<PatternItem> OvenStepGrid;

        public void Reload()
        {
            InvokeAsync(StateHasChanged);
        }

        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            Reload();
        }

        protected override void OnInitialized()
        {
            if (PatternData == null)
            {
                PatternData = new Pattern();
                PatternData.Airpump = new AirPumpSetting();
                PatternData.PatternItems = new List<PatternItem>();

                PatternData.PatternNumber = 99;
                PatternData.Airpump.StartTemp = 150;
                PatternData.Airpump.EndTemp = 700;
                PatternData.Airpump.DelayDuration = 60;
            }

            chk().GetAwaiter();
            Globals.PropertyChanged += OnPropertyChanged;
        }

        protected void LoadDataGrid(LoadDataArgs args)
        {
            PatternData.PatternItems = PatternData.PatternItems.OrderBy(x => x.Step).ToList();
        }

        protected async Task GridDeleteButtonClick(MouseEventArgs args, dynamic data)
        {
            try
            {
                if (await DialogService.Confirm("Are you sure you want to delete this record?") == true)
                {
                    PatternData.PatternItems.Remove(data);
                    PatternData.StepCount = PatternData.PatternItems.Count();

                    await chk();
                    await OvenStepGrid.Reload();
                }
            }
            catch (Exception sampleDeleteProductException)
            {
                NotificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = $"Error", Detail = $"{sampleDeleteProductException}" });
            }
        }

        protected async Task AddNewRow(MouseEventArgs args)
        {
            int rowindex = PatternData.PatternItems.Count() + 1;
            if (rowindex <= 16)
            {
                PatternItem dialogResult = await DialogService.OpenAsync<AddStep>("Add New Step", new Dictionary<string, object>() { { "RowIndex", rowindex } });
                if (dialogResult != null)
                {
                    PatternData.PatternItems.Add(dialogResult);
                    PatternData.StepCount = PatternData.PatternItems.Count();

                    await chk();
                    await OvenStepGrid.InsertRow(dialogResult);
                    await OvenStepGrid.Reload();
                    await InvokeAsync(() => { StateHasChanged(); });
                }
            }
            else
            {
                NotificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = $"Error", Detail = $"Maximum Step" });
            }
        }

        protected void Next(MouseEventArgs args)
        {
            PatternData.PatternNumber = 99;
            PatternData.StepCount = PatternData.PatternItems.Count;
            PatternData.TotalTime = PatternData.PatternItems.Sum(x => x.StepDuration);

            Globals.GlobalPattern = new Pattern();
            Globals.GlobalPattern.PatternItems.Clear();

            Globals.GlobalPattern = PatternData;
            Globals.GlobalPattern.PatternItems = PatternData.PatternItems;

            Globals.SetPoint = PatternData.PatternItems.ToList();
            
            DialogService.Close(null);
        }

        protected async Task Save(MouseEventArgs args)
        {
            bool status = false;

            if (PatternData.PatternNumber == 99)
            {
                status = await PatternService.CreatePattern(PatternData);
                PatternData.PatternNumber = (await PatternService.GetPatternListAsync()).Max(x => x.PatternNumber);
                PatternData.StepCount = PatternData.PatternItems.Count;
                PatternData.TotalTime = PatternData.PatternItems.Sum(x => x.StepDuration);
            }
            else
            {
                status = await PatternService.UpdatePattern(PatternData);
            }

            if (status)
            {
                Globals.GlobalPattern = new Pattern();
                Globals.GlobalPattern.PatternItems.Clear();

                Globals.GlobalPattern = await PatternService.GetPatternByID(PatternData.PatternNumber);
                NotificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"Update Pattern", Detail = $"Success" });
            }
            else
            {
                NotificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = $"Update Pattern", Detail = $"Not Success" });
            }

            Globals.SetPoint = PatternData.PatternItems.ToList();

            DialogService.Close(null);
        }

        protected async Task TextBoxChanged()
        {
            await chk();
            await InvokeAsync(() => { StateHasChanged(); });
        }

        private async Task chk()
        {
            if (!string.IsNullOrEmpty(PatternData.PatternName) && PatternData.PatternItems.Count > 0)
            {
                btnDisable = false;
            }
            else
            {
                btnDisable = true;
            }

            await Task.CompletedTask;
        }
    }
}