using Google.Protobuf.WellKnownTypes;
using GrpcService.Protos;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using UI.Models;
using UI.Services;

namespace UI.Pages.Index.Component.Controller
{
    public partial class GraphSettingComponent : ComponentBase
    {
        [Inject]
        protected GlobalService? _globals { get; set; }

        [Inject]
        protected OperationService? _operationService { get; set; }

        [Inject]
        protected PatternService? _patternService { get; set; }

        [Inject]
        protected SystemConfig? _sysConfig { get; set; }

        protected List<ProtoOvenLogList> LogList { get; set; } = new List<ProtoOvenLogList>();
        protected List<int> YearList { get; set; } = new List<int>();
        protected List<int> MonthList { get; set; } = new List<int>();

        public int SelectYear = 0;
        public int SelectMonth = 0;

        protected ProtoOvenLogList? Selected;

        private void Reload()
        {
            InvokeAsync(StateHasChanged);
        }

        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "OperationLogInfo")
            {
                GetData();
            }
        }

        protected override void OnInitialized()
        {
            _globals!.PropertyChanged += OnPropertyChanged;
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                await GetData();
            }
        }

        private Task GetData()
        {
            return Task.Run(() =>
            {
                if (_globals!.OperationLogInfo != null)
                {
                    YearList = _globals.OperationLogInfo.YearList.ToList();
                    MonthList = _globals.OperationLogInfo.MonthList.ToList();
                    foreach (var item in _globals.OperationLogInfo.LogList.OrderByDescending(x => x.LogID))
                    {
                        LogList.Add(new ProtoOvenLogList()
                        {
                            LogID = item.LogID,
                            PatternID = item.PatternID,
                            StartLog = item.StartLog.ToDateTime().ToTimestamp(),
                            EndLog = item.EndLog.ToDateTime().ToTimestamp()
                        });
                    }

                    SelectYear = YearList.LastOrDefault();
                    SelectMonth = MonthList.LastOrDefault();
                }

                Reload();
            });
        }

        protected async Task PlotChart(MouseEventArgs args)
        {
            _globals!.ActualPoint = new List<OperationLog>();
            _globals.SetPoint = new List<ProtoPatternDetail>();

            List<OperationLog> actual = await _operationService!.GetOperationLog(Selected!.LogID);
            ProtoPattern setpoint = (Selected.PatternID != 0 && Selected.PatternID != 99) ? await _patternService!.GetPatternByID(Selected.PatternID) : new ProtoPattern();

            _globals.ActualPoint = actual;
            _globals.SetPoint = setpoint.PatternDetail.ToList();

            Console.WriteLine($"PlotChart ID : {Selected.LogID}");
        }

        protected async void OnChange(object value)
        {
            Console.WriteLine($"Select Year : {SelectYear} | Month : {SelectMonth}");
            var result = await _operationService!.GetOperationLogWithFilter(SelectYear, SelectMonth);

            if (result.LogList.Any())
            {
                LogList.Clear();
                foreach (var item in result.LogList.OrderByDescending(x => x.LogID))
                {
                    LogList.Add(new ProtoOvenLogList()
                    {
                        LogID = item.LogID,
                        PatternID = item.PatternID,
                        StartLog = item.StartLog.ToDateTime().ToTimestamp(),
                        EndLog = item.EndLog.ToDateTime().ToTimestamp()
                    });
                }
            }

            Reload();
        }
    }

}