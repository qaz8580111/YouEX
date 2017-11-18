using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Data;
using YouExLib.Interface;
using YouExLib.Service;

namespace WebSite.UserCenter
{
    using DataInfo = Dictionary<string, object>;
    public partial class ConsumeRecordSale : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string strItem = "";
                if (!IsPostBack)
                {
                    IList<DataInfo> bills = (new OrderService()).GetBillListPage(userId, 2, 10, 1);
                    IList<DataInfo> bills_count = (new OrderService()).GetBillList(-1,userId,1008,2,-1,"","");
                    Label_HideStrItemFinal.Text = Literal_Record_Sale.Text;

                    foreach (DataInfo bill in bills)
                    {
                        string bill_strItem = Literal_Record_Sale.Text;
                        bill_strItem = bill_strItem.Replace("billnoHere", bill["BillNo"].ToString());                        
                        bill_strItem = bill_strItem.Replace("paystatusHere", "支付完成"); 
                        bill_strItem = bill_strItem.Replace("paybankHere", bill["PayBank"].ToString());
                        bill_strItem = bill_strItem.Replace("paycashHere", bill["PayCash"].ToString());
                        bill_strItem = bill_strItem.Replace("payflyHere", bill["PayFly"].ToString());
                        bill_strItem = bill_strItem.Replace("paycouponHere", bill["PayCoupon"].ToString());
                        bill_strItem = bill_strItem.Replace("totalcostHere", bill["TotalCost"].ToString());
                        bill_strItem = bill_strItem.Replace("paytimeHere", Convert.ToDateTime(bill["PayTime"]).ToLocalTime().ToString());
                        bill_strItem = bill_strItem.Replace("contentHere", bill["Content"].ToString());
                        strItem += bill_strItem;
                    }
                    Literal_Record_Sale.Text = strItem;
                    Label_IsPage.Text = "1";
                    Label_CountPage.Text = (bills_count.Count % 10 == 0) ? (bills_count.Count / 10).ToString() : ((bills_count.Count / 10) + 1).ToString();
                    if (Label_CountPage.Text == "0")
                        Label_CountPage.Text = "1";
                }
            }
            catch { }
        }

        //首页
        protected void FirstPageClick(object sender, EventArgs e)
        {
            IList<DataInfo> bills = (new OrderService()).GetBillListPage(userId, 2, 10, 1);
            Literal_Record_Sale.Text = "";
            string strItem = "";
            foreach (DataInfo bill in bills)
            {
                string bill_strItem = Label_HideStrItemFinal.Text;
                bill_strItem = bill_strItem.Replace("billnoHere", bill["BillNo"].ToString());
                bill_strItem = bill_strItem.Replace("paystatusHere", "支付完成");
                bill_strItem = bill_strItem.Replace("paybankHere", bill["PayBank"].ToString());
                bill_strItem = bill_strItem.Replace("paycashHere", bill["PayCash"].ToString());
                bill_strItem = bill_strItem.Replace("payflyHere", bill["PayFly"].ToString());
                bill_strItem = bill_strItem.Replace("paycouponHere", bill["PayCoupon"].ToString());
                bill_strItem = bill_strItem.Replace("totalcostHere", bill["TotalCost"].ToString());
                bill_strItem = bill_strItem.Replace("paytimeHere", Convert.ToDateTime(bill["PayTime"]).ToLocalTime().ToString());
                bill_strItem = bill_strItem.Replace("contentHere", bill["Content"].ToString());
                strItem += bill_strItem;
            }
            Literal_Record_Sale.Text = strItem;
            Label_IsPage.Text = "1";
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

        //上一页
        protected void PrevPageClick(object sender, EventArgs e)
        {
            int prevpage = Convert.ToInt32(Label_IsPage.Text) - 1;
            if (prevpage > 0)
            {
                IList<DataInfo> bills = (new OrderService()).GetBillListPage(userId, 2, 10, prevpage);
                Literal_Record_Sale.Text = "";
                string strItem = "";
                foreach (DataInfo bill in bills)
                {
                    string bill_strItem = Label_HideStrItemFinal.Text;
                    bill_strItem = bill_strItem.Replace("billnoHere", bill["BillNo"].ToString());
                    bill_strItem = bill_strItem.Replace("paystatusHere", "支付完成");
                    bill_strItem = bill_strItem.Replace("paybankHere", bill["PayBank"].ToString());
                    bill_strItem = bill_strItem.Replace("paycashHere", bill["PayCash"].ToString());
                    bill_strItem = bill_strItem.Replace("payflyHere", bill["PayFly"].ToString());
                    bill_strItem = bill_strItem.Replace("paycouponHere", bill["PayCoupon"].ToString());
                    bill_strItem = bill_strItem.Replace("totalcostHere", bill["TotalCost"].ToString());
                    bill_strItem = bill_strItem.Replace("paytimeHere", Convert.ToDateTime(bill["PayTime"]).ToLocalTime().ToString());
                    bill_strItem = bill_strItem.Replace("contentHere", bill["Content"].ToString());
                    strItem += bill_strItem;
                }
                Literal_Record_Sale.Text = strItem;
                Label_IsPage.Text = prevpage.ToString();
                ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
            }
        }

        //下一页
        protected void NextPageClick(object sender, EventArgs e)
        {
            try
            {
                int nextpage = Convert.ToInt32(Label_IsPage.Text) + 1;
                if (nextpage <= Convert.ToInt32(Label_CountPage.Text))
                {
                    IList<DataInfo> bills = (new OrderService()).GetBillListPage(userId, 2, 10, nextpage);
                    Literal_Record_Sale.Text = "";
                    string strItem = "";
                    foreach (DataInfo bill in bills)
                    {
                        string bill_strItem = Label_HideStrItemFinal.Text;
                        bill_strItem = bill_strItem.Replace("billnoHere", bill["BillNo"].ToString());
                        bill_strItem = bill_strItem.Replace("paystatusHere", "支付完成");
                        bill_strItem = bill_strItem.Replace("paybankHere", bill["PayBank"].ToString());
                        bill_strItem = bill_strItem.Replace("paycashHere", bill["PayCash"].ToString());
                        bill_strItem = bill_strItem.Replace("payflyHere", bill["PayFly"].ToString());
                        bill_strItem = bill_strItem.Replace("paycouponHere", bill["PayCoupon"].ToString());
                        bill_strItem = bill_strItem.Replace("totalcostHere", bill["TotalCost"].ToString());
                        bill_strItem = bill_strItem.Replace("paytimeHere", Convert.ToDateTime(bill["PayTime"]).ToLocalTime().ToString());
                        bill_strItem = bill_strItem.Replace("contentHere", bill["Content"].ToString());
                        strItem += bill_strItem;
                    }
                    Literal_Record_Sale.Text = strItem;
                    Label_IsPage.Text = nextpage.ToString();
                    ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
                }
            }
            catch { }
        }

        //跳转页数
        protected void RedirectClick(object sender, EventArgs e)
        {
            int redirectpage = Convert.ToInt32(TextBox_Page.Text);
            IList<DataInfo> bills = (new OrderService()).GetBillListPage(userId, 2, 10, redirectpage);
            Literal_Record_Sale.Text = "";
            string strItem = "";
            foreach (DataInfo bill in bills)
            {
                string bill_strItem = Label_HideStrItemFinal.Text;
                bill_strItem = bill_strItem.Replace("billnoHere", bill["BillNo"].ToString());
                bill_strItem = bill_strItem.Replace("paystatusHere", "支付完成");
                bill_strItem = bill_strItem.Replace("paybankHere", bill["PayBank"].ToString());
                bill_strItem = bill_strItem.Replace("paycashHere", bill["PayCash"].ToString());
                bill_strItem = bill_strItem.Replace("payflyHere", bill["PayFly"].ToString());
                bill_strItem = bill_strItem.Replace("paycouponHere", bill["PayCoupon"].ToString());
                bill_strItem = bill_strItem.Replace("totalcostHere", bill["TotalCost"].ToString());
                bill_strItem = bill_strItem.Replace("paytimeHere", Convert.ToDateTime(bill["PayTime"]).ToLocalTime().ToString());
                bill_strItem = bill_strItem.Replace("contentHere", bill["Content"].ToString());
                strItem += bill_strItem;
            }
            Literal_Record_Sale.Text = strItem;
            Label_IsPage.Text = redirectpage.ToString();
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

        //末页
        protected void LastPageClick(object sender, EventArgs e)
        {
            int lastpage = Convert.ToInt32(Label_CountPage.Text);
            IList<DataInfo> bills = (new OrderService()).GetBillListPage(userId, 2, 10, lastpage);
            Literal_Record_Sale.Text = "";
            string strItem = "";
            foreach (DataInfo bill in bills)
            {
                string bill_strItem = Label_HideStrItemFinal.Text;
                bill_strItem = bill_strItem.Replace("billnoHere", bill["BillNo"].ToString());
                bill_strItem = bill_strItem.Replace("paystatusHere", "支付完成");
                bill_strItem = bill_strItem.Replace("paybankHere", bill["PayBank"].ToString());
                bill_strItem = bill_strItem.Replace("paycashHere", bill["PayCash"].ToString());
                bill_strItem = bill_strItem.Replace("payflyHere", bill["PayFly"].ToString());
                bill_strItem = bill_strItem.Replace("paycouponHere", bill["PayCoupon"].ToString());
                bill_strItem = bill_strItem.Replace("totalcostHere", bill["TotalCost"].ToString());
                bill_strItem = bill_strItem.Replace("paytimeHere", Convert.ToDateTime(bill["PayTime"]).ToLocalTime().ToString());
                bill_strItem = bill_strItem.Replace("contentHere", bill["Content"].ToString());
                strItem += bill_strItem;
            }
            Literal_Record_Sale.Text = strItem;
            Label_IsPage.Text = lastpage.ToString();
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }


    }
}