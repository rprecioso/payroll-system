using Extermicon_Payroll_System.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Extermicon_Payroll_System.Source.Shared
{
    public partial class Signin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (HttpContext.Current.User.Identity.IsAuthenticated == false)
                {
                    //FormsAuthentication.RedirectToLoginPage();
                }
                else
                {
                    Response.Redirect("~/Source/Attendance/User/UserLoginHistory.aspx");
                }
            }
        }

        protected void btnSigin_Click(object sender, EventArgs e)
        {
            FormsAuthentication.Initialize();

            UserModel um = new UserModel();
            um.Validate(tbxUsername.Text, tbxPassword.Text);

            if (um.isValidated == true)
            {
                var rol = "User";
                if (string.IsNullOrEmpty(um.role.role) == false)
                {
                    rol = um.role.role;
                }
                FormsAuthenticationTicket ticket =
                        new FormsAuthenticationTicket(1
                            , tbxUsername.Text
                            , DateTime.Now, DateTime.Now.AddMinutes(30)
                            , true
                            , rol
                            , FormsAuthentication.FormsCookiePath);

                string encryptedTicket = FormsAuthentication.Encrypt(ticket);

                var httpCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                httpCookie.Expires = ticket.Expiration;

                Response.Cookies.Add(httpCookie);

                Session["emp_id"] = um.employee.emp_id;

                string strRedirect;
                strRedirect = Request["ReturnUrl"];
                if (strRedirect == null)
                    strRedirect = "~/Source/Shared/Signin.aspx";
                Response.Redirect("~/Source/Attendance/User/UserLoginHistory.aspx", true);
            }

            else
            {
                CustomValidator val = new CustomValidator();
                val.ValidationGroup = "Authentication";
                val.IsValid = false;
                val.ErrorMessage = "Either Username and password does not match! or Account/Role has been pruned or disabled.";
                this.Page.Validators.Add(val);
            }
        }
    }
}