using Microsoft.AspNetCore.Components;
using UI.Services;
using GrpcService.Protos;
using Grpc.Core;
using Google.Protobuf.WellKnownTypes;
using System.ComponentModel;
using UI.Models;
using Microsoft.JSInterop;

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
        [Inject]
        protected IJSRuntime? jsRuntime { get; set; }

        private BackgroundWorker WorkerMonitor = new BackgroundWorker();

        protected int PercenValue;

        private ProtoOvenResponse Monitor = new ProtoOvenResponse();

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
            _globals.ActualPoint = new List<TempActualLog>();
            _globals.SetPoint = new List<ProtoPatternDetail>();
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                _globals!.isMobile = await jsRuntime!.InvokeAsync<bool>("isDevice");
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
                            Monitor = response.ResponseStream.Current;

                            if (!object.Equals(_globals!.GlobalMonitor.Status.Operation, Monitor.Status.Operation))
                            {
                                if (Monitor.Status.Operation)
                                {
                                    _globals.GlobalPattern.PatternId = Monitor.Status.PatternId;
                                    _globals.GlobalPattern = await _patternService!.GetPatternByID(Monitor.Status.PatternId);
                                }
                                else
                                {
                                    _globals.GlobalPattern.PatternId = 0;
                                    _globals.ActualPoint = new List<TempActualLog>();
                                    _globals.SetPoint = new List<ProtoPatternDetail>();
                                }
                            }

                            if (Monitor.Status.Operation)
                            {
                                if (Monitor.Status.TempLogList.TempLog.Any())
                                {
                                    List<TempActualLog> result = new List<TempActualLog>();
                                    if (!_globals.ActualPoint.Any())
                                    {
                                        foreach (var item in Monitor.Status.TempLogList.TempLog)
                                        {
                                            result.Add(new TempActualLog()
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
                                        Console.WriteLine($"Add ActualPoint Success : {_globals.ActualPoint.Count}");
                                    }
                                    else
                                    {
                                        if (!object.Equals(_globals.ActualPoint.Count, Monitor.Status.TempLogList.TempLog.Count))
                                        {
                                            result.AddRange(_globals.ActualPoint);
                                            result.Add(new TempActualLog()
                                            {
                                                TempTime = Monitor.Status.TempLogList.TempLog.Last().TempTime.ToDateTime().ToLocalTime(),
                                                TempValue = new Temp()
                                                {
                                                    TempOven = Monitor.Status.TempLogList.TempLog.Last().TempValue.TempOven,
                                                    TempAFB = Monitor.Status.TempLogList.TempLog.Last().TempValue.TempAFB,
                                                    TempFloor = Monitor.Status.TempLogList.TempLog.Last().TempValue.TempFloor,
                                                    TempTube = Monitor.Status.TempLogList.TempLog.Last().TempValue.TempTube
                                                }
                                            });
                                            _globals.ActualPoint = result;
                                            Console.WriteLine($"Add ActualPoint Success : {_globals.ActualPoint.Count}");
                                        }
                                    }
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
            catch (Exception ex) when (ex is OperationCanceledException && worker.CancellationPending)
            {
                Console.WriteLine(ex.Message);
            }
        }

    }
}