using System;
using System.Threading;
using System.Threading.Tasks;
using GrpcService.Protos;
using Microsoft.AspNetCore.Components;
using Radzen;
using Radzen.Blazor;
using UI.Services;
// using UI.Models;

namespace UI.Shared
{
    public partial class MainLayoutComponent : LayoutComponentBase
    {
        [Inject]
        protected GlobalService? _globals { get; set; }

        [Inject]
        protected OvenService? _service { get; set; }

        protected RadzenBody? body0;
        protected RadzenSidebar? sidebar0;

        protected string MachineName { get; set; } = string.Empty;
        protected string MachineModel { get; set; } = "GrpcService NotConnection";

        protected void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "GlobalMachineInfo")
            {
                MachineName = _globals!.GlobalMachineInfo.MachineName;
                MachineModel = "S6 Eco (Fixed)";

                InvokeAsync(StateHasChanged);
            }
        }

        protected override void OnInitialized()
        {
            _globals!.PropertyChanged += OnPropertyChanged;
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
            await InvokeAsync(() => { sidebar0!.Toggle(); });

            await InvokeAsync(() => { body0!.Toggle(); });
        }
    }
}