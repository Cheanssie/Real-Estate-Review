<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/Master/Client.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PropertyWebsite.WebPages.Client.Login" %>

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
    <div class="container-xl d-flex justify-content-center align-items-center mb-4 h-custom p-5">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-md-9 col-lg-6 col-xl-5">
                <img src="../../Resources/Img/login-bg.jpg" class="img-fluid" alt="Login Page" />
            </div>
            <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                <div class="divider d-flex align-items-center my-4">
                    <p class="lead fw-bold mb-0 fs-2 mx-auto">Login</p>
                </div>

                <!-- Email input -->
                <div class="form-outline mb-3">
                    <label class="form-label" for="form3Example3">Email</label>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Username is Required" ControlToValidate="txtEmailL" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtEmailL" CssClass="form-control form-control-lg" placeholder="Enter email" runat="server"></asp:TextBox>
                </div>

                <!-- Password input -->
                <div class="form-outline mb-3">
                    <label class="form-label" for="form3Example4">Password</label>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is Required" ControlToValidate="txtPassword" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <div class="position-relative">
                        <asp:TextBox ID="txtPassword" CssClass="form-control form-control-lg" placeholder="Enter password" TextMode="Password" runat="server"></asp:TextBox>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="position-absolute toggle-password bi bi-eye-slash" style="top: 15px; right: 12px; cursor: pointer;" viewBox="0 0 16 16">
                            <path d="M13.359 11.238C15.06 9.72 16 8 16 8s-3-5.5-8-5.5a7.028 7.028 0 0 0-2.79.588l.77.771A5.944 5.944 0 0 1 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.134 13.134 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755-.165.165-.337.328-.517.486l.708.709z" />
                            <path d="M11.297 9.176a3.5 3.5 0 0 0-4.474-4.474l.823.823a2.5 2.5 0 0 1 2.829 2.829l.822.822zm-2.943 1.299.822.822a3.5 3.5 0 0 1-4.474-4.474l.823.823a2.5 2.5 0 0 0 2.829 2.829z" />
                            <path d="M3.35 5.47c-.18.16-.353.322-.518.487A13.134 13.134 0 0 0 1.172 8l.195.288c.335.48.83 1.12 1.465 1.755C4.121 11.332 5.881 12.5 8 12.5c.716 0 1.39-.133 2.02-.36l.77.772A7.029 7.029 0 0 1 8 13.5C3 13.5 0 8 0 8s.939-1.721 2.641-3.238l.708.709zm10.296 8.884-12-12 .708-.708 12 12-.708.708z" />
                        </svg>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center">
                    <!-- Checkbox -->
                    <div class="form-check mb-0 ps-0">
                        <asp:CheckBox ID="cbRememberMe" runat="server" />
                        <label class="form-check-label">Remember me</label>
                    </div>
                    <button id="btnForget" class="btn" type="button">Forgot password?</button>
                </div>

                <div class="text-center text-lg-start mt-3 pt-2">
                    <asp:Button ID="btnLogin" CssClass="btn btn-dark btn-md w-100" runat="server" Text="Login" Style="padding-left: 2.5rem; padding-right: 2.5rem; border-radius:30px;" OnClick="btnLogin_Click" />
                    <p class="small fw-bold mt-2 pt-1 mb-0">
                        Don't have an account? <a href="Register.aspx" class="link-danger">Register</a>
                    </p>
                </div>
                <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
            </div>
        </div>
    </div>

    <div id="forgetPanel" class="position-absolute shadow px-5 pb-5" style="display: none; top: 50%; left: 50%; transform: translate(-50%,-50%); width: 500px; background-color: #fff; border: 1px solid #ccc; padding: 20px;">
        <button class="border-0 bg-white float-end btn-close" id="btnClose" type="button">
        </button>
        <p class="fs-2"><b>Forget Password</b></p>
        <p>Enter your email to reset password.</p>

        <!-- Email input -->
        <div class="form-outline mb-4 mt-4 float-none">
            <label class="form-label" for="form3Example3">Email address</label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Email Address is Required" ControlToValidate="txtEmail" ValidationGroup="forgetPassword" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="Please enter a valid Email Address" ControlToValidate="txtEmail" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="forgetPassword" Display="Dynamic">*</asp:RegularExpressionValidator>
            <asp:TextBox ID="txtEmail" CssClass="form-control form-control-lg"
                placeholder="Enter a valid email address" runat="server"></asp:TextBox>
            <asp:Label ID="lblErrorForgetPass" runat="server" Text="" ForeColor="Red"></asp:Label>
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" ForeColor="Red" ValidationGroup="forgetPassword" />
        </div>
        <asp:Button ID="btnConfirmReset" CssClass="btn btn-dark btn-lg w-100" runat="server" Text="Confirm" Style="padding-left: 2.5rem; padding-right: 2.5rem; border-radius:30px;" ValidationGroup="forgetPassword" OnClick="btnConfirmReset_Click" />
    </div>

    <script type="text/javascript">
        var btnForget = document.getElementById('btnForget');
        var btnClose = document.getElementById('btnClose');
        var forgetPanel = document.getElementById('forgetPanel');

        btnForget.addEventListener('click', function () {
            forgetPanel.style.display = "block";
        });

        btnClose.addEventListener('click', function () {
            forgetPanel.style.display = "none";
        });

        function openForgetPanel() {
            forgetPanel.style.display = "block";
        }

        //show password
        $(document).ready(function () {
            $(".toggle-password").click(function () {
                var input = $(this).parent().find("input");
                if (input.attr("type") === "password") {
                    input.attr("type", "text");
                    $(this).removeClass("bi-eye-slash").addClass("bi-eye");
                } else {
                    input.attr("type", "password");
                    $(this).removeClass("bi-eye").addClass("bi-eye-slash");
                }
            });
        });

        function openMsgPanel(msg) {
            var popup = document.createElement('div');
            popup.textContent = msg;
            popup.style.position = 'fixed';
            popup.style.top = '50%';
            popup.style.left = '50%';
            popup.style.transform = 'translate(-50%, -50%)';
            popup.style.backgroundColor = 'rgba(0, 0, 0, 0.8)';
            popup.style.color = '#fff';
            popup.style.padding = '50px';
            popup.style.opacity = 1;
            popup.style.transition = 'opacity 3s';

            document.body.appendChild(popup);

            setInterval(function () {
                popup.style.opacity = 0;
            }, 1000);

            setTimeout(function () {
                document.body.removeChild(popup);
            }, 2000);
        };
    </script>
</asp:Content>
