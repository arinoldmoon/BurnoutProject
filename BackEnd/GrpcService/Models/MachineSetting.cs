using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GrpcService.Models
{
    public class MachineSetting
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Setting_ID { get; set; }

        [Required]
        public int AfbStartTemp { get; set; }

        [Required]
        public int AfbEndTemp { get; set; } 

        [Required]
        public int AfbDelay { get; set; }

        [Required]
        public int PumpStartTemp { get; set; }

        [Required]
        public int PumpEndTemp { get; set; }

        [Required]
        public int PumpDelay { get; set; }

        [Required]
        public int TubeStartTemp { get; set; }

        [Required]
        public int FloorStartTemp { get; set; }

        [Required]
        public int AlarmOven { get; set; }

        [Required]
        public int AlarmAfb { get; set; }

        public int? ModifyDate { get; set; }
    }
}
