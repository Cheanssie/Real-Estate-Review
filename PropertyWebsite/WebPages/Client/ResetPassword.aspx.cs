using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PropertyWebsite.WebPages.Client
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["token"] == null)
            {
                Response.Redirect(Request.Url.GetLeftPart(UriPartial.Authority) + "/WebPages/Client/Home.aspx");
            }
        }
    }
}