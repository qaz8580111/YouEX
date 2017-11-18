using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Service;
using System.Text.RegularExpressions;

namespace WebSite.UserCenter
{
    using DataInfo = Dictionary<string, object>;
    public partial class ConsumeRecordDebit : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    IList<DataInfo> services = (new OrderService()).GetServiceListPage(userId,10,1);
                    IList<DataInfo> services_count = (new OrderService()).GetServiceByUserId(userId);
                    Label_HideStrItemFinal.Text = Literal_Service.Text;
                 
                    string strItem = "";
                    foreach (DataInfo service in services)
                    {
                        string service_strItem = Literal_Service.Text;
                        service_strItem = service_strItem.Replace("servicenoHere", service["ServiceNo"].ToString());
                        service_strItem = service_strItem.Replace("packagenoHere", service["PackageNo"].ToString());
                        service_strItem = service_strItem.Replace("servicenameHere", service["ServiceCode"].ToString());
                        service_strItem = service_strItem.Replace("paystatusHere", service["PayStatus"].ToString());
                        service_strItem = service_strItem.Replace("createtimeHere", Convert.ToDateTime(service["CreateTime"]).ToLocalTime().ToString());
                        service_strItem = service_strItem.Replace("accesstimeHere", Convert.ToDateTime(service["AccessTime"]).ToLocalTime().ToString());
                        service_strItem = service_strItem.Replace("requestHere", service["Request"].ToString());
                        //service_strItem = service_strItem.Replace("attachfileHere", service["AttachFile"].ToString());
                        strItem += service_strItem;
                    }
                    Literal_Service.Text = strItem;
                    Label_IsPage.Text = "1";//Regex.IsMatch(strSrc, @"^[+-]?\d+$")
                    Label_CountPage.Text = (services_count.Count % 10 == 0) ? (services_count.Count / 10).ToString() : ((services_count.Count / 10) + 1).ToString();
                    if (Label_CountPage.Text == "0")
                        Label_CountPage.Text = "1";
                }
            }
            catch { }

        }

        //首页
        protected void FirstPageClick(object sender, EventArgs e)
        {
            IList<DataInfo> services = (new OrderService()).GetServiceListPage(userId, 10, 1);
            Literal_Service.Text = "";
            string strItem = "";
            foreach (DataInfo service in services)
            {
                string service_strItem = Label_HideStrItemFinal.Text;
                service_strItem = service_strItem.Replace("servicenoHere", service["ServiceNo"].ToString());
                service_strItem = service_strItem.Replace("packagenoHere", service["PackageNo"].ToString());
                service_strItem = service_strItem.Replace("servicenameHere", service["ServiceCode"].ToString());
                service_strItem = service_strItem.Replace("paystatusHere", service["PayStatus"].ToString());
                service_strItem = service_strItem.Replace("createtimeHere", Convert.ToDateTime(service["CreateTime"]).ToLocalTime().ToString());
                service_strItem = service_strItem.Replace("accesstimeHere", Convert.ToDateTime(service["AccessTime"]).ToLocalTime().ToString());
                service_strItem = service_strItem.Replace("requestHere", service["Request"].ToString());
                //service_strItem = service_strItem.Replace("attachfileHere", service["AttachFile"].ToString());
                strItem += service_strItem;
            }
            Literal_Service.Text = strItem;
            Label_IsPage.Text = "1";
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

        //上一页
        protected void PrevPageClick(object sender, EventArgs e)
        {
            int prevpage = Convert.ToInt32(Label_IsPage.Text) - 1;
            if (prevpage > 0)
            {
                IList<DataInfo> services = (new OrderService()).GetServiceListPage(userId, 10, prevpage);
                Literal_Service.Text = "";
                string strItem = "";
                foreach (DataInfo service in services)
                {
                    string service_strItem = Label_HideStrItemFinal.Text;
                    service_strItem = service_strItem.Replace("servicenoHere", service["ServiceNo"].ToString());
                    service_strItem = service_strItem.Replace("packagenoHere", service["PackageNo"].ToString());
                    service_strItem = service_strItem.Replace("servicenameHere", service["ServiceCode"].ToString());
                    service_strItem = service_strItem.Replace("paystatusHere", service["PayStatus"].ToString());
                    service_strItem = service_strItem.Replace("createtimeHere", Convert.ToDateTime(service["CreateTime"]).ToLocalTime().ToString());
                    service_strItem = service_strItem.Replace("accesstimeHere", Convert.ToDateTime(service["AccessTime"]).ToLocalTime().ToString());
                    service_strItem = service_strItem.Replace("requestHere", service["Request"].ToString());
                    //service_strItem = service_strItem.Replace("attachfileHere", service["AttachFile"].ToString());
                    strItem += service_strItem;
                }
                Literal_Service.Text = strItem;
                Label_IsPage.Text = prevpage.ToString();
                ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
            }
        }

        //下一页
        protected void NextPageClick(object sender, EventArgs e)
        {
            int nextpage = Convert.ToInt32(Label_IsPage.Text) + 1;
            if (nextpage <= Convert.ToInt32(Label_CountPage.Text))
            {
                IList<DataInfo> services = (new OrderService()).GetServiceListPage(userId, 10, nextpage);
                Literal_Service.Text = "";
                string strItem = "";
                foreach (DataInfo service in services)
                {
                    string service_strItem = Label_HideStrItemFinal.Text;
                    service_strItem = service_strItem.Replace("servicenoHere", service["ServiceNo"].ToString());
                    service_strItem = service_strItem.Replace("packagenoHere", service["PackageNo"].ToString());
                    service_strItem = service_strItem.Replace("servicenameHere", service["ServiceCode"].ToString());
                    service_strItem = service_strItem.Replace("paystatusHere", service["PayStatus"].ToString());
                    service_strItem = service_strItem.Replace("createtimeHere", Convert.ToDateTime(service["CreateTime"]).ToLocalTime().ToString());
                    service_strItem = service_strItem.Replace("accesstimeHere", Convert.ToDateTime(service["AccessTime"]).ToLocalTime().ToString());
                    service_strItem = service_strItem.Replace("requestHere", service["Request"].ToString());
                    //service_strItem = service_strItem.Replace("attachfileHere", service["AttachFile"].ToString());
                    strItem += service_strItem;
                }
                Literal_Service.Text = strItem;
                Label_IsPage.Text = nextpage.ToString();
                ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
            }
        }

        //跳转页数
        protected void RedirectClick(object sender, EventArgs e)
        {
            int redirectpage = Convert.ToInt32(TextBox_Page.Text);
            IList<DataInfo> services = (new OrderService()).GetServiceListPage(userId, 10, redirectpage);
            Literal_Service.Text = "";
            string strItem = "";
            foreach (DataInfo service in services)
            {
                string service_strItem = Label_HideStrItemFinal.Text;
                service_strItem = service_strItem.Replace("servicenoHere", service["ServiceNo"].ToString());
                service_strItem = service_strItem.Replace("packagenoHere", service["PackageNo"].ToString());
                service_strItem = service_strItem.Replace("servicenameHere", service["ServiceCode"].ToString());
                service_strItem = service_strItem.Replace("paystatusHere", service["PayStatus"].ToString());
                service_strItem = service_strItem.Replace("createtimeHere", Convert.ToDateTime(service["CreateTime"]).ToLocalTime().ToString());
                service_strItem = service_strItem.Replace("accesstimeHere", Convert.ToDateTime(service["AccessTime"]).ToLocalTime().ToString());
                service_strItem = service_strItem.Replace("requestHere", service["Request"].ToString());
                //service_strItem = service_strItem.Replace("attachfileHere", service["AttachFile"].ToString());
                strItem += service_strItem;
            }
            Literal_Service.Text = strItem;
            Label_IsPage.Text = redirectpage.ToString();
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

        //末页
        protected void LastPageClick(object sender, EventArgs e)
        {
            int lastpage = Convert.ToInt32(Label_CountPage.Text);
            IList<DataInfo> services = (new OrderService()).GetServiceListPage(userId, 10,lastpage);
            Literal_Service.Text = "";
            string strItem = "";
            foreach (DataInfo service in services)
            {
                string service_strItem = Label_HideStrItemFinal.Text;
                service_strItem = service_strItem.Replace("servicenoHere", service["ServiceNo"].ToString());
                service_strItem = service_strItem.Replace("packagenoHere", service["PackageNo"].ToString());
                service_strItem = service_strItem.Replace("servicenameHere", service["ServiceCode"].ToString());
                service_strItem = service_strItem.Replace("paystatusHere", service["PayStatus"].ToString());
                service_strItem = service_strItem.Replace("createtimeHere", Convert.ToDateTime(service["CreateTime"]).ToLocalTime().ToString());
                service_strItem = service_strItem.Replace("accesstimeHere", Convert.ToDateTime(service["AccessTime"]).ToLocalTime().ToString());
                service_strItem = service_strItem.Replace("requestHere", service["Request"].ToString());
                //service_strItem = service_strItem.Replace("attachfileHere", service["AttachFile"].ToString());
                strItem += service_strItem;
            }
            Literal_Service.Text = strItem;
            Label_IsPage.Text = lastpage.ToString();
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

    }
}