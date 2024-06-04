﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="UserCalendar.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Attendance.User.UserCalendar" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <telerik:RadAjaxManager runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rg_holiday">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rc_holiday" LoadingPanelID="ralp1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel runat="server" ID="ralp1"></telerik:RadAjaxLoadingPanel>
    <telerik:RadCalendar Skin="Metro" ID="rc_holidays" AutoPostBack="true" OnSelectionChanged="rc_holidays_SelectionChanged" Width="100%" EnableMultiSelect="false" Height="300px" Font-Size="Large" runat="server">
        <CalendarDayTemplates>
            <telerik:DayTemplate ID="non_working_days" runat="server">
                <Content>
                    <div style="text-align: center; font-family: 'Segoe UI'; opacity: 0.3">
                        NW
                    </div>

                </Content>
            </telerik:DayTemplate>
        </CalendarDayTemplates>
    </telerik:RadCalendar>
    <hr />
    <telerik:RadGrid ID="rg_holiday" OnNeedDataSource="rg_holiday_NeedDataSource" Skin="Metro" OnItemCommand="rg_holiday_ItemCommand"
         OnItemUpdated="rg_holiday_ItemUpdated" runat="server" CellSpacing="0" GridLines="None">
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="holi_id">
            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>

            <Columns>
                <telerik:GridBoundColumn DataField="holi_id" DataType="System.Int32" FilterControlAltText="Filter holi_id column" HeaderText="ID" ReadOnly="True" SortExpression="holi_id" UniqueName="holi_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="holiday" FilterControlAltText="Filter holiday column" HeaderText="Holiday" SortExpression="holiday" UniqueName="holiday">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="description" FilterControlAltText="Filter description column" HeaderText="Description" SortExpression="description" UniqueName="description">
                    <EditItemTemplate>
                        <asp:TextBox ID="descriptionTextBox" TextMode="MultiLine" runat="server" Text='<%# Bind("description") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="descriptionLabel" runat="server" Text='<%# Eval("description") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="start_date" DataType="System.DateTime" FilterControlAltText="Filter start_date column" HeaderText="Start Date" SortExpression="start_date" UniqueName="start_date">
                    <EditItemTemplate>
                        <telerik:RadDatePicker ID="rdp_start" DbSelectedDate='<%# Bind("start_date") %>' runat="server"></telerik:RadDatePicker>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="start_dateLabel" runat="server" Text='<%# Eval("start_date","{0:yyyy/MM/dd}") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="end_date" DataType="System.DateTime" FilterControlAltText="Filter end_date column" HeaderText="End Date" SortExpression="end_date" UniqueName="end_date">
                    <EditItemTemplate>
                        <telerik:RadDatePicker ID="rdp_end" DbSelectedDate='<%# Bind("end_date") %>' runat="server"></telerik:RadDatePicker>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="end_dateLabel" runat="server" Text='<%# Eval("end_date","{0:yyyy/MM/dd}") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>

            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>
    <asp:EntityDataSource ID="edsHolidays" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" EntitySetName="tblHolidays">
    </asp:EntityDataSource>
</asp:Content>
