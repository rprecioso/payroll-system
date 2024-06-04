<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="LoginReports.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Attendance.Administrator.LoginReports" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">

        <div class="row">
            <div class="col-lg-12">
                <div class="container row form-inline">

                    <div class="form-group">
                        <div class="input-group" style="width: 30%;">
                            <span class="input-group-addon">Start Date</span>
                            <div class="form-control">
                                <telerik:RadDatePicker ID="rdpStart" Skin="Metro" runat="server"></telerik:RadDatePicker>
                            </div>

                        </div>
                        <div class="input-group" style="width: 30%;">
                            <span class="input-group-addon">End Date</span>
                            <div class="form-control">
                                <telerik:RadDatePicker Skin="Metro" ID="rdpEnd" runat="server"></telerik:RadDatePicker>
                            </div>
                        </div>
                        <div class="input-group" style="width: 30%;">
                            <span class="input-group-addon">Employee</span>
                            <div class="form-control">
                                <telerik:RadComboBox ID="rcmbEmployee" CheckBoxes="true" Filter="Contains" AllowCustomText="true" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" AutoCompleteSeparator="|" Skin="Metro" runat="server" Font-Bold="false" DataSourceID="edsEmployeeList" DataTextField="name" DataValueField="emp_id"></telerik:RadComboBox>
                                <asp:EntityDataSource ID="edsEmployeeList" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EntitySetName="vw_employee_list">
                                </asp:EntityDataSource>
                            </div>
                        </div>
                    </div>

                    <asp:LinkButton ID="lbtnQuery" CssClass="btn btn-info" OnClick="lbtnQuery_Click" runat="server">Query</asp:LinkButton>

                </div>
            </div>
            <hr />
            <div class="col-lg-12">
                <rsweb:ReportViewer ID="rptLoginReports" Width="100%" Height="800" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                    <LocalReport ReportPath="Source\Attendance\Administrator\LoginReports.rdlc">
                    </LocalReport>
                </rsweb:ReportViewer>
            </div>
        </div>

    </div>
</asp:Content>
