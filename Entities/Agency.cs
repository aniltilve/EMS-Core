using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace EMS.Entity
{
    public class Agency
    {
        [Key]
        public int iAgencyID { get; set; }
        public String szName { get; set; }
        public String szShortName { get; set; }
        public String szEIN { get; set; }
        public String szRegState { get; set; }
        public String szStatus { get; set; }
        public DateTime dtSubscribeStart { get; set; }
        public DateTime? dtSubscribeEnd { get; set; }
        public bool bTaxExempt { get; set; }
        public decimal mLicensePrice { get; set; }
        public decimal mRenewalPrice { get; set; }
        public bool bIsActive { get; set; }
        public DateTime dtInserted { get; set; }
        public String szInsertedBy { get; set; }
        public DateTime? dtUpdated { get; set; }
        public String szUpdatedBy { get; set; }
        public String szNotificationEmail { get; set; }
        public bool bNotificationRequired { get; set; }
        public bool bAgreement  { get; set; }
        public DateTime? dtAgreementAccepted { get; set; }
        public int? iAgreementAcceptedUserID { get; set; }
        public String szIPAddress { get; set; }
        public String szLogoFileName { get; set; }
    }
}
