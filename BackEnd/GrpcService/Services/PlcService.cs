using System.IO.Ports;
using Google.Protobuf.WellKnownTypes;
using GrpcService.Models;
using GrpcService.Models.SQLite;
using GrpcService.Protos;
using Microsoft.Extensions.Options;
using Modbus.Device;

namespace GrpcService.Services
{
    public interface IPlcService
    {
        Task<bool> ConnectPLCDevice();
        Task<bool> CheckConnection();
        Task GetTempSensor();
        Task GetCoilSensor();
        Task GetMachineStatus();

        Task<BoolValue> StartOperation(ProtoPattern request);
        Task<BoolValue> StopOperation();
        Task<BoolValue> SetOvenSetting(ProtoOvenSetting request);

        Task<ProtoPattern> GetCuerrentPattern();
        Task<ProtoOvenSetting> GetOvenSetting();
    }

    public class PlcService : IPlcService
    {

        private readonly IOptions<PLCConfig> _plcConfig;
        private readonly SystemConfig _sysConfig;
        private readonly ResponseModel _response;
        private readonly IDbService _dbService;
        private readonly ModelConvertor _convert;

        private SerialPort serialPort = new SerialPort();
        private IModbusMaster Device = ModbusSerialMaster.CreateRtu(new SerialPort());

        public PlcService(IOptions<PLCConfig> plcConfig, IDbService dbService, SystemConfig sysConfig, ResponseModel response, ModelConvertor convert)
        {
            _plcConfig = plcConfig;
            _sysConfig = sysConfig;
            _response = response;
            _dbService = dbService;
            _convert = convert;
        }

        private async Task<bool> SerialPortInit()
        {
            bool status = false;

            try
            {
                await Task.Run(() =>
                {
                    Console.WriteLine($"SerialPort Create | Portname: {_plcConfig.Value.PortName}, BuadRate : {_plcConfig.Value.BaudRate}");
                    serialPort = new SerialPort()
                    {
                        PortName = _plcConfig.Value.PortName,
                        BaudRate = _plcConfig.Value.BaudRate,
                        Parity = Parity.None,
                        DataBits = 8,
                        StopBits = StopBits.One
                    };
                    serialPort.Open();

                    if (serialPort.IsOpen)
                    {
                        Device = ModbusSerialMaster.CreateRtu(serialPort);
                        status = true;
                    }
                });
            }
            catch (Exception ex)
            {
                _sysConfig.WriteLogFile($"SerialPort Init Error : {ex.Message}");
                Device.Dispose();
                serialPort.Dispose();
                _sysConfig.plcDeviceConnected = false;
            }

            return status;
        }

        public async Task<bool> ConnectPLCDevice()
        {
            bool response = false;
            _sysConfig.plcDeviceConnected = false;

            try
            {
                await Task.Run(() =>
                {
                    Device.Dispose();
                    serialPort.Dispose();

                    if (SerialPortInit().Result)
                    {
                        response = CheckConnection().Result;
                        _sysConfig.plcDeviceConnected = true;
                    }
                });
            }
            catch (Exception ex)
            {
                string message = $"{ex.Message.ToString()}";
                _sysConfig.WriteLogFile(message);

                _sysConfig.plcDeviceConnected = false;
                response = false;
            }

            return response;
        }

        public async Task<bool> CheckConnection()
        {
            bool result = false;

            try
            {
                await Task.Run(() =>
                {
                    if (Device.ReadCoils(1, 500, 1).Any())
                    {
                        result = true;
                    }
                    _sysConfig.plcDeviceConnected = result;

                    Console.WriteLine($"CheckConnection : {result}");
                });
            }
            catch (Exception ex)
            {
                string message = $"{ex.Message.ToString()}";
                _sysConfig.WriteLogFile(message);
                Console.WriteLine(message);
            }

            return result;
        }

        public async Task GetTempSensor()
        {
            try
            {
                await Task.Run(() =>
                {
                    ushort[] SensorList = { 100, 120, 160, 140 };
                    foreach (var item in SensorList)
                    {
                        ushort result = Device.ReadHoldingRegistersAsync((byte)1, (ushort)item, (ushort)1).Result[0];
                        switch (item)
                        {
                            case 100:
                                _response.tempResponse.TempOven = (int)result;
                                break;
                            case 120:
                                _response.tempResponse.TempAFB = (int)result;
                                break;
                            case 160:
                                _response.tempResponse.TempFloor = (int)result;
                                break;
                            case 140:
                                _response.tempResponse.TempTube = (int)result;
                                break;
                        }
                    }
                });
            }
            catch (Exception ex)
            {
                string message = $"GetTempSensor Error : {ex.Message.ToString()}";
                _sysConfig.WriteLogFile(message);
                Console.WriteLine(message);
            }
        }

        public async Task GetCoilSensor()
        {
            try
            {
                await Task.Run(() =>
                {
                    bool[] result = Device.ReadCoilsAsync((byte)1, (ushort)70, (ushort)5).Result;
                    _response.coilResponse.CoilOven = result[0];
                    _response.coilResponse.CoilAFB = result[1];
                    _response.coilResponse.CoilTube = result[2];
                    _response.coilResponse.CoilPump = result[3];
                    _response.coilResponse.CoilFloor = result[4];
                });
            }
            catch (Exception ex)
            {
                string message = $"GetCoilSensor Error : {ex.Message.ToString()}";
                _sysConfig.WriteLogFile(message);
                Console.WriteLine(message);
            }
        }

        public async Task GetMachineStatus()
        {
            try
            {
                await Task.Run(() =>
                {
                    if (_sysConfig.plcDeviceConnected)
                    {
                        _response.statusResponse.Operation = Device.ReadCoilsAsync(1, 500, 1).Result[0];
                        _response.statusResponse.Door = Device.ReadCoilsAsync(1, 85, 1).Result[0];

                        // Read OperationInfo From PLC
                        ushort[] HeaderList = { 200, 299, 500, 572, 574 };
                        foreach (var item in HeaderList)
                        {
                            ushort StatusResult = Device.ReadHoldingRegistersAsync(1, item, 1).Result[0];
                            switch (item)
                            {
                                case 200:
                                    _response.statusResponse.TotalStep = (int)StatusResult;
                                    break;
                                case 299:
                                    _response.statusResponse.PatternId = (int)StatusResult;
                                    break;
                                case 500:
                                    _response.statusResponse.CurrentStep = (int)StatusResult;
                                    break;
                                case 572:
                                    _response.statusResponse.RemainMins = TimeSpan.FromMinutes((int)StatusResult).ToDuration();
                                    break;
                                case 574:
                                    _response.statusResponse.RemainHours = TimeSpan.FromHours((int)StatusResult).ToDuration();
                                    break;
                            }
                        }

                        // Read PatternStatus From PLC
                        ushort[] StatusList = { 601, 602, 603, 607 };
                        foreach (ushort item in StatusList)
                        {
                            if (Device.ReadCoilsAsync(1, item, 1).Result[0])
                            {
                                switch (item)
                                {
                                    case 601:
                                        _response.statusResponse.PatternStatus = PatternStatus.Down;
                                        break;
                                    case 602:
                                        _response.statusResponse.PatternStatus = PatternStatus.Up;
                                        break;
                                    case 603:
                                        _response.statusResponse.PatternStatus = PatternStatus.Stable;
                                        break;
                                    case 607:
                                        _response.statusResponse.PatternStatus = PatternStatus.End;
                                        break;
                                    default:
                                        _response.statusResponse.PatternStatus = PatternStatus.Standby;
                                        break;
                                }
                            }
                        }
                    }
                });
            }
            catch (Exception ex)
            {
                string message = $"GetMachineStatus Error : {ex.Message.ToString()}";
                _sysConfig.WriteLogFile(message);
                Console.WriteLine(message);
            }
        }

        private async Task<bool> SendPatternToPLC(ProtoPattern request)
        {
            bool response = false;

            try
            {
                await Task.Run(() =>
                {
                    Device.WriteSingleRegisterAsync((byte)1, (ushort)299, (ushort)request.PatternId);
                    Device.WriteSingleRegisterAsync((byte)1, (ushort)200, (ushort)request.StepCount);

                    Device.WriteSingleCoilAsync((byte)1, (ushort)550, request.UseAfb);
                    Device.WriteSingleCoilAsync((byte)1, (ushort)552, request.AirPump.UseAirpump);
                    Device.WriteSingleRegisterAsync((byte)1, (ushort)(553), (ushort)request.AirPump.StartTemp);
                    Device.WriteSingleRegisterAsync((byte)1, (ushort)(554), (ushort)request.AirPump.EndTemp);
                    Device.WriteSingleRegisterAsync((byte)1, (ushort)(551), (ushort)request.AirPump.DelayMinuteDuration.Seconds);

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
                            Device.WriteSingleRegisterAsync((byte)1, StartAddr, item);
                            Task.Delay(10);
                            StartAddr++;
                        }
                    }

                    var chk1 = Device.ReadHoldingRegistersAsync(1, 299, 1).Result[0];
                    var chk2 = Device.ReadHoldingRegistersAsync(1, 200, 1).Result[0];
                    var chk3 = Device.ReadHoldingRegistersAsync(1, 554, 1).Result[0];

                    response = (chk1 == request.PatternId && chk2 == request.StepCount && chk3 == request.AirPump.EndTemp) ? true : false;
                });
            }
            catch (Exception ex)
            {
                string message = $"SendPatternToPLC Error : {ex.Message.ToString()}";
                _sysConfig.WriteLogFile(message);
            }

            return response;
        }

        public async Task<BoolValue> StartOperation(ProtoPattern request)
        {
            BoolValue response = new BoolValue() { Value = false };

            try
            {
                await Task.Run(async () =>
                {
                    if (_sysConfig.plcDeviceConnected)
                    {
                        if (_response.statusResponse!.Operation == false)
                        {
                            if (await SendPatternToPLC(request))
                            {
                                if (_dbService.OperationWriteLog(++_sysConfig.LastLogID).Result)
                                {
                                    await Device.WriteSingleCoilAsync((byte)1, 38, true);
                                    await Task.Delay(3000);
                                    await Device.WriteSingleCoilAsync((byte)1, 38, false);

                                    if ((await Device.ReadCoilsAsync(1, 500, 1))[0])
                                    {
                                        response.Value = true;
                                        _sysConfig.WriteLogFile($"StartOperation PatternID : {request.PatternId} | LogID : {_sysConfig.LastLogID}");
                                    }
                                }
                            }
                        }
                        else
                        {
                            Console.WriteLine("Operation State : Stay Runing ");
                        }
                    }
                });
            }
            catch (Exception ex)
            {
                string message = $"StartOperation Error : {ex.Message.ToString()}";
                _sysConfig.WriteLogFile(message);
            }

            return response;

        }

        public async Task<BoolValue> StopOperation()
        {
            BoolValue response = new BoolValue() { Value = false };

            try
            {
                await Task.Run(() =>
                {
                    if (_sysConfig.plcDeviceConnected)
                    {
                        if (_response.statusResponse!.Operation)
                        {
                            Device.WriteSingleCoilAsync((byte)1, 39, true);
                            Task.Delay(3000);
                            Device.WriteSingleCoilAsync((byte)1, 39, false);

                            Device.WriteSingleRegisterAsync((byte)1, 200, (ushort)0);
                            Task.Delay(10);
                            Device.WriteSingleRegisterAsync((byte)1, 299, (ushort)0);
                            Task.Delay(10);
                            Device.WriteSingleRegisterAsync((byte)1, 500, 0);
                            Task.Delay(10);

                            WorkerService.WorkerGetActual!.CancelAsync();
                            Console.WriteLine("StopWorkerGetActual From StopOperation");

                            _response.statusResponse.TempLogList.TempLog.Clear();

                            response.Value = !Device.ReadCoilsAsync(1, 500, 1).Result[0];
                            _sysConfig.WriteLogFile("StopOperation");
                        }
                        else
                        {
                            Console.WriteLine("Operation State : Not Run");
                        }
                    }
                });
            }
            catch (Exception ex)
            {
                string message = $"StopOperation Error : {ex.Message.ToString()}";
                _sysConfig.WriteLogFile(message);
            }

            return response;
        }

        public async Task<BoolValue> SetOvenSetting(ProtoOvenSetting setting)
        {
            BoolValue response = new BoolValue() { Value = false };

            try
            {
                await Task.Run(() =>
                {
                    Device.WriteSingleRegisterAsync(1, 542, (ushort)10);

                    Device.WriteSingleRegisterAsync(1, 545, (ushort)setting.AlarmOven);
                    Device.WriteSingleRegisterAsync(1, 546, (ushort)setting.AlarmAfb);
                    Device.WriteSingleRegisterAsync(1, 547, (ushort)setting.AfbStartTemp);
                    Device.WriteSingleRegisterAsync(1, 548, (ushort)setting.AfbEndTemp);
                    Device.WriteSingleRegisterAsync(1, 549, (ushort)setting.AfbDelay);
                    Device.WriteSingleRegisterAsync(1, 556, (ushort)setting.TubeStartTemp);
                    Device.WriteSingleRegisterAsync(1, 558, (ushort)setting.FloorStartTemp);

                    Device.WriteSingleRegisterAsync(1, 536, (ushort)setting.SetpointTemp.TempAFB);
                    Device.WriteSingleRegisterAsync(1, 537, (ushort)setting.SetpointTemp.TempTube);
                    Device.WriteSingleRegisterAsync(1, 538, (ushort)setting.SetpointTemp.TempFloor);

                    Device.WriteSingleCoilAsync(1, 550, setting.CoilSetting.CoilAFB);
                    Device.WriteSingleCoilAsync(1, 551, setting.CoilSetting.CoilTube);
                    Device.WriteSingleCoilAsync(1, 552, setting.CoilSetting.CoilPump);
                    Device.WriteSingleCoilAsync(1, 553, setting.CoilSetting.CoilFloor);

                    response.Value = true;
                });
            }
            catch (Exception ex)
            {
                string message = $"GetOvenSetting Error : {ex.Message.ToString()}";
                _sysConfig.WriteLogFile(message);
            }


            return response;
        }

        public async Task<ProtoPattern> GetCuerrentPattern()
        {
            ProtoPattern response = new ProtoPattern();

            try
            {
                await Task.Run(() =>
                {
                    if (_response.statusResponse!.Operation)
                    {
                        if (_response.statusResponse.PatternId == 99 && _sysConfig.plcDeviceConnected)
                        {
                            ushort addr = 201;
                            List<int> DetailList = new List<int>();
                            response.PatternId = 99;
                            response.StepCount = Device.ReadHoldingRegistersAsync((byte)1, (ushort)200, (ushort)1).Result[0];

                            if (response.StepCount != 0)
                            {
                                response.AirPump = new ProtoAirpump()
                                {
                                    StartTemp = Device.ReadHoldingRegistersAsync((byte)1, (ushort)553, (ushort)1).Result[0],
                                    EndTemp = Device.ReadHoldingRegistersAsync((byte)1, (ushort)554, (ushort)1).Result[0],
                                    DelayMinuteDuration = TimeSpan.FromSeconds(Device.ReadHoldingRegistersAsync((byte)1, (ushort)551, (ushort)1).Result[0]).ToDuration()
                                };

                                for (int i = 0; i < response.StepCount * 3; i++)
                                {
                                    int item = Convert.ToInt32(Device.ReadHoldingRegisters((byte)1, addr, 1)[0]);
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

                                _sysConfig.WriteLogFile($"GetPattern From PLC TotalStep : {response.StepCount}");
                            }
                        }
                        else
                        {
                            Pattern result = _dbService.GetPattern(new Int32Value() { Value = _response.statusResponse.PatternId }).Result;
                            response = _convert.ConvertPatternModelToProtoPattern(result);
                            _sysConfig.WriteLogFile($"GetPattern From DB TotalStep : {response.StepCount}");
                        }
                    }
                });
            }
            catch (Exception ex)
            {
                string message = $"GetCuerrentPattern Error : {ex.Message.ToString()}";
                _sysConfig.WriteLogFile(message);
            }


            return response;
        }

        public async Task<ProtoOvenSetting> GetOvenSetting()
        {
            ProtoOvenSetting response = new ProtoOvenSetting();

            try
            {
                await Task.Run(() =>
                {
                    if (_sysConfig.plcDeviceConnected)
                    {
                        int[] SettingList1 = new int[] { 536, 537, 538, 545, 546, 547, 548, 549, 556, 558 };
                        List<ushort> value1 = new List<ushort>();
                        foreach (var item in SettingList1)
                        {
                            value1.Add(Device.ReadHoldingRegistersAsync(1, (ushort)item, 1).Result[0]);
                        }

                        response.AfbStartTemp = value1[5];
                        response.AfbEndTemp = value1[6];
                        response.AfbDelay = value1[7];
                        response.TubeStartTemp = value1[8];
                        response.FloorStartTemp = value1[9];
                        response.AlarmOven = value1[3];
                        response.AlarmAfb = value1[4];
                        response.SetpointTemp = new Temp()
                        {
                            TempAFB = value1[0],
                            TempTube = value1[1],
                            TempFloor = value1[2],
                        };

                        bool[] value2 = Device.ReadCoilsAsync(1, 550, 4).Result;
                        response.CoilSetting = new Coil()
                        {
                            CoilAFB = value2[0],
                            CoilPump = value2[2],
                            CoilTube = value2[1],
                            CoilFloor = value2[3]
                        };
                    }
                });
            }
            catch (Exception ex)
            {
                string message = $"GetOvenSetting Error : {ex.Message.ToString()}";
                _sysConfig.WriteLogFile(message);
            }

            return response;
        }

    }
}