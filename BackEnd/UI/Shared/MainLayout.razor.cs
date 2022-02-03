using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Microsoft.AspNetCore.Components;
using Radzen.Blazor;
using UI.Protos;
using static UI.Protos.OvenProto;

namespace UI.Shared
{
    public class MainLayoutComponent : LayoutComponentBase
    {
        [Inject]
        protected OvenProtoClient Client { get; set; }
        protected RadzenBody body0;
        protected RadzenSidebar sidebar0;

        public ProtoOvenInfo Info { get; set; } = new ProtoOvenInfo();
        public string MachineModel { get; set; } = string.Empty;

        protected override async Task OnInitializedAsync()
        {
            var _IsConnected = await Client.GrpcConnectAsync(new Empty());
            if (_IsConnected.Value)
            {
                Info = await Client.GetOvenInfoAsync(new Empty());
                MachineModel = "S6 Eco (Fixed)";
            }
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                await SidebarToggleClick();
            }
        }

        protected async Task SidebarToggleClick()
        {
            await InvokeAsync(() => { sidebar0.Toggle(); });

            await InvokeAsync(() => { body0.Toggle(); });
        }
    }
}