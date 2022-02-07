using System;
using System.ComponentModel.DataAnnotations;

namespace UI.Models
{
    public class MachineInfo
    {
        [Key]
        [Required]
        public int SerialNumber { get; set; }

        [Required]
        public int MachineModel { get; set; }

        [StringLength(10)]
        public string MachineName { get; set; }

        [Required]
        public DateTime WarrantyStart { get; set; }

        [Required]
        public DateTime WarrantyEnd { get; set; }
    }
}
