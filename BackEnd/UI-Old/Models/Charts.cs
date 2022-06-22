using System;
using System.Collections.Generic;

namespace UI.Models
{
    public class TempChart
    {
        public DateTime Time { get; set; } = new DateTime();
        public double TempValue { get; set; } = 0;
    }

    public class GlobalChart
    {
        public List<PatternItem> SetPoint {get;set;}
        public List<OperationLog> ActualPoint {get;set;}
    }
}