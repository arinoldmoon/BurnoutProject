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


        public PatternModel? SelectedPattern;

        public RadzenDataGrid<PatternDetailModel>? OvenStepGrid;

        public IList<PatternDetailModel>? CurrentPattern;

        public ProtoOvenSetting? Setting;

        private void Reload()
        {
            InvokeAsync(StateHasChanged);
        }

        protected void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "GlobalMonitor")
            {
                Reload();
                Console.WriteLine("GlobalMonitor Update");
            }
        }

        protected override async Task OnInitializedAsync()
        {
            _globals!.PropertyChanged += OnPropertyChanged;
            SelectedPattern = _convert!.ConvertProtoPatternToPatternModel(_globals!.GlobalPattern);
            Setting = await _ovenService!.GetSetting();
        }

        public async Task EditProgramClick(MouseEventArgs args) => await _dialogServices!.OpenAsync<PatternDetail>("Edit Program", new Dictionary<string, object> { { "_patternModel", SelectedPattern! } });

        public async Task CancelProgram(MouseEventArgs args)
        {
            _globals!.GlobalPattern = new ProtoPattern()
            {
                AirPump = new ProtoAirpump()
            };
            _globals.SetPoint = new List<ProtoPatternDetail>();

            await Task.CompletedTask;
        }

        public async Task StartOperation(MouseEventArgs args)
        {
            await Task.Run(async () => await _operationService!.StartOpration(_globals!.GlobalPattern)).ContinueWith((res) =>
            {
                if (res.Result.Value)
                {
                    Reload();
                    _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"Operation : ", Detail = $"Started" });
                }
                else
                {
                    _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Error, Summary = "Operation : ", Detail = "Not Start" });
                }
            });
        }

        public async Task StopOperation(MouseEventArgs args)
        {
            if (await _dialogServices!.Confirm("Are you sure you want to cancel this operation?") == true)
            {
                var response = await _operationService!.StopOpration();
                if (response.Value)
                {
                    _globals!.SetPoint = new List<ProtoPatternDetail>();
                    _globals.ActualPoint = new List<OperationLog>();
                    _globals.GlobalPattern = new ProtoPattern()
                    {
                        AirPump = new ProtoAirpump()
                    };

                    Reload();
                    _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"Operation", Detail = $"Stoped" });
                }
                else
                {
                    _notificationService!.Notify(new NotificationMessage() { Severity = NotificationSeverity.Success, Summary = $"Operation", Detail = $"Error" });
                }
            }

            await Task.CompletedTask;
        }

    }
}