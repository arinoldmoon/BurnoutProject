using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace UI.Models
{
    public class PatternItem
    {
        public int DetailId { get; set; }

        public int PatternId { get; set; }

        public int Step { get; set; }

        public int Temp { get; set; }

        public int StepDuration { get; set; }
    }
}
