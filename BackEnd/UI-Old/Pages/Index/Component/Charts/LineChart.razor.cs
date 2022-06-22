using Microsoft.AspNetCore.Components;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UI.Models;
using UI.Services;

namespace UI.Pages.Index.Component.Charts
{
    public partial class LineChartComponent : ComponentBase
    {
        [Inject]
        protected GlobalService Globals { get; set; }

        private static DateTime _dateTime;
        public List<TempChart> AFB { get; set; } = new List<TempChart>();
        public List<TempChart> SetPoint { get; set; } = new List<TempChart>();
        public List<TempChart> Actual { get; set; } = new List<TempChart>();

        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "ActualPoint")
            {
                Actual.Clear();
                AFB.Clear();

                if (Globals.ActualPoint.Any())
                {
                    if (Actual.Count != Globals.ActualPoint.Count)
                    {
                        DrawChart().GetAwaiter();
                    }
                }
            }

            if (args.Name == "SetPoint")
            {
                SetPoint.Clear();

                if (Globals.SetPoint.Any())
                {
                    DrawChart().GetAwaiter();
                }
                StateHasChanged();
            }
        }

        protected override void OnInitialized()
        {
            Globals.PropertyChanged += OnPropertyChanged;
        }

        private void Reload()
        {
            InvokeAsync(StateHasChanged);
        }

        private async Task DrawChart()
        {
            SetPoint.Clear();
            Actual.Clear();
            AFB.Clear();

            List<OperationLog> _tempLog = new List<OperationLog>();
            bool chkActual = Globals.ActualPoint.Any();
            bool chkSetpoint = Globals.SetPoint.Any();

            _dateTime = (chkActual) ? Globals.ActualPoint.First().TempTime : DateTime.Now;
            _tempLog = (chkActual) ? Globals.ActualPoint : null;

            if (chkSetpoint)
            {
                SetPoint.Add(new TempChart() { Time = _dateTime, TempValue = Globals.SetPoint.First().Temp });
                foreach (var item in Globals.SetPoint)
                {
                    _dateTime = _dateTime.AddMinutes(item.StepDuration);
                    SetPoint.Add(new TempChart()
                    {
                        Time = _dateTime,
                        TempValue = item.Temp
                    });
                }
            }

            if (chkActual)
            {
                foreach (var AP in _tempLog)
                {
                    if (Actual.Any())
                    {
                        if (Actual.Last().TempValue != AP.TempValue.TempOven)
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
                                if (AP.TempTime.ToString("dd/MM/yyyy HH:mm") == SP.Time.ToString("dd/MM/yyyy HH:mm"))
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
            await Task.CompletedTask;
            Reload();
        }
    }
}
