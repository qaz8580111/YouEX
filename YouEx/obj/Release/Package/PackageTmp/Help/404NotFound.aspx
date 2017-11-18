<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="404NotFound.aspx.cs" Inherits="WebSite.Help._404NotFound" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .button{width:100px; height:30px; background-color:#1a9dd1; margin-bottom:40px; line-height:30px; 
                text-align:center; border-radius:2px; margin-left:750px;cursor: pointer;margin-top: 50px;}
    </style>
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-404</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <img src="../Images/Pic_Main/404.jpg" style="margin-left: auto;margin-right: auto;" />
    <div class="button">返回</div>

    <script>
        $(".button").click(function () {
            location.href = "javascript:history.back();";
        })
    </script>

</asp:Content>
