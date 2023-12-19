using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PropertyWebsite.Class;
using System.Net.Http;
using System.Threading.Tasks;
using System.Text.Json;


namespace PropertyWebsite.WebPages.Client
{
    public partial class PropertyDetail : System.Web.UI.Page
    {
        SqlConnection conn, conn2;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            if (!IsPostBack)
            {
                ViewState["Pid"] = Request.QueryString["Pid"];
                cmd = new SqlCommand("SELECT * FROM Property WHERE Pid = @Pid", conn);
                cmd.Parameters.AddWithValue("@Pid", Request.QueryString["Pid"]);

                conn.Open();
                SqlDataReader property = cmd.ExecuteReader();
                while (property.Read())
                {

                    // if not category data is less than 5, combine with others
                    //imgProd.ImageUrl = property["prodImg"].ToString();
                    propName.InnerText = property["propName"].ToString();
                    propDesc.InnerText = property["description"].ToString();
                    startPrice.InnerText = property["startPrice"].ToString();
                    endPrice.InnerText = property["endPrice"].ToString();
                    propCategory.InnerText = property["category"].ToString();
                    //txtQty.Attributes.Add("max", property["prodQuantity"].ToString());

                }
                conn.Close();
            }

            if(ddlSentiment.SelectedValue == "*")
            {
                SqlDataSource2.SelectCommand = "SELECT * FROM [Review] R, [Users] U WHERE ([Pid] = @Pid) AND (U.Uid = R.Uid) ORDER BY datetime DESC";
                SqlDataSource2.SelectParameters.Clear();
                SqlDataSource2.SelectParameters.Add("Pid", ViewState["Pid"].ToString());
                conn.Open();
                cmd = new SqlCommand("SELECT COUNT(*) FROM Review R, Users U WHERE (Pid = @Pid) AND (U.Uid = R.Uid)", conn);
                cmd.Parameters.AddWithValue("@Pid", ViewState["Pid"]);
                if ((int)cmd.ExecuteScalar() == 0)
                {
                    reviewImg.Attributes["style"] = "display: block !important";
                }
                else
                {
                    reviewImg.Attributes["style"] = "display: none !important";
                }
                conn.Close();
            }
            else
            {
                SqlDataSource2.SelectCommand = "SELECT * FROM [Review] R, [Users] U WHERE ([Pid] = @Pid) AND (U.Uid = R.Uid) AND (sentiment = @sentiment) ORDER BY datetime DESC";
                SqlDataSource2.SelectParameters.Clear();
                SqlDataSource2.SelectParameters.Add("Pid", ViewState["Pid"].ToString());
                SqlDataSource2.SelectParameters.Add("sentiment", ddlSentiment.SelectedValue);
                conn.Open(); 
                cmd = new SqlCommand("SELECT COUNT(*) FROM Review R, Users U WHERE (Pid = @Pid) AND (U.Uid = R.Uid) AND (sentiment = @sentiment)", conn);
                cmd.Parameters.AddWithValue("@Pid", ViewState["Pid"]);
                cmd.Parameters.AddWithValue("@sentiment", ddlSentiment.SelectedValue);
                if((int)cmd.ExecuteScalar() == 0)
                {
                    reviewImg.Attributes["style"] = "display: block !important";
                }
                else
                {
                    reviewImg.Attributes["style"] = "display: none !important";
                }
                conn.Close();
            }
            rptReview.DataBind();

        }

        protected async void LinkButton1_Click(object sender, EventArgs e)
        {
            string review = txtReview.Text;

            string apiUrl = "http://44.221.94.142/lexiconMT/";
            string passcode = "SentimentAPIfyp2023";
            apiUrl += passcode + "?text=" + review;


            if (review != "")
            {
                conn.Open();
                conn2.Open();
                SqlCommand cmd2 = new SqlCommand("SELECT * FROM Users WHERE email = @email", conn2);
                cmd2.Parameters.AddWithValue("@email", Session["email"]);
                SqlDataReader readerUid = cmd2.ExecuteReader();
                readerUid.Read();
                string current = DateTime.Now.ToString("dd-MMM-yyyy HH:mm");
                cmd = new SqlCommand("INSERT INTO Review(review, datetime, sentiment, Pid, Uid) VALUES (@review, @datetime, @sentiment, @Pid, @Uid)", conn);
                cmd.Parameters.AddWithValue("@review", review);
                cmd.Parameters.AddWithValue("@datetime", current);
                cmd.Parameters.AddWithValue("@Pid", Request.QueryString["Pid"]);
                cmd.Parameters.AddWithValue("@Uid", readerUid["Uid"].ToString());
                try
                {
                    using (HttpClient client = new HttpClient())
                    {
                        HttpResponseMessage response = await client.GetAsync(apiUrl);
                        if (response.IsSuccessStatusCode)
                        {
                            string apiResponse = await response.Content.ReadAsStringAsync();
                            System.Diagnostics.Debug.WriteLine("API Response: " + apiResponse);

                            SentimentAnalysisResult result = JsonSerializer.Deserialize<SentimentAnalysisResult>(apiResponse.ToString());
                            cmd.Parameters.AddWithValue("@sentiment", result.Sentiment);
                            int resultReview = cmd.ExecuteNonQuery();
                            if (resultReview == 1)
                            {
                                rptReview.DataBind();
                                cmd.Parameters.Clear();
                                txtReview.Text = "";
                            }

                        }
                        else
                        {
                            Response.Write("API request failed. Status code: " + response.StatusCode);
                            cmd.Parameters.AddWithValue("@sentiment", null);
                            int resultReview = cmd.ExecuteNonQuery();
                            if (resultReview == 1)
                            {
                                rptReview.DataBind();
                                cmd.Parameters.Clear();
                                txtReview.Text = "";
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Exception: " + ex.Message);
                    cmd.Parameters.AddWithValue("@sentiment", DBNull.Value);
                    int resultReview = cmd.ExecuteNonQuery();
                    if (resultReview == 1)
                    {
                        rptReview.DataBind();
                        cmd.Parameters.Clear();
                        txtReview.Text = "";
                    }
                }
                
                

                readerUid.Close();
            }

            conn2.Close();
            conn.Close();

        }
    }
}