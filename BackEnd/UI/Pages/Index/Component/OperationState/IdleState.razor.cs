using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Radzen;
using UI.Pages.Index.Component.PatternStep;

namespace UI.Pages.Index.Component.OperationState
{
    public partial class IdleStateComponent : ComponentBase
    {
        [Parameter]
        public int PatternID { get; set; } = 0;

        [Inject]
        protected DialogService DialogService { get; set; }

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