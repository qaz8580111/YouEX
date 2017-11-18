using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Service;

namespace WebSite.Help
{
    using DataInfo = Dictionary<string, object>;
    public partial class PayTax : System.Web.UI.Page
    {
        string shippingorder = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    PayTax newWeb = (PayTax)Context.Handler;
                    string shippingorder = newWeb.ShippingOrder;
                    string strItem = "";
                    IList<DataInfo> taxes = (new TaxService()).GetTaxByShippingNo(shippingorder);
                    if (taxes.Count == 0)
                        Label_IsShow.Text = "no";
                    if (taxes.Count == 0 && shippingorder == "")
                        Label_IsShow.Text = "none";
                    if(taxes.Count > 0 && shippingorder != "")
                    {
                        foreach (DataInfo tax in taxes)
                        {
                            Image_Tax.ImageUrl = string.Concat("./PageHandler/ImageVirtualSourceFront.aspx?idfront=", tax["Image"].ToString());
                            if ((int)tax["PayStatus"] == 0)
                            {
                                Label_IsShow.Text = "yes";
                                Label_HideShippingOrder.Text = shippingorder;
                            }
                            if ((int)tax["PayStatus"] == 2)
                                Label_IsShow.Text = "yesyes";
                        }
                    }
                }
            }
            catch { }
        }

        protected void searchClick(object sender, EventArgs e)
        {
            shippingorder = Request.Form["search_shippingorder"];
            Server.Transfer("./PayTaxes.aspx");
        }

        protected void PayTax_Button(object sender, EventArgs e)
        {
            Response.Redirect("./TaxPay.aspx?Number=" + Label_HideShippingOrder.Text);
        }        
        
        public string ShippingOrder { get { return shippingorder; } }
    }
}