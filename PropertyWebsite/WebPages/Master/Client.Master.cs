using PropertyWebsite.Class;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PropertyWebsite.WebPages.Master
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        SqlConnection conn;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            if (Request.Cookies["tokenUser"] != null && Request.Cookies["tokenPassword"] != null && Request.Cookies["tokenRole"] != null && Session["email"] == null)
            {
                string email = Tokenization.InterpreteToken(Request.Cookies["tokenUser"].Value);
                string password = Tokenization.InterpreteToken(Request.Cookies["tokenPassword"].Value);
                string role = Tokenization.InterpreteToken(Request.Cookies["tokenRole"].Value);

                cmd = new SqlCommand("SELECT * FROM Users WHERE email = @email", conn);
                cmd.Parameters.AddWithValue("@email", email);
                conn.Open();
                SqlDataReader readUser = cmd.ExecuteReader();
                if (readUser.HasRows)
                {
                    readUser.Read();
                    if (Tokenization.InterpreteToken(readUser["password"].ToString()) == password)
                    {
                        
                        Session["email"] = email;
                        Session["role"] = readUser["role"];
                        readUser.Close();
                        if (role.ToLower() == "admin")
                        {
                            Response.Redirect(HttpContext.Current.Request.ApplicationPath + "AdminPage/Dashboard.aspx");
                        }
                        else
                        {
                            Response.Redirect(HttpContext.Current.Request.ApplicationPath + "WebPages/Client/Homepage.aspx");
                        }
                    }
                    else
                    {
                        readUser.Close();
                        Response.Redirect(HttpContext.Current.Request.ApplicationPath + "WebPages/Client/Logout.aspx");
                    }
                }
                conn.Close();

            }
        }
    }
}