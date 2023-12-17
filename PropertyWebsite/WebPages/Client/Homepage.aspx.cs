using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PropertyWebsite.WebPages.Client
{
    public partial class Homepage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


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
    }
}