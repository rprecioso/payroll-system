using Extermicon_Payroll_System.DAL;
using Extermicon_Payroll_System.Model;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace Extermicon_Payroll_System.Source.Attendance.User
{
    public partial class UserCalendar : System.Web.UI.Page
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
                    Session["emp_id"] = emp_id;
                }
                rc_holidays.SelectedDate = DateTime.Now;
                refreshHoliday();
            }


        }

        private List<RadCalendarDay> list_dates(DateTime _start, DateTime _end, string _content)
        {
            List<RadCalendarDay> list_dt = new List<RadCalendarDay>();
            TimeSpan ts = _end - _start;
            int _date_diff = ts.Days;
            for (int i = 0; i <= _date_diff; i++)
            {
                RadCalendarDay rcd = new RadCalendarDay();
                rcd.Date = _start.AddDays(i);
                rcd.ItemStyle.BackColor = Color.LightSteelBlue;
                rcd.ToolTip = _content;
                rcd.TemplateID = "non_working_days";
                rcd.Repeatable = Telerik.Web.UI.Calendar.RecurringEvents.DayAndMonth;
                list_dt.Add(rcd);
            }
            return list_dt;
        }

        private void refreshHoliday()
        {

            rc_holidays.Style.Clear();
            rc_holidays.SpecialDays.Clear();
            //int cnt = _holiday.get_holiday_list().Count();
            // var y = _holiday.get_holiday_list().Where(x => rc_holidays.SelectedDate.Month == x.start_date.Value.Month).ToList();


            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                var y = db.tblHolidays.ToList();
                foreach (tblHoliday item in y)
                {
                    foreach (RadCalendarDay rcd in list_dates(item.start_date.Value, item.end_date.Value, item.holiday + Environment.NewLine + item.description))
                    {
                        rc_holidays.SpecialDays.Add(rcd);
                    }
                }
                rc_holidays.DataBind();
            }
        }

        protected void rg_holiday_ItemUpdated(object sender, GridUpdatedEventArgs e)
        {
            refreshHoliday();
        }

        protected void rc_holidays_SelectionChanged(object sender, Telerik.Web.UI.Calendar.SelectedDatesEventArgs e)
        {
            refreshHoliday();
            string test = rc_holidays.CalendarView.ViewStartDate.Month.ToString();
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {

                var res = from ho in db.tblHolidays
                          where ho.start_date <= rc_holidays.SelectedDate
                          && ho.end_date >= rc_holidays.SelectedDate
                          select ho;
                rg_holiday.DataSource = res.ToList();
                rg_holiday.DataBind();
            }
            rc_holidays.DataBind();
        }

        protected void rg_holiday_ItemCommand(object sender, GridCommandEventArgs e)
        {
            refreshHoliday();
        }

        protected void rg_holiday_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                rg_holiday.DataSource = db.tblHolidays.ToList();
            }
        }


    }
}