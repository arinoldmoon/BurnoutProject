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

        protected int SelectYear = 0;
        protected int SelectMonth = 0;
        public static bool plotBusy = false;

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
                plotBusy = false;
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
                    foreach (var item in _globals.OperationLogInfo.LogList.Where(x => x.PatternID != 17 && x.PatternID != 0).OrderByDescending(x => x.LogID))
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
            await Task.Run(() =>
            {
                plotBusy = true;
                _globals!.ActualPoint = new List<TempActualLog>();
                _globals.SetPoint = new List<ProtoPatternDetail>();
                _globals.ActualPoint = _operationService!.GetOperationLog(Selected!.LogID).Result;
                _globals.SetPoint = _patternService!.GetPatternByID(Selected.PatternID).Result.PatternDetail.ToList();
                Console.WriteLine($"PlotChart ID : {Selected.LogID}");
            });
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