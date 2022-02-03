using System.Threading.Tasks;
using GrpcService.Protos;

namespace GrpcService.Services
{
    public interface IOvenPlcService
    {
        Task<Temp> GetTempSensorAsync();
        Task<Coil> GetCoilSensor();
        Task<mcStatus> GetMachineStatus();
    }
}