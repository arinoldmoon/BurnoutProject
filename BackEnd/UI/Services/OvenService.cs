using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Grpc.Net.Client;
using GrpcService.Protos;
using Microsoft.AspNetCore.Components;
using static GrpcService.Protos.OvenProtoService;

namespace UI.Services
{
    public partial class OvenService
    {
        private GrpcChannel channel { get; set; }
        private OvenProtoServiceClient OvenProto { get; set; }

        public OvenService(string IP)
        {
            var addr = new Uri($"http://{IP}:5000");

            channel = GrpcChannel.ForAddress(addr);
            OvenProto = new OvenProtoServiceClient(channel);
        }

        public async Task<ProtoServiceConnection> DeviceConnect()
        {
            ProtoServiceConnection response = new ProtoServiceConnection();
            try
            {
                response = await OvenProto.DeviceConnectAsync(new Empty());                
                return response;
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"Connection Error : {ex.StatusCode}");
                return response;
            }
        }

        public Task<AsyncServerStreamingCall<ProtoOvenResponse>> MonitorDevice() => Task.Run(() => OvenProto.MonitorDevice(new Empty()));

        public async Task<ProtoOvenSetting> GetSetting()
        {
            ProtoOvenSetting response = new ProtoOvenSetting();

            await Task.Run(async () =>
            {
                response = await OvenProto.GetOvenSettingAsync(new Empty());
                response.AfbDelay = response.AfbDelay / 60;
            });

            return response;
        }

    }
}