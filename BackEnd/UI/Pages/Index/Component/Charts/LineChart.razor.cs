
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
                if (_globals!.SetPoint.Any())
                {
                    DrawSetpoint();
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
                        DrawActualPoint();
                    }
                }
                else
                {
                    Actual.Clear();
                    AFB.Clear();
                }
            }
        }


        private void Reload()
        {
            InvokeAsync(StateHasChanged);
        }

        protected override void OnInitialized()
        {
            _globals!.PropertyChanged += OnPropertyChanged;
        }

        private Task DrawSetpoint()
        {
            return Task.Run(() =>
            {
                SetPoint.Clear();
                _dateTime = _globals!.ActualPoint.Any() ? _globals.ActualPoint.First().TempTime : DateTime.Now;

                SetPoint.Add(new TempChart() { Time = _dateTime, TempValue = _globals!.SetPoint.FirstOrDefault()!.Temp });
                foreach (var item in _globals.SetPoint)
                {
                    _dateTime = _dateTime.AddMinutes(item.StepDuration.ToTimeSpan().TotalMinutes);
                    SetPoint.Add(new TempChart()
                    {
                        Time = _dateTime,
                        TempValue = item.Temp
                    });
                }
                Reload();
            });
        }

        private Task DrawActualPoint()
        {
            return Task.Run(() =>
            {
                _tempLog = _globals!.ActualPoint;
                _dateTime = _globals!.ActualPoint.Any() ? _globals.ActualPoint.First().TempTime : DateTime.Now;

                if (_tempLog.Any())
                {
                    Actual.Clear();
                    AFB.Clear();

                    foreach (var AP in _tempLog)
                    {
                        if (Actual.Any())
                        {
                            Actual.Add(new TempChart()
                            {
                                Time = AP.TempTime.ToLocalTime(),
                                TempValue = AP.TempValue!.TempOven
                            });

                            AFB.Add(new TempChart()
                            {
                                Time = AP.TempTime.ToLocalTime(),
                                TempValue = AP.TempValue.TempAFB
                            });

                            // if (Actual.Last().TempValue != AP.TempValue!.TempOven)
                            // {
                            //     Actual.Add(new TempChart()
                            //     {
                            //         Time = AP.TempTime.ToLocalTime(),
                            //         TempValue = AP.TempValue.TempOven
                            //     });

                            //     AFB.Add(new TempChart()
                            //     {
                            //         Time = AP.TempTime.ToLocalTime(),
                            //         TempValue = AP.TempValue.TempAFB
                            //     });
                            // }
                            // else
                            // {
                            //     foreach (var SP in SetPoint)
                            //     {
                            //         if (AP.TempTime.ToString(_systemConfig!.DATE_FORMAT_STRING) == SP.Time.ToString(_systemConfig.DATE_FORMAT_STRING))
                            //         {
                            //             Actual.Add(new TempChart()
                            //             {
                            //                 Time = AP.TempTime,
                            //                 TempValue = AP.TempValue.TempOven
                            //             });

                            //             AFB.Add(new TempChart()
                            //             {
                            //                 Time = AP.TempTime.ToLocalTime(),
                            //                 TempValue = AP.TempValue.TempAFB
                            //             });
                            //         }
                            //     }
                            // }
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

                    Reload();
                }
            });

        }
    }
}
