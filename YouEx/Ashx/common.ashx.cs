using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YouExLib.Service;

namespace WebSite.Ashx
{
    using DataInfo = Dictionary<string, object>;
    public class common : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            int atcid = Convert.ToInt32(context.Request.QueryString["atcid"]);
            string upcount = context.Request.QueryString["upcount"];
            string downcount = context.Request.QueryString["downcount"];

            #region 获取新闻内容
            if (atcid > 0)
            {
                DataInfo news = (new NewsService()).GetNewsInfo(atcid);
                context.Response.ContentType = "text/plain";
                context.Response.Write(Serialize(news));
                context.Response.End();
            }
            #endregion

            #region 点赞统计
            if (upcount != null)
            {
                int commentid = Convert.ToInt32(upcount.Split('_')[0]);
                DataInfo comment = (new CommentService()).GetComentInfo(commentid);
                comment["UpCount"] = upcount.Split('_')[1];
                bool result_upcount = (new CommentService()).UpdateComment(commentid,comment);
                if (result_upcount)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("yes");
                    context.Response.End();
                }
            }
            #endregion

            #region 被踩统计
            if (downcount != null)
            {
                int commentid = Convert.ToInt32(downcount.Split('_')[0]);
                DataInfo comment = (new CommentService()).GetComentInfo(commentid);
                comment["DownCount"] = downcount.Split('_')[1];
                bool result_downcount = (new CommentService()).UpdateComment(commentid,comment);
                if (result_downcount)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("yes");
                    context.Response.End();
                }
            }
            #endregion


        }




        //转为json格式
        public static string Serialize(object o)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.Web.Script.Serialization.JavaScriptSerializer json = new System.Web.Script.Serialization.JavaScriptSerializer();
            json.Serialize(o, sb);
            return sb.ToString();
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