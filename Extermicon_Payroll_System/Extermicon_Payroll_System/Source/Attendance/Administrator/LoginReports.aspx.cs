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

namespace Extermicon_Payroll_System.Source.Attendance.Administrator
{
    public partial class LoginReports : System.Web.UI.Page
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
                    using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                    {
                        rptLoginReports.LocalReport.ReportPath = "Source/Attendance/Administrator/LoginReports.rdlc";
                        rptLoginReports.LocalReport.DataSources.Clear();
                        rptLoginReports.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("dsLogin", db.vw_log_in_history.ToList()));
                        rptLoginReports.LocalReport.Refresh();
                    }
                }
            }


        }

        protected void rcmbEmployee_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
        }

        protected void rbtnQuery_Click(object sender, EventArgs e)
        {

        }

        protected void lbtnQuery_Click(object sender, EventArgs e)
        {
            List<int> empList = new List<int>();
            foreach (var item in rcmbEmployee.CheckedItems.ToList())
            {
                empList.Add(Helper.StringToInt(item.Value));
            }

            DateTime start = rdpStart.SelectedDate ?? DateTime.Now;
            DateTime end = rdpEnd.SelectedDate ?? DateTime.Now;

            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                rptLoginReports.LocalReport.ReportPath = "Source/Attendance/Administrator/LoginReports.rdlc";
                rptLoginReports.LocalReport.DataSources.Clear();
                rptLoginReports.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("dsLogin", db.vw_log_in_history.Where(x => empList.Contains(x.emp_id ?? 0) == true && x.dtstamp >= start && x.dtstamp <= end).ToList()));
                rptLoginReports.LocalReport.Refresh();
            }
        }
    }
}