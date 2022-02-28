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

        public static Temp tempResponse = new Temp();
        public static Coil coilResponse = new Coil();
        public static mcStatus statusResponse = new mcStatus();

        public bool IsConnected { get; set; } = false;

        public static List<OperationLog> TempLog = new List<OperationLog>();

        public static System.Timers.Timer timer = new System.Timers.Timer();
        public static bool TimerState { get; set; } = false;

        public WorkerService(ILogger<WorkerService> logger, IOvenPlcService plcService, IOptions<PLCConfig> config)
        {
            _logger = logger;
            _plcService = plcService;
            _config = config;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            IsConnected = await _plcService.ConnectDevice();
            timer.Interval = TimeSpan.FromMinutes(1).TotalMilliseconds;
            timer.Elapsed += new System.Timers.ElapsedEventHandler(OperationWriteLog);

            if (IsConnected)
            {
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
                        //Test
                        // statusResponse.RemainHours = TimeSpan.FromHours(0).ToDuration();
                        // statusResponse.RemainMins = TimeSpan.FromMinutes(0).ToDuration();
                        // await Task.CompletedTask;

                        tempResponse = await _plcService.GetTempSensorAsync();
                        coilResponse = await _plcService.GetCoilSensorAsync();
                        statusResponse = await _plcService.GetMachineStatusAsync();

                        if (statusResponse.Operation && !statusResponse.TempLog.Any() && !TimerState)
                        {
                            _logger.LogInformation("OperationWriteLog Run");
                            WorkerService.timer.Start();
                            WorkerService.TimerState = true;
                        }
                        
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError($"ServiceWorkerMonitorPLC Error : {ex}");
                        break;
                    }
                    Thread.Sleep(TimeSpan.FromMilliseconds(_config.Value.Delay1)); //10 Milisec
                }
            }));

            return Task.CompletedTask;
        }

        private void OperationWriteLog(object sender, System.Timers.ElapsedEventArgs e)
        {
            OperationLog log = new OperationLog();
            if (tempResponse != null)
            {
                log.TempTime = DateTime.UtcNow.ToTimestamp();
                log.TempValue = new Temp()
                {
                    TempOven = tempResponse.TempOven,
                    TempAFB = tempResponse.TempAFB,
                    TempFloor = tempResponse.TempFloor,
                    TempTube = tempResponse.TempTube
                };
            }

            TempLog.Add(log);           
            _logger.LogInformation($"OperationWriteLog : {TempLog.Count()}");                 
        }
    }
}