<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="Signin.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Shared.Signin" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="margin-top: 100px;">
        <table style="text-align: right; border-spacing: 10px 20px; margin: auto; padding: 10px;">
            <tr>
                <td colspan="2" style="text-align: left; font-family: 'Segoe UI'; font-size: large; background-color: lightslategray; padding: 4px;">Sign in
                </td>
            </tr>
            <tr>
                <td style="text-align: left; padding-top: 20px">User name &nbsp&nbsp&nbsp</td>
                <td style="text-align: left; padding-top: 20px">
                    <telerik:RadTextBox ID="tbxUsername" Width="100%" ValidationGroup="Authentication" runat="server"></telerik:RadTextBox>

                </td>
                <td>
                    <asp:RequiredFieldValidator ID="rfv1" runat="server" ErrorMessage="Username is required!"
                        ControlToValidate="tbxUsername" Text="Username is required!" ForeColor="Red"
                        ValidationGroup="Authentication"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="text-align: left; padding-top: 5px">Password &nbsp&nbsp&nbsp</td>
                <td style="text-align: left; padding-top: 5px">
                    <telerik:RadTextBox ID="tbxPassword" TextMode="Password" Width="100%" ValidationGroup="Authentication" runat="server"></telerik:RadTextBox>


                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Password is required!"
                        ControlToValidate="tbxPassword" Text="Password is required!" ForeColor="Red"
                        ValidationGroup="Authentication"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td></td>
                <td style="text-align: left; padding-top: 5px;">
                    <telerik:RadButton ID="btnSigin" OnClick="btnSigin_Click" ValidationGroup="Authentication" CausesValidation="true" Width="100%" runat="server" Text="Sign in"></telerik:RadButton>

                </td>
            </tr>
            <tr>
                <td></td>
                <td style="text-align: left; padding-top: 5px;">
                    <asp:ValidationSummary ID="vs1" ForeColor="White" BackColor="Red" Width="100%" runat="server" ValidationGroup="Authentication" DisplayMode="BulletList"
                        HeaderText="<div class='validationheader'>&nbsp;Please correct the following:&nbsp;</div>" />
                </td>
            </tr>
        </table>
    </div>


</asp:Content>
