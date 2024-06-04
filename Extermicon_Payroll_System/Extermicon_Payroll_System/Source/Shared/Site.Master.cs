using Extermicon_Payroll_System.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Extermicon_Payroll_System.Source.Shared
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                try
                {
                    if (HttpContext.Current.User.Identity.IsAuthenticated == true)
                    {
                        string username = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value).Name;
                        lblLogged.Text = LoginHelper.getEmployeeName(username);

                        lbtnLogout.Visible = true;
                        lbtnAccountSettings.Visible = true;
                        lbtnLoginHistory.Visible = true;
                        

                        if (LoginHelper.getEmployeeRole(username) == "Administrator")
                        {
                            lbtnAdAccount.Visible = true;
                            lbtnAdCalendar.Visible = true;
                            lbtnAdReport.Visible = true;
                            lbtnLogin.Visible = false;
                            lbtnAdCreatePayslip.Visible = true;
                            //lblAdHeader.Visible = true;
                            //lbtnAdBatchLogs.Visible = true;
                            //lbtnAdLoginHistory.Visible = true;
                            //lblAdHeaderPay.Visible = true;
                            //lblAdLogin.Visible = true;
                            //lbtnAdLoginReports.Visible = true;
                            divLogin.Visible = true;
                            divPayslip.Visible = true;
                            divAdmin.Visible = true;
                            divGov.Visible = true;
                            lbtnWtax.Visible = true;
                            lbtnHMO.Visible = true;
                            lbtnHDMF.Visible = true;
                            lbtnSSS.Visible = true;
                        }
                        else
                        {
                            lbtnAdCreatePayslip.Visible = false;
                            lbtnAdAccount.Visible = false;
                            lbtnAdCalendar.Visible = false;
                            lbtnAdReport.Visible = false;
                            //lblAdHeader.Visible = false;
                            //lbtnAdLoginHistory.Visible = false;
                            //lblAdHeaderPay.Visible = false;
                            //lblAdLogin.Visible = false;
                            //lbtnAdLoginReports.Visible = false;
                            
                           
                            //lbtnAdBatchLogs.Visible = false;
                            divAdmin.Visible = false;
                            divGov.Visible = false;
                            divPayslip.Visible = false;
                            divLogin.Visible = false;
                            lbtnWtax.Visible = false;
                            lbtnHMO.Visible = false;
                            lbtnHDMF.Visible = false;
                            lbtnSSS.Visible = false;
                            lbtnLogin.Visible = false;
                        }
                    }
                    else
                    {
                        lblLogged.Text = "Not logged in";
                        lbtnLogout.Visible = false;
                        lbtnAccountSettings.Visible = false;
                        lbtnLoginHistory.Visible = false;
                        lbtnAdAccount.Visible = false;
                        lbtnAdCalendar.Visible = false;
                        lbtnAdReport.Visible = false;
                        lbtnUserPayslip.Visible = false;
                        lbtnAdCreatePayslip.Visible = false;
                        //lblAdHeader.Visible = false;
                        //lbtnAdLoginHistory.Visible = false;
                        //lblAdHeaderPay.Visible = false;
                        //lbtnAdBatchLogs.Visible = false;
                        //lblAdLogin.Visible = false;
                        //lbtnAdLoginReports.Visible = false;
                        divLogin.Visible = false;
                        divPayslip.Visible = false;
                        divAdmin.Visible = false;
                        divGov.Visible = false;
                        lbtnLogin.Visible = true;
                        lbtnWtax.Visible = false;
                        lbtnHMO.Visible = false;
                        lbtnHDMF.Visible = false;
                        lbtnSSS.Visible = false;
                    }


                }
                catch (Exception)
                {

                    //FormsAuthentication.RedirectToLoginPage();
                }
            }

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {

        }



        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();
        }

        protected void lbtnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Source/Shared/Signin.aspx");
        }
    }
}