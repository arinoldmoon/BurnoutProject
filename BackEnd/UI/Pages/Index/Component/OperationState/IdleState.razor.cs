using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Radzen;
using UI.Pages.Index.Component.PatternStep;
using UI.Services;

namespace UI.Pages.Index.Component.OperationState
{
    public partial class IdleStateComponent : ComponentBase
    {
        [Parameter]
        public int PatternID { get; set; } = 0;

        [Inject]
        protected DialogService? _dialogService { get; set; }

        [Inject]
        protected GlobalService? _globals { get; set; }

        protected bool IsDisable { get; set; } = false;

        protected void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "GlobalPattern")
            {
                IsDisable = _globals!.GlobalPattern.PatternId == 0 ? false : true;
                InvokeAsync(StateHasChanged);
            }           
        }

        protected override void OnInitialized()
        {
            _globals!.PropertyChanged += OnPropertyChanged;
        }

        protected async Task NewProgramClick(MouseEventArgs args) => await _dialogService!.OpenAsync<PatternDetail>("New Program", null);
        protected async Task LoadProgram(MouseEventArgs args) => await _dialogService!.OpenAsync<PatternList>("Load Program", null);
        
    }
}