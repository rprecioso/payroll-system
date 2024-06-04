using Extermicon_Payroll_System.DAL;
using Extermicon_Payroll_System.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Extermicon_Payroll_System.Helpers;

namespace Extermicon_Payroll_System.Source.Attendance.Administrator
{
    public partial class Account : System.Web.UI.Page
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
                    using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                    {
                        var src = db.vw_employee_list.Where(x => x.emp_id != emp_id).ToList();
                        rcmbEmployee.DataSource = src;
                        rcmbEmployee.DataTextField = "name";
                        rcmbEmployee.DataValueField = "emp_id";
                        rcmbEmployee.DataBind();
                        rcmbEmployee.SelectedValue = src.FirstOrDefault().emp_id.ToString();
                    }
        
                }
            }

    
        }

        protected void rg_employee_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            StringBuilder errorMessage = new StringBuilder();
            bool hasError = false;

            if (e.CommandName == RadGrid.DeleteCommandName)
            {
                GridDataItem item = e.Item as GridDataItem;

                int emp_id = Convert.ToInt32(item.GetDataKeyValue("emp_id").ToString());
                using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                {
                    db.tblEmployees.Remove(db.tblEmployees.Where(x => x.emp_id == emp_id).FirstOrDefault());
                    db.SaveChanges();

                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Delete Successfull')", true);
                }
            }

            if (e.CommandName == RadGrid.PerformInsertCommandName)
            {
                GridEditFormItem item = e.Item as GridEditFormItem;
                string first_name = (item["first_name"].Controls[0] as TextBox).Text;
                string middle_name = (item["middle_name"].Controls[0] as TextBox).Text;
                string last_name = (item["last_name"].Controls[0] as TextBox).Text;

                string employee_number = (item["employee_number"].Controls[0] as TextBox).Text;

                double basic_salary = Helper.StringToDouble((item["basic_salary"].Controls[0] as TextBox).Text);
                double cola = Helper.StringToDouble((item["cola"].Controls[0] as TextBox).Text);

                using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                {
                    if ((db.tblEmployees.Where(x => x.employee_number == employee_number).Count() > 0))
                    {
                        e.Canceled = true;
                        errorMessage.Append("Employee Number is already in used.");
                        hasError = true;
                    }

                    if (first_name.Length < 2 || middle_name.Length < 2 || last_name.Length < 2 || employee_number.Length < 2)
                    {
                        errorMessage.Append("Names and Employee Number cannot be less than 2 characters");
                        hasError = true;
                        e.Canceled = true;
                    }


                    if (basic_salary < 0 || cola < 0)
                    {
                        errorMessage.Append("Basic Salary and Cola cannot be less than zero");
                        hasError = true;
                        e.Canceled = true;
                    }
                }

                if (hasError == true)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('" + errorMessage.ToString() + "')", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Insert Successfull')", true);
                }
            }

            if (e.CommandName == RadGrid.UpdateCommandName)
            {
                GridEditFormItem item = e.Item as GridEditFormItem;
                int emp_id = Helper.StringToInt((item["emp_id"].Controls[0] as TextBox).Text);
                string first_name = (item["first_name"].Controls[0] as TextBox).Text;
                string middle_name = (item["middle_name"].Controls[0] as TextBox).Text;
                string last_name = (item["last_name"].Controls[0] as TextBox).Text;

                string employee_number = (item["employee_number"].Controls[0] as TextBox).Text;

                double basic_salary = Helper.StringToDouble((item["basic_salary"].Controls[0] as TextBox).Text);
                double cola = Helper.StringToDouble((item["cola"].Controls[0] as TextBox).Text);

                using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                {
                    if ((db.tblEmployees.Where(x => x.employee_number == employee_number && x.emp_id != emp_id).Count() > 0))
                    {
                        e.Canceled = true;
                        errorMessage.Append("Employee Number is already in used.");
                        hasError = true;
                    }

                    if (first_name.Length < 2 || middle_name.Length < 2 || last_name.Length < 2 || employee_number.Length < 2)
                    {
                        errorMessage.Append("Names and Employee Number cannot be less than 2 characters");
                        hasError = true;
                        e.Canceled = true;
                    }


                    if (basic_salary < 0 || cola < 0)
                    {
                        errorMessage.Append("Basic Salary and Cola cannot be less than zero");
                        hasError = true;
                        e.Canceled = true;
                    }
                }

                if (hasError == true)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('" + errorMessage.ToString() + "')", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Update Successfull')", true);
                }
            }
            rg_employee.Rebind();
            rcmbEmployee.DataBind();
        }

        protected void rg_account_ItemCommand(object sender, GridCommandEventArgs e)
        {
            StringBuilder errorMessage = new StringBuilder();
            bool hasError = false;
            //if (e.CommandName == RadGrid.PerformInsertCommandName)
            //{

            //    GridDataItem item = e.Item as GridDataItem;
            //    //int emp_id = Convert.ToInt32(item.GetDataKeyValue("emp_id").ToString());
            //    string username = (item["username"].Controls[0] as TextBox).Text;
            //    string password = (item["password"].Controls[0] as TextBox).Text;
            //    string passcode = (item["passcode"].Controls[0] as TextBox).Text;
            //    string role = (item["role_id"].Controls[1] as RadComboBox).SelectedValue;

            //    using (ExtermiconDBEntities db = new ExtermiconDBEntities())
            //    {
            //        if ((db.tblUsers.Where(x => x.username == username).Count() > 0) || (db.tblUsers.Where(x => x.passcode == passcode).Count() > 0))
            //        {
            //            e.Canceled = true;
            //            errorMessage.Append("Username or Passcode is already in used.");
            //            hasError = true;
            //        }

            //        if (username.Length < 3 || password.Length < 3 || passcode.Length < 3)
            //        {
            //            errorMessage.Append(" Username or password cannot be less than 3 characters");
            //            hasError = true;
            //            e.Canceled = true;
            //        }


            //        if (hasError == true)
            //        {
            //            ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('" + errorMessage.ToString() + "')", true);
            //        }
            //        else
            //        {
            //            db.tblUsers.Add(new tblUser()
            //            {
            //                passcode = passcode,
            //                username = username,
            //                password = password,
            //                emp_id = Helper.StringToInt(rcmbEmployee.SelectedValue.ToString()),
            //                role_id = Helper.StringToInt(role)
            //            });
            //            db.SaveChanges();
            //            ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Insert Successfull')", true);
            //        }
            //    }
            //}

            if (e.CommandName == RadGrid.UpdateCommandName)
            {

                GridDataItem item = e.Item as GridDataItem;
                int user_id = Convert.ToInt32((item["user_id"].Controls[0] as TextBox).Text);
                string username = (item["username"].Controls[0] as TextBox).Text;
                string password = (item["password"].Controls[0] as TextBox).Text;
                string passcode = (item["passcode"].Controls[0] as TextBox).Text;

                using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                {
                    if ((db.tblUsers.Where(x => x.username == username && x.user_id != user_id).Count() > 0) || (db.tblUsers.Where(x => x.passcode == passcode && x.user_id != user_id).Count() > 0))
                    {
                        e.Canceled = true;
                        errorMessage.Append("Username or Passcode is already in used.");
                        hasError = true;
                    }

                    if (username.Length < 3 || password.Length < 3 || passcode.Length < 3)
                    {
                        errorMessage.Append(" Username or password cannot be less than 3 characters");
                        hasError = true;
                        e.Canceled = true;
                    }
                }

                if (hasError == true)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('" + errorMessage.ToString() + "')", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Update Successfull')", true);
                }
            }

            if (e.CommandName == RadGrid.DeleteCommandName)
            {

                GridDataItem item = e.Item as GridDataItem;

                int user_id = Convert.ToInt32(item.GetDataKeyValue("user_id").ToString());//Convert.ToInt32((item["user_id"].Controls[0] as TextBox).Text);
                using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                {
                    db.tblUsers.Remove(db.tblUsers.Where(x => x.user_id == user_id).FirstOrDefault());
                    db.SaveChanges();

                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Delete Successfull')", true);
                }
            }

            rg_account.Rebind();
            rcmbEmployee.DataBind();
        }

        protected void rg_account_ItemDataBound(object sender, GridItemEventArgs e)
        {

        }

        protected void rcmbEmployee_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            try
            {
                rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.None;
                RadComboBox employee = (RadComboBox)sender;
                if (EmployeeHelper.hasAccount(Convert.ToInt32(employee.SelectedValue)) == true)
                {
                    rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.None;

                }
                else
                {
                    rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.Top;
                }
            }
            catch (Exception)
            {

            }

            // employee.SelectedValue
        }

        protected void rg_account_ItemCreated(object sender, GridItemEventArgs e)
        {
            //if (e.Item is GridEditableItem && e.Item.IsInEditMode)
            //{
            //    GridEditableItem item = e.Item as GridEditableItem;
            //    GridTextBoxColumnEditor editor = (GridTextBoxColumnEditor)item.EditManager.GetColumnEditor("Username");
            //    TableCell cell = (TableCell)editor.TextBoxControl.Parent;

            //    RequiredFieldValidator validator = new RequiredFieldValidator();

            //    validator.ControlToValidate = editor.TextBoxControl.ID;
            //    validator.ErrorMessage = "*";
            //    cell.Controls.Add(validator);
            //}
        }

        protected void rg_account_ItemInserted(object sender, GridInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("username"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Username cannot be blank or has duplicate')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("password"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Password cannot be blank')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("passcode"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Passcode cannot be blank or has duplicate')", true);
                }

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Insert Successful')", true);
            }

            try
            {
                rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.None;
                RadComboBox employee = (RadComboBox)sender;
                if (EmployeeHelper.hasAccount(Convert.ToInt32(employee.SelectedValue)) == true)
                {
                    rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.None;

                }
                else
                {
                    rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.Top;
                }
            }
            catch (Exception)
            {

            }
        }

        protected void rg_account_ItemUpdated(object sender, GridUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("username"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Username cannot be blank or has duplicate')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("password"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Password cannot be blank')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("passcode"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Passcode cannot be blank or has duplicate')", true);
                }

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Update Successful')", true);
            }
        }

        protected void rg_account_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            try
            {
                rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.None;
                RadComboBox employee = (RadComboBox)sender;
                if (EmployeeHelper.hasAccount(Convert.ToInt32(employee.SelectedValue)) == true)
                {
                    rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.None;

                }
                else
                {
                    rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.Top;
                }
            }
            catch (Exception)
            {

            }
        }

        protected void rg_employee_ItemInserted(object sender, GridInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("first_name"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('First Name cannot be blank')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("last_name"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Last Name cannot be blank')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("uq"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Employee Number cannot be blank or has duplicate')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("basic_salary"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Basic Salary cannot be blank or contain letters')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("cola"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('COLA cannot be blank or contain letters')", true);
                }


                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("chk_employee"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Numeric values cannot be less than 0')", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Insert Successful')", true);

                string username = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value).Name;
                var emp_id = LoginHelper.getEmployeeID(username);
                Session["emp_id"] = emp_id;
                using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                {
                    var src = db.vw_employee_list.Where(x => x.emp_id != emp_id).ToList();
                    rcmbEmployee.DataSource = src;
                    rcmbEmployee.DataTextField = "name";
                    rcmbEmployee.DataValueField = "emp_id";
                    rcmbEmployee.DataBind();
                    rcmbEmployee.SelectedValue = src.FirstOrDefault().emp_id.ToString();
                }
            }

            try
            {
                rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.None;
                RadComboBox employee = (RadComboBox)sender;
                if (EmployeeHelper.hasAccount(Convert.ToInt32(employee.SelectedValue)) == true)
                {
                    rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.None;

                }
                else
                {
                    rg_account.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.Top;
                }
            }
            catch (Exception)
            {
                //ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Insert Successful')", true);

   
            }
        }

        protected void rg_employee_ItemUpdated(object sender, GridUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("first_name"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('First Name cannot be blank')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("last_name"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Last Name cannot be blank')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("uq"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Employee Number cannot be blank or has duplicate')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("basic_salary"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Basic Salary cannot be blank or contain letters')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("cola"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('COLA cannot be blank or contain letters')", true);
                }

                if (e.Exception.InnerException.Message.ToLower().ToString().Contains("chk_employee"))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Numeric values cannot be less than 0')", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), new Guid().ToString(), "alert('Update Successful')", true);

                string username = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value).Name;
                var emp_id = LoginHelper.getEmployeeID(username);
                Session["emp_id"] = emp_id;
                using (ExtermiconDBEntities db = new ExtermiconDBEntities())
                {
                    var src = db.vw_employee_list.Where(x => x.emp_id != emp_id).ToList();
                    rcmbEmployee.DataSource = src;
                    rcmbEmployee.DataTextField = "name";
                    rcmbEmployee.DataValueField = "emp_id";
                    rcmbEmployee.DataBind();
                    rcmbEmployee.SelectedValue = src.FirstOrDefault().emp_id.ToString();
                }
            }
        }
    }
}