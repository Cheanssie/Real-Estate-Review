using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Runtime.Remoting.Messaging;
using PropertyWebsite.Class;
using System.Net;
using System.Net.Mail;

namespace PropertyWebsite.WebPages.Client
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlCommand command;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            cmd = new SqlCommand("SELECT * FROM Users WHERE email = @email", conn);
            cmd.Parameters.AddWithValue("@email", txtEmailL.Text);
            conn.Open();
            SqlDataReader userReader = cmd.ExecuteReader();
            if (userReader.HasRows)
            {
                userReader.Read();
                if (userReader["status"].ToString().ToLower() == "true")
                {
                    if (Tokenization.InterpreteToken(userReader["password"].ToString()) == txtPassword.Text)
                    {                        
                        string role = userReader["role"].ToString().ToLower();
                        //Create Session
                        Session["email"] = txtEmailL.Text;
                        Session["role"] = role;
                        userReader.Close();
                        conn.Close();

                        if (cbRememberMe.Checked)
                        {
                            HttpCookie userCookie = new HttpCookie("tokenUser");
                            HttpCookie passwordCookie = new HttpCookie("tokenPassword");
                            HttpCookie roleCookie = new HttpCookie("tokenRole");
                            userCookie.Value = Tokenization.GenerateToken(txtEmailL.Text);
                            passwordCookie.Value = Tokenization.GenerateToken(txtPassword.Text);
                            roleCookie.Value = Tokenization.GenerateToken(role);
                            userCookie.Expires = DateTime.Now.AddDays(365);
                            passwordCookie.Expires = DateTime.Now.AddDays(365);
                            roleCookie.Expires = DateTime.Now.AddDays(365);
                            Response.Cookies.Add(userCookie);
                            Response.Cookies.Add(passwordCookie);
                            Response.Cookies.Add(roleCookie);
                        }

                        if (role == "admin")
                        {
                            Response.Redirect(HttpContext.Current.Request.ApplicationPath + "WebPages/Admin/Homepage.aspx");
                        }
                        else
                        {
                            Response.Redirect(HttpContext.Current.Request.ApplicationPath + "WebPages/Client/Homepage.aspx");
                        }
                    }
                    else
                    {
                        lblError.Text = "Invalid username or password";
                    }
                }
                else
                {
                    lblError.Text = "Account is freezed";
                    userReader.Close();
                    conn.Close();
                }
            }
            else
            {
                lblError.Text = "Invalid username or password";
            }
        }

        protected void btnConfirmReset_Click(object sender, EventArgs e)
        {
            command = new SqlCommand("SELECT username FROM [Users] WHERE email = @email", conn);
            command.Parameters.AddWithValue("@email", txtEmail.Text);
            conn.Open();
            object result = command.ExecuteScalar();
            conn.Close();

            if (result != null)
            {
                string token = HttpUtility.UrlEncode(Tokenization.GenerateToken(txtEmail.Text));
                string emailBody = "";
                emailBody += "<p>Please be informed that you have requested to reset password using email address, click on the link to visit password reseting page.";
                emailBody += "<br/><a href=\"" + Request.Url.GetLeftPart(UriPartial.Authority) + "/WebPages/Client/Logout.aspx?token=" + token + "&action=reset" + "\">Reset Password</a>";
                emailBody += "<p>Please ignore this or report to us if the action is not performed by you.</p>";

                EmailService.SendEmail(txtEmail.Text, "iRoom Change Password Request", emailBody);
                lblErrorForgetPass.Text = "";
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:openMsgPanel('Please check your inbox to reset password'); ", true);

            }
            else
            {
                lblErrorForgetPass.Text = "Email does not exist!";
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:openForgetPanel(); ", true);

            }

        }
    }
}
   