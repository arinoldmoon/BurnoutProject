using GrpcService.Protos;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Radzen;
using Radzen.Blazor;
using UI.Models;
using UI.Pages.Index.Component.PatternStep;
using UI.Services;

namespace UI.Pages.Index.Component.Controller
{
    public partial class OperationStateComponent : ComponentBase
    {
        [Inject]
        protected GlobalService? _globals { get; set; }

        [Inject]
        protected OvenService? _ovenService { get; set; }

        [Inject]
        protected OperationService? _operationService { get; set; }

        [Inject]
        protected DialogService? _dialogServices { get; set; }

        [Inject]
        protected NotificationService? _notificationService { get; set; }

        [Inject]
        protected ModelConvertor? _convert { get; set; }


        protected PatternModel? SelectedPattern;

        private IList<PatternDetailModel>? _currentPattern;
        protected IList<PatternDetailModel>? CurrentPattern
        {
            get { return _currentPattern; }
            set
            {
                if (!object.Equals(_currentPattern, value))
                {
                    _currentPattern = value;
                }
            }
        }

        protected RadzenDataGrid<PatternDetailModel>? OvenStepGrid;
        protected ProtoOvenSetting? Setting;
        protected bool DisableChangeMode = true;
        protected bool ManualMode;
        protected bool startBtnBusy = false;
        protected bool stopBtnBusy = false;
        protected int ManualTemp;

        protected void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "GlobalMonitor")
            {
                CurrentPattern = SelectedPattern!.PatternDetail.Where(x => x.Step == _globals!.GlobalMonitor.Status.CurrentStep).ToList();
                DisableChangeMode = !object.Equals(_globals!.GlobalMonitor.Status.CurrentStep, SelectedPattern!.PatternDetail.Last().Step);
            }
        }

        protected override async Task OnInitializedAsync()
        {
            _globals!.PropertyChanged += OnPropertyChanged;
            SelectedPattern = _convert!.ConvertProtoPatternToPatternModel(_globals!.GlobalPattern);
            CurrentPattern = SelectedPattern!.PatternDetail.Where(x => x.Step == _globals.GlobalMonitor.Status.CurrentStep).ToList();
            Setting = await _ovenService!.GetSetting();
            if (_globals.PlcConnected)
            {
                ManualTemp = Setting.ManualTemp.Temp;
                ManualMode = Setting.ManualTemp.Use;
                DisableChangeMode = !object.Equals(_globals!.GlobalMonitor.Status.CurrentStep, SelectedPattern!.PatternDetail.Last().Step);
            }
            // Console.WriteLine(SelectedPattern.PatternDetail.Where(x => x.Step == 2).FirstOrDefault()!.StepDuration.ToString());
        }

        protected async Task EditProgramClick(MouseEventArgs args) => await _dialogServices!.OpenAsync<PatternDetail>("Edit Program", new Dictionary<string, object> { { "_patternModel", SelectedPattern! } });

        protected async Task CancelProgram(MouseEventArgs args)
        {
            _globals!.GlobalPattern = new ProtoPattern()
            {
                AirPump = new ProtoAirpump()
            };
            _globals.SetPoint = new List<ProtoPatternDetail>();

            await Task.CompletedTask;
        }

        protected async Task StartOperation(MouseEventArgs args)
        {
            startBtnBusy = true;
            await Task.Run(() =>
            {
                var result = _operationService!.StartOpration(_globals!.GlobalPattern).Result.Value;
                Console.WriteLine(result);
                if (result)
                {
                    _globals.GlobalMonitor.Status.Operation = result;
                    _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = "Operation : ", Detail = "Started" });
                }
                else
                {
                    _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = "Operation : ", Detail = "Not Start" });
                }
            });                    
        }

        protected async Task StopOperation(MouseEventArgs args)
        {
            stopBtnBusy = true;
            await Task.Run(async () =>
            {
                if (await _dialogServices!.Confirm("Are you sure you want to cancel this operation?") == true)
                {
                    var response = await _operationService!.StopOpration();
                    if (response.Value)
                    {
                        _globals!.SetPoint = new List<ProtoPatternDetail>();
                        _globals.ActualPoint = new List<TempActualLog>();
                        _globals.GlobalPattern = new ProtoPattern()
                        {
                            AirPump = new ProtoAirpump()
                        };
                        _globals.GlobalPattern.PatternId = 0;

                        _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = "Operation", Detail = "Stoped" });
                    }
                    else
                    {
                        _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = "Operation", Detail = "Error" });
                    }
                }
            });
            stopBtnBusy = false;
        }

        protected async Task ChangeMode(bool value)
        {
            await Task.Run(async () =>
            {
                if (await _dialogServices!.Confirm("Are you sure you want to change mode?") == true)
                {
                    if (_operationService!.ManualTemp(new ProtoManualTemp() { Use = ManualMode, Temp = ManualTemp }).Result.Value)
                    {
                        _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = "Change to mode", Detail = "Changed" });
                    }
                }
                else
                {
                    ManualMode = !value;
                }
            });
        }

        protected async Task SetManualTemp()
        {
            await Task.Run(async () =>
            {
                if (await _dialogServices!.Confirm("Are you sure you want to change set value temp?") == true)
                {
                    Console.WriteLine($"Use = {ManualMode} Temp =  {ManualTemp}");
                    var response = await _operationService!.ManualTemp(new ProtoManualTemp() { Use = ManualMode, Temp = ManualTemp });
                    if (response.Value)
                    {
                        _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"OvenTemp", Detail = $"Changed" });
                    }
                    else
                    {
                        _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"SetOvenTemp", Detail = $"Error" });
                    }
                }
            });
        }
    }
}