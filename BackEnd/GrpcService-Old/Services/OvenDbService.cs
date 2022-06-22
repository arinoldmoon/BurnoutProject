using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Google.Protobuf.WellKnownTypes;
using GrpcService.Data;
using GrpcService.Models;
using GrpcService.Protos;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace GrpcService.Services
{
    public class OvenDbService : IOvenDbService
    {
        private readonly ILogger<OvenDbService> _logger;
        private readonly DataContext _Context;
        private readonly FactorConfig _factor;

        public OvenDbService(ILogger<OvenDbService> logger, DataContext Context, FactorConfig factor)
        {
            _logger = logger;
            _Context = Context;
            _factor = factor;
        }

        public async Task<MachineInfo> GetMachineInfo()
        {
            MachineInfo result = new MachineInfo();

            try
            {
                result = await _Context.MachineInfos.SingleAsync();
            }
            catch (SqliteException ex)
            {
                _logger.LogError("GetMachineInfo SqliteException Message: {0}", ex.Message);
            }

            return result;
        }

        public async Task<bool> UpdateMachineInfo(MachineInfo info)
        {
            bool IsSuccess = false;

            try
            {
                var result = await GetMachineInfo();
                _Context.Entry(result).CurrentValues.SetValues(info);

                IsSuccess = _Context.SaveChangesAsync().IsCompletedSuccessfully;
                _logger.LogInformation("UpdateMachineInfo  Status : {0}", IsSuccess);
            }
            catch (SqliteException ex)
            {
                _logger.LogError("UpdateMachineInfo SqliteException Message: {0}", ex.Message);
            }

            return IsSuccess;

        }

        public async Task<MachineSetting> GetMachineSetting()
        {
            MachineSetting result = new MachineSetting();
            try
            {
                result = await _Context.MachineSettings.SingleAsync();
            }
            catch (SqliteException ex)
            {
                _logger.LogError("GetMachineInfo SqliteException Message: {0}", ex.Message);
            }
            return result;
        }

        public async Task<bool> UpdateMachineSetting(MachineSetting setting)
        {
            bool IsSuccess = false;

            try
            {
                var result = await GetMachineSetting();
                _Context.Entry(result).CurrentValues.SetValues(setting);

                IsSuccess = _Context.SaveChangesAsync().IsCompletedSuccessfully;
                _logger.LogInformation("UpdateMachineSetting  Status : {0}", IsSuccess);
            }
            catch (SqliteException ex)
            {
                _logger.LogError("UpdateMachineSetting SqliteException Message: {0}", ex.Message);
            }

            return IsSuccess;
        }

        public async Task<List<Pattern>> GetPatternList()
        {
            List<Pattern> result = new List<Pattern>();

            try
            {
                result = await _Context.Patterns.Include(a => a.Airpump).Include(d => d.PatternItems).ToListAsync();
            }
            catch (SqliteException ex)
            {
                _logger.LogError("GetPatternList SqliteException Message: {0}", ex.Message);
            }

            return result;
        }

        public async Task<Pattern> GetPattern(int Number)
        {
            Pattern result = new Pattern();
            try
            {
                result = (await GetPatternList()).Find(x => x.PatternNumber == Number);
                result.PatternItems = result.PatternItems.OrderBy(x => x.Step).ToList();
            }
            catch (SqliteException ex)
            {
                _logger.LogError("GetPatternList SqliteException Message: {0}", ex.Message);
            }
            return result;
        }

        public async Task<bool> CreatePattern(Pattern pattern)
        {
            bool IsSuccess = false;
            string createdDate = DateTime.Now.ToUniversalTime().ToString("dd/MM/yyyy HH:mm");

            try
            {
                pattern.CreateDate = createdDate;
                await _Context.Patterns.AddAsync(pattern);

                IsSuccess = _Context.SaveChangesAsync().IsCompletedSuccessfully;
                _logger.LogInformation("CreatePattern  Status : {0}", IsSuccess);
            }
            catch (SqliteException ex)
            {
                _logger.LogError("CreatePattern SqliteException Message: {0}", ex.Message);
            }
            return IsSuccess;
        }

        public async Task<bool> UpdatePattern(Pattern newPattern)
        {
            bool IsSuccess = false;
            string modidyDate = DateTime.Now.ToUniversalTime().ToString("dd/MM/yyyy HH:mm");

            try
            {
                var result = await GetPattern(newPattern.PatternNumber);
                if (result != null)
                {
                    newPattern.ModifyDate = modidyDate;
                    _Context.Entry(result).CurrentValues.SetValues(newPattern);
                    _Context.Entry(result.Airpump).CurrentValues.SetValues(newPattern.Airpump);

                    // Delete PatternItems
                    foreach (var childDelete in result.PatternItems.ToList())
                    {
                        if (!newPattern.PatternItems.Any(x => x.Id == childDelete.Id))
                        {
                            _Context.PatternItems.Remove(childDelete);
                            _logger.LogInformation("Delete : {0}", childDelete.Id);
                        }
                    }

                    // Update or insert PatternItems
                    foreach (var childUpdate in newPattern.PatternItems)
                    {
                        if (childUpdate.Id != 0) //ID 0 = New ROW
                        {
                            var chk = result.PatternItems.Where(x => x.Id == childUpdate.Id).SingleOrDefault();
                            if (chk != null)
                            {
                                _Context.Entry(chk).CurrentValues.SetValues(childUpdate);
                                _logger.LogInformation("Update : {0}", childUpdate.Id);
                            }
                            else
                            {
                                result.PatternItems.Add(childUpdate);
                                _logger.LogInformation("Insert : {0} Step {1}", childUpdate.Id, childUpdate.Step);
                            }
                        }
                        else
                        {
                            result.PatternItems.Add(childUpdate);
                            _logger.LogInformation("Insert : {0} Step {1}", childUpdate.Id, childUpdate.Step);
                        }
                    }

                    IsSuccess = _Context.SaveChangesAsync().IsCompletedSuccessfully;
                    _logger.LogInformation("UpdatePattern  Status : {0}", modidyDate);
                }
            }
            catch (SqliteException ex)
            {
                _logger.LogError("UpdatePattern SqliteException Message: {0}", ex.Message);
            }
            return IsSuccess;
        }

        public async Task<bool> DeletePattern(int Number)
        {
            bool IsSuccess = false;
            try
            {
                var pattern = await GetPattern(Number);
                if (pattern != null)
                {
                    _Context.PatternItems.RemoveRange(pattern.PatternItems);
                    _Context.AirPumpSettings.Remove(pattern.Airpump);
                    _Context.Patterns.Remove(pattern);

                    IsSuccess = _Context.SaveChangesAsync().IsCompletedSuccessfully;
                    _logger.LogInformation("DeletePattern  Status : {0}", IsSuccess);
                }

                var chkListEmpty = await GetPatternList();
                if (chkListEmpty == null)
                {

                }
            }
            catch (SqliteException ex)
            {
                _logger.LogError("DeletePattern SqliteException Message: {0}", ex.Message);
            }
            return IsSuccess;
        }

        public async Task<int> ChkOperationLogID()
        {
            if (_Context.OperationLogs.Any())
            {
                return await _Context.OperationLogs.MaxAsync(x => x.LogID);
            }
            return 0;
        }

        public async Task<bool> OperationWriteLog(int logID)
        {
            bool IsSuccess = false;

            try
            {
                ActualLog actual = new ActualLog()
                {
                    TempTime = DateTimeOffset.UtcNow.ToTimestamp(),
                    TempValue = new Temp()
                    {
                        TempOven = WorkerService.tempResponse.TempOven,
                        TempAFB = WorkerService.tempResponse.TempAFB,
                        TempFloor = WorkerService.tempResponse.TempFloor,
                        TempTube = WorkerService.tempResponse.TempTube
                    }
                };

                MachineStatus status = new MachineStatus()
                {
                    Door = WorkerService.statusResponse.Door,
                    Operation = WorkerService.statusResponse.Operation,
                    PatternId = WorkerService.statusResponse.PatternId,
                    TotalStep = WorkerService.statusResponse.TotalStep,
                    CurrentStep = WorkerService.statusResponse.CurrentStep,
                    PatternStatus = WorkerService.statusResponse.PatternStatus,
                    RemainHours = WorkerService.statusResponse.RemainHours,
                    RemainMins = WorkerService.statusResponse.RemainMins
                };

                OperationLog log = new OperationLog()
                {
                    LogID = logID,
                    Door = Convert.ToInt32(status.Door),
                    PatternID = status.PatternId,
                    CurrentStep = status.CurrentStep,
                    TotalStep = status.TotalStep,
                    PatternStatus = status.PatternStatus.ToString(),
                    ActualTempOven = actual.TempValue.TempOven,
                    ActualTempAFB = actual.TempValue.TempAFB,
                    ActualTempFloor = actual.TempValue.TempFloor,
                    ActualTempTube = actual.TempValue.TempTube,
                    OperationTime = actual.TempTime.ToDateTime().ToString(_factor.DATE_FORMAT_STRING)
                };

                if (_Context.OperationLogs.Add(log).State == EntityState.Added)
                {
                    await _Context.SaveChangesAsync().ContinueWith(status =>
                    {
                        if (status.IsCompletedSuccessfully)
                        {
                            WorkerService.ActualLogList.Add(actual);
                            IsSuccess = true;
                        }
                    });
                }

            }
            catch (SqliteException ex)
            {
                _logger.LogInformation($"WriteLog : {ex.Message}");
            }

            return IsSuccess;
        }

        public async Task<ProtoOvenLog> GetOperationLog(int year, int month)
        {
            ProtoOvenLog response = new ProtoOvenLog();

            var result = _Context.OperationLogs.Select(x => new
            {
                Date = DateTime.ParseExact(x.OperationTime, _factor.DATE_FORMAT_STRING, null),
                x.LogID,
                x.PatternID,
                x.PatternStatus
            }).ToList();

            foreach (var item in result.DistinctBy(x => x.Date.Year).ToList())
            {
                response.YearList.Add(item.Date.Year);
            }

            foreach (var item in result.Where(x => x.Date.Year == year).DistinctBy(x => x.Date.Month).ToList())
            {
                response.MonthList.Add(item.Date.Month);
            }

            foreach (var item in result.Where(x => x.Date.Year == year && x.Date.Month == month).GroupBy(x => x.LogID))
            {
                response.LogList.Add(new ProtoOvenLogList()
                {
                    LogID = item.First().LogID,
                    PatternID = item.First().PatternID,
                    StartLog = DateTime.SpecifyKind(item.First().Date, DateTimeKind.Utc).ToTimestamp(),
                    EndLog = DateTime.SpecifyKind(item.Last().Date, DateTimeKind.Utc).ToTimestamp()
                });
            }

            await Task.CompletedTask;
            return response;
        }

        public async Task<List<OperationLog>> GetOperationLogByID(int LogID) => await _Context.OperationLogs.Where(x => x.LogID == LogID).ToListAsync();
    }
}