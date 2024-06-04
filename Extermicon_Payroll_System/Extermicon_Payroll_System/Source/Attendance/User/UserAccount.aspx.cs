using Extermicon_Payroll_System.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Extermicon_Payroll_System.Source.Attendance.User
{
    public partial class UserAccount : System.Web.UI.Page
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

  
        protected void emp_numberValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (EmployeeHelper.hasDuplicate(args.Value) == true)
            {
               
                args.IsValid = false;
            }
            //if 
            //{
            //    args.IsValid = false;
            //}
        }

        protected void rg_employee_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            Page.Validate();
            if (e.CommandName == RadGrid.UpdateCommandName)
            {
                if (!Page.IsValid)
                {
                    e.Canceled = true;
                }
            }
        }
    }
}