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
    public partial class TaxPay : Tool.UserPage
    {
        string billno = "";
        string taxno = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string shippingorder = Request.QueryString["Number"];
            IList<DataInfo> taxes = (new TaxService()).GetTaxByShippingNo(shippingorder);
            foreach (DataInfo tax in taxes)
            {
                TB_Recharge.Text = tax["Money"].ToString();
                taxno = tax["TaxNo"].ToString();
            }
        }

        protected void PayTax(object sender, EventArgs e)
        {
            if (Convert.ToInt32(Request.Form["recharge_type"]) == 1)
                Server.Transfer("../Pay/alidirect/alipayto.aspx");
            if (Convert.ToInt32(Request.Form["recharge_type"]) == 2)
                Server.Transfer("../Pay/paypal/payto.aspx");
        }

        public string RechargeMoney { get { return TB_Recharge.Text; } }
        public string RechargeBill { get { return billno; } }
        public string PayTaxNo { get { return taxno; } }
    }
}