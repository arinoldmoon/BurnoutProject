using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Radzen;
using UI.Models;
using UI.Services;

namespace UI.Pages.Index
{
    public partial class IndexComponent : ComponentBase, IDisposable
    {
        [Inject]
        protected OvenService OvenService { get; set; }

        [Inject]
        protected NotificationService NotificationService { get; set; }

        [Inject]
        protected GlobalService Globals { get; set; }

        public int PercenValue { get; set; } = 0;

        public void Dispose()
        {
            Globals.PropertyChanged -= OnPropertyChanged;
        }

        public void Reload()
        {
            InvokeAsync(StateHasChanged);
        }

        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            Reload();
        }

        protected override void OnInitialized()
        {
            Globals.GlobalPattern = new Pattern();

            Globals.GlobalMonitor = new MachineMonitor();
            Globals.GlobalMonitor.Coil = new Coil();
            Globals.GlobalMonitor.Temp = new Temp();
            Globals.GlobalMonitor.Status = new mcStatus();

            Globals.PropertyChanged += OnPropertyChanged;
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
                        MachineMonitor Monitor = new MachineMonitor();

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

                        if (!object.Equals(Globals.GlobalMonitor.Status.Operation, Monitor.Status.Operation))
                        {
                            if (Monitor.Status.Operation)
                            {
                                Globals.GlobalPattern.PatternNumber = Monitor.Status.PatternId;
                                NotificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"Operation", Detail = $"Runing" });
                            }
                            else
                            {
                                Globals.GlobalPattern.PatternNumber = 0;
                                NotificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"Operation", Detail = $"Stoped" });
                            }

                            Reload();
                        }

                        Globals.GlobalMonitor = Monitor;
                        await Task.Delay(1000);
                    }
                }
            }
            else
            {
                Console.WriteLine("Cannot Connect PLC");
            }
        }

        private int ProcressPercen(int current, int total) => (int)((current / total) * 100);
    }
}