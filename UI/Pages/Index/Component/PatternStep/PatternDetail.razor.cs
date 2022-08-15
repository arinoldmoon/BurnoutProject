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
        public PatternModel? _patternModel { get; set; }

        [Inject]
        protected DialogService? _dialogService { get; set; }

        [Inject]
        protected NotificationService? _notificationService { get; set; }

        [Inject]
        protected GlobalService? _globals { get; set; }

        [Inject]
        protected PatternService? _patternService { get; set; }

        [Inject]
        protected ModelConvertor? _convert { get; set; }

        protected RadzenDataGrid<PatternDetailModel>? patternGrid { get; set; }
        protected PatternDetailModel? orderToInsert { get; set; }

        protected bool btnDisable { get; set; } = true;

        protected override async Task OnInitializedAsync()
        {
            if (_patternModel == null)
            {
                _patternModel = new PatternModel();
                _patternModel.PatternId = 99;
                _patternModel.AirPump = new AirpumpModel()
                {
                    StartTemp = 150,
                    EndTemp = 700,
                    DelayMinuteDuration = 30,
                    UseAirpump = true
                };
            }
            await btnCheck();
        }

        private async Task btnCheck() => btnDisable = await Task.FromResult(!(!string.IsNullOrEmpty(_patternModel!.PatternName) && _patternModel.PatternDetail.Any()));

        protected async Task TextBoxChanged() => await btnCheck();

        protected async void OnSubmit(PatternModel model)
        {
            if (!string.IsNullOrEmpty(model.PatternName) && model.PatternDetail.Any())
            {               
                ProtoPattern _protoPattern = _convert!.ConvertPatternModelToProtoPattern(model);
                BoolValue result = new BoolValue() { Value = false };
                int PatternID = 0;

                if (_protoPattern.PatternId == 99)
                {
                     PatternID = ((await _patternService!.GetPatternListAsync()).Max(x => (int?)x.PatternId) ?? 0) + 1;
                     Console.WriteLine(PatternID);
                    _protoPattern.PatternId = PatternID;
                    _protoPattern.AirPump.Id = PatternID;
                    foreach (var pid in _protoPattern.PatternDetail)
                    {
                        pid.PatternId = PatternID;
                    }
                    result = await _patternService!.CreatePattern(_protoPattern);

                    _protoPattern.StepCount = _protoPattern.PatternDetail.Count;
                    _protoPattern.TotalTime = TimeSpan.FromSeconds(_protoPattern.PatternDetail.Sum(x => x.StepDuration.Seconds)).ToDuration();
                }
                else
                {
                    PatternID = model.PatternId;
                    result = await _patternService!.UpdatePattern(_protoPattern);
                }                

                if (result.Value)
                {                    
                    _globals!.GlobalPattern = await _patternService.GetPatternByID(PatternID);
                    _globals.SetPoint = _protoPattern!.PatternDetail.ToList();

                    _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"Update Pattern", Detail = $"Success" });
                }
                else
                {
                    _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = $"Update Pattern", Detail = $"Not Success" });
                }

                _dialogService!.Close(null);
            }
            else
            {
                _notificationService!.Notify(NotificationSeverity.Error, "Please Add Step");
            }
        }

        protected void Next(MouseEventArgs args)
        {
            ProtoPattern _protoPattern = _convert!.ConvertPatternModelToProtoPattern(_patternModel!);

            _globals!.GlobalPattern = _protoPattern;
            _globals.SetPoint = _protoPattern.PatternDetail.ToList();
            _dialogService!.Close(null);
        }

        protected async Task DeleteRow(PatternDetailModel order)
        {
            if (order == orderToInsert)
            {
                orderToInsert = null;
            }

            if (_patternModel!.PatternDetail.Contains(order))
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
            orderToInsert.Step = _patternModel!.PatternDetail.Count() + 1;

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
            _patternModel!.PatternDetail.Add(order);
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
            var oData = _patternModel!.PatternDetail.AsQueryable();
            _patternModel.PatternDetail = oData.OrderBy(x => x.Step).ToList();
        }
    }
}