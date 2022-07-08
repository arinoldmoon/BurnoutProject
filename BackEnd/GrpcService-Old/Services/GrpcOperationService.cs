using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Grpc.Core;
using Google.Protobuf.WellKnownTypes;
using GrpcService.Protos;
using GrpcService.Models;

namespace GrpcService.Services
{
    public class GrpcOperationService : OperationProto.OperationProtoBase
    {
        private readonly ILogger<GrpcOvenService> _logger;
        private readonly IOvenDbService _dbService;
        private readonly IOvenPlcService _plcService;
        private readonly FactorConfig _factor;

        public GrpcOperationService(ILogger<GrpcOvenService> logger, IOvenDbService dbService, IOvenPlcService plcService, FactorConfig factor)
        {
            _logger = logger;
            _dbService = dbService;
            _plcService = plcService;
            _factor = factor;
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

        public override async Task<ActualLogList> GetOperationLog(Int32Value request, ServerCallContext context)
        {
            ActualLogList response = new ActualLogList();

            var result = await _dbService.GetOperationLogByID(request.Value);
            if (result.Any())
            {
                foreach (var item in result)
                {
                    response.TempLog.Add(new ActualLog()
                    {
                        TempTime = DateTime.SpecifyKind(DateTime.ParseExact(item.OperationTime, _factor.DATE_FORMAT_STRING, null), DateTimeKind.Utc).ToTimestamp(),
                        TempValue = new Temp()
                        {
                            TempOven = item.ActualTempOven,
                            TempAFB = item.ActualTempAFB,
                            TempFloor = item.ActualTempFloor,
                            TempTube = item.ActualTempTube
                        }
                    });
                }
            }
            Console.WriteLine(result.Count);
            return response;
        }

        // public override async Task<ProtoOvenLog> GetOperationLogList(ProtoOvenLogRequest request, ServerCallContext context)
        // {
        //     return await _dbService.GetOperationLog(request.SelectYear, request.SelectMonth);
        // }
    }
}