using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using GrpcService.Protos;

namespace GrpcService.Services
{
    public interface IOvenPlcService
    {
        Task<bool> ConnectDevice();
        Task<Temp> GetTempSensorAsync();
        Task<Coil> GetCoilSensorAsync();
        Task<MachineStatus> GetMachineStatusAsync();
        Task<BoolValue> PushStopOperation();
        Task<BoolValue> PushStartOperation(ProtoPattern request);
        Task<ProtoPattern> GetCuerrentPattern();
        Task<ProtoOvenSetting> GetOvenSetting();
    }
}