using System.Collections.Generic;
using System.Threading.Tasks;
using GrpcService.Models;
using GrpcService.Protos;

namespace GrpcService.Services
{
    public interface IOvenDbService
    {
        Task<MachineInfo> GetMachineInfo();
        Task<bool> UpdateMachineInfo(MachineInfo info);
        Task<MachineSetting> GetMachineSetting();
        Task<bool> UpdateMachineSetting(MachineSetting setting);
        Task<List<Pattern>> GetPatternList();
        Task<Pattern> GetPattern(int Number);
        Task<bool> CreatePattern(Pattern pattern);
        Task<bool> UpdatePattern(Pattern pattern);
        Task<bool> DeletePattern(int Number);
        Task<int> ChkOperationLogID();
        Task<bool> OperationWriteLog(int ID);
        Task<ProtoOvenLog> GetOperationLog(int year, int month);
        Task<List<OperationLog>> GetOperationLogByID(int LogID);
    }
}