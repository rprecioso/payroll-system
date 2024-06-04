using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Extermicon_Payroll_System.Source.Shared
{
    public partial class server_error : System.Web.UI.Page
    {
        string res = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            res = Request.QueryString["url"].ToString();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {    
            Response.Redirect(res);
        }
    }
}