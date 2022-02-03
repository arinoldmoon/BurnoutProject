using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Microsoft.AspNetCore.Components;
using UI.Protos;
using UI.Services;
using static UI.Protos.OvenProto;

namespace UI.Pages.Index
{
    public class IndexComponent : ComponentBase
    {
        [Inject]
        protected GlobalService Globals { get; set; }

        protected override async Task OnInitializedAsync()
        {
            await Task.CompletedTask;
        }
    }
}