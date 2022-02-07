using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using GrpcService.Data;
using GrpcService.Models;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace GrpcService.Services
{
    public class OvenDbService : IOvenDbService
    {
        private readonly ILogger<OvenDbService> _logger;
        private readonly DataContext _Context;

        public OvenDbService(ILogger<OvenDbService> logger, DataContext Context)
        {
            _logger = logger;
            _Context = Context;
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
            string createdDate = DateTime.Now.ToUniversalTime().ToString();

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
            string modidyDate = DateTime.Now.ToUniversalTime().ToString();

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
    }
}