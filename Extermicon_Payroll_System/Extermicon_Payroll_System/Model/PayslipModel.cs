using Extermicon_Payroll_System.DAL;
using Extermicon_Payroll_System.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Extermicon_Payroll_System.Model
{
    public class PayslipModel
    {
        public int emp_id { get; set; }
        public string startperiod { get; set; }
        public string endperiod { get; set; }
        public int salary_type { get; set; }
        public int dependent_type { get; set; }
        public string employee_name { get; set; }
        public string dependent_description { get; set; }


        public string employee_number { get; set; }
        public string designation { get; set; }
        public double basic_salary { get; set; }
        public string status { get; set; }
        public double hourlyrate { get; set; }
        public double dailyrate { get; set; }
        public double dayspresent { get; set; }
        public double daysperiod { get; set; }
        public double cola { get; set; }
        public double adjustment { get; set; }
        public double allowance { get; set; }

        public double overtimeregular { get; set; }
        public double undertimeregular { get; set; }
        public double fullregular { get; set; }

        public double periodmultiplier { get; set; }
        public double overtimerate { get; set; }
        public double sssloan { get; set; }
        public double pagibigloan { get; set; }
        public double companyloan { get; set; }
        public double overtimetotal { get; set; }
        public double undertimetotal { get; set; }
        public double ssscon { get; set; }
        public double pagibigcon { get; set; }
        public double philhealthcon { get; set; }

        public double fulllegal { get; set; }
        public double overtimelegal { get; set; }
        public double undertimelegal { get; set; }
        public double unworkedlegal { get; set; }

        public double fullspecial { get; set; }
        public double overtimespecial { get; set; }
        public double undertimespecial { get; set; }

        public int regularpresent { get; set; }
        public int legalpresent { get; set; }
        public int specialpresent { get; set; }


        public double legaltotal { get; set; }
        public double regulartotal { get; set; }
        public double specialtotal { get; set; }


        public double whtax { get; set; }

        public double basic_total { get; set; }

        public double overtime_total { get; set; }

        public double earning_total { get; set; }

        public double deduction_total { get; set; }

        public double undertime_total { get; set; }

        public double net_pay { get; set; }
        public PayslipModel()
        { }

        public PayslipModel(int _emp_id, string _start, string _end, int _sal_type, int _dep_type)
        {
            this.cola = 0;
            this.adjustment = 0;
            this.allowance = 0;
            this.sssloan = 0;
            this.pagibigloan = 0;
            this.companyloan = 0;

            this.emp_id = _emp_id;
            this.startperiod = _start;
            this.endperiod = _end;
            this.salary_type = _sal_type;

            this.dependent_type = _dep_type;


            recompute();
        }


        public void recompute()
        {
            var emp = getEmployeeInfo();
            var xM = SalaryHelper.getSalaryTypeMultiplier(this.salary_type);

            this.employee_name = emp.last_name + ", " + emp.first_name + " " + emp.middle_name;
            this.designation = emp.designation;
            this.status = emp.status;
            this.basic_salary = Helper.DecimalToDouble(emp.basic_salary);
            this.employee_number = emp.employee_number;
            this.cola = Helper.DecimalToDouble(emp.cola);
            var dayPr = getDaysPresent();

            this.daysperiod = 13;// getDaysPeriod(); //get days between payroll period
            this.dayspresent = dayPr.Count();


            //monthly salary * period multiplier(in case the computation is not for monthly / divided by days period
            this.dailyrate = Math.Round((this.basic_salary / Helper.DecimalToDouble(xM)) / (daysperiod), 2);
            this.hourlyrate = Math.Round(this.dailyrate / 9, 2);

            this.overtimerate = Math.Round(this.dailyrate / 9, 2);
            //this.overtimetotal = this.overtimeregular * this.overtimerate;
            //this.undertimetotal = this.undertimeregular * this.overtimerate;

            this.ssscon = Helper.DecimalToDouble(DeductionHelper.getSSSContribution(Helper.DoubleToDecimal(this.basic_salary)) / xM);
            this.pagibigcon = Helper.DecimalToDouble(DeductionHelper.getHDMFContribution(Helper.DoubleToDecimal(this.basic_salary)) / xM);
            this.philhealthcon = Helper.DecimalToDouble(DeductionHelper.getPhilhealthContribution(Helper.DoubleToDecimal(this.basic_salary)) / xM);

            this.fullregular = dayPr.Select(x => x.fullRegular).Sum();
            this.overtimeregular = Math.Round(dayPr.Select(x => x.overtimeRegular).Sum(), 2);
            this.undertimeregular = Math.Round(dayPr.Select(x => x.undertimeRegular).Sum(), 2);


            this.fullspecial = dayPr.Select(x => x.fullSpecial).Sum();
            this.overtimespecial = dayPr.Select(x => x.overtimeSpecial).Sum();
            this.undertimespecial = dayPr.Select(x => x.undertimeSpecial).Sum();

            this.fulllegal = dayPr.Select(x => x.fullLegal).Sum();
            this.overtimelegal = dayPr.Select(x => x.overtimeLegal).Sum();
            this.undertimelegal = dayPr.Select(x => x.undertimeLegal).Sum();
            this.unworkedlegal = dayPr.Select(x => x.unworkedLegal).Sum();


            //full(hrs) divide by 9 to get a day of work

            //daily rate + cola * 2
            this.legaltotal = (this.fulllegal / 9) * ((this.dailyrate + this.cola) * 2);
            this.legalpresent = Convert.ToInt32(this.fulllegal / 9);
            //add overtime
            this.legaltotal += (this.hourlyrate * this.overtimelegal * 2.6);
            //add undertime
            this.legaltotal -= (this.overtimerate * this.undertimelegal);
            //add unworked legal
            this.legaltotal += (this.hourlyrate * this.unworkedlegal);
            this.legaltotal = Math.Round(this.legaltotal);
            //daily rate x 1.3
            this.specialtotal = (this.fullspecial / 9) * (this.dailyrate * 1.3);
            this.specialpresent = Convert.ToInt32(this.fullspecial / 9);
            //add overtime
            this.specialtotal += (this.hourlyrate * this.overtimespecial * 1.69);
            //add undertime
            this.specialtotal -= (this.overtimerate * this.undertimespecial);
            this.specialtotal = Math.Round(this.specialtotal, 2);
            //regular
            this.regulartotal = (this.fullregular / 9) * (this.dailyrate + cola);
            this.regularpresent = Convert.ToInt32(this.fullregular / 9);
            ////add overtime
            this.regulartotal += (this.hourlyrate * this.overtimeregular);
            //add undertime
            this.regulartotal -= (this.overtimerate * this.undertimeregular);


            this.undertimetotal = Math.Round(this.undertimeregular * this.overtimerate, 2);
            this.overtimetotal = Math.Round(this.overtimeregular * this.overtimerate, 2);

            this.whtax = computeTax();

            this.basic_total = Math.Round(((this.fullregular / 9) * (this.dailyrate + cola)) + this.allowance + this.adjustment, 2);
            this.earning_total = Math.Round((this.overtimeregular * this.overtimerate) + this.specialtotal + this.legaltotal, 2);
            this.deduction_total = Math.Round(this.ssscon + this.sssloan + this.pagibigcon + this.pagibigloan + this.philhealthcon + this.companyloan + this.whtax + this.undertimeregular, 2);

            this.overtime_total = Math.Round((this.overtimelegal + this.overtimespecial + this.overtimelegal) * this.hourlyrate, 2); //this.specialtotal + this.legaltotal + (this.overtimeregular * this.hourlyrate);
            this.undertime_total = Math.Round((this.undertimespecial + this.undertimeregular + this.undertimelegal) * this.hourlyrate, 2);


            this.net_pay = Math.Round(((this.fullregular / 9) * (this.dailyrate + cola)) + this.earning_total - deduction_total, 2);
        }

        private double computeTax()
        {
            var earn = this.adjustment + (this.overtimeregular * this.overtimerate) + this.specialtotal + this.legaltotal + ((this.fullregular / 9) * (this.dailyrate + cola));
            var deduct = this.ssscon + this.sssloan + this.pagibigcon + this.pagibigloan + this.philhealthcon + this.companyloan + this.allowance;
            var taxableIncome = earn - deduct;
            if (taxableIncome > 0)
            {
                var tax = DeductionHelper.getWHTax(Helper.DoubleToDecimal(taxableIncome), this.dependent_type, 5);
                var taxExemption = Helper.DecimalToDouble(tax.exemption ?? 0);
                var taxOver = Helper.DecimalToDouble(tax.percent_over ?? 0);
                var baseTax = Helper.DecimalToDouble(tax.flooring ?? 0);

                var WHTax = ((taxableIncome - baseTax) * taxOver) + taxExemption;
                return Math.Round(WHTax, 2);
            }
            return 0;
        }

        private double getDaysPeriod()
        {
            double weekend = 0.0;

            var totDays = DateTime.Parse(this.endperiod).Subtract(DateTime.Parse(this.startperiod)).TotalDays;
            var dt = DateTime.Parse(this.startperiod);
            for (int i = 0; i < totDays; i++)
            {

                if (dt.DayOfWeek == DayOfWeek.Saturday || dt.DayOfWeek == DayOfWeek.Sunday)
                {
                    weekend += 1;
                }
                dt = dt.AddDays(1);
            }
            return totDays - weekend;
        }

        private tblEmployee getEmployeeInfo()
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {
                return db.tblEmployees.Where(x => x.emp_id == this.emp_id).FirstOrDefault();
            }
        }

        private List<Attendance> getDaysPresent()
        {
            using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            {

                var start = DateTime.Parse(this.startperiod);
                var end = DateTime.Parse(this.endperiod);

                var totDays = end.Subtract(start).TotalDays;

                List<Attendance> attList = new List<Attendance>();
                ////var employeeLogins = from u in db.vw_log_in_history
                ////                     where u.emp_id == this.emp_id
                ////                     && u.dtstamp >= start
                ////                     && u.dtstamp <= end && u.out_time != null
                ////                     select u;

                var dt = start;

                for (int i = 0; i < totDays; i++)
                {
                    var h = dt.ToString("yyyy-MM-dd");
                    var employeeLogins = from u in db.vw_log_in_history
                                         where u.emp_id == this.emp_id
                                         && u.date == h
                                         && u.out_time != null
                                         select u;

                    var empLog = employeeLogins.FirstOrDefault();
                    bool isPresent = employeeLogins.Count() > 0;
                    Attendance newAtt = new Attendance();

                    var holiday = db.tblHolidays.Where(x => x.start_date <= dt && x.end_date >= dt);

                    bool isHoliday = holiday.Count() > 0;

                    bool hasData = false;
                    //Holiday
                    if (isHoliday == true)
                    {
                        var hol = holiday.FirstOrDefault();
                        if (isPresent == true)
                        {


                            var diff = empLog.out_time.Value.Subtract(empLog.in_time.Value);

                            //Legal
                            if (hol.description.ToLower().Contains("legal"))
                            {
                                if (diff.TotalHours < 9)
                                {
                                    newAtt.fullLegal = 9;
                                    newAtt.undertimeLegal = 9 - diff.TotalHours;
                                    hasData = true;
                                }

                                if (diff.TotalHours >= 9)
                                {
                                    newAtt.fullLegal = 9;
                                    newAtt.overtimeLegal = diff.TotalHours - 9;
                                    hasData = true;
                                }
                            }

                            //Special
                            if (hol.description.ToLower().Contains("special"))
                            {
                                if (diff.TotalHours < 9)
                                {
                                    newAtt.fullSpecial = 9;
                                    newAtt.undertimeSpecial = 9 - diff.TotalHours;
                                    hasData = true;
                                }

                                if (diff.TotalHours >= 9)
                                {
                                    newAtt.fullSpecial = 9;
                                    newAtt.overtimeSpecial = diff.TotalHours - 9;
                                    hasData = true;
                                }
                            }
                        }
                        else if (isPresent == false && hol.description.ToLower().Contains("legal"))
                        {
                            newAtt.unworkedLegal = 9;
                            hasData = true;
                        }

                    }

                    //holiday=false but present=true
                    else
                    {
                        if (isPresent == true)
                        {
                            var diff = empLog.out_time.Value.Subtract(empLog.in_time.Value);

                            if (diff.TotalHours < 9)
                            {
                                newAtt.fullRegular = 9;
                                newAtt.undertimeRegular = 9 - diff.TotalHours;
                                hasData = true;
                            }

                            if (diff.TotalHours >= 9)
                            {
                                newAtt.fullRegular = 9;
                                newAtt.overtimeRegular = diff.TotalHours - 9;
                                hasData = true;
                            }
                        }
                    }
                    if (hasData == true)
                    {
                        newAtt.dateTimeStamp = dt;
                        attList.Add(newAtt);
                    }
                    dt = dt.AddDays(1);
                }
                return attList;
            }
        }

    }

    public class Attendance
    {

        public DateTime dateTimeStamp { get; set; }

        public double fullRegular { get; set; }
        public double overtimeRegular { get; set; }
        public double undertimeRegular { get; set; }

        public double fullSpecial { get; set; }
        public double overtimeSpecial { get; set; }
        public double undertimeSpecial { get; set; }

        public double unworkedLegal { get; set; }

        public double fullLegal { get; set; }
        public double overtimeLegal { get; set; }
        public double undertimeLegal { get; set; }



    }
}