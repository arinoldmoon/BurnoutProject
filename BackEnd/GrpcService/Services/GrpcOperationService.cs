using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using GrpcService.Protos;
using Microsoft.Extensions.Logging;

namespace GrpcService.Services
{
    public class GrpcOperationService : OperationProto.OperationProtoBase
    {
        private readonly ILogger<GrpcOvenService> _logger;
        private readonly IOvenDbService _dbService;
        private readonly IOvenPlcService _plcService;

        public GrpcOperationService(ILogger<GrpcOvenService> logger, IOvenDbService dbService, IOvenPlcService plcService)
        {
            _logger = logger;
            _dbService = dbService;
            _plcService = plcService;
        }

        public override Task<BoolValue> StartOperation(ProtoPattern request, ServerCallContext context)
        {
            return _plcService.PushStartOperation(request);
        }

        public override Task<BoolValue> StopOperation(Empty request, ServerCallContext context)
        {
            return _plcService.PushStopOperation();
        }

        public override Task<ProtoPattern> CurrentPattern(Empty request, ServerCallContext context)
        {
            return _plcService.GetCuerrentPattern();
        }
    }
}