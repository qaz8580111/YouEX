using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebSite.Help
{
    public partial class EditSuccessReLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["YouEx_User"] != null) {
                Response.Redirect("./404NotFound.aspx");
            }
        }
    }
}