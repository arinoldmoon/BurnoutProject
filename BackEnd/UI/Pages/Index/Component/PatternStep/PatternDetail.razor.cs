using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Radzen;
using Radzen.Blazor;
using Google.Protobuf.WellKnownTypes;
using UI.Services;
using UI.Models;
using GrpcService.Protos;

namespace UI.Pages.Index.Component.PatternStep
{
    public partial class PatternDetailComponent : ComponentBase
    {
        [Parameter]
        public ProtoPattern? _patternParam { get; set; }

        [Inject]
        protected DialogService? _dialogService { get; set; }

        [Inject]
        protected NotificationService? _notificationService { get; set; }

        [Inject]
        protected GlobalService? _globals { get; set; }

        [Inject]
        protected PatternService? _patternService { get; set; }

        protected RadzenDataGrid<PatternDetailModel>? patternGrid { get; set; }
        protected PatternDetailModel? orderToInsert { get; set; }
        protected PatternModel _patternModel { get; set; } = new PatternModel();
        protected bool btnDisable { get; set; } = true;

        protected override void OnInitialized()
        {
            if (_patternParam != null)
            {
                _patternModel = new PatternModel()
                {
                    PatternId = _patternParam.PatternId,
                    PatternName = _patternParam.PatternName,
                    AirPump = new AirpumpModel()
                    {
                        StartTemp = _patternParam.AirPump.StartTemp,
                        EndTemp = _patternParam.AirPump.EndTemp,
                        DelayMinuteDuration = _patternParam.AirPump.DelayMinuteDuration.ToTimeSpan().TotalMinutes,
                        UseAirpump = _patternParam.AirPump.UseAirpump
                    }
                };

                foreach (var item in _patternParam.PatternDetail)
                {
                    _patternModel.PatternDetail.Add(new PatternDetailModel()
                    {
                        DetailId = item.DetailId,
                        PatternId = item.PatternId,
                        Step = item.Step,
                        Temp = item.Temp,
                        StepDuration = item.StepDuration.ToTimeSpan().TotalMinutes
                    });
                }
            }
            else
            {
                _patternModel = new PatternModel();
                _patternModel.PatternId = 99;
                _patternModel.AirPump.StartTemp = 150;
                _patternModel.AirPump.EndTemp = 700;
                _patternModel.AirPump.DelayMinuteDuration = 30;
                _patternModel.AirPump.UseAirpump = true;
                _patternModel.PatternDetail = new List<PatternDetailModel>();

                _patternParam = new ProtoPattern();
            }
        }

        protected async Task TextBoxChanged() => btnDisable = await Task.FromResult(!(!string.IsNullOrEmpty(_patternModel.PatternName) && _patternModel.PatternDetail.Any()));

        protected void OnSubmit(PatternModel model)
        {
            if (!string.IsNullOrEmpty(model.PatternName) && model.PatternDetail.Any())
            {
                
                // if (_patternParam.PatternId == 99)
                // {
                //     status = (await _patternService.CreatePattern(_patternParam)).Value;
                //     _patternParam.PatternId = (await _patternService.GetPatternListAsync()).Max(x => x.PatternId);
                //     _patternParam.StepCount = _patternParam.PatternDetail.Count;
                //     _patternParam.TotalTime = TimeSpan.FromSeconds(_patternParam.PatternDetail.Sum(x => x.StepDuration.Seconds)).ToDuration();
                // }
                // else
                // {
                //     status = (await _patternService.UpdatePattern(_patternParam)).Value;
                // }

                // if (status)
                // {
                //     _globals.GlobalPattern = new ProtoPattern();
                //     _globals.GlobalPattern.PatternDetail.Clear();

                //     _globals.GlobalPattern = await _patternService.GetPatternByID(_patternParam.PatternId);
                //     _notificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"Update Pattern", Detail = $"Success" });
                // }
                // else
                // {
                //     _notificationService.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = $"Update Pattern", Detail = $"Not Success" });
                // }

                // _globals.SetPoint = _patternParam.PatternDetail.ToList();
                _dialogService!.Close(null);
            }
            else
            {
                _notificationService!.Notify(NotificationSeverity.Error, "Please Add Step");
            }
        }

        protected void Next(MouseEventArgs args)
        {
            _patternParam!.PatternId = 99;
            _patternParam.StepCount = _patternModel.PatternDetail.Count;
            _patternParam.TotalTime = TimeSpan.FromMinutes(_patternModel.PatternDetail.Sum(x => x.StepDuration)).ToDuration();
            _globals!.GlobalPattern = _patternParam;

            foreach (var item in _patternModel.PatternDetail)
            {
                _patternParam.PatternDetail.Add(new ProtoPatternDetail()
                {
                    DetailId = item.DetailId,
                    PatternId = item.PatternId,
                    Step = item.Step,
                    Temp = item.Temp,
                    StepDuration = TimeSpan.FromMinutes(item.StepDuration).ToDuration()
                });
            }           
            
            _globals.SetPoint = _patternParam.PatternDetail.ToList();
            _dialogService!.Close(null);
        }

        protected async Task DeleteRow(PatternDetailModel order)
        {
            if (order == orderToInsert)
            {
                orderToInsert = null;
            }

            if (_patternModel.PatternDetail.Contains(order))
            {
                _patternModel.PatternDetail.Remove(order);

                await patternGrid!.Reload();
                btnDisable = !(!string.IsNullOrEmpty(_patternModel.PatternName) && _patternModel.PatternDetail.Any());
            }
            else
            {
                Console.WriteLine("CancelEditRow");
                patternGrid!.CancelEditRow(order);
            }
        }

        protected async Task InsertRow()
        {
            orderToInsert = new PatternDetailModel();
            orderToInsert.Step = _patternModel.PatternDetail.Count() + 1;

            await patternGrid!.InsertRow(orderToInsert);
        }

        protected void OnUpdateRow(PatternDetailModel order)
        {
            if (order == orderToInsert)
            {
                orderToInsert = null;
            }
        }

        protected void OnCreateRow(PatternDetailModel order)
        {
            _patternModel.PatternDetail.Add(order);
            _patternModel.PatternDetail = _patternModel.PatternDetail.OrderBy(x => x.Step).ToList();

            btnDisable = !(!string.IsNullOrEmpty(_patternModel.PatternName) && _patternModel.PatternDetail.Any());
        }

        protected async Task EditRow(PatternDetailModel patternDetail) => await patternGrid!.EditRow(patternDetail);

        protected async Task SaveRow(PatternDetailModel patternDetail)
        {
            if (patternDetail == orderToInsert)
            {
                orderToInsert = null;
            }

            await patternGrid!.UpdateRow(patternDetail);
        }

        protected void CancelEdit(PatternDetailModel patternDetail)
        {
            if (patternDetail == orderToInsert)
            {
                orderToInsert = null;
            }

            patternGrid!.CancelEditRow(patternDetail);
        }

        protected void LoadData(LoadDataArgs args)
        {
            var oData = _patternModel.PatternDetail.AsQueryable();
            _patternModel.PatternDetail = oData.OrderBy(x => x.Step).ToList();
        }

    }
}