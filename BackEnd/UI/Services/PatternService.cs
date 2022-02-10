using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Grpc.Net.Client;
using UI.Models;
using UI.Protos;
using static UI.Protos.PatternProto;

namespace UI.Services
{
    public class PatternService
    {
        private GrpcChannel channel { get; set; }
        private PatternProtoClient client { get; set; }

        private bool GrpcIsConnected { get { return OvenService.GrpcIsConnected; } }

        public PatternService(string IP)
        {
            var addr = new Uri($"http://{IP}:5000");

            channel = GrpcChannel.ForAddress(addr);
            client = new PatternProtoClient(channel);
        }

        public async Task<IEnumerable<Pattern>> GetPatternListAsync()
        {
            List<Pattern> PatternList = new List<Pattern>();
            try
            {
                if (GrpcIsConnected)
                {
                    var response = (await client.GetPatternListAsync(new Empty()));
                    foreach (var item in response.Pattern)
                    {
                        Pattern pattern = new Pattern()
                        {
                            PatternNumber = item.PatternId,
                            PatternName = item.PatternName,
                            StepCount = item.StepCount,
                            TotalTime = (int)TimeSpan.FromSeconds(item.TotalTime.Seconds).TotalMinutes
                        };
                        PatternList.Add(pattern);
                    }
                }
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"GetMachineInfo Error {ex.StatusCode} : {ex.Message}");
                return new List<Pattern>(); ;
            }

            return PatternList;
        }

        public async Task<Pattern> GetPatternByID(int PatternNumber)
        {
            Pattern result = new Pattern();
            ProtoPattern response = await client.GetPatternAsync(new Int32Value() { Value = PatternNumber });

            if (response != null)
            {
                result.PatternNumber = response.PatternId;
                result.PatternName = response.PatternName;
                result.StepCount = response.StepCount;
                result.TotalTime = (int)TimeSpan.FromSeconds(response.TotalTime.Seconds).TotalMinutes;

                result.Airpump = new AirPumpSetting()
                {
                    StartTemp = response.AirPump.StartTemp,
                    EndTemp = response.AirPump.EndTemp,
                    DelayDuration = (int)TimeSpan.FromSeconds(response.AirPump.DelayMinuteDuration.Seconds).TotalMinutes
                };

                foreach (var item in response.PatternDetail)
                {
                    PatternItem pattern = new PatternItem()
                    {
                        Step = item.Step,
                        Temp = item.Temp,
                        StepDuration = (int)TimeSpan.FromSeconds(item.StepDuration.Seconds).TotalMinutes
                    };
                    result.PatternItems.Add(pattern);
                }
            }

            return result;
        }
    }
}