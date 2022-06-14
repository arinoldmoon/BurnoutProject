namespace UI.Models
{
    public class PatternModel
    {
        public int PatternId { get; set; }
        public string PatternName { get; set; } = string.Empty;
        public int StepCount { get; set; }
        public int TotalTime { get; set; }
        public AirpumpModel AirPump { get; set; } = new AirpumpModel();
        public List<PatternDetailModel> PatternDetail { get; set; } = new List<PatternDetailModel>();
        public DateTime CreateDate { get; set; }
        public DateTime ModifyDate { get; set; }

    }

    public class AirpumpModel
    {
        public int Id { get; set; }
        public int StartTemp { get; set; }
        public int EndTemp { get; set; }
        public double DelayMinuteDuration { get; set; }
        public bool UseAirpump { get; set; } 
    }

    public class PatternDetailModel
    {
        public int DetailId { get; set; }
        public int PatternId { get; set; }
        public int Step { get; set; }
        public int Temp { get; set; }
        public double StepDuration { get; set; }
    }
}