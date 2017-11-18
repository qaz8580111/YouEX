using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YouExLib.Service;
using YouExLib.Common;
using YouExLib.Tools;

namespace WebSite.Tool
{
    public class AdminBasePage : System.Web.UI.Page
    {
        protected string cookieDomain = "new.fedroad.com";
        protected string encryptKey = "IZjE2H/lNwnHFC6L1hKmyUneNL0NZ6QxXHQ3lpjemHI=";
        protected int userId = -1;
        protected int Type = 0;
        protected string userName = "";
        protected string password = "";

        public AdminBasePage()
        {
            LoadCookies();
        }

        //管理员登录
        public int Login(string UserName, string Password, int Type)
        {
            userId = (new UserService()).AdminLogin(UserName, MD5.Encode(Password), Type);

            if (userId > 0)
            {
                userName = UserName;
                password = Password;
                SaveCookies(userId, UserName, Password, Type);
            }

            return userId;
        }

        protected void Logout()
        {
            ClearCookies();
        }

        private void SaveCookies(int UserId, string UserName, string Password, int Type)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["YouEx_Admin"];
            if (cookie == null)
                cookie = new HttpCookie("YouEx_Admin");

            cookie["UserId"] = UserId.ToString();
            cookie["UserName"] = UserName;
            cookie["Password"] = DES.Encode(Password, encryptKey);
            cookie["Type"] = Type.ToString();

            HttpContext.Current.Response.AppendCookie(cookie);
        }

        private void LoadCookies()
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["YouEx_Admin"];

            if (cookie != null)
            {
                if (cookie["UserId"] != null)
                    userId = Utils.StrToInt(cookie["UserId"], -1);

                if (userId > 0)
                {
                    if (cookie["UserName"] != null)
                        userName = cookie["UserName"];

                    if (cookie["Password"] != null)
                        password = DES.Decode(cookie["Password"], encryptKey);

                    /*if (cookie["ValidateMinutes"] != null)
                    {
                        int ValidateMinutes = Utils.StrToInt(cookie["ValidateMinutes"], 0);
                        HttpContext.Current.Request.Cookies["YouEx_User"].Expires = DateTime.Now.AddMinutes(ValidateMinutes);
                    }*/

                    int type = Convert.ToInt32((new UserService()).GetUserInfo(userId)["Type"]);
                    Type = type;

                }
                else
                    ClearCookies();
            }
        }

        private void ClearCookies()
        {
            userId = -1;
            userName = "";
            password = "";
            HttpContext.Current.Request.Cookies.Remove("YouEx_User");
        }
    }
}