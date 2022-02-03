using System;
using System.IO.Ports;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using GrpcService.Models;
using GrpcService.Protos;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Modbus.Device;

namespace GrpcService.Services
{
    public class OvenPlcService : IOvenPlcService
    {
        private readonly ILogger<OvenPlcService> _logger;
        private readonly IOptions<PLCConfig> _config;

        private SerialPort _Port;
        private IModbusMaster _Device;

        private string _PortName = string.Empty;
        private int _BaudRate = 0;

        public static bool _IsConnected = false;

        public OvenPlcService(ILogger<OvenPlcService> logger, IOptions<PLCConfig> config)
        {
            _logger = logger;
            _config = config;        
        }

        public async Task ConnectDevice()
        {
            _PortName = _config.Value.PortName;
            _BaudRate = _config.Value.BaudRate;
            _logger.LogInformation($"USBPort : {_PortName} , BuadRate : {_BaudRate} | Create Connection");

            _Port = new SerialPort(_PortName, _BaudRate, Parity.None, 8, StopBits.One);
            _Device = ModbusSerialMaster.CreateRtu(_Port);

            _Port.Open();
            var OperationState = await _Device.ReadCoilsAsync(1, 500, 1);
            if (OperationState != null)
            {
                _IsConnected = true;
                _logger.LogInformation($"PLC Status : Connected");
            }
            else
            {
                _Device.Dispose();
                _logger.LogInformation($"PLC Status : NotConnect");
            }
        }

        public async Task<Temp> GetTempSensorAsync()
        {
            Temp TempSensor = new Temp();
            ushort[] SensorList = { 100, 120, 160, 140 };

            foreach (var item in SensorList)
            {
                ushort[] SensorResult = await _Device.ReadHoldingRegistersAsync(1, item, 1);
                if (SensorResult.Length > 0)
                {
                    switch (item)
                    {
                        case 100:
                            TempSensor.TempOven = Convert.ToInt32(SensorResult[0]);
                            break;
                        case 120:
                            TempSensor.TempAFB = Convert.ToInt32(SensorResult[0]);
                            break;
                        case 160:
                            TempSensor.TempFloor = Convert.ToInt32(SensorResult[0]);
                            break;
                        case 140:
                            TempSensor.TempTube = Convert.ToInt32(SensorResult[0]);
                            break;
                    }
                }
            }

            return TempSensor;
        }

        public async Task<Coil> GetCoilSensorAsync()
        {
            Coil CoilSensor = new Coil();
            bool[] CoilResult = await _Device.ReadCoilsAsync(1, 70, 5);

            CoilSensor.CoilOven = CoilResult[0];
            CoilSensor.CoilAFB = CoilResult[1];
            CoilSensor.CoilFloor = CoilResult[2];
            CoilSensor.CoilTube = CoilResult[3];
            CoilSensor.CoilPump = CoilResult[4];

            return CoilSensor;
        }

        public async Task<mcStatus> GetMachineStatusAsync()
        {
            mcStatus Status = new mcStatus();

            Status.Operation = Convert.ToBoolean(_Device.ReadCoilsAsync(1, 500, 1).Result[0]);
            Status.Door = Convert.ToBoolean(_Device.ReadCoilsAsync(1, 85, 1).Result[0]);

            ushort[] HeaderList = { 200, 299, 500, 572, 574 };
            foreach (var item in HeaderList)
            {
                int StatusResult = Convert.ToInt32(_Device.ReadHoldingRegistersAsync(1, item, 1).Result[0]);
                switch (item)
                {
                    case 200:
                        Status.TotalStep = Convert.ToInt32(StatusResult);
                        break;
                    case 299:
                        Status.PatternId = Convert.ToInt32(StatusResult);
                        break;
                    case 500:
                        Status.CurrentStep = Convert.ToInt32(StatusResult);
                        break;
                    case 572:
                        Status.RemainMins = TimeSpan.FromMinutes(StatusResult).ToDuration();
                        break;
                    case 574:
                        Status.RemainHours = TimeSpan.FromHours(StatusResult).ToDuration();
                        break;
                }
            }

            ushort[] StatusList = { 601, 602, 603, 607 };
            foreach (var item in StatusList)
            {
                bool Result = Convert.ToBoolean(_Device.ReadCoilsAsync(1, item, 1).Result[0]);
                switch (item)
                {
                    case 601:
                        Status.PatternStatus = (Result) ? PatternStatus.Down : PatternStatus.Standby;
                        break;
                    case 602:
                        Status.PatternStatus = (Result) ? PatternStatus.Up : PatternStatus.Standby;
                        break;
                    case 603:
                        Status.PatternStatus = (Result) ? PatternStatus.Stable : PatternStatus.Standby;
                        break;
                    case 607:
                        Status.PatternStatus = (Result) ? PatternStatus.End : PatternStatus.Standby;
                        break;
                    default:
                        Status.PatternStatus = (Result) ? PatternStatus.Standby : PatternStatus.Standby;
                        break;
                }
            }

            return Status;
        }
    }
}