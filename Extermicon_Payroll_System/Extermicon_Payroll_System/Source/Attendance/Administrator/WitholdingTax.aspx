<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="WitholdingTax.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Attendance.Administrator.WitholdingTax" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <div class="form-group">
            <div class="input-group">
                <label class="control-label">Tax Dependent Type</label>

                <telerik:RadComboBox ID="rcmbDependent" Skin="Metro" AutoPostBack="true" runat="server" DataSourceID="EDSDependent" DataTextField="description" DataValueField="tax_dependent_type_id"></telerik:RadComboBox>

            </div>
            <div class="input-group">
                <label class="control-label">Salary Type</label>
                <telerik:RadComboBox AutoPostBack="true" Skin="Metro" ID="rcmbSalary" runat="server" DataSourceID="EDSSalary" DataTextField="name" DataValueField="salary_type_id"></telerik:RadComboBox>

            </div>
        </div>

    </div>
    <telerik:RadGrid ID="rgWithholdingTax" Skin="Metro" ValidationSettings-EnableValidation="true" runat="server" AllowAutomaticDeletes="true" AllowAutomaticUpdates="True" AllowAutomaticInserts="True" AutoGenerateEditColumn="True" DataSourceID="EDSWHTax" CellSpacing="0" GridLines="None">
        <MasterTableView InsertItemDisplay="Top" CommandItemDisplay="Top" AutoGenerateColumns="False" EditMode="InPlace" DataKeyNames="wth_rate_id" DataSourceID="EDSWHTax">
            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>

            <Columns>
                <%--                <telerik:GridBoundColumn Display="false" DataField="wth_rate_id" DataType="System.Int32" FilterControlAltText="Filter wth_rate_id column" HeaderText="wth_rate_id" ReadOnly="True" SortExpression="wth_rate_id" UniqueName="wth_rate_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn Display="false" ReadOnly="true" DataField="salary_type_id" DataType="System.Int32" FilterControlAltText="Filter salary_type_id column" HeaderText="Salary Type" SortExpression="salary_type_id" UniqueName="salary_type_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn Display="false" ReadOnly="true" DataField="tax_dependent_type_id" DataType="System.Int32" FilterControlAltText="Filter tax_dependent_type_id column" HeaderText="Tax Dependent Type" SortExpression="tax_dependent_type_id" UniqueName="tax_dependent_type_id">
                </telerik:GridBoundColumn>--%>
                <telerik:GridTemplateColumn FilterControlAltText="Filter tax_dependent_type_id column" HeaderText="Tax Dependent Type" UniqueName="tax_dependent_type_id" Reorderable="False">
                    <ItemTemplate>

                        <asp:Label ID="lblTaxDependentType" runat="server" Text='<%# getTaxDependentType(Eval("tax_dependent_type_id").ToString()) %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="rcmbDependentType" Skin="Metro" runat="server" DataSourceID="EDSDependent" DataTextField="description" DataValueField="tax_dependent_type_id" SelectedValue='<%# Bind("tax_dependent_type_id") %>'></telerik:RadComboBox>

                    </EditItemTemplate>

                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn FilterControlAltText="Filter salary_type_id column" HeaderText="Salary Type" UniqueName="salary_type_id" Reorderable="False">
                    <ItemTemplate>
                        <asp:Label ID="lblSalaryType" runat="server" TextMode="Number" Text='<%# getSalaryType(Eval("salary_type_id").ToString()) %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <telerik:RadComboBox Skin="Metro" ID="rcmbSalary" runat="server" DataSourceID="EDSSalary" DataTextField="name" SelectedValue='<%# Bind("salary_type_id") %>' DataValueField="salary_type_id"></telerik:RadComboBox>

                    </EditItemTemplate>

                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="exemption" DataType="System.Decimal" FilterControlAltText="Filter exemption column" HeaderText="Exemption" SortExpression="exemption" UniqueName="exemption">
                    <EditItemTemplate>
                        <asp:TextBox ID="exemptionTextBox" TextMode="Number" runat="server" Text='<%# Bind("exemption") %>'>
                            
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="This field is required" ControlToValidate="exemptionTextBox"></asp:RequiredFieldValidator>
                        <asp:RangeValidator MinimumValue="0" MaximumValue="999999" ID="RangeValidator4" runat="server" ErrorMessage="Value must be a number" ControlToValidate="exemptionTextBox">
                        </asp:RangeValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="exemptionLabel" runat="server" Text='<%# Eval("exemption") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="percent_over" DataType="System.Decimal" FilterControlAltText="Filter percent_over column" HeaderText="Percent Over" SortExpression="percent_over" UniqueName="percent_over">
                    <EditItemTemplate>
                        <asp:TextBox TextMode="Number" ID="percent_overTextBox" runat="server" Text='<%# Bind("percent_over") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="This field is required" ControlToValidate="percent_overTextBox"></asp:RequiredFieldValidator>
                        <asp:RangeValidator MinimumValue="0" MaximumValue="999999" ID="RangeValidator3" runat="server" ErrorMessage="Value must be a number" ControlToValidate="percent_overTextBox">
                        </asp:RangeValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="percent_overLabel" runat="server" Text='<%# Eval("percent_over") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="flooring" DataType="System.Decimal" FilterControlAltText="Filter flooring column" HeaderText="Salary From" SortExpression="flooring" UniqueName="flooring">
                    <EditItemTemplate>
                        <asp:TextBox TextMode="Number" ID="flooringTextBox" runat="server" Text='<%# Bind("flooring") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="This field is required" ControlToValidate="flooringTextBox"></asp:RequiredFieldValidator>
                        <asp:RangeValidator MinimumValue="0" MaximumValue="999999" ID="RangeValidator2" runat="server" ErrorMessage="Value must be a number" ControlToValidate="flooringTextBox"></asp:RangeValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="flooringLabel" runat="server" Text='<%# Eval("flooring") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="ceiling" DataType="System.Decimal" FilterControlAltText="Filter ceiling column" HeaderText="Salary To" SortExpression="ceiling" UniqueName="ceiling">
                    <EditItemTemplate>
                        <asp:TextBox ID="ceilingTextBox" TextMode="Number" ValidateRequestMode="Enabled" runat="server" Text='<%# Bind("ceiling") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="This field is required" ControlToValidate="ceilingTextBox"></asp:RequiredFieldValidator>
                        <asp:RangeValidator MinimumValue="0" MaximumValue="999999" ID="RangeValidator1" runat="server" ErrorMessage="Value must be a number" ControlToValidate="ceilingTextBox"></asp:RangeValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="ceilingLabel" runat="server" Text='<%# Eval("ceiling") %>'></asp:Label>
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
    <asp:EntityDataSource ID="EDSDependent" runat="server" ConnectionString="name=PH_DEDUCTIONSEntities" DefaultContainerName="PH_DEDUCTIONSEntities" EnableFlattening="False" EntitySetName="TaxDependentTypes">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EDSSalary" runat="server" ConnectionString="name=PH_DEDUCTIONSEntities" DefaultContainerName="PH_DEDUCTIONSEntities" EnableFlattening="False" EntitySetName="SalaryTypes">
    </asp:EntityDataSource>
    <asp:EntityDataSource ID="EDSWHTax" AutoGenerateWhereClause="true" runat="server" EnableUpdate="true" EnableDelete="true" EnableInsert="true" ConnectionString="name=PH_DEDUCTIONSEntities" DefaultContainerName="PH_DEDUCTIONSEntities" EnableFlattening="False" EntitySetName="WithHoldingTaxRates">
        <WhereParameters>
            <asp:ControlParameter ControlID="rcmbDependent" PropertyName="SelectedValue" DbType="Int32" Name="tax_dependent_type_id" />
        </WhereParameters>

        <WhereParameters>
            <asp:ControlParameter ControlID="rcmbSalary" PropertyName="SelectedValue" DbType="Int32" Name="salary_type_id" />
        </WhereParameters>
    </asp:EntityDataSource>
</asp:Content>
