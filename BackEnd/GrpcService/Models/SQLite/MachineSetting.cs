using System;
using System.Collections.Generic;

namespace GrpcService.Models.SQLite
{
    public partial class MachineSetting
    {
        public long SettingId { get; set; }
        public long AfbStartTemp { get; set; }
        public long AfbEndTemp { get; set; }
        public long AfbDelay { get; set; }
        public long PumpStartTemp { get; set; }
        public long PumpEndTemp { get; set; }
        public long PumpDelay { get; set; }
        public long TubeStartTemp { get; set; }
        public long FloorStartTemp { get; set; }
        public long AlarmOven { get; set; }
        public long AlarmAfb { get; set; }
        public long? ModifyDate { get; set; }
    }
}
