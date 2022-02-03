using System.Threading.Tasks;
using GrpcService.Protos;

namespace GrpcService.Services
{
    public interface IOvenPlcService
    {
        Task ConnectDevice();
        Task<Temp> GetTempSensorAsync();
        Task<Coil> GetCoilSensorAsync();
        Task<mcStatus> GetMachineStatusAsync();
    }
}