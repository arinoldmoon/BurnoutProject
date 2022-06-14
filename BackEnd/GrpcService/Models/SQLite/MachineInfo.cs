using System;
using System.Collections.Generic;

namespace GrpcService.Models.SQLite
{
    public partial class MachineInfo
    {
        public long SerialNumber { get; set; }
        public long MachineModel { get; set; }
        public string? MachineName { get; set; }
        public long WarrantyStart { get; set; }
        public long WarrantyEnd { get; set; }
    }
}
