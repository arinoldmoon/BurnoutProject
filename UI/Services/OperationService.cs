using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Grpc.Net.Client;
using GrpcService.Protos;
using Microsoft.AspNetCore.Components;
using UI.Models;
using static GrpcService.Protos.OperationProtoService;

namespace UI.Services
{
    public class OperationService
    {
        private GrpcChannel channel { get; set; }
        private OperationProtoServiceClient OperationProto { get; set; }

        public OperationService(string IP)
        {
            var addr = new Uri($"http://{IP}:5000");

            channel = GrpcChannel.ForAddress(addr);
            OperationProto = new OperationProtoServiceClient(channel);
        }

        public async Task<List<TempActualLog>> GetOperationLog(int request)
        {
            List<TempActualLog> response = new List<TempActualLog>();
            ActualLogList result = await OperationProto.GetOperationLogWithIDAsync(new Int32Value() { Value = request });
            if (result.TempLog.Any())
            {
                foreach (var item in result.TempLog)
                {
                    response.Add(new TempActualLog()
                    {
                        TempTime = item.TempTime.ToDateTime().ToLocalTime(),
                        TempValue = new Temp()
                        {
                            TempOven = item.TempValue.TempOven,
                            TempAFB = item.TempValue.TempAFB
                        }
                    });
                }
            }

            return response;
        }

        public async Task<ProtoOperationLogInfo> GetOperationLogWithFilter(int year, int month)
        {
            ProtoOperationLogInfo response = new ProtoOperationLogInfo();

            await Task.Run(async () =>
            {
                response = await OperationProto.GetOperationLogWithFilterAsync(new OperationLogWithFilter() { YearSelect = year, MonthSelect = month });
                return Task.CompletedTask;
            });

            return response;
        }

        public async Task<BoolValue> StartOpration(ProtoPattern pattern) => await OperationProto.StartOperationAsync(pattern);

        public async Task<BoolValue> StopOpration() => await OperationProto.StopOperationAsync(new Empty());

        public async Task<ProtoPattern> CurrentPattern() => await OperationProto.CurrentPatternAsync(new Empty());

        public async Task<BoolValue> ManualTemp(ProtoManualTemp request) => await OperationProto.ManualTempAsync(request);
    }
}