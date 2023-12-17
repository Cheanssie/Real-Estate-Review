<%@ Page Title="" Async="true" Language="C#" MasterPageFile="~/WebPages/Master/Client.Master" AutoEventWireup="true" CodeBehind="PropertyDetail.aspx.cs" Inherits="PropertyWebsite.WebPages.Client.PropertyDetail" %>
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

        #popup-container, #popup-container-edit, #popup-container-delete {
            position: fixed;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 9999;
            display: none;
        }

        @media (max-width: 700px) {
            .container-suggestion {
                display: none;
            }
        }

        .review-list .left span {
             width: 32px;
             height: 32px;
             display: inline-block;
        }
         .review-list .left {
             flex: none;
             max-width: none;
             margin: 0 10px 0 0;
        }
         .review-list .left span img {
             border-radius: 50%;
        }
         .review-list .right h4 {
             font-size: 16px;
             margin: 0;
             display: flex;
        }
         .review-list {
             border-bottom: 1px solid #dadbdd;
             padding: 0 0 30px;
             margin: 0 0 10px;
        }
         .review-list .right {
             flex: auto;
        }
         .review-list .review-description {
             margin: 20px 0 0;
        }
         .review-list .review-description p {
             font-size: 14px;
             margin: 0;
        }
         .review-list .publish {
             font-size: 13px;
             color: #95979d;
        }
         #reviewBox {
             max-height:300px;
             overflow:hidden scroll;
         }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [Product] WHERE ([productId] = 0)">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="productId" Name="productId" Type="String"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="container container-sm container-md container-xl m-auto">
        <div class="row">
            <div class="col-md-6 d-flex align-items-center">
                <div id="imgCarousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#imgCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#imgCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#imgCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    </div>
                    <div class="carousel-inner">
                        <asp:Repeater ID="rptPropImg" runat="server" DataSourceID="SqlDataSource3">
                            <ItemTemplate>
                                <div class='<%# Container.ItemIndex == 0 ? "carousel-item active" : "carousel-item" %>'>
                                    <img src="<%# Eval("url") %>" class="d-block w-100 object-fit-cover">
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [PropertyImg] WHERE ([Pid] = @Pid)">
                            <SelectParameters>
                                <asp:QueryStringParameter QueryStringField="Pid" Name="Pid" Type="Int32"></asp:QueryStringParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#imgCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#imgCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
               <%-- <asp:Image ID="imgProp" class="img-fluid" runat="server" />--%>
            </div>
            <div class="col-md-6">
                <div class="w-100 p-5">
                    <p class="fs-2"><b id="propName" runat="server"></b></p>
                    <hr />
                    <p class="text-wrap">
                        <span id="propDesc" runat="server"></span>
                    </p>
                    <p class="card-text p-category mt-5 mb-3" id="propCategory" runat="server"></p>
                    <div class="d-flex flex-row justify-content-between col-12" style="width: 35%;">
                        <p class="fw-bold">Price:</p>
                    </div>
                    <div class="d-flex flex-row justify-content-between col-12" style="">
                        <p>From RM<span id="startPrice" runat="server"></span> to RM<span id="endPrice" runat="server"></span></p>
                    </div>
                    <br />
                    <br />
                    <br />
                </div>
            </div>
        </div>
    </div>

    <!-- Review Section -->
    <div class="container container-sm container-md container-xl m-auto">
        <div>
            <p class="text-left fs-2">Reviews</p>
        </div>
        <hr />
        <div class="row m-4">
            <div class="col-9 bg-light px-4 pt-4 pb-1">
                <div id="reviewBox" class="col">
                    <asp:Repeater ID="rptReview" runat="server" DataSourceID="SqlDataSource2">
                        <ItemTemplate>
                            <div class="review-list">
                                <div class="d-flex">
                                    <div class="left">
                                        <span>
                                            <img src="../../Resources/Img/defaul-profile.jpeg" class="profile-pict-img img-fluid" alt="" />
                                        </span>
                                    </div>
                                    <div class="right">
                                        <h4><%# Eval("username") %></h4>
                                        <div class="review-description">
                                            <p><%# Eval("review") %></p>
                                        </div>
                                        <span class="publish d-inline-block w-100"><%# Eval("datetime") %></span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>


                    <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [Review] R, [Users] U WHERE ([Pid] = @Pid) AND (U.Uid = R.Uid) ORDER BY datetime DESC">
                        <SelectParameters>
                            <asp:QueryStringParameter QueryStringField="Pid" Name="Pid" Type="Int32"></asp:QueryStringParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="mb-3 mt-3 input-group d-flex justify-content-center align-content-center">
    <% if (Session["email"] == null)
        {%>
    <a class="text-dark" href="Login.aspx">Please login to review!</a>
    <%}
        else
        { %>
    <asp:TextBox ID="txtReview" runat="server" CssClass="ml-4 form-control" Style="border-radius: 15px 0 0 15px; height: 40px" placeholder="Comment Here"></asp:TextBox>
    <div class="input-group-append">
        <asp:LinkButton ID="btnReview" runat="server" CssClass="border-0 bg-black text-light btn btn-md" Style="border-radius: 0 15px 15px 0;" OnClick="LinkButton1_Click">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
                <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576zm6.787-8.201L1.591 6.602l4.339 2.76 7.494-7.493Z"/>
            </svg>
        </asp:LinkButton>
    </div>
    <%} %>
</div>
            </div>
            <div class="col-3 bg-light px-4 pt-4 pb-1" style="width: 300px; height:auto">
                    <canvas id="doughnutChart" ></canvas>
                </div>
        </div>
    </div>



        <div id="popup-container" class="bg-white p-5 border-1 shadow w-25">
        <div class="container">
            <div class="row mb-2">
                <p class="text-center fs-4">Please login for adding to cart!</p>
            </div>

            <div class="container d-flex justify-content-center">
                <button id="btn-closeDelete" class="btn btn-primary btn-light mx-2">OK</button>
                <asp:Button ID="btnConfirm" CssClass="btn btn-primary mx-2" runat="server" Text="Login"/>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript">
        $.ajax({
            url: '../../Ajax/Ajax.aspx/SentimentCount', //[Neutral, Positive, Negative]
            type: 'POST',
            data: JSON.stringify({ "Pid": parseInt('<%=Request.QueryString["Pid"] %>') }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {

                console.log(data);
                if (data.d != "") {
                    var ctxD = document.getElementById("doughnutChart").getContext('2d');
                    var myLineChart = new Chart(ctxD, {
                        type: 'doughnut',
                        data: {
                            labels: ["Neutral", "Positive", "Negative"],
                            datasets: [{
                                data: [data.d[0], data.d[1], data.d[2]],
                                backgroundColor: ["#949FB1", "#46BFBD", "#F7464A"],
                                hoverBackgroundColor: ["#A8B3C5", "#5AD3D1", "#FF5A5E"]
                            }]
                        },
                        options: {
                            responsive: true
                        }
                    });
                }
            },
            error: function (error) {
                console.error('Error:', error);
            }
        });

    </script>
</asp:Content>
