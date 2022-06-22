using Microsoft.AspNetCore.Components;

namespace UI.Pages.Index.Component.OperationState
{
    public partial class RuningStateComponent : ComponentBase
    {
        [Parameter]
        public int processPercen { get; set; }

        [Parameter]
        public int hTime { get; set; }

        [Parameter]
        public int mTime { get; set; }

        [Parameter]
        public int program { get; set; }
    }
}