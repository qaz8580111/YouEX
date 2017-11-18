using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Service;
using System.Text;
using YouExLib.Data;

namespace WebSite.UserCenter
{
    using DataInfo = Dictionary<string, object>;
    public partial class MobileActivation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int result_msg = 0;
            string isactive = Request.QueryString["isactive"];
            if (isactive != null) {
                int userid = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
                if (Convert.ToInt32((new UserService()).GetUserInfo(userid)["Type"]) == Convert.ToInt32(DataField.User_Type.UnAction))
                {
                    Response.ContentType = "text/plain";
                    Response.Write("yes");
                    Response.End();
                }
            }
            if (Request.Cookies["IsSendMobile"] == null)
            {
                result_msg = SendMsg();
                HttpCookie cookie = new HttpCookie("IsSendMobile");
                cookie["MsgId"] = result_msg.ToString();
                cookie.Expires = DateTime.Now.AddMinutes(30);
                HttpContext.Current.Response.AppendCookie(cookie);
            }
        }

        //发送短信
        protected int SendMsg()
        {
            string mobile = Request.Cookies["YouEx_User"]["UserName"];
            DataInfo msg_t = Message.GetTemplet("RegActive", 1);
            string randstring = (new Random()).Next(100000, 999999).ToString();
            string content_t = msg_t["MessageBody"].ToString().Replace("{$Mobile}", mobile);
            string content = content_t.Replace("{$ActiveCode}", randstring);
            DataInfo msginfo = new DataInfo();
            msginfo["UserId"] = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
            msginfo["TempletCode"] = msg_t["Name"].ToString();
            msginfo["KeyString"] = Request.Cookies["YouEx_User"]["UserId"] + randstring;
            msginfo["ValidateTime"] = 30;
            int result_msg = Message.SendSmsMessage(mobile, content, true, msginfo);
            return result_msg;
        }    

        //手机激活
        protected void ActivationMobile(object sender, EventArgs e)
        {
            string userid = Request.Cookies["YouEx_User"]["UserId"];
            string checkcode_t = getTransferString(TB_MobileCheck.Text);
            string checkcode = userid + checkcode_t;
            IList<DataInfo> messages = (new MessageService()).GetValidateMessage(1, 1, Convert.ToInt32(userid), "", "", "", checkcode, "", "");
            if (messages.Count > 0)
            {
                DataInfo user = (new UserService()).GetUserInfo(Convert.ToInt32(userid));
                user["Type"] = Convert.ToInt32(DataField.User_Type.Intermediate);
                bool result_updateuser = (new UserService()).UpdateUser(Convert.ToInt32(userid), user);
                if (result_updateuser)
                {
                    //移除注册时的cookie
                    HttpContext.Current.Response.Cookies[HttpUtility.UrlEncode("IsSendMobile")].Expires = DateTime.Now.AddDays(-1);
                    Response.Redirect("./UserCenter.aspx");
                }
            }
            else
                Label_HideMsgCode.Text = "验证码错误";
        }

        //重新发送手机短信
        protected void ReSendMobile(object sender, EventArgs e)
        {
            SendMsg();
        }

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&/=()]", "");
            return result_transfer;
        }
    }
}