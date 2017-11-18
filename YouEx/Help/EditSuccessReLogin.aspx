<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="EditSuccessReLogin.aspx.cs" Inherits="WebSite.Help.EditSuccessReLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .error_word{color:black;margin-left: 750px;font-size: 20px;}
        .redirect_word{color:black;margin-left: 750px;font-size: 15px;}
    </style>
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-重新登录</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


     <div>
        <span class="error_word">修改成功，请重新登录</span>
        <div class="redirect_word">正在跳转.....</div>
    </div>


    <script>
        function GoTo() {
            location.href = "../UserCenter/UserLogin.aspx";
        }
        setTimeout("GoTo()", 3000);
    </script> 


</asp:Content>
