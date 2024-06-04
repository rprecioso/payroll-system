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
    public partial class LoginHistory : System.Web.UI.Page
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
                    var role = LoginHelper.getEmployeeRole(username);
                    if (role.ToLower() != "administrator")
                    {
                        Response.Redirect("Source/Shared/Unauthorized.aspx");
                    }
                    Session["emp_id"] = emp_id;

                    rdpEnd.SelectedDate = DateTime.Now.AddDays(15);
                    rdpStart.SelectedDate = DateTime.Now.AddDays(-1);
                };
            }
        }


        protected void lbtnQuery_Click(object sender, EventArgs e)
        {
            //rgUserLoginHistory.Rebind();

            List<int> empList = new List<int>();
            foreach (var item in rcmbEmployee.CheckedItems.ToList())
            {
                empList.Add(Helper.StringToInt(item.Value));
            }

            DateTime start = rdpStart.SelectedDate ?? DateTime.Now;
            DateTime end = rdpEnd.SelectedDate ?? DateTime.Now;
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                rgUserLoginHistory.DataSource = null;
                rgUserLoginHistory.DataSource = db.vw_log_in_history.Where(x => x.dtstamp <= end && x.dtstamp >= start && empList.Contains(x.emp_id ?? 0) == true).ToList();
                rgUserLoginHistory.DataBind();
            }
        }

        protected void rgUserLoginHistory_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                rgUserLoginHistory.DataSource = db.vw_log_in_history.ToList();

            }
            //if (HttpContext.Current.User.Identity.IsAuthenticated == false)
            //{
            //    FormsAuthentication.RedirectToLoginPage();
            //}
            //else
            //{
            //    using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            //    {
            //        string username = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value).Name;
            //        var emp_id = Helper.StringToInt(rcmbEmployee.SelectedValue.ToString()); //LoginHelper.getEmployeeID(username);
            //        var start = rdpStart.SelectedDate;
            //        var end = rdpEnd.SelectedDate;
            //        rgUserLoginHistory.DataSource = db.vw_log_in_history.Where(x => x.dtstamp <= end && x.dtstamp >= start && x.emp_id == emp_id).ToList();
            //    }
            //}
        }


    }
}