using GrpcService.Protos;
using Microsoft.AspNetCore.Components;
using UI.Models;
using UI.Services;

namespace UI.Pages.Index.Component.Charts
{
    public partial class LineChartComponent : ComponentBase
    {
        [Inject]
        protected GlobalService? _globals { get; set; }

        [Inject]
        protected SystemConfig? _systemConfig { get; set; }

        protected List<TempChart> AFB { get; set; } = new List<TempChart>();
        protected List<TempChart> SetPoint { get; set; } = new List<TempChart>();
        protected List<TempChart> Actual { get; set; } = new List<TempChart>();

        private List<OperationLog> _tempLog { get; set; } = new List<OperationLog>();
        private DateTime _dateTime { get; set; }

        protected void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "SetPoint")
            {
                Console.WriteLine("Chart Detect SetPoint Change");
                if (_globals!.SetPoint.Any())
                {
                    DrawChart().GetAwaiter();
                }
                else
                {
                    SetPoint.Clear();
                }
            }

            if (args.Name == "ActualPoint")
            {
                if (_globals!.ActualPoint.Any())
                {
                    if (!object.Equals(Actual.Count, _globals.ActualPoint.Count))
                    {
                        DrawChart().GetAwaiter();
                    }
                }
                else
                {
                    Actual.Clear();
                    AFB.Clear();
                }
            }
        }

        protected override void OnInitialized()
        {
            _globals!.PropertyChanged += OnPropertyChanged;
        }

        private Task DrawChart()
        {
            SetPoint.Clear();
            Actual.Clear();
            AFB.Clear();

            return Task.Run(() =>
            {
                _dateTime = _globals!.ActualPoint.Any() ? _globals.ActualPoint.First().TempTime : DateTime.Now;
                _tempLog = _globals.ActualPoint;
            }).ContinueWith(task =>
            {
                SetPoint.Add(new TempChart() { Time = _dateTime, TempValue = _globals!.SetPoint.First().Temp });
                foreach (var item in _globals.SetPoint)
                {
                    _dateTime = _dateTime.AddMinutes(item.StepDuration.ToTimeSpan().TotalMinutes);
                    SetPoint.Add(new TempChart()
                    {
                        Time = _dateTime,
                        TempValue = item.Temp
                    });
                }
            }).ContinueWith(task =>
            {
                if (_tempLog.Any())
                {
                    foreach (var AP in _tempLog)
                    {
                        if (Actual.Any())
                        {
                            if (Actual.Last().TempValue != AP.TempValue!.TempOven)
                            {
                                Actual.Add(new TempChart()
                                {
                                    Time = AP.TempTime.ToLocalTime(),
                                    TempValue = AP.TempValue.TempOven
                                });

                                AFB.Add(new TempChart()
                                {
                                    Time = AP.TempTime.ToLocalTime(),
                                    TempValue = AP.TempValue.TempAFB
                                });
                            }
                            else
                            {
                                foreach (var SP in SetPoint)
                                {
                                    if (AP.TempTime.ToString(_systemConfig!.DATE_FORMAT_STRING) == SP.Time.ToString(_systemConfig.DATE_FORMAT_STRING))
                                    {
                                        Actual.Add(new TempChart()
                                        {
                                            Time = AP.TempTime,
                                            TempValue = AP.TempValue.TempOven
                                        });

                                        AFB.Add(new TempChart()
                                        {
                                            Time = AP.TempTime.ToLocalTime(),
                                            TempValue = AP.TempValue.TempAFB
                                        });
                                    }
                                }
                            }
                        }
                        else
                        {
                            Actual.Add(new TempChart()
                            {
                                Time = AP.TempTime,
                                TempValue = AP.TempValue!.TempOven
                            });

                            AFB.Add(new TempChart()
                            {
                                Time = AP.TempTime.ToLocalTime(),
                                TempValue = AP.TempValue.TempAFB
                            });
                        }
                    }
                }
            }).ContinueWith(task =>
            {
                InvokeAsync(StateHasChanged);
            });
        }
    }
}
