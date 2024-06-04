<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="BatchLogs.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Attendance.Administrator.BatchLogs" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../../../Scripts/jquery-2.1.3.min.js"></script>
    <script src="../../../Scripts/knockout-3.2.0.js"></script>
    <script src="../../../Scripts/knockout.mapping-latest.js"></script>
    <script type="text/javascript">
        //function DisableDate(sender, eventArgs) {
        //    var date = eventArgs.get_renderDay().get_date();
        //    var dfi = sender.DateTimeFormatInfo;

        //    var formattedDate = dfi.FormatDate(date, dfi.ShortDatePattern);

        //    if (eventArgs.get_isSelecting() == true) {
        //        $.ajax({
        //            type: "POST",
        //            url: "BatchLogs.aspx/isPresent",
        //            data: JSON.stringify({ 'selectedDate': formattedDate }),
        //            contentType: "application/json; charset=utf-8",
        //            dataType: "json",
        //            async: true,
        //            cache: false,
        //            success: function (data) {
        //                //alert(data.d);
        //                //var dt = JSON.parse(data.d);
        //                //if (dt != null) {
        //                //    ko.mapping.fromJS(dt, {}, vm.SelectedDates);

        //                //}


        //                eventArgs.set_cancel(false);
        //                sender.unselectDate(date);
        //            },
        //            error: function(e)
        //            {
        //                //sender.unselectDate(date);
        //                //eventArgs.set_cancel(false);
        //            }
        //        });
        //    }

        //    $(document).ready(function () {

        //        function CalendarViewModel() {
        //            var self = this;
        //            self.SelectedDates = ko.observableArray("");
        //        }

        //        ko.applyBindings(window.vm = new CalendarViewModel());
        //    });


        //}
    </script>
    <style>
        .date-list
        {
            padding: 20px !important;
            width: 100% !important;
            height: 200px !important;
            overflow: auto !important;
            border: none !important;
          
        }
    </style>
    <div class="container-fluid">
        <div class="row">

            <%--     <div class="alert alert-info" role="alert">Insert/update employee's attendance.</div>--%>
            <div class="col-lg-12">
                <div class="container row form-inline">
                    <div class="form-group">
                        <div class="input-group" style="width: 30%;">
                            <span class="input-group-addon">Employee</span>
                            <div class="form-control">
                                <telerik:RadComboBox OnSelectedIndexChanged="rcmbEmployee_SelectedIndexChanged" ID="rcmbEmployee" Filter="Contains" AllowCustomText="true" AutoPostBack="true" AutoCompleteSeparator="|" Skin="Metro" runat="server" DataSourceID="edsEmployeeList" DataTextField="name" DataValueField="emp_id"></telerik:RadComboBox>
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

                <telerik:RadCalendar Skin="Metro" ID="rc_holidays" AutoPostBack="true" OnDayRender="rc_holidays_DayRender" OnSelectionChanged="rc_holidays_SelectionChanged" Width="100%" EnableMultiSelect="true" Height="300px" Font-Size="Large" runat="server">
                </telerik:RadCalendar>


            </div>
            <div class="col-lg-12">
                <div class="date-list">
                    <telerik:RadGrid ID="rgAttendance" OnItemCommand="rgAttendance_ItemCommand" AutoGenerateEditColumn="true"  OnNeedDataSource="rgAttendance_NeedDataSource" runat="server" CellSpacing="0" GridLines="None">

                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="dtstamp">
                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>

                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>

                            <Columns>
                                <telerik:GridBoundColumn DataField="dtstamp" DataType="System.DateTime" DataFormatString="{0:yyyy-MM-dd}" FilterControlAltText="Filter date column" HeaderText="Date" SortExpression="date" UniqueName="date">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="in_time" DataType="System.DateTime" DataFormatString="{0:hh:mm:ss tt}" FilterControlAltText="Filter in_time column" HeaderText="Time In" SortExpression="in_time" UniqueName="in_time">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="out_time" DataType="System.DateTime" DataFormatString="{0:hh:mm:ss tt}" FilterControlAltText="Filter out_time column" HeaderText="Time Out" SortExpression="out_time" UniqueName="out_time">
                                </telerik:GridBoundColumn>
                                 <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete"
                                        ConfirmText="Are you sure you want to delete this record?" HeaderStyle-Width="50px" />
                            </Columns>

                            <EditFormSettings EditFormType="Template">
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                                <FormTemplate>
                                    <table>
                                        <tr>
                                            <td>Date
                                            </td>
                                            <td>
              
                                                <asp:Label Text='<%#Eval("date") %>' runat="server" ID="lblDate"></asp:Label>
                                                <%--<telerik:RadDateTimePicker ID="rdtpDate" DbSelectedDate='<%#Bind("dtstamp") %>'  runat="server"></telerik:RadDateTimePicker>--%>

                                                <%--<telerik:RadTimePicker ID="RadTimePicker1" DbSelectedDate='<%#Bind("in_time") %>' runat="server"></telerik:RadTimePicker>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Time In
                                            </td>
                                            <td>
                                                <telerik:RadTimePicker ID="rtpIn" DbSelectedDate='<%#Bind("in_time") %>' runat="server"></telerik:RadTimePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Time Out
                                            </td>
                                            <td>
                                                <telerik:RadTimePicker ID="rtpOut" DbSelectedDate='<%#Bind("out_time") %>' runat="server"></telerik:RadTimePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                                    runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'></asp:Button>&nbsp;
                                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                        CommandName="Cancel"></asp:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </FormTemplate>
                            </EditFormSettings>
                        </MasterTableView>

                        <FilterMenu EnableImageSprites="False"></FilterMenu>

                    </telerik:RadGrid>
                </div>
                <%--                <asp:EntityDataSource ID="edsAtt" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EntitySetName="tblLogins">
                </asp:EntityDataSource>
                <asp:LinqDataSource ID="ldsAtt" runat="server" EntityTypeName="">
                </asp:LinqDataSource>

                <div class="col-lg-6">

                    <telerik:RadListBox AutoPostBack="true" Skin="Metro" ID="RadListBox1" OnSelectedIndexChanged="RadListBox1_SelectedIndexChanged" CssClass="date-list" runat="server"></telerik:RadListBox>
                </div>
                <div class="col-lg-6">
                    <div class="input-group" style="width: 100%; padding: 20px;">
                        <span class="input-group-addon">Time In</span>
                        <div class="form-control">
                            <telerik:RadTimePicker ID="rtpIn" runat="server"></telerik:RadTimePicker>
                        </div>

                        <%--    <input id="inpOvertime" type="number" runat="server" class="form-control" />
                    </div>
                    <div class="input-group" style="width: 100%; padding: 20px;">
                        <span class="input-group-addon">Time Out</span>
                        <div class="form-control">
                            <telerik:RadTimePicker ID="rtpOut" runat="server">
                            </telerik:RadTimePicker>
                        </div>
                    </div>
                  
                </div>--%>
                <div class="col-lg-12" style="padding: 10px;">
                    <asp:Button ID="btnAttSave" OnClick="btnAttSave_Click" CssClass="form-control btn-primary" runat="server" Text="Save Attendance" />
                </div>

                <%--   <div data-bind="foreach: vm.SelectedDates">
                    <label data-bind="text: date"></label>
                </div>--%>
            </div>
        </div>

    </div>

</asp:Content>
