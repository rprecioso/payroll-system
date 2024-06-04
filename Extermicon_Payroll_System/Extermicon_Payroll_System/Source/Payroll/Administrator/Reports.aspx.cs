using Extermicon_Payroll_System.DAL;
using Extermicon_Payroll_System.Helpers;
using Extermicon_Payroll_System.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Extermicon_Payroll_System.Source.Payroll.Administrator
{
    public partial class Reports : System.Web.UI.Page
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
                    //string role = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value).UserData;
                    //if (role.ToLower() != "administrator")
                    //{
                    //    Response.Redirect("/Source/Shared/server-error.aspx?404&url=" + Request.UrlReferrer.ToString());
                    //}
                    string username = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value).Name;
                    var emp_id = LoginHelper.getEmployeeID(username);
                    Session["emp_id"] = emp_id;

                    var payslip_id = Helper.StringToInt(Session["payslip_id"].ToString());
                    
                    using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                    {
                        rpvPayslip.LocalReport.ReportPath = "Source/Payroll/Administrator/Payslip.rdlc";
                        rpvPayslip.LocalReport.DataSources.Clear();
                        rpvPayslip.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("dsPayslip", db.Payslips.Where(x => x.payslip_id == payslip_id).ToList()));
                        rpvPayslip.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("dsEmployee", db.tblEmployees.Where(x => x.Payslips.Where(y=> y.payslip_id == payslip_id).Count() > 0).ToList()));
                        rpvPayslip.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("dsDeduction", db.vw_deduction_no_zero.Where(x => x.payslip_id == payslip_id).ToList()));
                        rpvPayslip.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("dsEarning", db.vw_earning_no_zero.Where(x => x.payslip_id == payslip_id).ToList()));
                        rpvPayslip.LocalReport.Refresh();
                    }
                }

             
            }


           
            
        }
    }
}