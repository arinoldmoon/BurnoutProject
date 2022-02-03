using System;
using System.IO.Ports;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using GrpcService.Protos;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Modbus.Device;

namespace GrpcService.Services
{
    public class OvenPlcService : IOvenPlcService
    {
        private readonly ILogger<OvenPlcService> _logger;

        private SerialPort _Port;
        private IModbusMaster _Device;

        private string _PortName = string.Empty;
        private int _BaudRate = 0;

        private bool _IsConnected = false;

        public OvenPlcService(ILogger<OvenPlcService> logger, IConfiguration Config)
        {
            _logger = logger;
            _PortName = Config.GetSection("PLCConfig").GetSection("PortName").Value;
            _BaudRate = Convert.ToInt16(Config.GetSection("PLCConfig").GetSection("BaudRate").Value);
        }

        public async Task ConnectDevice()
        {
            _Port = new SerialPort(_PortName, _BaudRate, Parity.None, 8, StopBits.One);
            _Device = ModbusSerialMaster.CreateRtu(_Port);
            _logger.LogInformation($"USBPort : {_PortName} | Create Connected");

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

        public async Task<Coil> GetCoilSensor()
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

        public async Task<mcStatus> GetMachineStatus()
        {
            mcStatus Status = new mcStatus();

            Status.Operation = Convert.ToBoolean(await _Device.ReadCoilsAsync(1, 500, 1));
            Status.Door = Convert.ToBoolean(await _Device.ReadCoilsAsync(1, 85, 1));

            ushort[] HeaderList = { 200, 299, 500, 572, 574 };
            foreach (var item in HeaderList)
            {
                int StatusResult = Convert.ToInt32(await _Device.ReadHoldingRegistersAsync(1, item, 1));
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
                bool Result = Convert.ToBoolean(await _Device.ReadCoilsAsync(1, item, 1));
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