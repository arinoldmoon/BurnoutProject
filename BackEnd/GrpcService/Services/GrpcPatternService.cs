using System;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using GrpcService.Models;
using GrpcService.Protos;
using Microsoft.Extensions.Logging;

namespace GrpcService.Services
{
    public class GrpcPatternService : PatternProto.PatternProtoBase
    {
        private readonly ILogger<GrpcPatternService> _logger;
        private readonly IOvenDbService _dbService;

        public GrpcPatternService(ILogger<GrpcPatternService> logger, IOvenDbService dbService)
        {
            _logger = logger;
            _dbService = dbService;
        }

        public override async Task<ProtoPatternList> GetPatternList(Empty request, ServerCallContext context)
        {
            _logger.LogInformation("Call GRPC -> GetPatternList");
            ProtoPatternList response = new ProtoPatternList();

            var resultFromDB = await _dbService.GetPatternList();

            foreach (var result in resultFromDB)
            {
                ProtoPattern res = new ProtoPattern();
                res.PatternId = result.PatternNumber;
                res.PatternName = result.PatternName;
                res.StepCount = result.StepCount;
                res.TotalTime = TimeSpan.FromMinutes(result.TotalTime).ToDuration();
                res.CreateDate = !String.IsNullOrEmpty(result.CreateDate) ? DateTime.Parse(result.CreateDate).ToUniversalTime().ToTimestamp() : null;
                res.ModifyDate = !String.IsNullOrEmpty(result.ModifyDate) ? DateTime.Parse(result.ModifyDate).ToUniversalTime().ToTimestamp() : null;

                response.Pattern.Add(res);
            }

            return response;
        }

        public override async Task<ProtoPattern> GetPattern(Int32Value request, ServerCallContext context)
        {
            _logger.LogInformation("Call GRPC -> GetPattern");
            ProtoPattern response = new ProtoPattern();

            var resultFromDB = await _dbService.GetPattern(request.Value);
            if (resultFromDB != null)
            {
                response.PatternId = resultFromDB.PatternNumber;
                response.PatternName = resultFromDB.PatternName;
                response.StepCount = resultFromDB.StepCount;
                response.TotalTime = new Duration() { Seconds = resultFromDB.TotalTime };
                response.AirPump = new ProtoAirpump()
                {
                    Id = resultFromDB.Airpump.Id,
                    StartTemp = resultFromDB.Airpump.StartTemp,
                    EndTemp = resultFromDB.Airpump.EndTemp,
                    DelayMinuteDuration = TimeSpan.FromMinutes(resultFromDB.Airpump.DelayDuration).ToDuration()
                };
                foreach (var item in resultFromDB.PatternItems)
                {
                    ProtoPatternDetail detail = new ProtoPatternDetail();
                    detail.Step = item.Step;
                    detail.Temp = item.Temp;
                    detail.StepDuration = TimeSpan.FromMinutes(item.StepDuration).ToDuration();
                    detail.DetailId = item.Id;
                    detail.PatternId = resultFromDB.PatternNumber;

                    response.PatternDetail.Add(detail);
                }
                response.CreateDate = !String.IsNullOrEmpty(resultFromDB.CreateDate) ? DateTime.Parse(resultFromDB.CreateDate).ToUniversalTime().ToTimestamp() : null;
                response.ModifyDate = !String.IsNullOrEmpty(resultFromDB.ModifyDate) ? DateTime.Parse(resultFromDB.ModifyDate).ToUniversalTime().ToTimestamp() : null;
            }

            return response;
        }

        public override async Task<BoolValue> CreatePattern(ProtoPattern request, ServerCallContext context)
        {
            _logger.LogInformation("Call GRPC -> CreatePattern");
            Pattern pattern = new Pattern();

            pattern.PatternName = request.PatternName;
            pattern.Airpump = new AirPumpSetting()
            {
                StartTemp = request.AirPump.StartTemp,
                EndTemp = request.AirPump.EndTemp,
                DelayDuration = (int)TimeSpan.FromSeconds(request.AirPump.DelayMinuteDuration.Seconds).TotalMinutes
            };
            foreach (var item in request.PatternDetail)
            {
                var list = new PatternItem()
                {
                    Step = item.Step,
                    Temp = item.Temp,
                    StepDuration = (int)TimeSpan.FromSeconds(item.StepDuration.Seconds).TotalMinutes,
                };
                pattern.PatternItems.Add(list);
            }

            return new BoolValue() { Value = await _dbService.CreatePattern(pattern) };
        }

        public override async Task<BoolValue> UpdatePattern(ProtoPattern request, ServerCallContext context)
        {
            _logger.LogInformation("Call GRPC -> UpdatePattern");
            BoolValue response = new BoolValue();
            Pattern pattern = new Pattern();

            pattern.PatternName = request.PatternName;
            pattern.PatternNumber = request.PatternId;
            pattern.Airpump = new AirPumpSetting()
            {
                Id = request.AirPump.Id,
                StartTemp = request.AirPump.StartTemp,
                EndTemp = request.AirPump.EndTemp,
                DelayDuration = (int)TimeSpan.FromSeconds(request.AirPump.DelayMinuteDuration.Seconds).TotalMinutes
            };
            foreach (var item in request.PatternDetail)
            {
                var list = new PatternItem()
                {
                    Id = item.DetailId,
                    Step = item.Step,
                    Temp = item.Temp,
                    StepDuration = (int)TimeSpan.FromSeconds(item.StepDuration.Seconds).TotalMinutes,

                };
                pattern.PatternItems.Add(list);
            }
            pattern.CreateDate = request.CreateDate.ToDateTime().ToString();

            return new BoolValue() { Value = await _dbService.UpdatePattern(pattern) };
        }

        public override async Task<BoolValue> DeletePattern(Int32Value request, ServerCallContext context)
        {
            _logger.LogInformation("Call GRPC -> DeletePattern");
            return new BoolValue() { Value = await _dbService.DeletePattern(request.Value) };
        }

    }
}