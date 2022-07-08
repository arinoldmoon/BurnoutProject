using System;
using System.Collections.Generic;

namespace GrpcService.Models.SQLite
{
    public partial class OperationLog
    {
        public long Id { get; set; }
        public long LogId { get; set; }
        public long? Door { get; set; }
        public long? PatternId { get; set; }
        public long? CurrentStep { get; set; }
        public long? TotalStep { get; set; }
        public string? PatternStatus { get; set; }
        public long? ActualTempOven { get; set; }
        public long? ActualTempAfb { get; set; }
        public long? ActualTempFloor { get; set; }
        public long? ActualTempTube { get; set; }
        public string? OperationTime { get; set; }
    }
}
