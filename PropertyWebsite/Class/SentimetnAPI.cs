using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Text.Json;
using PropertyWebsite.Class;

namespace PropertyWebsite.Class
{
    public class SentimentAPI
    {
        static string passcode = "SentimentAPIfyp2023";
      
        public async static Task<string> Parse(string review)
        {
            StringBuilder apiUrlBuilder = new StringBuilder("http://44.221.94.142/lexiconMT/");
            apiUrlBuilder.Append(passcode).Append("?text=").Append(HttpUtility.UrlEncode(review));
            string apiUrl = apiUrlBuilder.ToString();

            try
            {
                using (HttpClient client = new HttpClient())
                {
                    HttpResponseMessage response = await client.GetAsync(apiUrl);
                    if (response.IsSuccessStatusCode)
                    {
                        string apiResponse = await response.Content.ReadAsStringAsync();
                        SentimentAnalysisResult result = JsonSerializer.Deserialize<SentimentAnalysisResult>(apiResponse);


                        return result.Sentiment; 
                    }
                    else
                    {
                        
                    }
                }
            }
            catch (Exception ex)
            {
            }

            return null; 
        }

        public void main(string[] args)
        {
            string result = Parse("Aku memang bodoh").ToString();
            Console.WriteLine(result);
        }

    }
}
