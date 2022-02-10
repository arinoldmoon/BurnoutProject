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
    public partial class PatternDetailComponent : ComponentBase, IDisposable
    {
        [Parameter]
        public Pattern PatternData { get; set; }

        [Inject]
        protected DialogService DialogService { get; set; }

        [Inject]
        protected NotificationService NotificationService { get; set; }

        [Inject]
        protected GlobalService Globals { get; set; }

        protected RadzenDataGrid<PatternItem> OvenStepGrid;

        public void Reload()
        {
            InvokeAsync(StateHasChanged);
        }

        public void Dispose()
        {
            Globals.PropertyChanged -= OnPropertyChanged;
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
            }

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
            PatternData.PatternName = "New Program";
            PatternData.StepCount = PatternData.PatternItems.Count();

            Globals.GlobalPattern = PatternData;
            DialogService.Close(null);
        }
    }
}