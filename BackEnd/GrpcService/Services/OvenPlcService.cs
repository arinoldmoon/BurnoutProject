using System;
using System.Collections.Generic;
using System.Globalization;
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
        private readonly IOvenDbService _dbService;

        private SerialPort _Port;
        private IModbusMaster _Device;

        private string _PortName = string.Empty;
        private int _BaudRate, Delay3 = 0;

        private Temp TempValue = new Temp();
        private List<Temp> TempList = new List<Temp>();

        public static bool _IsConnected = false;

        public OvenPlcService(ILogger<OvenPlcService> logger, IOptions<PLCConfig> config, IOvenDbService dbService)
        {
            _logger = logger;
            _config = config;
            _dbService = dbService;

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
            ushort[] SensorList = { 100, 120, 160, 140 };

            foreach (var item in SensorList)
            {
                int SensorResult = (await _Device.ReadHoldingRegistersAsync(1, item, 1))[0];
                _logger.LogDebug(SensorResult.ToString());
                switch (item)
                {
                    case 100:
                        TempValue.TempOven = SensorResult;
                        break;
                    case 120:
                        TempValue.TempAFB = SensorResult;
                        break;
                    case 160:
                        TempValue.TempFloor = SensorResult;
                        break;
                    case 140:
                        TempValue.TempTube = SensorResult;
                        break;
                }
            }

            return TempValue;
        }

        public async Task<Coil> GetCoilSensorAsync()
        {
            Coil CoilSensor = new Coil();
            bool[] CoilResult = await _Device.ReadCoilsAsync(1, 70, 5);

            CoilSensor.CoilOven = CoilResult[0];
            CoilSensor.CoilAFB = CoilResult[1];
            CoilSensor.CoilTube = CoilResult[2];
            CoilSensor.CoilPump = CoilResult[3];
            CoilSensor.CoilFloor = CoilResult[4];

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
            Status.PatternStatus = PatternStatus.Standby;

            foreach (ushort item in StatusList)
            {
                if ((await _Device.ReadCoilsAsync(1, item, 1))[0])
                {
                    switch (item)
                    {
                        case 601:
                            Status.PatternStatus = PatternStatus.Down;
                            break;
                        case 602:
                            Status.PatternStatus = PatternStatus.Up;
                            break;
                        case 603:
                            Status.PatternStatus = PatternStatus.Stable;
                            break;
                        case 607:
                            Status.PatternStatus = PatternStatus.End;
                            break;
                    }
                }
            }

            if(WorkerService.TempLog.Any())
            {
                Status.TempLog.AddRange(WorkerService.TempLog);
            }

            return Status;
        }

        public async Task<BoolValue> PushStopOperation()
        {
            // Test
            // WorkerService.statusResponse.Operation = false;
            // WorkerService.statusResponse.PatternId = 0;
            // WorkerService.statusResponse.CurrentStep = 0;
            // WorkerService.statusResponse.TotalStep = 0;
            // WorkerService.statusResponse.PatternStatus = PatternStatus.Standby;  
            // WorkerService.TempLog.Clear();
            // WorkerService.statusResponse.TempLog.Clear();
            // await Task.CompletedTask;
            // return new BoolValue() { Value = true };

            if ((await _Device.ReadCoilsAsync(1, 500, 1))[0])
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

                if (!(await _Device.ReadCoilsAsync(1, 500, 1))[0])
                {
                    _logger.LogInformation("Operation State : Stoped");

                    _logger.LogInformation("OperationWriteLog Stop");
                    WorkerService.TimerState = false;
                    WorkerService.timer.Stop();
                    WorkerService.TempLog.Clear();

                    return new BoolValue() { Value = true };
                }

                return new BoolValue() { Value = false };
            }
            return new BoolValue() { Value = false };
        }

        public async Task<BoolValue> PushStartOperation(ProtoPattern request)
        {
            // Test
            // WorkerService.statusResponse.Operation = true;
            // WorkerService.statusResponse.PatternId = 1;
            // WorkerService.statusResponse.CurrentStep = 1;
            // WorkerService.statusResponse.TotalStep = 7;
            // WorkerService.statusResponse.PatternStatus = PatternStatus.Standby;
            // WorkerService.timer.Start();
            // await Task.CompletedTask;
            // return new BoolValue() { Value = true };

            if (!(await _Device.ReadCoilsAsync(1, 500, 1))[0])
            {
                if (await SendPatternToPLC(request))
                {
                    _logger.LogInformation("SendPatternToPLC State : Success");

                    _Device.WriteSingleCoil((byte)1, 38, true);
                    await Task.Delay(3000);
                    _Device.WriteSingleCoil((byte)1, 38, false);

                    if (_Device.ReadCoils(1, 500, 1)[0])
                    {
                        _logger.LogInformation("Operation State : New Runing");

                        _logger.LogInformation("OperationWriteLog Run");
                        WorkerService.timer.Start();
                        WorkerService.TimerState = true;

                        return new BoolValue() { Value = true };
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
            ProtoPattern response = new ProtoPattern();
            if (WorkerService.statusResponse.PatternId != 99)
            {
                _logger.LogInformation("Get From DB");
                Pattern resultFromDB = await _dbService.GetPattern(WorkerService.statusResponse.PatternId);
                if (resultFromDB != null)
                {
                    response.PatternId = resultFromDB.PatternNumber;
                    response.PatternName = resultFromDB.PatternName;
                    response.StepCount = resultFromDB.StepCount;
                    response.TotalTime = new Duration() { Seconds = resultFromDB.TotalTime };
                    response.AirPump = new ProtoAirpump()
                    {
                        Id = resultFromDB.Airpump.Id,
                        StartTemp = resultFromDB.Airpump.StartTemp,
                        EndTemp = resultFromDB.Airpump.EndTemp,
                        DelayMinuteDuration = TimeSpan.FromMinutes(resultFromDB.Airpump.DelayDuration).ToDuration()
                    };
                    foreach (var item in resultFromDB.PatternItems)
                    {
                        ProtoPatternDetail detail = new ProtoPatternDetail();
                        detail.Step = item.Step;
                        detail.Temp = item.Temp;
                        detail.StepDuration = TimeSpan.FromMinutes(item.StepDuration).ToDuration();
                        detail.DetailId = item.Id;
                        detail.PatternId = resultFromDB.PatternNumber;

                        response.PatternDetail.Add(detail);
                    }
                    response.CreateDate = !String.IsNullOrEmpty(resultFromDB.CreateDate) ? DateTime.ParseExact(resultFromDB.CreateDate, "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture).ToUniversalTime().ToTimestamp() : null;
                    response.ModifyDate = !String.IsNullOrEmpty(resultFromDB.ModifyDate) ? DateTime.ParseExact(resultFromDB.ModifyDate, "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture).ToUniversalTime().ToTimestamp() : null;
                }
            }
            else
            {
                if (_IsConnected)
                {
                    _logger.LogInformation("Get From PLC");
                    ushort addr = 201;
                    List<int> DetailList = new List<int>();
                    response.PatternId = 99;
                    response.StepCount = (await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)200, (ushort)1))[0];

                    if (response.StepCount != 0)
                    {
                        response.AirPump.StartTemp = (await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)553, (ushort)1))[0];
                        response.AirPump.EndTemp = (await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)554, (ushort)1))[0];
                        response.AirPump.DelayMinuteDuration = TimeSpan.FromMinutes((await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)551, (ushort)1))[0]).ToDuration();

                        for (int i = 0; i < response.StepCount * 3; i++)
                        {
                            int item = Convert.ToInt32(_Device.ReadHoldingRegisters((byte)1, addr, 1)[0]);
                            DetailList.Add(item);
                            addr++;
                        }

                        for (int u = 0; u < DetailList.Count;)
                        {
                            response.PatternDetail.Add(new ProtoPatternDetail()
                            {
                                Step = response.PatternDetail.Count + 1,
                                Temp = DetailList[u],
                                StepDuration = TimeSpan.Parse($"{DetailList[u + 1]}:{DetailList[u + 2]}").ToDuration()
                            });

                            u += 3;
                        }
                    }
                    else
                    {
                        Console.WriteLine("result.StepCount == 0");
                    }
                }
                else
                {
                    _logger.LogInformation("PLC Cannot Connect");
                }
            }

            return response;
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