using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Data;
using YouExLib.Interface;
using YouExLib.Service;
using System.IO;
using System.Security.Cryptography;
using System.Net;
using YouExLib.Common;

namespace WebSite.UserCenter
{

    using DataInfo = Dictionary<string, object>;
    public partial class UserLogin : Tool.BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string send_type  = Request.QueryString["send_type"];
            string check_code = Request.QueryString["check_code"];
            if (userId > 0) {
                TB_UserName.Text = userName;
                TB_Password.Attributes.Add("value", password);
                CB_Remember.Checked = true;
            }

            //重置密码：发送验证码到手机
            if (send_type == "mobile") {
                string rd_pwd = new Random().Next(100000, 999999).ToString();
                string mobile = getTransferString(TB_Get_Pwd_Mobile.Text);
                int userid = (new UserService()).GetUserIdByMobile(mobile);
                DataInfo msg_t = Message.GetTemplet("RegActive", 1);
                string content = "您的验证码是：" + rd_pwd;
                DataInfo msginfo = new DataInfo();
                msginfo["UserId"] = userid;
                msginfo["TempletCode"] = "手机重置密码";
                msginfo["KeyString"] = rd_pwd;
                msginfo["ValidateTime"] = 30;
                int result_msg = Message.SendSmsMessage(mobile, content, true, msginfo);
                Response.ContentType = "text/plain";
                Response.Write(result_msg);
                Response.End();
            }

            //重置密码：发送验证码到邮箱
            if (send_type == "email"){
                string rd_pwd = new Random().Next(100000, 999999).ToString();
                string email = getTransferString(TB_Get_Pwd_Email.Text);
                int userid = (new UserService()).GetUserIdByEmail(email);
                DataInfo msg_t = Message.GetTemplet("RegActive", 2);
                string content = "您的验证码是：" + rd_pwd ;
                DataInfo msginfo = new DataInfo();
                msginfo["UserId"] = userid;
                msginfo["TempletCode"] = "邮箱重置密码";
                msginfo["KeyString"] = rd_pwd;
                msginfo["ValidateTime"] = 1440;
                int result_message = Message.SendEmail(email, msg_t["Subject"].ToString(), content, true, msginfo);
                Response.ContentType = "text/plain";
                Response.Write(result_message);
                Response.End();
            }

            //使用忘记密码时，检查手机短信验证码是否正确
            if (check_code != null && check_code != "")
            {
                DataInfo message = (new MessageService()).GetMessage(Convert.ToInt32(check_code));
                if (TB_Check_Code.Text == message["KeyString"].ToString())
                {
                    Response.ContentType = "text/plain";
                    Response.Write("yes");
                    Response.End();
                }
                else {
                    Response.ContentType = "text/plain";
                    Response.Write("no");
                    Response.End();
                }
            }
        }

        protected void UserLogin_Content(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string username = getTransferString(TB_UserName.Text);
                    string ts_password = getTransferString(TB_Password.Text);
                    int cb_agree = Convert.ToInt32(Request.Form["hide_remember"]);
                    int userid = Login(username, ts_password, 1440, cb_agree);                    

                    //记住用户cookie
                    if (userid < 1)
                    {
                        Label_Fail_Login.Text = "帐号或密码输入有误";
                    }
                    else
                    {
                        //修改用户信息
                        DataInfo userinfo = (new UserService()).GetUserInfo(userid);
                        userinfo["LastIp"] = Request.UserHostAddress;
                        userinfo["LastLogin"] = System.DateTime.UtcNow.ToString();
                        userinfo["LoginTimes"] = Convert.ToInt32(userinfo["LoginTimes"])+1;
                        (new UserService()).UpdateUser(userid,userinfo);
                        
                        //记录用户登录日志
                        DataInfo userlog_login = new DataInfo();
                        userlog_login["UserId"] = userid;
                        userlog_login["LoginIp"] = Request.UserHostAddress;
                        userlog_login["LoginTime"] = System.DateTime.UtcNow.ToString();
                        userlog_login["Message"] = "用户登录成功";
                        (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), userinfo["StorageNo"].ToString(), DataField.USER_ACTION.Login.ToString(),userlog_login);
                        bool isinurl = RequestX.GetUrl().Contains("?url=");
                        if (isinurl)                          
                            Response.Redirect(RequestX.GetUrl().Split(new string[] { "?url=" }, StringSplitOptions.RemoveEmptyEntries)[1]);
                        else
                            Response.Redirect("./UserCenter.aspx");
                    }
                }
                catch { }
            }
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

        #region cookies加密&解密
        /// <summary>
        /// DES对称加密方法
        /// </summary>
        /// <param name="InitData">原始待加密数据</param>
        /// <param name="SecretKey">加密密钥</param>
        public static string EncryptData(string InitData, string SecretKey)
        {
            try
            {
                string MySecretKey = "ZGLSGWYH";
                string newSecretKey = MD5(SecretKey + MySecretKey).Substring(16, 8);
                DESCryptoServiceProvider des = new DESCryptoServiceProvider();
                //把字符串放到byte数组中    
                Byte[] inputByteArray = Encoding.Default.GetBytes(InitData.ToString());
                //建立加密对象的密钥和偏移量
                des.Key = ASCIIEncoding.ASCII.GetBytes(newSecretKey);
                //原文使用ASCIIEncoding.ASCII方法的GetBytes方法 
                des.IV = ASCIIEncoding.ASCII.GetBytes(newSecretKey);
                //使得输入密码必须输入英文文本
                MemoryStream ms = new MemoryStream();
                CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write);
                cs.Write(inputByteArray, 0, inputByteArray.Length);
                cs.FlushFinalBlock();
                StringBuilder ret = new StringBuilder();
                foreach (Byte b in ms.ToArray())
                {
                    ret.AppendFormat("{0:X2}", b);
                }
                ret.ToString();
                return ret.ToString();
            }
            catch
            {
                return "";
            }
        }

        /// <summary>
        /// DES对称解密方法
        /// </summary>
        /// <param name="EncryptedData">待解密数据</param>
        /// <param name="SecretKey">解密密钥</param>
        public static string DecryptData(string EncryptedData, string SecretKey)
        {
            try
            {
                string MySecretKey = "ZGLSGWYH";
                string newSecretKey = MD5(SecretKey + MySecretKey).Substring(16, 8);
                string pToDecrypt = EncryptedData.ToString();
                DESCryptoServiceProvider des = new DESCryptoServiceProvider();
                Byte[] inputByteArray = new byte[pToDecrypt.Length / 2];
                for (int x = 0; x < pToDecrypt.Length / 2; x++)
                {
                    int i = (Convert.ToInt32(pToDecrypt.Substring(x * 2, 2), 16));
                    inputByteArray[x] = (byte)i;
                }
                //建立加密对象的密钥和偏移量，此值重要，不能修改 
                des.Key = ASCIIEncoding.ASCII.GetBytes(newSecretKey);
                des.IV = ASCIIEncoding.ASCII.GetBytes(newSecretKey);
                MemoryStream ms = new MemoryStream();
                CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);
                cs.Write(inputByteArray, 0, inputByteArray.Length);
                cs.FlushFinalBlock();
                return System.Text.Encoding.Default.GetString(ms.ToArray());
            }
            catch
            {
                return "";
            }
            //Utils.MD5(SecretKey + MySecretKey).Substring(16, 8);
            //这里的MD5自己写一个,然后随意截取其中8位,MySecretKey=内部密钥
        }
        #endregion

        //电子邮箱重置密码
        protected void ResetPwdEmail(object sender, EventArgs e)
        {
            int userid = (new UserService()).GetUserIdByEmail(TB_Get_Pwd_Email.Text);
            DataInfo old_user = (new UserService()).GetUserInfo(userid);
            old_user["Password"] = MD5(TB_Reset_Pwd.Text);
            bool result_resetpwd = (new UserService()).UpdateUser(userid, old_user);
            if (result_resetpwd)
            {
                //记录用户重置密码日志
                DataInfo userinfo = (new UserService()).GetUserInfo(userid);
                DataInfo userlog_reset = new DataInfo();
                userlog_reset["UserId"] = userid;
                userlog_reset["ActionIp"] = Request.UserHostAddress;
                userlog_reset["ResetTime"] = System.DateTime.UtcNow.ToString();
                userlog_reset["Message"] = "邮箱重置密码成功";
                (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), userinfo["StorageNo"].ToString(), DataField.USER_ACTION.Update.ToString(), userlog_reset);
                Response.Write("<script>alert('密码重置成功');</script>");
            }
            else
            {
                Response.Write("<script>alert('重置失败！');</script>");
            }
        }

        //手机号码重置密码
        protected void ResetPwdMobile(object sender, EventArgs e)
        {
            int userid = (new UserService()).GetUserIdByMobile(TB_Get_Pwd_Mobile.Text);
            DataInfo old_user = (new UserService()).GetUserInfo(userid);
            old_user["Password"] = MD5(TB_Reset_Pwd.Text);
            bool result_resetpwd = (new UserService()).UpdateUser(userid, old_user);
            if (result_resetpwd)
            {
                //记录用户重置密码日志
                DataInfo userinfo = (new UserService()).GetUserInfo(userid);
                DataInfo userlog_reset = new DataInfo();
                userlog_reset["UserId"] = userid;
                userlog_reset["ActionIp"] = Request.UserHostAddress;
                userlog_reset["ResetTime"] = System.DateTime.UtcNow.ToString();
                userlog_reset["Message"] = "手机重置密码成功";
                (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), userinfo["StorageNo"].ToString(), DataField.USER_ACTION.Update.ToString(), userlog_reset);
                Response.Write("<script>alert('密码重置成功');</script>");
            }
            else
                Response.Write("<script>alert('重置失败');</script>");
        }

    }
}