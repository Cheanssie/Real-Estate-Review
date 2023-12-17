<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/WebPages/Master/Client.Master" AutoEventWireup="true" CodeBehind="APITester.aspx.cs" Inherits="PropertyWebsite.WebPages.APITester" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        Testing
    </div>
    <asp:TextBox ID="txtInput" runat="server"></asp:TextBox>
    <asp:Button ID="btnAPI" runat="server" Text="Test" OnClick="btnAPI_Click" />
    <br />
    <asp:Label ID="lblOutput" runat="server"></asp:Label>
</asp:Content>
