using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Drawing;

namespace WebSite.Tool.Control
{
    [ToolboxData("<{0}:button runat=server></{0}:button>"),
     DefaultProperty("Text")]
    public class Button : System.Web.UI.WebControls.Button
    {
        protected override void Render(HtmlTextWriter writer)
        {
            base.Render(writer);
        }
    }
}
