using Extermicon_Payroll_System.DAL;
using Extermicon_Payroll_System.Helpers;
using Extermicon_Payroll_System.Model;
using System;
using System.Data.Entity;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace Extermicon_Payroll_System.Source.Payroll.Administrator
{
    public partial class Payslip : System.Web.UI.Page
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

                    rdpEnd.SelectedDate = DateTime.Now;
                    rdpStart.SelectedDate = DateTime.Now.AddDays(-15);
                }


            }
        }

        protected void rcmbEmployee_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

            var emp_id = Helper.StringToInt(rcmbEmployee.SelectedValue.ToString());
            var emp = EmployeeHelper.getEmployee(emp_id);
            if (emp != null)
            {


                var daysInPeriod = rdpEnd.SelectedDate.Value.Subtract(rdpStart.SelectedDate.Value).TotalDays;
                var dailyRate = Math.Abs((Convert.ToDouble(emp.basic_salary) / daysInPeriod)).ToString("0.00");
                var totalMinutePeriod = ((60 * 9) * daysInPeriod);
                var totalMinuteDay = (9 * 60);
                var OTRate = (Math.Abs((Convert.ToDouble(emp.basic_salary) / daysInPeriod)) / 9);
                var OTMinutes = EmployeeHelper.getEmployeeOT(emp_id, rdpStart.SelectedDate ?? DateTime.Now, rdpEnd.SelectedDate ?? DateTime.Now) / 60;
                var loginMinutes = EmployeeHelper.getEmployeeLogin(emp_id, rdpStart.SelectedDate ?? DateTime.Now, rdpEnd.SelectedDate ?? DateTime.Now);
                var sssCon = DeductionHelper.getSSSContribution(emp.basic_salary);
                var hdmfCon = DeductionHelper.getHDMFContribution(emp.basic_salary);
                var pHealth = DeductionHelper.getPhilhealthContribution(emp.basic_salary);
                var dayPresent = (loginMinutes / totalMinuteDay);



                inpEmployeeNumber.Value = emp.employee_number;
                inpBasicSalary.Value = emp.basic_salary.ToString();
                inpOTRate.Value = OTRate.ToString("0.00");
                inpDailyRate.Value = dailyRate;
                inpOvertime.Value = OTMinutes.ToString("0.00");
                inpDaysPresent.Value = inpDaysPresent.ToString();
                inpOTTotal.Value = (OTMinutes * OTRate).ToString("0.00");
                inpSSSCon.Value = sssCon.ToString();
                inpPagibigCon.Value = hdmfCon.ToString();
                inpPhilhealth.Value = pHealth.ToString();
                inpSSSLoan.Value = "0.00";
                inpPagibigLoan.Value = "0.00";
                inpCompanyLoan.Value = "0.00";
                inpAllowance.Value = "0.00";
                inpCola.Value = "0.00";
                inpLegalH.Value = "0.00";
                inpSpecialH.Value = "0.00";
                inpAdjustment.Value = "0.00";




            }

        }





        [WebMethod]
        public static bool savePayslip(string payslip, string start, string end)
        {
            try
            {
                using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                {
                    List<PayslipModel> payslipList = new JavaScriptSerializer().Deserialize<List<PayslipModel>>(payslip);
                    if (payslipList.Count() > 0)
                    {
                        var x = payslipList.FirstOrDefault();

                        var pm = new Model.Payslip()
                        {
                            basic_rate = Helper.DoubleToDecimal(x.dailyrate),
                            COLA = Helper.DoubleToDecimal(x.cola),
                            period_start = Helper.StringToDateTime(start),
                            period_end = Helper.StringToDateTime(end),
                            issue_date = DateTime.Now,
                            emp_id = x.emp_id,
                            dayspresent = Helper.DoubleToDecimal(x.dayspresent)
                        };
                        db.Payslips.Add(pm);
                        db.SaveChanges();

                        foreach (DeductionType ded in db.DeductionTypes.ToList())
                        {
                            var deduction = new Model.Deduction()
                            {
                                deduction_type_id = ded.deduction_type_id,
                                payslip_id = pm.payslip_id,
                                taxable = true,
                                quantity = 1
                            };

                            switch (ded.name.ToLower().Trim())
                            {
                                case "sss premium":
                                    deduction.rate = Helper.DoubleToDecimal(x.ssscon);
                                    break;

                                case "sss loan":
                                    deduction.rate = Helper.DoubleToDecimal(x.sssloan);
                                    break;

                                case "pag-ibig premium":
                                    deduction.rate = Helper.DoubleToDecimal(x.pagibigcon);
                                    break;

                                case "pag-ibig loan":
                                    deduction.rate = Helper.DoubleToDecimal(x.pagibigloan);
                                    break;

                                case "philhealth premium":
                                    deduction.rate = Helper.DoubleToDecimal(x.philhealthcon);
                                    break;

                                case "withholding tax":
                                    deduction.rate = Helper.DoubleToDecimal(x.whtax);
                                    break;

                                case "company loan":
                                    deduction.rate = Helper.DoubleToDecimal(x.companyloan);
                                    break;
                                default:
                                    break;
                            }

                            db.Deductions.Add(deduction);

                            db.SaveChanges();
                        }

                        foreach (EarningType ear in db.EarningTypes.ToList())
                        {
                            var earning = new Model.Earning()
                          {
                              earning_type_id = ear.earning_type_id,
                              payslip_id = pm.payslip_id,
                              taxable = true,
                              quantity = 1
                          };

                            switch (ear.name.ToLower())
                            {
                                case "basic":
                                    earning.rate = Helper.DoubleToDecimal(x.regulartotal);
                                    break;

                                case "allowance":
                                    earning.rate = Helper.DoubleToDecimal(x.allowance);
                                    break;

                                case "adjustment":
                                    earning.rate = Helper.DoubleToDecimal(x.adjustment);
                                    break;

                                case "regular overtime":
                                    earning.rate = Helper.DoubleToDecimal(x.overtimetotal);
                                    break;

                                case "legal holiday":
                                    earning.rate = Helper.DoubleToDecimal(x.legaltotal);
                                    break;

                                case "special holiday":
                                    earning.rate = Helper.DoubleToDecimal(x.specialtotal);
                                    break;

                                default:
                                    break;
                            }

                            db.Earnings.Add(earning);
                            db.SaveChanges();
                        }

                        Reports rep = new Reports();
                        rep.Session["payslip_id"] = pm.payslip_id;
                    }


                }


                return true;
            }
            catch (Exception)
            {

                return false;
            }

        }

        [WebMethod]
        public static string computeWHTax(string payslip, string start, string end)
        {
            //var _start = Helper.StringToDateTime(start);
            //var _end = Helper.StringToDateTime(end);

            //var diff = _end.Subtract(_start).TotalDays;

            //if (diff != 15)
            //{
            //    return "Error: Selected date range is not 15 days";
            //}

            List<PayslipModel> payslipList = new JavaScriptSerializer().Deserialize<List<PayslipModel>>(payslip);

            var x = payslipList.FirstOrDefault();

            try
            {
                //PayslipModel pm = new PayslipModel();
                //pm = x;

                //pm.recompute();
                x.dependent_type = EmployeeHelper.getEmployee(x.emp_id).tax_dependent_type_id ?? 0;
                x.dependent_description = DeductionHelper.getDependentDescription(x.dependent_type);
                x.salary_type = 5; //5 = semi-monthly
                x.startperiod = start;
                x.endperiod = end;
                x.recompute();

                JavaScriptSerializer js = new JavaScriptSerializer();
                return js.Serialize(payslipList);

            }
            catch (Exception)
            {

                JavaScriptSerializer js = new JavaScriptSerializer();
                return js.Serialize(payslipList);
            }



        }

        [WebMethod]
        public static string changeEmployee(int emp_id, string start, string end)
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                db.Configuration.ProxyCreationEnabled = false;
                var emp = EmployeeHelper.getEmployee(emp_id);

                if (emp == null)
                {
                    return null;
                }

                var empres = from e in db.tblEmployees
                             where e.emp_id == emp_id
                             select e;

                List<PayslipModel> pmList = new List<PayslipModel>();
                foreach (tblEmployee e in empres.ToList())
                {
                    var pm = new PayslipModel(e.emp_id, start, end, 5, e.tax_dependent_type_id ?? 0);
                    pm.dependent_description = DeductionHelper.getDependentDescription(e.tax_dependent_type_id ?? 0);
                    //pm.net_pay = pm.basic_total + pm.overtime_total - pm.deduction_total;
                    pmList.Add(pm);
                }


                JavaScriptSerializer js = new JavaScriptSerializer();
                return js.Serialize(pmList);
            }
        }

        protected void rdpStart_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
        {
            rdpEnd.SelectedDate = rdpStart.SelectedDate.Value.AddDays(15);
        }

    }
}