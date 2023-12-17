<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/Master/Client.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="PropertyWebsite.WebPages.Client.ResetPassword" %>
<%@ Register TagPrefix="R" TagName="RP" Src="~/UserControl/ResetPassword.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .h-custom {
            height: calc(100% - 73px);
        }

        @media (max-width: 995px) {
            .h-custom {
                height: 100%;
            }
        }

        .form-control {
            background: white;
        }

            .form-control:focus {
                background: white;
                color: black;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <R:RP  runat="server" />
</asp:Content>
