using System;
using System.Collections.Generic;

namespace GrpcService.Models.SQLite
{
    public partial class Pattern
    {
        public Pattern()
        {
            PatternItems = new HashSet<PatternItem>();
        }

        public long PatternNumber { get; set; }
        public string? PatternName { get; set; }
        public string? CreateDate { get; set; }
        public string? ModifyDate { get; set; }
        public long? AirpumpId { get; set; }
        public long? UseAfb { get; set; }

        public virtual AirPumpSetting? Airpump { get; set; }
        public virtual ICollection<PatternItem> PatternItems { get; set; }
    }
}
