<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ArticleCenter.aspx.cs" Inherits="WebSite.Manager.ArticleCenter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="../Include/CSS/articlecenter.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <script type="text/javascript" src="../Include/JS/jquery.min.js"></script>
    <title>联邦转运FedRoad-新闻中心</title>
</head>
<body>
    <form id="form1" runat="server">

        <div class="left">
            <div class="news_type_word">新闻分类</div>
            <div>
                <div class="news_type"><a href="ArticleCenter.aspx?articletype=1&articlepage=1">重要通知</a></div>
                <div class="news_type"><a href="ArticleCenter.aspx?articletype=2&articlepage=1">行业新闻</a></div>
                <div class="news_type"><a href="ArticleCenter.aspx?articletype=3&articlepage=1">最新优惠</a></div>
            </div>
            <div class="news_type_action">
                <div class="add_news"><a href="ArticleAction.aspx">增加新闻</a></div>
                <div class="add_news"><a href="CouponAction.aspx">增加优惠券</a></div>
            </div>
        </div>

        <div class="right">
            <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                <tr class="news_attrubition">
                    <td class="news_id">编号</td>
                    <td class="news_title">新闻标题</td>
                    <td class="news_metakey">关键字</td>
                    <td class="news_descript">描述</td>
                    <td class="news_createtime">发布日期</td>
                    <td class="news_author">发布人</td>
                    <td class="news_action">操作</td>
                </tr>
                <asp:Literal ID="Literal_News" runat="server">
                    <tr class="news_content">
                        <td class="news_id">countidHere</td>
                        <td class="news_title">titleHere</td>
                        <td class="news_metakey">metakeyHere</td>
                        <td class="news_descript">descriptHere</td>
                        <td class="news_createtime">createtimeHere</td>
                        <td class="news_author">authorHere</td>
                        <td class="news_action">
                            <a href="ArticleAction.aspx?atcid=newsidHere">修改</a>
                            <span class="deletenews_newsidHere">删除</span>
                        </td>
                    </tr>
                </asp:Literal>                
            </table>
            <div class="news_page">
                <span class="first_page">首页</span>
                <span class="prev_page">上一页</span>
                <span class="next_page">下一页</span>
                <span class="last_page">末页</span>
                <asp:Label ID="Label_Total" runat="server" Text=""></asp:Label>
            </div>
        </div>

    </form>
    <script>
        var this_page_url = window.location.href;
        $(".first_page").click(function () {
            location.href= this_page_url.split("articlepage=")[0] + "articlepage=1";
        })
        $(".prev_page").click(function () {
            if ((parseInt(this_page_url.split("articlepage=")[1]) - 1)>0)
                location.href = this_page_url.split("articlepage=")[0] + "articlepage=" + (parseInt(this_page_url.split("articlepage=")[1]) - 1);
        })
        $(".next_page").click(function () {
            if (parseInt(this_page_url.split("articlepage=")[1]) < $("#Label_Total").text())
                location.href = this_page_url.split("articlepage=")[0] + "articlepage=" + (parseInt(this_page_url.split("articlepage=")[1])+1);
        })
        $(".last_page").click(function () {
           location.href = this_page_url.split("articlepage=")[0] + "articlepage=" + $("#Label_Total").text();
        })
    </script>
</body>    
</html>
