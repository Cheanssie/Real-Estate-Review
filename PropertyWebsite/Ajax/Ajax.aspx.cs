using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Security.Cryptography;

namespace PropertyWebsite.Ajax
{
    public partial class Ajax : System.Web.UI.Page
    {
        static SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        static SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            // disable caching of the response
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }

        [WebMethod]
        public static List<string> SearchSuggestion(string keyword)
        {
            List<string> result = new List<string>();

            if (keyword != "")
            {
                conn.Open();
                cmd = new SqlCommand("SELECT TOP 5 propName FROM Property WHERE propName LIKE @propName", conn);
                cmd.Parameters.AddWithValue("@propName", "%" + keyword + "%");
                SqlDataReader readPropName = cmd.ExecuteReader();
                while (readPropName.Read())
                {
                    result.Add(readPropName["propName"].ToString());
                }

                readPropName.Close();
                conn.Close();
            }

            
            return result;
        }

        [WebMethod]
        public static List<int> SentimentCount(int Pid)
        {
            List<int> result = new List<int>();
            conn.Open();
            cmd = new SqlCommand("SELECT COUNT(*) FROM Review WHERE Pid = @Pid AND sentiment = 'neutral'", conn);
            cmd.Parameters.AddWithValue("@Pid", Pid);
            int neutral = (int)cmd.ExecuteScalar();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Review WHERE Pid = @Pid AND sentiment = 'positive'", conn);
            cmd.Parameters.AddWithValue("@Pid", Pid);
            int positive = (int)cmd.ExecuteScalar();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Review WHERE Pid = @Pid AND sentiment = 'negative'", conn);
            cmd.Parameters.AddWithValue("@Pid", Pid);
            int negative = (int)cmd.ExecuteScalar();

            result.Add(neutral);
            result.Add(positive) ;
            result.Add(negative);
            conn.Close();
            return result;

        }

        [WebMethod]
        public static List<int> Counter()
        {
            List<int> result = new List<int>();
            conn.Open();
            cmd = new SqlCommand("SELECT COUNT(*) FROM Review ", conn);
            int review = (int)cmd.ExecuteScalar();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Property", conn);
            int property = (int)cmd.ExecuteScalar();

            cmd = new SqlCommand("SELECT COUNT(*) FROM Users", conn);
            int users = (int)cmd.ExecuteScalar();

            result.Add(users);
            result.Add(property);
            result.Add(review);
            conn.Close();
            return result;
        }
    }
}