using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Drawing;

namespace WebSite.Tool.Control
{
    public class DropDownList : System.Web.UI.WebControls.DropDownList
    {
        protected override void Render(HtmlTextWriter writer)
        {
            base.Render(writer);
        }
    }
}
