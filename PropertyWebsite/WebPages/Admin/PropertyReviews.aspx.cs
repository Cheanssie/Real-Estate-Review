using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PropertyWebsite.WebPages.Admin
{
    public partial class PropertyReviews : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            ViewState["Pid"] = Request.QueryString["Pid"];
            cmd = new SqlCommand("SELECT * FROM Property WHERE Pid = @Pid", conn);
            cmd.Parameters.AddWithValue("@Pid", ViewState["Pid"]);
            conn.Open();
            SqlDataReader readProp = cmd.ExecuteReader();
            if(readProp.Read())
            {
                propName.InnerText = readProp["propName"].ToString();
            }
            readProp.Close();
            conn.Close();
            if (ddlSentiment.SelectedValue == "*")
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [Review] R, [Users] U WHERE ([Pid] = @Pid) AND (U.Uid = R.Uid) ORDER BY datetime DESC";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("Pid", ViewState["Pid"].ToString());
                conn.Open();
                cmd = new SqlCommand("SELECT COUNT(*) FROM Review R, Users U WHERE (Pid = @Pid) AND (U.Uid = R.Uid)", conn);
                cmd.Parameters.AddWithValue("@Pid", ViewState["Pid"]);
               
                conn.Close();
            }
            else
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [Review] R, [Users] U WHERE ([Pid] = @Pid) AND (U.Uid = R.Uid) AND (sentiment = @sentiment) ORDER BY datetime DESC";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("Pid", ViewState["Pid"].ToString());
                SqlDataSource1.SelectParameters.Add("sentiment", ddlSentiment.SelectedValue);
                conn.Open();
                cmd = new SqlCommand("SELECT COUNT(*) FROM Review R, Users U WHERE (Pid = @Pid) AND (U.Uid = R.Uid) AND (sentiment = @sentiment)", conn);
                cmd.Parameters.AddWithValue("@Pid", ViewState["Pid"]);
                cmd.Parameters.AddWithValue("@sentiment", ddlSentiment.SelectedValue);
                
                conn.Close();
            }
            GridView1.DataBind();
        }
    }
}