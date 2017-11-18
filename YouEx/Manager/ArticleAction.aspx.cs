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
    public partial class ArticleAction : Tool.AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int atcid = Convert.ToInt32(Request.QueryString["atcid"]);
            TextBox_CreateTime.Text = System.DateTime.Now.ToLongDateString();
            if (!IsPostBack)
            {
                if (atcid != 0)
                {
                    DataInfo news = (new NewsService()).GetNewsInfo(atcid);
                    DropDownList_NewsType.SelectedValue = news["Type"].ToString();
                    TextBox_TitleName.Text = news["Title"].ToString();
                    TextBox_CreateTime.Text = news["CreateTime"].ToString();
                    TextBox_AuthorName.Text = news["AuthorName"].ToString();
                    TextBox_Label.Text = news["MetaKey"].ToString();
                    TextBox_Description.Text = news["Description"].ToString();
                    TextBox_Hidden_Content.Text = news["Content"].ToString();
                }
            }
        }

        protected void AddArticle_Click(object sender, EventArgs e)
        {
            DataInfo article = new DataInfo();
            article["Type"] = Request.Form[DropDownList_NewsType.UniqueID];
            article["Title"] = TextBox_TitleName.Text;
            article["CreateTime"] = TextBox_CreateTime.Text;
            article["AuthorName"] = TextBox_AuthorName.Text;
            article["MetaKey"] = TextBox_Label.Text;
            article["Description"] = TextBox_Description.Text;
            article["Content"] = TextBox_Hidden_Content.Text;
            int result = (new NewsService()).CreateNews(article);

            if (result > 0)
            {
                Response.Redirect("ArticleCenter.aspx?articlepage=1");
            }
        }

        protected void UpdateArticle_Click(object sender, EventArgs e)
        {
            int atcid = Convert.ToInt32(Request.QueryString["atcid"]);
            DataInfo article = (new NewsService()).GetNewsInfo(atcid);
            article["Type"] = Request.Form[DropDownList_NewsType.UniqueID];
            article["Title"] = TextBox_TitleName.Text;
            article["UpdateTime"] = TextBox_CreateTime.Text;
            article["AuthorName"] = TextBox_AuthorName.Text;
            article["MetaKey"] = TextBox_Label.Text;
            article["Description"] = TextBox_Description.Text;
            article["Content"] = TextBox_Hidden_Content.Text;
            bool result = (new NewsService()).UpdateNews(atcid,article);
            if (result)
                Response.Redirect("ArticleCenter.aspx?articlepage=1");
            else
                Response.Redirect("ArticleCenter.aspx?atcid=" + atcid);
        }

        protected void CancelArticle_Click(object sender, EventArgs e)
        {
            Response.Redirect("ArticleCenter.aspx?articlepage=1");
        }
    }
}