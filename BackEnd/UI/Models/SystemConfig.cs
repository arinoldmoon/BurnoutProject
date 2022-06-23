using Google.Protobuf.WellKnownTypes;
using GrpcService.Protos;

namespace UI.Models
{
    public class SystemConfig
    {
        public string DATE_FORMAT_STRING { get { return "dd/MM/yyyy HH:mm"; } }
    }

    public class ModelConvertor
    {
        public ProtoPattern ConvertPatternModelToProtoPattern(PatternModel model)
        {
            ProtoPattern response = new ProtoPattern();

            response = new ProtoPattern()
            {
                PatternId = model.PatternId == 99 ? 99 : (int)model.PatternId,
                PatternName = model.PatternName,
                StepCount = model.PatternDetail.Count,
                TotalTime = TimeSpan.FromSeconds(model.PatternDetail.Sum(x => x.StepDuration)).ToDuration(),
                UseAfb = Convert.ToBoolean(model.UseAfb),
                CreateDate = model.CreateDate.ToUniversalTime().ToTimestamp(),
                ModifyDate = model.ModifyDate.ToUniversalTime().ToTimestamp()
            };

            response.AirPump = new ProtoAirpump()
            {
                Id = (int)model.AirPump!.Id,
                StartTemp = (int)model.AirPump.StartTemp,
                EndTemp = (int)model.AirPump.EndTemp,
                DelayMinuteDuration = TimeSpan.FromMinutes(model.AirPump.DelayMinuteDuration).ToDuration(),
                UseAirpump = Convert.ToBoolean(model.AirPump.UseAirpump)
            };

            foreach (var item in model.PatternDetail)
            {
                response.PatternDetail.Add(new ProtoPatternDetail()
                {
                    DetailId = (int)item.DetailId,
                    PatternId = (int)item.PatternId,
                    Step = (int)item.Step,
                    Temp = (int)item.Temp,
                    StepDuration = TimeSpan.FromMinutes(item.StepDuration).ToDuration()
                });
            }

            return response;
        }

        public PatternModel ConvertProtoPatternToPatternModel(ProtoPattern proto)
        {
            PatternModel response = new PatternModel();

            response = new PatternModel()
            {
                PatternId = proto.PatternId,
                PatternName = proto.PatternName,
                AirpumpId = proto.AirPump.Id,
                UseAfb = proto.UseAfb,
                CreateDate = proto.CreateDate.ToDateTime()
            };            

            response.AirPump = new AirpumpModel()
            {
                Id = proto.AirPump.Id,
                StartTemp = proto.AirPump.StartTemp,
                EndTemp = proto.AirPump.EndTemp,
                DelayMinuteDuration = (long)TimeSpan.FromSeconds(proto.AirPump.DelayMinuteDuration.Seconds).TotalMinutes,
                UseAirpump = proto.AirPump.UseAirpump
            };

            foreach (var item in proto.PatternDetail)
            {
                response.PatternDetail.Add(new PatternDetailModel()
                {
                    DetailId = item.DetailId,
                    PatternId = item.PatternId,
                    Step = item.Step,
                    Temp = item.Temp,
                    StepDuration = (long)TimeSpan.FromSeconds(item.StepDuration.Seconds).TotalMinutes
                });
            }

            return response;
        }

    }

}