<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/Master/Client.Master" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="PropertyWebsite.WebPages.Client.Homepage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .carouselImg {
            max-height: 350px;
            object-fit: cover;
        }

        .carousel-caption {
            opacity: 0;
            transform: translateY(50px);
            transition: opacity 0.35s, transform 0.35s;
        }

        .carousel-item.active .carousel-caption {
            opacity: 1;
            transform: translateY(0);
        }

        .carousel-caption h5,
        .carousel-caption p {
            background-color: rgb(75, 75, 75, 0.90);
            color: white;
            width: fit-content;
            margin: auto;
            padding: 5px;
        }

        .rounded-custom {
            border-radius: 15px;
        }

        .btn-custom {
            border-radius: 15px;
            border: 1px solid black;
            z-index: 3;
            background-color: black;
            color: white;
            width: 80px;
            padding-inline: 5px;
        }

        .counter-section {
            text-align: center;
            margin-top: 50px;
        }

        .counter {
            font-size: 36px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        @keyframes countUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .counter.animated {
            animation: countUp 1s ease-out;
        }

        .card-price {
            color: grey;
        }

        .p-category {
            max-width: max-content;
            padding: 2px 5px;
            border: 1px solid #0d6efd;
            color: #0d6efd;
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

        .card-price {
            color: grey;
        }

        .p-category {
            max-width: max-content;
            padding: 2px 5px;
            border: 1px solid black;
            color: black;
            border-radius: 5px;
            font-size: 12px;
            margin-bottom: 5px;
        }

        .suggestion-item {
            width:100%;
            border-bottom: 1px solid black;
        }

        .suggestion-item:hover{
            cursor:pointer;
            background: rgba(216,217,216, 0.5);
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Carousel Slider Begin -->
    <div id="carouselHome" class="carousel carousel-dark slide" data-bs-ride="carousel">
        <!--div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselHome" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselHome" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselHome" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div-->
        <div class="carousel-inner">
            <div class="carousel-item active" data-bs-interval="2000">
                <img src="../../Resources/Img/carousel1.jpg" class="d-block w-100 carouselImg" alt="">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Explore Your Dream Home</h5>
                    <p>Discover a collection of exquisite properties that cater to your unique lifestyle in our curated selection.</p>
                </div>
            </div>
            <div class="carousel-item" data-bs-interval="2000">
                <img src="../../Resources/Img/carousel2.jpg" class="d-block w-100 carouselImg" alt="">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Luxury Living Awaits</h5>
                    <p>Dive into a world of elegance and comfort with our premier properties, designed to redefine your sense of home.</p>
                </div>
            </div>
            <div class="carousel-item" data-bs-interval="2000">
                <img src="../../Resources/Img/carousel3.jpg" class="d-block w-100 carouselImg" alt="">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Find Your Perfect Sanctuary</h5>
                    <p>Browse through our carousel to uncover a range of homes, each crafted to provide an ideal haven for every discerning individual.</p>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselHome" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselHome" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
    <!-- Carousel Slider End -->

    <!-- Search Section Begin -->
    <div class="card mx-auto w-50 shadow py-4" style="margin-top: -30px; background-color: rgb(255 255 255 / 0.70);">
        <div class="card-body">
            <div class="col w-75 mx-auto">
                <div class="input-group" style="height: 30px;">
                    <asp:TextBox ID="searchInput" class="form-control rounded-custom" placeholder="Search" aria-label="Search" aria-describedby="search-addon" oninput="search()" runat="server"></asp:TextBox>
                    <asp:Button ID="btnSearch" ClientIDMode="Static" runat="server" CssClass="btn-custom" Text="Search" OnClick="btnSearch_Click" />
                </div>
                <div id="searchSuggestions" class="pt-3 d-flex flex-wrap justify-content-start gap-4">
                    <!-- Suggestions will appear here -->
                    <!-- Check it out in javascript -->
                </div>
            </div>
            <div class="input-group mx-auto pt-3 d-flex flex-wrap justify-content-center gap-4">
                <asp:DropDownList ID="ddlArea" runat="server" CssClass="border-0" Style="width: 120px;">
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
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="border-0" Style="width: 120px;">
                    <asp:ListItem Selected="True" Value="*">All Category</asp:ListItem>
                    <asp:ListItem>Air Bnb</asp:ListItem>
                    <asp:ListItem>Hotel</asp:ListItem>
                    <asp:ListItem>Homestay</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
    </div>
    <!-- Search Section End -->



    <!-- Counter Begin -->
    <div class="container my-3 shadow p-2">
        <div class="row text-center">
            <div class="col">
                <div class="counter" id="userCounter">0</div>
                <p>Users Joined</p>
            </div>
            <div class="col">
                <div class="counter" id="propertyCounter">0</div>
                <p>Properties Available</p>
            </div>
            <div class="col">
                <div class="counter" id="rateCounter">0</div>
                <p>Reviews Collected</p>
            </div>
        </div>
    </div>
    <!-- Counter End -->

    <!-- Property Section Begin -->
    <div class="container-xl mt-3">
        <p class="text-left fs-2">Latest Property</p>
    </div>
    <div class="container-xl">
            <div id="productCarousel" class="carousel slide" data-bs-pause="true">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="row justify-content-center owl-carousel owl-theme">
                            <asp:Repeater ID="rptProd" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="rptProd_ItemCommand">
                                <ItemTemplate>
                                    <div class="card-parent col" style="position: relative">
                                        <div class="card h-100 mx-auto mx-sm-auto" style="max-width: 18rem; min-width: 14rem;">
                                            <img src="<%# Eval("url") %>"" style="height: 150px;" class="card-img-top" alt="...">
                                            <div class="card-body">
                                                <h5 class="card-title overflow-hidden"  style="max-height: 1.3em;"><%# Eval("propName") %></h5>
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
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT *
FROM Property P
JOIN (
    SELECT TOP 1 *
    FROM PropertyImg PI
) AS PI ON P.Pid = PI.Pid;
"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <br />
    <br />
    <!-- Property Section End -->


    <script type="text/javascript">
        function animateCounter(counterElement) {
            counterElement.classList.add('animated');
            setTimeout(() => {
                counterElement.classList.remove('animated');
            }, 1000);
        }

        // Counter Logic
        function startCounters() {
            const userCounter = document.getElementById('userCounter');
            const propertyCounter = document.getElementById('propertyCounter');
            const rateCounter = document.getElementById('rateCounter');

            // Set your count
            let targetUserCount;
            let targetRateCount;
            let targetPropertyCount;
            let userCount = 0;
            let propertyCount = 0;
            let rateCount = 0;
            $.ajax({
                url: '../../Ajax/Ajax.aspx/Counter', // [Users, Properties, Reviews]
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    console.log(data);
                    if (data.d != "") {
                        targetUserCount = data.d[0];
                        targetPropertyCount = data.d[1];
                        targetRateCount = data.d[2];
                        const intervalId = setInterval(() => {
                            userCount += Math.ceil((targetUserCount - userCount) / 5);
                            rateCount += Math.ceil((targetRateCount - rateCount) / 5);
                            propertyCount += Math.ceil((targetPropertyCount - propertyCount) / 5);

                            userCounter.textContent = userCount;
                            rateCounter.textContent = rateCount;
                            propertyCounter.textContent = propertyCount;

                            animateCounter(userCounter);
                            animateCounter(rateCounter);

                            if (userCount >= targetUserCount && rateCount >= targetRateCount) {
                                clearInterval(intervalId);
                                userCounter.classList.remove('animated');
                                propertyCounter.classList.remove('animated');
                                rateCounter.classList.remove('animated');
                            }
                        }, 100); // Adjust the interval duration for faster animation
                    }
                },
                error: function (error) {
                    console.error('Error:', error);
                    targetUserCount = 0;
                    targetPropertyCount = 0;
                    targetRateCount = 0;
                }
            });
            
        }

        // Function to add the animation class
        function animateCounter(element) {
            element.classList.add('animated');
        }

        // Start Counters when the page loads
        window.onload = startCounters;

        var owl = $('.owl-carousel');
        owl.owlCarousel({
            margin: 10,
            loop: false,
            responsive: {
                0: {
                    items: 1
                },
                600: {
                    items: 3
                },
                1000: {
                    items: 5
                }
            }
        });

        owl.on('mousewheel', '.owl-stage', function (e) {
            if (e.deltaY>0) {
                owl.trigger('next.owl');
            } else {
                owl.trigger('prev.owl');
            }
        e.preventDefault();
        });


    </script>
    <script>
        function search() {
            // AJAX retrieving suggestion from database
            txtInput = document.getElementById('<%= searchInput.ClientID %>');

            // Clear previous suggestions
            const suggestionsContainer = document.getElementById('searchSuggestions');
            suggestionsContainer.innerHTML = '';

            // Add suggestions in rows

            $.ajax({
                url: '../../Ajax/Ajax.aspx/SearchSuggestion',
                type: 'POST',
                data: JSON.stringify({ "keyword": txtInput.value.toString() }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    console.log(data);
                    if (data.d != "") {
                        for (const item of data.d) {
                            const suggestionItem = document.createElement('div');
                            suggestionItem.classList.add('suggestion-item');
                            suggestionItem.textContent = item;


                            suggestionsContainer.appendChild(suggestionItem);

                            // Handle click on suggestion
                            suggestionItem.addEventListener('click', () => {
                                txtInput.value = suggestionItem.innerText;

                                // Trigger click event on the ASP.NET button
                                const btnSearch = document.getElementById('<%= btnSearch.ClientID %>');
                                if (btnSearch) {
                                    btnSearch.click();
                                    console.log("Click Button");
                                }

                            });
                        }
                    }
                },
                error: function (error) {
                    console.error('Error:', error);
                }
            });
           
        } 


    </script>
</asp:Content>