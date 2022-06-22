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

            await Task.Run(async () =>
            {
                await _plcService.CheckConnection();
                response.PlcConnected = _sysConfig.plcDeviceConnected;
                response.OvenInfo = await _dbService.GetMachineInfo();
                response.OperationLogInfo = await _dbService.GetOperationLogInfo();
            });

            return response;
        }

        public override async Task MonitorDevice(Empty request, IServerStreamWriter<ProtoOvenResponse> responseStream, ServerCallContext context)
        {
            while (!context.CancellationToken.IsCancellationRequested)
            {
                ProtoOvenResponse Response = new ProtoOvenResponse()
                {
                    Temp = _response.tempResponse,
                    Coil = _response.coilResponse,
                    Status = _response.statusResponse
                };

                await responseStream.WriteAsync(Response);
                Thread.Sleep(TimeSpan.FromMilliseconds(_config.Value.GrpcMonitorDelay));
            }
        }

        public override async Task<ProtoOvenSetting> GetOvenSetting(Empty request, ServerCallContext context) => await _plcService.GetOvenSetting();

        public override async Task<BoolValue> UpdateOvenSetting(ProtoOvenSetting request, ServerCallContext context) => await _plcService.SetOvenSetting(request);
        

    }
}