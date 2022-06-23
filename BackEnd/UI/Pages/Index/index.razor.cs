using Microsoft.AspNetCore.Components;
using UI.Services;
using GrpcService.Protos;
using Grpc.Core;
using Google.Protobuf.WellKnownTypes;
using System.ComponentModel;
using UI.Models;

namespace UI.Pages.Index
{
    public partial class IndexComponent : ComponentBase, IDisposable
    {
        [Inject]
        protected OvenService? _ovenService { get; set; }

        [Inject]
        protected PatternService? _patternService { get; set; }

        [Inject]
        protected GlobalService? _globals { get; set; }

        private BackgroundWorker WorkerMonitor = new BackgroundWorker();
        private ProtoOvenResponse Monitor = new ProtoOvenResponse();
        public int PercenValue;

        private void Reload()
        {
           InvokeAsync(StateHasChanged);
        }

        public void Dispose()
        {
            WorkerMonitor.CancelAsync();
        }

        protected override void OnInitialized()
        {
            WorkerMonitor.DoWork += WorkerMonitor_DoWork!;
            WorkerMonitor.WorkerSupportsCancellation = true;

            _globals!.GlobalMonitor = new ProtoOvenResponse()
            {
                Temp = new Temp(),
                Coil = new Coil(),
                Status = new MachineStatus()
            };
            _globals.GlobalPattern = new ProtoPattern();
            _globals.ActualPoint = new List<OperationLog>();
            _globals.SetPoint = new List<ProtoPatternDetail>();

        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                ProtoServiceConnection response = await _ovenService!.DeviceConnect();
                if (response != null)
                {
                    _globals!.ServiceConnected = true;
                    _globals.PlcConnected = response.PlcConnected;
                    _globals.GlobalMachineInfo = response.OvenInfo;
                    _globals.OperationLogInfo = response.OperationLogInfo;

                    Console.WriteLine("DeviceConnect : True");
                    Reload();
                }

                if (!WorkerMonitor.IsBusy)
                {
                    WorkerMonitor.RunWorkerAsync();
                }
            }
        }

        private async void WorkerMonitor_DoWork(object sender, DoWorkEventArgs e)
        {
            BackgroundWorker worker = (BackgroundWorker)sender;
            Console.WriteLine("MonitorDevice Start");

            AsyncServerStreamingCall<ProtoOvenResponse> response = await _ovenService!.MonitorDevice();

            while (!worker.CancellationPending && await response.ResponseStream.MoveNext(CancellationToken.None))
            {               
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

                Monitor.Status = new MachineStatus()
                {
                    Door = response.ResponseStream.Current.Status.Door,
                    Operation = response.ResponseStream.Current.Status.Operation,
                    PatternId = response.ResponseStream.Current.Status.PatternId,
                    TotalStep = response.ResponseStream.Current.Status.TotalStep,
                    CurrentStep = response.ResponseStream.Current.Status.CurrentStep,
                    PatternStatus = response.ResponseStream.Current.Status.PatternStatus,
                    RemainHours = response.ResponseStream.Current.Status.RemainHours,
                    RemainMins = response.ResponseStream.Current.Status.RemainMins,
                    TempLogList = response.ResponseStream.Current.Status.TempLogList
                };

                if (Monitor.Status.TotalStep > 0)
                {
                    PercenValue = (Monitor.Status.CurrentStep / Monitor.Status.TotalStep) * 100;
                }

                if (Monitor.Status.Operation)
                {
                    if (Monitor.Status.PatternId != _globals!.GlobalPattern.PatternId)
                    {
                        int PatternId = (Monitor.Status.Operation) ? Monitor.Status.PatternId : 0;
                        if (PatternId > 0)
                        {
                            _globals.GlobalPattern.PatternId = PatternId;
                            _globals.GlobalPattern = await _patternService!.GetPatternByID(PatternId);
                        }
                    }

                    if (Monitor.Status.TempLogList.TempLog.Any() && !object.Equals(_globals!.ActualPoint.Count, Monitor.Status.TempLogList.TempLog.Count))
                    {
                        List<OperationLog> result = new List<OperationLog>();
                        foreach (var item in Monitor.Status.TempLogList.TempLog)
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

                        _globals.ActualPoint = result;
                        _globals.SetPoint = _globals.GlobalPattern.PatternDetail.ToList();
                    }
                }    

                _globals!.GlobalMonitor = Monitor;     
                Reload();       

                // if (Monitor.Status.PatternId != _globals!.GlobalPattern.PatternId)
                // {
                //     int PatternId = (Monitor.Status.Operation) ? Monitor.Status.PatternId : 0;
                //     if (PatternId > 0)
                //     {
                //         _globals.GlobalPattern.PatternId = PatternId;
                //         _globals.GlobalPattern = await _patternService!.GetPatternByID(PatternId);                        
                //     }

                //     if (Monitor.Status.TempLogList.TempLog.Any() && !object.Equals(_globals!.ActualPoint.Count, Monitor.Status.TempLogList.TempLog.Count))
                //     {
                //         List<OperationLog> result = new List<OperationLog>();
                //         foreach (var item in Monitor.Status.TempLogList.TempLog)
                //         {
                //             result.Add(new OperationLog()
                //             {
                //                 TempTime = item.TempTime.ToDateTime().ToLocalTime(),
                //                 TempValue = new Temp()
                //                 {
                //                     TempOven = item.TempValue.TempOven,
                //                     TempAFB = item.TempValue.TempAFB,
                //                     TempFloor = item.TempValue.TempFloor,
                //                     TempTube = item.TempValue.TempTube
                //                 }
                //             });
                //         }

                //         _globals.ActualPoint = result;
                //         _globals.SetPoint = _globals.GlobalPattern.PatternDetail.ToList();
                //     }
                // }

                // if (Monitor.Status.Operation && _globals!.GlobalPattern.PatternId == 0)
                // {
                //     // _globals!.SetPoint = _globals.GlobalPattern.PatternDetail.ToList();
                //     //     if (Monitor.Status.TempLogList.TempLog.Any() && !object.Equals(_globals!.ActualPoint.Count, Monitor.Status.TempLogList.TempLog.Count))
                //     // {
                //     //     List<OperationLog> result = new List<OperationLog>();
                //     //     foreach (var item in Monitor.Status.TempLogList.TempLog)
                //     //     {
                //     //         result.Add(new OperationLog()
                //     //         {
                //     //             TempTime = item.TempTime.ToDateTime().ToLocalTime(),
                //     //             TempValue = new Temp()
                //     //             {
                //     //                 TempOven = item.TempValue.TempOven,
                //     //                 TempAFB = item.TempValue.TempAFB,
                //     //                 TempFloor = item.TempValue.TempFloor,
                //     //                 TempTube = item.TempValue.TempTube
                //     //             }
                //     //         });
                //     //     }
                //     //     _globals.ActualPoint = result;
                //     // }
                // }

                
                // _globals.GlobalPattern.PatternId = (Monitor.Status.Operation) ? Monitor.Status.PatternId : 0;

                
                
            }
        }

        // private async Task MonitorDevice()
        // {
        //     Console.WriteLine("MonitorDevice Start");

        //     AsyncServerStreamingCall<ProtoOvenResponse> response = await _ovenService!.MonitorDevice();
        //     while (!cancellationToken.IsCancellationRequested && await response.ResponseStream.MoveNext(CancellationToken.None))
        //     {
        //         MonitorCount++;
        //         Monitor.Temp = new Temp()
        //         {
        //             TempOven = response.ResponseStream.Current.Temp.TempOven,
        //             TempAFB = response.ResponseStream.Current.Temp.TempAFB,
        //             TempFloor = response.ResponseStream.Current.Temp.TempFloor,
        //             TempTube = response.ResponseStream.Current.Temp.TempTube
        //         };

        //         Monitor.Coil = new Coil()
        //         {
        //             CoilOven = response.ResponseStream.Current.Coil.CoilOven,
        //             CoilAFB = response.ResponseStream.Current.Coil.CoilAFB,
        //             CoilFloor = response.ResponseStream.Current.Coil.CoilFloor,
        //             CoilTube = response.ResponseStream.Current.Coil.CoilTube,
        //             CoilPump = response.ResponseStream.Current.Coil.CoilPump
        //         };

        //         Monitor.Status = new MachineStatus()
        //         {
        //             Door = response.ResponseStream.Current.Status.Door,
        //             Operation = response.ResponseStream.Current.Status.Operation,
        //             PatternId = response.ResponseStream.Current.Status.PatternId,
        //             TotalStep = response.ResponseStream.Current.Status.TotalStep,
        //             CurrentStep = response.ResponseStream.Current.Status.CurrentStep,
        //             PatternStatus = response.ResponseStream.Current.Status.PatternStatus,
        //             RemainHours = response.ResponseStream.Current.Status.RemainHours,
        //             RemainMins = response.ResponseStream.Current.Status.RemainMins,
        //             TempLogList = response.ResponseStream.Current.Status.TempLogList
        //         };

        //         _globals!.GlobalMonitor = Monitor;
        //         Console.WriteLine($"MonitorDevice {MonitorCount} SetParameter : {DateTime.UtcNow.ToTimestamp()}");

        //         Thread.Sleep(TimeSpan.FromSeconds(1));
        //     }
        // }
    }
}