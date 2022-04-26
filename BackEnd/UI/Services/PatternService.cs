using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Grpc.Net.Client;
using Microsoft.AspNetCore.Components;
using UI.Models;
using UI.Protos;
using static UI.Protos.PatternProto;

namespace UI.Services
{
    public class PatternService
    {
        private GrpcChannel channel { get; set; }
        private PatternProtoClient client { get; set; }

        [Inject]
        protected GlobalService Globals { get; set; }

        public PatternService(string IP)
        {
            var addr = new Uri($"http://{IP}:5000");

            channel = GrpcChannel.ForAddress(addr);
            client = new PatternProtoClient(channel);
        }

        public async Task<List<Pattern>> GetPatternListAsync()
        {
            List<Pattern> PatternList = new List<Pattern>();
            try
            {
                ProtoPatternList response = (await client.GetPatternListAsync(new Empty()));
                if (response.Pattern.Any())
                {
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
                Console.WriteLine($"GetPatternList Error {ex.StatusCode} : {ex.Message}");
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
                    Id = response.AirPump.Id,
                    StartTemp = response.AirPump.StartTemp,
                    EndTemp = response.AirPump.EndTemp,
                    DelayDuration = (int)TimeSpan.FromSeconds(response.AirPump.DelayMinuteDuration.Seconds).TotalMinutes
                };

                foreach (var item in response.PatternDetail)
                {
                    PatternItem pattern = new PatternItem()
                    {
                        DetailId = item.DetailId,
                        PatternId = item.PatternId,
                        Step = item.Step,
                        Temp = item.Temp,
                        StepDuration = (int)TimeSpan.FromSeconds(item.StepDuration.Seconds).TotalMinutes
                    };
                    result.PatternItems.Add(pattern);
                }
            }

            return result;
        }

        public async Task<bool> UpdatePatternToDB(Pattern pattern)
        {
            ProtoPattern request = new ProtoPattern();
            ProtoAirpump air = new ProtoAirpump();

            request.PatternId = pattern.PatternNumber;
            request.PatternName = pattern.PatternName;
            request.StepCount = pattern.StepCount;
            request.TotalTime = TimeSpan.FromMinutes(pattern.PatternItems.Sum(x => x.StepDuration)).ToDuration();
            request.AirPump = new ProtoAirpump()      
            {
                Id = pattern.Airpump.Id,
                StartTemp = pattern.Airpump.StartTemp,
                EndTemp = pattern.Airpump.EndTemp,
                DelayMinuteDuration = TimeSpan.FromMinutes(pattern.Airpump.DelayDuration).ToDuration()
            }; 

            // air.Id = pattern.Airpump.Id;
            // air.StartTemp = pattern.Airpump.StartTemp;
            // air.EndTemp = pattern.Airpump.EndTemp;
            // air.DelayMinuteDuration = TimeSpan.FromMinutes(pattern.Airpump.DelayDuration).ToDuration();

            // request.AirPump = air;



            foreach (var item in pattern.PatternItems)
            {
                request.PatternDetail.Add(new ProtoPatternDetail()
                {
                    DetailId = item.DetailId,
                    PatternId = item.PatternId,
                    Step = item.Step,
                    Temp = item.Temp,
                    StepDuration = TimeSpan.FromMinutes(item.StepDuration).ToDuration()
                });
            }

            var status =  client.UpdatePattern(request);
            
            await Task.CompletedTask;

            return status.Value;
        }

        public async Task<bool> CreatePattern(Pattern pattern)  
        {
            ProtoPattern request = new ProtoPattern()
            {
                PatternName = pattern.PatternName,
                StepCount = pattern.StepCount,
                TotalTime = TimeSpan.FromMinutes(pattern.PatternItems.Sum(x => x.StepDuration)).ToDuration(),
                AirPump = new ProtoAirpump()
                {
                    Id = pattern.Airpump.Id,
                    StartTemp = pattern.Airpump.StartTemp,
                    EndTemp = pattern.Airpump.EndTemp,
                    DelayMinuteDuration = TimeSpan.FromMinutes(pattern.Airpump.DelayDuration).ToDuration()
                }
            };

            foreach (var item in pattern.PatternItems)
            {
                request.PatternDetail.Add(new ProtoPatternDetail()
                {
                    Step = item.Step,
                    Temp = item.Temp,
                    StepDuration = TimeSpan.FromMinutes(item.StepDuration).ToDuration()
                });
            }

            return (await client.CreatePatternAsync(request)).Value;
        }
    }
}