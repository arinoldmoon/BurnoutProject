using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using UI.Models;
using UI.Services;

namespace UI.Pages.Index
{
    public partial class IndexComponent : ComponentBase
    {
        [Inject]
        protected OvenService OvenService { get; set; }

        [Inject]
        protected PatternService PatternService { get; set; }

        [Inject]
        protected GlobalService Globals { get; set; }

        public MachineMonitor Monitor { get; set; }

        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if(args.Name == "GlobalPattern")
            {
                StateHasChanged();
            }
        }

        public void Dispose()
        {
            Globals.PropertyChanged -= OnPropertyChanged;
        }

        protected override void OnInitialized()
        {
            Globals.PropertyChanged += OnPropertyChanged;

            Monitor = new MachineMonitor();
            Monitor.Temp = new Temp();
            Monitor.Coil = new Coil();
            Monitor.Status = new mcStatus();

            Globals.GlobalPattern = new Pattern();
            Globals.GlobalMonitor = Monitor;
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                if (Globals.PlcConnected)
                {
                    await MonitorDevice();
                }
            }
        }

        private async Task MonitorDevice()
        {
            if (Globals.ServiceConnected && Globals.PlcConnected)
            {
                using (var response = await OvenService.MonitorDevice())
                {
                    while (await response.ResponseStream.MoveNext(CancellationToken.None))
                    {
                        Monitor.Temp = new Models.Temp()
                        {
                            TempOven = response.ResponseStream.Current.Temp.TempOven,
                            TempAFB = response.ResponseStream.Current.Temp.TempAFB,
                            TempFloor = response.ResponseStream.Current.Temp.TempFloor,
                            TempTube = response.ResponseStream.Current.Temp.TempTube
                        };

                        Monitor.Coil = new Models.Coil()
                        {
                            CoilOven = response.ResponseStream.Current.Coil.CoilOven,
                            CoilAFB = response.ResponseStream.Current.Coil.CoilAFB,
                            CoilFloor = response.ResponseStream.Current.Coil.CoilFloor,
                            CoilTube = response.ResponseStream.Current.Coil.CoilTube
                        };

                        Monitor.Status = new mcStatus()
                        {
                            Door = response.ResponseStream.Current.Status.Door,
                            Operation = response.ResponseStream.Current.Status.Operation,
                            PatternId = response.ResponseStream.Current.Status.PatternId,
                            TotalStep = response.ResponseStream.Current.Status.TotalStep,
                            CurrentStep = response.ResponseStream.Current.Status.CurrentStep,
                            PatternStatus = (PatternStatus)response.ResponseStream.Current.Status.PatternStatus,
                            RemainHours = (int)TimeSpan.FromSeconds(response.ResponseStream.Current.Status.RemainHours.Seconds).TotalHours,
                            RemainMins = (int)TimeSpan.FromSeconds(response.ResponseStream.Current.Status.RemainHours.Seconds).TotalMinutes
                        };

                        if (response.ResponseStream.Current.Status.Operation)
                        {
                            Globals.GlobalMonitor = Monitor;
                            Globals.GlobalPattern = await PatternService.GetPatternByID(response.ResponseStream.Current.Status.PatternId);
                        }

                        StateHasChanged();
                    }
                }
            }
            else
            {
                Console.WriteLine("Cannot Connect PLC");
            }
        }
    }
}