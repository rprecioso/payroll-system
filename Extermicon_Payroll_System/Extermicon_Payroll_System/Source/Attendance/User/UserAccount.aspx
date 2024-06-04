<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="UserAccount.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Attendance.User.UserAccount" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_employee">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_employee" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rg_account">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rg_account" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>

            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>

    <telerik:RadGrid ID="rg_employee" OnItemCommand="rg_employee_ItemCommand" Skin="Metro" runat="server" CellSpacing="0" DataSourceID="edsEmployee" AllowAutomaticUpdates="True" GridLines="None">
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="emp_id" DataSourceID="edsEmployee">
            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>

            <Columns>
                <telerik:GridTemplateColumn DataField="emp_id" DataType="System.Int32" Display="False" FilterControlAltText="Filter emp_id column" HeaderText="Emp. ID" SortExpression="emp_id" UniqueName="emp_id">
                    <EditItemTemplate>

                        <asp:TextBox ID="emp_idTextBox" runat="server" Text='<%# Bind("emp_id") %>'></asp:TextBox>
                   
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="emp_idLabel" runat="server" Text='<%# Eval("emp_id") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="first_name" FilterControlAltText="Filter first_name column" HeaderText="First Name" SortExpression="first_name" UniqueName="first_name">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="middle_name" FilterControlAltText="Filter middle_name column" HeaderText="Middle Name" SortExpression="middle_name" UniqueName="middle_name">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="last_name" FilterControlAltText="Filter last_name column" HeaderText="Last Name" SortExpression="last_name" UniqueName="last_name">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="employee_number" FilterControlAltText="Filter employee_number column" HeaderText="Employee Number" SortExpression="employee_number" UniqueName="employee_number">
                    <EditItemTemplate>
                        <asp:TextBox ID="employee_numberTextBox" runat="server" Text='<%# Bind("employee_number") %>'></asp:TextBox>
                             <asp:CustomValidator ID="emp_numberValidator" runat="server" ErrorMessage="Invalid input"
                            ControlToValidate="employee_numberTextBox" ClientValidationFunction="" OnServerValidate="emp_numberValidator_ServerValidate">
                        </asp:CustomValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="employee_numberLabel" runat="server" Text='<%# Eval("employee_number") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>

            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>

    <hr />

    <telerik:RadGrid ID="rg_account" Skin="Metro" runat="server" DataSourceID="edsUser" AllowAutomaticUpdates="True" AutoGenerateEditColumn="True" CellSpacing="0" GridLines="None">
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="user_id" DataSourceID="edsUser">
            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>

            <Columns>
                <telerik:GridBoundColumn DataField="user_id" DataType="System.Int32" FilterControlAltText="Filter user_id column" HeaderText="User ID" Display="false" ReadOnly="True" SortExpression="user_id" UniqueName="user_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="username" FilterControlAltText="Filter username column" ReadOnly="true" HeaderText="Username" SortExpression="username" UniqueName="username">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="password" FilterControlAltText="Filter password column" HeaderText="Password" SortExpression="password" UniqueName="password">
                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn DataField="role_id" DataType="System.Int32" FilterControlAltText="Filter role_id column" ReadOnly="true" HeaderText="Role" SortExpression="role_id" UniqueName="role_id">
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="RadComboBox2" Enabled="false" ForeColor="Black" AutoPostBack="true" SelectedValue='<%#Bind ("role_id") %>' runat="server" DataSourceID="edsRole" DataTextField="role" DataValueField="role_id">
                            <DefaultItem Text="Select a role..." Value="0" />
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <telerik:RadComboBox ID="RadComboBox1" Enabled="false" ForeColor="Black" AutoPostBack="true" SelectedValue='<%#Bind ("role_id") %>' runat="server" DataSourceID="edsRole" DataTextField="role" DataValueField="role_id">
                            <DefaultItem Text="Select a role..." Value="0" />
                        </telerik:RadComboBox>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="passcode" FilterControlAltText="Filter passcode column" HeaderText="Login Code" SortExpression="passcode" UniqueName="passcode">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="sched_id" DataType="System.Int32" FilterControlAltText="Filter sched_id column" ReadOnly="true" Display="false" HeaderText="sched_id" SortExpression="sched_id" UniqueName="sched_id">
                </telerik:GridBoundColumn>
            </Columns>

            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>

    <asp:EntityDataSource ID="edsEmployee" AutoGenerateWhereClause="true" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EnableUpdate="True" EntitySetName="tblEmployees">
        <WhereParameters>
            <asp:SessionParameter Type="Int32" SessionField="emp_id" Name="emp_id" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="edsUser" runat="server" AutoGenerateWhereClause="true" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EnableUpdate="True" EntitySetName="tblUsers">
        <WhereParameters>
            <asp:SessionParameter Type="Int32" SessionField="emp_id" Name="emp_id" />
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="edsRole" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EntitySetName="tblRoles"></asp:EntityDataSource>

</asp:Content>
