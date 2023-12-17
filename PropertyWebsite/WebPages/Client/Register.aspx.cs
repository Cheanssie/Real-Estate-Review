using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using PropertyWebsite.Class;

namespace PropertyWebsite.WebPages.Client
{
    public partial class Register : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand command;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        }

        protected void register_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                command = new SqlCommand("SELECT * FROM Users WHERE username = @username OR email = @email", conn);
                command.Parameters.AddWithValue("@username", txtName.Text);
                command.Parameters.AddWithValue("@email", txtEmail.Text);
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows == true)
                {
                    while (reader.Read())
                    {
                        if (reader["username"].ToString() == txtName.Text)
                        {
                            lblError.Text = "Username Existed!";
                            return;
                        }
                        else if (reader["email"].ToString() == txtEmail.Text)
                        {
                            lblError.Text = "Email Address Existed!";
                            return;
                        }
                    }
                }
                conn.Close();
                command = new SqlCommand("INSERT INTO Users (username, email, password, status, img, role) VALUES (@username, @email, @password, 1, 'abc', 'normal')", conn);
                command.Parameters.AddWithValue("@username", txtName.Text);
                command.Parameters.AddWithValue("@email", txtEmail.Text);
                command.Parameters.AddWithValue("@password", Tokenization.GenerateToken(txtPassword.Text));
                conn.Open();
                int result = command.ExecuteNonQuery();
                if (result == 1)
                {
                    Response.Redirect(HttpContext.Current.Request.ApplicationPath + "WebPages/Client/Login.aspx?register=success");
                }
                else
                {
                    lblError.Text = "Unable to create account";
                }
                conn.Close();

            }
        }
    }
}