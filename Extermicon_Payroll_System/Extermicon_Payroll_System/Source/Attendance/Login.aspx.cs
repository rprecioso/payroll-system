using Extermicon_Payroll_System.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Extermicon_Payroll_System.Source.Attendance
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //var result = LoginHelper.user_login(tbxPassCode.Text);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Login", "alert('" + result + "');", true);
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {
            rgTodayLogs.Rebind();
        }

        [WebMethod]
        public static string login(string passcode)
        {
            var result = LoginHelper.user_login(passcode);
            return result;

            

            //Reports rep = new Reports();
            //rep.Session["payslip_id"] = payslip_id;
            //return true;
        }
    }
}