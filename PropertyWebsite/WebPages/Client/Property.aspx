<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/Master/Client.Master" AutoEventWireup="true" CodeBehind="Property.aspx.cs" Inherits="PropertyWebsite.WebPages.Client.Property" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card-price {
            color: grey;
        }

        .p-category {
            max-width: max-content;
            padding: 2px 5px;
            border: 1px solid #000000;
            color: #000000;
            border-radius: 5px;
            font-size: 12px;
            margin-bottom: 5px;
        }

        .card-parent:hover > .card {
            box-shadow: 0 4px 10px rgba(13, 110, 253, 0.16), 0 4px 10px rgba(13, 110, 253, 0.23);
            opacity: 0.5;
        }

        .view-details {
            z-index: 2;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            visibility: hidden;
        }

        .card-parent:hover > .view-details {
            visibility: visible;
            opacity: 1 !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container container-sm container-md container-lg container-xl my-3">
        <div class="row justify-content-md-end justify-content-sm-center justify-content-center align-items-center">
            <div class="col-auto">
                <label class="form-label my-auto">Filter by:</label>
            </div>
            <div class="col-auto">
                <asp:DropDownList ID="ddlArea" class="form-select" runat="server" OnSelectedIndexChanged="ddlArea_SelectedIndexChanged" AutoPostBack="True" >
                    <asp:ListItem Selected="True" Value="*">All Area</asp:ListItem>
                    <asp:ListItem>Kuala Lumpur</asp:ListItem>
                    <asp:ListItem>Selangor</asp:ListItem>
                    <asp:ListItem>Malacca</asp:ListItem>
                    <asp:ListItem>Johor</asp:ListItem>
                    <asp:ListItem>Pahang</asp:ListItem>
                    <asp:ListItem>Kelantan</asp:ListItem>
                    <asp:ListItem>Terengganu</asp:ListItem>
                    <asp:ListItem>Penang</asp:ListItem>
                    <asp:ListItem>Sabah</asp:ListItem>
                    <asp:ListItem>Sarawak</asp:ListItem>
                    <asp:ListItem>Perlis</asp:ListItem>
                    <asp:ListItem>Kedah</asp:ListItem>
                    <asp:ListItem>Negeri Sembilan</asp:ListItem>
                    <asp:ListItem>Perak</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-auto">
                <asp:DropDownList ID="ddlCategory" class="form-select" runat="server" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" AutoPostBack="True">
                    <asp:ListItem Selected="True" Value="*">All Category</asp:ListItem>
                    <asp:ListItem>Air Bnb</asp:ListItem>
                    <asp:ListItem>Hotel</asp:ListItem>
                    <asp:ListItem>Homestay</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-auto">
                <asp:DropDownList ID="ddlPrice" class="form-select" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPrice_SelectedIndexChanged" >
                    <asp:ListItem Value="ASC" Selected="True">Lowest to Highest</asp:ListItem>
                    <asp:ListItem Value="DESC">Highest to Lowest</asp:ListItem>
                </asp:DropDownList>
        </div>
    </div>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [Property]" EnableCaching="True">
    </asp:SqlDataSource>

    <asp:ListView ID="ListView1" runat="server" AllowPaging="true" PagerTemplate="{% myDataPager %}" ViewStateMode="Enabled" DataSourceID="SqlDataSource1" OnItemCommand="ListView1_ItemCommand">
        <LayoutTemplate>
            <div class="container container-sm container-md container-lg container-xl my-3">
                <div class="row row-cols-1 row-cols-sm-1 row-cols-md-5 g-4 mb-md-3  mb-sm-4  mb-4">
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                </div>
            </div>
            <div class="d-flex justify-content-center text-center mb-3">
                <asp:DataPager ID="myDataPager" runat="server" PageSize="15" PagedControlID="ListView1">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" />
                        <asp:NumericPagerField />
                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <div class="card-parent col" style="position: relative">
                <div class="card h-100 mx-auto mx-sm-auto" style="max-width: 18rem; min-width:14rem;">
                    <img src="../../Resources/Img/carousel1.jpg" style="height: 150px;" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title"><%# Eval("propName") %></h5>
                        <p class="card-text p-category"><%# Eval("category") %></p>
                        <p class="card-text card-price position-relative">
                            <%# Eval("area") %><span class="card-text float-end position-absolute bottom-0 end-0" style="font-size: 12px;">From RM<%# Eval("startPrice") %></span></p>
                    </div>
                </div>
                <div class="view-details buttons d-flex">
                    <asp:LinkButton ID="lbViewDetails" CssClass="btn btn-dark btn-sm d-flex justify-content-center align-content-center" runat="server" CommandName="detail" CommandArgument='<%# Eval("Pid") %>'>View Details</asp:LinkButton>
                </div>
            </div>
        </ItemTemplate>
    </asp:ListView>

</asp:Content>
