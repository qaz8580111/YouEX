using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Data;
using YouExLib.Interface;
using YouExLib.Service;
using System.Net;

namespace WebSite.UserCenter
{
    using DataInfo = Dictionary<string,object>;
    public partial class UserCenter : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string isavatar = Request.QueryString["isavatar"];
            //显示用户基本信息
            DataInfo user = getUserInfoByUserId(userId);
            DataInfo useraccount = getUserAccountByUserId(userId);
            Label_RealName.Text = user["RealName"].ToString();
            Image_level.ImageUrl = "../Images/Pic_User/"+getUserLevel(user["Type"].ToString());
            Label_StorageNo.Text = user["StorageNo"].ToString();
            Label_RegTime.Text = user["LastLogin"].ToString();
            Label_Money.Text = useraccount["Money"].ToString();
            Label_FlyMoney.Text = useraccount["FlyMoney"].ToString();
            if(user["Birthday"].ToString() != "")
                Image_Avatar.ImageUrl = string.Concat("./PageHandler/ImageVirtualSourceFront.aspx?idfront=", user["Birthday"].ToString());
            else
                Image_Avatar.ImageUrl = "../Images/Pic_User/head.png";
        }

        //通过用户id获取用户信息
        protected DataInfo getUserInfoByUserId(int userid) {
            IUserCenter uc = YouExService.GetIUserCenter();
            DataInfo user = uc.GetUserInfo(userid);
            return user;
        }

        //通过用户id获取账户信息
        protected DataInfo getUserAccountByUserId(int userid) {
            IUserAccount ua = YouExService.GetIUserAccount();
            DataInfo useraccount = ua.GetAccountDefault(userid);
            return useraccount;
        }

        //获取用户不同的等级
        protected string getUserLevel(string type) {
            string str_level = "";
            switch (type)
            {
                case "2": str_level = "普通.png"; break;
                case "3": str_level = "普通.png"; break;
                case "4": str_level = "高级.gif"; break;
                case "6": str_level = "VIP.gif"; break;
            }
            return str_level;
        }
        
        
    }
}