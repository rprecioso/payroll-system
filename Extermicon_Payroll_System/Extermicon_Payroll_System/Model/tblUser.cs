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
    
    public partial class tblUser
    {
        public tblUser()
        {
            this.tblLogins = new HashSet<tblLogin>();
        }
    
        public int user_id { get; set; }
        public string username { get; set; }
        public string password { get; set; }
        public int emp_id { get; set; }
        public string passcode { get; set; }
        public Nullable<int> sched_id { get; set; }
        public int role_id { get; set; }
    
        public virtual tblEmployee tblEmployee { get; set; }
        public virtual ICollection<tblLogin> tblLogins { get; set; }
        public virtual tblRole tblRole { get; set; }
        public virtual tblSchedule tblSchedule { get; set; }
    }
}
