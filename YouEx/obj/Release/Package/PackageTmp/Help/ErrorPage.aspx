<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="WebSite.Help.ErrorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .error_word{color:black;margin-left: 750px;font-size: 20px;}
        .error_word_2{color:black;font-size: 20px;}
        .error_word_3{color:black;margin-left: 700px;font-size: 20px;color:red}
        .last-nav-bj {position:fixed;}
    </style>
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-错误页面</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin-top:50px;">
        <span class="error_word">出错了.....</span>        
    </div>
    <div>
        <span class="error_word_3">3</span><span class="error_word_2">秒后将返回到上一页</span>    
    </div>

    <script>
        function Show() {
            if ($(".error_word_3").text() == 1)
                location.href = "javascript:history.back();";
            else
                $(".error_word_3").text(parseInt($(".error_word_3").text())-1);
        }
        setInterval(Show, 1000);
        
    </script>
</asp:Content>
