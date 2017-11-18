using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Data;
using YouExLib.Interface;
using YouExLib.Service;
using YouExLib.Common;

namespace WebSite.UserCenter
{
    using DataInfo = Dictionary<string, object>;
    public partial class UserAccount : Tool.UserPage
    {
        string billno = "" ;
        protected void Page_Load(object sender, EventArgs e)
        {
            IUserCenter uc = YouExService.GetIUserCenter();
            IUserAccount uac = YouExService.GetIUserAccount();
            DataInfo user = uc.GetUserInfo(userId);
            DataInfo useraccount = uac.GetAccountDefault(userId);
            string str_userItem = Literal_UserInfo.Text;
            str_userItem = str_userItem.Replace("usernameHere", user["FirstName"].ToString());
            str_userItem = str_userItem.Replace("levelHere", getUserLevel(user["Type"].ToString()));
            str_userItem = str_userItem.Replace("emailHere", user["Email"].ToString());
            str_userItem = str_userItem.Replace("mobileHere", user["Mobile"].ToString());
            str_userItem = str_userItem.Replace("moneyHere", useraccount["Money"].ToString());
            str_userItem = str_userItem.Replace("moneyflyHere", useraccount["FlyMoney"].ToString());
            str_userItem = str_userItem.Replace("creditHere", useraccount["Credit"].ToString());
            str_userItem = str_userItem.Replace("frozenHere", useraccount["Frozen"].ToString());
            Literal_UserInfo.Text = str_userItem;

            Label_Charge_Money.Text = useraccount["Money"].ToString();
            Label_Charge_Fmoney.Text = useraccount["FlyMoney"].ToString();
            Label_UserName.Text = user["RealName"].ToString();
            Label_StorageNo.Text = user["StorageNo"].ToString();
            Label_Money.Text = useraccount["Money"].ToString();
            Label_FlyMoney.Text = useraccount["FlyMoney"].ToString();
            Image_Level.ImageUrl = "../Images/Pic_User/" + getUserLevel(user["Type"].ToString());
            if (user["Birthday"].ToString() != "")
                Image_Avatar.ImageUrl = string.Concat("./PageHandler/ImageVirtualSourceFront.aspx?idfront=", user["Birthday"].ToString());
            else
                Image_Avatar.ImageUrl = "../Images/Pic_User/head.png";
        }

        //用户充值
        protected void UserRecharge(object sender, EventArgs e)
        {
            if(Convert.ToInt32(getTransferString(Request.Form["recharge_type"])) == 1)
                Server.Transfer("../Pay/alidirect/alipayto.aspx");
            if (Convert.ToInt32(getTransferString(Request.Form["recharge_type"])) == 2)
                Server.Transfer("../Pay/paypal/payto.aspx");
        }

        //增加用户头像
        protected void Button_Hide_Upload_Click(object sender, EventArgs e)
        {
            DataInfo user = (new UserService()).GetUserInfo(userId);
            //得到图片数据并创建文件信息
            string str = FileUpload_Avatar.PostedFile.FileName;
            string suffix = str.Substring(str.LastIndexOf("."));
            //得到byte数组
            System.IO.Stream fileDataStream = FileUpload_Avatar.PostedFile.InputStream;
            int fileLength = FileUpload_Avatar.PostedFile.ContentLength;
            byte[] fileData = new byte[fileLength];
            fileDataStream.Read(fileData, 0, fileLength);
            //创建文件
            int result_idcard = (new FileService()).CreateFile(1, userId, "Avatar_" + userId, ConvertDateTimeToInt(DateTime.Now).ToString() + suffix, "Temp");
            bool result_issave = (new FileService()).SaveFile(result_idcard, fileData);
            if (result_issave)
            {
                user["Birthday"] = result_idcard;
                (new UserService()).UpdateUser(userId, user);
                Image_Avatar.ImageUrl = string.Concat("./PageHandler/ImageVirtualSourceFront.aspx?idfront=", user["Birthday"].ToString());
            }
        }

        //修改密码
        protected void EditPassword(object sender, EventArgs e)
        {
            string old_password = getTransferString(TB_Password_Old.Text);
            string new_password = getTransferString(TB_Password_New.Text);
            string re_new_password = getTransferString(TB_Password_Renew.Text);
            IUserCenter uc = YouExService.GetIUserCenter();
            string db_password = uc.GetUserInfo(userId)["Password"].ToString();
            string result_editpwd = "修改成功";

            if (new_password != re_new_password)
            {
                result_editpwd = "两次密码输入不一致";
            }
            if (old_password == new_password)
            {
                result_editpwd = "原密码和新密码相同";
            }
            if (db_password != MD5(old_password))
            {
                result_editpwd = "原密码出错";
            }
            if (result_editpwd == "修改成功")
            {
                DataInfo user = uc.GetUserInfo(userId);
                user["Password"] = MD5(new_password);
                bool result_edit_password = uc.UpdateUser(userId, user);
                if (result_edit_password)
                {
                    //记录修改密码日志
                    DataInfo userlog_update = new DataInfo();
                    userlog_update["UserId"] = userId;
                    userlog_update["ActionIp"] = Request.UserHostAddress;
                    userlog_update["CreateTime"] = System.DateTime.UtcNow.ToString();
                    userlog_update["Message"] = "用户修改密码成功";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), (new UserService()).GetStorageNo(userId), DataField.USER_ACTION.Update.ToString(), userlog_update);

                    Response.Cookies["YouEx_User"].Expires = DateTime.Now.AddDays(-1);
                    Page.ClientScript.RegisterStartupScript(GetType(), "", "<script>$('.hide_pwd_notice').text('" + result_editpwd + "');</script>");
                    Response.Redirect("../Help/EditSuccessReLogin.aspx");
                }
            }
            else
                Page.ClientScript.RegisterStartupScript(GetType(), "", "<script>$('.edit_page,.bj').show();;$('.hide_pwd_notice').text('" + result_editpwd + "');</script>");
        }

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&/=()]", "");
            return result_transfer;
        }

        //MD5加密
        protected static string MD5(string toCryString)
        {
            return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(toCryString, "MD5");
        }

        //获取用户不同的等级
        protected string getUserLevel(string type)
        {
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

        //获取时间戳
        public static long ConvertDateTimeToInt(System.DateTime time)
        {
            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1, 0, 0, 0, 0));
            long t = (time.Ticks - startTime.Ticks) / 10000;   //除10000调整为13位      
            return t;
        }

        //传送该页面的值给下个页面
        public string RechargePlace { get { return Request.Form["recharge_place"]; } }
        public string RechargeMoney { get { return getTransferString(TB_Recharge.Text); } }
        public string RechargeBill { get { return billno; } }
    }
}