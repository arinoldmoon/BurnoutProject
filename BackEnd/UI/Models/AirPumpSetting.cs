using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace UI.Models
{
    public class AirPumpSetting
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required]
        public int StartTemp { get; set; }

        [Required]
        public int EndTemp { get; set; }

        [Required]
        public int DelayDuration { get; set; }
    }
}
