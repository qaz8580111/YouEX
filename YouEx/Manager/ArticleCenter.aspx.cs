using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Service;

namespace WebSite.Manager
{
    using DataInfo = Dictionary<string, object>;
    public partial class ArticleCenter : Tool.AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string articletype = Request.QueryString["articletype"];
            int articlepage = Convert.ToInt32(Request.QueryString["articlepage"]);
            if (articletype == null)
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(15, articlepage);
                string Item = "";
                int i = 1;
                Literal_News.Text = GetNews(newses, Item, i);
                Label_Total.Text = GetNewsPage();
            }
            if (articletype == "1")
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(15, articlepage, 1);
                string Item = "";
                int i = 1;
                Literal_News.Text = GetNews(newses, Item, i);
                Label_Total.Text = GetNewsPage(1);
            }
            if (articletype == "2")
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(15, articlepage, 2);
                string Item = "";
                int i = 1;
                Literal_News.Text = GetNews(newses, Item, i);
                Label_Total.Text = GetNewsPage(2);
            }
            if (articletype == "3")
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(15, articlepage, 3);
                string Item = "";
                int i = 1;
                Literal_News.Text = GetNews(newses, Item, i);
                Label_Total.Text = GetNewsPage(3);
            }            
        }

        //遍历新闻
        protected string GetNews(IList<DataInfo> News, string Item, int i)
        {
            foreach (DataInfo news in News)
            {
                string strItem = Literal_News.Text;
                strItem = strItem.Replace("newsidHere", news["NewsId"].ToString());
                strItem = strItem.Replace("countidHere", (i++).ToString());
                strItem = strItem.Replace("titleHere", news["Title"].ToString());
                strItem = strItem.Replace("metakeyHere", news["MetaKey"].ToString());
                strItem = strItem.Replace("descriptHere", news["Description"].ToString());
                strItem = strItem.Replace("createtimeHere", Convert.ToDateTime(news["CreateTime"]).ToLongDateString());
                strItem = strItem.Replace("authorHere", news["AuthorName"].ToString());
                strItem = strItem.Replace("contentHere", news["Content"].ToString());
                Item += strItem;
            }
            return Item;
        }

        //得到新闻类型的总页数
        protected string GetNewsPage(int Type=0) {
            int news_total = (new NewsService()).GetNewsList(Type).Count;
            int news_page = news_total / 15;
            if (news_page != 0)
                news_page = news_page + 1;
            if (news_page == 0 || (news_total % 15 == 0 && news_page != 0))
                news_page = 1;
            return news_page.ToString();
        }
    }
}