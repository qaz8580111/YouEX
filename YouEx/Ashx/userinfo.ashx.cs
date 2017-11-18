using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using YouExLib.Data;
using YouExLib.Interface;
using YouExLib.Service;

namespace WebSite.Ashx
{
    using DataInfo = Dictionary<string, object>;
    public class userinfo : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {            
            string edit_userinfo = context.Request.QueryString["edit_userinfo"];
            int countryid = Convert.ToInt32(context.Request.Form["Cvalue"]);
            int provinceid = Convert.ToInt32(context.Request.Form["Pvalue"]);
            string edit_password = context.Request.QueryString["edit_password"];
            string del_user_address = context.Request.QueryString["del_user_address"];
            string checkmobile = context.Request.QueryString["checkmobile"];
            string checkemail = context.Request.QueryString["checkemail"];
            string isenough = context.Request.QueryString["isenough"];
            string resetemail = context.Request.QueryString["resetemail"];
            string checkaddressname = context.Request.QueryString["checkaddressname"];

            #region 获取省份
            if (countryid > 0)
            {
                IAreaCenter ac = YouExService.GetIAreaCenter();
                IList<DataInfo> provinces = ac.GetAreaList(countryid);
                List<DataInfo> provinces_reverse = new List<DataInfo>();
                provinces_reverse = (List<DataInfo>)provinces;
                provinces_reverse.Reverse();
                context.Response.ContentType = "text/plain";
                context.Response.Write(Serialize(provinces_reverse));
                context.Response.End();
            }
            #endregion

            #region 获取城市
            if (provinceid > 0)
            {
                IAreaCenter ac = YouExService.GetIAreaCenter();
                IList<DataInfo> cities = ac.GetAreaList(provinceid);
                List<DataInfo> cities_reverse = new List<DataInfo>();
                cities_reverse = (List<DataInfo>)cities;
                cities_reverse.Reverse();
                context.Response.ContentType = "text/plain";
                context.Response.Write(Serialize(cities_reverse));
                context.Response.End();
            }
            #endregion            

            #region 删除地址
            if (del_user_address != null) {
                int userid = Convert.ToInt32(context.Request.Cookies["YouEx_User"]["UserId"]); 
                IUserAddress ua = YouExService.GetIUserAddress();
                bool result_del_address = ua.DeleteUserAddress(userid,del_user_address);

                if (result_del_address) {
                    //记录删除地址簿日志
                    DataInfo userlog_deladdress = new DataInfo();
                    userlog_deladdress["UserId"] = userid;
                    userlog_deladdress["AddressName"] = del_user_address;
                    userlog_deladdress["CreateTime"] = System.DateTime.UtcNow.ToString();
                    userlog_deladdress["Message"] = "删除地址成功";
                    (new LogService()).CreateLog(Convert.ToInt32(DataField.LOG_TYPE.User), (new UserService().GetStorageNo(userid)), DataField.USER_ACTION.DeleteAddress.ToString(), userlog_deladdress);

                    context.Response.ContentType = "text/plain";
                    context.Response.Write("yes");
                    context.Response.End();
                }
            }
            #endregion
                        
            #region 核对手机号码是否存在
            if (checkmobile != null) {
                IUserCenter uc = YouExService.GetIUserCenter();
                bool result_checkmobile = uc.CheckMobile(checkmobile);
                if (result_checkmobile)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("yes");
                    context.Response.End();
                }
                else
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("no");
                    context.Response.End();
                }
            }
            #endregion

            #region 核对电子邮箱是否存在
            if (checkemail != null) {
                IUserCenter uc = YouExService.GetIUserCenter();
                bool result_checkemail = uc.CheckEmail(checkemail);
                if(result_checkemail)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("yes");
                    context.Response.End();
                }
                else
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("no");
                    context.Response.End();
                }
            }
            #endregion

            #region 核对地址分类名是否重复
            if (checkaddressname != null) {
                int userid = Convert.ToInt32(context.Request.Cookies["YouEx_User"]["UserId"]);
                DataInfo useraddress = (new UserService()).GetUserAddress(userid,checkaddressname);
                if (useraddress != null)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("yes");
                    context.Response.End();
                }
                else
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("no");
                    context.Response.End();
                }
            }
            #endregion



        }








        //用户输入信息转义
        protected string getTransferString(string inputstring)
        {
            inputstring = inputstring.Replace("\\", "<");
            string result_transfer = System.Text.RegularExpressions.Regex.Replace(inputstring, "[ <>|\'\"\\;%&/=()]", "");
            return result_transfer;
        }

        //转为json格式
        public static string Serialize(object o)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Web.Script.Serialization.JavaScriptSerializer json = new System.Web.Script.Serialization.JavaScriptSerializer();
            json.Serialize(o, sb);
            return sb.ToString();
        }

        //随机产生验证码
        public static string CreateAuthStr(int len)
        {
            int number;
            StringBuilder checkCode = new StringBuilder();

            Random random = new Random();

            for (int i = 0; i < len; i++)
            {
                number = random.Next();

                if (number % 2 == 0)
                {
                    checkCode.Append((char)('0' + (char)(number % 10)));
                }
                else
                {
                    checkCode.Append((char)('A' + (char)(number % 26)));
                }

            }

            return checkCode.ToString();
        }

        //判断是否为空
        protected string IsNullAlreadyCost(string str)
        {
            if (str == "")
                str = "0";
            return str;
        }




        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}