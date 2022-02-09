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
        protected DialogService DialogService { get; set; }

        [Inject]
        protected GlobalService Globals { get; set; }

        public bool IsDisable { get; set; } = false;

        public void Reload()
        {
            InvokeAsync(StateHasChanged);
        }

        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "GlobalPattern")
            {
                IsDisable = Globals.GlobalPattern.PatternNumber == 0 ? false : true;
            }

            Reload();
        }

        protected override void OnInitialized()
        {
            Globals.PropertyChanged += OnPropertyChanged;
        }

        protected async Task NewProgramClick(MouseEventArgs args)
        {
            await DialogService.OpenAsync<PatternDetail>("New Program", null);
        }

        protected async Task LoadProgram(MouseEventArgs args)
        {
            await DialogService.OpenAsync<PatternList>("Load Program", null);
        }
    }
}