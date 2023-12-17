<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/Master/Client.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="PropertyWebsite.WebPages.Client.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .h-custom {
            height: calc(100% - 73px);
        }

        @media (max-width: 700px) {
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
        <div class="row d-flex justify-content-center align-items-center h-100 flex-md-row flex-sm-column-reverse flex-column-reverse gap-2">
            <div class="col-custom col-md-6 col-lg-6 col-xl-4 offset-xl-1">
                <div class="divider d-flex align-items-center my-4">
                    <p class="lead fw-bold mb-0 fs-2 mx-auto">Register</p>
                </div>

                <!-- Name input -->
                <div class="form-outline mb-3">
                    <label class="form-label" for="txtName">Full Name</label>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is Required" ForeColor="Red" ControlToValidate="txtName">*</asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control form-control-lg" placeholder="Enter full name" ></asp:TextBox>
                </div>

                <!-- Email input -->
                <div class="form-outline mb-3">
                    <label class="form-label" for="txtEmail">Email address</label>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email Address is Required" ControlToValidate="txtEmail" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="Please Enter a valid Email Address" ControlToValidate="txtEmail" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic">*</asp:RegularExpressionValidator>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control form-control-lg" placeholder="Enter a valid email address" TextMode="Email"></asp:TextBox>
                </div>

                <!-- Password input -->
                <div class="form-outline mb-3">
                    <label class="form-label" for="txtPassword">Password</label>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is Required" ControlToValidate="txtPassword" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPassword" runat="server" ErrorMessage="Password must have minimum 8 characters consisting at least one uppercase letter, one lowercase letter, one number and one special character" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" ControlToValidate="txtPassword" ForeColor="Red" Display="Dynamic">*</asp:RegularExpressionValidator>
                    <div class="position-relative">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control form-control-lg" placeholder="Enter password" TextMode="Password"></asp:TextBox>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="position-absolute toggle-password bi bi-eye-slash" style="top: 15px; right: 12px; cursor: pointer;" viewBox="0 0 16 16">
                            <path d="M13.359 11.238C15.06 9.72 16 8 16 8s-3-5.5-8-5.5a7.028 7.028 0 0 0-2.79.588l.77.771A5.944 5.944 0 0 1 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.134 13.134 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755-.165.165-.337.328-.517.486l.708.709z" />
                            <path d="M11.297 9.176a3.5 3.5 0 0 0-4.474-4.474l.823.823a2.5 2.5 0 0 1 2.829 2.829l.822.822zm-2.943 1.299.822.822a3.5 3.5 0 0 1-4.474-4.474l.823.823a2.5 2.5 0 0 0 2.829 2.829z" />
                            <path d="M3.35 5.47c-.18.16-.353.322-.518.487A13.134 13.134 0 0 0 1.172 8l.195.288c.335.48.83 1.12 1.465 1.755C4.121 11.332 5.881 12.5 8 12.5c.716 0 1.39-.133 2.02-.36l.77.772A7.029 7.029 0 0 1 8 13.5C3 13.5 0 8 0 8s.939-1.721 2.641-3.238l.708.709zm10.296 8.884-12-12 .708-.708 12 12-.708.708z" />
                        </svg>
                    </div>
                </div>

                <!-- Confirm Password input -->
                <div class="form-outline mb-3">
                    <label class="form-label" for="txtConfirmPassword">Confirm Password</label>
                    <asp:RequiredFieldValidator ID="rfvPassword2" runat="server" ErrorMessage="Confirm Password is Required" ControlToValidate="txtConfirmPassword" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvConfrimPswd" runat="server" ErrorMessage="Confirm Password is not same with Password" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ForeColor="Red" Display="Dynamic">*</asp:CompareValidator>
                    <div class="position-relative">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control form-control-lg" placeholder="Re-enter password" TextMode="Password"></asp:TextBox>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="position-absolute toggle-password1 bi bi-eye-slash" style="top: 15px; right: 12px; cursor: pointer;" viewBox="0 0 16 16">
                            <path d="M13.359 11.238C15.06 9.72 16 8 16 8s-3-5.5-8-5.5a7.028 7.028 0 0 0-2.79.588l.77.771A5.944 5.944 0 0 1 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.134 13.134 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755-.165.165-.337.328-.517.486l.708.709z" />
                            <path d="M11.297 9.176a3.5 3.5 0 0 0-4.474-4.474l.823.823a2.5 2.5 0 0 1 2.829 2.829l.822.822zm-2.943 1.299.822.822a3.5 3.5 0 0 1-4.474-4.474l.823.823a2.5 2.5 0 0 0 2.829 2.829z" />
                            <path d="M3.35 5.47c-.18.16-.353.322-.518.487A13.134 13.134 0 0 0 1.172 8l.195.288c.335.48.83 1.12 1.465 1.755C4.121 11.332 5.881 12.5 8 12.5c.716 0 1.39-.133 2.02-.36l.77.772A7.029 7.029 0 0 1 8 13.5C3 13.5 0 8 0 8s.939-1.721 2.641-3.238l.708.709zm10.296 8.884-12-12 .708-.708 12 12-.708.708z" />
                        </svg>
                    </div>
                </div>
                <div class="text-center text-lg-start mt-3 pt-2">
                    <asp:Button ID="btnSignUp" runat="server" CssClass="btn btn-dark btn-md w-100" style="padding-left: 2.5rem; padding-right: 2.5rem;border-radius:30px;" Text="Register" OnClick="register_Click" />
                    <p class="small fw-bold mt-2 pt-1 mb-0">
                        Already have an account? <a href="Login.aspx" class="link-danger">Login</a>
                    </p>
                </div>
                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" Text="cvdob"/>
            </div>
            <div class="col-custom col-md-9 col-lg-6 col-xl-5">
                <img src="../../Resources/Img/register-bg.jpg" class="img-fluid" alt="Register Page"/>
            </div>
        </div>
    </div>

    <script type="text/javascript">
       

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

        $(document).ready(function () {
            $(".toggle-password1").click(function () {
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
    </script>
</asp:Content>
