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
    public partial class UserSkipping : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string keystring = Request.QueryString["activation"];
            int userid = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
            string email = Request.Cookies["YouEx_User"]["UserName"].ToString();

            IList<DataInfo> messages = (new MessageService()).GetValidateMessage(2, 1, userid, "", email, "", keystring, "", "");
            if (messages.Count > 0)
            {
                DataInfo user = (new UserService()).GetUserInfo(userid);
                user["Type"] = Convert.ToInt32(DataField.User_Type.Intermediate);
                bool result_updateuser = (new UserService()).UpdateUser(userid, user);
                if (result_updateuser)
                {
                    //移除注册时的cookie
                    HttpContext.Current.Response.Cookies[HttpUtility.UrlEncode("IsSendEmail")].Expires = DateTime.Now.AddDays(-1);                    
                    Response.Redirect("./UserCenter.aspx");
                }
            }
        }
    }
}