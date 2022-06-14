using GrpcService.Protos;
using Iot.Device.CpuTemperature;
using Microsoft.AspNetCore.Components;
using UI.Models;
using UI.Services;


namespace UI.Pages.Index
{
    public partial class IndexComponent : ComponentBase, IDisposable
    {
        [Inject]
        protected OvenService? _ovenService { get; set; }

        [Inject]
        protected GlobalService? _globals { get; set; }

        private ProtoOvenResponse Monitor = new ProtoOvenResponse();
        private List<OperationLog> ActualPoint { get; set; } = new List<OperationLog>();

        public int PercenValue
        {
            get
            {
                return (Monitor.Status.CurrentStep / Monitor.Status.TotalStep) * 100;
            }
        }

        public void Dispose()
        {
            _globals!.PropertyChanged -= OnPropertyChanged;
        }

        private void Reload()
        {
            InvokeAsync(StateHasChanged);
        }

        protected void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "GlobalMachineInfo")
            {
                if (_globals!.ServiceConnected)
                {
                    Task.Run(() => MonitorDevice());
                }
            }

            if (args.Name == "GlobalPattern")
            {
                Reload();
            }
        }

        protected override void OnInitialized()
        {
            _globals!.PropertyChanged += OnPropertyChanged;

            if (_globals.GlobalMonitor == null)
            {
                _globals.GlobalMonitor = new ProtoOvenResponse()
                {
                    Temp = new Temp(),
                    Coil = new Coil(),
                    Status = new MachineStatus()
                };
            }

            if (_globals.GlobalPattern == null)
            {
                _globals.GlobalPattern = new ProtoPattern();
            }

            if (_globals.ActualPoint == null)
            {
                _globals.ActualPoint = new List<OperationLog>();
            }

            if (_globals.SetPoint == null)
            {
                _globals.SetPoint = new List<ProtoPatternDetail>();
            }
        }

        protected override void OnAfterRender(bool firstRender)
        {
            if (firstRender)
            {
                Task.Run(() => _ovenService!.DeviceConnect().ContinueWith(res =>
                {
                    _globals!.ServiceConnected = res.IsCompletedSuccessfully;
                    _globals.PlcConnected = res.Result.PlcConnected;
                    _globals.GlobalMachineInfo = res.Result.OvenInfo;
                    Console.WriteLine($"DeviceConnect : {res.IsCompletedSuccessfully}");
                }));
            }
        }

        private Task MonitorDevice()
        {
            if (_globals!.PlcConnected)
            {
                return _ovenService!.MonitorDevice().ContinueWith(async res =>
                {
                    while (await res.Result.ResponseStream.MoveNext(CancellationToken.None))
                    {
                        GetCPUTemp();
                        await Task.Run(() =>
                        {
                            Monitor.Temp = new Temp()
                            {
                                TempOven = res.Result.ResponseStream.Current.Temp.TempOven,
                                TempAFB = res.Result.ResponseStream.Current.Temp.TempAFB,
                                TempFloor = res.Result.ResponseStream.Current.Temp.TempFloor,
                                TempTube = res.Result.ResponseStream.Current.Temp.TempTube
                            };

                            Monitor.Coil = new Coil()
                            {
                                CoilOven = res.Result.ResponseStream.Current.Coil.CoilOven,
                                CoilAFB = res.Result.ResponseStream.Current.Coil.CoilAFB,
                                CoilFloor = res.Result.ResponseStream.Current.Coil.CoilFloor,
                                CoilTube = res.Result.ResponseStream.Current.Coil.CoilTube,
                                CoilPump = res.Result.ResponseStream.Current.Coil.CoilPump
                            };

                            Monitor.Status = new MachineStatus()
                            {
                                Door = res.Result.ResponseStream.Current.Status.Door,
                                Operation = res.Result.ResponseStream.Current.Status.Operation,
                                PatternId = res.Result.ResponseStream.Current.Status.PatternId,
                                TotalStep = res.Result.ResponseStream.Current.Status.TotalStep,
                                CurrentStep = res.Result.ResponseStream.Current.Status.CurrentStep,
                                PatternStatus = res.Result.ResponseStream.Current.Status.PatternStatus,
                                RemainHours = res.Result.ResponseStream.Current.Status.RemainHours,
                                RemainMins = res.Result.ResponseStream.Current.Status.RemainMins,
                            };
                        }).ContinueWith(task =>
                        {
                            if (_globals.GlobalMonitor.Status != null)
                            {
                                if (!object.Equals(_globals.GlobalMonitor.Status.Operation, Monitor.Status.Operation))
                                {
                                    _globals.GlobalPattern.PatternId = (Monitor.Status.Operation) ? Monitor.Status.PatternId : 0;
                                }
                            }

                            if (Monitor.Status.TempLog.Any() && !object.Equals(_globals.GlobalMonitor.Status!.TempLog.Count, Monitor.Status.TempLog.Count))
                            {
                                foreach (var item in Monitor.Status.TempLog)
                                {
                                    ActualPoint.Add(new OperationLog()
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
                            }


                        }).ContinueWith(task =>
                        {
                            _globals.GlobalMonitor = Monitor;
                            _globals.ActualPoint = ActualPoint;
                            Reload();
                        });

                    }
                });
            }
            else
            {
                Console.WriteLine("Cannot Connect PLC");
                return Task.CompletedTask;
            }
        }

        private void GetCPUTemp()
        {           
            try
            {
                using (CpuTemperature cpuTemperature = new CpuTemperature())
                {
                    if (cpuTemperature.IsAvailable)
                    {
                        var temperature = cpuTemperature.ReadTemperatures();
                        foreach (var entry in temperature)
                        {
                            if (!double.IsNaN(entry.Temperature.DegreesCelsius))
                            {                                
                                _globals!.CpuTemp = entry.Temperature.DegreesCelsius;
                            }                            
                        }
                    }                    
                    cpuTemperature.Dispose();
                }                
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception : {ex.Message}");
            }
        }
    }
}