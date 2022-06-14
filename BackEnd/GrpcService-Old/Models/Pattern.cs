using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;

namespace GrpcService.Models
{
    public class Pattern
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int PatternNumber { get; set; }

        [Required]
        public string PatternName { get; set; }

        public string CreateDate { get; set; }

        public string ModifyDate { get; set; }

        public virtual AirPumpSetting Airpump { get; set; }

        public virtual ICollection<PatternItem> PatternItems { get; set; } = new HashSet<PatternItem>();

        public int StepCount { get { return PatternItems.Max(x => x.Step); } }

        public int TotalTime { get { return PatternItems.Sum(s => s.StepDuration); } }
    }
}