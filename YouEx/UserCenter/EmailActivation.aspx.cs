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
    public partial class EmailActivation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int result_message = 0;
            string isactive = Request.QueryString["isactive"];
            if (isactive != null)
            {
                int userid = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
                if (Convert.ToInt32((new UserService()).GetUserInfo(userid)["Type"]) == Convert.ToInt32(DataField.User_Type.UnAction))
                {
                    Response.ContentType = "text/plain";
                    Response.Write("yes");
                    Response.End();
                }
            }
            if (Request.Cookies["IsSendEmail"] == null)
            {
                result_message = SendToEmail();
                HttpCookie cookie = new HttpCookie("IsSendEmail");
                cookie["MessageId"] = result_message.ToString();
                cookie.Expires = DateTime.Now.AddMinutes(30);
                HttpContext.Current.Response.AppendCookie(cookie);
            }
        }

        //跳转到邮箱网址
        protected void EnterEmail(object sender, EventArgs e)
        {
            #region 判断进入什么邮箱网址
            int userid = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
            string email = Request.Cookies["YouEx_User"]["UserName"];
            DataInfo user = (new UserService()).GetUserInfo(userid);
            string email_str = email.Split('@')[1].ToLower();
            string netaddress = getNetAddress(email_str);
            if (netaddress != "")
            {
                //移除注册时的cookie
                HttpContext.Current.Response.Cookies[HttpUtility.UrlEncode("IsSendEmail")].Expires = DateTime.Now.AddDays(-1);
                Response.Redirect("http://" + netaddress);
            }
            else
            {
                Response.Write("<script>alert('跳转失败！');</script>");
            }        
            #endregion
        }

        //发送邮件到邮箱
        protected int SendToEmail() {
            int userid = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
            string email = Request.Cookies["YouEx_User"]["UserName"];
            DataInfo msg_t = Message.GetTemplet("RegActive", 2);
            string keystring = getCheckEmailString(userid);
            string content = msg_t["MessageBody"].ToString().Replace("{$ActiveUrl}", "<a href='http://new.fedroad.com/UserCenter/UserSkipping.aspx?activation=" + keystring + "'>点击激活</a>");
            DataInfo msginfo = new DataInfo();
            msginfo["UserId"] = userid;
            msginfo["TempletCode"] = msg_t["Name"].ToString();
            msginfo["KeyString"] = keystring;
            msginfo["ValidateTime"] = 1440;
            int result_message = Message.SendEmail(email, msg_t["Subject"].ToString(), content, true, msginfo);
            return result_message;
        }

        //得到要进入邮箱的网址
        protected string getNetAddress(string email)
        {
            string netaddress = "";             
            switch (email)
            {
                case "gmail.com": email = "google.com"; break;
            }
            netaddress = "mail." + email;
            return netaddress;
        }

        //获取email验证字段
        protected string getCheckEmailString(int userid){
            string str_userid = MD5(userid.ToString());
            string rdstring = RndStr(15, RndType.Char);
            string keystring = str_userid + rdstring;
            return keystring;
        }

        //MD5加密
        protected static string MD5(string toCryString)
        {
            return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(toCryString, "MD5");
        }

        //获取随机字符段
        public static string RndStr(int Len, RndType type)
        {
            string s = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,W,X,Y,Z";
            string[] Chars = s.Split(',');
            Random Rnd = new Random();
            int Start = 0, End = 0;
            switch (type)
            {
                case RndType.Char:
                    Start = 10;
                    End = 35;
                    break;
                case RndType.Number:
                    Start = 0;
                    End = 9;
                    break;
                case RndType.Both:
                    Start = 0;
                    End = 35;
                    break;
            }
            s = "";
            for (int i = 0; i < Len; i++)
            {
                s += Chars[Rnd.Next(Start, End)];
                System.Threading.Thread.Sleep(5);//延时,避免重复   
            }
            return s;
        }
        public enum RndType
        {
            Char, Number, Both
        };

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&/=()]", "");
            return result_transfer;
        }

        //重新发送邮箱
        protected void ReSendEmail(object sender, EventArgs e)
        {
            SendToEmail();
        }


    }
}