using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EMS.Entity
{
    class Hospital
    {
        [Key]
        public int iHospitalID { get; set; }

        public int iAgencyID { get; set; }
        [Required(ErrorMessage = "Please enter name")]
        [Display(Name = "Name:")]

        public string szName { get; set; }

        public bool bIsActive { get; set; }

        public DateTime dtInserted { get; set; }

        public DateTime? dtUpdated { get; set; }

        public string szInsertedBy { get; set; }

        public string szUpdatedBy { get; set; }
    }
}
