using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Data;
using YouExLib.Service;
using YouExLib.Common;

namespace WebSite.Manager
{
    using DataInfo = Dictionary<string, object>;
    public partial class Admin_Login : Tool.AdminBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AdminLogin(object sender, ImageClickEventArgs e)
        {
            string checkcode = (Session["VerifyCode"].ToString()).ToLower();
            if (checkcode == Tb_CheckCode.Text)
            {
                string username = usernametb.Text;
                string password = passwordtb.Text;
                int userid = Login(username, password, 1);
                if (userid > 0)
                    Response.Redirect("ArticleCenter.aspx?articlepage=1");
                else
                    Label_Hide_Check.Text = "用户名或密码错误";
            }else
                Label_Hide_Check.Text = "请输入正确的验证码";
        }
    }
}