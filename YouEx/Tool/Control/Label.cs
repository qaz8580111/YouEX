using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace YouExCore.Control
{
    [ToolboxData("<{0}:label runat=\"server\"></{0}:label>"),
    DefaultProperty("Text")]
    public class Label : WebControl
    {
        public Label()
            : base(HtmlTextWriterTag.Span)
        {
        }
        public virtual string Text
        {
            get
            {
                object text = ViewState["Text"];
                if (text == null)
                    return string.Empty;
                else return (string)text;
            }
            set
            {
                ViewState["Text"] = value;
            }
        }
        protected override void RenderContents(HtmlTextWriter writer)
        {
            writer.Write(Text);
        }
    }
}
