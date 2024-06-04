<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="UserPayslip.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Payroll.User.UserPayslip" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function printPayslip(payslip_id) {
            $.ajax({
                type: "POST",
                url: "UserPayslip.aspx/printPayslip",
                data: JSON.stringify({ 'payslip_id': payslip_id }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (data) {
                    var dt = JSON.parse(data.d);
                    if (dt != null) {
                        window.open("/Source/Payroll/Administrator/Reports.aspx", "_self");
                    }
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <telerik:RadGrid ID="rgUserPayslip" Skin="Metro" runat="server" CellSpacing="0" DataSourceID="edsUserPayslip" GridLines="None">
                <MasterTableView AutoGenerateColumns="False" DataKeyNames="payslip_id,issue_date,COLA,basic_rate" DataSourceID="edsUserPayslip">
                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <Columns>

                        <telerik:GridTemplateColumn DataField="payslip_id" DataType="System.Int32" FilterControlAltText="Filter payslip_id column" HeaderText="" SortExpression="payslip_id" UniqueName="payslip_id">
                            <ItemTemplate>
                                <a onclick="printPayslip('<%# Eval("payslip_id") %>')"><i class="glyphicon glyphicon-download-alt"></i>&nbsp;Download</a>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="payslip_id" Display="false" DataType="System.Int32" FilterControlAltText="Filter payslip_id column" HeaderText="ID" SortExpression="payslip_id" UniqueName="payslip_id">
                            <EditItemTemplate>
                                <asp:TextBox ID="payslip_idTextBox" runat="server" Text='<%# Bind("payslip_id") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>

                                <asp:Label ID="payslip_idLabel" runat="server" Text='<%# Eval("payslip_id") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                         <telerik:GridBoundColumn DataField="name" FilterControlAltText="Filter name column" HeaderText="Employee" Display="false" SortExpression="name" UniqueName="name">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="issue_date" DataType="System.DateTime" DataFormatString="{0:yyyy-MM-dd}" FilterControlAltText="Filter issue_date column" HeaderText="Issued" ReadOnly="True" SortExpression="issue_date" UniqueName="issue_date">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="COLA" DataType="System.Decimal" FilterControlAltText="Filter COLA column" HeaderText="COLA" ReadOnly="True" SortExpression="COLA" UniqueName="COLA">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="basic_rate" ItemStyle-ForeColor="WhiteSmoke" Display="false" DataType="System.Decimal" FilterControlAltText="Filter basic_rate column" HeaderText="Daily Rate" ReadOnly="True" SortExpression="Daily Rate" UniqueName="basic_rate">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="period_start" DataType="System.DateTime" DataFormatString="{0:yyyy-MM-dd}" FilterControlAltText="Filter period_start column" HeaderText="Payroll Start" SortExpression="payroll_start" UniqueName="period_start">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="period_end" DataType="System.DateTime" DataFormatString="{0:yyyy-MM-dd}" FilterControlAltText="Filter period_end column" HeaderText="Payroll End" SortExpression="period_end" UniqueName="period_end">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="emp_id" DataType="System.Int32" FilterControlAltText="Filter emp_id column" HeaderText="emp_id" Visible="false" SortExpression="emp_id" UniqueName="emp_id">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="dayspresent" DataType="System.Decimal" DataFormatString="{0:n0}" FilterControlAltText="Filter dayspresent column" HeaderText="Days Present" SortExpression="dayspresent" UniqueName="dayspresent">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="amount" ItemStyle-ForeColor="WhiteSmoke" DataType="System.Decimal" Display="false" DataFormatString="{0:n2}" FilterControlAltText="Filter amount column" HeaderText="Pay" SortExpression="amount" UniqueName="amount">
                        </telerik:GridBoundColumn>

                        
                    </Columns>
                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                    </EditFormSettings>
                </MasterTableView>
                <FilterMenu EnableImageSprites="False"></FilterMenu>
            </telerik:RadGrid>
            <asp:EntityDataSource ID="edsUserPayslip" AutoGenerateWhereClause="true" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EntitySetName="vw_payslip_summary">
                <WhereParameters>
                    <asp:SessionParameter Type="Int32" Name="emp_id" SessionField="emp_id" />
                </WhereParameters>
            </asp:EntityDataSource>
        </div>
    </div>
</asp:Content>
