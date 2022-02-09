using System;
using System.Collections.Generic;
using System.IO.Ports;
using System.Linq;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using GrpcService.Models;
using GrpcService.Protos;
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
        private int _BaudRate, Delay3 = 0;

        public static bool _IsConnected = false;

        public OvenPlcService(ILogger<OvenPlcService> logger, IOptions<PLCConfig> config)
        {
            _logger = logger;
            _config = config;

            Delay3 = _config.Value.Delay3;
        }

        public async Task<bool> ConnectDevice()
        {
            _PortName = _config.Value.PortName;
            _BaudRate = _config.Value.BaudRate;
            _logger.LogInformation($"USBPort : {_PortName} , BuadRate : {_BaudRate} | Create Connection");

            _Port = new SerialPort(_PortName, _BaudRate, Parity.None, 8, StopBits.One);
            _Device = ModbusSerialMaster.CreateRtu(_Port);

            try
            {
                _Port.Open();
                if (_Port.IsOpen)
                {
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
            }
            catch (Exception ex)
            {
                _logger.LogError($"{ex.Message.ToString()}");
            }

            return _IsConnected;
        }

        public async Task<Temp> GetTempSensorAsync()
        {
            Temp TempSensor = new Temp();
            ushort[] SensorList = { 100, 120, 160, 140 };

            foreach (var item in SensorList)
            {
                int SensorResult = (await _Device.ReadHoldingRegistersAsync(1, item, 1))[0];
                _logger.LogDebug(SensorResult.ToString());
                switch (item)
                {
                    case 100:
                        TempSensor.TempOven = SensorResult;
                        break;
                    case 120:
                        TempSensor.TempAFB = SensorResult;
                        break;
                    case 160:
                        TempSensor.TempFloor = SensorResult;
                        break;
                    case 140:
                        TempSensor.TempTube = SensorResult;
                        break;
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

            Status.Operation = (await _Device.ReadCoilsAsync(1, 500, 1))[0];
            Status.Door = (await _Device.ReadCoilsAsync(1, 85, 1))[0];

            ushort[] HeaderList = { 200, 299, 500, 572, 574 };
            foreach (var item in HeaderList)
            {
                int StatusResult = (await _Device.ReadHoldingRegistersAsync(1, item, 1))[0];
                switch (item)
                {
                    case 200:
                        Status.TotalStep = StatusResult;
                        break;
                    case 299:
                        Status.PatternId = StatusResult;
                        break;
                    case 500:
                        Status.CurrentStep = StatusResult;
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
                bool Result = (await _Device.ReadCoilsAsync(1, item, 1))[0];
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

        public async Task<BoolValue> PushStopOperation()
        {
            bool OperationRun = (await _Device.ReadCoilsAsync(1, 500, 1))[0];

            if (OperationRun)
            {
                await _Device.WriteSingleCoilAsync((byte)1, 39, true);
                await Task.Delay(3000);
                await _Device.WriteSingleCoilAsync((byte)1, 39, false);

                _Device.WriteSingleRegister((byte)1, 200, (ushort)0);
                await Task.Delay(Delay3);
                _Device.WriteSingleRegister((byte)1, 299, (ushort)0);
                await Task.Delay(Delay3);
                _Device.WriteSingleRegister((byte)1, 500, 0);
                await Task.Delay(Delay3);

                OperationRun = (await _Device.ReadCoilsAsync(1, 500, 1))[0];
                await Task.CompletedTask;

                if (!OperationRun)
                {
                    _logger.LogInformation("Operation State : Stoped");
                    return new BoolValue() { Value = true };
                }
                else
                {
                    return new BoolValue() { Value = false };
                }

            }

            return new BoolValue() { Value = true };
        }

        public async Task<BoolValue> PushStartOperation(ProtoPattern request)
        {
            bool OperationRun = (await _Device.ReadCoilsAsync(1, 500, 1))[0];

            if (!OperationRun)
            {
                bool ready = await SendPatternToPLC(request);
                if (ready)
                {
                    _logger.LogInformation("SendPatternToPLC State : Success");

                    _Device.WriteSingleCoil((byte)1, 38, true);
                    await Task.Delay(3000);
                    _Device.WriteSingleCoil((byte)1, 38, false);

                    OperationRun = _Device.ReadCoils(1, 500, 1)[0];
                    if (OperationRun)
                    {
                        _logger.LogInformation("Operation State : New Runing");
                        return new BoolValue() { Value = OperationRun };
                    }

                    return new BoolValue() { Value = false };
                }
                _logger.LogInformation("SendPatternToPLC State : Not Success");
                return new BoolValue() { Value = false };
            }
            else
            {
                _logger.LogInformation("Operation State : NowRuning");
                return new BoolValue() { Value = false };
            }
        }

        public async Task<ProtoPattern> GetCuerrentPattern()
        {
            ProtoPattern result = new ProtoPattern();
            result.AirPump = new ProtoAirpump();

            if (_IsConnected)
            {
                result.PatternId = (int)(await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)299, (ushort)1))[0];

                if (result.PatternId != 0)
                {
                    ushort addr = 201;
                    List<int> DetailList = new List<int>();

                    result.StepCount = (await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)200, (ushort)1))[0];

                    result.AirPump.StartTemp = (await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)553, (ushort)1))[0];
                    result.AirPump.EndTemp = (await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)554, (ushort)1))[0];
                    result.AirPump.DelayMinuteDuration = TimeSpan.FromMinutes((await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)551, (ushort)1))[0]).ToDuration();

                    for (int i = 0; i < result.StepCount * 3; i++)
                    {
                        int item = Convert.ToInt32(_Device.ReadHoldingRegisters((byte)1, addr, 1)[0]);
                        DetailList.Add(item);
                        addr++;
                    }

                    for (int u = 0; u < DetailList.Count;)
                    {
                        result.PatternDetail.Add(new ProtoPatternDetail()
                        {
                            PatternId = result.PatternId,
                            Step = result.PatternDetail.Count + 1,
                            Temp = DetailList[u],
                            StepDuration = TimeSpan.Parse($"{DetailList[u + 1]}:{DetailList[u + 2]}").ToDuration()
                        });

                        u += 3;
                    }
                }

            }

            return result;
        }

        private async Task<bool> SendPatternToPLC(ProtoPattern request)
        {
            _Device.WriteSingleRegister((byte)1, (ushort)299, (ushort)request.PatternId);
            _Device.WriteSingleRegister((byte)1, (ushort)200, (ushort)request.StepCount);

            _Device.WriteSingleRegister((byte)1, (ushort)(553), (ushort)request.AirPump.StartTemp);
            _Device.WriteSingleRegister((byte)1, (ushort)(554), (ushort)request.AirPump.EndTemp);
            _Device.WriteSingleRegister((byte)1, (ushort)(551), (ushort)TimeSpan.FromSeconds(request.AirPump.DelayMinuteDuration.Seconds).TotalMinutes);

            List<ushort> result = new List<ushort>();
            if (request.StepCount > 0)
            {
                foreach (var item in request.PatternDetail)
                {
                    var time = TimeSpan.FromSeconds(item.StepDuration.Seconds);
                    result.Add((ushort)item.Temp);
                    result.Add((ushort)time.Hours);
                    result.Add((ushort)time.Minutes);
                }

                ushort StartAddr = 201;
                foreach (var item in result)
                {
                    _Device.WriteSingleRegister((byte)1, StartAddr, item);
                    await Task.Delay(Delay3);
                    StartAddr++;
                }
            }

            var chk1 = _Device.ReadHoldingRegisters(1, 299, 1)[0];
            var chk2 = _Device.ReadHoldingRegisters(1, 200, 1)[0];
            var chk3 = _Device.ReadHoldingRegisters(1, 554, 1)[0];

            await Task.CompletedTask;

            return (chk1 == request.PatternId && chk2 == request.StepCount && chk3 == request.AirPump.EndTemp) ? true : false;
        }
    }
}