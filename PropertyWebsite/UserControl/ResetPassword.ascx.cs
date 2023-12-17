using PropertyWebsite.Class;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PropertyWebsite.UserControl
{
    public partial class ResetPassword : System.Web.UI.UserControl
    {
        SqlConnection conn;
        SqlCommand command;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["token"] == null)
            {
                Response.Redirect(Request.Url.GetLeftPart(UriPartial.Authority) + "/WebPages/Client/Home.aspx");
            }
            else
            {
                conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                if (!IsPostBack)
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
                }
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string email = Tokenization.InterpreteToken(Request.QueryString["token"]);
            command = new SqlCommand("UPDATE Users SET password = @password WHERE email = @email", conn);
            command.Parameters.AddWithValue("@password", Tokenization.GenerateToken(txtCPassword.Text));
            command.Parameters.AddWithValue("@email", email);
            conn.Open();
            string emailBody = "Kindly inform that your password reset is ";
            if (command.ExecuteNonQuery() != 0)
            {
                emailBody += "successful.";
            }
            else
            {
                emailBody += "failed.";
            }

            EmailService.SendEmail(email, "iRoom Reset Password Status", emailBody);
            conn.Close();
            Response.Redirect(Request.Url.GetLeftPart(UriPartial.Authority) + "/WebPages/Client/Home.aspx");

        }
    }
}