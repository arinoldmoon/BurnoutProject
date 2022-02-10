using System;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Grpc.Net.Client;
using UI.Models;
using UI.Protos;
using static UI.Protos.OperationProto;

namespace UI.Services
{
    public class OperationService
    {
        private GrpcChannel channel { get; set; }

        public static OperationProtoClient OperationProto { get; set; }

        private bool GrpcIsConnected { get { return OvenService.GrpcIsConnected; } }

        private bool PLCIsConnected { get { return OvenService.PLCIsConnected; } }

        public OperationService(string IP)
        {
            var addr = new Uri($"http://{IP}:5000");

            channel = GrpcChannel.ForAddress(addr);
            OperationProto = new OperationProtoClient(channel);
        }

        public async Task<bool> StopOperation()
        {
            try
            {
                return (await OperationProto.StopOperationAsync(new Empty())).Value;
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"Connection Error : {ex.StatusCode}");
                return false;
            }
        }

        public async Task<bool> StartOpration(Pattern pattern)
        {
            try
            {
                ProtoPattern request = new ProtoPattern();
                request.PatternId = pattern.PatternNumber;
                request.StepCount = pattern.StepCount;
                request.AirPump = new ProtoAirpump()
                {
                    StartTemp = pattern.Airpump.StartTemp,
                    EndTemp = pattern.Airpump.EndTemp,
                    DelayMinuteDuration = TimeSpan.FromMinutes(pattern.Airpump.DelayDuration).ToDuration()
                };

                foreach (var item in pattern.PatternItems)
                {
                    ProtoPatternDetail detail = new ProtoPatternDetail();
                    detail.Step = item.Step;
                    detail.Temp = item.Temp;
                    detail.StepDuration = TimeSpan.FromMinutes(item.StepDuration).ToDuration();

                    request.PatternDetail.Add(detail);
                }

                return (await OperationProto.StartOperationAsync(request)).Value;
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"Connection Error : {ex.StatusCode}");
                return false;
            }
        }

        public async Task<Pattern> CurrentPattern()
        {
            Pattern result = new Pattern();
            try
            {
                ProtoPattern response = await OperationProto.CurrentPatternAsync(new Empty());
                if (response != null)
                {
                    result.PatternNumber = response.PatternId;
                    result.StepCount = response.StepCount;

                    foreach (var item in response.PatternDetail)
                    {
                        result.PatternItems.Add(new PatternItem()
                        {
                            Step = item.Step,
                            Temp = item.Temp,
                            StepDuration = (int)TimeSpan.FromSeconds(item.StepDuration.Seconds).TotalMinutes
                        });
                    }
                    return result;
                }
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"Connection Error : {ex.StatusCode}");
            }

            return result;
        }
    }
}