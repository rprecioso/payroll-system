using Extermicon_Payroll_System.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Extermicon_Payroll_System.DAL
{
    public static class SalaryHelper
    {
        public static decimal getSalaryTypeMultiplier(int salary_type_id)
        {
            using (PH_DEDUCTIONSEntities db = new PH_DEDUCTIONSEntities())
            {
                return  db.SalaryTypes.Where(x => x.salary_type_id == salary_type_id).FirstOrDefault().multiplier30;
            }
        }
    }
}