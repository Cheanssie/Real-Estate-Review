using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Threading.Tasks;

namespace PropertyWebsite.WebPages
{
    public partial class APITester : System.Web.UI.Page
    {
        string apiUrl = "http://54.163.254.29/lexiconMT/";
        string passcode = "SentimentAPIfyp2023";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected async void btnAPI_Click(object sender, EventArgs e)
        {
            apiUrl += passcode + "?text=" + txtInput.Text.ToString();

            try
            {
                using (HttpClient client = new HttpClient())
                {
                    HttpResponseMessage response = await client.GetAsync(apiUrl);
                    if (response.IsSuccessStatusCode)
                    {
                        string apiResponse = await response.Content.ReadAsStringAsync();
                        Response.Write("API Response: " + apiResponse);
                    }
                    else
                    {
                        Response.Write("API request failed. Status code: " + response.StatusCode);

                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Exception: " + ex.Message);
            }


        }
    }
}