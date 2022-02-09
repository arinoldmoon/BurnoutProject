namespace GrpcService.Models
{
    public class PLCConfig
    {
        public string PortName { get; set; } = string.Empty;
        public int BaudRate { get; set; } = 0;
        public int Delay1 { get; set; } = 0;
        public int Delay2 { get; set; } = 0;
        public int Delay3 { get; set; } = 0;
    }
}