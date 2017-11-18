using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YouExLib.Service;
using YouExLib.Tools;
using YouExLib.Common;
using YouExLib.Data;

namespace WebSite.Tool
{
    using DataInfo = Dictionary<string, object>;
    public class AdminPage : Tool.AdminBasePage
    {
        public AdminPage()
        {
            if (userId < 0)
                System.Web.HttpContext.Current.Response.Redirect("../Manager/Admin_Login.aspx?url=" + RequestX.GetUrl());
            if (userId > 0 && Type != Convert.ToInt32(DataField.User_Type.Admin))
            {
                System.Web.HttpContext.Current.Response.Redirect("../Manager/Admin_Login.aspx?url=" + RequestX.GetUrl());
            }
        }
    }
}