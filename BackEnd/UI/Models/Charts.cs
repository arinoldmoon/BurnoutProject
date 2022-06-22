using GrpcService.Protos;

namespace UI.Models
{
    public class TempChart
    {
        public DateTime Time { get; set; }
        public double TempValue { get; set; }
    }

    public class OperationLog
    {
        public DateTime TempTime { get; set; }
        public Temp? TempValue { get; set; }
    }
}