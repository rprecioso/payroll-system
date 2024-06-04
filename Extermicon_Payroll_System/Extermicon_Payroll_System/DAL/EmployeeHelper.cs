using Extermicon_Payroll_System.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Extermicon_Payroll_System.DAL
{
    public class EmployeePayslip
    { 
    
    }

    public static class EmployeeHelper
    {

        public static tblEmployee getEmployee(int emp_id)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                var employee = db.tblEmployees.Find(emp_id);
                return employee;
                //if (employee != null)
                //{

                //}
            }
        }

        public static tblUser getEmp(int emp_id)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {



                var employee = db.tblEmployees.Find(emp_id);
                if (employee.tblUsers.Count() > 0)
                {
                    return employee.tblUsers.FirstOrDefault();
                }

                return null;
                //if (employee != null)
                //{

                //}
            }
        }

        public static bool hasDuplicate(string emp_num)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                var employee = db.tblEmployees.Where(x => x.employee_number.Contains(emp_num) == true);

                if (employee.Count() > 0)
                {
                    return true;
                }
                return false;
            }
        }

        public static bool hasAccount(int emp_id)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                var employee = db.tblEmployees.Find(emp_id);

                if (employee.tblUsers.Count() > 0)
                { 
          
                    return true;
                }
                return false;
            }
        }

        public static double getEmployeeSpecialH(int emp_id, DateTime start, DateTime end)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                //var employeeLogins = db.vw_log_in_history.Where(x => x.emp_id == emp_id && x.dtstamp).ToList();

                var employeeLogins = from u in db.vw_log_in_history
                                     where u.emp_id == emp_id
                                     && u.dtstamp >= start
                                     && u.dtstamp <= end
                                     select u;
                //TimeSpan minutes = new TimeSpan();
                double minutes = 0.0;
                foreach (vw_log_in_history lih in employeeLogins.ToList())
                {
                    var diff = lih.out_time.Value.Subtract(lih.in_time.Value);

                    minutes += diff.TotalMinutes;
                }

                return minutes;
                //return employee;
                //if (employee != null)
                //{

                //}
            }
        }

        public static double getEmployeeLegalH(int emp_id, DateTime start, DateTime end)
        {


            List<DateTime> specialHolidays = new List<DateTime>();

            List<DateTime> legalHolidays = new List<DateTime>();

            List<DateTime> weekend = new List<DateTime>();



            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                //var employeeLogins = db.vw_log_in_history.Where(x => x.emp_id == emp_id && x.dtstamp).ToList();

                var employeeLogins = from u in db.vw_log_in_history
                                     where u.emp_id == emp_id
                                     && u.dtstamp >= start
                                     && u.dtstamp <= end
                                     select u;

                //double specialHEarnings = 0.0;

                foreach (vw_log_in_history lih in employeeLogins.ToList())
                {
                    var holiday = db.tblHolidays.Where(x => x.start_date <= lih.dtstamp && x.end_date >= lih.dtstamp);
                    if (holiday.Count() > 0)
                    {
                        if (holiday.FirstOrDefault().description.ToLower().Contains("legal"))
                        {
                            legalHolidays.Add(lih.dtstamp ?? DateTime.Now);

                            var diff = lih.out_time.Value.Subtract(lih.in_time.Value);

                            if (diff.TotalHours < 9)
                            { 
                            
                            }

                            if (diff.TotalHours > 9)
                            { 
                            
                            }

                           // minutes += diff.TotalMinutes;

                        }
                    }
                }


                //TimeSpan minutes = new TimeSpan();
                double minutes = 0.0;
                foreach (vw_log_in_history lih in employeeLogins.ToList())
                {
                    var diff = lih.out_time.Value.Subtract(lih.in_time.Value);

                    minutes += diff.TotalMinutes;
                }

                return minutes;
                //return employee;
                //if (employee != null)
                //{

                //}
            }
        }

        public static double getEmployeeLogin(int emp_id, DateTime start, DateTime end)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                //var employeeLogins = db.vw_log_in_history.Where(x => x.emp_id == emp_id && x.dtstamp).ToList();

                var employeeLogins = from u in db.vw_log_in_history
                                     where u.emp_id == emp_id
                                     && u.dtstamp >= start
                                     && u.dtstamp <= end
                                     select u;
                //TimeSpan minutes = new TimeSpan();
                double minutes = 0.0;
                foreach (vw_log_in_history lih in employeeLogins.ToList())
                {
                    var diff = lih.out_time.Value.Subtract(lih.in_time.Value);

                    minutes += diff.TotalMinutes;
                }

                return minutes;
                //return employee;
                //if (employee != null)
                //{

                //}
            }
        }

        public static double getEmployeeOT(int emp_id, DateTime start, DateTime end)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                //var employeeLogins = db.vw_log_in_history.Where(x => x.emp_id == emp_id).ToList();

                var employeeLogins = from u in db.vw_log_in_history
                                     where u.emp_id == emp_id
                                     && u.dtstamp >= start
                                     && u.dtstamp <= end
                                     select u;
                //TimeSpan minutes = new TimeSpan();
                double minutes = 0.0;
                foreach (vw_log_in_history lih in employeeLogins.ToList())
                {
                    var diff = lih.out_time.Value.Subtract(lih.in_time.Value);

                    if (diff.TotalHours > 9)
                    {

                        minutes += diff.TotalMinutes - (9 * 60);
                    }
                    //minutes += diff.TotalHours;
                }

                return minutes;
                //return employee;
                //if (employee != null)
                //{

                //}
            }
        }
    }
}