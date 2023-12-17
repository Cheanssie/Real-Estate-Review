using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PropertyWebsite.WebPages.Master
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["email"] != null && Session["role"].ToString() != "admin")
            {
                Response.Redirect(HttpContext.Current.Request.ApplicationPath + "WebPages/Client/Homepage.aspx");
            }
        }
    }
}