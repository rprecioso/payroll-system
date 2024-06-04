<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Attendance.Administrator.Account" %>

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

    <div class="form-inline">

        <telerik:RadComboBox ID="rcmbEmployee" AllowCustomText="true" Filter="Contains" OnSelectedIndexChanged="rcmbEmployee_SelectedIndexChanged" AutoPostBack="true" AutoCompleteSeparator="|" Skin="Metro" runat="server" DataTextField="name" DataValueField="emp_id"></telerik:RadComboBox>
        <%--    <asp:EntityDataSource ID="edsEmployeeList" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EntitySetName="vw_employee_list">
    
        </asp:EntityDataSource>--%>
    </div>
    <hr />
    <telerik:RadGrid ID="rg_employee" AllowAutomaticInserts="True" OnItemInserted="rg_employee_ItemInserted" OnItemUpdated="rg_employee_ItemUpdated" AllowAutomaticDeletes="True" Skin="Metro" runat="server" CellSpacing="0" DataSourceID="edsEmployee" AllowAutomaticUpdates="True" GridLines="None">
        <MasterTableView InsertItemDisplay="Top" CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="emp_id" DataSourceID="edsEmployee">
            <CommandItemSettings ExportToPdfText="Export to PDF" AddNewRecordText="Add New Employee"></CommandItemSettings>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>

            <Columns>
                <telerik:GridBoundColumn DataField="emp_id" Display="false" DataType="System.Int32" FilterControlAltText="Filter emp_id column" HeaderText="Emp. ID" ReadOnly="True" SortExpression="emp_id" UniqueName="emp_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="first_name" FilterControlAltText="Filter first_name column" HeaderText="First Name" SortExpression="first_name" UniqueName="first_name">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="middle_name" FilterControlAltText="Filter middle_name column" HeaderText="Middle Name" SortExpression="middle_name" UniqueName="middle_name">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="last_name" FilterControlAltText="Filter last_name column" HeaderText="Last Name" SortExpression="last_name" UniqueName="last_name">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="designation" FilterControlAltText="Filter designation column" HeaderText="Designation" SortExpression="designation" UniqueName="designation">
                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn DataField="cola" DataType="System.Decimal" FilterControlAltText="Filter cola column" HeaderText="Cola" SortExpression="cola" UniqueName="cola">
                    <EditItemTemplate>
                        <telerik:RadNumericTextBox ID="RadNumericTextBox1" runat="server"  Text='<%# Bind("cola") %>'></telerik:RadNumericTextBox>                        
                        <%--<asp:TextBox ID="colaTextBox" TextMode="Number" runat="server" Text='<%# Bind("cola") %>'></asp:TextBox>--%>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="colaLabel" runat="server" Text='<%# Eval("cola") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="status" FilterControlAltText="Filter status column" HeaderText="Status" SortExpression="status" UniqueName="status">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="employee_number" FilterControlAltText="Filter employee_number column" HeaderText="Employee Number" SortExpression="employee_number" UniqueName="employee_number">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="basic_salary" DataType="System.Decimal" FilterControlAltText="Filter basic_salary column" HeaderText="Basic Salary" SortExpression="basic_salary" UniqueName="basic_salary">
                    <EditItemTemplate>
                          <telerik:RadNumericTextBox ID="basic_salaryTextBox" runat="server"  Text='<%# Bind("basic_salary") %>'></telerik:RadNumericTextBox>     
                        
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="basic_salaryLabel" runat="server" Text='<%# Eval("basic_salary") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="tax_dependent_type_id" DataType="System.Int32" FilterControlAltText="Filter tax_dependent_type_id column" HeaderText="Dependent Type" SortExpression="tax_dependent_type_id" UniqueName="tax_dependent_type_id">
                    <InsertItemTemplate>
                        <telerik:RadComboBox ID="rcmbTaxDependentType" AutoPostBack="True" AutoCompleteSeparator="|" Skin="Metro" runat="server" SelectedValue='<%# Bind("tax_dependent_type_id") %>' DataSourceID="edsDependentList" DataTextField="description" DataValueField="tax_dependent_type_id"></telerik:RadComboBox>
                    </InsertItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="rcmbTaxDependentType" AutoPostBack="True" AutoCompleteSeparator="|" Skin="Metro" runat="server" SelectedValue='<%# Bind("tax_dependent_type_id") %>' DataSourceID="edsDependentList" DataTextField="description" DataValueField="tax_dependent_type_id"></telerik:RadComboBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <telerik:RadComboBox ID="rcmbTaxDependentType" Enabled="false" AutoPostBack="True" AutoCompleteSeparator="|" Skin="Metro" runat="server" SelectedValue='<%# Bind("tax_dependent_type_id") %>' DataSourceID="edsDependentList" DataTextField="description" DataValueField="tax_dependent_type_id"></telerik:RadComboBox>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete"
                    ConfirmText="Are you sure you want to delete this record?" HeaderStyle-Width="50px">
                    <HeaderStyle Width="50px"></HeaderStyle>
                </telerik:GridButtonColumn>
                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Edit"
                    ConfirmText="Are you sure you want to edit this record?" HeaderStyle-Width="50px">
                    <HeaderStyle Width="50px"></HeaderStyle>
                </telerik:GridButtonColumn>
            </Columns>

            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>

    <hr />

    <telerik:RadGrid ID="rg_account" OnItemInserted="rg_account_ItemInserted" OnItemUpdated="rg_account_ItemUpdated" OnItemDeleted="rg_account_ItemDeleted" ValidateRequestMode="Enabled" OnItemCreated="rg_account_ItemCreated" OnItemDataBound="rg_account_ItemDataBound" AllowAutomaticInserts="true" AutoGenerateEditColumn="true" AllowAutomaticDeletes="true" Skin="Metro" MasterTableView-EditMode="InPlace" runat="server" DataSourceID="edsUser" AllowAutomaticUpdates="True" CellSpacing="0" GridLines="None">
        <MasterTableView AutoGenerateColumns="False" InsertItemDisplay="Top" CommandItemDisplay="None" DataKeyNames="user_id" DataSourceID="edsUser">
            <CommandItemSettings AddNewRecordText="Add New User Account" ExportToPdfText="Export to PDF"></CommandItemSettings>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>

            <Columns>
                <telerik:GridBoundColumn DataField="user_id" Display="false" DataType="System.Int32" FilterControlAltText="Filter user_id column" HeaderText="User ID" ReadOnly="True" SortExpression="user_id" UniqueName="user_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="username" FilterControlAltText="Filter username column" HeaderText="Username" SortExpression="username" UniqueName="username">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="password" FilterControlAltText="Filter password column" HeaderText="Password" SortExpression="password" UniqueName="password">
                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn DataField="role_id" DataType="System.Int32" FilterControlAltText="Filter role_id column" HeaderText="Role" SortExpression="role_id" UniqueName="role_id">
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="RadComboBox2" Enabled="true" ForeColor="Black" AutoPostBack="true" SelectedValue='<%#Bind ("role_id") %>' runat="server" DataSourceID="edsRole" DataTextField="role" DataValueField="role_id">
                            <DefaultItem Text="Select a role..." Value="3" />
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <ItemTemplate>

                        <telerik:RadComboBox ID="RadComboBox1" Enabled="false" ForeColor="Black" AutoPostBack="true" SelectedValue='<%#Bind ("role_id") %>' runat="server" DataSourceID="edsRole" DataTextField="role" DataValueField="role_id">
                            <DefaultItem Text="Select a role..." Value="3" />

                        </telerik:RadComboBox>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn DataField="passcode" FilterControlAltText="Filter passcode column" HeaderText="Login Code" SortExpression="passcode" UniqueName="passcode">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="sched_id" DataType="System.Int32" FilterControlAltText="Filter sched_id column" ReadOnly="true" Display="false" HeaderText="sched_id" SortExpression="sched_id" UniqueName="sched_id">
                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn DataField="emp_id" DataType="System.Int32" Display="false" FilterControlAltText="Filter emp_id column" HeaderText="Employee" SortExpression="emp_id" UniqueName="emp_id">
                    <InsertItemTemplate>
                        <telerik:RadComboBox ID="rcmbEmployee2" AutoPostBack="True" AutoCompleteSeparator="|" Skin="Metro" runat="server" SelectedValue='<%# Bind("emp_id") %>' DataSourceID="edsEmployeeList" DataTextField="name" DataValueField="emp_id"></telerik:RadComboBox>
                    </InsertItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="emp_idLabel" runat="server" Text='<%# Eval("emp_id") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="emp_idLabel" runat="server" Text='<%# Eval("emp_id") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete"
                    ConfirmText="Are you sure you want to delete this record?" HeaderStyle-Width="50px" />
            </Columns>

            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>
    <asp:EntityDataSource ID="edsEmployeeList" AutoGenerateWhereClause="true" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EntitySetName="vw_employee_list">
        <WhereParameters>
            <asp:ControlParameter ControlID="rcmbEmployee" Type="Int32" Name="emp_id" PropertyName="SelectedValue" />
            <%--<asp:SessionParameter Type="Int32" SessionField="emp_id"  Name="emp_id" />--%>
        </WhereParameters>
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="edsEmployee" AutoGenerateWhereClause="true" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EnableInsert="true" EnableUpdate="True" EnableDelete="true" EntitySetName="tblEmployees">
        <WhereParameters>
            <asp:ControlParameter ControlID="rcmbEmployee" Type="Int32" Name="emp_id" PropertyName="SelectedValue" />
            <%--<asp:SessionParameter Type="Int32" SessionField="emp_id"  Name="emp_id" />--%>
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="edsUser" runat="server" AutoGenerateWhereClause="true" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableInsert="true" EnableDelete="true" EnableFlattening="False" EnableUpdate="True" EntitySetName="tblUsers">
        <WhereParameters>
            <asp:ControlParameter ControlID="rcmbEmployee" Type="Int32" Name="emp_id" PropertyName="SelectedValue" />
            <%--       <asp:SessionParameter Type="Int32" SessionField="emp_id" Name="emp_id" />--%>
        </WhereParameters>
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="edsDependentList" runat="server" AutoGenerateWhereClause="True" ConnectionString="name=PH_DEDUCTIONSEntities" DefaultContainerName="PH_DEDUCTIONSEntities" EnableFlattening="False" EntitySetName="TaxDependentTypes">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="edsRole" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EntitySetName="tblRoles">
    </asp:EntityDataSource>
</asp:Content>
