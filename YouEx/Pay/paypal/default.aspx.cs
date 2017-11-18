using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using YouExLib.Common;
using YouExLib.Service;



namespace YouExPay.Pay.paypal
{
    using DataInfo = Dictionary<string, object>;

    public partial class _default : Page
    {
        protected string CnyAmount = RequestX.GetString("price");
        protected string BillNo = RequestX.GetString("BillNo");
        protected string PayType = RequestX.GetString("PayType");
        protected decimal ExchangeRate = 0;
        protected decimal ChargeRate = 0.04M;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (CnyAmount != string.Empty)
                {
                    DataInfo Currency = Common.GetCurrency("USD");
                    ChargeRate = Common.GetCharge("Paypal", "Charge");
                    if (Currency != null)
                    {
                        ExchangeRate = Utils.StrToDecimal(Currency["ExchangeRate"], 6.5M);
                        decimal UsdAmount = 0;
                        if (decimal.TryParse(CnyAmount, out UsdAmount))
                        {
                            UsdAmount = UsdAmount / ExchangeRate; //折算为要充值的美元
                            decimal Charge = UsdAmount * ChargeRate;

                            price.Value = CnyAmount; //仍然为人民币金额
                            amountL.Text = UsdAmount.ToString("N2");
                            UsdAmount += Charge;
                            totalPriceL.Text = UsdAmount.ToString("N2");
                        }
                        else Response.Redirect("/");
                    }
                    else
                    {
                        Response.Clear();
                        Response.Write("对不起，本站暂时不支持美元支付充值！如有问题请与管理员联系！");
                        Response.End();
                    }
                }
            }
        }
    }
}