using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EMS.Entity
{
    class USState
    {
        public string szStateName { get; set; }

        [Key]
        public string szAbbrev { get; set; }
    }
}
