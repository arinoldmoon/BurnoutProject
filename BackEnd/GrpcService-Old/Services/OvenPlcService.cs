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
        private readonly FactorConfig _factor;

        private SerialPort _Port;
        private IModbusMaster _Device;

        private string _PortName = string.Empty;
        private int _BaudRate, Delay3 = 0;

        private Temp TempValue = new Temp();
        private List<Temp> TempList = new List<Temp>();

        public static bool _IsConnected = false;

        public OvenPlcService(ILogger<OvenPlcService> logger, IOptions<PLCConfig> config, IOvenDbService dbService, FactorConfig factor)
        {
            _logger = logger;
            _config = config;
            _dbService = dbService;
            _factor = factor;

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

                        SetOvenSetting(new ProtoOvenSetting()
                        {
                            AfbStartTemp = 150,
                            AfbEndTemp = 700,
                            AfbDelay = (int)TimeSpan.FromMinutes(60).TotalSeconds,
                            TubeStartTemp = 150,
                            FloorStartTemp = 150,
                            AlarmOven = 800,
                            AlarmAfb = 900,
                            SetpointTemp = new Temp()
                            {                                
                                TempAFB = 850,
                                TempTube = 120,
                                TempFloor = 300
                            },
                            CoilSetting = new Coil()
                            {
                                CoilOven = false,
                                CoilAFB = true,
                                CoilTube = false,
                                CoilPump = true,
                                CoilFloor = false
                            }
                        });

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

        public async Task<MachineStatus> GetMachineStatusAsync()
        {
            MachineStatus Status = new MachineStatus();

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

            if (WorkerService.ActualLogList.Any())
            {
                Status.TempLog.AddRange(WorkerService.ActualLogList);
            }

            return Status;
        }

        public async Task<BoolValue> PushStopOperation()
        {
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
                    WorkerService.ActualLogList.Clear();

                    return new BoolValue() { Value = true };
                }

                return new BoolValue() { Value = false };
            }
            return new BoolValue() { Value = false };
        }

        public async Task<BoolValue> PushStartOperation(ProtoPattern request)
        {
            bool IsSuccess = false;
            if (!(await _Device.ReadCoilsAsync(1, 500, 1))[0])
            {
                if (await SendPatternToPLC(request))
                {
                    _logger.LogInformation("SendPatternToPLC State : Success");

                    if (await _dbService.OperationWriteLog(++_factor.OperationLogID))
                    {
                        _Device.WriteSingleCoil((byte)1, 38, true);
                        await Task.Delay(3000);
                        _Device.WriteSingleCoil((byte)1, 38, false);

                        if (_Device.ReadCoils(1, 500, 1)[0])
                        {
                            IsSuccess = true;
                            WorkerService.timer.Start();
                            WorkerService.TimerState = true;
                            _logger.LogInformation("Operation State : New Runing ");
                        }
                    }

                    return new BoolValue() { Value = IsSuccess };
                }
                _logger.LogInformation("SendPatternToPLC State : Not Success");
                return new BoolValue() { Value = IsSuccess };
            }
            else
            {
                _logger.LogInformation("Operation State : NowRuning");
                return new BoolValue() { Value = IsSuccess };
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
                        response.AirPump = new ProtoAirpump()
                        {
                            StartTemp = (await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)553, (ushort)1))[0],
                            EndTemp = (await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)554, (ushort)1))[0],
                            DelayMinuteDuration = TimeSpan.FromSeconds((await _Device.ReadHoldingRegistersAsync((byte)1, (ushort)551, (ushort)1))[0]).ToDuration()
                        };

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

                        response.TotalTime = TimeSpan.FromSeconds(response.PatternDetail.Sum(x => x.StepDuration.Seconds)).ToDuration();
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
            _Device.WriteSingleRegister((byte)1, (ushort)(551), (ushort)request.AirPump.DelayMinuteDuration.Seconds);

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

        public async Task<ProtoOvenSetting> GetOvenSetting()
        {
            ProtoOvenSetting response = new ProtoOvenSetting();
            response.AfbStartTemp = (await _Device.ReadHoldingRegistersAsync(1, 547, 1))[0];
            response.AfbEndTemp = (await _Device.ReadHoldingRegistersAsync(1, 548, 1))[0];
            response.AfbDelay = (await _Device.ReadHoldingRegistersAsync(1, 549, 1))[0];
            response.TubeStartTemp = (await _Device.ReadHoldingRegistersAsync(1, 556, 1))[0];
            response.FloorStartTemp = (await _Device.ReadHoldingRegistersAsync(1, 558, 1))[0];
            response.AlarmOven = (await _Device.ReadHoldingRegistersAsync(1, 545, 1))[0];
            response.AlarmAfb = (await _Device.ReadHoldingRegistersAsync(1, 546, 1))[0];
            response.SetpointTemp = new Temp()
            {                
                TempAFB = (await _Device.ReadHoldingRegistersAsync(1, 536, 1))[0],
                TempTube = (await _Device.ReadHoldingRegistersAsync(1, 537, 1))[0],
                TempFloor = (await _Device.ReadHoldingRegistersAsync(1, 538, 1))[0],
            };
            response.CoilSetting = new Coil()
            {
                CoilAFB = (await _Device.ReadCoilsAsync(1, 550, 1))[0],
                CoilPump = (await _Device.ReadCoilsAsync(1, 552, 1))[0],
                CoilTube = (await _Device.ReadCoilsAsync(1, 551, 1))[0],
                CoilFloor = (await _Device.ReadCoilsAsync(1, 553, 1))[0]
            };

            return response;
        }

        public async Task<BoolValue> SetOvenSetting(ProtoOvenSetting setting)
        {
            BoolValue response = new BoolValue() { Value = false };

            // Init D542 value = 10;
            // _Device.WriteSingleRegister((byte)1, (ushort)542, (ushort)10);

            await Task.Run(async () =>
            {
                await _Device.WriteSingleRegisterAsync(1, 545, (ushort)setting.AlarmOven);
                await _Device.WriteSingleRegisterAsync(1, 546, (ushort)setting.AlarmAfb);
                await _Device.WriteSingleRegisterAsync(1, 547, (ushort)setting.AfbStartTemp);
                await _Device.WriteSingleRegisterAsync(1, 548, (ushort)setting.AfbEndTemp);
                await _Device.WriteSingleRegisterAsync(1, 549, (ushort)setting.AfbDelay);
                await _Device.WriteSingleRegisterAsync(1, 556, (ushort)setting.TubeStartTemp);
                await _Device.WriteSingleRegisterAsync(1, 558, (ushort)setting.FloorStartTemp);

                await _Device.WriteSingleRegisterAsync(1, 536, (ushort)setting.SetpointTemp.TempAFB);
                await _Device.WriteSingleRegisterAsync(1, 537, (ushort)setting.SetpointTemp.TempTube);
                await _Device.WriteSingleRegisterAsync(1, 538, (ushort)setting.SetpointTemp.TempFloor);

                await _Device.WriteSingleCoilAsync(1, 550, setting.CoilSetting.CoilAFB);
                await _Device.WriteSingleCoilAsync(1, 551, setting.CoilSetting.CoilTube);
                await _Device.WriteSingleCoilAsync(1, 552, setting.CoilSetting.CoilPump);
                await _Device.WriteSingleCoilAsync(1, 553, setting.CoilSetting.CoilFloor);
            }).ContinueWith(status =>
           {
               response.Value = status.IsCompletedSuccessfully;
           });

            await Task.CompletedTask;
            return response;
        }
    }
}