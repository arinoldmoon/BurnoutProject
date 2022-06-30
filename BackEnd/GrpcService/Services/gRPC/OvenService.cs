using System.Timers;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using GrpcService.Models;
using GrpcService.Protos;
using Microsoft.Extensions.Options;

namespace GrpcService.Services.gRPC
{
    public class OvenService : OvenProtoService.OvenProtoServiceBase
    {

        private readonly IDbService _dbService;
        private readonly IPlcService _plcService;
        private readonly IOptions<PLCConfig> _config;
        private readonly ResponseModel _response;
        private readonly SystemConfig _sysConfig;

        public OvenService(IDbService dbService, IPlcService plcService, IOptions<PLCConfig> config, ResponseModel response, SystemConfig sysConfig)
        {
            _dbService = dbService;
            _config = config;
            _plcService = plcService;
            _response = response;
            _sysConfig = sysConfig;
        }

        public override async Task<ProtoServiceConnection> DeviceConnect(Empty request, ServerCallContext context)
        {
            ProtoServiceConnection response = new ProtoServiceConnection();
            await Task.Run(() =>
            {
                response.PlcConnected = _sysConfig.plcDeviceConnected;
                response.OvenInfo = _sysConfig.MachineInfo;
                response.OvenInfo!.Operation = _response.statusResponse.Operation;
                response.OperationLogInfo = _sysConfig.OperationLogInfo;
            });

            return response;
        }

        public override async Task MonitorDevice(Empty request, IServerStreamWriter<ProtoOvenResponse> responseStream, ServerCallContext context)
        {
            try
            {
                while (!context.CancellationToken.IsCancellationRequested)
                {
                    ProtoOvenResponse Response = new ProtoOvenResponse()
                    {
                        Temp = _response.tempResponse,
                        Coil = _response.coilResponse,
                        Status = _response.statusResponse
                    };

                    await responseStream.WriteAsync(Response, context.CancellationToken);
                    await Task.Delay(_config.Value.GrpcMonitorDelay);
                }
            }
            catch (Exception ex)
            {
                _sysConfig.WriteLogFile($"MonitorDevice Catch : {ex.Message}");
            }
        }

        public override async Task<ProtoOvenSetting> GetOvenSetting(Empty request, ServerCallContext context) => await _plcService.GetOvenSetting();

        public override async Task<BoolValue> UpdateOvenSetting(ProtoOvenSetting request, ServerCallContext context) => await _plcService.SetOvenSetting(request);


    }
}