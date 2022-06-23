using Microsoft.AspNetCore.Components;

namespace UI.Pages.Index.Component.OperationState
{
    public partial class RuningStateComponent : ComponentBase
    {
        [Parameter]
        public int processPercen { get; set; }

        [Parameter]
        public double hTime { get; set; }

        [Parameter]
        public double mTime { get; set; }

        [Parameter]
        public int program { get; set; }
    }
}