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

                if (!WorkerMonitor.IsBusy && _globals!.ServiceConnected)
                {
                    WorkerMonitor.RunWorkerAsync();
                }
            }
        }

        private void WorkerMonitor_DoWork(object sender, DoWorkEventArgs e)
        {
            BackgroundWorker worker = (BackgroundWorker)sender;
            Console.WriteLine("MonitorDevice Start");
            try
            {
                ThreadPool.QueueUserWorkItem(new WaitCallback(async (res) =>
                {
                    using (var response = await _ovenService!.MonitorDevice())
                    {
                        while (await response.ResponseStream.MoveNext(CancellationToken.None) && !worker.CancellationPending)
                        {
                            ProtoOvenResponse Monitor = new ProtoOvenResponse()
                            {
                                Temp = new Temp()
                                {
                                    TempOven = response.ResponseStream.Current.Temp.TempOven,
                                    TempAFB = response.ResponseStream.Current.Temp.TempAFB,
                                    TempFloor = response.ResponseStream.Current.Temp.TempFloor,
                                    TempTube = response.ResponseStream.Current.Temp.TempTube
                                },
                                Coil = new Coil()
                                {
                                    CoilOven = response.ResponseStream.Current.Coil.CoilOven,
                                    CoilAFB = response.ResponseStream.Current.Coil.CoilAFB,
                                    CoilFloor = response.ResponseStream.Current.Coil.CoilFloor,
                                    CoilTube = response.ResponseStream.Current.Coil.CoilTube,
                                    CoilPump = response.ResponseStream.Current.Coil.CoilPump
                                },
                                Status = new MachineStatus()
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
                                }
                            };

                            if (!object.Equals(_globals!.GlobalMonitor.Status.Operation, Monitor.Status.Operation))
                            {
                                if (Monitor.Status.Operation)
                                {
                                    _globals.GlobalPattern.PatternId = Monitor.Status.PatternId;
                                    _globals.GlobalPattern = await _patternService!.GetPatternByID(Monitor.Status.PatternId);
                                }
                            }

                            if (Monitor.Status.Operation)
                            {
                                if (Monitor.Status.TempLogList.TempLog.Any() && !_globals.ActualPoint.Any() || !object.Equals(_globals.ActualPoint.Count, Monitor.Status.TempLogList.TempLog.Count))
                                {
                                    Console.WriteLine("Generate ActualPoint");
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

                                if (Monitor.Status.TotalStep > 0)
                                {
                                    PercenValue = (Monitor.Status.CurrentStep / Monitor.Status.TotalStep) * 100;
                                }
                            }

                            _globals.GlobalMonitor = Monitor;
                            Reload();
                        }
                    }
                }));
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

    }
}