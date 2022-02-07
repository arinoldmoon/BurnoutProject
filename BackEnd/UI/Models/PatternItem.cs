using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace UI.Models
{
    public class PatternItem
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required]
        public int Step { get; set; }

        [Required]
        public int Temp { get; set; }

        [Required]
        public int StepDuration { get; set; }
    }
}
