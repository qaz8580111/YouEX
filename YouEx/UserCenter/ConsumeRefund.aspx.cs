using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Data;
using YouExLib.Service;

namespace WebSite.UserCenter
{
    using DataInfo = Dictionary<string,object>;
    public partial class ConsumeRefund : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //用户申请退款
        protected void RefundMoney(object sender, EventArgs e)
        {
            string checkcode = (Session["VerifyCode"].ToString()).ToLower();
            if (checkcode == Tb_CheckCode.Text)
            {
                DataInfo refund = new DataInfo();
                refund["UserId"] = userId;
                refund["Status"] = 1;//1为申请提现,2为处理中,3为已经体现
                refund["ReturnMoney"] = getTransferString(Tb_Money.Text);
                refund["CreateTime"] = DateTime.Now.ToString();
                refund["Message"] = getTransferString(Tb_Type.Text);
                (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.Account), (new UserService()).GetUserInfo(userId)["StorageNo"].ToString(),
                 DataField.ACCOUNT_ACTION.CashReturn.ToString(), refund);

                Response.Write("<script>alert('申请提交成功,请耐心等待');</script>");
            }
            else
                Label_Hide_Check.Text = "请输入正确的验证码";
        }

        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&/=()]", "");
            return result_transfer;
        }

    }
}