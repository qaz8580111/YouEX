using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Data;
using YouExLib.Interface;
using YouExLib.Service;

namespace WebSite.UserCenter
{
    using DataInfo = Dictionary<string, object>;
    public partial class UserEdit : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string issendmsg = Request.QueryString["issendmsg"];
            string isoldmobile = Request.QueryString["isoldmobile"];

            if (!IsPostBack)
            {
                IUserCenter uc = YouExService.GetIUserCenter();
                DataInfo user = uc.GetUserInfo(userId);

                Label_Storage.Text = user["StorageNo"].ToString();
                Tb_RealName.Text = user["RealName"].ToString();
                Tb_FirstName.Text = user["FirstName"].ToString();
                Tb_LastName.Text = user["LastName"].ToString();
                Tb_Email.Text = user["Email"].ToString();
                Rbl_Gender.SelectedValue = user["Gender"].ToString();
                Tb_Mobile.Text = user["Mobile"].ToString();
                Tb_Phone.Text = user["Phone"].ToString();
                Tb_WeiXin.Text = user["WeiXin"].ToString();
                Tb_Remark.Text = user["Remark"].ToString();
            }

            //发送短信验证码
            if (issendmsg != null)
            {
                string mobile = getTransferString(Tb_NewMobile.Text);
                DataInfo msg_t = Message.GetTemplet("RegActive", 1);
                string randstring = (new Random()).Next(100000, 999999).ToString();
                string content_t = msg_t["MessageBody"].ToString().Replace("{$Mobile}", mobile);
                string content = content_t.Replace("{$ActiveCode}", randstring);
                DataInfo msginfo = new DataInfo();
                msginfo["UserId"] = Convert.ToInt32(Request.Cookies["YouEx_User"]["UserId"]);
                msginfo["TempletCode"] = msg_t["Name"].ToString();
                msginfo["KeyString"] = Request.Cookies["YouEx_User"]["UserId"] + randstring;
                msginfo["ValidateTime"] = 30;
                int msgcode = Message.SendSmsMessage(mobile, content, true, msginfo);
                if (msgcode <= 0)
                {
                    Response.ContentType = "text/plain";
                    Response.Write("no");
                    Response.End();
                }
            }

            //是否重复旧手机号码
            if (isoldmobile != null)
            {
                string mobile_input = getTransferString(Tb_NewMobile.Text);
                string mobile_old = (new UserService()).GetUserInfo(userId)["Mobile"].ToString();
                if (mobile_input == mobile_old)
                {
                    Response.ContentType = "text/plain";
                    Response.Write("no");
                    Response.End();
                }
                else {
                    Response.ContentType = "text/plain";
                    Response.Write("yes");
                    Response.End();
                }
            }


        }


        //修改用户资料
        protected void EditUser(object sender, EventArgs e)
        {
            IUserCenter uc = YouExService.GetIUserCenter();
            DataInfo user = uc.GetUserInfo(userId);
            user["RealName"] = getTransferString(Tb_RealName.Text);
            user["FirstName"] = getTransferString(Tb_FirstName.Text);
            user["LastName"] = getTransferString(Tb_LastName.Text);
            user["Email"] = getTransferString(Tb_Email.Text);
            user["Gender"] = Convert.ToInt32(Rbl_Gender.SelectedValue);
            user["Mobile"] = getTransferString(Tb_Mobile.Text);
            user["Phone"] = getTransferString(Tb_Phone.Text);
            user["WeiXin"] = getTransferString(Tb_WeiXin.Text);
            user["Remark"] = getTransferString(Tb_Remark.Text);
            bool result_edit_user = uc.UpdateUser(userId, user);

            //记录修改资料日志
            DataInfo userlog_update = new DataInfo();
            userlog_update["UserId"] = userId;
            userlog_update["ActionIp"] = Request.UserHostAddress;
            userlog_update["CreateTime"] = System.DateTime.UtcNow.ToString();
            userlog_update["Message"] = "用户修改资料成功";
            (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), (new UserService()).GetStorageNo(userId), DataField.USER_ACTION.Update.ToString(), userlog_update);

            if (result_edit_user)
                Response.Write("<script>alert('修改成功');</script>");
        }

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&/=()]", "");
            return result_transfer;
        }

        //修改手机号码
        protected void EditMobile(object sender, EventArgs e)
        {
            string checkcode_t = getTransferString(Tb_CheckCode.Text);
            string checkcode = userId + checkcode_t;
            IList<DataInfo> messages = (new MessageService()).GetValidateMessage(1, 1, userId, "", "", "", checkcode, "", "");
            if (messages.Count > 0)
            {
                DataInfo old_user = (new UserService()).GetUserInfo(userId);
                DataInfo new_user = new DataInfo();
                new_user["Mobile"] = getTransferString(Tb_NewMobile.Text);
                bool result_editmobile = (new UserService()).UpdateUser(userId, new_user);
                if (result_editmobile)
                {
                    //记录修改手机号码日志
                    DataInfo userlog_update = new DataInfo();
                    userlog_update["UserId"] = userId;
                    userlog_update["ActionIp"] = Request.UserHostAddress;
                    userlog_update["CreateTime"] = System.DateTime.UtcNow.ToString();
                    userlog_update["Message"] = "用户修改手机号码成功";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), (new UserService()).GetStorageNo(userId), DataField.USER_ACTION.Update.ToString(), userlog_update);

                    Response.Cookies["YouEx_User"].Expires = DateTime.Now.AddDays(-1);
                    Response.Redirect("../Help/EditSuccessReLogin.aspx");
                }
                else
                    Response.Write("<script>alert('修改失败,手机号重复');</script>");
            }
            else
                Label_HideMsgCode.Text = "验证码错误";
        }

        //修改电子邮箱
        protected void EditEmail(object sender, EventArgs e)
        {
            DataInfo old_user = (new UserService()).GetUserInfo(userId);
            DataInfo new_user = new DataInfo();
            new_user["Email"] = getTransferString(Tb_NewEmail.Text);
            bool result_editemail = (new UserService()).UpdateUser(userId, new_user);
            if (result_editemail)
            {
                //记录修改电子邮箱日志
                DataInfo userlog_update = new DataInfo();
                userlog_update["UserId"] = userId;
                userlog_update["ActionIp"] = Request.UserHostAddress;
                userlog_update["CreateTime"] = System.DateTime.UtcNow.ToString();
                userlog_update["Message"] = "用户修改电子邮箱成功";
                (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), (new UserService()).GetStorageNo(userId), DataField.USER_ACTION.Update.ToString(), userlog_update);

                Response.Cookies["YouEx_User"].Expires = DateTime.Now.AddDays(-1);
                Response.Redirect("../Help/EditSuccessReLogin.aspx");
            }
            else
                Response.Write("<script>alert('修改失败,邮箱重复');</script>");
        }

        //修改微信号码
        protected void EditWeiXin(object sender, EventArgs e)
        {
            DataInfo old_user = (new UserService()).GetUserInfo(userId);
            DataInfo new_user = new DataInfo();
            new_user["WeiXin"] = getTransferString(Tb_NewWeiXin.Text);
            bool result_ediweixin = (new UserService()).UpdateUser(userId, new_user);
            if (result_ediweixin)
            {
                //记录修改微信号码日志
                DataInfo userlog_update = new DataInfo();
                userlog_update["UserId"] = userId;
                userlog_update["ActionIp"] = Request.UserHostAddress;
                userlog_update["CreateTime"] = System.DateTime.UtcNow.ToString();
                userlog_update["Message"] = "用户修改微信号码成功";
                (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), (new UserService()).GetStorageNo(userId), DataField.USER_ACTION.Update.ToString(), userlog_update);

                Response.Redirect("./UserEdit.aspx");
            }
            else
                Response.Write("<script>alert('修改失败');</script>");
        }


    }
}