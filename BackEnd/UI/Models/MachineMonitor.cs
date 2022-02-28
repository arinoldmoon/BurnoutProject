using System;
using System.Collections.Generic;

namespace UI.Models
{
    public class MachineMonitor
    {
        public Temp Temp { get; set; }
        public Coil Coil { get; set; }
        public McStatus Status { get; set; }
    }
    public class Temp
    {
        public int TempOven { get; set; }
        public int TempAFB { get; set; }
        public int TempTube { get; set; }
        public int TempFloor { get; set; }
    }

    public class Coil
    {
        public bool CoilOven { get; set; }
        public bool CoilAFB { get; set; }
        public bool CoilTube { get; set; }
        public bool CoilPump { get; set; }
        public bool CoilFloor { get; set; }
    }

    public class McStatus
    {
        public bool Door { get; set; }
        public bool Operation { get; set; }
        public int PatternId { get; set; }
        public int TotalStep { get; set; }
        public int CurrentStep { get; set; }
        public PatternStatus PatternStatus { get; set; }
        public int RemainHours { get; set; }
        public int RemainMins { get; set; }
        public List<OperationLog> TempLog {get;set;}
    }

    public enum PatternStatus
    {
        Standby = 0,
        Up = 1,
        Down = 2,
        Stable = 3,
        End = 4
    }

    public class OperationLog
    {
        public DateTime TempTime { get; set; }
        public Temp TempValue { get; set; }
    }
}