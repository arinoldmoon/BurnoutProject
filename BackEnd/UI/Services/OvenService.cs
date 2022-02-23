
using System;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using Grpc.Core;
using Grpc.Net.Client;
using UI.Models;
using UI.Protos;
using static UI.Protos.OvenProto;

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

        public bool GrpcConnect()
        {
            try
            {
                var response = OvenProto.GrpcConnect(new Empty());
                GrpcIsConnected = response.Value;

                return GrpcIsConnected;
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"Connection Error : {ex.StatusCode}");
                return false;
            }
        }

        public bool PLCConnect()
        {
            try
            {
                var response = OvenProto.PLCConnect(new Empty());
                PLCIsConnected = response.Value;

                return PLCIsConnected;
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"Connection Error : {ex.StatusCode}");
                return false;
            }
        }

        public Task<MachineInfo> GetMachineInfo()
        {
            MachineInfo info = new MachineInfo();
            try
            {
                if (GrpcIsConnected)
                {
                    ProtoOvenInfo response = (OvenProto.GetOvenInfo(new Empty()));
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
                return Task.FromResult(new MachineInfo());
            }

            return Task.FromResult(info);
        }

        public async Task<AsyncServerStreamingCall<ProtoOvenResponse>> MonitorDevice()
        {
            try
            {
                if (PLCIsConnected)
                {
                    return await Task.FromResult(OvenProto.MonitorDevice(new Empty()));
                }
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"MonitorDevice Error {ex.StatusCode} : {ex.Message}");
                return null;
            }

            return null;
        }

        public async Task<MachineSetting> GetMachineSetting()
        {
            MachineSetting Setting = new MachineSetting();

            if (PLCIsConnected)
            {
                ProtoOvenSetting response = await OvenProto.GetOvenSettingAsync(new Empty());
                if (response != null)
                {
                    Setting.TubeStartTemp = response.TubeStartTemp;
                    Setting.FloorStartTemp = response.FloorStartTemp;
                    Setting.AfbStartTemp = response.AfbStartTemp;
                    Setting.AfbEndTemp = response.AfbEndTemp;
                    Setting.AfbDelay = response.AfbDelay;
                    Setting.AlarmOven = response.AlarmOven;
                    Setting.AlarmAfb = response.AlarmAfb;
                }
            }

            return Setting;
        }
    }
}