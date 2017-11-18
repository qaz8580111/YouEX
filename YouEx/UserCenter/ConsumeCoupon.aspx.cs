using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Service;
using YouExLib.Data;

namespace WebSite.UserCenter
{
    using DataInfo = Dictionary<string, object>;
    public partial class ConsumeCoupon : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //显示优惠券
                string coupon_strItem = "";
                int coupon_status = Convert.ToInt32(Request.QueryString["couponstatus"]);
                Label_CouponStatus.Text = coupon_status.ToString();
                IList<DataInfo> coupons = (new CouponService()).GetCouponListPage(userId, 10, 1, coupon_status);
                IList<DataInfo> coupons_count = (new CouponService()).GetCouponList(userId, -1, coupon_status);
                Label_HideStrItemFinal.Text = Literal_Coupon.Text;

                foreach (DataInfo coupon in coupons)
                {
                    string str_coupon = Literal_Coupon.Text;
                    str_coupon = str_coupon.Replace("couponnoHere", coupon["CouponNo"].ToString());
                    str_coupon = str_coupon.Replace("couponnameHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["CouponName"].ToString());
                    str_coupon = str_coupon.Replace("couponvalueHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["Value"].ToString());
                    str_coupon = str_coupon.Replace("couponcreatetimeHere", Convert.ToDateTime(coupon["CreateTime"]).ToLocalTime().ToString());
                    str_coupon = str_coupon.Replace("couponinvalidtimeHere", Convert.ToDateTime(coupon["InvalidTime"]).ToLocalTime().ToString());
                    str_coupon = str_coupon.Replace("sourceHere", coupon["Source"].ToString());
                    coupon_strItem += str_coupon;
                }
                Literal_Coupon.Text = coupon_strItem;
                Label_IsPage.Text = "1";
                Label_CountPage.Text = (coupons_count.Count % 10 == 0) ? (coupons_count.Count / 10).ToString() : ((coupons_count.Count / 10) + 1).ToString();
                if (Label_CountPage.Text == "0")
                    Label_CountPage.Text = "1";
            }
        }





        //取得优惠券的名字
        protected DataInfo GetCouponT(int couponid)
        {
            DataInfo coupon_t = new DataInfo();
            IList<DataInfo> t_coupons = (new CommonService()).GetCouponTemplet(couponid);
            foreach (DataInfo t_coupon in t_coupons)
            {
                coupon_t["CouponName"] = t_coupon["CouponName"].ToString();
                coupon_t["Value"] = t_coupon["Value"].ToString();
            }
            return coupon_t;
        }

        //取得优惠券状态值
        protected string GetCouponStatus(int couponstatus) {
            string word = "";
            switch(couponstatus){
                case 0: word = "未使用"; break;
                case 1: word = "已使用"; break;
            }
            return word;
        }

        //首页
        protected void FirstPageClick(object sender, EventArgs e)
        {
            int coupon_status = Convert.ToInt32(Request.QueryString["couponstatus"]);
            IList<DataInfo> coupons = (new CouponService()).GetCouponListPage(userId, 10, 1, coupon_status);
            Literal_Coupon.Text = "";
            string strItem = "";
            foreach (DataInfo coupon in coupons)
            {
                string str_coupon = Label_HideStrItemFinal.Text;
                str_coupon = str_coupon.Replace("couponnoHere", coupon["CouponNo"].ToString());
                str_coupon = str_coupon.Replace("couponnameHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["CouponName"].ToString());
                str_coupon = str_coupon.Replace("couponvalueHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["Value"].ToString());
                str_coupon = str_coupon.Replace("couponcreatetimeHere", Convert.ToDateTime(coupon["CreateTime"]).ToLocalTime().ToString());
                str_coupon = str_coupon.Replace("couponinvalidtimeHere", Convert.ToDateTime(coupon["InvalidTime"]).ToLocalTime().ToString());
                str_coupon = str_coupon.Replace("sourceHere", coupon["Source"].ToString());
                strItem += str_coupon;
            }
            Literal_Coupon.Text = strItem;
            Label_IsPage.Text = "1";
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

        //上一页
        protected void PrevPageClick(object sender, EventArgs e)
        {
            int coupon_status = Convert.ToInt32(Request.QueryString["couponstatus"]);
            int prevpage = Convert.ToInt32(Label_IsPage.Text) - 1;
            if (prevpage > 0)
            {
                IList<DataInfo> coupons = (new CouponService()).GetCouponListPage(userId, 10, prevpage, coupon_status);
                Literal_Coupon.Text = "";
                string strItem = "";
                foreach (DataInfo coupon in coupons)
                {
                    string str_coupon = Label_HideStrItemFinal.Text;
                    str_coupon = str_coupon.Replace("couponnoHere", coupon["CouponNo"].ToString());
                    str_coupon = str_coupon.Replace("couponnameHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["CouponName"].ToString());
                    str_coupon = str_coupon.Replace("couponvalueHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["Value"].ToString());
                    str_coupon = str_coupon.Replace("couponcreatetimeHere", Convert.ToDateTime(coupon["CreateTime"]).ToLocalTime().ToString());
                    str_coupon = str_coupon.Replace("couponinvalidtimeHere", Convert.ToDateTime(coupon["InvalidTime"]).ToLocalTime().ToString());
                    str_coupon = str_coupon.Replace("sourceHere", coupon["Source"].ToString());
                    strItem += str_coupon;
                }
                Literal_Coupon.Text = strItem;
                Label_IsPage.Text = prevpage.ToString();
                ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
            }
        }

        //下一页
        protected void NextPageClick(object sender, EventArgs e)
        {
            try
            {
                int coupon_status = Convert.ToInt32(Request.QueryString["couponstatus"]);
                int nextpage = Convert.ToInt32(Label_IsPage.Text) + 1;
                if (nextpage <= Convert.ToInt32(Label_CountPage.Text))
                {
                    IList<DataInfo> coupons = (new CouponService()).GetCouponListPage(userId, 10, nextpage, coupon_status);
                    Literal_Coupon.Text = "";
                    string strItem = "";
                    foreach (DataInfo coupon in coupons)
                    {
                        string str_coupon = Label_HideStrItemFinal.Text;
                        str_coupon = str_coupon.Replace("couponnoHere", coupon["CouponNo"].ToString());
                        str_coupon = str_coupon.Replace("couponnameHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["CouponName"].ToString());
                        str_coupon = str_coupon.Replace("couponvalueHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["Value"].ToString());
                        str_coupon = str_coupon.Replace("couponcreatetimeHere", Convert.ToDateTime(coupon["CreateTime"]).ToLocalTime().ToString());
                        str_coupon = str_coupon.Replace("couponinvalidtimeHere", Convert.ToDateTime(coupon["InvalidTime"]).ToLocalTime().ToString());
                        str_coupon = str_coupon.Replace("sourceHere", coupon["Source"].ToString());
                        strItem += str_coupon;
                    }
                    Literal_Coupon.Text = strItem;
                    Label_IsPage.Text = nextpage.ToString();
                    ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
                }
            }
            catch { }
        }

        //跳转页数
        protected void RedirectClick(object sender, EventArgs e)
        {
            int coupon_status = Convert.ToInt32(Request.QueryString["couponstatus"]);
            int redirectpage = Convert.ToInt32(TextBox_Page.Text);
            IList<DataInfo> coupons = (new CouponService()).GetCouponListPage(userId, 10, redirectpage, coupon_status);
            Literal_Coupon.Text = "";
            string strItem = "";
            foreach (DataInfo coupon in coupons)
            {
                string str_coupon = Label_HideStrItemFinal.Text;
                str_coupon = str_coupon.Replace("couponnoHere", coupon["CouponNo"].ToString());
                str_coupon = str_coupon.Replace("couponnameHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["CouponName"].ToString());
                str_coupon = str_coupon.Replace("couponvalueHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["Value"].ToString());
                str_coupon = str_coupon.Replace("couponcreatetimeHere", Convert.ToDateTime(coupon["CreateTime"]).ToLocalTime().ToString());
                str_coupon = str_coupon.Replace("couponinvalidtimeHere", Convert.ToDateTime(coupon["InvalidTime"]).ToLocalTime().ToString());
                str_coupon = str_coupon.Replace("sourceHere", coupon["Source"].ToString());
                strItem += str_coupon;
            }
            Literal_Coupon.Text = strItem;
            Label_IsPage.Text = redirectpage.ToString();
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

        //末页
        protected void LastPageClick(object sender, EventArgs e)
        {
            int coupon_status = Convert.ToInt32(Request.QueryString["couponstatus"]);
            int lastpage = Convert.ToInt32(Label_CountPage.Text);
            IList<DataInfo> coupons = (new CouponService()).GetCouponListPage(userId, 10, lastpage, coupon_status);
            Literal_Coupon.Text = "";
            string strItem = "";
            foreach (DataInfo coupon in coupons)
            {
                string str_coupon = Label_HideStrItemFinal.Text;
                str_coupon = str_coupon.Replace("couponnoHere", coupon["CouponNo"].ToString());
                str_coupon = str_coupon.Replace("couponnameHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["CouponName"].ToString());
                str_coupon = str_coupon.Replace("couponvalueHere", GetCouponT(Convert.ToInt32(coupon["CouponId"]))["Value"].ToString());
                str_coupon = str_coupon.Replace("couponcreatetimeHere", Convert.ToDateTime(coupon["CreateTime"]).ToLocalTime().ToString());
                str_coupon = str_coupon.Replace("couponinvalidtimeHere", Convert.ToDateTime(coupon["InvalidTime"]).ToLocalTime().ToString());
                str_coupon = str_coupon.Replace("sourceHere", coupon["Source"].ToString());
                strItem += str_coupon;
            }
            Literal_Coupon.Text = strItem;
            Label_IsPage.Text = lastpage.ToString();
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }



    }
}