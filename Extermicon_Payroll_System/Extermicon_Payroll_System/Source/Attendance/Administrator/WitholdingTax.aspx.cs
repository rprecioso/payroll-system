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
    public partial class WitholdingTax : System.Web.UI.Page
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
                }
            }
        }

        protected string getSalaryType(string _salary_type_id)
        {
            int id;
            Int32.TryParse(_salary_type_id, out id);
            using (PH_DEDUCTIONSEntities pddb = new PH_DEDUCTIONSEntities())
            {
                var res = pddb.SalaryTypes.Where(x => x.salary_type_id == id);
                if (res.Count() <= 0)
                {
                    return "Salary Type Name";
                }
                return res.FirstOrDefault().name;
            }
        }

        protected string getTaxDependentType(string _tax_dependent_type_id)
        {
            int id;
            Int32.TryParse(_tax_dependent_type_id, out id);
            using (PH_DEDUCTIONSEntities pddb = new PH_DEDUCTIONSEntities())
            {
                var res = pddb.TaxDependentTypes.Where(x => x.tax_dependent_type_id == id);
                if (res.Count() <= 0)
                {
                    return "Tax Dependent Type Name";
                }
                return res.FirstOrDefault().description;
            }
        }
    }
}