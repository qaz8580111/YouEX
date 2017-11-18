using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Service;
using System.Net;
using YouExLib.Data;

namespace WebSite.WebSite
{
    using DataInfo = Dictionary<string, object>;
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["YouEx_User"] != null)
            {
                Label_Show_LoginOut.Text = "user";
                int userId = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
                DataInfo User = (new UserService()).GetUserInfo(userId);
                Label_LoginName.Text = User["FirstName"].ToString();
            }

        }

        protected void UserLoginOut(object sender, EventArgs e)
        {
            //记录用户登出日志
            DataInfo userlog_loginout = new DataInfo();
            int userid = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
            userlog_loginout["UserId"] = userid;
            userlog_loginout["LoginIp"] = Request.UserHostAddress; ;
            userlog_loginout["LoginOutTime"] = System.DateTime.Now.ToString();
            userlog_loginout["Message"] = "用户登出成功";
            (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User),(new UserService()).GetStorageNo(userid) , DataField.USER_ACTION.Logout.ToString(), userlog_loginout);

            HttpContext.Current.Response.Cookies[HttpUtility.UrlEncode("YouEx_User")].Expires = DateTime.Now.AddDays(-1); 
            Response.Redirect("../UserCenter/UserLogin.aspx");
        }
    }
}