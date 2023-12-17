<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/Master/Admin.Master" AutoEventWireup="true" CodeBehind="Manage-employee.aspx.cs" Inherits="PropertyWebsite.WebPages.Manage-employee" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <style>
        .maxwidth-col {
            max-width: 150px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .form-control {
            background: white;
        }

            .form-control:focus {
                background: white;
                color: black;
            }

        #popup-container, #popup-container-edit, #popup-container-delete {
            position: fixed;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 9999;
            display: none;
        }

        .gridview th a {
            text-decoration: none;
            color: inherit;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid p-5">
        <div class="row d-flex align-content-center">
            <div class="col-md-8">
                <p class="fs-2">Employees</p>
            </div>
            <div class="col-md-2 text-end">
                <input type="text" id="txtSearch" title="Search by All Fields" class="form-control text-black" placeholder="Search"/>
            </div>
            <div class="col-md-2 text-end">
                <button id="btn-addEmp" class="btn btn-primary" type="button">Add Employee</button>
            </div>
            <hr />
        </div>

     <% if (GridView1.Rows.Count != 0)
         { %>
     <div class="table-responsive">
         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' 
             SelectCommand="SELECT * FROM [Users] WHERE role = 'admin' AND 
             (userid LIKE '%' + @key + '%' OR username LIKE '%' + @key + '%' OR email LIKE '%' + @key + '%'" 
             ConflictDetection="CompareAllValues" 
             
             DeleteCommand="DELETE FROM [Users] WHERE [userid] = @original_userid AND [username] = @original_username AND 
             [email] = @original_email AND [password] = @original_password AND [status] = @original_status AND
             [img] = @original_img AND [role] = @original_role"
             
             InsertCommand="INSERT INTO [Users] ([userid], [username], [email], [password], [status], [img], [role]) 
             VALUES (@userid, @username, @email, @password, @status, @img, @role)" 
             OldValuesParameterFormatString="original_{0}" 
             
             UpdateCommand="UPDATE [Users] SET [username] = @username, [email] = @email, [password] = @password, [status] = @status, 
             [img] = @img, [role] = @role WHERE [Uid] = @original_Uid AND 
             [username] = @original_username AND [email] = @original_email AND [password] = @original_password AND
             [status] = @original_status AND [img] = @original_img AND [role] = @original_role">
             
             <DeleteParameters>
                 <asp:Parameter Name="original_userid" Type="String"></asp:Parameter>
                 <asp:Parameter Name="original_username" Type="String"></asp:Parameter>
                 <asp:Parameter Name="original_email" Type="String"></asp:Parameter>
                 <asp:Parameter Name="original_password" Type="String"></asp:Parameter>
                 <asp:Parameter Name="original_status" Type="String"></asp:Parameter>
                 <asp:Parameter Name="original_img" />
                 <asp:Parameter Name="original_role" Type="String"></asp:Parameter>
             </DeleteParameters>
             <InsertParameters>
                 <asp:Parameter Name="userid" Type="String"></asp:Parameter>
                 <asp:Parameter Name="username" Type="String"></asp:Parameter>
                 <asp:Parameter Name="email" Type="String"></asp:Parameter>
                 <asp:Parameter Name="password" Type="String"></asp:Parameter>
                 <asp:Parameter Name="status" Type="String"></asp:Parameter>
                 <asp:Parameter Name="img" />
                 <asp:Parameter Name="role" Type="String"></asp:Parameter>
             </InsertParameters>

             <SelectParameters>
                 <asp:QueryStringParameter QueryStringField="searchKey" DefaultValue="%" Name="key"></asp:QueryStringParameter>

             </SelectParameters>
             <UpdateParameters>
                 <asp:Parameter Name="username"></asp:Parameter>
                 <asp:Parameter Name="email" Type="String"></asp:Parameter>
                 <asp:Parameter Name="password" Type="String"></asp:Parameter>
                 <asp:Parameter Name="status" Type="Boolean"></asp:Parameter>
                 <asp:Parameter Name="img"></asp:Parameter>
                 <asp:Parameter Name="role" Type="String"></asp:Parameter>
                 <asp:Parameter Name="original_Uid"></asp:Parameter>
                 <asp:Parameter Name="original_username" Type="String"></asp:Parameter>
                 <asp:Parameter Name="original_email" Type="String"></asp:Parameter>
                 <asp:Parameter Name="original_password" Type="String"></asp:Parameter>
                 <asp:Parameter Name="original_status" Type="String"></asp:Parameter>
                 <asp:Parameter Name="original_img"></asp:Parameter>
                 <asp:Parameter Name="original_role" Type="String"></asp:Parameter>
             </UpdateParameters>
         </asp:SqlDataSource>

         <asp:GridView ID="GridView1" CssClass="table table-hover table-bordered text-center gridview" HeaderStyle-CssClass="text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="username" DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="5" AllowSorting="True" OnRowCommand="GridView1_RowCommand">
             <Columns>
                 <asp:BoundField DataField="userid" HeaderText="User Id" ReadOnly="True" SortExpression="userid" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                 <asp:BoundField DataField="username" HeaderText="Username" SortExpression="username"></asp:BoundField>
                 <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email"></asp:BoundField>
                 <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" HeaderText="Status">
                     <ItemTemplate>
                         <asp:CheckBox ID="chkStatus" runat="server" Checked='<%# Eval("status") %>' AutoPostBack="true" OnCheckedChanged="chkStatus_CheckedChanged"/>
                     </ItemTemplate>
                 </asp:TemplateField>
                 
                 <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" HeaderText="Action">
                     <ItemTemplate>
                         <asp:Button ID="btnEdit" CssClass="btn btn-sm btn-success" runat="server" Text="Edit" CommandName="editCustom" CommandArgument='<%# Eval("username") %>' />
                         <asp:Button ID="btnDelete" CssClass="btn btn-sm btn-danger" runat="server" Text="Delete" CommandName="deleteCustom" CommandArgument='<%# Eval("username") %>' />
                     </ItemTemplate>
                 </asp:TemplateField>
             </Columns>
         </asp:GridView>
     </div>
     <% }
         else
         { %>
     <div class="text-center m-5">
         <h4>Currently have no employee</h4>
         <p>Grant access to your staff now.</p>
     </div>
     <% } %>
 </div>

 <div id="popup-container" class="bg-white p-5 border-1 shadow w-50">
     <div class="container">
         <div class="row mb-2">
             <div class="col-10">
                 <p class="fs-3"><b>Add Employee</b></p>
             </div>
             <div class="col-2 text-end">
                 <button id="btn-closeEmp" type="button" class="border-0 bg-transparent btn-close"></button>
             </div>
         </div>
         <div class="row mb-3" id="p">
             <div class="col-3">
                 <label class="form-label">Username</label>
                 <asp:TextBox ID="txtUsername" CssClass="form-control" runat="server" ValidationGroup="addEmp"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Please fill in Username" ControlToValidate="txtUsername" ValidationGroup="addEmp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
             </div>
             <div class="col-9">
                 <label class="form-label">Email</label>
                 <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" ValidationGroup="addEmp"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Please fill in email" ValidationGroup="addEmp" ForeColor="Red" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="Please enter a valid email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="addEmp" ForeColor="Red" Display="Dynamic" ControlToValidate="txtEmail"></asp:RegularExpressionValidator>
             </div>
         </div>
                    
         <div class="row mt-3 mb-5">
             <label class="form-label">Upload Image</label><br />
             <asp:FileUpload ID="fuEmp" runat="server" ValidationGroup="addEmp" />
             <asp:RequiredFieldValidator ID="rfvEmpImg" runat="server" ErrorMessage="Please upload employee image" ControlToValidate="fuEmp" ForeColor="Red" ValidationGroup="addEmp"></asp:RequiredFieldValidator>
         </div>

         <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
         <div class="d-flex justify-content-center mt-3">
             <asp:Button ID="btnAddEmp" CssClass="btn btn-primary" Width="100%" runat="server" Text="Add" ValidationGroup="addEmp" OnClick="btnAddEmp_Click" />
         </div>
     </div>
 </div>

 <div id="popup-container-edit" class="bg-white p-5 border-1 shadow w-50">
     <div class="container">
         <div class="row mb-2">
             <div class="col-10">
                 <p class="fs-3"><b>Edit Employee</b></p>
             </div>
             <div class="col-2 text-end">
                 <button id="btn-closeEdit" type="button" class="border-0 bg-transparent btn-close"></button>
             </div>
         </div>
         <div class="row mb-3">
             <div class="col-3">
                 <label class="form-label">Username</label>
                 <asp:TextBox ID="txtEditUsername" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
             </div>
             <div class="col-9">
                 <label class="form-label">Email</label>
                 <asp:TextBox ID="txtEditEmail" CssClass="form-control" runat="server" Enabled="false"></asp:TextBox>
             </div>
         </div>
         <asp:Label ID="lblEditError" runat="server" Text="" ForeColor="Red"></asp:Label>
         <div class="row mt-3 mb-5">
             <label class="form-label">Upload Image</label><br />
             <asp:FileUpload ID="fuEditEmp" runat="server" ValidationGroup="editEmp" />
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please upload employee image" ControlToValidate="fuEmp" ForeColor="Red" ValidationGroup="editEmp"></asp:RequiredFieldValidator>
         </div>

         <div class="d-flex justify-content-center mt-3">
             <asp:Button ID="btnEditSubmit" CssClass="btn btn-primary" Width="100%" runat="server" Text="Update" OnClick="btnEditSubmit_Click" ValidationGroup="editEmp" />
         </div>
     </div>
 </div>

 <div id="popup-container-delete" class="bg-white p-5 border-1 shadow w-25">
     <div class="container">
         <div class="row mb-2">
             <p class="text-center fs-4">Are you sure to delete?</p>
         </div>

         <div class="container d-flex justify-content-center">
             <button id="btn-closeDelete" class="btn btn-primary btn-light mx-2">Cancel</button>
             <asp:TextBox ID="txtDeleteUser" CssClass="form-control d-none" runat="server"></asp:TextBox>
             <asp:Button ID="btnConfirmDelete" CssClass="btn btn-primary btn-danger mx-2" runat="server" Text="Confirm" OnClick="btnConfirmDelete_Click" />
         </div>
     </div>
 </div>
 <script type="text/javascript">
     var showPopupBtn = document.getElementById('btn-addEmp');
     var closePopupBtn = document.getElementById('btn-closeEmp');

     var popupContainer = document.getElementById('popup-container');

     showPopupBtn.addEventListener('click', function () {
         popupContainer.style.display = 'block';
     });

     closePopupBtn.addEventListener('click', function () {
         popupContainer.style.display = 'none';
     });

     window.addEventListener('scroll', function () {
         // reposition the pop-up in the center of the screen when scrolling
         popupContainer.style.top = window.innerHeight / 2 + 'px';
     });

     function openAddPanel() {
         popupContainer.style.display = 'block';
     }

     var editPanel = document.getElementById('popup-container-edit');
     var editPanelCloseBtn = document.getElementById('btn-closeEdit');
     function openEditPanel() {
         editPanel.style.display = 'block';
     }
     editPanelCloseBtn.addEventListener('click', function () {
         editPanel.style.display = 'none';
     });

     var deletePanel = document.getElementById('popup-container-delete');
     var deletePanelCloseBtn = document.getElementById('btn-closeDelete');


     function openDeletePanel() {
         deletePanel.style.display = 'block';
     }
     deletePanelCloseBtn.addEventListener('click', function () {
         deletePanel.style.display = 'none';
     });

     var empNav = document.getElementById('employee');
     empNav.classList.add('active');

     $(document).ready(function () {
         var queryString = window.location.search;

         // create a URLSearchParams object
         var params = new URLSearchParams(queryString);

         // get the value of the "param" parameter
         var paramValue = params.get("searchKey");

         // display the value in an alert box
         $("#txtSearch").val(paramValue);
     });

     $("#txtSearch").keydown(function (event) {
         if (event.keyCode == 13) {
             event.preventDefault();
             window.location.href = "Manage-employee.aspx?searchKey=" + $("#txtSearch").val();
         }
     });
 </script>

</asp:Content>
