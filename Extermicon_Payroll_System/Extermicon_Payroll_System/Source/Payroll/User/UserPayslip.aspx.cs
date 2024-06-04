using Extermicon_Payroll_System.DAL;
using Extermicon_Payroll_System.Source.Payroll.Administrator;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Extermicon_Payroll_System.Source.Payroll.User
{
    public partial class UserPayslip : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated == false)
                {
                    FormsAuthentication.RedirectToLoginPage();
                }
                else
                {
                    string username = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value).Name;
                    var emp_id = LoginHelper.getEmployeeID(username);
                    Session["emp_id"] = emp_id;
                }

      
            }
        }

        [WebMethod]
        public static bool printPayslip(string payslip_id)
        {
            Reports rep = new Reports();
            rep.Session["payslip_id"] = payslip_id;
            return true;
        }
    }
}