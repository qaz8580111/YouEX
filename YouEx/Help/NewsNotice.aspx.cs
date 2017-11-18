using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using YouExLib.Service;
using YouExLib.Data;

namespace WebSite.Help
{
    using DataInfo = Dictionary<string, object>;
    public partial class NewsNotice : Tool.UserPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string typeid = Request.QueryString["typeid"];
                string newsid = Request.QueryString["newsid"];
                int newsofpage = Convert.ToInt32((new NewsService()).GetNewsListPage(5, 1, Convert.ToInt32(typeid))[0]["NewsId"]);                
                if (newsid != null)
                {
                    newsofpage = Convert.ToInt32(newsid);
                    typeid = (new NewsService()).GetNewsInfo(newsofpage)["Type"].ToString();
                }
                Label_HideStrItemFinal.Text = Literal_News.Text;
                Label_HideStrItemFinalComment.Text = Literal_Comment.Text;
                Label_Hidden_WhichPage.Text = typeid;
                //判断新闻类型页面
                if (typeid == null)
                    GetNewsType();
                if (typeid == "1")
                    GetNewsType(1);
                if (typeid == "2")
                    GetNewsType(2);
                if (typeid == "3")
                    GetNewsType(3);   
                Label_IsPage.Text = "1";
                Label_IsPage_Comment.Text = "1";

                //头像和评论
                DataInfo user = (new UserService()).GetUserInfo(userId);
                if (user["Birthday"].ToString() != "")
                    Image_MyAvatar.ImageUrl = string.Concat("./PageHandler/ImageVirtualSourceFront.aspx?idfront=", user["Birthday"].ToString());
                else
                    Image_MyAvatar.ImageUrl = "../Images/Pic_User/head.png";

                int news_count = (new CommentService()).GetCommentList(newsofpage).Count;                
                DataInfo NewsOfPage = (new NewsService()).GetNewsInfo(newsofpage);
                NewsContent_Title.Text = NewsOfPage["Title"].ToString();
                NewsContent_CreateTime.Text = NewsOfPage["CreateTime"].ToString();
                NewsContent_Author.Text = NewsOfPage["AuthorName"].ToString();
                NewsContent_Content.Text = NewsOfPage["Content"].ToString();
                Label_CountPage_NewsId.Text = newsofpage.ToString();
                Label_CountPage_Comment.Text = (news_count % 2 == 0) ? (news_count / 2).ToString() : ((news_count / 2) + 1).ToString();
                if (Label_CountPage_Comment.Text == "0")
                    Label_CountPage_Comment.Text = "1";
                IList<DataInfo> comments = (new CommentService()).GetCommentListPage(2, 1, newsofpage);
                string str_Comment = "";
                getStrItemCommentPage(str_Comment, comments);
            }

            
        }

        //加载不同类型新闻
        protected void GetNewsType(int Type=0) {
            IList<DataInfo> newses = null;
            if (Type == 0)
                newses = (new NewsService()).GetNewsListPage(5, 1);
            else
                newses = (new NewsService()).GetNewsListPage(5, 1, Type);
            string Item = "";
            getStrItem(Item, newses);
            int log_count = (new NewsService()).GetNewsList(Type).Count;
            Label_CountPage.Text = (log_count % 5 == 0) ? (log_count / 5).ToString() : ((log_count / 5) + 1).ToString();
            if (Label_CountPage.Text == "0")
                Label_CountPage.Text = "1";            
        }

        public void getStrItem(string Item, IList<DataInfo> Newses) {
            foreach (DataInfo news in Newses)
            {
                string strItem = Literal_News.Text;
                strItem = strItem.Replace("newsidHere", news["NewsId"].ToString());
                strItem = strItem.Replace("titleHere", news["Title"].ToString());
                strItem = strItem.Replace("createtimeHere", Convert.ToDateTime(news["CreateTime"]).ToLongDateString());
                strItem = strItem.Replace("contentHere", news["Content"].ToString());
                Item += strItem;
            }
            Literal_News.Text = Item;
        }

        public void getStrItemPage(string Item, IList<DataInfo> Newses)
        {
            foreach (DataInfo news in Newses)
            {
                string strItem = Label_HideStrItemFinal.Text;
                strItem = strItem.Replace("newsidHere", news["NewsId"].ToString());
                strItem = strItem.Replace("titleHere", news["Title"].ToString());
                strItem = strItem.Replace("createtimeHere", Convert.ToDateTime(news["CreateTime"]).ToLongDateString());
                strItem = strItem.Replace("contentHere", news["Content"].ToString());
                Item += strItem;
            }
            Literal_News.Text = Item;
        }

        //评论页数Label_ClickNewsId.Text
        public void getStrItemCommentPage(string Item, IList<DataInfo> Comments)
        {
            int calcu = 1;
            foreach (DataInfo comment in Comments)
            {
                DataInfo user_comment = (new UserService()).GetUserInfo(Convert.ToInt32(comment["UserId"]));
                if (calcu == 1)
                {
                    if (user_comment["Birthday"].ToString() != "")
                        Image_UserAvatar_1.ImageUrl = string.Concat("./PageHandler/ImageVirtualSourceFront.aspx?idfront=", user_comment["Birthday"].ToString());
                    else
                        Image_UserAvatar_1.ImageUrl = "../Images/Pic_User/head.png";
                }
                if (calcu == 2)
                {
                    if (user_comment["Birthday"].ToString() != "")
                        Image_UserAvatar_2.ImageUrl = string.Concat("./PageHandler/ImageVirtualSourceFront.aspx?idfront=", user_comment["Birthday"].ToString());
                    else
                        Image_UserAvatar_2.ImageUrl = "../Images/Pic_User/head.png";
                }

                string strItem = Label_HideStrItemFinalComment.Text;
                strItem = strItem.Replace("commentidHere", comment["CommentId"].ToString());
                strItem = strItem.Replace("realnameHere", user_comment["RealName"].ToString());
                strItem = strItem.Replace("createtimeHere", Convert.ToDateTime(comment["CreateTime"]).ToLongDateString());
                strItem = strItem.Replace("upcountHere", comment["UpCount"].ToString());
                strItem = strItem.Replace("downcountHere", comment["DownCount"].ToString());
                strItem = strItem.Replace("contentHere", comment["Content"].ToString());
                Item += strItem;
                calcu++;
            }
            Literal_Comment.Text = Item;
        }


        

        //首页
        protected void FirstPageClick(object sender, EventArgs e)
        {
            Literal_News.Text = "";
            string strItem = "";            
            string typeid = Request.QueryString["typeid"];

            if (typeid == null)
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, 1);
                string Item = "";
                getStrItemPage(Item, newses);
            }
            if (typeid == "1")
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, 1, 1);
                string Item = "";
                getStrItemPage(Item, newses);
            }
            if (typeid == "2")
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, 1, 2);
                string Item = "";
                getStrItemPage(Item, newses);
            }
            if (typeid == "3")
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, 1, 3);
                string Item = "";
                getStrItemPage(Item, newses);
            }
            Label_IsPage.Text = "1";            
        }

        //上一页
        protected void PrevPageClick(object sender, EventArgs e)
        {
            int prevpage = Convert.ToInt32(Label_IsPage.Text) - 1;
            if (prevpage > 0)
            {
                Literal_News.Text = "";
                string strItem = "";
                string typeid = Request.QueryString["typeid"];
                if (typeid == null)
                {
                    IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, prevpage);
                    string Item = "";
                    getStrItemPage(Item, newses);
                }
                if (typeid == "1")
                {
                    IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, prevpage, 1);
                    string Item = "";
                    getStrItemPage(Item, newses);
                }
                if (typeid == "2")
                {
                    IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, prevpage, 2);
                    string Item = "";
                    getStrItemPage(Item, newses);
                }
                if (typeid == "3")
                {
                    IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, prevpage, 3);
                    string Item = "";
                    getStrItemPage(Item, newses);
                }
                Label_IsPage.Text = prevpage.ToString();
            }
        }

        //下一页
        protected void NextPageClick(object sender, EventArgs e)
        {
            int nextpage = Convert.ToInt32(Label_IsPage.Text) + 1;
            if (nextpage <= Convert.ToInt32(Label_CountPage.Text))
            {
                Literal_News.Text = "";
                string strItem = "";
                string typeid = Request.QueryString["typeid"];
                if (typeid == null)
                {
                    IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, nextpage);
                    string Item = "";
                    getStrItemPage(Item, newses);
                }
                if (typeid == "1")
                {
                    IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, nextpage, 1);
                    string Item = "";
                    getStrItemPage(Item, newses);
                }
                if (typeid == "2")
                {
                    IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, nextpage, 2);
                    string Item = "";
                    getStrItemPage(Item, newses);
                }
                if (typeid == "3")
                {
                    IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, nextpage, 3);
                    string Item = "";
                    getStrItemPage(Item, newses);
                }
                Label_IsPage.Text = nextpage.ToString();
            }
        }

        //末页
        protected void LastPageClick(object sender, EventArgs e)
        {
            int lastpage = Convert.ToInt32(Label_CountPage.Text);
            Literal_News.Text = "";
            string strItem = "";
            string typeid = Request.QueryString["typeid"];
            if (typeid == null)
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, lastpage);
                string Item = "";
                getStrItemPage(Item, newses);
            }
            if (typeid == "1")
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, lastpage, 1);
                string Item = "";
                getStrItemPage(Item, newses);
            }
            if (typeid == "2")
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, lastpage, 2);
                string Item = "";
                getStrItemPage(Item, newses);
            }
            if (typeid == "3")
            {
                IList<DataInfo> newses = (new NewsService()).GetNewsListPage(5, lastpage, 3);
                string Item = "";
                getStrItemPage(Item, newses);
            }
            Label_IsPage.Text = lastpage.ToString();
        }

        //评论首页
        protected void FirstPageCommentClick(object sender, EventArgs e)
        {
            string typeid = Request.QueryString["typeid"];
            string newsid = Request.QueryString["newsid"];
            int newsofpage = Convert.ToInt32((new NewsService()).GetNewsListPage(5, 1, Convert.ToInt32(typeid))[0]["NewsId"]);
            if (newsid != null)
                newsofpage = Convert.ToInt32(newsid);
            Literal_Comment.Text = "";
            string strItem = "";
            IList<DataInfo> comments = (new CommentService()).GetCommentListPage(2, 1, newsofpage);
            getStrItemCommentPage(strItem, comments);
            Label_IsPage_Comment.Text = "1";
            ScriptManager.RegisterClientScriptBlock(UpdatePanel_Comment, GetType(), "FlushUserAvatar", "FlushUserAvatar()", true);
        }

        //评论上一页
        protected void PrevPageCommentClick(object sender, EventArgs e)
        {
            string typeid = Request.QueryString["typeid"];
            string newsid = Request.QueryString["newsid"];
            int newsofpage = Convert.ToInt32((new NewsService()).GetNewsListPage(5, 1, Convert.ToInt32(typeid))[0]["NewsId"]);
            if (newsid != null)
                newsofpage = Convert.ToInt32(newsid);
            int prevpage = Convert.ToInt32(Label_IsPage_Comment.Text) - 1;
            if (prevpage > 0)
            {
                Literal_Comment.Text = "";
                string strItem = "";
                IList<DataInfo> comments = (new CommentService()).GetCommentListPage(2, prevpage, newsofpage);
                getStrItemCommentPage(strItem, comments);
                Label_IsPage_Comment.Text = prevpage.ToString();
            }
            ScriptManager.RegisterClientScriptBlock(UpdatePanel_Comment, GetType(), "FlushUserAvatar", "FlushUserAvatar()", true);            
        }

        //评论下一页
        protected void NextPageCommentClick(object sender, EventArgs e)
        {
            string typeid = Request.QueryString["typeid"];
            string newsid = Request.QueryString["newsid"];
            int newsofpage = Convert.ToInt32((new NewsService()).GetNewsListPage(5, 1, Convert.ToInt32(typeid))[0]["NewsId"]);
            if (newsid != null)
                newsofpage = Convert.ToInt32(newsid);
            int nextpage = Convert.ToInt32(Label_IsPage_Comment.Text) + 1;
            if (nextpage <= Convert.ToInt32(Label_CountPage_Comment.Text))
            {
                Literal_Comment.Text = "";
                string strItem = "";
                IList<DataInfo> comments = (new CommentService()).GetCommentListPage(2, nextpage, newsofpage);
                getStrItemCommentPage(strItem, comments);
                Label_IsPage_Comment.Text = nextpage.ToString();                
            }
            ScriptManager.RegisterClientScriptBlock(UpdatePanel_Comment, GetType(), "FlushUserAvatar", "FlushUserAvatar()", true);
        }

        //评论末页
        protected void LastPageCommentClick(object sender, EventArgs e)
        {
            string typeid = Request.QueryString["typeid"];
            string newsid = Request.QueryString["newsid"];
            int newsofpage = Convert.ToInt32((new NewsService()).GetNewsListPage(5, 1, Convert.ToInt32(typeid))[0]["NewsId"]);
            if (newsid != null)
                newsofpage = Convert.ToInt32(newsid);
            int lastpage = Convert.ToInt32(Label_CountPage_Comment.Text);
            Literal_Comment.Text = "";
            string strItem = "";
            IList<DataInfo> comments = (new CommentService()).GetCommentListPage(2, lastpage, newsofpage);
            getStrItemCommentPage(strItem, comments);
            Label_IsPage_Comment.Text = lastpage.ToString();
            ScriptManager.RegisterClientScriptBlock(UpdatePanel_Comment, GetType(), "FlushUserAvatar", "FlushUserAvatar()", true);
        }

        //发表评论
        protected void SubmitComment(object sender, EventArgs e)
        {
            DataInfo comment = new DataInfo();
            comment["NewsId"] = Label_CountPage_NewsId.Text;
            comment["UserId"] = userId;
            comment["UpCount"] = 0;
            comment["DownCount"] = 0;
            comment["CreateTime"] = System.DateTime.Now;
            comment["Content"] = Request.Form["comment_content"];
            int commentid = (new CommentService()).CreateComment(comment);
            if (commentid > 0)
                Response.Redirect("NewsNotice.aspx?newsid=" + Label_CountPage_NewsId.Text);
            else
                Response.Redirect("ErrorPage.aspx");
        }

    }
}