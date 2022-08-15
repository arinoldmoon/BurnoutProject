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
        bool ConnectPLCDevice();
        bool CheckConnection();
        Task GetTempSensor();
        Task GetCoilSensor();
        Task GetMachineStatus();

        Task<BoolValue> StartOperation(ProtoPattern request);
        Task<BoolValue> StopOperation();
        Task<BoolValue> SetOvenSetting(ProtoOvenSetting request);
        Task<BoolValue> SetManualTemp(ProtoManualTemp request);

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

        private const byte _slaveId = 1;
        private const ushort _numOfPoint = 1;

        public PlcService(IOptions<PLCConfig> plcConfig, IDbService dbService, SystemConfig sysConfig, ResponseModel response, ModelConvertor convert)
        {
            _plcConfig = plcConfig;
            _sysConfig = sysConfig;
            _response = response;
            _dbService = dbService;
            _convert = convert;
        }

        private bool SerialPortInit()
        {
            bool status = false;

            try
            {
                Console.WriteLine($"SerialPort Create | Portname: {_plcConfig.Value.PortName}, BuadRate : {_plcConfig.Value.BaudRate}");
                serialPort = new SerialPort()
                {
                    PortName = _plcConfig.Value.PortName,
                    BaudRate = _plcConfig.Value.BaudRate,
                    Parity = Parity.None,
                    DataBits = 8,
                    StopBits = StopBits.One,
                    ReadTimeout = 200,
                    WriteTimeout = 200
                };
                serialPort.Open();

                if (serialPort.IsOpen)
                {
                    Device = ModbusSerialMaster.CreateRtu(serialPort);
                    status = true;
                }
            }
            catch (Exception ex)
            {
                Device.Dispose();
                serialPort.Dispose();
                _sysConfig.WriteLogFile($"SerialPort Init Error : {ex.Message}");
                _sysConfig.plcDeviceConnected = false;
            }

            return status;
        }

        private async Task<bool> SendPatternToPLC(ProtoPattern request)
        {
            bool response = false;

            await Task.Run(() =>
            {
                try
                {
                    Device.WriteSingleRegister(_slaveId, registerAddress: 299, value: (ushort)request.PatternId);
                    Task.Delay(10);
                    Device.WriteSingleRegister(_slaveId, registerAddress: 200, value: (ushort)request.StepCount);
                    Task.Delay(10);

                    Device.WriteSingleCoil(_slaveId, coilAddress: 550, value: request.UseAfb);
                    Task.Delay(10);
                    Device.WriteSingleCoil(_slaveId, coilAddress: 552, value: request.AirPump.UseAirpump);
                    Task.Delay(10);
                    Device.WriteSingleRegister(_slaveId, registerAddress: (553), value: (ushort)request.AirPump.StartTemp);
                    Task.Delay(10);
                    Device.WriteSingleRegister(_slaveId, registerAddress: (554), value: (ushort)request.AirPump.EndTemp);
                    Task.Delay(10);
                    Device.WriteSingleRegister(_slaveId, registerAddress: (551), value: (ushort)request.AirPump.DelayMinuteDuration.Seconds);
                    Task.Delay(10);

                    List<ushort> result = new List<ushort>();
                    if (request.StepCount > 0)
                    {
                        foreach (var item in request.PatternDetail.OrderBy(x => x.Step))
                        {
                            double totalMinutes = TimeSpan.FromSeconds(item.StepDuration.Seconds).TotalMinutes;
                            int hh = (int)(totalMinutes / 60);
                            int mm = (int)((totalMinutes / 60) % 1 * 60);

                            result.Add((ushort)item.Temp);
                            result.Add((ushort)hh);
                            result.Add((ushort)mm);
                            Task.Delay(10);
                        }

                        ushort StartAddr = 201;
                        foreach (ushort value in result)
                        {
                            Device.WriteSingleRegister(_slaveId, StartAddr, value);
                            StartAddr++;
                            Task.Delay(10);
                        }
                    }

                    var chk1 = Device.ReadHoldingRegisters(_slaveId, startAddress: 299, _numOfPoint)[0];
                    var chk2 = Device.ReadHoldingRegisters(_slaveId, startAddress: 200, _numOfPoint)[0];
                    var chk3 = Device.ReadHoldingRegisters(_slaveId, startAddress: 554, _numOfPoint)[0];

                    response = (chk1 == request.PatternId && chk2 == request.StepCount && chk3 == request.AirPump.EndTemp) ? true : false;
                }
                catch (Exception ex)
                {
                    string message = $"SendPatternToPLC Error : {ex.Message}";
                    _sysConfig.WriteLogFile(message);
                }
            });


            return response;
        }

        public bool ConnectPLCDevice()
        {
            bool response = false;
            _sysConfig.plcDeviceConnected = false;

            try
            {
                if (SerialPortInit())
                {
                    response = CheckConnection();
                }
                else
                {
                    Console.WriteLine("SerialPortInit Failed");
                }
            }
            catch (Exception ex)
            {
                string message = $"ConnectPLCDevice Error : {ex.Message}";
                _sysConfig.WriteLogFile(message);

                _sysConfig.plcDeviceConnected = false;
                response = false;
            }

            return response;
        }

        public bool CheckConnection()
        {
            bool result = false;

            try
            {
                if (Device.ReadCoils(_slaveId, startAddress: 500, _numOfPoint).Any())
                {
                    result = true;
                }
                _sysConfig.plcDeviceConnected = result;
                Console.WriteLine($"CheckConnection : {result}");
            }
            catch (Exception ex)
            {
                string message = $"{ex.Message}";
                _sysConfig.WriteLogFile(message);
                Console.WriteLine(message);
            }

            return result;
        }

        public async Task GetTempSensor()
        {
            await Task.Run(() =>
            {
                try
                {
                    ushort[] AddressTempSensorList = { 100, 120, 160, 140 };
                    _response.tempResponse.TempOven = Device.ReadHoldingRegisters(_slaveId, startAddress: AddressTempSensorList[0], _numOfPoint)[0];
                    _response.tempResponse.TempAFB = Device.ReadHoldingRegisters(_slaveId, startAddress: AddressTempSensorList[1], _numOfPoint)[0];
                    _response.tempResponse.TempFloor = Device.ReadHoldingRegisters(_slaveId, startAddress: AddressTempSensorList[2], _numOfPoint)[0];
                    _response.tempResponse.TempTube = Device.ReadHoldingRegisters(_slaveId, startAddress: AddressTempSensorList[3], _numOfPoint)[0];
                }
                catch (Exception ex)
                {
                    string message = $"GetTempSensor Error : {ex.Message}";
                    _sysConfig.WriteLogFile(message);
                    Console.WriteLine(message);
                }
            });
        }

        public async Task GetCoilSensor()
        {
            await Task.Run(() =>
            {
                try
                {
                    bool[] result = Device.ReadCoils(_slaveId, startAddress: 70, numberOfPoints: 5);
                    _response.coilResponse.CoilOven = result[0];
                    _response.coilResponse.CoilAFB = result[1];
                    _response.coilResponse.CoilTube = result[2];
                    _response.coilResponse.CoilPump = result[3];
                    _response.coilResponse.CoilFloor = result[4];

                }
                catch (Exception ex)
                {
                    string message = $"GetCoilSensor Error : {ex.Message}";
                    _sysConfig.WriteLogFile(message);
                    Console.WriteLine(message);
                }
            });
        }

        public async Task GetMachineStatus()
        {
            await Task.Run(() =>
            {
                try
                {
                    if (_sysConfig.plcDeviceConnected)
                    {
                        _response.statusResponse.Operation = Device.ReadCoils(_slaveId, startAddress: 500, _numOfPoint)[0];
                        Task.Delay(10);
                        _response.statusResponse.Door = Device.ReadCoils(_slaveId, startAddress: 85, _numOfPoint)[0];

                        // Read OperationInfo From PLC
                        ushort[] AddrHeaderList = { 200, 299, 500, 572, 574 };
                        _response.statusResponse.TotalStep = Device.ReadHoldingRegisters(_slaveId, startAddress: AddrHeaderList[0], _numOfPoint)[0];
                        _response.statusResponse.PatternId = Device.ReadHoldingRegisters(_slaveId, startAddress: AddrHeaderList[1], _numOfPoint)[0];
                        _response.statusResponse.CurrentStep = Device.ReadHoldingRegisters(_slaveId, startAddress: AddrHeaderList[2], _numOfPoint)[0];
                        _response.statusResponse.RemainMins = TimeSpan.FromMinutes(Device.ReadHoldingRegisters(_slaveId, startAddress: AddrHeaderList[3], _numOfPoint)[0]).ToDuration();
                        _response.statusResponse.RemainHours = TimeSpan.FromHours(Device.ReadHoldingRegisters(_slaveId, startAddress: AddrHeaderList[4], _numOfPoint)[0]).ToDuration();

                        // Read PatternStatus From PLC                       
                        List<ushort> AddrStatusList = new List<ushort>() { 601, 602, 603, 607 };

                        foreach (var (addr, index) in AddrStatusList.Select((value, i) => (value, i + 1)))
                        {

                            if (Device.ReadCoils(_slaveId, startAddress: addr, _numOfPoint)[0])
                            {
                                _response.statusResponse.PatternStatus = (PatternStatus)index;
                            }

                            Task.Delay(10);
                        }
                    }
                }
                catch (Exception ex)
                {
                    string message = $"GetMachineStatus Error : {ex.Message}";
                    _sysConfig.WriteLogFile(message);
                    Console.WriteLine(message);
                }
            });
        }

        public async Task<BoolValue> StartOperation(ProtoPattern request)
        {
            BoolValue response = new BoolValue() { Value = false };

            await Task.Run(async () =>
            {
                try
                {
                    if (_sysConfig.plcDeviceConnected)
                    {
                        if (_response.statusResponse!.Operation == false)
                        {
                            if (SendPatternToPLC(request).Result)
                            {
                                _response.statusResponse.PatternId = request.PatternId;
                                if (_dbService.OperationWriteLog(++_sysConfig.LastLogID))
                                {
                                    Device.WriteSingleCoil(_slaveId, coilAddress: 38, value: true);
                                    await Task.Delay(3000);
                                    Device.WriteSingleCoil(_slaveId, coilAddress: 38, value: false);

                                    if (Device.ReadCoils(_slaveId, startAddress: 500, _numOfPoint)[0])
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
                }
                catch (Exception ex)
                {
                    string message = $"StartOperation Error : {ex.Message}";
                    _sysConfig.WriteLogFile(message);
                }
            });
            return response;
        }

        public async Task<BoolValue> StopOperation()
        {
            BoolValue response = new BoolValue() { Value = false };

            await Task.Run(async () =>
            {
                try
                {
                    if (_sysConfig.plcDeviceConnected)
                    {
                        if (_response.statusResponse!.Operation)
                        {
                            Device.WriteSingleCoil(_slaveId, coilAddress: 39, value: true);
                            await Task.Delay(3000);
                            Device.WriteSingleCoil(_slaveId, coilAddress: 39, value: false);

                            Device.WriteSingleRegister(_slaveId, registerAddress: 200, value: 0);
                            await Task.Delay(10);
                            Device.WriteSingleRegister(_slaveId, registerAddress: 299, value: 0);
                            await Task.Delay(10);
                            Device.WriteSingleRegister(_slaveId, registerAddress: 500, value: 0);
                            await Task.Delay(10);

                            WorkerService.WorkerGetActual!.CancelAsync();
                            Console.WriteLine("StopWorkerGetActual From StopOperation");

                            _response.statusResponse.TempLogList.TempLog.Clear();

                            response.Value = !Device.ReadCoils(_slaveId, startAddress: 500, _numOfPoint)[0];
                            Console.WriteLine($"response : {response.Value}");

                            _sysConfig.WriteLogFile("StopOperation");
                            _sysConfig.OperationLogInfo = _dbService.GetOperationLogInfo().Result;
                        }
                        else
                        {
                            Console.WriteLine("Operation State : Not Run");
                        }
                    }

                }
                catch (Exception ex)
                {
                    string message = $"StopOperation Error : {ex.Message}";
                    _sysConfig.WriteLogFile(message);
                }
            });
            return response;
        }

        public async Task<BoolValue> SetOvenSetting(ProtoOvenSetting setting)
        {
            BoolValue response = new BoolValue() { Value = false };

            await Task.Run(async () =>
            {
                try
                {
                    if (_sysConfig.plcDeviceConnected)
                    {
                        await Device.WriteSingleRegisterAsync(_slaveId, registerAddress: 542, value: 10);

                        ushort[] SetSystemValueList = new ushort[] { (ushort)setting.AlarmOven, (ushort)setting.AlarmAfb, (ushort)setting.AfbStartTemp, (ushort)setting.AfbEndTemp, (ushort)setting.AfbDelay };
                        await Device.WriteMultipleRegistersAsync(_slaveId, startAddress: 545, data: SetSystemValueList);
                        await Device.WriteSingleRegisterAsync(_slaveId, registerAddress: 558, value: (ushort)setting.FloorStartTemp);
                        await Device.WriteSingleRegisterAsync(_slaveId, registerAddress: 556, value: (ushort)setting.TubeStartTemp);


                        ushort[] SetTempValueList = new ushort[] { (ushort)setting.SetpointTemp.TempAFB, (ushort)setting.SetpointTemp.TempTube, (ushort)setting.SetpointTemp.TempFloor };
                        await Device.WriteMultipleRegistersAsync(_slaveId, startAddress: 536, data: SetTempValueList);


                        bool[] SetCoilValueList = new bool[] { setting.CoilSetting.CoilAFB, setting.CoilSetting.CoilTube, setting.CoilSetting.CoilPump, setting.CoilSetting.CoilFloor };
                        await Device.WriteMultipleCoilsAsync(_slaveId, startAddress: 550, data: SetCoilValueList);

                        response.Value = true;
                    }
                }
                catch (Exception ex)
                {
                    string message = $"GetOvenSetting Error : {ex.Message}";
                    _sysConfig.WriteLogFile(message);
                }
            });

            return response;
        }

        public async Task<BoolValue> SetManualTemp(ProtoManualTemp request)
        {
            BoolValue response = new BoolValue() { Value = false };

            await Task.Run(async () =>
            {
                try
                {
                    if (_sysConfig.plcDeviceConnected)
                    {
                        await Device.WriteSingleRegisterAsync(_slaveId, registerAddress: 560, value: (ushort)request.Temp);
                        await Task.Delay(10);
                        await Device.WriteSingleCoilAsync(_slaveId, coilAddress: 606, value: request.Use);

                        response.Value = true;
                    }
                }
                catch (Exception ex)
                {
                    string message = $"SetManualTemp Error : {ex.Message}";
                    _sysConfig.WriteLogFile(message);
                }
            });

            return response;
        }

        public async Task<ProtoPattern> GetCuerrentPattern()
        {
            ProtoPattern response = new ProtoPattern();

            await Task.Run(async () =>
            {
                try
                {
                    if (_response.statusResponse!.Operation)
                    {
                        if (_response.statusResponse.PatternId == 99 && _sysConfig.plcDeviceConnected)
                        {
                            ushort addr = 201;
                            List<int> DetailList = new List<int>();
                            response.PatternId = 99;
                            response.StepCount = (await Device.ReadHoldingRegistersAsync(_slaveId, startAddress: 200, _numOfPoint))[0];

                            if (response.StepCount != 0)
                            {
                                response.AirPump = new ProtoAirpump()
                                {
                                    StartTemp = (await Device.ReadHoldingRegistersAsync(_slaveId, startAddress: 553, _numOfPoint))[0],
                                    EndTemp = (await Device.ReadHoldingRegistersAsync(_slaveId, startAddress: 554, _numOfPoint))[0],
                                    DelayMinuteDuration = TimeSpan.FromSeconds(Device.ReadHoldingRegisters(_slaveId, startAddress: 551, _numOfPoint)[0]).ToDuration()
                                };

                                for (int i = 0; i < response.StepCount * 3; i++)
                                {
                                    int item = Convert.ToInt32((await Device.ReadHoldingRegistersAsync(_slaveId, startAddress: addr, _numOfPoint))[0]);
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
                }
                catch (Exception ex)
                {
                    string message = $"GetCuerrentPattern Error : {ex.Message.ToString()}";
                    _sysConfig.WriteLogFile(message);
                }
            });



            return response;
        }

        public async Task<ProtoOvenSetting> GetOvenSetting()
        {
            ProtoOvenSetting response = new ProtoOvenSetting();

            await Task.Run(async () =>
            {
                try
                {
                    if (_sysConfig.plcDeviceConnected)
                    {
                        int[] AddrSettingList = new int[] { 536, 537, 538, 545, 546, 547, 548, 549, 556, 558 };
                        List<ushort> SettingListValue = new List<ushort>();
                        foreach (ushort addr in AddrSettingList)
                        {
                            SettingListValue.Add((await Device.ReadHoldingRegistersAsync(_slaveId, startAddress: addr, _numOfPoint))[0]);
                            await Task.Delay(10);
                        }

                        response.AlarmOven = SettingListValue[3];
                        response.AlarmAfb = SettingListValue[4];
                        response.AfbStartTemp = SettingListValue[5];
                        response.AfbEndTemp = SettingListValue[6];
                        response.AfbDelay = SettingListValue[7];
                        response.TubeStartTemp = SettingListValue[8];
                        response.FloorStartTemp = SettingListValue[9];
                        response.SetpointTemp = new Temp()
                        {
                            TempAFB = SettingListValue[0],
                            TempTube = SettingListValue[1],
                            TempFloor = SettingListValue[2],
                        };

                        bool[] CoilListValue = await Device.ReadCoilsAsync(_slaveId, startAddress: 550, numberOfPoints: 4);
                        response.CoilSetting = new Coil()
                        {
                            CoilAFB = CoilListValue[0],
                            CoilPump = CoilListValue[2],
                            CoilTube = CoilListValue[1],
                            CoilFloor = CoilListValue[3]
                        };

                        response.ManualTemp = new ProtoManualTemp()
                        {
                            Use = (await Device.ReadCoilsAsync(_slaveId, startAddress: 606, _numOfPoint))[0],
                            Temp = (await Device.ReadHoldingRegistersAsync(_slaveId, startAddress: 560, _numOfPoint))[0]
                        };
                    }
                }
                catch (Exception ex)
                {
                    string message = $"GetOvenSetting Error : {ex.Message}";
                    _sysConfig.WriteLogFile(message);
                }
            });


            return response;
        }

    }
}