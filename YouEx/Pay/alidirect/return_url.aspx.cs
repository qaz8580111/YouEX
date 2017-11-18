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
using System.Collections.Specialized;
using System.Collections.Generic;
using AlipayClass;
using YouExLib.Common;
using YouExLib.Service;

/// <summary>
/// 功能：付完款后跳转的页面（页面跳转同步通知页面）
/// 版本：3.1
/// 日期：2010-10-29
/// 说明：
/// 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
/// 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
/// 
/// ///////////////////////页面功能说明///////////////////////
/// 该页面可在本机电脑测试
/// 该页面称作“页面跳转同步通知页面”，是由支付宝服务器同步调用，可当作是支付完成后的提示信息页，如“您的某某某订单，多少金额已支付成功”。
/// 可放入HTML等美化页面的代码和订单交易完成后的数据库更新程序代码
/// 该页面可以使用ASP.NET开发工具调试，也可以使用写文本函数Log_result进行调试，该函数已被默认关闭
/// TRADE_FINISHED(表示交易已经成功结束，为普通即时到帐的交易状态成功标识);
/// TRADE_SUCCESS(表示交易已经成功结束，为高级即时到帐的交易状态成功标识);
/// </summary>
namespace YouExPay.Pay.alidirect
{
    using DataInfo = Dictionary<string, object>;
    public partial class return_url : WebSite.Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SortedDictionary<string, string> sArrary = GetRequestGet();
            ///////////////////////以下参数是需要设置的相关配置参数，设置后不会更改的//////////////////////
            AlipayConfig con = new AlipayConfig("alipaydirect");
            string partner = con.Partner;
            string key = con.Key;
            string input_charset = con.Input_charset;
            string sign_type = con.Sign_type;
            string transport = con.Transport;
            //////////////////////////////////////////////////////////////////////////////////////////////

            if (sArrary.Count > 0)//判断是否有带返回参数
            {
                AlipayNotify aliNotify = new AlipayNotify(sArrary, Request.QueryString["notify_id"], partner, key, input_charset, sign_type, transport);
                string responseTxt = aliNotify.ResponseTxt; //获取远程服务器ATN结果，验证是否是支付宝服务器发来的请求
                string sign = Request.QueryString["sign"];  //获取支付宝反馈回来的sign结果
                string mysign = aliNotify.Mysign;           //获取通知返回后计算后（验证）的签名结果

                //写日志记录（若要调试，请取消下面两行注释）
                //string sWord = "responseTxt=" + responseTxt + "\n return_url_log:sign=" + Request.QueryString["sign"] + "&mysign=" + mysign + "\n return回来的参数：" + aliNotify.PreSignStr;
                //AlipayFunction.log_result(Server.MapPath("log/" + DateTime.Now.ToString().Replace(":", "")) + ".txt",sWord);

                //判断responsetTxt是否为ture，生成的签名结果mysign与获得的签名结果sign是否一致
                //responsetTxt的结果不是true，与服务器设置问题、合作身份者ID、notify_id一分钟失效有关
                //mysign与sign不等，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
                if (responseTxt == "true" && sign == mysign)//验证成功
                {
                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //请在这里加上商户的业务逻辑程序代码

                    //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                    //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表
                    string trade_no = Request.QueryString["trade_no"];      //支付宝交易号
                    string order_no = Request.QueryString["out_trade_no"];	//获取订单号
                    string total_fee = Request.QueryString["total_fee"];	//获取总金额
                    string subject = Request.QueryString["subject"];        //商品名称、订单名称
                    string body = Request.QueryString["body"];              //商品描述、订单备注、描述
                    string buyer_email = Request.QueryString["buyer_email"];//买家支付宝账号
                    string trade_status = Request.QueryString["trade_status"];//交易状态

                    //打印页面
                    lbTrade_no.Text = trade_no;
                    lbOut_trade_no.Text = order_no.ToString();
                    lbTotal_fee.Text = total_fee;
                    lbSubject.Text = subject;
                    lbBody.Text = body;
                    lbBuyer_email.Text = buyer_email;
                    lbTrade_status.Text = trade_status;
                    lbVerify.Text = "验证成功";

                    if (Request.QueryString["trade_status"] == "TRADE_FINISHED" || Request.QueryString["trade_status"] == "TRADE_SUCCESS")
                    {
                        int orderId = Convert.ToInt32(order_no.Split('_')[1]);

                        //是否支付账单
                        if (HttpContext.Current.Request.Cookies["Return_url"] != null)
                        {
                            DataInfo bill = (new PayService()).GetPayInfo(orderId);
                            bool result_bank = Payment.UserPay(userId, bill["BillNo"].ToString());
                            if (result_bank)
                            {
                                HttpContext.Current.Response.Cookies[HttpUtility.UrlEncode("Return_url")].Expires = DateTime.Now.AddDays(-1);
                                string packageno = Request.Cookies["Return_url"]["url"];
                                Response.Redirect("../../Package/MyStock.aspx?ordertype=delivery_transport");
                            }
                        }

                        //是否支付缴税
                        if (HttpContext.Current.Request.Cookies["Return_TaxNo"] != null)
                        {
                            string taxno = Request.Cookies["Return_TaxNo"]["Tax_No"];
                            DataInfo tax = (new TaxService()).GetTaxInfo(taxno);
                            tax["PayStatus"] = 2;
                            bool result_paytax = (new TaxService()).UpdateTaxBill(taxno, tax);
                            if (result_paytax)
                            {
                                HttpContext.Current.Response.Cookies[HttpUtility.UrlEncode("Return_TaxNo")].Expires = DateTime.Now.AddDays(-1);
                                string packageno = Request.Cookies["Return_TaxNo"]["Tax_No"];
                                Response.Redirect("../../UserCenter/UserTaxes.aspx");
                            }
                        }

                        //判断该笔订单是否在商户网站中已经做过处理（可参考“集成教程”中“3.4返回数据处理”）
                        //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                        //如果有做过处理，不执行商户的业务程序
                        
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

                       /* UserCenter uc = new UserCenter();
                        AcountInfo ai = uc.GetAcountById(Int32.Parse(order_no.Substring(order_no.IndexOf("_") + 1)));
                        if (ai != null)
                        {
                            if (ai.IsPaid == 0) //防止刷新页面重复充值
                            {
                                ai.IsPaid = 1;
                                ai.AdminNote = "您的充值申请已通过支付宝接口成功入款！支付宝充值记录号为：" + trade_no;
                                ai.PaidTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                                ai.AdminUser = 1;
                                AcountDetail ad = new AcountDetail
                                {
                                    AddIn = ai.Amount,
                                    AddInPoints = 0,
                                    Earn = 0,
                                    Promotion = 0,
                                    PromotionPoints = 0,
                                    UpPoints = 0,
                                    UpTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                                    UserId = ai.UserId
                                };
                                AcountLogInfo logInfo = new AcountLogInfo
                                {
                                    UserId = ai.UserId,
                                    UserMoney = ai.Amount,
                                    FrozenMoney = 0,
                                    RankPoints = 0,
                                    PayPoints = 0,
                                    ChangeTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                                    ChangeDesc = "充值",
                                    ChangeType = 0,
                                    ActionCode = "ADDIN",
                                    ItemId = 0,
                                    ItemNo = "",
                                    LogId = 0
                                };
                                uc.CreateAcountLog(logInfo); //添加日志，因为要读取充值前的余额，所以要添加日志然后再进行充值
                                uc.UpdateUserAcount(ad); //更新帐号信息
                                uc.UpdateAcount(ai);
                                uc.UpdateAcountStatus(ai.Id, 1); //更改状态为已充值
                                lbTrade_status.Text = "充值成功";

                                GeneralConfigInfo configInfo = GeneralConfigs.GetConfig();
                                if (configInfo.AddInPoints > 0)
                                {
                                    AcountDetail addPoints = new AcountDetail
                                    {
                                        UpPoints = 0,
                                        Earn = 0,
                                        AddIn = 0,
                                        AddInPoints = (int)(ai.Amount * configInfo.AddInPoints),
                                        Promotion = 0,
                                        PromotionPoints = 0,
                                        UpTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                                        UserId = ai.UserId
                                    };
                                    uc.UpdateUserAcount(addPoints); //更新帐号信息

                                    AcountLogInfo addpointsLog = new AcountLogInfo
                                    {
                                        UserId = ai.UserId,
                                        UserMoney = 0,
                                        FrozenMoney = 0,
                                        RankPoints = 0,
                                        PayPoints = (int)(ai.Amount * configInfo.AddInPoints),
                                        ChangeTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                                        ChangeDesc = "充值￥" + ai.Amount + " 元，获得" + (int)(ai.Amount * configInfo.AddInPoints) + "点积分。",
                                        ChangeType = 5,
                                        ActionCode = "ADDIN",
                                        ItemId = ai.Id,
                                        ItemNo = "",
                                        LogId = 0
                                    };
                                    uc.CreateAcountLog(addpointsLog); //积分变动记录
                                }
                            }
                            else
                            {
                                //Response.Write("trade_status=" + Request.QueryString["trade_status"]);
                                //已充过值
                                lbTrade_status.Text = "充值已完成，请勿重复刷新本页！";
                            }

                            lbVerify.Text = "验证成功";
                        }
                        else
                        {
                            //订单不存在
                            lbTrade_status.Text = "您的订单记录在本站不存在，如有疑问请截屏当前页面并与本站管理员联系！";
                            lbVerify.Text = "验证错误";
                        }
                        */
                    }
                    else
                    {
                        Response.Write("trade_status=" + Request.QueryString["trade_status"]);
                    }
                    //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                }
                else//验证失败
                {
                    lbVerify.Text = "验证失败";
                }
            }
            else
            {
                lbVerify.Text = "无返回参数";
            }
        }

        /// <summary>
        /// 获取支付宝GET过来通知消息，并以“参数名=参数值”的形式组成数组
        /// </summary>
        /// <returns>request回来的信息组成的数组</returns>
        public SortedDictionary<string, string> GetRequestGet()
        {
            int i = 0;
            SortedDictionary<string, string> sArray = new SortedDictionary<string, string>();
            NameValueCollection coll;
            //Load Form variables into NameValueCollection variable.
            coll = Request.QueryString;

            // Get names of all forms into a string array.
            String[] requestItem = coll.AllKeys;

            for (i = 0; i < requestItem.Length; i++)
            {
                sArray.Add(requestItem[i], Request.QueryString[requestItem[i]]);
            }

            return sArray;
        }
    }
}