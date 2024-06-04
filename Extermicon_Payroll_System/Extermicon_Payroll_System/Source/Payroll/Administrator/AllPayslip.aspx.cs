using Extermicon_Payroll_System.DAL;
using Extermicon_Payroll_System.Helpers;
using Extermicon_Payroll_System.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Extermicon_Payroll_System.Source.Payroll.Administrator
{
    public partial class AllPayslip : System.Web.UI.Page
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
                    string username = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value).Name;
                    var emp_id = LoginHelper.getEmployeeID(username);
              
                    Session["emp_id"] = emp_id;

                    rdpEnd.SelectedDate = DateTime.Now.AddDays(15);
                    rdpStart.SelectedDate = DateTime.Now.AddDays(-1);
                };
            }
        }

        [WebMethod]
        public static bool printPayslip(string payslip_id)
        {
            Reports rep = new Reports();
            rep.Session["payslip_id"] = payslip_id;
            return true;
        }

        protected void rgUserPayslip_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                {
                    GridDataItem item = (GridDataItem)e.Item;
                    int id;
                    Int32.TryParse(item.GetDataKeyValue("payslip_id").ToString(), out id);

                    var dedList = db.Deductions.Where(x => x.payslip_id == id).ToList();
                    foreach (var ded in dedList)
                    {
                        db.Deductions.Remove(ded);
                        db.SaveChanges();
                    }

                    var earnList = db.Earnings.Where(x => x.payslip_id == id).ToList();
                    foreach (var earn in earnList)
                    {
                        db.Earnings.Remove(earn);
                        db.SaveChanges();
                    }


                    var pay = db.Payslips.Where(x => x.payslip_id == id);
                    if (pay.Count() > 0)
                    {
                        db.Payslips.Remove(pay.FirstOrDefault());
                        db.SaveChanges();
                    }

                }
            }
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

                rgUserPayslip.DataSource = db.vw_payslip_summary.Where(x => x.period_end <= end && x.period_start >= start && empList.Contains(x.emp_id ?? 0) == true).ToList();
                rgUserPayslip.DataBind();
            }
        }

        protected void rgUserPayslip_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {

                rgUserPayslip.DataSource = db.vw_payslip_summary.ToList();
      
            }
        }

        protected void rdpEnd_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {

        }
    }
}