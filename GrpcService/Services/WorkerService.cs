using System.ComponentModel;
using System.Timers;
using Google.Protobuf.WellKnownTypes;
using GrpcService.Models;
using GrpcService.Models.SQLite;
using GrpcService.Protos;
using Microsoft.Extensions.Options;

namespace GrpcService.Services
{
    public class WorkerService : BackgroundService
    {
        private readonly IOptions<PLCConfig> _plcConfig;
        private readonly SystemConfig _sysConfig;
        private readonly ResponseModel _response;
        private readonly IPlcService _plcService;
        private readonly IDbService _dbService;
        private BackgroundWorker WorkerMonitor = new BackgroundWorker()
        {
            WorkerSupportsCancellation = true
        };

        public static BackgroundWorker WorkerGetActual = new BackgroundWorker()
        {
            WorkerSupportsCancellation = true
        };

        public WorkerService(IOptions<PLCConfig> plcConfig, SystemConfig sysConfig, ResponseModel response, IPlcService plcService, IDbService dbService)
        {
            _plcConfig = plcConfig;
            _sysConfig = sysConfig;
            _plcService = plcService;
            _dbService = dbService;
            _response = response;

            WorkerMonitor.DoWork += WorkerMonitor_DoWork!;
            WorkerMonitor.RunWorkerCompleted += WorkerMonitor_RunWorkerCompleted!;

            WorkerGetActual.DoWork += WorkerGetActual_DoWork!;
            WorkerGetActual.RunWorkerCompleted += WorkerGetActual_RunWorkerCompleted!;

        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            await Task.Run(() =>
            {
                Console.WriteLine("GrpcService Started");
                _response.statusResponse!.TempLogList = new ActualLogList();
                                
                _sysConfig.MachineInfo = _dbService.GetMachineInfo().Result;
                _sysConfig.OperationLogInfo = _dbService.GetOperationLogInfo().Result;

                if (_plcService.ConnectPLCDevice())
                {
                    _sysConfig.LastLogID = (int)(_dbService.GetLastLogID().Result);
                    WorkerMonitor.RunWorkerAsync(stoppingToken);
                }
                else
                {
                    Console.WriteLine("PlcConnected NotConnect");
                    _sysConfig.WriteLogFile($"PlcConnected NotConnect");
                }
            });
        }

        private void WorkerMonitor_DoWork(object sender, DoWorkEventArgs e)
        {
            BackgroundWorker worker = (BackgroundWorker)sender;
            while (!worker.CancellationPending)
            {
                _plcService.GetTempSensor();
                _plcService.GetCoilSensor();
                _plcService.GetMachineStatus();

                if (_response.statusResponse.Operation && !WorkerGetActual!.IsBusy)
                {
                    if (_response.statusResponse.TempLogList.TempLog.Count == 0)
                    {
                        Console.WriteLine($"{DateTime.Now} GetOperationLogByID : {_sysConfig.LastLogID}");
                        List<OperationLog> result = _dbService.GetOperationLogByID(_sysConfig.LastLogID).Result;

                        foreach (var item in result)
                        {
                            _response.statusResponse.TempLogList.TempLog.Add(new ActualLog()
                            {
                                TempTime = DateTime.SpecifyKind(DateTime.ParseExact(item.OperationTime!, SystemConfig.DATE_FORMAT_STRING, null), DateTimeKind.Utc).ToTimestamp(),
                                TempValue = new Temp()
                                {
                                    TempOven = (int)item.ActualTempOven!,
                                    TempAFB = (int)item.ActualTempAfb!
                                }
                            });
                        }
                    }

                    WorkerGetActual.RunWorkerAsync(sender);
                    Console.WriteLine("WorkerGetActual Run");
                }

                Thread.Sleep(_plcConfig.Value.WorkerMonitorDelay);
            }
        }

        private void WorkerGetActual_DoWork(object sender, DoWorkEventArgs e)
        {
            BackgroundWorker worker = (BackgroundWorker)sender;

            while (!worker.CancellationPending)
            {
                ActualLog data = new ActualLog()
                {
                    TempTime = DateTime.UtcNow.ToTimestamp(),
                    TempValue = new Temp()
                    {
                        TempOven = _response.tempResponse.TempOven,
                        TempAFB = _response.tempResponse.TempAFB
                    }
                };
                _response.statusResponse.TempLogList.TempLog.Add(data);
                _dbService.OperationWriteLog(_sysConfig.LastLogID);

                Console.WriteLine($"Temp : {data.TempValue.TempOven} | {data.TempTime.ToDateTime()} | Count {_response.statusResponse.TempLogList.TempLog.Count}");
                Thread.Sleep(_plcConfig.Value.OperationWriteLogDelay);
            }
        }

        private void WorkerMonitor_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                Console.WriteLine(e.Error.Message);
            }
            else if (e.Cancelled)
            {
                Console.WriteLine("Operation was canceled");
            }
            else
            {
                Console.WriteLine("WorkerMonitor Stoped");
            }
        }

        private void WorkerGetActual_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                Console.WriteLine(e.Error.Message);
            }
            else if (e.Cancelled)
            {
                Console.WriteLine("Operation was canceled");
            }
            else
            {
                Console.WriteLine("WorkerGetActual Stoped");
            }
        }
    }
}