using System;
using System.Threading;
using System.Threading.Tasks;
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

        public WorkerService(ILogger<WorkerService> logger, IOvenPlcService plcService, IOptions<PLCConfig> config)
        {
            _logger = logger;
            _plcService = plcService;
            _config = config;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            await _plcService.ConnectDevice();
            await WorkerMonitorPLC(stoppingToken);
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
    }
}