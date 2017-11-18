using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using YouExLib.Service;
using YouExLib.Tools;
using YouExLib.Common;
using YouExLib.Data;

namespace WebSite.Tool
{
    using DataInfo = Dictionary<string, object>;
    public class UserPage : Tool.BasePage
    {
        /// <summary>
        /// 帐户详细
        /// </summary>

        public UserPage()
        {
            if (userId < 0)
                System.Web.HttpContext.Current.Response.Redirect("../UserCenter/UserLogin.aspx?url=" + RequestX.GetUrl());
            if (userId > 0 && Type == Convert.ToInt32(DataField.User_Type.UnAction))
            {
                DataInfo user = (new UserService()).GetUserInfo(userId);
                if (user["Email"].ToString() != "")
                    System.Web.HttpContext.Current.Response.Redirect("../UserCenter/EmailActivation.aspx");
                if (user["Mobile"].ToString() != "")
                    System.Web.HttpContext.Current.Response.Redirect("../UserCenter/MobileActivation.aspx");
            }
            /*IList<DataInfo> addresses = (new UserService()).GetAddressList(userId);
            if (userId > 0 && Type > 2 && addresses.Count == 0)
            {
                System.Web.HttpContext.Current.Response.Redirect("../UserCenter/UserAddress.aspx");
            }*/
        }
    }
}
