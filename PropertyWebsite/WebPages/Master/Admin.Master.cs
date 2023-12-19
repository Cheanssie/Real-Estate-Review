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
            if (Application["Analyzer"] == null)
            {
                Application["Analyzer"] = "lexiconMT";
            }
        }

        protected void btnLex_Click(object sender, EventArgs e)
        {
            Application["Analyzer"] = "lexiconMT";
        }

        protected void btnML_Click(object sender, EventArgs e)
        {
            Application["Analyzer"] = "machineLearningMT";
        }
    }
}