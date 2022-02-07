using System;
using System.Collections.Generic;
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
        protected DialogService DialogService { get; set; }

        [Inject]
        protected PatternService Services { get; set; }

        public Pattern SelectedPattern { get; set; }


        public RadzenDataGrid<PatternItem> OvenStepGrid;

        protected void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if(args.Name == "GlobalPattern")
            {
                SelectedPattern = Globals.GlobalPattern;
                StateHasChanged();
            }
        }

        protected override async Task OnInitializedAsync()
        {
            Globals.PropertyChanged += OnPropertyChanged;
            SelectedPattern = new Pattern();

            await base.OnInitializedAsync();
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                SelectedPattern = Globals.GlobalPattern;
                StateHasChanged();
            }
            await base.OnAfterRenderAsync(firstRender);
        }

        public async Task EditProgramClick(MouseEventArgs args)
        {
            await DialogService.OpenAsync<PatternDetail>("Edit Program", new Dictionary<string, object> { { "PatternData", SelectedPattern } });
        }

        public async Task CancelProgram(MouseEventArgs args)
        {
            Globals.GlobalPattern = new Pattern();

            await Task.CompletedTask;
        }

        public async Task StartOperation(MouseEventArgs args)
        {
            await Task.CompletedTask;
        }

        public async Task StopOperation(MouseEventArgs args)
        {
            await Task.CompletedTask;
        }
    }
}