using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Extermicon_Payroll_System.Source.Attendance.Administrator
{
    public partial class HDMF : System.Web.UI.Page
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

                    string role = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value).UserData;
                    if (role.ToLower() != "administrator")
                    {
                        Response.Redirect("/Source/Shared/server-error.aspx?404&url=" + Request.UrlReferrer.ToString());
                    }
                }
            }
        }
    }
}