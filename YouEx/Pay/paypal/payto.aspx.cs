using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text;
using YouExLib.Common;
using YouExLib.Service;
using WebSite.UserCenter;
using WebSite.Package;
using WebSite.Help;

namespace YouExPay.Pay.paypal
{
    using DataInfo = Dictionary<string, object>;

    public partial class payto :WebSite.Tool.UserPage
    {
        private string CurrencyCode = "USD";
        private IList<DataInfo> PaypalConfig = null;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            string CnyAmount = "";
            string BillNo = "";
            string PayType = "";
            string PackageNo = "";

            //账户充值
            try
            {
                UserAccount newWeb = (UserAccount)Context.Handler;
                CnyAmount = newWeb.RechargeMoney;
                BillNo = newWeb.RechargeBill;
                PayType = newWeb.RechargePlace;                
            }
            catch{}

            //账单支付
            try
            {
                PayBill newWeb = (PayBill)Context.Handler;
                CnyAmount = newWeb.RechargeMoney;
                BillNo = newWeb.RechargeBill;
                PayType = newWeb.RechargePlace;
                PackageNo = newWeb.PackageNo;

                HttpCookie cookie = new HttpCookie("Return_url");
                cookie["url"] = PackageNo;
                cookie.Expires = DateTime.Now.AddDays(1);
                HttpContext.Current.Response.AppendCookie(cookie);
            }
            catch { }

            //缴税支付
            try
            {
                TaxPay newWeb = (TaxPay)Context.Handler;
                PayType = "";
                CnyAmount = newWeb.RechargeMoney;
                BillNo = newWeb.RechargeBill;
                string PayTaxNo = newWeb.PayTaxNo;

                HttpCookie cookie = new HttpCookie("Return_TaxNo");
                cookie["Tax_No"] = PayTaxNo;
                cookie.Expires = DateTime.Now.AddDays(1);
                HttpContext.Current.Response.AppendCookie(cookie);
            }
            catch { }

            int userid = userId;
            if (!IsPostBack)
            {
                if (CnyAmount != string.Empty)
                {
                    decimal CnyPrice = 0; //人民币金额
                    if (decimal.TryParse(CnyAmount, out CnyPrice))
                    {
                        if (CnyPrice > 0)
                        {
                            DataInfo Currency = Common.GetCurrency("USD");
                            PaypalConfig = Common.GetEnumGroup("Paypal");

                            if (Currency != null)
                            {
                                decimal ExchangeRate = Utils.StrToDecimal(Currency["ExchangeRate"], 6.5M);
                                decimal ChargeRate = Utils.StrToDecimal(Common.GetContentInfo(PaypalConfig, "Charge"), 0.04M);

                                decimal PayPrice = CnyPrice / ExchangeRate; //折算为要充值的美元
                                decimal Charge = PayPrice * ChargeRate;
                                amountL.Text = CnyPrice.ToString("N2");

                                string UserInfo = "在线充值" + (PayPrice + Charge).ToString("N2") + " " + CurrencyCode + "(实际入帐" + PayPrice.ToString("N2") + CurrencyCode + ",折合" + CnyPrice.ToString("N2") + "元人民币，含手续费" + Charge.ToString("N2") + " " + CurrencyCode + ")";
                                int OrderId = Payment.CreateBankPay(userid, 0, 0, BillNo, Utils.StrToInt(PayType, 1), CnyPrice.ToString("N2"), PayPrice.ToString("N2"), CurrencyCode, Charge.ToString("N2"), "Paypal", UserInfo, "");


                                if (OrderId > 0)
                                    lbButton.Text = GetFormHtml(OrderId, (PayPrice + Charge).ToString("N2"));
                            }
                            else
                            {
                                Response.Clear();
                                Response.Write("对不起，您选择的币种不支持！");
                                Response.End();
                                Response.Close();
                            }
                        }
                        else Response.Redirect("/");
                    }
                    else Response.Redirect("/");
                }
            }
        }


        private string GetFormHtml(int OrderId, string PayPrice)
        {
            string Business = Common.GetContentInfo(PaypalConfig, "Business");
            string ReturnUrl = Common.GetContentInfo(PaypalConfig, "ReturnUrl");
            string CancelUrl = Common.GetContentInfo(PaypalConfig, "CancelUrl");

            StringBuilder strForm = new StringBuilder();
            strForm.Append("<form id='paypalForm' name='paypalForm' action='https://www.paypal.com/cgi-bin/webscr' method='Post'>"); //.sandbox
            strForm.Append("   <input type='hidden' name='cmd' value='_xclick'>");
            strForm.Append("   <input type='hidden' name='business' value='" + Business + "'>");
            strForm.Append("   <input type='hidden' name='item_name' value='在线充值'>");
            strForm.Append("   <input type='hidden' name='item_number' value='1'>");
            strForm.Append("   <input type='hidden' name='currency_code' value='" + CurrencyCode + "'>");
            strForm.Append("   <input type='hidden' name='no_shipping' value='1'>");
            strForm.Append("   <input type='hidden' name='custom' value='" + OrderId + "'>");
            strForm.Append("   <input type='hidden' name='return' value='" + ReturnUrl + "'>");
            strForm.Append("   <input type='hidden' name='cancel_return' value='" + CancelUrl + "'>");
            strForm.Append("   <input type='hidden' name='charset' value='utf-8'>");
            strForm.Append("   <input type='hidden' name='amount' value='" + PayPrice + "'>");
            strForm.Append("<input type=\"submit\" value=\"Paypal确认付款\"></form>");
            strForm.Append("<script>document.forms['paypalForm'].submit();</script>");
            strForm.Append("</form>");

            return strForm.ToString();
        }
    }
}