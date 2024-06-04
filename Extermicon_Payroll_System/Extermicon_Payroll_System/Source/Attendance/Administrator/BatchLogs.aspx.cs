using Extermicon_Payroll_System.DAL;
using Extermicon_Payroll_System.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Extermicon_Payroll_System.Source.Attendance.Administrator
{
    public class login
    {
        public string login_id { get; set; }
        public DateTime dtstamp { get; set; }
        public DateTime in_time { get; set; }
        public DateTime out_time { get; set; }
        public string date { get; set; }
        public int user_id { get; set; }
    }

    public static class tempLogin
    {
        // public static List<login> tempLoginList = new List<login>();
    }

    public partial class BatchLogs : System.Web.UI.Page
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
                    Session["templogin"] = new List<login>();
                }
            }
        }

        protected void rc_holidays_SelectionChanged(object sender, Telerik.Web.UI.Calendar.SelectedDatesEventArgs e)
        {
            var empid = 0;

            if (string.IsNullOrEmpty(rcmbEmployee.SelectedValue) == false)
            {
                empid = Convert.ToInt32(rcmbEmployee.SelectedValue);

                refreshData(rc_holidays.SelectedDates.ToArray().ToList(), Convert.ToInt32(empid));

                rgAttendance.Rebind();
            }
            else
            {

            }
        }

        private void refreshData(List<DateTime> sDates, int _empid)
        {
            try
            {
                List<login> tempLoginList = (List<login>)Session["templogin"];
                using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                {
       List<DateTime> toBeRemoved = new List<DateTime>();
                    rc_holidays.SelectedDates.Clear();

                    foreach (DateTime sdt in sDates)
                    {
                        string cdt = sdt.ToString("yyyy-MM-dd");
                        var b = from logs in db.vw_log_in_history
                                where logs.date == cdt && logs.emp_id == _empid
                                select logs;
                        if (b.Count() > 0)
                        {
                            var f = b.FirstOrDefault();
                            if (tempLoginList.Where(x => x.date == f.date).Count() < 1)
                            {

                                tempLoginList.Add(new login()
                                {
                                    login_id = new Guid().ToString(),
                                    date = f.date,
                                    dtstamp = f.dtstamp ?? DateTime.Now,
                                    in_time = f.in_time ?? DateTime.Now,
                                    out_time = f.out_time ?? DateTime.Now,
                                    user_id = f.user_id ?? 0
                                });
                            }
                        }
                    }
                    foreach (DateTime dt in sDates)
                    {
                        var dts = dt.ToString("yyyy-MM-dd");
                        // var res = db.tblLogins.Where(x => x.date.Value.Year == log.dtstamp.Year && x.date.Value.Month == log.dtstamp.Month && x.date.Value.Day == log.dtstamp.Day);
                        if (tempLoginList.Where(x => x.date == dts).Count() < 1)
                        {
                            DateTime now = DateTime.Now;
                            tempLoginList.Add(new login()
                            {
                                login_id = new Guid().ToString(),
                                date = dt.ToString("yyyy-MM-dd"),
                                dtstamp = dt,
                                in_time = new DateTime(dt.Year, dt.Month, dt.Day, 9, 0, 0),
                                out_time = new DateTime(dt.Year, dt.Month, dt.Day, 18, 0, 0),
                                user_id = EmployeeHelper.getEmp(_empid).user_id
                            });
                        }
                    }

                    var LList = tempLoginList.ToList();
                    foreach (login log in LList)
                    {
                        bool stillSelected = false;
                        foreach (DateTime dt in sDates)
                        {
                            if (log.date == dt.ToString("yyyy-MM-dd"))
                            {
                                stillSelected = true;
                            }
                        }
                        if (stillSelected == false)
                        {
                            tempLoginList.Remove(log);
                        }
                    }
                    foreach (DateTime dts in sDates)
                    {
                        rc_holidays.SelectedDates.Add(new Telerik.Web.UI.RadDate(dts));
                        DateTime now = DateTime.Now;
                    }
                    Session["templogin"] = tempLoginList;
                }
            }
            catch (Exception)
            {
                Response.Redirect("/Source/Attendance/Administrator/BatchLogs.aspx");
            }

        }

        protected void rc_holidays_DayRender(object sender, Telerik.Web.UI.Calendar.DayRenderEventArgs e)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                var empid = 0;

                if (string.IsNullOrEmpty(rcmbEmployee.SelectedValue) == false)
                {
                    empid = Convert.ToInt32(rcmbEmployee.SelectedValue);
                }


                DateTime CurrentDate = e.Day.Date;
                string cdt = CurrentDate.ToString("yyyy-MM-dd");
                var b = from logs in db.vw_log_in_history
                        where logs.date == cdt && logs.emp_id == empid
                        select logs;

                //var holidayList = db.tblHolidays.ToList().Where(x => x.start_date <= CurrentDate && x.end_date >= CurrentDate).ToList();
                if (b.Count() > 0)
                {
                    var intime = "no time in";
                    var outtime = "no time out";
                    if (b.FirstOrDefault().in_time != null)
                    {
                        intime = b.FirstOrDefault().in_time.Value.ToShortTimeString();
                    }
                    if (b.FirstOrDefault().out_time != null)
                    {
                        outtime = b.FirstOrDefault().out_time.Value.ToShortTimeString();
                    }
                    TableCell currentCell = e.Cell;
                    currentCell.Style["background-color"] = "Yellow";
                    currentCell.Style["text-align"] = "center";
                    currentCell.Style["text-wrap"] = "normal";
                    currentCell.Style["max-width"] = "10%";
                    currentCell.Text = intime + " - " + outtime;
                    currentCell.Enabled = false;
                    currentCell.CssClass = "hol";
                }
            }
        }

        protected void lbtnQuery_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static bool isPresent(string selectedDate)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                DateTime CurrentDate = DateTime.Parse(selectedDate);
                string cdt = CurrentDate.ToString("yyyy-MM-dd");
                var b = from logs in db.vw_log_in_history
                        where logs.date == cdt
                        select logs;


                //JavaScriptSerializer js = new JavaScriptSerializer();
                //return js.Serialize(b);

                if (b.Count() > 0)
                {
                    return false;
                }

                return true;

            }
        }



        protected void btnAttSave_Click(object sender, EventArgs e)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {


                try
                {
                    List<login> tempLoginList = (List<login>)Session["templogin"];
                    foreach (login log in tempLoginList)
                    {
                        var d = log.dtstamp;
                        var res = db.tblLogins.Where(x => x.date.Value.Year == log.dtstamp.Year && x.date.Value.Month == log.dtstamp.Month && x.date.Value.Day == log.dtstamp.Day);
                        if (res.Count() > 0)
                        {

                            var f = res.FirstOrDefault();

                            f.date = log.dtstamp;
                            f.in_time = new DateTime(d.Year, d.Month, d.Day, log.in_time.Hour, log.in_time.Minute, log.in_time.Second);
                            f.out_time = new DateTime(d.Year, d.Month, d.Day, log.out_time.Hour, log.out_time.Minute, log.out_time.Second);
                            f.user_id = log.user_id;
                        }
                        else
                        {

                            db.tblLogins.Add(new tblLogin()
                            {
                                date = log.dtstamp,
                                in_time = new DateTime(d.Year, d.Month, d.Day, log.in_time.Hour, log.in_time.Minute, log.in_time.Second),
                                out_time = new DateTime(d.Year, d.Month, d.Day, log.out_time.Hour, log.out_time.Minute, log.out_time.Second),
                                user_id = log.user_id

                            });
                        }
                    }

                    db.SaveChanges();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Attendance has been updated!')", true);
                    Session["templogin"] = new List<login>();

                    rc_holidays.SelectedDates.Clear();

                    rgAttendance.Rebind();
                }
                catch (Exception)
                {
                    Response.Redirect("/Source/Attendance/Administrator/BatchLogs.aspx");
                }


                //    
            }
        }

        protected void rcmbEmployee_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rc_holidays.SelectedDates.Clear();
        }

        protected void rgAttendance_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

            List<login> tempLoginList = (List<login>)Session["templogin"];
            rgAttendance.DataSource = tempLoginList;

        }

        protected void rgAttendance_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            List<login> tempLoginList = (List<login>)Session["templogin"];
            if (e.CommandName == "Update")
            {
                GridEditFormItem editForm = (GridEditFormItem)e.Item;
                RadTimePicker rtpIn = (RadTimePicker)editForm.FindControl("rtpIn");
                RadTimePicker rtpOut = (RadTimePicker)editForm.FindControl("rtpOut");
                //Label dtstamp = (Label)editForm.FindControl("lblDate");
                Label lblDate = (Label)editForm.FindControl("lblDate");
                //RadDateTimePicker rdtpDate = (RadDateTimePicker)editForm.FindControl("rdtpDate");


                var d = DateTime.Parse(lblDate.Text);
                var res = tempLoginList.Where(x => x.date == lblDate.Text);
                var in_time = rtpIn.SelectedDate ?? DateTime.Now;
                var out_time = rtpOut.SelectedDate ?? DateTime.Now;

                if (in_time >= out_time)
                {
                    e.Canceled = true;
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Time in is past or equal to time out!')", true);
                }
                else
                {

                    res.FirstOrDefault().in_time = new DateTime(d.Year, d.Month, d.Day, in_time.Hour, in_time.Minute, in_time.Second);
                    res.FirstOrDefault().out_time = new DateTime(d.Year, d.Month, d.Day, out_time.Hour, out_time.Minute, out_time.Second);
                    res.FirstOrDefault().dtstamp = d;
                    res.FirstOrDefault().date = lblDate.Text;
                    Session["templogin"] = tempLoginList;

                    rgAttendance.Rebind();
                }
            }

            if (e.CommandName == "Delete")
            {
                GridDataItem item = (GridDataItem)e.Item;
                DateTime dt;
                DateTime.TryParse(item.GetDataKeyValue("dtstamp").ToString(), out dt);
                var d = dt.ToString("yyyy-MM-dd");
                var res = tempLoginList.Where(x => x.date == d).ToList();

                if (res.Count() > 0)
                {
                    var empid = 0;

                    if (string.IsNullOrEmpty(rcmbEmployee.SelectedValue) == false)
                    {
                        empid = Convert.ToInt32(rcmbEmployee.SelectedValue);
                    }
                    using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                    {
                        var r = res.FirstOrDefault().date;

                        var f = db.vw_log_in_history.Where(x => x.date == r && x.emp_id == empid).ToList();
                        if (f.Count() > 0)
                        {
                            db.tblLogins.Remove(db.tblLogins.Find(f.FirstOrDefault().log_id));
                            db.SaveChanges();
                        }
                    }


                    tempLoginList.Remove(res.FirstOrDefault());

                    refreshData(rc_holidays.SelectedDates.ToArray().ToList(), empid);
                    rgAttendance.DataSource = tempLoginList;
                    rgAttendance.DataBind();
                }



                ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('" + dt.ToString() + "')", true);

            }
        }


    }
}