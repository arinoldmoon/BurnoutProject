using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Radzen;
using Radzen.Blazor;
using UI.Models;

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


        protected RadzenDataGrid<PatternItem> OvenStepGrid;

        protected override async Task OnInitializedAsync()
        {
            PatternData = new Pattern();
            PatternData.Airpump = new AirPumpSetting();
            PatternData.PatternItems = new List<PatternItem>();

            await Task.CompletedTask;
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
                PatternItem dialogResult = await DialogService.OpenAsync<AddStep>("Add New Step", new Dictionary<string, object>() { { "_rowindex", rowindex } });
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

        protected async Task Next(MouseEventArgs args)
        {
            // PatternData.PatternNumber = 99;            
            await Task.CompletedTask;

            DialogService.Close(null);
        }
    }
}