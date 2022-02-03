using System;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using GrpcService.Models;
using GrpcService.Protos;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace GrpcService.Services
{
    public class GrpcOvenService : OvenProto.OvenProtoBase
    {
        private readonly ILogger<GrpcOvenService> _logger;
        private readonly IOvenDbService _dbService;
        private readonly int _streamDelay = 0;


        public GrpcOvenService(ILogger<GrpcOvenService> logger, IConfiguration Config, IOvenDbService dbService)
        {
            _logger = logger;
            _dbService = dbService;
            _streamDelay = Convert.ToInt32(Config["PLCConfig:StreamDelay"]);
        }

        public override Task<BoolValue> GrpcConnect(Empty request, ServerCallContext context)
        {
            _logger.LogInformation("GrpcConnect");
            return Task.FromResult(new BoolValue() { Value = true });
        }

        public override async Task<ProtoOvenInfo> GetOvenInfo(Empty request, ServerCallContext context)
        {
            _logger.LogInformation("GetOvenInfo");
            ProtoOvenInfo response = new ProtoOvenInfo();

            var result = await _dbService.GetMachineInfo();
            response.SerialNumber = result.SerialNumber;
            response.MachineModel = result.MachineModel;
            response.MachineName = result.MachineName;
            response.WarrantyStart = new Timestamp() { Seconds = result.WarrantyStart };
            response.WarrantyEnd = new Timestamp() { Seconds = result.WarrantyEnd };

            return response;
        }

        public override async Task<BoolValue> UpdateMachineInfo(ProtoOvenInfo request, ServerCallContext context)
        {
            _logger.LogInformation("UpdateMachineInfo");
            MachineInfo Info = new MachineInfo();

            Info.SerialNumber = request.SerialNumber;
            Info.MachineModel = request.MachineModel;
            Info.MachineName = request.MachineName;
            Info.WarrantyStart = Convert.ToInt32(request.WarrantyStart.Seconds);
            Info.WarrantyEnd = Convert.ToInt32(request.WarrantyEnd.Seconds);

            return new BoolValue() { Value = await _dbService.UpdateMachineInfo(Info) };
        }

        public override async Task<ProtoOvenSetting> GetOvenSetting(Empty request, ServerCallContext context)
        {
            _logger.LogInformation("GetOvenSetting");
            ProtoOvenSetting response = new ProtoOvenSetting();

            var result = await _dbService.GetMachineSetting();
            response.SettingId = result.Setting_ID;
            response.AfbStartTemp = result.AfbStartTemp;
            response.AfbEndTemp = result.AfbEndTemp;
            response.AfbDelay = result.AfbDelay;
            response.PumpStartTemp = result.PumpStartTemp;
            response.PumpEndTemp = result.PumpEndTemp;
            response.PumpDelay = result.PumpDelay;
            response.TubeStartTemp = result.TubeStartTemp;
            response.FloorStartTemp = result.FloorStartTemp;
            response.AlarmOven = result.AlarmOven;
            response.AlarmAfb = result.AlarmAfb;

            return response;
        }

        public override async Task<BoolValue> UpdateOvenSetting(ProtoOvenSetting request, ServerCallContext context)
        {
            _logger.LogInformation("UpdateOvenSetting");
            MachineSetting setting = new MachineSetting();

            setting.AfbStartTemp = request.AfbStartTemp;
            setting.AfbEndTemp = request.AfbEndTemp;
            setting.AfbDelay = request.AfbDelay;
            setting.PumpStartTemp = request.PumpStartTemp;
            setting.PumpEndTemp = request.PumpEndTemp;
            setting.PumpDelay = request.PumpDelay;
            setting.TubeStartTemp = request.TubeStartTemp;
            setting.FloorStartTemp = request.FloorStartTemp;
            setting.AlarmOven = request.AlarmOven;
            setting.AlarmAfb = request.AlarmAfb;

            return new BoolValue() { Value = await _dbService.UpdateMachineSetting(setting) };
        }
    }
}
