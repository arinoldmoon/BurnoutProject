using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using GrpcService.Models;
using GrpcService.Protos;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace GrpcService.Services
{
    public class WorkerService : BackgroundService
    {
        private readonly ILogger<WorkerService> _logger;
        private readonly IOvenPlcService _plcService;
        private readonly IOptions<PLCConfig> _config;
        private readonly IOvenDbService _dbService;
        private readonly FactorConfig _factor;


        public static Temp tempResponse = new Temp();
        public static Coil coilResponse = new Coil();
        public static MachineStatus statusResponse = new MachineStatus();
        public static List<ActualLog> ActualLogList = new List<ActualLog>();

        public bool IsConnected { get; set; } = false;


        public static System.Timers.Timer timer = new System.Timers.Timer();
        public static bool TimerState { get; set; } = false;

        public WorkerService(ILogger<WorkerService> logger, IOvenPlcService plcService, IOvenDbService dbService, IOptions<PLCConfig> config, FactorConfig factor)
        {
            _logger = logger;
            _plcService = plcService;
            _dbService = dbService;
            _config = config;
            _factor = factor;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            IsConnected = await _plcService.ConnectDevice();
            timer.Interval = TimeSpan.FromMinutes(1).TotalMilliseconds;
            timer.Elapsed += new System.Timers.ElapsedEventHandler(OperationWriteLog);

            if (IsConnected)
            {
                _factor.OperationLogID = await _dbService.ChkOperationLogID();                

                _logger.LogInformation($"OperationLogID : { _factor.OperationLogID}");
                await WorkerMonitorPLC(stoppingToken);
            }
        }

        private Task WorkerMonitorPLC(CancellationToken stoppingToken)
        {
            ThreadPool.QueueUserWorkItem(new WaitCallback(async (obj) =>
            {
                _logger.LogInformation("StartWorkerMonitorPLC");
                while (!stoppingToken.IsCancellationRequested)
                {
                    try
                    {
                        tempResponse = await _plcService.GetTempSensorAsync();
                        coilResponse = await _plcService.GetCoilSensorAsync();
                        statusResponse = await _plcService.GetMachineStatusAsync();

                        if (statusResponse.Operation)
                        {
                            if (!ActualLogList.Any())
                            {
                                if (!TimerState)
                                {
                                    Console.WriteLine($"Continue LogID : {_factor.OperationLogID}");

                                    foreach (var item in _dbService.GetOperationLogByID(_factor.OperationLogID).Result)
                                    {
                                        ActualLogList.Add(new ActualLog()
                                        {
                                            TempTime = DateTime.SpecifyKind(DateTime.ParseExact(item.OperationTime, _factor.DATE_FORMAT_STRING, null), DateTimeKind.Utc).ToTimestamp(),
                                            TempValue = new Temp()
                                            {
                                                TempOven = item.ActualTempOven,
                                                TempAFB = item.ActualTempAFB,
                                                TempFloor = item.ActualTempFloor,
                                                TempTube = item.ActualTempTube
                                            }
                                        });
                                    }
                                    timer.Start();
                                    TimerState = true;
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError($"ServiceWorkerMonitorPLC Error : {ex}");
                        break;
                    }
                    Thread.Sleep(TimeSpan.FromMilliseconds(_config.Value.Delay1)); //100 Milisec
                }
            }));

            return Task.CompletedTask;
        }

        private void OperationWriteLog(object sender, System.Timers.ElapsedEventArgs e)
        {
            _dbService.OperationWriteLog(_factor.OperationLogID).GetAwaiter();
        }
    }
}