using Microsoft.AspNetCore.Components;

namespace UI.Pages.Index.Component.Cards
{
    public partial class SensorCardComponent : ComponentBase
    {
        [Parameter]
        public bool State { get; set; } = false;

        [Parameter]
        public string CardName { get; set; } = string.Empty;
    }
}