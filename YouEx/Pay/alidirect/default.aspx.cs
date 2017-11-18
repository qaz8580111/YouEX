using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Common;
using YouExLib.Service;


namespace YouExPay.Pay.alidirect
{
    public partial class _default : Page
    {
        protected string money = RequestX.GetString("amount");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.Title = "确认支付订单";
                alimoney.Value = (String.IsNullOrEmpty(money) ? "0" : money);
            }
            Page.DataBind();
        }
    }
}