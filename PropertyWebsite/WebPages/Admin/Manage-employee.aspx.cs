using PropertyWebsite.Class;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PropertyWebsite.WebPages
{
    public partial class Manage_employee : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        }

        //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "editCustom")
        //    {
        //        string cmdString = "SELECT * FROM users WHERE Uid = @Uid";
        //        cmd = new SqlCommand(cmdString, conn);
        //        cmd.Parameters.AddWithValue("@Uid", e.CommandArgument.ToString());
        //        conn.Open();
        //        SqlDataReader emp = cmd.ExecuteReader();
        //        while (emp.Read())

        //        {
        //            txtEditUsername.Text = emp["username"].ToString();
        //            txtEditEmail.Text = emp["email"].ToString();
        //        }

        //        ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:openEditPanel(); ", true);
        //    }

        //    if (e.CommandName == "deleteCustom")
        //    {
        //        txtDeleteUser.Text = e.CommandArgument.ToString();
        //        ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:openDeletePanel(); ", true);
        //    }

        //}

        //protected void btnAddEmp_Click(object sender, EventArgs e)
        //{

        //    cmd = new SqlCommand("SELECT * FROM Users WHERE Uid = @Uid OR userid = @userid OR username = @username OR email = @email", conn);
        //    cmd.Parameters.AddWithValue("@username", txtUsername.Text);
        //    cmd.Parameters.AddWithValue("@email", txtEmail.Text);
        //    conn.Open();
        //    SqlDataReader readUser = cmd.ExecuteReader();
        //    if (readUser.HasRows)
        //    {
        //        while (readUser.Read())
        //        {
        //            if (readUser["username"].ToString() == txtUsername.Text)
        //            {
        //                lblError.Text = "Username Existed!";
        //                conn.Close();
        //                break;
        //            }
        //            else if (readUser["email"].ToString() == txtEmail.Text)
        //            {
        //                lblError.Text = "Email Existed!";
        //                conn.Close();
        //                break;
        //            }
        //        }
        //        ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:openAddPanel(); ", true);
        //        readUser.Close();
        //    }
        //    else
        //    {
        //        readUser.Close();
        //        string imgPath = "../Resources/EmpImg/" + DateTime.Now.ToString("dd-MM-yyyy-hh-mm-ss") + Path.GetExtension(fuEmp.FileName);
        //        fuEmp.SaveAs(Server.MapPath("../Resources/EmpImg/") + DateTime.Now.ToString("dd-MM-yyyy-hh-mm-ss") + Path.GetExtension(fuEmp.FileName));

        //        cmd = new SqlCommand("INSERT INTO Users (username, email, password, status, img, role) VALUES (@username, @email, @password, @status, @img, @role)", conn);
        //        cmd.Parameters.AddWithValue("@username", txtUsername.Text);
        //        cmd.Parameters.AddWithValue("@email", txtEmail.Text);
        //        cmd.Parameters.AddWithValue("@password", txtEmail.Text);
        //        cmd.Parameters.AddWithValue("@status", 1);
        //        cmd.Parameters.AddWithValue("@img", imgPath);
        //        cmd.Parameters.AddWithValue("@role", "staff");
        //        if (cmd.ExecuteNonQuery() != 0)
        //        {
        //            GridView1.DataBind();
        //            string token = HttpUtility.UrlEncode(Tokenization.GenerateToken(txtEmail.Text));
        //            string emailBody = "";
        //            emailBody += "<p>Please be informed that you have registered as iRoom's staff. Kindly reset password using email address, click on the link to visit password reseting page.";
        //            emailBody += "<br/><a href=\"" + Request.Url.GetLeftPart(UriPartial.Authority) + "/Client/Logout.aspx?token=" + token + "&action=reset" + "\">Reset Password</a>";
        //            emailBody += "<p>Please ignore this or report to us if the action is not performed by you.</p>";

        //            EmailService.SendEmail(txtEmail.Text, "iRoom Change Password Request", emailBody);
        //            lblError.Text = "";
        //            txtUsername.Text = "";
        //            txtEmail.Text = "";
        //            string script = string.Format("openPopupMsg('{0}');", "Employee added successfully");
        //            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "popupMsg", script, true);
        //        }
        //    }
        //    conn.Close();
        //}

        //protected void btnEditSubmit_Click(object sender, EventArgs e)
        //{

        //    conn.Open();
        //    SqlDataReader readUser = cmd.ExecuteReader();

        //    readUser.Close();
        //    cmd = new SqlCommand("UPDATE Users SET username = @username WHERE Uid = @Uid", conn);
        //    cmd.Parameters.AddWithValue("@username", txtEditUsername.Text);
        //    if (cmd.ExecuteNonQuery() != 0)
        //    {
        //        GridView1.DataBind();
        //        string script = string.Format("openPopupMsg('{0}');", "Employee updated successfully");
        //        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "popupMsg", script, true);
        //    }
        //    conn.Close();
        //}

        //protected void btnConfirmDelete_Click(object sender, EventArgs e)
        //{
        //    conn.Open();
        //    cmd = new SqlCommand("DELETE FROM Users WHERE Uid = @Uid", conn);
        //    cmd.Parameters.AddWithValue("@Uid", txtDeleteUser.Text);
        //    if (cmd.ExecuteNonQuery() != 0)
        //    {
        //        GridView1.DataBind();
        //        string script = string.Format("openPopupMsg('{0}');", "Employee deleted successfully");
        //        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "popupMsg", script, true);
        //    }
        //    conn.Close();
        //}



        //protected void chkStatus_CheckedChanged(object sender, EventArgs e)
        //{
        //    CheckBox chk = (CheckBox)sender;
        //    GridViewRow row = (GridViewRow)chk.NamingContainer;
        //    string username = row.Cells[0].Text;

        //    conn.Open();
        //    cmd = new SqlCommand("UPDATE Users SET status = @status WHERE Uid = @Uid", conn);
        //    cmd.Parameters.AddWithValue("@Uid", username);
        //    cmd.Parameters.AddWithValue("@status", chk.Checked);
        //    if (cmd.ExecuteNonQuery() != 0)
        //    {
        //        GridView1.DataBind();
        //        string script = string.Format("openPopupMsg('{0}');", "Status updated successfully");
        //        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "popupMsg", script, true);
        //    }
        //    conn.Close();
        //}
    }
}