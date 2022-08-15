
using Microsoft.AspNetCore.Components;
using UI.Models;
using UI.Pages.Index.Component.Controller;
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

        private List<TempActualLog> _tempLog { get; set; } = new List<TempActualLog>();
        private DateTime _dateTime { get; set; }

        protected async void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "SetPoint")
            {
                if (_globals!.SetPoint.Any())
                {
                    await DrawSetpoint();
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
                        await DrawActualPoint();
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

        private async Task DrawSetpoint()
        {
            await Task.Run(() =>
            {
                SetPoint.Clear();
                _dateTime = _globals!.ActualPoint.Any() ? _globals.ActualPoint.First().TempTime : DateTime.Now;

                SetPoint.Add(new TempChart() { Time = _dateTime, TempValue = _globals!.SetPoint.FirstOrDefault()!.Temp });
                foreach (var item in _globals.SetPoint.OrderBy(x => x.Step))
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

        private async Task DrawActualPoint()
        {
            await Task.Run(() =>
            {
                if (!Actual.Any())
                {
                    foreach (var AP in _globals!.ActualPoint)
                    {
                        if (!Actual.Any() || !object.Equals((int)Actual.Last().TempValue, AP.TempValue!.TempOven))
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
                        }
                    }
                    Console.WriteLine("DrawActualPoint Success");
                    GraphSetting.plotBusy = false;
                }
                else
                {
                    if (!object.Equals((int)Actual.Last().TempValue, _globals!.ActualPoint.Last().TempValue!.TempOven))
                    {
                        Actual.Add(new TempChart()
                        {
                            Time = _globals!.ActualPoint.Last().TempTime.ToLocalTime(),
                            TempValue = _globals.ActualPoint.Last().TempValue!.TempOven
                        });

                        AFB.Add(new TempChart()
                        {
                            Time = _globals!.ActualPoint.Last().TempTime.ToLocalTime(),
                            TempValue = _globals.ActualPoint.Last().TempValue!.TempAFB
                        });
                    }
                    else
                    {
                        foreach (var SP in SetPoint)
                        {
                            if (_globals.ActualPoint.Last().TempTime.ToString(_systemConfig!.DATE_FORMAT_STRING) == SP.Time.ToString(_systemConfig.DATE_FORMAT_STRING))
                            {
                                Actual.Add(new TempChart()
                                {
                                    Time = _globals.ActualPoint.Last().TempTime,
                                    TempValue = _globals.ActualPoint.Last().TempValue!.TempOven
                                });

                                AFB.Add(new TempChart()
                                {
                                    Time = _globals.ActualPoint.Last().TempTime.ToLocalTime(),
                                    TempValue = _globals.ActualPoint.Last().TempValue!.TempAFB
                                });
                            }
                        }
                    }
                }
            });
        }       

    }
}
