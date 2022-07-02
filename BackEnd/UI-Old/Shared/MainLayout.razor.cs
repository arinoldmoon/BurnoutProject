using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Radzen;
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
        protected OperationService operation { get; set; }

        [Inject]
        protected GlobalService Globals { get; set; }


        protected RadzenBody body0;
        protected RadzenSidebar sidebar0;

        public string MachineName { get; set; } = string.Empty;
        public string MachineModel { get; set; } = "GrpcService NotConnection";

        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "MachineInfo")
            {
                MachineName = Globals.GlobalMachineInfo.MachineName;
                Reload();
            }
        }

        public void Reload()
        {
            InvokeAsync(StateHasChanged);
        }

        protected override async Task OnInitializedAsync()
        {
            Globals.PropertyChanged += OnPropertyChanged;

            if (service.GrpcConnect())
            {
                MachineModel = "S6 Eco (Fixed)";
                Globals.ServiceConnected = true;
                Globals.PlcConnected = service.PLCConnect();

                Reload();
            }

            await Task.CompletedTask;
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

        protected async Task Notifications()
        {
            var response = await operation.StopOperation();
            if (response)
            {
                Globals.GlobalPattern = new Pattern();
                Globals.GlobalPattern.Airpump = new AirPumpSetting();
                Globals.GlobalPattern.PatternItems.Clear();
            }
        }
    }
}