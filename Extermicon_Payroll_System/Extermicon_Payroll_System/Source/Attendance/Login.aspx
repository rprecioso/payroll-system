<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Attendance.Login" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        //ticker function that will refresh our display every second
        function tick() {
            var newd = new Date();
            document.getElementById('time_ticker').innerHTML = newd.toLocaleTimeString();
        }
        //the runner
        var t = setInterval(tick, 1000);
    </script>


    <script src="../../Scripts/jquery-2.1.3.min.js"></script>
    <script>
        $("#tbxPasscode").keydown(function (event) {
            if (event.keyCode == 13) {
                $("#btnLogin").click();
            }
        });

        function login() {

            var passcode = document.getElementById("tbxPasscode").value;

            $.ajax({
                type: "POST",
                url: "Login.aspx/login",
                data: JSON.stringify({ 'passcode': passcode }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (data) {
                    var masterTable = $find("<%= rgTodayLogs.ClientID %>").get_masterTableView();
                    masterTable.rebind();
                    alert(data.d);
                    document.getElementById("tbxPasscode").value = '';
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>


            <telerik:AjaxSetting AjaxControlID="btnLogin">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rgTodayLogs" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"></telerik:RadAjaxLoadingPanel>
    <div class="container-fluid" style="margin-top: 0px; text-align: center">

        <div class="row">
            <div class="col-lg-12">
                <span id="time_ticker" style="font-size: 100px !important; font-weight: 700; font-family: 'Segoe UI'">00:00:00</span>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12">
                <div class="form-inline">
                    <div class="form-group">
                        <label class="sr-only" for="tbxPassCode">Employee Number</label>
                        <div class="input-group">
                            <div class="input-group-addon">Enter Employee Number</div>
                            <%--<telerik:RadTextBox CssClass="form-control" ID="tbxPassCode" TextMode="Password" runat="server" Width="100%"></telerik:RadTextBox>--%>
                            <input type="password" id="tbxPasscode" onsubmit="login()" class="form-control" />
                        </div>

                    </div>

                    <input class="btn btn-primary" onclick="login()" type="submit" id="btnLogin" runat="server" value="Submit" />
                    <%--<asp:LinkButton ID="lbtnLogin" OnClick="btnLogin_Click" CssClass="btn btn-primary" runat="server">Login</asp:LinkButton>--%>
                </div>
            </div>
        </div>



    </div>
    <hr />
    <div class="row">
        <div class="col-sm-12" style="text-align: center;">
            <telerik:RadGrid ID="rgTodayLogs" Skin="Metro" runat="server" CellSpacing="0" EnableViewState="false" DataSourceID="edsTodayLogs" GridLines="None" MasterTableView-NoMasterRecordsText="No Logins for Today yet">
                <MasterTableView AutoGenerateColumns="False" DataKeyNames="user_id,log_id,emp_id" DataSourceID="edsTodayLogs">
                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>

                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>

                    <Columns>
                        <telerik:GridTemplateColumn DataField="first_name" FilterControlAltText="Filter first_name column" HeaderText="Name" SortExpression="first_name" UniqueName="first_name">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%#Eval("last_name") + ", " +  Eval("first_name")  %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="in_time" DataType="System.DateTime" FilterControlAltText="Filter in_time column" HeaderText="In" SortExpression="in_time" UniqueName="in_time">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="out_time" DataType="System.DateTime" FilterControlAltText="Filter out_time column" HeaderText="Out" SortExpression="out_time" UniqueName="out_time">
                        </telerik:GridBoundColumn>
                        <%--                            <telerik:GridBoundColumn DataField="first_name" FilterControlAltText="Filter first_name column" HeaderText="first_name" SortExpression="first_name" UniqueName="first_name">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="last_name" FilterControlAltText="Filter last_name column" HeaderText="last_name" SortExpression="last_name" UniqueName="last_name">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="user_id" DataType="System.Int32" FilterControlAltText="Filter user_id column" HeaderText="user_id" ReadOnly="True" SortExpression="user_id" UniqueName="user_id">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="log_id" DataType="System.Int32" FilterControlAltText="Filter log_id column" HeaderText="log_id" ReadOnly="True" SortExpression="log_id" UniqueName="log_id">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="emp_id" DataType="System.Int32" FilterControlAltText="Filter emp_id column" HeaderText="emp_id" ReadOnly="True" SortExpression="emp_id" UniqueName="emp_id">
                            </telerik:GridBoundColumn>--%>
                    </Columns>

                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                    </EditFormSettings>
                </MasterTableView>

                <FilterMenu EnableImageSprites="False"></FilterMenu>
            </telerik:RadGrid>
            <asp:EntityDataSource ID="edsTodayLogs" runat="server" ConnectionString="name=ExtermiconDBEntities" DefaultContainerName="ExtermiconDBEntities" EnableFlattening="False" EntitySetName="vw_today_logs">
            </asp:EntityDataSource>
        </div>
    </div>
</asp:Content>
