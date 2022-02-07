
using System;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Grpc.Net.Client;
using UI.Models;
using UI.Protos;
using static UI.Protos.OvenProto;
using static UI.Protos.PatternProto;

namespace UI.Services
{
    public class OvenService
    {
        private GrpcChannel channel { get; set; }
        public static OvenProtoClient OvenProto { get; set; }

        public static bool GrpcIsConnected = false;

        public static bool PLCIsConnected = false;

        public OvenService(string IP)
        {
            var addr = new Uri($"http://{IP}:5000");

            channel = GrpcChannel.ForAddress(addr);
            OvenProto = new OvenProtoClient(channel);
        }

        public async Task<bool> GrpcConnect()
        {
            try
            {
                var response = await OvenProto.GrpcConnectAsync(new Empty());

                GrpcIsConnected = response.Value;
                return GrpcIsConnected;
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"Connection Error : {ex.StatusCode}");
                return false;
            }
        }

        public async Task<bool> PLCConnect()
        {
            try
            {
                var response = await OvenProto.GrpcConnectAsync(new Empty());

                PLCIsConnected = response.Value;
                return PLCIsConnected;
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"Connection Error : {ex.StatusCode}");
                return false;
            }
        }

        public async Task<MachineInfo> GetMachineInfo()
        {
            MachineInfo info = new MachineInfo();
            try
            {
                if (GrpcIsConnected)
                {
                    ProtoOvenInfo response = (await OvenProto.GetOvenInfoAsync(new Empty()));
                    info.MachineModel = response.MachineModel;
                    info.MachineName = response.MachineName;
                    info.SerialNumber = response.SerialNumber;
                    info.WarrantyStart = response.WarrantyStart.ToDateTime();
                    info.WarrantyEnd = response.WarrantyEnd.ToDateTime();
                }
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"GetMachineInfo Error {ex.StatusCode} : {ex.Message}");
                return new MachineInfo(); ;
            }

            return info;
        }

        public async Task<AsyncServerStreamingCall<ProtoOvenResponse>> MonitorDevice()
        {
            try
            {
                if (!GrpcIsConnected)
                {
                    await GrpcConnect();
                }
                return OvenProto.MonitorDevice(new Empty());

            }
            catch (RpcException ex)
            {
                Console.WriteLine($"Error : {ex.StatusCode}");
                return null;
            }
        }
    }
}