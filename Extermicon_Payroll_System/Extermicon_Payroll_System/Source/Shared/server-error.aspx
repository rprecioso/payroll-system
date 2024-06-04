<%@ Page Title="" Language="C#" MasterPageFile="~/Source/Shared/Site.Master" AutoEventWireup="true" CodeBehind="server-error.aspx.cs" Inherits="Extermicon_Payroll_System.Source.Shared.server_error" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblError" runat="server" Text="It seems you are not allowed to access this page. Click the button to go back where you are."></asp:Label>
    <asp:Button ID="btnBack" OnClick="btnBack_Click" runat="server" Text="Go back!" />
</asp:Content>
