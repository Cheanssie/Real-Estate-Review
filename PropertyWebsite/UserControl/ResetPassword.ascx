<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.ascx.cs" Inherits="PropertyWebsite.UserControl.ResetPassword" %>

<div class="container-xl d-flex justify-content-center align-items-center mb-4 h-custom p-5">
    <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-md-9 col-lg-6 col-xl-5">
            <img src="../../Resources/Img/ResetPassword.png" class="img-fluid" alt="Reset Password Page" />
        </div>
        <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
            <div class="divider d-flex align-items-center my-4">
                <p class="lead fw-bold mb-0 fs-2 mx-auto">Reset Password</p>
            </div>

            <!-- Password input -->
            <div class="form-outline mb-3">
                <label class="form-label" for="form3Example4">Password</label>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is Required" ControlToValidate="txtPassword" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPassword" runat="server" ErrorMessage="Password must have minimum 8 characters consisting at least one uppercase letter, one lowercase letter, one number and one special character" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" ControlToValidate="txtPassword" ForeColor="Red">*</asp:RegularExpressionValidator>
                <asp:TextBox ID="txtPassword" CssClass="form-control form-control-lg" placeholder="Enter password" TextMode="Password" runat="server"></asp:TextBox>
            </div>
            <!-- Confirm Password input -->
            <div class="form-outline mb-3">
                <label class="form-label" for="form3Example4">Confirm Password</label>
                <asp:CompareValidator ID="cvCPassword" runat="server" ErrorMessage="Password & Confirm Password do not match!" ControlToCompare="txtPassword" ControlToValidate="txtCPassword" ForeColor="Red">*</asp:CompareValidator>
                <asp:RequiredFieldValidator ID="rfvCPassword" runat="server" ErrorMessage="Confirm Password is Required" ControlToValidate="txtCPassword" ForeColor="Red" Trim="false">*</asp:RequiredFieldValidator>
                <asp:TextBox ID="txtCPassword" CssClass="form-control form-control-lg" placeholder="Confirm password" TextMode="Password" runat="server"></asp:TextBox>
            </div>
            <label>
                <input type="checkbox" id="showPasswordCheckbox" class="m-2">
                Show Password
               
            </label>
            <div class="text-center text-lg-start mt-4 pt-2">
                <asp:Button ID="btnReset" CssClass="btn btn-dark btn-lg w-100" runat="server" Text="Reset" Style="padding-left: 2.5rem; padding-right: 2.5rem; border-radius:30px;" OnClick="btnReset_Click" />
            </div>
            <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
        </div>
    </div>
</div>

<script type="text/javascript">
    var showPasswordCheckbox = document.getElementById('showPasswordCheckbox');
    var txtPassword = document.getElementById('<%= txtPassword.ClientID %>');
    var txtCPassword = document.getElementById('<%= txtCPassword.ClientID %>');

    showPasswordCheckbox.addEventListener('change', function () {
        if (showPasswordCheckbox.checked) {
            txtPassword.type = 'text';
            txtCPassword.type = 'text';
        } else {
            txtPassword.type = 'password';
            txtCPassword.type = 'password';
        }
    });
</script>
