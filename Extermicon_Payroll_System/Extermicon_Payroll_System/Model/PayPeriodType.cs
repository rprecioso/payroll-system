//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Extermicon_Payroll_System.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class PayPeriodType
    {
        public PayPeriodType()
        {
            this.PayPeriods = new HashSet<PayPeriod>();
        }
    
        public int pay_period_type_id { get; set; }
        public string name { get; set; }
    
        public virtual ICollection<PayPeriod> PayPeriods { get; set; }
    }
}
