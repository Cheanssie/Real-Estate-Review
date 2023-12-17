using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PropertyWebsite.WebPages.Client
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Remove("email");
            if (Request.Cookies["tokenUser"] != null && Request.Cookies["tokenPassword"] != null && Request.Cookies["tokenRole"] != null)
            {
                HttpCookie username = Request.Cookies["tokenUser"];
                HttpCookie password = Request.Cookies["tokenPassword"];
                HttpCookie role = Request.Cookies["tokenRole"];
                username.Expires = DateTime.Now.AddDays(-1);
                password.Expires = DateTime.Now.AddDays(-1);
                role.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(username);
                Response.Cookies.Add(password);
                Response.Cookies.Add(role);
            }
            if (Request.QueryString["action"] != null && Request.QueryString["token"] != null)
            {
                Response.Redirect(HttpContext.Current.Request.ApplicationPath + "WebPages/Client/ResetPassword.aspx?token=" + HttpUtility.UrlEncode(Request.QueryString["token"].ToString()));
            }
            else
            {
                Response.Redirect(HttpContext.Current.Request.ApplicationPath + "WebPages/Client/Homepage.aspx");
            }
        }
    }
}