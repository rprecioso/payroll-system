using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Extermicon_Payroll_System.Model
{
    public class UserModel
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        public bool isValidated { get; set; }

        public tblRole role { get; set; }

        public tblEmployee employee { get; set; }

        public void Validate(string username, string password)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                var res = db.tblUsers.Where(x => x.username == username && x.password == password);
                if (res.Count() > 0)
                {
                    this.isValidated = true;
                    this.role = res.FirstOrDefault().tblRole;
                    this.employee = res.FirstOrDefault().tblEmployee;
                }
                else
                {
                    this.isValidated = false;
                }
            }
        }
    }
}