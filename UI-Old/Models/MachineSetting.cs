using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace UI.Models
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
