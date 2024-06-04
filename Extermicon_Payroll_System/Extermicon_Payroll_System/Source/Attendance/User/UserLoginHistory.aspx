<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="UserLoginHistory.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Attendance.User.UserLoginHistory" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container row form-inline">
        <div class="form-group">
            <label class="control-label" for="rdpStart">Start Date</label>
            <div class="form-control">
                <telerik:RadDatePicker ID="rdpStart" Skin="Metro" runat="server"></telerik:RadDatePicker>
            </div>

        </div>
        <div class="form-group">
            <label class="control-label" for="rdpEnd">End Date</label>
            <div class="form-control">
                <telerik:RadDatePicker Skin="Metro" ID="rdpEnd" runat="server"></telerik:RadDatePicker>
            </div>
        </div>
     
        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-info" OnClick="btnQuery_Click" runat="server">Query</asp:LinkButton>
    </div>
    <hr />
    <div class="container row">
        <telerik:RadGrid ID="rgUserLoginHistory" Skin="Metro" runat="server" CellSpacing="0" OnNeedDataSource="rgUserLoginHistory_NeedDataSource" GridLines="None">
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="log_id">
                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                    <HeaderStyle Width="20px"></HeaderStyle>
                </RowIndicatorColumn>

                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                    <HeaderStyle Width="20px"></HeaderStyle>
                </ExpandCollapseColumn>

                <Columns>
                    <telerik:GridBoundColumn DataField="log_id" Display="false" DataType="System.Int32" FilterControlAltText="Filter log_id column" HeaderText="ID" ReadOnly="True" SortExpression="log_id" UniqueName="log_id">
                    </telerik:GridBoundColumn>
                    <%--         <telerik:GridBoundColumn DataField="in_time" DataType="System.DateTime" FilterControlAltText="Filter in_time column" HeaderText="in_time" SortExpression="in_time" UniqueName="in_time">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="out_time" DataType="System.DateTime" FilterControlAltText="Filter out_time column" HeaderText="out_time" SortExpression="out_time" UniqueName="out_time">
                </telerik:GridBoundColumn>
               <telerik:GridBoundColumn DataField="user_id" DataType="System.Int32" FilterControlAltText="Filter user_id column" HeaderText="user_id" SortExpression="user_id" UniqueName="user_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="sched_id" DataType="System.Int32" FilterControlAltText="Filter sched_id column" HeaderText="sched_id" SortExpression="sched_id" UniqueName="sched_id">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="dtstamp" DataType="System.DateTime" FilterControlAltText="Filter dtstamp column" HeaderText="dtstamp" SortExpression="dtstamp" UniqueName="dtstamp">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="note" FilterControlAltText="Filter note column" HeaderText="note" SortExpression="note" UniqueName="note">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="schedule" FilterControlAltText="Filter schedule column" HeaderText="schedule" SortExpression="schedule" UniqueName="schedule">
                </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="date" FilterControlAltText="Filter date column" HeaderText="Date" SortExpression="date" UniqueName="date">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="hours_spent" DataType="System.Double" DataFormatString="{0:n2}" FilterControlAltText="Filter hours_spent column" HeaderText="Hours Spent" SortExpression="hours_spent" UniqueName="hours_spent">
                    </telerik:GridBoundColumn>
             <%--       <telerik:GridBoundColumn DataField="hours_over" DataType="System.Double" DataFormatString="{0:n2}" FilterControlAltText="Filter hours_over column" HeaderText="Overtime" SortExpression="hours_over" UniqueName="hours_over">
                    </telerik:GridBoundColumn>--%>
                    <%--            <telerik:GridBoundColumn DataField="name" FilterControlAltText="Filter name column" HeaderText="name" SortExpression="name" UniqueName="name">
                </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="log" FilterControlAltText="Filter log column" HeaderText="Log times" SortExpression="log" UniqueName="log">
                    </telerik:GridBoundColumn>
                    <%--   <telerik:GridBoundColumn DataField="emp_id" DataType="System.Int32" FilterControlAltText="Filter emp_id column" HeaderText="emp_id" SortExpression="emp_id" UniqueName="emp_id">
                </telerik:GridBoundColumn>--%>
                </Columns>

                <EditFormSettings>
                    <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>

            <FilterMenu EnableImageSprites="False"></FilterMenu>
        </telerik:RadGrid>
        <asp:EntityDataSource ID="edsUserLoginHistory" runat="server" AutoGenerateWhereClause="true" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EntitySetName="vw_log_in_history">
            <WhereParameters>
                <asp:SessionParameter SessionField="emp_id" Type="Int32" DefaultValue="0" Name="emp_id" />
            </WhereParameters>
        </asp:EntityDataSource>
    </div>

</asp:Content>
