using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;


namespace EMS.Entity
{
    class DispatchType
    {
        [Key]
        public int iDispatchTypeID { get; set; }

        public int iAgencyID { get; set; }

        [Required(ErrorMessage = "Please enter a charcter code")]
        [Display(Name = "Code:")]
        [RegularExpression("^[a-zA-Z0-9]{1}$", ErrorMessage = "Please enter only one charcter code")]
        public string szCode { get; set; }

        [Required(ErrorMessage = "Please enter a name")]
        [Display(Name = "Name:")]
        public string szName { get; set; }

        public bool bIsActive { get; set; }

        public DateTime dtInserted { get; set; }

        public DateTime? dtUpdated { get; set; }

        public string szInsertedBy { get; set; }

        public string szUpdatedBy { get; set; }
    }
}
