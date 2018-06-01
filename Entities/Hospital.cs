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

        [Required(ErrorMessage = "Please enter a name")]
        [Display(Name = "Name:")]
        [MaxLength(100, ErrorMessage = "This field has a max length of 100 characters.")]
        public string szName { get; set; }

        public bool bIsActive { get; set; }

        public DateTime dtInserted { get; set; }

        public DateTime? dtUpdated { get; set; }

        public string szInsertedBy { get; set; }

        public string szUpdatedBy { get; set; }
    }
}
