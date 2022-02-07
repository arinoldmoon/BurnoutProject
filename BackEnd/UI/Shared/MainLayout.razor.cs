using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Radzen.Blazor;
using UI.Models;
using UI.Services;

namespace UI.Shared
{
    public class MainLayoutComponent : LayoutComponentBase
    {
        [Inject]
        protected OvenService service { get; set; }

        [Inject]
        protected GlobalService Globals { get; set; }


        protected RadzenBody body0;
        protected RadzenSidebar sidebar0;

        public MachineInfo Info { get; set; } = new MachineInfo();
        public string MachineModel { get; set; } = string.Empty;


        protected override async Task OnParametersSetAsync()
        {
            MachineModel = "GrpcService NotConnection";
            await base.OnParametersSetAsync();
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                await SidebarToggleClick();
                bool IsConnected = await service.GrpcConnect();

                if (IsConnected)
                {
                    Globals.ServiceConnected = true;
                    Globals.PlcConnected = await service.PLCConnect();

                    MachineModel = "S6 Eco (Fixed)";
                    Info = await service.GetMachineInfo();
                }
                else
                {
                    Globals.ServiceConnected = false;
                    MachineModel = "GrpcService NotConnection";
                }
                StateHasChanged();
            }
        }

        protected async Task SidebarToggleClick()
        {
            await InvokeAsync(() => { sidebar0.Toggle(); });

            await InvokeAsync(() => { body0.Toggle(); });
        }
    }
}