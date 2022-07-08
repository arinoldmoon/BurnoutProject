
using System;
using System.Collections.Generic;
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

        public async Task<MachineInfo> GetMachineInfo()
        {
            MachineInfo info = new MachineInfo();
            info.LogHeader = new OvenLogHeader();
            info.LogHeader.YearList = new List<int>();
            info.LogHeader.MonthList = new List<int>();
            info.LogHeader.LogList = new List<OvenLogList>();

            try
            {
                if (GrpcIsConnected)
                {
                    ProtoOvenInfo response = await OvenProto.GetOvenInfoAsync(new Empty());
                    info.MachineModel = response.MachineModel;
                    info.MachineName = response.MachineName;
                    info.SerialNumber = response.SerialNumber;
                    info.WarrantyStart = response.WarrantyStart.ToDateTime();
                    info.WarrantyEnd = response.WarrantyEnd.ToDateTime();

                    foreach (var item in response.OvenLog.YearList)
                    {
                        info.LogHeader.YearList.Add(item);
                    }

                    foreach (var item in response.OvenLog.MonthList)
                    {
                        info.LogHeader.MonthList.Add(item);
                    }

                    foreach (var item in response.OvenLog.LogList)
                    {
                        info.LogHeader.LogList.Add(new OvenLogList()
                        {
                            LogID = item.LogID,
                            PatternID = item.PatternID,
                            StartLog = item.StartLog.ToDateTime().ToLocalTime(),
                            EndLog = item.EndLog.ToDateTime().ToLocalTime()
                        });
                    }
                }
            }
            catch (RpcException ex)
            {
                Console.WriteLine($"GetMachineInfo Error {ex.StatusCode} : {ex.Message}");
                return info;
            }

            return info;
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
                    Setting.AfbDelay = (int)TimeSpan.FromSeconds(response.AfbDelay).TotalMinutes;
                    Setting.AlarmOven = response.AlarmOven;
                    Setting.AlarmAfb = response.AlarmAfb;
                }
            }

            return Setting;
        }

        
    }
}