<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/Master/Admin.Master" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="PropertyWebsite.WebPages.Admin.Homepage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
         .form-control {
             background: white;
         }

             .form-control:focus {
                 background: white;
                 color: black;
             }

         #popup-container, #popup-container-edit, #popup-container-delete, #report-popup {
             position: fixed;
             top: 50%;
             left: 50%;
             transform: translate(-50%, -50%);
             z-index: 9999;
             display: none;
         }

         .gridview th a {
             text-decoration: none;
             color: inherit;
         }

         #imageContainer {
             position: relative;
             display: flex;
             flex-wrap: wrap;
             margin: 5px;
         }


         .image-slot {
             display: inline-block;
             margin: 10px; 
         }

         .small-image {
             width: 100px; 
             height: auto;
         }

         .modal-content {
             overflow: auto; 
             max-height: 80vh; 
         }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row mt-3">
            <div class="row d-flex align-content-center justify-content-center">
                <div class="col px-5">
                    <p class="fs-3">Property List</p>
                </div>
                <div class="col d-flex justify-content-end gap-2">
                <div class="text-end">
                    <input type="text" id="txtSearch" class="form-control text-black" title="Search by Property Name" placeholder="Search" />
                </div>
                <div class="text-end">
                    <button id="btn-addProp" class="btn btn-dark" type="button">Add Property</button>
                </div>
            </div>
                <hr />
            </div>
            <% if (GridView1.Rows.Count != 0)
                { %>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' 

                    SelectCommand="SELECT * FROM [Property]"
            
                    DeleteCommand="DELETE FROM [Property] WHERE [propId] = @original_propId AND [propName] = @original_propName AND 
                    [propAddress] = @original_propAddress AND [category] = @original_category AND [area] = @original_area AND 
                    [description] = @original_description AND [startPrice] = @original_startPrice AND [endPrice] = @original_endPrice"
                    
                    InsertCommand="INSERT INTO [Property] ([propId], [propName], [propAddress], [category], [area], [description], [startPrice], [endPrice]) 
                    VALUES (@propId, @propName, @propAddress, @category, @area, @description, @startPrice, @endPrice)" 
                    OldValuesParameterFormatString="original_{0}"
                    
                    UpdateCommand="UPDATE [Property] SET [propName] = @propName, [propAddress] = @propAddress, [category] = @category, 
                    [area] = @area, [description] = @description, [startPrice] = @startPrice, [endPrice] = @endPrice
                    WHERE [propId] = @original_propId AND [propName] = @original_propName AND [propAddress] = @original_propAddress AND
                    [category] = @original_category AND [area] = @original_area AND [description] = @original_description AND
                    [startPrice] = @original_startPrice AND [endPrice] = @original_endPrice">
                    
                <DeleteParameters>
                    <asp:Parameter Name="original_propId" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_propName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_propAddress" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_category" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_area" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_description" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_startPrice" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="original_endPrice" Type="Double"></asp:Parameter>
                </DeleteParameters>

                <InsertParameters>
                    <asp:Parameter Name="propId" Type="String"></asp:Parameter>
                    <asp:Parameter Name="propName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="propAddress" Type="String"></asp:Parameter>
                    <asp:Parameter Name="category" Type="String"></asp:Parameter>
                    <asp:Parameter Name="area" Type="String"></asp:Parameter>
                    <asp:Parameter Name="description" Type="String"></asp:Parameter>
                    <asp:Parameter Name="startPrice" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="endPrice" Type="Double"></asp:Parameter>
                </InsertParameters>

                <UpdateParameters>
                    <asp:Parameter Name="propName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="propAddress" Type="String"></asp:Parameter>
                    <asp:Parameter Name="category" Type="String"></asp:Parameter>
                    <asp:Parameter Name="area" Type="String"></asp:Parameter>
                    <asp:Parameter Name="description" Type="String"></asp:Parameter>
                    <asp:Parameter Name="startPrice" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="endPrice" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="original_propId" />
                    <asp:Parameter Name="original_propName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_propAddress" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_category" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_area" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_description" Type="String"></asp:Parameter>
                    <asp:Parameter Name="original_startPrice" Type="Double"></asp:Parameter>
                    <asp:Parameter Name="original_endPrice" Type="Double"></asp:Parameter>
                </UpdateParameters>
        </asp:SqlDataSource>

        <asp:GridView ID="GridView1" CssClass="table table-hover table-bordered text-center" runat="server" HorizontalAlign="Center" DataSourceID="SqlDataSource1"  AutoGenerateColumns="False" DataKeyNames="Pid" Font-Size="Smaller" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:BoundField DataField="propId" HeaderText="ID" SortExpression="propId" ReadOnly="True"></asp:BoundField>
                <asp:BoundField DataField="propName" HeaderText="Name" SortExpression="propName"></asp:BoundField>
                <asp:BoundField DataField="propAddress" HeaderText="Address" SortExpression="propAddress"></asp:BoundField>
                <asp:BoundField DataField="category" ItemStyle-CssClass="maxwidth-col" HeaderText="Category" SortExpression="category" ItemStyle-HorizontalAlign="Justify"></asp:BoundField>
                <asp:BoundField DataField="area" HeaderText="Area" SortExpression="area"></asp:BoundField>
                <asp:BoundField DataField="description" ItemStyle-CssClass="maxwidth-col" HeaderText="Description" SortExpression="description"></asp:BoundField>
                <asp:BoundField DataField="startPrice" HeaderText="Start Price" SortExpression="startPrice"></asp:BoundField>
                <asp:BoundField DataField="endPrice" HeaderText="End Price" SortExpression="endPrice"></asp:BoundField>
               <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                        <ItemTemplate>
                            <div class="d-flex">
                                <asp:Button ID="btnEdit" CssClass="btn btn-sm btn-success mx-1" runat="server" Text="Edit" CommandName="editCustom" CommandArgument='<%# Eval("Pid") %>' CausesValidation="False" />
                                <asp:Button ID="btnDelete" CssClass="btn btn-sm btn-danger mx-1" runat="server" Text="Delete" CommandName="deleteCustom" CommandArgument='<%# Eval("Pid") %>' CausesValidation="False" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
            </Columns>
            </asp:GridView>
            <% }
                else
                { %>
            <div class="text-center m-5">
                <h4>Currently have no property</h4>
                <p>Refresh to check for the latest information.</p>
            </div>
            <% } %>
        </div>

    <div id="popup-container" class="bg-white p-5 border-1 shadow w-50 modal-content">
        <div class="container">
            <div class="row mb-2">
                <div class="col-10">
                    <p class="fs-3"><b>Add Property</b></p>
                </div>
                <div class="col-2 text-end">
                    <button id="btn-closeProp" type="button" class="border-0 bg-transparent btn-close"></button>
                </div>
            </div>
            <div class="row mb-3">
                <div class="form-group col">
                    <label class="form-label">Property Name</label>
                    <asp:TextBox ID="txtPropName" CssClass="form-control" runat="server" ValidationGroup="addprop"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPropName" runat="server" ErrorMessage="Please fill in the property name" ControlToValidate="txtPropName" ForeColor="Red" Display="Dynamic" ValidationGroup="addprop"></asp:RequiredFieldValidator>
                </div>              
            </div>
            <div class="row mb-3">
                <div class="col">
                    <label class="form-label">Description</label><br />
                    <asp:TextBox ID="txtPropDesc" CssClass="form-control" runat="server" ValidationGroup="addprop"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPropDesc" runat="server" ErrorMessage="Please fill in the property description" ControlToValidate="txtPropDesc" ForeColor="Red" Display="Dynamic" ValidationGroup="addprop"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col">
                    <label class="form-label">Address</label><br />
                    <asp:TextBox ID="txtPropAddress" CssClass="form-control" runat="server" ValidationGroup="addprop"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPropAdd" runat="server" ErrorMessage="Please fill in the property description" ControlToValidate="txtPropAddress" ForeColor="Red" Display="Dynamic" ValidationGroup="addprop"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="row mt-3">
                <div class="col">
                    <label class="form-label">Start Price</label>
                    <asp:TextBox ID="txtPropPrice" CssClass="form-control" runat="server" ValidationGroup="addprop"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPropPrice" runat="server" ErrorMessage="Please fill in the property price" ControlToValidate="txtPropPrice" ForeColor="Red" Display="Dynamic" ValidationGroup="addprop"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPropPrice" runat="server" ErrorMessage="Invalid Price" ControlToValidate="txtPropPrice" ForeColor="Red" Display="Dynamic" ValidationExpression="^\d+(\.\d{1,2})?$" ValidationGroup="addprop"></asp:RegularExpressionValidator>
                </div>
                <div class="col">
                    <label class="form-label">End Price</label>
                    <asp:TextBox ID="txtPropEPrice" CssClass="form-control" runat="server" ValidationGroup="addprop"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPropEPrice" runat="server" ErrorMessage="Please fill in the property price" ControlToValidate="txtPropEPrice" ForeColor="Red" Display="Dynamic" ValidationGroup="addprop"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPropEPrice" runat="server" ErrorMessage="Invalid Price" ControlToValidate="txtPropEPrice" ForeColor="Red" Display="Dynamic" ValidationExpression="^\d+(\.\d{1,2})?$" ValidationGroup="addprop"></asp:RegularExpressionValidator>
                </div>
                <div class="col">
                    <label class="form-label">Category</label>
                    <asp:DropDownList ID="ddlPropCategory" CssClass="form-select" runat="server">
                        <asp:ListItem>Airbnb</asp:ListItem>
                        <asp:ListItem>Homestay</asp:ListItem>
                        <asp:ListItem>Hotel</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col">
                    <label class="form-label">Area</label>
                    <asp:DropDownList ID="ddlPropArea" CssClass="form-select" runat="server">
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
            </div>
            <div class="row d-flex justify-content-between mb-4 mt-3">
                <div class="col">
                    <asp:FileUpload ID="fuAddProp" runat="server" CssClass="form-control" ValidationGroup="addprop"  ClientIDMode="Static" AllowMultiple="true"/>
                    <asp:RequiredFieldValidator ID="rfvPropImg" runat="server" ErrorMessage="Please upload property image" ControlToValidate="fuAddProp" ForeColor="Red" ValidationGroup="addprop"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="d-flex justify-content-center">
                <asp:Button ID="btnAddProp" CssClass="btn btn-dark" Width="100%" runat="server" Text="Add" OnClick="btnAddProp_Click" ValidationGroup="addprop"/>
            </div>
        </div>
    </div>

    <div id="popup-container-edit" class="bg-white p-5 border-1 shadow w-50 modal-content">
        <div class="container">
            <div class="row mb-2">
                <div class="col-10">
                    <p class="fs-3"><b>Edit Propuct</b></p>
                </div>
                <div class="col-2 text-end">
                    <button id="btn-closeEdit" type="button" class="border-0 bg-transparent btn-close"></button>
                </div>
            </div>
            <div class="row mb-3">
                <div class="form-group col-8">
                    <label class="form-label">Property Name</label>
                    <asp:TextBox ID="txtEditPropName" CssClass="form-control" runat="server" ValidationGroup="editprop"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEditPropName" runat="server" ErrorMessage="Please fill in the property name" ControlToValidate="txtEditPropName" ForeColor="Red" Display="Dynamic" ValidationGroup="editprop"></asp:RequiredFieldValidator>
                </div>
                <div class="col-4">
                    <label class="form-label">Property ID</label>
                    <asp:TextBox ID="txtEditPropId" CssClass="form-control" runat="server" ValidationGroup="editprop" Enabled="false"></asp:TextBox>
                    <asp:TextBox ID="txtEditPid" CssClass="form-control d-none" runat="server" ValidationGroup="editprop" Enabled="false"></asp:TextBox>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col">
                    <label class="form-label">Description</label><br />
                    <asp:TextBox ID="txtEditPropDesc" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please fill in the property description" ControlToValidate="txtEditPropDesc" ForeColor="Red" Display="Dynamic" ValidationGroup="editprop"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col">
                    <label class="form-label">Address</label><br />
                    <asp:TextBox ID="txtEditAddress" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please fill in the property description" ControlToValidate="txtEditAddress" ForeColor="Red" Display="Dynamic" ValidationGroup="editprop"></asp:RequiredFieldValidator>
                </div>
            </div>
            
            <div class="row mt-3">
                <div class="col">
                    <label class="form-label">Start Price</label>
                    <asp:TextBox ID="txtEditPrice" CssClass="form-control" runat="server" ValidationGroup="editprop"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEditPrice" runat="server" ErrorMessage="Please fill in the property price" ControlToValidate="txtEditPrice" ForeColor="Red" Display="Dynamic" ValidationGroup="editprop"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEditPrice" runat="server" ErrorMessage="Invalid Price" ControlToValidate="txtEditPrice" ForeColor="Red" Display="Dynamic" ValidationExpression="^\d+(\.\d{1,2})?$" ValidationGroup="editprop"></asp:RegularExpressionValidator>
                </div>
                <div class="col">
                    <label class="form-label">End Price</label>
                    <asp:TextBox ID="txtEditEPrice" CssClass="form-control" runat="server" ValidationGroup="editprop"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEditEPrice" runat="server" ErrorMessage="Please fill in the property price" ControlToValidate="txtEditEPrice" ForeColor="Red" Display="Dynamic" ValidationGroup="editprop"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEditEPrice" runat="server" ErrorMessage="Invalid Price" ControlToValidate="txtEditEPrice" ForeColor="Red" Display="Dynamic" ValidationExpression="^\d+(\.\d{1,2})?$" ValidationGroup="editprop"></asp:RegularExpressionValidator>
                </div>
                <div class="col">
                    <label class="form-label">Category</label>
                    <asp:DropDownList ID="ddlEditPropCategory" CssClass="form-select" runat="server">
                        <asp:ListItem>Air Bnb</asp:ListItem>
                        <asp:ListItem>Hotel</asp:ListItem>
                        <asp:ListItem>Homestay</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col">
                    <label class="form-label">Area</label>
                    <asp:DropDownList ID="ddlEditPropArea" CssClass="form-select" runat="server">
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
            </div>
            <div id="imageContainer" class="mt-3">
                <asp:Repeater ID="rptExistingImages" runat="server" DataSourceID="SqlDataSource2">
                    <ItemTemplate>
                        <div class="image-slot">
                            <img src='<%# Eval("url") %>' alt="Existing Image" class="img-thumbnail small-image" />
                            <asp:CheckBox ID="chkRemoveImage" runat="server" Text="Remove" />
                            <asp:TextBox ID="txtImgId" CssClass="d-none" runat="server" Text='<%# Eval("imgId") %>'></asp:TextBox>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [PropertyImg] WHERE ([Pid] = @Pid)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtEditPid" PropertyName="Text" Name="Pid" Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <div class="row d-flex justify-content-between mb-4 mt-3">
                <div class="col form-group">
                    <label for="fuEditImg" class="form-label">Upload Images</label>
                    <asp:FileUpload ID="fuEditImg" CssClass="form-control" runat="server" ValidationGroup="editprop" ClientIDMode="Static" AllowMultiple="true" />
                    <span class="text-info" style="font-size:small;">Select one or more images to upload</span>
                </div>
            </div>
            <div class="d-flex justify-content-center">
                <asp:Button ID="btnEditSubmit" CssClass="btn btn-dark" Width="100%" runat="server" Text="Update" ValidationGroup="editprop" OnClick="btnEditSubmit_Click" />
            </div>
        </div>
    </div>

    <div id="popup-container-delete" class="bg-white p-5 border-1 shadow w-25">
        <div class="container">
            <div class="row mb-2">
                <p class="text-center fs-4">Are you sure to delete?</p>
            </div>

            <div class="container d-flex justify-content-center">
                <button id="btn-closeDelete" class="btn btn-light mx-2">Cancel</button>
                <asp:TextBox ID="txtDeletePropId" CssClass="d-none" runat="server"></asp:TextBox>
                <asp:Button ID="btnConfirmDelete" CssClass="btn btn-danger mx-2" runat="server" Text="Confirm" OnClick="btnConfirmDelete_Click" />
            </div>
        </div>
    </div>
     <script type="text/javascript">
         //-------------------------Add Propuct
         var showPopupBtn = document.getElementById('btn-addProp');
         var closePopupBtn = document.getElementById('btn-closeProp');

         var popupContainer = document.getElementById('popup-container');
         var closePopup = document.getElementById('btn-closeReport');
         var popupReport = document.getElementById('report-popup');

         showPopupBtn.addEventListener('click', function () {
             popupContainer.style.display = 'block';
         });

         closePopupBtn.addEventListener('click', function () {
             popupContainer.style.display = 'none';
         });

        //-------------------------Edit Propuct
        var btnEditClose = document.getElementById('btn-closeEdit');
        var editPanel = document.getElementById('popup-container-edit');

        btnEditClose.addEventListener('click', function () {
            editPanel.style.display = 'none';
        });

        function openEditPanel() {
            editPanel.style.display = 'block';
        }

        var deletePanel = document.getElementById('popup-container-delete');
        var deletePanelCloseBtn = document.getElementById('btn-closeDelete');


        function openDeletePanel() {
            deletePanel.style.display = 'block';
        }
        deletePanelCloseBtn.addEventListener('click', function () {
            deletePanel.style.display = 'none';
        });

        var propNav = document.getElementById('property');
        propNav.classList.add('active');

       
     </script>


</asp:Content>
