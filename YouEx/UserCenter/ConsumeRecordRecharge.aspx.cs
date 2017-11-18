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
    public partial class ConsumeRecordRechange : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           try
            {
                string strItem = "";
                if (!IsPostBack)
                {
                    string storageno = (new UserService()).GetUserInfo(userId)["StorageNo"].ToString();
                    IList<DataInfo> account_logs = (new LogService()).GetLogListPage((int)DataField.LOG_TYPE.Account, 10, 1, storageno);
                    IList<DataInfo> log_count_cash = (new LogService()).GetLogList((int)DataField.LOG_TYPE.Account,storageno,DataField.ACCOUNT_ACTION.RechargeCash.ToString());
                    IList<DataInfo> log_count_fly = (new LogService()).GetLogList((int)DataField.LOG_TYPE.Account, storageno, DataField.ACCOUNT_ACTION.RechargeFly.ToString());
                    int log_count = log_count_cash.Count + log_count_fly.Count;
                    Label_HideStrItemFinal.Text = Literal_Recharge.Text;

                    foreach (DataInfo account_log in account_logs)
                    {
                        if (account_log["Action"].ToString() == "RechargeCash")
                        {
                            DataInfo account = (DataInfo)account_log["LogContent"];
                            string recharge_strItem = Literal_Recharge.Text;
                            recharge_strItem = recharge_strItem.Replace("lognoHere", account_log["LogNo"].ToString());
                            if (account["CashMoney"].ToString() != "")
                            {
                                recharge_strItem = recharge_strItem.Replace("typeHere", "余额");
                                recharge_strItem = recharge_strItem.Replace("amountHere", account["CashMoney"].ToString());
                            }
                            if (account["FlyMoney"].ToString() != "")
                            {
                                recharge_strItem = recharge_strItem.Replace("typeHere", "F币");
                                recharge_strItem = recharge_strItem.Replace("amountHere", account["FlyMoney"].ToString());
                            }
                            recharge_strItem = recharge_strItem.Replace("createtimeHere", Convert.ToDateTime(account_log["CreateTime"]).ToLocalTime().ToString());
                            recharge_strItem = recharge_strItem.Replace("messageHere", account["Message"].ToString());
                            strItem += recharge_strItem;                            
                        }                        
                    }
                    Literal_Recharge.Text = strItem;
                    Label_IsPage.Text = "1";
                    Label_CountPage.Text = (log_count % 10 == 0) ? (log_count / 10).ToString() : ((log_count / 10) + 1).ToString();
                    if (Label_CountPage.Text == "0")
                        Label_CountPage.Text = "1";
                }
            }
            catch { }
        }

        //获取充值类型文字
        protected string getRechargeType(int type) {
            string word_type = "";
            switch(type){
                case 1: word_type = "账户"; break;
                case 2: word_type = "F币";  break;
            }
            return word_type;
        }

        //获取充值状态文字
        protected string getRechargeStatus(int status)
        {
            string word_status = "";
            switch (status)
            {
                case 0: word_status = "充值失败"; break;
                case 1: word_status = "已充值"; break;
            }
            return word_status;
        }


        //首页
        protected void FirstPageClick(object sender, EventArgs e)
        {
           string storageno = (new UserService()).GetUserInfo(userId)["StorageNo"].ToString();
           IList<DataInfo> account_logs = (new LogService()).GetLogListPage((int)DataField.LOG_TYPE.Account, 10, 1, storageno);
            Literal_Recharge.Text = "";
            string strItem = "";
            foreach (DataInfo account_log in account_logs)
            {
                DataInfo account = (DataInfo)account_log["LogContent"];
                string log_strItem = Label_HideStrItemFinal.Text;
                log_strItem = log_strItem.Replace("lognoHere", account_log["LogNo"].ToString());
                if (account["CashMoney"].ToString() != "")
                {
                    log_strItem = log_strItem.Replace("typeHere", "余额");
                    log_strItem = log_strItem.Replace("amountHere", account["CashMoney"].ToString());
                }
                if (account["FlyMoney"].ToString() != "")
                {
                    log_strItem = log_strItem.Replace("typeHere", "F币");
                    log_strItem = log_strItem.Replace("amountHere", account["FlyMoney"].ToString());
                }
                log_strItem = log_strItem.Replace("createtimeHere", Convert.ToDateTime(account_log["CreateTime"]).ToLocalTime().ToString());
                log_strItem = log_strItem.Replace("messageHere", account["Message"].ToString());
                strItem += log_strItem;
            }
            Literal_Recharge.Text = strItem;
            Label_IsPage.Text = "1";
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

        //上一页
        protected void PrevPageClick(object sender, EventArgs e)
        {
            string storageno = (new UserService()).GetUserInfo(userId)["StorageNo"].ToString();
            int prevpage = Convert.ToInt32(Label_IsPage.Text) - 1;
            if (prevpage > 0)
            {
                IList<DataInfo> account_logs = (new LogService()).GetLogListPage((int)DataField.LOG_TYPE.Account, 10, prevpage, storageno);
                Literal_Recharge.Text = "";
                string strItem = "";
                foreach (DataInfo account_log in account_logs)
                {
                    DataInfo account = (DataInfo)account_log["LogContent"];
                    string log_strItem = Label_HideStrItemFinal.Text;
                    log_strItem = log_strItem.Replace("lognoHere", account_log["LogNo"].ToString());
                    if (account["CashMoney"].ToString() != "")
                    {
                        log_strItem = log_strItem.Replace("typeHere", "余额");
                        log_strItem = log_strItem.Replace("amountHere", account["CashMoney"].ToString());
                    }
                    if (account["FlyMoney"].ToString() != "")
                    {
                        log_strItem = log_strItem.Replace("typeHere", "F币");
                        log_strItem = log_strItem.Replace("amountHere", account["FlyMoney"].ToString());
                    }
                    log_strItem = log_strItem.Replace("createtimeHere", Convert.ToDateTime(account_log["CreateTime"]).ToLocalTime().ToString());
                    log_strItem = log_strItem.Replace("messageHere", account["Message"].ToString());
                    strItem += log_strItem;
                }
                Literal_Recharge.Text = strItem;
                Label_IsPage.Text = prevpage.ToString();
                ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
            }
        }

        //下一页
        protected void NextPageClick(object sender, EventArgs e)
        {
            try
            {
                string storageno = (new UserService()).GetUserInfo(userId)["StorageNo"].ToString();
                int nextpage = Convert.ToInt32(Label_IsPage.Text) + 1;
                if (nextpage <= Convert.ToInt32(Label_CountPage.Text))
                {
                    IList<DataInfo> account_logs = (new LogService()).GetLogListPage((int)DataField.LOG_TYPE.Account, 10, nextpage, storageno);
                    Literal_Recharge.Text = "";
                    string strItem = "";
                    foreach (DataInfo account_log in account_logs)
                    {
                        DataInfo account = (DataInfo)account_log["LogContent"];
                        string log_strItem = Label_HideStrItemFinal.Text;
                        log_strItem = log_strItem.Replace("lognoHere", account_log["LogNo"].ToString());
                        if (account["CashMoney"].ToString() != "")
                        {
                            log_strItem = log_strItem.Replace("typeHere", "余额");
                            log_strItem = log_strItem.Replace("amountHere", account["CashMoney"].ToString());
                        }
                        if (account["FlyMoney"].ToString() != "")
                        {
                            log_strItem = log_strItem.Replace("typeHere", "F币");
                            log_strItem = log_strItem.Replace("amountHere", account["FlyMoney"].ToString());
                        }
                        log_strItem = log_strItem.Replace("createtimeHere", Convert.ToDateTime(account_log["CreateTime"]).ToLocalTime().ToString());
                        log_strItem = log_strItem.Replace("messageHere", account["Message"].ToString());
                        strItem += log_strItem;
                    }
                    Literal_Recharge.Text = strItem;
                    Label_IsPage.Text = nextpage.ToString();
                    ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
                }
            }
            catch { }
        }

        //跳转页数
        protected void RedirectClick(object sender, EventArgs e)
        {
            string storageno = (new UserService()).GetUserInfo(userId)["StorageNo"].ToString();
            int redirectpage = Convert.ToInt32(TextBox_Page.Text);
            IList<DataInfo> account_logs = (new LogService()).GetLogListPage((int)DataField.LOG_TYPE.Account, 10, redirectpage, storageno);
            Literal_Recharge.Text = "";
            string strItem = "";
            foreach (DataInfo account_log in account_logs)
            {
                DataInfo account = (DataInfo)account_log["LogContent"];
                string log_strItem = Label_HideStrItemFinal.Text;
                log_strItem = log_strItem.Replace("lognoHere", account_log["LogNo"].ToString());
                if (account["CashMoney"].ToString() != "")
                {
                    log_strItem = log_strItem.Replace("typeHere", "余额");
                    log_strItem = log_strItem.Replace("amountHere", account["CashMoney"].ToString());
                }
                if (account["FlyMoney"].ToString() != "")
                {
                    log_strItem = log_strItem.Replace("typeHere", "F币");
                    log_strItem = log_strItem.Replace("amountHere", account["FlyMoney"].ToString());
                }
                log_strItem = log_strItem.Replace("createtimeHere", Convert.ToDateTime(account_log["CreateTime"]).ToLocalTime().ToString());
                log_strItem = log_strItem.Replace("messageHere", account["Message"].ToString());
                strItem += log_strItem;
            }
            Literal_Recharge.Text = strItem;
            Label_IsPage.Text = redirectpage.ToString();
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

        //末页
        protected void LastPageClick(object sender, EventArgs e)
        {
            string storageno = (new UserService()).GetUserInfo(userId)["StorageNo"].ToString();
            int lastpage = Convert.ToInt32(Label_CountPage.Text);
            IList<DataInfo> account_logs = (new LogService()).GetLogListPage((int)DataField.LOG_TYPE.Account, 10, lastpage, storageno);
            Literal_Recharge.Text = "";
            string strItem = "";
            foreach (DataInfo account_log in account_logs)
            {
                DataInfo account = (DataInfo)account_log["LogContent"];
                string log_strItem = Label_HideStrItemFinal.Text;
                log_strItem = log_strItem.Replace("lognoHere", account_log["LogNo"].ToString());
                if (account["CashMoney"].ToString() != "")
                {
                    log_strItem = log_strItem.Replace("typeHere", "余额");
                    log_strItem = log_strItem.Replace("amountHere", account["CashMoney"].ToString());
                }
                if (account["FlyMoney"].ToString() != "")
                {
                    log_strItem = log_strItem.Replace("typeHere", "F币");
                    log_strItem = log_strItem.Replace("amountHere", account["FlyMoney"].ToString());
                }
                log_strItem = log_strItem.Replace("createtimeHere", Convert.ToDateTime(account_log["CreateTime"]).ToLocalTime().ToString());
                log_strItem = log_strItem.Replace("messageHere", account["Message"].ToString());
                strItem += log_strItem;
            }
            Literal_Recharge.Text = strItem;
            Label_IsPage.Text = lastpage.ToString();
            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, GetType(), "CheckPageCss", "CheckPageCss()", true);
        }

    }
}