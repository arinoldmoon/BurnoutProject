using System;
using System.Collections.Generic;

namespace GrpcService.Models.SQLite
{
    public partial class PatternItem
    {
        public long Id { get; set; }
        public long Step { get; set; }
        public long Temp { get; set; }
        public long StepDuration { get; set; }
        public long PatternNumber { get; set; }

        public virtual Pattern PatternNumberNavigation { get; set; } = null!;
    }
}
