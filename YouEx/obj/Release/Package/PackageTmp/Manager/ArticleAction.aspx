<%@Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeBehind="ArticleAction.aspx.cs" Inherits="WebSite.Manager.ArticleAction" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="../Include/CSS/articleaction.css"  />
    <script type="text/javascript" src="../Include/JS/jquery.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Tool/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Tool/ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="../Tool/ueditor/lang/zh-cn/zh-cn.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
            
        <div>新闻分类：
            <asp:DropDownList ID="DropDownList_NewsType" runat="server">
                <asp:ListItem Value="1" Text="--重要通知--" Selected="True"></asp:ListItem>
                <asp:ListItem Value="2" Text="--行业新闻--"></asp:ListItem>
                <asp:ListItem Value="3" Text="--最新优惠--"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div>新闻标题：<asp:TextBox ID="TextBox_TitleName" runat="server" ValidationGroup="AddArticle"></asp:TextBox></div>
        <div>新闻日期：<asp:TextBox ID="TextBox_CreateTime" runat="server"></asp:TextBox></div>
        <div>作者：<asp:TextBox ID="TextBox_AuthorName" runat="server" Text="Admin"></asp:TextBox></div>
        <div>关键字：<asp:TextBox ID="TextBox_Label" runat="server"></asp:TextBox></div>
        <div>描述：<asp:TextBox ID="TextBox_Description" runat="server"></asp:TextBox></div>
        <div>正文内容：</div>
        <script id="editor" type="text/plain" style="width:1024px;height:500px;"></script>
        <script>var ue = UE.getEditor('editor');</script>
        <asp:TextBox ID="TextBox_Hidden_Content" runat="server"></asp:TextBox>
        <div>
            <asp:Button ID="Button_Add" runat="server" Text="添加" OnClick="AddArticle_Click" ValidationGroup="AddArticle" OnClientClick="if(!addcontent()){return false;}" />
            <asp:Button ID="Button_Update" runat="server" Text="更新" OnClick="UpdateArticle_Click" OnClientClick="if(!updatecontent()){return false;}" />
            <asp:Button ID="Button_Cancel" runat="server" Text="返回" OnClick="CancelArticle_Click"  />
        </div>

    </form>
</body>
    <script>
        if (window.location.href.indexOf("?atcid") > 0) {
            $("#Button_Add").hide();
            $("#Button_Update").show();
        } else {
            $("#Button_Add").show();
            $("#Button_Update").hide();
        }
        function addcontent() {
            var str = UE.getEditor('editor').getContent();
            $("#TextBox_Hidden_Content").val(str);
            if ($("#TextBox_Hidden_Content").val() != "")
                return true;
            else
                return false;
        }
        function updatecontent() {
            var str = UE.getEditor('editor').getContent();
            $("#TextBox_Hidden_Content").val(str);
            if (str != "")
                return true;
            else
                return false;
        }
        function writeinontent(isAppendTo) {
            var str = $("#TextBox_Hidden_Content").val();
            if (str != "") {
                UE.getEditor('editor').setContent(str);
            }
            return false;
        }
        var delay_time = setTimeout(function () {
            writeinontent();
        }, 500);
        clearTimeout(test)
    </script>
</html>
