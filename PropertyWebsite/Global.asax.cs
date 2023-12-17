using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace PropertyWebsite
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            // Get the exception object.
            Exception ex = Server.GetLastError();

            // Log the exception.
            // You can use any logging mechanism here, such as log4net or NLog.
            // Here's an example using the built-in ASP.NET Trace class:
            Trace.TraceError("An unhandled exception occurred: " + ex.Message, ex);

            // Clear the error from the server.
            Server.ClearError();

            // Redirect the user to a custom error page.
            Response.Redirect("/WebPages/Client/Logout.aspx");
            Server.ClearError();
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}