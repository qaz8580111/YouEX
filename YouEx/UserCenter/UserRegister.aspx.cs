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
using YouExLib.Common;

namespace WebSite.UserCenter
{
    using DataInfo = Dictionary<string,object>;
    public partial class UserRegister : System.Web.UI.Page
    {
        protected string encryptKey = "IZjE2H/lNwnHFC6L1hKmyUneNL0NZ6QxXHQ3lpjemHI=";
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        //用户注册帐户并创建账户
        protected void UserRegister_Content(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string respassword = MD5(getTransferString(TB_Rg_Pwd.Text));
                    string email = getTransferString(TB_Rg_Email.Text);
                    string mobile = getTransferString(TB_Rg_Mobile.Text);
                    DataInfo userinfo = new DataInfo();
                    userinfo["Type"] = Convert.ToInt32(DataField.User_Type.UnAction);
                    userinfo["Status"] = 0;
                    userinfo["RealName"] = getTransferString(TB_Rg_RealName.Text);
                    userinfo["FirstName"] = getTransferString(TB_Rg_FirstName.Text);
                    userinfo["LastName"] = getTransferString(TB_Rg_SecondName.Text);
                    userinfo["Password"] = respassword;
                    if(email != "")
                        userinfo["Email"] = email;
                    if (mobile != "")
                        userinfo["Mobile"] = mobile;
                    userinfo["RegIP"] = Request.UserHostAddress;
                    userinfo["RegTime"] = System.DateTime.UtcNow.ToString();
                    userinfo["LastIp"] = Request.UserHostAddress;
                    userinfo["LastLogin"] = System.DateTime.UtcNow.ToString();
                    userinfo["LoginTimes"] = 1;
                    userinfo["StorageNo"] = (new CodeService()).GetStorageNo(1);
                    IUserCenter user = YouExService.GetIUserCenter();
                    int resid = user.RegisterUser(userinfo);
                    if (resid > 0)
                    {
                        IUserAccount ua = YouExService.GetIUserAccount();
                        DataInfo account = new DataInfo();
                        account["Name"] = (new UserService()).GetUserInfo(resid)["UserNo"].ToString();
                        account["CurrencyCode"] = "CNY";
                        account["Default"] = 1;
                        account["Status"] = 1;
                        account["Money"] = 0;
                        account["Frozen"] = 0;
                        account["Credit"] = 0;
                        account["FlyMoney"] = 0;
                        account["Score"] = 0;
                        int result_account = ua.AddUserAccount(resid, account);
                        if (result_account > 0)
                        {
                            if (email != "")
                            {
                                HttpCookie cookie = new HttpCookie("YouEx_User");
                                cookie["UserId"] = resid.ToString();
                                cookie["UserName"] = email;
                                cookie["Password"] = DES.Encode(getTransferString(TB_Rg_Pwd.Text), encryptKey);
                                cookie["ValidateMinutes"] = "1440";
                                cookie.Expires = DateTime.Now.AddMinutes(1440);
                                HttpContext.Current.Response.AppendCookie(cookie);

                                Page.ClientScript.RegisterStartupScript(ClientScript.GetType(), "",
                                    "<script>alert('注册成功');location.href='./EmailActivation.aspx';</script>");
                            }

                            if (mobile != "")
                            {
                                HttpCookie cookie = new HttpCookie("YouEx_User");
                                cookie["UserId"] = resid.ToString();
                                cookie["UserName"] = mobile;
                                cookie["Password"] = DES.Encode(getTransferString(TB_Rg_Pwd.Text), encryptKey);
                                cookie["ValidateMinutes"] = "1440";
                                cookie.Expires = DateTime.Now.AddMinutes(1440);
                                HttpContext.Current.Response.AppendCookie(cookie);

                                Page.ClientScript.RegisterStartupScript(ClientScript.GetType(),"",
                                    "<script>alert('注册成功');location.href='./MobileActivation.aspx';</script>");
                                //Response.Redirect("./MobileActivation.aspx");
                            }
                        }
                    }
                    else
                    {
                        Response.Write("<script type='text/javascript'>alert('注册失败，请重新注册');</script>");
                    }
                }
                catch { }
            }
        }

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\","<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&/=()]", "");
            return result_transfer;
        }

        //MD5加密
        protected static string MD5(string toCryString)
        {
            return System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(toCryString, "MD5");
        }

        //获取随机库位码
        protected string getStorageNo()
        {
            Random r = new Random();
            string result = ((char)r.Next(65, 90)).ToString() + r.Next(1000, 9999).ToString();
            for (int i = 0; getUserByStorageNo(result) != null; i++)
            {
                result = ((char)r.Next(65, 90)).ToString() + r.Next(1000, 9999).ToString();
            }
            return result;
        }

        //根据库位码获取用户信息
        protected DataInfo getUserByStorageNo(string storageno)
        {
            IUserCenter uc = YouExService.GetIUserCenter();
            DataInfo userinfo = uc.GetUserByStorageNo(storageno);
            return userinfo;
        }



    }
}