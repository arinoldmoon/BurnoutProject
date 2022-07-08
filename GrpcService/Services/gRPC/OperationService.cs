using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using GrpcService.Models;
using GrpcService.Models.SQLite;
using GrpcService.Protos;

namespace GrpcService.Services.gRPC
{
    public class OperationService : OperationProtoService.OperationProtoServiceBase
    {
        private readonly IDbService _dbService;
        private readonly IPlcService _plcService;
        private readonly SystemConfig _sysConfig;

        public OperationService(IDbService dbService, IPlcService plcService, SystemConfig sysConfig)
        {
            _dbService = dbService;
            _plcService = plcService;
            _sysConfig = sysConfig;
        }

        public override async Task<ActualLogList> GetOperationLogWithID(Int32Value request, ServerCallContext context)
        {
            ActualLogList response = new ActualLogList();

            try
            {
                await Task.Run(async () =>
                {
                    List<OperationLog> result = await _dbService.GetOperationLogByID(request.Value);
                    if (result.Any())
                    {
                        foreach (var item in result)
                        {
                            response.TempLog.Add(new ActualLog()
                            {
                                TempTime = DateTime.SpecifyKind(DateTime.ParseExact(item.OperationTime!, _sysConfig.DATE_FORMAT_STRING, null), DateTimeKind.Utc).ToTimestamp(),
                                TempValue = new Temp()
                                {
                                    TempOven = Convert.ToInt32(item.ActualTempOven),
                                    TempAFB = Convert.ToInt32(item.ActualTempAfb),
                                    TempFloor = Convert.ToInt32(item.ActualTempFloor),
                                    TempTube = Convert.ToInt32(item.ActualTempTube)
                                }
                            });
                        }
                        _sysConfig.WriteLogFile($"GetOperationLogWithID : {request.Value}");
                    }
                });
            }
            catch (Exception ex)
            {
                _sysConfig.WriteLogFile($"GetOperationLogWithID Error : {ex.Message}");
            }


            return response;
        }

        public override async Task<ProtoOperationLogInfo> GetOperationLogWithFilter(OperationLogWithFilter request, ServerCallContext context)
        {
            ProtoOperationLogInfo response = new ProtoOperationLogInfo();
            
            try
            {
               await Task.Run(() =>
                {
                    var result = _dbService.GetOperationLogWithFilter(request.YearSelect, request.MonthSelect).Result.LogList;
                    response.LogList.AddRange(result);
                });
            }
            catch (Exception ex)
            {
                _sysConfig.WriteLogFile($"GetOperationLogWithFilter Error : {ex.Message}");
            }


            return response;
        }

        public override async Task<BoolValue> StartOperation(ProtoPattern request, ServerCallContext context) => await _plcService.StartOperation(request);

        public override async Task<BoolValue> StopOperation(Empty request, ServerCallContext context) => await _plcService.StopOperation();

        public override async Task<ProtoPattern> CurrentPattern(Empty request, ServerCallContext context) => await _plcService.GetCuerrentPattern();

        public override async Task<BoolValue> ManualTemp(ProtoManualTemp request, ServerCallContext context) => await _plcService.SetManualTemp(request);
       
    }
}