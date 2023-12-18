using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

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
            if(e.CommandName == "editCustom")
            {
                cmd = new SqlCommand("SELECT * FROM Property WHERE Pid = @Pid", conn);
                cmd.Parameters.AddWithValue("@Pid", e.CommandArgument);
                conn.Open();
                SqlDataReader readProperty = cmd.ExecuteReader();
                while (readProperty.Read())
                {
                    txtEditPropId.Text = readProperty["propId"].ToString();
                    txtEditPropName.Text = readProperty["propName"].ToString();
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
        }

        protected void btnEditSubmit_Click(object sender, EventArgs e)
        {
            string propId = txtEditPropId.Text;
            string propName = txtEditPropName.Text;
            string propAddress = txtEditAddress.Text;
            string propDesc = txtEditPropDesc.Text;
            float propPrice, propEPrice;
            float.TryParse(txtEditPrice.Text, out propPrice);
            float.TryParse(txtEditEPrice.Text, out propEPrice);
            string propCategory = ddlEditPropCategory.SelectedValue;
            string propArea = ddlEditPropArea.SelectedValue;

            conn.Open();
            cmd = new SqlCommand("UPDATE Property SET propName = @propName, propAddress = @propAddress, description = @propDesc, category = @propCategory, area = @propArea, startPrice = @propPrice, endPrice = @propEPrice", conn);
            cmd.Parameters.AddWithValue("@propName", propName);
            cmd.Parameters.AddWithValue("@propAddress", propAddress);
            cmd.Parameters.AddWithValue("@propDesc", propDesc);
            cmd.Parameters.AddWithValue("@propCategory", propCategory);
            cmd.Parameters.AddWithValue("@propArea", propArea);
            cmd.Parameters.AddWithValue("@propPrice", propPrice);
            cmd.Parameters.AddWithValue("@propEPrice", propEPrice);

            if (cmd.ExecuteNonQuery() != 0)
            {
                GridView1.DataBind();
                string script = string.Format("openPopupMsg('{0}');", "Product updated successfully");
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
            string imgPath = "../../Resources/PropertyImg/" + DateTime.Now.ToString("dd-MM-yyyy-hh-mm-ss") + Path.GetExtension(fuAddProp.FileName);
            fuAddProp.SaveAs(Server.MapPath("../../Resources/PropertyImg/") + DateTime.Now.ToString("dd-MM-yyyy-hh-mm-ss") + Path.GetExtension(fuAddProp.FileName));
            
            conn.Open();
            cmd = new SqlCommand("INSERT INTO Property VALUES(@propName, @propAddress, @category, @area,  @description, @startPrice, @endPrice)", conn);
            cmd.Parameters.AddWithValue("@propName", propName);
            cmd.Parameters.AddWithValue("@propAddress", propAddress);
            cmd.Parameters.AddWithValue("@category", propCategory);
            cmd.Parameters.AddWithValue("@area", propArea);
            cmd.Parameters.AddWithValue("@description", propDesc);
            cmd.Parameters.AddWithValue("@startPrice", propPrice);
            cmd.Parameters.AddWithValue("@endPrice", propEPrice);

            cmd = new SqlCommand("SELECT TOP 1 Pid FROM Property ORDER BY Pid DESC", conn);
            var latestPid = cmd.ExecuteScalar();

            cmd = new SqlCommand("INSERT INTO PropertyImg VALUES(@url, @Pid)", conn);
            cmd.Parameters.AddWithValue("@url", imgPath);
            cmd.Parameters.AddWithValue("@Pid", latestPid);

            if (cmd.ExecuteNonQuery() != 0)
            {
                GridView1.DataBind();
                txtPropName.Text = "";
                txtPropDesc.Text = "";
                txtPropAddress.Text = "";
                txtPropPrice.Text = "1";
                txtPropEPrice.Text = "1";
                string script = string.Format("openPopupMsg('{0}');", "Property added successfully");
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "popupMsg", script, true);
            }

            conn.Close();
        }

    }
}