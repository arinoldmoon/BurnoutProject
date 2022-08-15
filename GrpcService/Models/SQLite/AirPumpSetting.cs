using System;
using System.Collections.Generic;

namespace GrpcService.Models.SQLite
{
    public partial class AirPumpSetting
    {
        public AirPumpSetting()
        {
            Patterns = new HashSet<Pattern>();
        }

        public long Id { get; set; }
        public long StartTemp { get; set; }
        public long EndTemp { get; set; }
        public long DelayDuration { get; set; }
        public long UseAirpump { get; set; }

        public virtual ICollection<Pattern> Patterns { get; set; }
    }
}
