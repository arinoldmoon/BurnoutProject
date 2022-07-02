using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Grpc.Net.Client;
using GrpcService.Protos;
using static GrpcService.Protos.PatternProtoService;

namespace UI.Services
{
    public partial class PatternService
    {
        private GrpcChannel channel { get; set; }
        private PatternProtoServiceClient client { get; set; }

        public PatternService(string IP)
        {
            var addr = new Uri($"http://{IP}:5000");

            channel = GrpcChannel.ForAddress(addr);
            client = new PatternProtoServiceClient(channel);
        }

        public async Task<List<ProtoPattern>> GetPatternListAsync()
        {
            List<ProtoPattern> PatternList = new List<ProtoPattern>();

            try
            {
                await Task.Run(async () => await client.GetPatternListAsync(new Empty())).ContinueWith(res =>
                {
                    if (res.Result.Pattern.Any())
                    {
                        PatternList.AddRange(res.Result.Pattern);
                    }
                });
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"GetPatternList Error {ex.StatusCode} : {ex.Message}");
                return new List<ProtoPattern>(); ;
            }

            return PatternList;
        }      

        public async Task<ProtoPattern> GetPatternByID(int PatternId) => await client.GetPatternAsync(new Int32Value(){Value = PatternId});
    
        public async Task<BoolValue> DeletePattern(int PatternId) => await client.DeletePatternAsync(new Int32Value(){Value = PatternId});
        
        public async Task<BoolValue> CreatePattern(ProtoPattern patternData) => await client.CreatePatternAsync(patternData);

        public async Task<BoolValue> UpdatePattern(ProtoPattern patternData) => await client.UpdatePatternAsync(patternData);
    }
}