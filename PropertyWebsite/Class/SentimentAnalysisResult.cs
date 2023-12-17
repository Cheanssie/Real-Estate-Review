using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PropertyWebsite.Class
{
    public class SentimentAnalysisResult
    {
        public string AccessedModule { get; set; }
        public string Description { get; set; }
        public string InputText { get; set; }
        public int ResponseCode { get; set; }
        public string Sentiment { get; set; }
        public string TranslatedText { get; set; }
    }
}