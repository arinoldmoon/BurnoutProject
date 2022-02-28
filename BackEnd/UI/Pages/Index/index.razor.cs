using System;
using System.Collections.Generic;
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
            if (args.Name == "GlobalPattern")
            {
                Reload();
            }
        }

        protected override void OnInitialized()
        {
            Globals.GlobalPattern = new Pattern();

            Globals.GlobalMonitor = new MachineMonitor();
            Globals.GlobalMonitor.Coil = new Coil();
            Globals.GlobalMonitor.Temp = new Temp();
            Globals.GlobalMonitor.Status = new McStatus();
            Globals.GlobalMonitor.Status.TempLog = new List<OperationLog>();

            Globals.PropertyChanged += OnPropertyChanged;
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                if(Globals.ServiceConnected)
                {
                    Globals.GlobalMachineInfo = await OvenService.GetMachineInfo();
                    await MonitorDevice();
                }
            }
        }

        private async Task MonitorDevice()
        {
            if (Globals.PlcConnected)
            {                
                using (var response = await OvenService.MonitorDevice())
                {
                    while (await response.ResponseStream.MoveNext(CancellationToken.None))
                    {
                        MachineMonitor Monitor = new MachineMonitor();
                        Monitor.Temp = new Temp()
                        {
                            TempOven = response.ResponseStream.Current.Temp.TempOven,
                            TempAFB = response.ResponseStream.Current.Temp.TempAFB,
                            TempFloor = response.ResponseStream.Current.Temp.TempFloor,
                            TempTube = response.ResponseStream.Current.Temp.TempTube
                        };

                        Monitor.Coil = new Coil()
                        {
                            CoilOven = response.ResponseStream.Current.Coil.CoilOven,
                            CoilAFB = response.ResponseStream.Current.Coil.CoilAFB,
                            CoilFloor = response.ResponseStream.Current.Coil.CoilFloor,
                            CoilTube = response.ResponseStream.Current.Coil.CoilTube,
                            CoilPump = response.ResponseStream.Current.Coil.CoilPump
                        };


                         Monitor.Status = new Models.McStatus()
                        {
                            Door = response.ResponseStream.Current.Status.Door,
                            Operation = response.ResponseStream.Current.Status.Operation,
                            PatternId = response.ResponseStream.Current.Status.PatternId,
                            TotalStep = response.ResponseStream.Current.Status.TotalStep,
                            CurrentStep = response.ResponseStream.Current.Status.CurrentStep,
                            PatternStatus = (PatternStatus)response.ResponseStream.Current.Status.PatternStatus,
                            RemainHours = (int)TimeSpan.FromSeconds(response.ResponseStream.Current.Status.RemainHours.Seconds).TotalHours,
                            RemainMins = (int)TimeSpan.FromSeconds(response.ResponseStream.Current.Status.RemainMins.Seconds).TotalMinutes,
                            TempLog = new List<OperationLog>()
                        };                       

                        if(response.ResponseStream.Current.Status.TempLog.Count > 0 && !object.Equals(Globals.GlobalMonitor.Status.Operation,response.ResponseStream.Current.Status.TempLog.Count))
                        {
                            List<OperationLog> result = new List<OperationLog>();
                            foreach(var item  in response.ResponseStream.Current.Status.TempLog)
                            {
                                result.Add(new OperationLog()
                                {
                                    TempTime = item.TempTime.ToDateTime().ToLocalTime(),
                                    TempValue = new Temp()
                                    {
                                        TempOven = item.TempValue.TempOven,
                                        TempAFB = item.TempValue.TempAFB,
                                        TempFloor = item.TempValue.TempFloor,
                                        TempTube = item.TempValue.TempTube
                                    }
                                });
                            }
                            Monitor.Status.TempLog = result;
                        }

                        if (!object.Equals(Globals.GlobalMonitor.Status.Operation, Monitor.Status.Operation))
                        {
                            if (Monitor.Status.Operation)
                            {
                                Globals.GlobalPattern.PatternNumber = Monitor.Status.PatternId;
                                PercenValue = ProcressPercen(Monitor.Status.CurrentStep, Monitor.Status.TotalStep);
                            }
                            else
                            {
                                Globals.GlobalPattern.PatternNumber = 0;
                            }
                        }

                        Globals.GlobalMonitor = Monitor;
                        Reload();
                    }
                }
            }
            else
            {
                Console.WriteLine("Cannot Connect PLC");
            }
        }

        private int ProcressPercen(decimal current, decimal total) => (int)((current / total) * 100);
    }
}