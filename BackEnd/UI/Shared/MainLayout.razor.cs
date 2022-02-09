using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Radzen.Blazor;
using UI.Models;
using UI.Services;

namespace UI.Shared
{
    public partial class MainLayoutComponent : LayoutComponentBase
    {
        [Inject]
        protected OvenService service { get; set; }

        [Inject]
        protected GlobalService Globals { get; set; }


        protected RadzenBody body0;
        protected RadzenSidebar sidebar0;

        public MachineInfo Info { get; set; } = new MachineInfo();
        public string MachineModel { get; set; } = "GrpcService NotConnection";
        private bool IsConnected = false;

        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {
        }

        protected override void OnInitialized()
        {
            Globals.PropertyChanged += OnPropertyChanged;
            IsConnected = service.GrpcConnect();

            if (IsConnected)
            {
                MachineModel = "S6 Eco (Fixed)";
                Globals.ServiceConnected = true;
            }
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                await SidebarToggleClick();

                if (IsConnected)
                {
                    Globals.PlcConnected = service.PLCConnect();
                    Info = await service.GetMachineInfo();

                    StateHasChanged();
                }
            }
        }

        protected async Task SidebarToggleClick()
        {
            await InvokeAsync(() => { sidebar0.Toggle(); });

            await InvokeAsync(() => { body0.Toggle(); });
        }
    }
}