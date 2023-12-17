using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace PropertyWebsite.Class
{
    public class EmailService
    {
        // create a new MailMessage object
        private static MailMessage message = new MailMessage();
        public static void SendEmail(string receiver, string subject, string body)
        {
            // set the sender and recipient email addresses
            message.From = new MailAddress("iroomtarumt@gmail.com");
            message.To.Add(receiver);

            // set the subject and body of the message
            message.Subject = subject;
            message.Body = body;
            message.IsBodyHtml = true;

            // create a new SmtpClient object
            SmtpClient client = new SmtpClient();

            // set the SMTP server and port
            client.Host = "smtp.gmail.com";
            client.Port = 587;

            client.UseDefaultCredentials = false;
            // set the credentials (if required)
            client.Credentials = new System.Net.NetworkCredential("iroomtarumt@gmail.com", "nwlgsmlusecuumvp");

            // enable SSL if necessary
            client.EnableSsl = true;

            client.DeliveryMethod = SmtpDeliveryMethod.Network;

            // send the message
            client.Send(message);
        }
    }
}