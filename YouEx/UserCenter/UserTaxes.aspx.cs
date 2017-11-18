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
    public partial class UserTaxes : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    IList<DataInfo> taxes = (new TaxService()).GetTaxListPage(userId,2,10,1);
                    IList<DataInfo> taxes_count = (new TaxService()).GetTaxInfoByUserId(userId);
                    string strItem = "";
                    Label_HideStrItemFinal.Text = Literal_Tax.Text;

                    foreach (DataInfo tax in taxes)
                    {
                        if ((int)tax["UserId"] == userId)
                        {
                            string tax_strItem = Literal_Tax.Text;
                            tax_strItem = tax_strItem.Replace("taxnoHere", tax["TaxNo"].ToString());
                            tax_strItem = tax_strItem.Replace("shippingnoHere", tax["ShippingNo"].ToString());
                            tax_strItem = tax_strItem.Replace("moneyHere", tax["Money"].ToString());
                            tax_strItem = tax_strItem.Replace("createtimeHere", Convert.ToDateTime(tax["CreateTime"]).ToLocalTime().ToString());
                            tax_strItem = tax_strItem.Replace("statusHere", "已支付");
                            tax_strItem = tax_strItem.Replace("paytimeHere", Convert.ToDateTime(tax["PayTime"]).ToLocalTime().ToString());
                            tax_strItem = tax_strItem.Replace("imageHere", tax["Image"].ToString());
                            strItem += tax_strItem;
                        }
                    }
                    Literal_Tax.Text = strItem;
                    Label_IsPage.Text = "1";
                    Label_CountPage.Text = (taxes_count.Count % 10 == 0) ? (taxes_count.Count / 10).ToString() : ((taxes_count.Count / 10) + 1).ToString();
                    if (Label_CountPage.Text == "0")
                        Label_CountPage.Text = "1";
                    }
                }
            catch { }
        }

        //首页
        protected void FirstPageClick(object sender, EventArgs e)
        {
            IList<DataInfo> taxes = (new TaxService()).GetTaxListPage(userId, 2, 10, 1);
            string strItem = "";
            Literal_Tax.Text = "";
            foreach (DataInfo tax in taxes)
            {
                if ((int)tax["UserId"] == userId)
                {
                    string tax_strItem = Label_HideStrItemFinal.Text;
                    tax_strItem = tax_strItem.Replace("taxnoHere", tax["TaxNo"].ToString());
                    tax_strItem = tax_strItem.Replace("shippingnoHere", tax["ShippingNo"].ToString());
                    tax_strItem = tax_strItem.Replace("moneyHere", tax["Money"].ToString());
                    tax_strItem = tax_strItem.Replace("createtimeHere", Convert.ToDateTime(tax["CreateTime"]).ToLocalTime().ToString());
                    tax_strItem = tax_strItem.Replace("statusHere", "已支付");//tax["PayStatus"].ToString()
                    tax_strItem = tax_strItem.Replace("paytimeHere", Convert.ToDateTime(tax["PayTime"]).ToLocalTime().ToString());
                    tax_strItem = tax_strItem.Replace("imageHere", tax["Image"].ToString());
                    strItem += tax_strItem;
                }
            }
            Literal_Tax.Text = strItem;
            Label_IsPage.Text = "1";
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

        //上一页
        protected void PrevPageClick(object sender, EventArgs e)
        {
            int prevpage = Convert.ToInt32(Label_IsPage.Text) - 1;
            if (prevpage > 0)
            {
                IList<DataInfo> taxes = (new TaxService()).GetTaxListPage(userId, 2, 10, prevpage);
                string strItem = "";
                Literal_Tax.Text = "";
                foreach (DataInfo tax in taxes)
                {
                    if ((int)tax["UserId"] == userId)
                    {
                        string tax_strItem = Label_HideStrItemFinal.Text;
                        tax_strItem = tax_strItem.Replace("taxnoHere", tax["TaxNo"].ToString());
                        tax_strItem = tax_strItem.Replace("shippingnoHere", tax["ShippingNo"].ToString());
                        tax_strItem = tax_strItem.Replace("moneyHere", tax["Money"].ToString());
                        tax_strItem = tax_strItem.Replace("createtimeHere", Convert.ToDateTime(tax["CreateTime"]).ToLocalTime().ToString());
                        tax_strItem = tax_strItem.Replace("statusHere", "已支付");//tax["PayStatus"].ToString()
                        tax_strItem = tax_strItem.Replace("paytimeHere", Convert.ToDateTime(tax["PayTime"]).ToLocalTime().ToString());
                        tax_strItem = tax_strItem.Replace("imageHere", tax["Image"].ToString());
                        strItem += tax_strItem;
                    }
                }
                Literal_Tax.Text = strItem;
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
                    IList<DataInfo> taxes = (new TaxService()).GetTaxListPage(userId, 2, 10, nextpage);
                    Literal_Tax.Text = "";
                    string strItem = "";
                    foreach (DataInfo tax in taxes)
                    {
                        if ((int)tax["UserId"] == userId)
                        {
                            string tax_strItem = Label_HideStrItemFinal.Text;
                            tax_strItem = tax_strItem.Replace("taxnoHere", tax["TaxNo"].ToString());
                            tax_strItem = tax_strItem.Replace("shippingnoHere", tax["ShippingNo"].ToString());
                            tax_strItem = tax_strItem.Replace("moneyHere", tax["Money"].ToString());
                            tax_strItem = tax_strItem.Replace("createtimeHere", Convert.ToDateTime(tax["CreateTime"]).ToLocalTime().ToString());
                            tax_strItem = tax_strItem.Replace("statusHere", "已支付");//tax["PayStatus"].ToString()
                            tax_strItem = tax_strItem.Replace("paytimeHere", Convert.ToDateTime(tax["PayTime"]).ToLocalTime().ToString());
                            tax_strItem = tax_strItem.Replace("imageHere", tax["Image"].ToString());
                            strItem += tax_strItem;
                        }
                    }
                    Literal_Tax.Text = strItem;
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
            IList<DataInfo> taxes = (new TaxService()).GetTaxListPage(userId, 2, 10, redirectpage);
            Literal_Tax.Text = "";
            string strItem = "";
            foreach (DataInfo tax in taxes)
            {
                if ((int)tax["UserId"] == userId)
                {
                    string tax_strItem = Label_HideStrItemFinal.Text;
                    tax_strItem = tax_strItem.Replace("taxnoHere", tax["TaxNo"].ToString());
                    tax_strItem = tax_strItem.Replace("shippingnoHere", tax["ShippingNo"].ToString());
                    tax_strItem = tax_strItem.Replace("moneyHere", tax["Money"].ToString());
                    tax_strItem = tax_strItem.Replace("createtimeHere", Convert.ToDateTime(tax["CreateTime"]).ToLocalTime().ToString());
                    tax_strItem = tax_strItem.Replace("statusHere", "已支付");//tax["PayStatus"].ToString()
                    tax_strItem = tax_strItem.Replace("paytimeHere", Convert.ToDateTime(tax["PayTime"]).ToLocalTime().ToString());
                    tax_strItem = tax_strItem.Replace("imageHere", tax["Image"].ToString());
                    strItem += tax_strItem;
                }
            }
            Literal_Tax.Text = strItem;
            Label_IsPage.Text = redirectpage.ToString();
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

        //末页
        protected void LastPageClick(object sender, EventArgs e)
        {
            int lastpage = Convert.ToInt32(Label_CountPage.Text);
            IList<DataInfo> taxes = (new TaxService()).GetTaxListPage(userId, 2, 10, lastpage);
            Literal_Tax.Text = "";
            string strItem = "";
            foreach (DataInfo tax in taxes)
            {
                if ((int)tax["UserId"] == userId)
                {
                    string tax_strItem = Label_HideStrItemFinal.Text;
                    tax_strItem = tax_strItem.Replace("taxnoHere", tax["TaxNo"].ToString());
                    tax_strItem = tax_strItem.Replace("shippingnoHere", tax["ShippingNo"].ToString());
                    tax_strItem = tax_strItem.Replace("moneyHere", tax["Money"].ToString());
                    tax_strItem = tax_strItem.Replace("createtimeHere", Convert.ToDateTime(tax["CreateTime"]).ToLocalTime().ToString());
                    tax_strItem = tax_strItem.Replace("statusHere", "已支付");//tax["PayStatus"].ToString()
                    tax_strItem = tax_strItem.Replace("paytimeHere", Convert.ToDateTime(tax["PayTime"]).ToLocalTime().ToString());
                    tax_strItem = tax_strItem.Replace("imageHere", tax["Image"].ToString());
                    strItem += tax_strItem;
                }
            }
            Literal_Tax.Text = strItem;
            Label_IsPage.Text = lastpage.ToString();
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }


    }
}