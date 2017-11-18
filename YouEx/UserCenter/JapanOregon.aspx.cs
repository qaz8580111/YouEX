using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Service;

namespace WebSite.UserCenter
{
    using DataInfo = Dictionary<string,object>;
    public partial class JapanOregon : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataInfo user = (new UserService()).GetUserInfo(userId);
            Label_FirstName.Text = user["FirstName"].ToString();
            Label_LastName.Text = user["LastName"].ToString();
            Label_Storage.Text = user["StorageNo"].ToString();
        }
    }
}