using Google.Protobuf.WellKnownTypes;
using GrpcService.Database;
using GrpcService.Models;
using GrpcService.Models.SQLite;
using GrpcService.Protos;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;

namespace GrpcService.Services
{
    public interface IDbService
    {
        Task<ProtoOvenInfo> GetMachineInfo();
        Task<ProtoOperationLogInfo> GetOperationLogInfo();
        Task<ProtoOperationLogInfo> GetOperationLogWithFilter(int year, int month);

        Task<long> GetLastLogID();
        Task<ProtoPatternList> GetPatternList();
        Task<Pattern> GetPattern(Int32Value Number);

        bool OperationWriteLog(int logID);
        Task<BoolValue> CreatePattern(ProtoPattern pattern);
        Task<BoolValue> UpdatePattern(ProtoPattern newPattern);
        Task<BoolValue> DeletePattern(Int32Value PatternId);

        Task<List<OperationLog>> GetOperationLogByID(int LogID);
    }

    public class DbService : IDbService
    {

        private readonly SQLiteContext _context;
        private readonly SystemConfig _sysConfig;
        private readonly ResponseModel _response;
        private readonly ModelConvertor _convert;

        public DbService(SQLiteContext Context, SystemConfig sysConfig, ResponseModel response, ModelConvertor convert)
        {
            _context = Context;
            _sysConfig = sysConfig;
            _response = response;
            _convert = convert;
        }

        public async Task<ProtoOvenInfo> GetMachineInfo()
        {
            ProtoOvenInfo response = new ProtoOvenInfo();

            await Task.Run(async () =>
            {
                try
                {
                    MachineInfo result = await _context.MachineInfos.SingleAsync();
                    if (result != null)
                    {
                        response.MachineName = result.MachineName;
                        response.MachineModel = (int)result.MachineModel;
                        response.SerialNumber = (int)result.SerialNumber;
                        response.WarrantyStart = new Timestamp() { Seconds = result.WarrantyStart };
                        response.WarrantyEnd = new Timestamp() { Seconds = result.WarrantyEnd };
                    }
                }
                catch (Exception ex)
                {
                    _sysConfig.WriteLogFile($"GetMachineInfo Error : {ex.Message}");
                }
            });

            return response;
        }

        public async Task<ProtoOperationLogInfo> GetOperationLogInfo()
        {
            ProtoOperationLogInfo response = new ProtoOperationLogInfo();

            await Task.Run(async () =>
            {
                try
                {
                    response.YearList.AddRange((await _context.OperationLogs.Select(x => DateTime.ParseExact(x.OperationTime!, _sysConfig.DATE_FORMAT_STRING, null).Year).ToListAsync()).Distinct());
                    response.MonthList.AddRange((await _context.OperationLogs.Select(x => DateTime.ParseExact(x.OperationTime!, _sysConfig.DATE_FORMAT_STRING, null).Month).ToListAsync()).Distinct());

                    var LogList = (await _context.OperationLogs.ToListAsync())
                    .Where(x =>
                        DateTime.ParseExact(x.OperationTime!, _sysConfig.DATE_FORMAT_STRING, null).Year == response.YearList.Last() &&
                        DateTime.ParseExact(x.OperationTime!, _sysConfig.DATE_FORMAT_STRING, null).Month == response.MonthList.Last())
                    .GroupBy(x => x.LogId);

                    foreach (var item in LogList)
                    {
                        response.LogList.Add(new ProtoOvenLogList()
                        {
                            LogID = Convert.ToInt32(item.First().LogId),
                            PatternID = Convert.ToInt32(item.First().PatternId!),
                            StartLog = DateTime.SpecifyKind(DateTime.ParseExact(item.First().OperationTime!, _sysConfig.DATE_FORMAT_STRING, null), DateTimeKind.Utc).ToTimestamp(),
                            EndLog = DateTime.SpecifyKind(DateTime.ParseExact(item.Last().OperationTime!, _sysConfig.DATE_FORMAT_STRING, null), DateTimeKind.Utc).ToTimestamp(),
                        });
                    }
                }
                catch (Exception ex)
                {
                    _sysConfig.WriteLogFile($"GetOperationLogInfo Error : {ex.Message}");
                }
            });

            return response;
        }

        public async Task<ProtoOperationLogInfo> GetOperationLogWithFilter(int year, int month)
        {
            ProtoOperationLogInfo response = new ProtoOperationLogInfo();

            await Task.Run(async () =>
            {
                try
                {
                    var LogList = (await _context.OperationLogs.ToListAsync())
                .Where(x =>
                    DateTime.ParseExact(x.OperationTime!, _sysConfig.DATE_FORMAT_STRING, null).Year == year &&
                    DateTime.ParseExact(x.OperationTime!, _sysConfig.DATE_FORMAT_STRING, null).Month == month)
                .GroupBy(x => x.LogId);

                    foreach (var item in LogList)
                    {
                        response.LogList.Add(new ProtoOvenLogList()
                        {
                            LogID = Convert.ToInt32(item.First().LogId),
                            PatternID = Convert.ToInt32(item.First().PatternId!),
                            StartLog = DateTime.SpecifyKind(DateTime.ParseExact(item.First().OperationTime!, _sysConfig.DATE_FORMAT_STRING, null), DateTimeKind.Utc).ToTimestamp(),
                            EndLog = DateTime.SpecifyKind(DateTime.ParseExact(item.Last().OperationTime!, _sysConfig.DATE_FORMAT_STRING, null), DateTimeKind.Utc).ToTimestamp(),
                        });
                    }
                }
                catch (Exception ex)
                {
                    _sysConfig.WriteLogFile($"GetOperationLogWithFilter Error : {ex.Message}");
                }

            });

            return response;
        }

        public async Task<List<OperationLog>> GetOperationLogByID(int LogID) => await _context.OperationLogs.Where(x => x.LogId == LogID).ToListAsync();

        public async Task<long> GetLastLogID() => await _context.OperationLogs.MaxAsync(x => x.LogId);

        public async Task<ProtoPatternList> GetPatternList()
        {
            ProtoPatternList response = new ProtoPatternList();

            await Task.Run(async () =>
            {
                try
                {
                    List<Pattern> result = await _context.Patterns.Include(x => x.Airpump).Include(x => x.PatternItems).ToListAsync();
                    if (result.Any())
                    {
                        foreach (var item in result)
                        {
                            ProtoPattern Pattern = new ProtoPattern()
                            {
                                PatternId = (int)item.PatternNumber,
                                PatternName = item.PatternName,
                                StepCount = item.PatternItems.Count,
                                TotalTime = TimeSpan.FromMinutes(item.PatternItems.Sum(x => x.StepDuration)).ToDuration(),
                                CreateDate = string.IsNullOrEmpty(item.CreateDate) ? null : DateTime.SpecifyKind(DateTime.ParseExact(item.CreateDate.ToString(), _sysConfig.DATE_FORMAT_STRING, null), DateTimeKind.Utc).ToTimestamp(),
                                ModifyDate = string.IsNullOrEmpty(item.ModifyDate) ? null : DateTime.SpecifyKind(DateTime.ParseExact(item.ModifyDate.ToString(), _sysConfig.DATE_FORMAT_STRING, null), DateTimeKind.Utc).ToTimestamp(),
                            };
                            response.Pattern.Add(Pattern);
                        }
                    }
                }
                catch (Exception ex)
                {
                    _sysConfig.WriteLogFile($"GetPatternList Error : {ex.Message}");
                }
            });

            return response;
        }

        public async Task<Pattern> GetPattern(Int32Value Id)
        {
            Pattern response = new Pattern();
            await Task.Run(async () =>
            {
                try
                {
                    response = await _context.Patterns.Include(x => x.Airpump).Include(x => x.PatternItems).Where(x => x.PatternNumber == Id.Value).SingleAsync();
                    _sysConfig.WriteLogFile($"GetPatternFromDB By ID : {Id.Value}");
                }
                catch (Exception ex)
                {
                    _sysConfig.WriteLogFile($"GetPatternList Error : {ex.Message}");
                }

            });

            return response;
        }

        public bool OperationWriteLog(int logID)
        {
            bool IsSuccess = false;

            try
            {
                ActualLog actual = new ActualLog()
                {
                    TempTime = DateTime.UtcNow.ToTimestamp(),
                    TempValue = new Temp()
                    {
                        TempOven = _response.tempResponse!.TempOven,
                        TempAFB = _response.tempResponse.TempAFB,
                        TempFloor = _response.tempResponse.TempFloor,
                        TempTube = _response.tempResponse.TempTube
                    }
                };

                OperationLog log = new OperationLog()
                {
                    LogId = logID,
                    Door = Convert.ToInt32(_response.statusResponse!.Door),
                    PatternId = _response.statusResponse.PatternId,
                    CurrentStep = _response.statusResponse.CurrentStep,
                    TotalStep = _response.statusResponse.TotalStep,
                    PatternStatus = _response.statusResponse.PatternStatus.ToString(),
                    ActualTempOven = actual.TempValue.TempOven,
                    ActualTempAfb = actual.TempValue.TempAFB,
                    ActualTempFloor = actual.TempValue.TempFloor,
                    ActualTempTube = actual.TempValue.TempTube,
                    OperationTime = actual.TempTime.ToDateTime().ToString(_sysConfig.DATE_FORMAT_STRING)
                };

                _context.OperationLogs.AddAsync(log);
                _context.SaveChangesAsync();

                _response.statusResponse.TempLogList.TempLog.Add(actual);
                IsSuccess = true;


            }
            catch (SqliteException ex)
            {
                _sysConfig.WriteLogFile($"OperationWriteLog Error : {ex.Message}");
            }

            return IsSuccess;
        }

        public async Task<BoolValue> CreatePattern(ProtoPattern pattern)
        {
            BoolValue IsSuccess = new BoolValue() { Value = false };
            try
            {
                await Task.Run(async () =>
                {
                    Pattern result = _convert.ConvertProtoPatternToPatternModel(pattern);
                    long MaxID = await _context.Patterns.MaxAsync(x => x.PatternNumber) + 1;
                    result.PatternNumber = MaxID;
                    result.Airpump!.Id = MaxID;
                    result.CreateDate = DateTime.UtcNow.ToString(_sysConfig.DATE_FORMAT_STRING);
                    await _context.Patterns.AddAsync(result);

                    IsSuccess.Value = _context.SaveChangesAsync().IsCompletedSuccessfully;

                    _sysConfig.WriteLogFile($"CreatePattern ID : {MaxID}");
                });
            }
            catch (Exception ex)
            {
                _sysConfig.WriteLogFile($"CreatePattern Error : {ex.Message}");
            }
            return IsSuccess;
        }

        public async Task<BoolValue> UpdatePattern(ProtoPattern pattern)
        {
            BoolValue IsSuccess = new BoolValue() { Value = false };
            try
            {
                await Task.Run(() =>
                {
                    Pattern odata = _convert.ConvertProtoPatternToPatternModel(pattern);
                    Pattern update = GetPattern(new Int32Value() { Value = pattern.PatternId }).Result;

                    odata.ModifyDate = DateTime.UtcNow.ToString(_sysConfig.DATE_FORMAT_STRING);
                    _context.Entry(update).CurrentValues.SetValues(odata);
                    _context.Entry(update.Airpump!).CurrentValues.SetValues(odata.Airpump!);

                    foreach (var childDelete in update.PatternItems.ToList())
                    {
                        if (!odata.PatternItems.Any(x => x.Id == childDelete.Id))
                        {
                            _context.PatternItems.Remove(childDelete);
                        }
                    }

                    foreach (var childUpdate in odata.PatternItems.ToList())
                    {
                        if (childUpdate.Id != 0)
                        {
                            PatternItem? chk = update.PatternItems.Where(x => x.Id == childUpdate.Id).SingleOrDefault();
                            if (chk != null)
                            {
                                _context.Entry(chk).CurrentValues.SetValues(childUpdate);
                            }
                            else
                            {
                                update.PatternItems.Add(childUpdate);
                            }
                        }
                        else
                        {
                            update.PatternItems.Add(childUpdate);
                        }
                    }

                    IsSuccess.Value = _context.SaveChangesAsync().IsCompletedSuccessfully;

                    _sysConfig.WriteLogFile($"UpdatePattern ID : {odata.PatternNumber} Status : {IsSuccess.Value}");
                });

            }
            catch (Exception ex)
            {
                _sysConfig.WriteLogFile($"UpdatePattern Error : {ex.Message}");
            }

            return IsSuccess;
        }

        public async Task<BoolValue> DeletePattern(Int32Value PatternId)
        {
            BoolValue IsSuccess = new BoolValue() { Value = false };
            try
            {
                await Task.Run(async () =>
                {
                    Pattern result = await _context.Patterns.SingleAsync(x => x.PatternNumber == PatternId.Value);
                    if (result != null)
                    {
                        _context.PatternItems.RemoveRange(result.PatternItems);
                        _context.AirPumpSettings.Remove(result.Airpump!);
                        _context.Patterns.Remove(result);

                        IsSuccess.Value = _context.SaveChangesAsync().IsCompletedSuccessfully;
                        _sysConfig.WriteLogFile($"DeletePattern ID : {PatternId.Value} | Status : {IsSuccess}");
                    }
                });
            }
            catch (Exception ex)
            {
                _sysConfig.WriteLogFile($"DeletePattern Error : {ex.Message}");
            }
            return IsSuccess;
        }


    }
}