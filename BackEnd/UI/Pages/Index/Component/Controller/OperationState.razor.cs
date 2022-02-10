using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Radzen;
using Radzen.Blazor;
using UI.Models;
using UI.Pages.Index.Component.PatternStep;
using UI.Services;

namespace UI.Pages.Index.Component.Controller
{
    public partial class OperationStateComponent : ComponentBase
    {
        [Inject]
        protected GlobalService Globals { get; set; }

        [Inject]
        protected DialogService DialogServices { get; set; }

        [Inject]
        protected PatternService PatternServices { get; set; }

        [Inject]
        protected OperationService OperationService { get; set; }

        [Inject]
        protected NotificationService NotificationService { get; set; }

        public Pattern SelectedPattern { get; set; }

        public IList<PatternItem> CurrentPattern;

        public RadzenDataGrid<PatternItem> OvenStepGrid;

        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {

            if (args.Name == "GlobalMonitor")
            {
                CurrentPattern = SelectedPattern.PatternItems.Where(x => x.Step == Globals.GlobalMonitor.Status.CurrentStep).ToList();
            }

            StateHasChanged();

        }

        protected override async Task OnInitializedAsync()
        {
            SelectedPattern = new Pattern();
            Globals.PropertyChanged += OnPropertyChanged;

            await base.OnInitializedAsync();
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                if (Globals.GlobalMonitor.Status.Operation)
                {
                    SelectedPattern = await OperationService.CurrentPattern();
                    Globals.GlobalPattern.PatternItems = SelectedPattern.PatternItems;

                    await CheckName(SelectedPattern);
                }
                else
                {
                    SelectedPattern = Globals.GlobalPattern;
                }

                CurrentPattern = SelectedPattern.PatternItems.Where(x => x.Step == Globals.GlobalMonitor.Status.CurrentStep).ToList();
                StateHasChanged();
            }
        }

        public async Task EditProgramClick(MouseEventArgs args)
        {
            await DialogServices.OpenAsync<PatternDetail>("Edit Program", new Dictionary<string, object> { { "PatternData", SelectedPattern } });
        }

        public async Task CancelProgram(MouseEventArgs args)
        {
            Globals.GlobalPattern = new Pattern();
            await Task.CompletedTask;
        }

        public async Task StartOperation(MouseEventArgs args)
        {
            await OperationService.StartOpration(Globals.GlobalPattern);
        }

        public async Task StopOperation(MouseEventArgs args)
        {
            if (await DialogServices.Confirm("Are you sure you want to cancel this operation?") == true)
            {
                var Stop = await OperationService.StopOperation();
                if (Stop)
                {
                    Globals.GlobalPattern = new Pattern();
                    Globals.GlobalPattern.Airpump = new AirPumpSetting();
                    Globals.GlobalPattern.PatternItems.Clear();
                }
            }

            await Task.CompletedTask;
        }

        private async Task CheckName(Pattern pattern)
        {
            if (Globals.GlobalMonitor.Status.Operation)
            {
                if (pattern.PatternNumber == 99)
                {
                    SelectedPattern.PatternName = "New Program";
                }
                else
                {
                    var PatternByID = (await PatternServices.GetPatternByID(SelectedPattern.PatternNumber));
                    if (PatternByID != null)
                    {
                        SelectedPattern = PatternByID;
                    }
                    else
                    {
                        Console.WriteLine("GetPatternByID = Null");
                    }
                }
            }
        }

    }
}