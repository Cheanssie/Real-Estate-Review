<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/Master/Admin.Master" AutoEventWireup="true" CodeBehind="PropertyReviews.aspx.cs" Inherits="PropertyWebsite.WebPages.Admin.PropertyReviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .gridview th a {
            text-decoration: none;
            color: inherit;
        }

        #popup-container, #popup-container-edit, #popup-container-delete, #report-popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 9999;
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row mt-3">
        <div class="row d-flex align-content-center justify-content-center">
            <div class="col px-5">
                <p id="propName" class="fs-3" runat="server"></p>
            </div>
            <div class="col d-flex justify-content-end gap-2">
                <div class="text-end">
                    <button id="btn-chart" class="btn btn-dark" type="button">View Summary</button>
                </div>
                <div class="text-end">
                    <asp:DropDownList ID="ddlSentiment" class="form-select me-0" runat="server" Style="width: 150px; height: fit-content" AutoPostBack="True">
                        <asp:ListItem Selected="True" Value="*">All Reviews</asp:ListItem>
                        <asp:ListItem>Positive</asp:ListItem>
                        <asp:ListItem>Neutral</asp:ListItem>
                        <asp:ListItem>Negative</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <hr />
        </div>
        <% if (GridView1.Rows.Count != 0)
            { %>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM Review R, Users U WHERE U.Uid = R.Uid AND Pid = @Pid">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="Pid" Name="Pid"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" CssClass="table table-hover table-bordered text-center px-5" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="datetime,Pid,Uid">
            <Columns>
                <asp:BoundField DataField="review" HeaderText="Review" SortExpression="review"></asp:BoundField>
                <asp:BoundField DataField="datetime" HeaderText="Review Time" ReadOnly="True" SortExpression="datetime"></asp:BoundField>
                <asp:BoundField DataField="Username" HeaderText="Username" ReadOnly="True" SortExpression="Username"></asp:BoundField>
                <asp:BoundField DataField="sentiment" HeaderText="Sentiment" SortExpression="sentiment"></asp:BoundField>
            </Columns>
        </asp:GridView>
        <% }
            else
            { %>
        <div class="text-center m-5">
            <h4>No this type of review</h4>
            <p>Refresh to check for the latest information.</p>
        </div>
        <% } %>
    </div>

    <div id="popup-container" class="bg-white p-5 border-1 shadow w-50 modal-content">
        <div class="container">
            <div class="row mb-2">
                <div class="col-10">
                    <p class="fs-3"><b>Summary</b></p>
                </div>
                <div class="col-2 text-end">
                    <button id="btn-closeProp" type="button" class="border-0 bg-transparent btn-close"></button>
                </div>
            </div>
            <div class="col m-3 w-50 mx-auto">
                <canvas id="doughnutChart"></canvas>
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
    <script>
        //-------------------------Add Propuct
        var showPopupBtn = document.getElementById('btn-chart');
        var closePopupBtn = document.getElementById('btn-closeProp');

        var popupContainer = document.getElementById('popup-container');

        showPopupBtn.addEventListener('click', function () {
            popupContainer.style.display = 'block';
        });

        closePopupBtn.addEventListener('click', function () {
            popupContainer.style.display = 'none';
        });
    </script>
</asp:Content>
