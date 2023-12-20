using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PropertyWebsite.WebPages.Client
{
    public partial class Homepage : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        }

        protected void rptProd_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName == "detail")
            {
                Response.Redirect(HttpContext.Current.Request.ApplicationPath + "WebPages/Client/PropertyDetail.aspx?Pid=" + e.CommandArgument.ToString());
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchText = searchInput.Text.ToString();
            Response.Redirect("Property.aspx?searchText=" + searchText + "&category=" + ddlCategory.SelectedValue + "&area=" + ddlArea.SelectedValue);
        }

        protected void rptProd_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType == ListItemType.Item)
            {
                DataRowView dataItem = e.Item.DataItem as DataRowView;

                if(dataItem != null) 
                {
                    int pid = Convert.ToInt32(dataItem["Pid"]);

                    Image propImg = e.Item.FindControl("propImg") as Image;
                    cmd = new SqlCommand("SELECT TOP 1 * FROM PropertyImg WHERE Pid = @Pid", conn);
                    cmd.Parameters.AddWithValue("@Pid", pid);
                    conn.Open();
                    SqlDataReader readImg = cmd.ExecuteReader();
                    if(readImg.Read()) {
                        propImg.ImageUrl = readImg["url"].ToString();
                    }
                    readImg.Close();
                    conn.Close(); 
                }
            }
        }
    }
}