using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GrpcService.Models
{
    public class OperationLog
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ID { get; set; }

        [Required]
        public int LogID { get; set; }
        public int Door { get; set; }
        public int PatternID { get; set; }
        public int CurrentStep { get; set; }
        public int TotalStep { get; set; }
        public string PatternStatus { get; set; }
        public int ActualTempOven { get; set; }
        public int ActualTempAFB { get; set; }
        public int ActualTempFloor { get; set; }
        public int ActualTempTube { get; set; }
        public string OperationTime { get; set; }
    }
}