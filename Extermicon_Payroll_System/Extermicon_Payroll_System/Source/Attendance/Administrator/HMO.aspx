<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="HMO.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Attendance.Administrator.HMO" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadGrid ID="rgHMO" Skin="Metro" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateEditColumn="True" runat="server" DataSourceID="edsHMO" CellSpacing="0" GridLines="None">

        <MasterTableView CommandItemDisplay="Top" InsertItemDisplay="Top" EditMode="InPlace" AllowAutomaticUpdates="true" AutoGenerateColumns="False" DataKeyNames="philhealth_rate_id" DataSourceID="edsHMO">
            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>

            <Columns>
                <telerik:GridBoundColumn Display="false" DataField="philhealth_rate_id" DataType="System.Int32" FilterControlAltText="Filter philhealth_rate_id column" HeaderText="philhealth_rate_id" ReadOnly="True" SortExpression="philhealth_rate_id" UniqueName="philhealth_rate_id">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="salary_flooring" DataType="System.Decimal" FilterControlAltText="Filter salary_flooring column" HeaderText="Salary From" SortExpression="salary_flooring" UniqueName="salary_flooring">
                    <EditItemTemplate>
                        <asp:TextBox ID="salary_flooringTextBox" runat="server" TextMode="Number" Text='<%# Bind("salary_flooring") %>'></asp:TextBox>
                      
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="This field is required" ControlToValidate="salary_flooringTextBox"></asp:RequiredFieldValidator>
                        <asp:RangeValidator MinimumValue="0" MaximumValue="999999" ID="RangeValidator4" runat="server" ErrorMessage="Value must be a number" ControlToValidate="salary_flooringTextBox"></asp:RangeValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="salary_flooringLabel" runat="server" Text='<%# Eval("salary_flooring") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="salary_ceiling" DataType="System.Decimal" FilterControlAltText="Filter salary_ceiling column" HeaderText="Salary To" SortExpression="salary_ceiling" UniqueName="salary_ceiling">
                    <EditItemTemplate>
                        <asp:TextBox ID="salary_ceilingTextBox" runat="server" TextMode="Number" Text='<%# Bind("salary_ceiling") %>'></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="This field is required" ControlToValidate="salary_ceilingTextBox"></asp:RequiredFieldValidator>
                        <asp:RangeValidator MinimumValue="0" MaximumValue="999999" ID="RangeValidator3" runat="server" ErrorMessage="Value must be a number" ControlToValidate="salary_ceilingTextBox"></asp:RangeValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="salary_ceilingLabel" runat="server" Text='<%# Eval("salary_ceiling") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="employee_contribution" DataType="System.Decimal" FilterControlAltText="Filter employee_contribution column" HeaderText="Employee Contribution" SortExpression="employee_contribution" UniqueName="employee_contribution">
                    <EditItemTemplate>
                        <asp:TextBox ID="employee_contributionTextBox" TextMode="Number" runat="server" Text='<%# Bind("employee_contribution") %>'></asp:TextBox>
                       
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="This field is required" ControlToValidate="employee_contributionTextBox"></asp:RequiredFieldValidator>
                        <asp:RangeValidator MinimumValue="0" MaximumValue="999999" ID="RangeValidator2" runat="server" ErrorMessage="Value must be a number" ControlToValidate="employee_contributionTextBox"></asp:RangeValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="employee_contributionLabel" runat="server" Text='<%# Eval("employee_contribution") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="employer_contribution" DataType="System.Decimal" FilterControlAltText="Filter employer_contribution column" HeaderText="Employer Contribution" SortExpression="employer_contribution" UniqueName="employer_contribution">
                    <EditItemTemplate>
                        <asp:TextBox ID="employer_contributionTextBox" TextMode="Number" runat="server" Text='<%# Bind("employer_contribution") %>'></asp:TextBox>
                       
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="This field is required" ControlToValidate="employer_contributionTextBox"></asp:RequiredFieldValidator>
                        <asp:RangeValidator MinimumValue="0" MaximumValue="999999" ID="RangeValidator1" runat="server" ErrorMessage="Value must be a number" ControlToValidate="employer_contributionTextBox"></asp:RangeValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="employer_contributionLabel" runat="server" Text='<%# Eval("employer_contribution") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete"
                    ConfirmText="Are you sure you want to delete this record?" HeaderStyle-Width="50px">
                    <HeaderStyle Width="50px"></HeaderStyle>
                </telerik:GridButtonColumn>
            </Columns>

            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>

    </telerik:RadGrid>
    <asp:EntityDataSource ID="edsHMO" runat="server" EnableDelete="true" EnableInsert="true" ConnectionString="name=PH_DEDUCTIONSEntities" DefaultContainerName="PH_DEDUCTIONSEntities" EnableFlattening="False" EnableUpdate="True" EntitySetName="PhilHealthRates">
    </asp:EntityDataSource>
</asp:Content>
