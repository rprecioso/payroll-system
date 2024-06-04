using Extermicon_Payroll_System.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Extermicon_Payroll_System.DAL
{
    public static class DeductionHelper
    {
        public static decimal getSSSContribution(decimal salary)
        {
            using (PH_DEDUCTIONSEntities db = new PH_DEDUCTIONSEntities())
            {
                var result = from u in db.SocialSecurityServiceRates
                             where u.salary_flooring <= salary
                             && u.salary_ceiling >= salary
                             select u;

                if (result.Count() > 0)
                {
                    return result.FirstOrDefault().employee_contribution ?? 0;
                }

                return 0;

            }
        }

        public static string getDependentDescription(int dep_id)
        {
            using (PH_DEDUCTIONSEntities db = new PH_DEDUCTIONSEntities())
            {
                var result = from d in db.TaxDependentTypes
                             where d.tax_dependent_type_id == dep_id
                             select d;
                return result.FirstOrDefault().description;
            }
        }

        public static decimal getHDMFContribution(decimal salary)
        {
            using (PH_DEDUCTIONSEntities db = new PH_DEDUCTIONSEntities())
            {
                var result = from u in db.PagibigRates
                             where u.salary_flooring <= salary
                             && u.salary_ceiling >= salary
                             select u;

                if (result.Count() > 0)
                {
                    return result.FirstOrDefault().employee_contribution * salary;
                }

                return 0;

            }
        }

        public static decimal getPhilhealthContribution(decimal salary)
        {
            using (PH_DEDUCTIONSEntities db = new PH_DEDUCTIONSEntities())
            {
                var result = from u in db.PhilHealthRates
                             where u.salary_flooring <= salary
                             && u.salary_ceiling >= salary
                             select u;

                if (result.Count() > 0)
                {
                    return (result.FirstOrDefault().employee_contribution ?? 0);
                }

                return 0;

            }
        }

        public static WithHoldingTaxRate getWHTax(decimal salary, int dependent_type, int salary_type)
        {
            using (PH_DEDUCTIONSEntities db = new PH_DEDUCTIONSEntities())
            {
                var result = from u in db.WithHoldingTaxRates
                             where u.flooring <= salary
                             && u.ceiling >= salary
                             && u.tax_dependent_type_id == dependent_type
                             && u.salary_type_id == salary_type
                             select u;

                if (result.Count() > 0)
                {
                    return (result.FirstOrDefault());
                }

                return null;

            }
        }
    }
}