using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.IO;
using YouExLib.Common;
using YouExLib.Service;

namespace YouExPay.Pay.paypal
{
    using DataInfo = Dictionary<string, object>;

    public partial class ReturnUrl : WebSite.Tool.UserPage
    {
        protected int return_payid = 0; 
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //获取PayPal 交易流水号
                string txToken = Request.QueryString["tx"];
                string strResponse = GetPaypalResponse(txToken);

                //取前面七个字符
                string isSuccess = strResponse.Substring(0, 7);
                Regex reg = new Regex(@"custom=(?<orderid>\d+)", RegexOptions.Compiled | RegexOptions.IgnoreCase);
                Match payResult = reg.Match(strResponse);

                int orderId = 0;
                if (payResult.Success)
                {
                    orderId = Utils.StrToInt(payResult.Groups["orderid"], 0);
                    return_payid = orderId;
                }

                if ((isSuccess == "SUCCESS") && (orderId > 0))
                {
                    //是否支付账单
                    if (HttpContext.Current.Request.Cookies["Return_url"] != null)
                    {
                        DataInfo bill = (new PayService()).GetPayInfo(orderId);
                        bool result_bank = Payment.UserPay(userId, bill["BillNo"].ToString());
                        if (result_bank)
                        {
                            HttpContext.Current.Response.Cookies[HttpUtility.UrlEncode("Return_url")].Expires = DateTime.Now.AddDays(-1);
                            string packageno = Request.Cookies["Return_url"]["url"];
                            Response.Redirect("../../Package/MyStock.aspx?ordertype=delivery_transportl");
                        }
                    }

                    //是否支付缴税
                    if (HttpContext.Current.Request.Cookies["Return_TaxNo"] != null)
                    {
                        string taxno = Request.Cookies["Return_TaxNo"]["Tax_No"];
                        DataInfo tax = (new TaxService()).GetTaxInfo(taxno);
                        tax["PayStatus"] = 2;
                        bool result_paytax = (new TaxService()).UpdateTaxBill(taxno,tax);
                        if (result_paytax)
                        {
                            HttpContext.Current.Response.Cookies[HttpUtility.UrlEncode("Return_TaxNo")].Expires = DateTime.Now.AddDays(-1);
                            string packageno = Request.Cookies["Return_TaxNo"]["Tax_No"];
                            Response.Redirect("../../UserCenter/UserTaxes.aspx");
                        }
                    }

                    int result_payaccess = Payment.AccessPay(orderId);
                    DataInfo payinfo = (new PayService()).GetPayInfo(orderId);
                    if (Convert.ToInt32(payinfo["CnyAmount"]) >= 1000 && Convert.ToInt32(payinfo["CnyAmount"]) < 2500 && Convert.ToInt32(payinfo["PayType"]) == 2)
                    {
                        DataInfo user = (new UserService()).GetUserInfo(userId);
                        user["Type"] = 4;
                        (new UserService()).UpdateUser(userId, user);
                    }
                    if (Convert.ToInt32(payinfo["CnyAmount"]) >= 2500 && Convert.ToInt32(payinfo["CnyAmount"]) < 5000 && Convert.ToInt32(payinfo["PayType"]) == 2)
                    {
                        DataInfo user = (new UserService()).GetUserInfo(userId);
                        user["Type"] = 5;
                        (new UserService()).UpdateUser(userId, user);
                    }
                    if (Convert.ToInt32(payinfo["CnyAmount"]) >= 5000 && Convert.ToInt32(payinfo["PayType"]) == 2)
                    {
                        DataInfo user = (new UserService()).GetUserInfo(userId);
                        user["Type"] = 6;
                        (new UserService()).UpdateUser(userId, user);
                    }
                    Response.Redirect("../../UserCenter/UserCenter.aspx");
                }
                

            }
            catch{} 
        }


        


        private string GetPaypalResponse(string txToken)
        {
            //定义您的身份标记,这里改成您的身份标记
            string authToken = "aMNBKezIVaao4kP0oajN3prmZ9hMD8SGDMyGgee0h58b6Du19dg9GaGy7Be";

            // Set the 'Method' property of the 'Webrequest' to 'POST'.
            HttpWebRequest myRequest = (HttpWebRequest)WebRequest.Create("http://www.paypal.com/cgi-bin/webscr"); //.sandbox
            myRequest.Method = "POST";
            myRequest.ContentType = "application/x-www-form-urlencoded";

            //设置请求参数
            string query = "cmd=_notify-synch&tx=" + txToken + "&at=" + authToken;
            string strValues = Encoding.ASCII.GetString((new ASCIIEncoding()).GetBytes(query));
            myRequest.ContentLength = strValues.Length;

            //发送请求
            StreamWriter streamOut = new StreamWriter(myRequest.GetRequestStream(), System.Text.Encoding.ASCII);
            streamOut.Write(strValues);
            streamOut.Close();

            //接受返回信息
            StreamReader streamIn = new StreamReader(myRequest.GetResponse().GetResponseStream());
            string strResponse = streamIn.ReadToEnd();
            streamIn.Close();

            return strResponse;
        }
    }
}