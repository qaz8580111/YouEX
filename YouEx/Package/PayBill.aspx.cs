using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Data;
using YouExLib.Interface;
using YouExLib.Service;
using System.Net;

namespace WebSite.Package
{
    using DataInfo = Dictionary<string, object>;
    public partial class PayBill : Tool.UserPage
    {
        string billno = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string ispaybill = Request.QueryString["ispaybill"];
            string orderno = Request.QueryString["orderno"];
            
            //显示用户账单
            if (orderno != null)
            {
                GetPayInfo(orderno);
            }

            //用户付款
            if(ispaybill != null){
                UserPayMoney(orderno, ispaybill);
            }
        }

        //页面加载显示用户账单
        protected void GetPayInfo(string orderno)
        {
            string bill_strItem = "";
            IList<DataInfo> bills = (new OrderService()).GetBillByOrderNo(orderno);
            foreach (DataInfo bill in bills)
            {
                IList<DataInfo> bill_details = (IList<DataInfo>)bill["BillDetail"];
                billno = bill["BillNo"].ToString();
                foreach (DataInfo bill_detail in bill_details)
                {
                    string strItem = Literal_BillDetail.Text;
                    strItem = strItem.Replace("billdetailHere", bill_detail["Remark"].ToString());
                    bill_strItem += strItem;
                }
                Total_Cost.Text = bill["TotalCost"].ToString();
                double already_cost = Convert.ToDouble(IsNullAlreadyCost(bill["PayBank"].ToString())) + Convert.ToDouble(IsNullAlreadyCost(bill["PayCash"].ToString())) + Convert.ToDouble(IsNullAlreadyCost(bill["PayFly"].ToString())) + Convert.ToDouble(IsNullAlreadyCost(bill["PayCoupon"].ToString()));
            }
            Literal_BillDetail.Text = bill_strItem;


            //显示用户可用资金
            string account_strItem = Literal_PayType.Text;
            DataInfo useraccount = (new UserService()).GetAccountDefault(userId);
            account_strItem = account_strItem.Replace("amountHere", useraccount["Money"].ToString());
            account_strItem = account_strItem.Replace("flymoneyHere", useraccount["FlyMoney"].ToString());
            account_strItem = account_strItem.Replace("creditHere", useraccount["Credit"].ToString());
            Literal_PayType.Text = account_strItem;

            //显示优惠券
            try
            {
                string coupon_strItem = "";
                IList<DataInfo> coupons = (new CouponService()).GetCouponList(userId);
                foreach (DataInfo coupon in coupons)
                {
                    if ((int)coupon["Status"] == (int)DataField.COUPON_STATUS.Blank)
                    {
                        string str_coupon = Literal_Coupon.Text;
                        str_coupon = str_coupon.Replace("couponHere", ShowCoupon(coupon));
                        coupon_strItem += str_coupon;
                    }
                }
                Literal_Coupon.Text = coupon_strItem;
            }
            catch { }
        }

        //用户付款
        protected void UserPayMoney(string orderno,string ispaybill)
        {
            IList<DataInfo> bills = (new OrderService()).GetBillByOrderNo(ispaybill);
            int userid = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
            decimal type_money = Convert.ToDecimal(IsNullAlreadyCost(Request.Form["type_money"]));
            decimal type_flymoney = Convert.ToDecimal(IsNullAlreadyCost(Request.Form["type_flymoney"]));
            decimal type_bank = Convert.ToDecimal(IsNullAlreadyCost(Request.Form["type_bank"]));
            string type_coupon = Request.Form["type_coupon"];

            //优惠券支付
            decimal pay_coupon = 0;
            if (type_coupon != "")
            {
                int couponid = Convert.ToInt32((new CouponService()).GetCouponInfo(type_coupon)["CouponId"]);
                IList<DataInfo> t_coupons = (new CommonService()).GetCouponTemplet(couponid);
                foreach (DataInfo t_coupon in t_coupons)
                {
                    pay_coupon = Convert.ToDecimal(t_coupon["Value"]);
                }
            }
            
            //支付准备
            foreach (DataInfo bill in bills)
            {
                decimal needpay = Convert.ToDecimal(bill["TotalCost"]) - (type_money + type_flymoney + pay_coupon);
                decimal needpay_nocoupon = Convert.ToDecimal(bill["TotalCost"]) - (type_money + type_flymoney);
                decimal bank_needpay = Convert.ToDecimal(bill["TotalCost"]) - (type_money + type_flymoney + pay_coupon + type_bank);
                decimal bank_needpay_nocoupon = Convert.ToDecimal(bill["TotalCost"]) - (type_money + type_flymoney + type_bank);
                

                //使用银行支付的情况
                int result_isenough = Payment.PrepairBill(bill["BillNo"].ToString(), type_bank, type_money, type_flymoney, pay_coupon, type_coupon);
                if ((type_bank > 0 && bank_needpay == 0) || (bank_needpay_nocoupon > 0 && type_bank > 0 && pay_coupon > 0)) 
                {
                    if (result_isenough == 1 && type_bank >= 1)
                    {
                        Response.ContentType = "text/plain";
                        Response.Write("bank");
                        Response.End();
                        break;
                    }
                }
                

                //未使用银行支付的情况
                if (type_bank == 0)
                {
                    if (needpay < 0 && pay_coupon == 0)//支付过多
                    {
                        Response.ContentType = "text/plain";
                        Response.Write("enough");
                        Response.End();
                        break;
                    }

                    if (needpay > 0)//支付不足
                    {
                        Response.ContentType = "text/plain";
                        Response.Write("notenough");
                        Response.End();
                        break;
                    }

                    if (needpay == 0 || (pay_coupon > 0 && needpay_nocoupon > 0))
                    {
                        bool result_direct = Payment.UserPay(userId, bill["BillNo"].ToString());
                        if (!result_direct)
                        {
                            Response.ContentType = "text/plain";
                            Response.Write("fail");
                            Response.End();
                            break;
                        }
                        else
                        {
                            DataInfo order = (new OrderService()).GetOrder(orderno);
                            order["PayStatus"] = 2 ;
                            bool result_update_order = (new OrderService()).UpdateOrder(orderno,order);
                            if (result_update_order)
                            {
                                Response.ContentType = "text/plain";
                                Response.Write("success");
                                Response.End();
                                break;
                            }
                        }
                    }
                }
                
                Response.ContentType = "text/plain";
                Response.Write("fail");
                Response.End();
            }
        }

        //取得优惠券的名字
        protected string GetCouponName(int couponid) {
            string couponname = "";
            IList<DataInfo> t_coupons = (new CommonService()).GetCouponTemplet(couponid);
            foreach (DataInfo t_coupon in t_coupons) {
                couponname = t_coupon["CouponName"].ToString();
            }
            return couponname;
        }

        //前台显示优惠券
        protected string ShowCoupon(DataInfo coupon)
        {
            string couponno = coupon["CouponNo"].ToString();
            int couponid = Convert.ToInt32(coupon["CouponId"]);
            string couponname = GetCouponName(couponid);
            string str_show_coupon = "<option value='" + couponno + "'>" + couponname + "</option>";
            return str_show_coupon;
        }

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&/=()]", "");
            return result_transfer;
        }

        //判断已支付是否为空
        protected string IsNullAlreadyCost(string str) {
            if (str == "")
                str = "0";
            return str;
        }

        //银行付款
        protected void PayBank(object sender, EventArgs e)
        {
            if (Convert.ToInt32(Request.Form["recharge_type"]) == 1)
                Server.Transfer("../Pay/alidirect/alipayto.aspx");
            if (Convert.ToInt32(Request.Form["recharge_type"]) == 2)
                Server.Transfer("../Pay/paypal/payto.aspx");
        }
        //传送该页面的值给下个页面
        public string RechargePlace { get { return "1"; } }
        public string RechargeMoney { get { return Request.Form["type_bank"]; } }
        public string RechargeBill { get { return billno; } }
        public string PackageNo { get { return Request.QueryString["paypackageno"]; } }
       
    }
}