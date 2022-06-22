using System;
using System.Collections.Generic;
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

        public OvenLogHeader LogHeader {get;set;}
       
    }

     public class OvenLogHeader
        {
            public List<int> YearList { get; set; }
            public List<int> MonthList { get; set; }
            public ICollection<OvenLogList> LogList { get; set; }
        }

        public class OvenLogList
        {
            public int LogID { get; set; }
            public int PatternID { get; set; }
            public DateTime StartLog { get; set; }
            public DateTime EndLog { get; set; }
        }
}
