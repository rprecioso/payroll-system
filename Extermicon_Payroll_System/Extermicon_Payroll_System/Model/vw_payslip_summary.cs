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
    
    public partial class vw_payslip_summary
    {
        public int payslip_id { get; set; }
        public System.DateTime issue_date { get; set; }
        public decimal COLA { get; set; }
        public decimal basic_rate { get; set; }
        public Nullable<System.DateTime> period_start { get; set; }
        public Nullable<System.DateTime> period_end { get; set; }
        public Nullable<int> emp_id { get; set; }
        public Nullable<decimal> dayspresent { get; set; }
        public Nullable<decimal> amount { get; set; }
        public Nullable<int> Expr1 { get; set; }
        public string name { get; set; }
    }
}
