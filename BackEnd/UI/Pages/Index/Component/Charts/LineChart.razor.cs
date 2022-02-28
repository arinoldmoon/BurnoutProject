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
        public TempChart[] AirFlow { get; set; } = new TempChart[] { };
        public List<TempChart> SetPoint { get; set; } = new List<TempChart>();
        public List<TempChart> Actual { get; set; } = new List<TempChart>();

        public void OnPropertyChanged(PropertyChangedEventArgs args)
        {
            if (args.Name == "GlobalPattern")
            {
                if (Globals.GlobalPattern.PatternItems != null)
                {
                    if (SetPoint.Count == 0)
                    {                       
                        DrawChart().GetAwaiter();
                    }
                }
            }

            if (args.Name == "GlobalMonitor")
            {
                bool TempCount = Globals.GlobalMonitor.Status.TempLog.Any();
                if (TempCount)
                {
                    if (!object.Equals(Actual.Count, Globals.GlobalMonitor.Status.TempLog.Count))
                    {                        
                        DrawChart().GetAwaiter();
                    }
                }
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
            List<OperationLog> TempLog = new List<OperationLog>();
            bool chk = Globals.GlobalMonitor.Status.TempLog.Any();

            _dateTime = (chk) ? Globals.GlobalMonitor.Status.TempLog.First().TempTime : DateTime.Now;
            TempLog = (chk) ? Globals.GlobalMonitor.Status.TempLog : null;

            if (Globals.GlobalPattern.PatternItems.Count > 0)
            {
                SetPoint.Add(new TempChart() { Time = _dateTime, TempValue = 30 });
                foreach (var item in Globals.GlobalPattern.PatternItems)
                {
                    _dateTime = _dateTime.AddMinutes(item.StepDuration);
                    SetPoint.Add(new TempChart()
                    {
                        Time = _dateTime,
                        TempValue = item.Temp
                    });
                }
            }

            if (chk)
            {
                foreach (var AP in TempLog)
                {
                    if (Actual.Any())
                    {
                        if (Actual.Last().TempValue != AP.TempValue.TempOven)
                        {
                            Actual.Add(new TempChart()
                            {
                                Time = AP.TempTime,
                                TempValue = AP.TempValue.TempOven
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
                    }
                }
            }

            await Task.CompletedTask;
            Reload();
        }
    }
}
