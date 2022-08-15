using System.ComponentModel;
using System.Reflection;
using Google.Protobuf.WellKnownTypes;
using GrpcService.Models.SQLite;
using GrpcService.Protos;

namespace GrpcService.Models
{
    public class SystemConfig
    {
        public static string DATE_FORMAT_STRING { get { return "yyyy-MM-dd HH:mm:ss"; } }  // yyyy-MM-dd HH:mm:ss  dd/MM/yyyy HH:mm
        public bool plcDeviceConnected { get; set; }

        private ProtoOvenInfo? _machineInfo;
        public ProtoOvenInfo MachineInfo
        {
            get { return _machineInfo!; }
            set { if (!object.Equals(_machineInfo, value)) { _machineInfo = value; } }
        }
        private ProtoOperationLogInfo? _OperationLogInfo;
        public ProtoOperationLogInfo OperationLogInfo
        {
            get { return _OperationLogInfo!; }
            set { if (!object.Equals(_OperationLogInfo, value)) { _OperationLogInfo = value; } }
        }

        private int _lastLogID;
        public int LastLogID
        {
            get { return _lastLogID; }
            set { if (!object.Equals(_lastLogID, value)) { _lastLogID = value; } }
        }


        public void WriteLogFile(string logMessage)
        {
            Task.Run(async () =>
            {
                try
                {
                    string logPath = AppDomain.CurrentDomain.BaseDirectory + "EvenLog.txt";
                    await File.AppendAllLinesAsync(logPath, new[] { $"{DateTime.Now.ToString(DATE_FORMAT_STRING)} {logMessage}" });
                    Console.WriteLine("WriteLogFile Success");
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            });
        }
    }

    public class PLCConfig
    {
        public string PortName { get; set; } = string.Empty;
        public int BaudRate { get; set; }
        public int WorkerMonitorDelay { get; set; }
        public int GrpcMonitorDelay { get; set; }
        public int OperationWriteLogDelay { get; set; }
    }

    public class ModelConvertor
    {
        public ProtoPattern ConvertPatternModelToProtoPattern(Pattern model)
        {
            ProtoPattern response = new ProtoPattern();

            response = new ProtoPattern()
            {
                PatternId = model.PatternNumber == 99 ? 99 : (int)model.PatternNumber,
                PatternName = model.PatternName,
                StepCount = model.PatternItems.Count,
                TotalTime = TimeSpan.FromSeconds(model.PatternItems.Sum(x => x.StepDuration)).ToDuration(),
                UseAfb = Convert.ToBoolean(model.UseAfb),
                CreateDate = !string.IsNullOrEmpty(model.CreateDate) ? DateTime.ParseExact(model.CreateDate!, SystemConfig.DATE_FORMAT_STRING, null).ToUniversalTime().ToTimestamp() : null,
                ModifyDate = !string.IsNullOrEmpty(model.ModifyDate) ? DateTime.ParseExact(model.ModifyDate!, SystemConfig.DATE_FORMAT_STRING, null).ToUniversalTime().ToTimestamp() : null
            };

            response.AirPump = new ProtoAirpump()
            {
                Id = (int)model.Airpump!.Id,
                StartTemp = (int)model.Airpump.StartTemp,
                EndTemp = (int)model.Airpump.EndTemp,
                DelayMinuteDuration = TimeSpan.FromMinutes(model.Airpump.DelayDuration).ToDuration(),
                UseAirpump = Convert.ToBoolean(model.Airpump.UseAirpump)
            };

            foreach (var item in model.PatternItems)
            {
                response.PatternDetail.Add(new ProtoPatternDetail()
                {
                    DetailId = (int)item.Id,
                    PatternId = (int)item.PatternNumber,
                    Step = (int)item.Step,
                    Temp = (int)item.Temp,
                    StepDuration = TimeSpan.FromMinutes(item.StepDuration).ToDuration()
                });
            }

            return response;
        }

        public Pattern ConvertProtoPatternToPatternModel(ProtoPattern proto)
        {
            Pattern response = new Pattern();

            response = new Pattern()
            {
                PatternNumber = proto.PatternId,
                PatternName = proto.PatternName,
                AirpumpId = proto.AirPump.Id,
                UseAfb = Convert.ToInt32(proto.UseAfb),
                CreateDate = proto.CreateDate!.ToDateTime().ToUniversalTime().ToString(SystemConfig.DATE_FORMAT_STRING)
            };

            response.Airpump = new AirPumpSetting()
            {
                Id = proto.AirPump.Id,
                StartTemp = proto.AirPump.StartTemp,
                EndTemp = proto.AirPump.EndTemp,
                DelayDuration = (long)TimeSpan.FromSeconds(proto.AirPump.DelayMinuteDuration.Seconds).TotalMinutes,
                UseAirpump = Convert.ToInt32(proto.AirPump.UseAirpump)
            };

            foreach (var item in proto.PatternDetail)
            {
                response.PatternItems.Add(new PatternItem()
                {
                    Id = item.DetailId,
                    PatternNumber = item.PatternId,
                    Step = item.Step,
                    Temp = item.Temp,
                    StepDuration = (long)TimeSpan.FromSeconds(item.StepDuration.Seconds).TotalMinutes
                });
            }

            return response;
        }

    }

    public class ResponseModel
    {
        public Temp tempResponse { get; set; } = new Temp();
        public Coil coilResponse { get; set; } = new Coil();
        public MachineStatus statusResponse { get; set; } = new MachineStatus();
    }
}