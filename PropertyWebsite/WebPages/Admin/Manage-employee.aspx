<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/Master/Admin.Master" AutoEventWireup="true" CodeBehind="Manage-employee.aspx.cs" Inherits="PropertyWebsite.WebPages.Admin.Employee" %>
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
                         (userId LIKE '%' + @key + '%' OR username LIKE '%' + @key + '%' OR email LIKE '%' + @key + '%')" 
                         ConflictDetection="CompareAllValues"

                         DeleteCommand="DELETE FROM [Users] WHERE [userId] = @original_userId AND [username] = @original_username AND 
                         [email] = @original_email AND [password] = @original_password AND [status] = @original_status AND
                         [img] = @original_img AND [role] = @original_role"
             
                         InsertCommand="INSERT INTO [Users] ([username], [email], [password], [status], [img], [role]) 
                         VALUES (@userId, @username, @email, @password, @status, @img, @role)"
                         OldValuesParameterFormatString="original_{0}" 
             
                         UpdateCommand="UPDATE [Users] SET [username] = @username, [email] = @email, [password] = @password, [status] = @status, 
                         [img] = @img, [role] = @role WHERE [Uid] = @original_Uid AND 
                         [username] = @original_username AND [email] = @original_email AND [password] = @original_password AND
                         [status] = @original_status AND [img] = @original_img AND [role] = @original_role">

                    <DeleteParameters>
                        <asp:Parameter Name="original_userId"></asp:Parameter>
                        <asp:Parameter Name="original_username" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_email" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_password" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_status" Type="Boolean"></asp:Parameter>
                        <asp:Parameter Name="original_img"></asp:Parameter>
                        <asp:Parameter Name="original_role" Type="String"></asp:Parameter>
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="userId" />
                        <asp:Parameter Name="username" Type="String"></asp:Parameter>
                        <asp:Parameter Name="email" Type="String"></asp:Parameter>
                        <asp:Parameter Name="password" Type="String"></asp:Parameter>
                        <asp:Parameter Name="status" Type="Boolean"></asp:Parameter>
                        <asp:Parameter Name="img"></asp:Parameter>
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
                        <asp:Parameter Name="original_Uid" />
                        <asp:Parameter Name="original_username" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_email" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_password" Type="String"></asp:Parameter>
                        <asp:Parameter Name="original_status" Type="Boolean"></asp:Parameter>
                        <asp:Parameter Name="original_img"></asp:Parameter>
                        <asp:Parameter Name="original_role" Type="String"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView1" CssClass="table table-hover table-bordered text-center gridview" HeaderStyle-CssClass="text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="username" DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="5" AllowSorting="True" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="userId" HeaderText="User Id" ReadOnly="True" SortExpression="userId" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField DataField="username" HeaderText="Username" ReadOnly="True" SortExpression="username" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email"></asp:BoundField>
                       <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" HeaderText="Status">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkStatus" runat="server" Checked='<%# Eval("status") %>' AutoPostBack="true" OnCheckedChanged="chkStatus_CheckedChanged"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" CssClass="btn btn-sm btn-success" runat="server" Text="Edit" CommandName="editCustom" CommandArgument='<%# Eval("email") %>' />
                                <asp:Button ID="btnDelete" CssClass="btn btn-sm btn-danger" runat="server" Text="Delete" CommandName="deleteCustom" CommandArgument='<%# Eval("email") %>' />
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
