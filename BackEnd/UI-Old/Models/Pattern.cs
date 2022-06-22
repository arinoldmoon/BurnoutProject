using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;

namespace UI.Models
{
    public class Pattern
    {
        public int PatternNumber { get; set; }

        public string PatternName { get; set; }

        public string CreateDate { get; set; }

        public string ModifyDate { get; set; }

        public AirPumpSetting Airpump { get; set; } = new AirPumpSetting();

        public ICollection<PatternItem> PatternItems { get; set; } = new HashSet<PatternItem>();

        public int StepCount { get; set; }

        public int TotalTime { get; set; }

    }
}