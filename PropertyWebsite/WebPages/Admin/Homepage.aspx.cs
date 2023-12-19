using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

namespace PropertyWebsite.WebPages.Admin
{
    public partial class Homepage : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "editCustom")
            {
                cmd = new SqlCommand("SELECT * FROM Property WHERE Pid = @Pid", conn);
                cmd.Parameters.AddWithValue("@Pid", e.CommandArgument);
                conn.Open();
                SqlDataReader readProperty = cmd.ExecuteReader();
                while (readProperty.Read())
                {
                    txtEditPid.Text = readProperty["Pid"].ToString();
                    txtEditPropId.Text = readProperty["propId"].ToString();
                    txtEditPropName.Text = readProperty["propName"].ToString();
                    txtEditAddress.Text = readProperty["propAddress"].ToString();
                    txtEditPropDesc.Text = readProperty["description"].ToString();
                    txtEditPrice.Text = readProperty["startPrice"].ToString();
                    txtEditEPrice.Text = readProperty["endPrice"].ToString();
                    ddlEditPropCategory.SelectedValue = readProperty["category"].ToString();
                    ddlEditPropArea.SelectedValue = readProperty["area"].ToString();
                }
                readProperty.Close();
                conn.Close();
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:openEditPanel(); ", true);
            }
            else if (e.CommandName == "deleteCustom")
            {
                txtDeletePropId.Text = e.CommandArgument.ToString();
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:openDeletePanel(); ", true);
            }
        }

        protected void btnEditSubmit_Click(object sender, EventArgs e)
        {
            string pId = txtEditPid.Text;
            string propName = txtEditPropName.Text;
            string propAddress = txtEditAddress.Text;
            string propDesc = txtEditPropDesc.Text;
            float propPrice, propEPrice;
            float.TryParse(txtEditPrice.Text, out propPrice);
            float.TryParse(txtEditEPrice.Text, out propEPrice);
            string propCategory = ddlEditPropCategory.SelectedValue;
            string propArea = ddlEditPropArea.SelectedValue;

            conn.Open();
            cmd = new SqlCommand("UPDATE Property SET propName = @propName, propAddress = @propAddress, description = @propDesc, category = @propCategory, area = @propArea, startPrice = @propPrice, endPrice = @propEPrice WHERE Pid = @Pid", conn);
            cmd.Parameters.AddWithValue("@propName", propName);
            cmd.Parameters.AddWithValue("@propAddress", propAddress);
            cmd.Parameters.AddWithValue("@propDesc", propDesc);
            cmd.Parameters.AddWithValue("@propCategory", propCategory);
            cmd.Parameters.AddWithValue("@propArea", propArea);
            cmd.Parameters.AddWithValue("@propPrice", propPrice);
            cmd.Parameters.AddWithValue("@propEPrice", propEPrice);
            cmd.Parameters.AddWithValue("@Pid", pId);

            if (cmd.ExecuteNonQuery() != 0)
            {
                string updateMsg = "Product updated successfully";
                if (fuEditImg.HasFiles)
                {
                    foreach (HttpPostedFile uploadedFile in fuEditImg.PostedFiles)
                    {
                        string fileName = Path.GetFileName(uploadedFile.FileName);
                        string imgPath = "../../Resources/PropertyImg/" + DateTime.Now.ToString("dd-MM-yyyy-hh-mm-ss-fffffff") + Path.GetExtension(uploadedFile.FileName);

                        // Save the image file
                        uploadedFile.SaveAs(Server.MapPath(imgPath));

                        // Create a new SqlCommand for each image insertion
                        SqlCommand imgCmd = new SqlCommand("INSERT INTO PropertyImg (url, Pid) VALUES (@url, @Pid)", conn);
                        imgCmd.Parameters.AddWithValue("@url", imgPath);
                        imgCmd.Parameters.AddWithValue("@Pid", pId);
                        imgCmd.ExecuteNonQuery();
                    }
                }

                foreach (RepeaterItem item in rptExistingImages.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        CheckBox chkRemoveImage = (CheckBox)item.FindControl("chkRemoveImage");

                        if (chkRemoveImage != null && chkRemoveImage.Checked)
                        {
                            cmd = new SqlCommand("SELECT COUNT(*) FROM PropertyImg WHERE Pid = @Pid", conn);
                            cmd.Parameters.AddWithValue("@Pid", pId);
                            int imgCount = (int)cmd.ExecuteScalar();
                            if (imgCount > 1)
                            {
                                TextBox txtImgId = (TextBox)item.FindControl("txtImgId");
                                cmd = new SqlCommand("DELETE propertyImg WHERE imgId = @imgId", conn);
                                cmd.Parameters.AddWithValue("@imgId", txtImgId.Text);
                                cmd.ExecuteNonQuery();
                            }
                            else
                            {
                                updateMsg = "Product updated successfully but at least one image is kept";
                            }
                            
                        }
                    }
                }
                GridView1.DataBind();
                rptExistingImages.DataBind();
                string script = string.Format("openPopupMsg('{0}');", updateMsg);
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "popupMsg", script, true);
            }
            conn.Close();

        }

        protected void btnAddProp_Click(object sender, EventArgs e)
        {
            string propName = txtPropName.Text;
            string propDesc = txtPropDesc.Text;
            string propAddress = txtPropAddress.Text;
            float propPrice, propEPrice;
            float.TryParse(txtPropPrice.Text, out propPrice);
            float.TryParse(txtPropEPrice.Text, out propEPrice);
            string propCategory = ddlPropCategory.SelectedValue;
            string propArea = ddlPropArea.SelectedValue;


            conn.Open();
            cmd = new SqlCommand("INSERT INTO Property VALUES(@propName, @propAddress, @category, @area,  @description, @startPrice, @endPrice); SELECT SCOPE_IDENTITY();", conn);
            cmd.Parameters.AddWithValue("@propName", propName);
            cmd.Parameters.AddWithValue("@propAddress", propAddress);
            cmd.Parameters.AddWithValue("@category", propCategory);
            cmd.Parameters.AddWithValue("@area", propArea);
            cmd.Parameters.AddWithValue("@description", propDesc);
            cmd.Parameters.AddWithValue("@startPrice", propPrice);
            cmd.Parameters.AddWithValue("@endPrice", propEPrice);
            int generatedPropertyID = Convert.ToInt32(cmd.ExecuteScalar());

            if (generatedPropertyID > 0)
            {
                GridView1.DataBind();
                txtPropName.Text = "";
                txtPropDesc.Text = "";
                txtPropAddress.Text = "";
                txtPropPrice.Text = "";
                txtPropEPrice.Text = "";

                if (fuAddProp.HasFiles)
                {
                    foreach (HttpPostedFile uploadedFile in fuAddProp.PostedFiles)
                    {
                        string fileName = Path.GetFileName(uploadedFile.FileName);
                        string imgPath = "../../Resources/PropertyImg/" + DateTime.Now.ToString("dd-MM-yyyy-hh-mm-ss-fffffff") + Path.GetExtension(uploadedFile.FileName);

                        // Save the image file
                        uploadedFile.SaveAs(Server.MapPath(imgPath));

                        // Create a new SqlCommand for each image insertion
                        SqlCommand imgCmd = new SqlCommand("INSERT INTO PropertyImg (url, Pid) VALUES (@url, @Pid)", conn);
                        imgCmd.Parameters.AddWithValue("@url", imgPath);
                        imgCmd.Parameters.AddWithValue("@Pid", generatedPropertyID);
                        imgCmd.ExecuteNonQuery();
                    }
                }

                string script = string.Format("openPopupMsg('{0}');", "Property added successfully");
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "popupMsg", script, true);
            }

            conn.Close();
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            conn.Open();
            cmd = new SqlCommand("DELETE PropertyImg WHERE Pid = @Pid", conn);
            cmd.Parameters.AddWithValue("@Pid", txtDeletePropId.Text);
            cmd.ExecuteNonQuery();

            cmd = new SqlCommand("DELETE Review WHERE Pid = @Pid", conn);
            cmd.Parameters.AddWithValue("@Pid", txtDeletePropId.Text);
            cmd.ExecuteNonQuery();

            cmd = new SqlCommand("DELETE Property WHERE Pid = @Pid", conn);
            cmd.Parameters.AddWithValue("@Pid", txtDeletePropId.Text);
            cmd.ExecuteNonQuery();

            GridView1.DataBind();
            string script = string.Format("openPopupMsg('{0}');", "Product deleted successfully");
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "popupMsg", script, true);
            

            conn.Close();
        }
    }
}