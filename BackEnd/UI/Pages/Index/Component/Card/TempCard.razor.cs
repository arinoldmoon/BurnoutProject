using Microsoft.AspNetCore.Components;

namespace UI.Pages.Index.Component.Card
{
    public partial class TempCardComponent : ComponentBase
    {
        [Parameter]
        public bool State { get; set; } = false;

        [Parameter]
        public int Value { get; set; } = 0;

        [Parameter]
        public string CardName { get; set; } = string.Empty;
    }
}