using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using GrpcService.Models;
using GrpcService.Protos;

namespace GrpcService.Services.gRPC
{
    public class PatternService : PatternProtoService.PatternProtoServiceBase
    {
        private readonly IDbService _dbService;
        private readonly ModelConvertor _convert;

        public PatternService(IDbService dbService, ModelConvertor convert)
        {
            _dbService = dbService;
            _convert = convert;
        }

        public override async Task<ProtoPatternList> GetPatternList(Empty request, ServerCallContext context) => await _dbService.GetPatternList();

        public override async Task<ProtoPattern> GetPattern(Int32Value request, ServerCallContext context) => _convert.ConvertPatternModelToProtoPattern(await _dbService.GetPattern(request));

        public override async Task<BoolValue> CreatePattern(ProtoPattern request, ServerCallContext context) => await _dbService.CreatePattern(request);

        public override async Task<BoolValue> UpdatePattern(ProtoPattern request, ServerCallContext context) => await _dbService.UpdatePattern(request);

        public override async Task<BoolValue> DeletePattern(Int32Value request, ServerCallContext context) => await _dbService.DeletePattern(request);

    }
}