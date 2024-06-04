using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Extermicon_Payroll_System.Source.Shared
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Attendance has been updated!')", true);
            FormsAuthentication.RedirectToLoginPage();
        }
    }
}