<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Payslip.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Payroll.Administrator.Payslip" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../../../Scripts/knockout-3.2.0.js"></script>
    <script src="../../../Scripts/knockout.mapping-latest.js"></script>
    <script>

        $(document).ready(function () {
            $('#rootwizard').bootstrapWizard();

            function PayslipViewModel() {
                var self = this;
                self.Payslip = ko.observableArray("");
            }

            ko.applyBindings(window.vm = new PayslipViewModel());
        });



        function printPayslip() {


            var _emp_id = $find('<%=rcmbEmployee.ClientID %>').get_selectedItem().get_value();
            var _salary_type = 5;// $find('=rcmbSalaryType.ClientID').get_selectedItem().get_value();
            //var _dependent_type = $find('rcmbDependent.ClientID %>').get_selectedItem().get_value();
            var _start = $find("<%=rdpStart.ClientID %>").get_dateInput().get_selectedDate().format("yyyy/MM/dd");
            var _end = $find("<%=rdpEnd.ClientID %>").get_dateInput().get_selectedDate().format("yyyy/MM/dd");

            //vm.Payslip[0].dependent_type(_dependent_type);
            //vm.Payslip[0].salary_type(_salary_type);
            //vm.Payslip[0].startperiod(_start);
            //vm.Payslip[0].endperiod(_end);
            //alert(vm.Payslip[0].companyloan);

            $.ajax({
                type: "POST",
                url: "Payslip.aspx/savePayslip",
                data: JSON.stringify({ 'payslip': ko.toJSON(vm.Payslip), 'start': _start, 'end': _end }),
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

        function savePayslip() {


            var _emp_id = $find('<%=rcmbEmployee.ClientID %>').get_selectedItem().get_value();
            var _salary_type = 5;//$find('=rcmbSalaryType.ClientID %>').get_selectedItem().get_value();
            //var _dependent_type = $find('rcmbDependent.ClientID %>').get_selectedItem().get_value();
            var _start = $find("<%=rdpStart.ClientID %>").get_dateInput().get_selectedDate().format("yyyy/MM/dd");
            var _end = $find("<%=rdpEnd.ClientID %>").get_dateInput().get_selectedDate().format("yyyy/MM/dd");

            //vm.Payslip[0].dependent_type(_dependent_type);
            //vm.Payslip[0].salary_type(_salary_type);
            //vm.Payslip[0].startperiod(_start);
            //vm.Payslip[0].endperiod(_end);
            //alert(vm.Payslip[0].companyloan);

            $.ajax({
                type: "POST",
                url: "Payslip.aspx/savePayslip",
                data: JSON.stringify({ 'payslip': ko.toJSON(vm.Payslip), 'start': _start, 'end': _end }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (data) {
                    var dt = JSON.parse(data.d);
                    if (dt != null) {
                        alert('Payslip Saved!');
                        ko.mapping.fromJS(dt, {}, vm.Payslip);

                    }
                }
            });
        }

        function computeTax() {


            var _emp_id = $find('<%=rcmbEmployee.ClientID %>').get_selectedItem().get_value();
            var _salary_type = 5;//$find('=rcmbSalaryType.ClientID %>').get_selectedItem().get_value();
            //var _dependent_type = $find('rcmbDependent.ClientID %>').get_selectedItem().get_value();
            var _start = $find("<%=rdpStart.ClientID %>").get_dateInput().get_selectedDate().format("yyyy/MM/dd");
            var _end = $find("<%=rdpEnd.ClientID %>").get_dateInput().get_selectedDate().format("yyyy/MM/dd");

            //vm.Payslip[0].dependent_type(_dependent_type);
            //vm.Payslip[0].salary_type(_salary_type);
            //vm.Payslip[0].startperiod(_start);
            //vm.Payslip[0].endperiod(_end);
            //alert(vm.Payslip[0].companyloan);

            $.ajax({
                type: "POST",
                url: "Payslip.aspx/computeWHTax",
                data: JSON.stringify({ 'payslip': ko.toJSON(vm.Payslip), 'start': _start, 'end': _end }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (data) {
                    //alert(data.d);
                    var dt = JSON.parse(data.d);
                    if (dt != null) {
                        ko.mapping.fromJS(dt, {}, vm.Payslip);
                        //alert(dt[0].employee_number);
                    }
                }
            });
        }

        function changeEmployee() {

            var _emp_id = $find('<%=rcmbEmployee.ClientID %>').get_selectedItem().get_value();
            var _salary_type = 5;//$find('rcmbSalaryType.ClientID %>').get_selectedItem().get_value();
            //var _dependent_type = $find('rcmbDependent.ClientID %>').get_selectedItem().get_value();
            var _start = $find("<%=rdpStart.ClientID %>").get_dateInput().get_selectedDate().format("yyyy/MM/dd");
            var _end = $find("<%=rdpEnd.ClientID %>").get_dateInput().get_selectedDate().format("yyyy/MM/dd");

            $.ajax({
                type: "POST",
                url: "Payslip.aspx/changeEmployee",
                data: JSON.stringify({ 'emp_id': _emp_id, 'start': _start, 'end': _end }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (data) {
                    //ko.mapping.fromJS(data.d, {}, vm.Payslip);

                    var dt = JSON.parse(data.d);
                    if (dt != null) {
                        ko.mapping.fromJS(dt, {}, vm.Payslip);
                        //alert(dt[0].employee_number);
                    }


                }
            });
        }
    </script>
    <style>
        .disabled-rcmb
        {
            border: none;
        }
    </style>
    <telerik:RadAjaxManager ID="ramExtermicon" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnComputeTotal">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="whtaxGroup" LoadingPanelID="ralpExtermicon" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="ralpExtermicon" runat="server"></telerik:RadAjaxLoadingPanel>


    <div>
        <div id="rootwizard" class="col-lg-9">
            <div class="navbar-default">
                <div class="navbar-inner">
                    <div class="container">
                        <ul>
                            <li><a href="#tabEmp" onclick="computeTax()" data-toggle="tab">Employee</a></li>
                            <li><a href="#tabAtt" onclick="computeTax()" data-toggle="tab">Attendance</a></li>
                            <li><a href="#tabGov" onclick="computeTax()" data-toggle="tab">Government Deductions</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div>
                <div class="tab-content" style="margin-left: 5%; padding-right: 20%;">
                    <hr />
                    <div class="tab-pane" id="tabEmp">

                        <div class="form-horizontal">
                            <div class="form-inline">
                                <div class="form-group">

                                    <div class="input-group">
                                        <span class="input-group-addon">Employee</span>
                                        <div class="form-control">
                                            <telerik:RadComboBox AllowCustomText="true" Filter="Contains" OnSelectedIndexChanged="rcmbEmployee_SelectedIndexChanged" ID="rcmbEmployee" OnClientSelectedIndexChanged="changeEmployee" AutoCompleteSeparator="|" Skin="Metro" runat="server" DataSourceID="edsEmployeeList" DataTextField="name" DataValueField="emp_id"></telerik:RadComboBox>
                                            <asp:EntityDataSource ID="edsEmployeeList" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EntitySetName="vw_employee_list">
                                            </asp:EntityDataSource>
                                        </div>

                                    </div>


                                </div>
                                <hr />
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">Salary Type Period</span>
                                        <div class="form-control">
                                            <label>Semi-Monthly</label>
                                            <%--                    <telerik:RadComboBox Visible="false" ID="rcmbSalaryType" Enabled="false" CssClass="disabled-rcmb" OnClientSelectedIndexChanged="computeTax" Skin="Metro" runat="server" DataSourceID="edsSalaryType" DataTextField="name" DataValueField="salary_type_id"></telerik:RadComboBox>
                                <asp:EntityDataSource ID="edsSalaryType" runat="server" AutoGenerateWhereClause="true" ConnectionString="name=PH_DEDUCTIONSEntities" DefaultContainerName="PH_DEDUCTIONSEntities" EnableFlattening="False" EntitySetName="SalaryTypes">
                                  <WhereParameters>
                                      <asp:Parameter DefaultValue="5" DbType="Int32" Name="salary_type_id"  />

                                  </WhereParameters>
                                </asp:EntityDataSource>--%>
                                        </div>
                                    </div>
                                    <br />
                                    <br />
                                    <label class="control-label" for="rcmbEmployee">Payroll Period</label>
                                    <br />
                                    <div class="input-group" style="width: 350px;">
                                        <span class="input-group-addon">From</span>
                                        <div class="form-control">
                                            <telerik:RadDatePicker Skin="Metro" ID="rdpStart" ClientEvents-OnDateSelected="computeTax" runat="server"></telerik:RadDatePicker>
                                        </div>
                                        <span class="input-group-addon">To</span>
                                        <div class="form-control">
                                            <telerik:RadDatePicker Skin="Metro" ID="rdpEnd" ClientEvents-OnDateSelected="computeTax" runat="server"></telerik:RadDatePicker>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Employee Number</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-info-sign"></i></span>
                                    <input type="text" id="inpEmployeeNumber" data-bind="value: employee_number" runat="server" readonly="true" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Basic Salary </label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" id="inpBasicSalary" data-bind="value: basic_salary" runat="server" readonly="true" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Daily Rate</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" id="inpDailyRate" data-bind="value: dailyrate" readonly="true" runat="server" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">COLA (Cost of Living Allowance)</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" data-bind="value: cola" id="inpCola" readonly="true" runat="server" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="tab-pane" id="tabAtt">
                        <%--           <h2>Attendance Info</h2>--%>
                        <hr />
                        <div class="form-horizontal">

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">No. of Days Present</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon "><i class="glyphicon glyphicon-ok-sign"></i></span>
                                    <input type="number" data-bind="value: regularpresent" readonly="true" id="inpDaysPresent" runat="server" class="form-control" aria-label="" />
                                    <span class="input-group-addon">x 9 hr/day</span>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Adjustment</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" data-bind="value: adjustment" onchange="computeTax" id="inpAdjustment" runat="server" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Allowance</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" data-bind="value: allowance" onchange="computeTax" id="inpAllowance" runat="server" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Over Time</label>

                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
                                    <input type="number" id="inpOvertime" data-bind="value: overtimeregular" runat="server" readonly="true" class="form-control" aria-label="" />
                                    <span class="input-group-addon">hours</span>
                                </div>

                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Rate/Hour</span>
                                    <input type="number" id="inpOTRate" runat="server" data-bind="value: overtimerate" class="form-control" readonly="true" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>

                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Total Php</span>
                                    <input type="number" id="inpOTTotal" runat="server" data-bind="value: overtimetotal" class="form-control" readonly="true" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Under Time</label>

                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
                                    <input type="number" id="Number1" data-bind="value: undertimeregular" runat="server" readonly="true" class="form-control" aria-label="" />
                                    <span class="input-group-addon">hours</span>
                                </div>

                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Rate/Hour</span>
                                    <input type="number" id="Number2" runat="server" data-bind="value: overtimerate" class="form-control" readonly="true" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>

                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Total Php</span>
                                    <input type="number" id="Number3" runat="server" data-bind="value: undertimetotal" class="form-control" readonly="true" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Legal Holidays</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" id="inpLegalH" runat="server" data-bind="value: legaltotal" readonly="true" onchange="computeTax" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Special Holidays</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" id="inpSpecialH" data-bind="value: specialtotal" runat="server" readonly="true" onchange="computeTax" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="tabGov">
                        <%--          <h2>Deductions Info</h2>--%>
                        <hr />
                        <div class="form-horizontal">


                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Pag-ibig Contribution</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" id="inpPagibigCon" data-bind="value: pagibigcon" readonly="true" runat="server" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Pag-ibig Loan</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" id="inpPagibigLoan" data-bind="value: pagibigloan" onchange="computeTax" runat="server" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">SSS Contribution</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" id="inpSSSCon" data-bind="value: ssscon" runat="server" readonly="true" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">SSS Loan</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" id="inpSSSLoan" data-bind="value: sssloan" runat="server" onchange="computeTax" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">PhilHealth Contribution</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" id="inpPhilhealth" data-bind="value: philhealthcon" readonly="true" runat="server" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Company Loan</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" data-bind="value: companyloan" id="inpCompanyLoan" runat="server" class="form-control" aria-label="" />
                                    <%--<span class="input-group-addon">.00</span>--%>
                                </div>
                            </div>

                            <div class="form-group" data-bind="foreach : Payslip">
                                <label class="control-label" for="rcmbEmployee">Dependent</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Type</span>
                                    <input type="text" id="inpDependent" data-bind="value: dependent_description" readonly="true" runat="server" class="form-control" aria-label="" />
                                    <%--       <div class="form-control">
                        
                                 <telerik:RadComboBox ID="rcmbDependent" Skin="Metro" OnClientSelectedIndexChanged="computeTax" Width="100%" runat="server" DataSourceID="edsDependentType" DataTextField="description" DataValueField="tax_dependent_type_id"></telerik:RadComboBox>
                                    <asp:EntityDataSource ID="edsDependentType" runat="server" ConnectionString="name=PH_DEDUCTIONSEntities" DefaultContainerName="PH_DEDUCTIONSEntities" EnableFlattening="False" EntitySetName="TaxDependentTypes">
                                    </asp:EntityDataSource>--%>
                                </div>

                            </div>

                            <div class="form-group" id="whtaxGroup" data-bind="foreach : Payslip">
                                <label class="control-label" for="lblBasicSalary">Withholding Tax</label>
                                <div class="input-group" style="width: 70%;">
                                    <span class="input-group-addon">Php</span>
                                    <input type="number" data-bind="value: whtax" id="inpWHTax" readonly="true" runat="server" class="form-control" aria-label="" />

                                </div>
                            </div>
                        </div>




                    </div>
                </div>

                <div class="tab-pane" id="tab6">
                    <hr />

                    <ul class="pager wizard">
                        <li class="previous first" style="display: none;"><a href="#">First</a></li>
                        <li class="previous"><a href="#">Previous</a></li>
                        <li class="next last" style="display: none;"><a href="#">Last</a></li>
                        <li class="next"><a href="#">Next</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-lg-3" style="margin-bottom: 30px;">
            <div class="row">
                <div class="col-lg-12">
                    <label class="control-label" for="lblBasicSalary">Payslip Summary</label>
                </div>

            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="form-group" id="Div1" data-bind="foreach : Payslip">

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: lightyellow;">Employee Name</span>
                            <input id="Text1" type="text" data-bind="value: employee_name" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: lightyellow;">Designation</span>
                            <input id="Text2" type="text" data-bind="value: designation" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: lightyellow;">Status</span>
                            <input id="Text3" type="text" data-bind="value: status" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: lightyellow;">Reg. Days Present</span>
                            <input id="Text4" type="text" data-bind="value: regularpresent" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: lightyellow;">Daily Rate</span>
                            <input id="Text23" type="text" data-bind="value: dailyrate" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>



                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: lightyellow;">COLA</span>
                            <input id="Text10" type="text" data-bind="value: cola" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: lightyellow;">Undertime</span>
                            <input id="Text24" type="text" data-bind="value: undertimeregular" placeholder="0.00" size="4" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: lightyellow;">Overtime</span>
                            <input id="Text25" type="text" data-bind="value: overtimeregular" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: lightyellow;">Allowance</span>
                            <input id="Text11" type="text" data-bind="value: allowance" readonly="true" size="4" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: lightyellow;">Adjustment</span>
                            <input id="Text17" type="text" data-bind="value: adjustment" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>
                    </div>
                </div>

                <div class="col-lg-12">
                    <div class="form-group" id="Div2" data-bind="foreach : Payslip">

                          <div class="input-group">
                            <span class="input-group-addon" style="background-color: cadetblue;">Overtime</span>
                            <input id="Text26" type="text" data-bind="value: overtimetotal" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: cadetblue;">Legal Holidays</span>
                            <input id="Text6" type="text" data-bind="value: legaltotal" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: cadetblue;">Special Holidays</span>
                            <input id="Text7" type="text" data-bind="value: specialtotal" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>
                    </div>
                </div>

                <div class="col-lg-12">
                    <div class="form-group" id="Div3" data-bind="foreach : Payslip">

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: indianred;">Undertime</span>
                            <input id="Text22" type="text" size="4" data-bind="value: undertimetotal" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: indianred;">Withholding Tax</span>
                            <input id="Text8" type="text" data-bind="value: whtax" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: indianred;">SSS Premium</span>
                            <input id="Text9" type="text" data-bind="value: ssscon" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: indianred;">SSS Loan</span>
                            <input id="Text12" type="text" data-bind="value: sssloan" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: indianred;">Pag-ibig Contribution</span>
                            <input id="Text13" type="text" data-bind="value: pagibigcon" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: indianred;">Pag-ibig Loan</span>
                            <input id="Text14" type="text" data-bind="value: pagibigloan" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: indianred;">Phil Health</span>
                            <input id="Text15" type="text" data-bind="value: philhealthcon" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>

                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: indianred;">Company Loan</span>
                            <input id="Text16" type="text" data-bind="value: companyloan" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="form-group" id="Div4" data-bind="foreach : Payslip">
                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: lightyellow;">Basic</span>
                            <input id="Text18" type="text" data-bind="value: basic_total" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>
                    </div>
                </div>

                <div class="col-lg-12">
                    <div class="form-group" id="Div5" data-bind="foreach : Payslip">
                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: cadetblue;">Earnings</span>
                            <input id="Text19" type="text" data-bind="value: earning_total" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>
                    </div>
                </div>

                <div class="col-lg-12">
                    <div class="form-group" id="Div6" data-bind="foreach : Payslip">
                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: indianred;">Deduction</span>
                            <input id="Text20" type="text" data-bind="value: deduction_total" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="form-group" id="Div7" data-bind="foreach : Payslip">
                        <div class="input-group">
                            <span class="input-group-addon" style="background-color: orangered;">Net Pay</span>
                            <input id="Text21" type="text" data-bind="value: net_pay" readonly="true" runat="server" class="form-control" aria-label="" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="btn-group" role="group" aria-label="..." style="float: right" data-bind="foreach : Payslip">
                        <button type="button" onclick="savePayslip()" class="btn btn-default"><span><i class="glyphicon glyphicon-floppy-save"></i>Save Only</span></button>
                        <button type="button" onclick="printPayslip()" class="btn btn-primary"><span><i class="glyphicon glyphicon-print"></i>Save and Print</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>



</asp:Content>
