using Extermicon_Payroll_System.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Extermicon_Payroll_System.DAL
{
    public static class LoginHelper
    {

        public static int getEmployeeID(string _username)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {

                var user = db.tblUsers.Where(x => x.username == _username);
                if (user.Count() > 0)
                {
                    return user.FirstOrDefault().tblEmployee.emp_id;
                }
                return 0;
            }
        }

        public static string getEmployeeRole(string _username)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {

                var user = db.tblUsers.Where(x => x.username == _username);
                if (user.Count() > 0)
                {
                    return user.FirstOrDefault().tblRole.role;
                }
                return "";
            }
        }

        public static string getEmployeeName(string _username)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {

                var user = db.tblUsers.Where(x => x.username == _username);
                if (user.Count() > 0)
                {
                    return user.FirstOrDefault().tblEmployee.last_name + ", " + user.FirstOrDefault().tblEmployee.first_name;
                }
                return "Not Logged in";
            }
        }


        public static string user_login(string _passcode)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                var _user = db.tblUsers.Where(x => x.tblEmployee.employee_number ==_passcode ).ToList();

                //if user exists
                if (_user.Count() > 0)
                {

                    var _user_id = _user.FirstOrDefault().user_id;

                    var datetoday = DateTime.Now.ToString("yyyy-MM-dd");

                    var _user_log_in = from u in db.vw_log_in_history
                                       where u.user_id == _user_id
                                       && u.date == datetoday
                                       && u.in_time != null
                                       select u;

                    var _user_log_out = from u in db.vw_log_in_history
                                        where u.user_id == _user_id
                                        && u.date == datetoday
                                        && u.out_time != null
                                        select u;

                    //var _user_log_in = db.tblLogins.Where(x => x.user_id == _user_id &&
                    //    x.in_time.Value.ToShortDateString() == DateTime.Now.Date.ToShortDateString()).ToList();

                    //var _user_log_out = db.tblLogins.Where(x => x.user_id == _user_id &&
                    //    x.out_time.Value.Date == DateTime.Now.Date).ToList();

                    //check log_in for today

                    var ui = _user_log_in.Count();

                    var user_log_out = db.tblLogins.Where(x => x.log_id == _user_log_out.FirstOrDefault().log_id).FirstOrDefault();

                    var user_log_in = db.tblLogins.Where(x => x.log_id == _user_log_in.FirstOrDefault().log_id).FirstOrDefault();

                    if (_user_log_in.Count() > 0 && _user_log_out.Count() > 0)
                    {
                        user_log_in.out_time = DateTime.Now;
                        db.SaveChanges();
                        return "You have previously logged out, saving your last log.";
                    }
                    else if (_user_log_in.Count() > 0)
                    {
                        user_log_in.out_time = DateTime.Now;
                        db.SaveChanges();
                        return "You have successfully logged out!";
                    }
                    else if (_user_log_out.Count() > 0)
                    {
                        return "Something went wrong when we were trying to logged you in!";
                    }
                    else
                    {
                        tblLogin new_login = new tblLogin()
                        {
                            user_id = _user.First().user_id,
                            in_time = DateTime.Now,
                            date = DateTime.Now

                        };
                        db.tblLogins.Add(new_login);
                        db.SaveChanges();
                        return "You have successfully logged in!";
                    }
                }
                return "The employee number you entered does not exist!";
            }
        }
    }
}