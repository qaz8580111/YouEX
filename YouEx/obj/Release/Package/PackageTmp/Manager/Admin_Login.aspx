<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_Login.aspx.cs" Inherits="WebSite.Manager.Admin_Login" %>
<%@ Register Assembly="WebSite" Namespace="WebSite.Tool.Control" TagPrefix="nac" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="../Include/CSS/adminlogin.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-管理员登录</title>
</head>
<body>
    <div class="logo"><a href="http://new.fedroad.com" target="_blank" title="FedRoad转运管理系统"><img src="../Images/Pic_Main/logo.png" /></a></div>
    <div id="LoginZone">
    <form id="form1" runat="server">
    <div class="main">	
        <div class="loginfrm">
        <div class="item">用户名：<nac:TextBox ID="usernametb" CanBeNull="必填" runat="server" ValidationGroup="set"
                Width="205px"></nac:TextBox>
        </div>
        <div class="item">密 &nbsp; 码：<nac:TextBox ID="passwordtb" CanBeNull="必填" ValidationGroup="set" 
                TextMode="Password" runat="server" Width="205px"></nac:TextBox>
        </div>
        <div class="yanzheng">
          验证码：
          <nac:TextBox ID="Tb_CheckCode" runat="server" CanBeNull="必填" ValidationGroup="set"></nac:TextBox>
          <img id="imgverify" src="../Help/VerifyCode.aspx" alt="看不清？点击更换" onclick="this.src=this.src+'?';" />
          <asp:Label ID="Label_Hide_Check" runat="server" Text=""></asp:Label>
        </div>
        <div class="item" style="padding-left:50px">
            <asp:ImageButton ID="loginbtn" ImageUrl="../Images/Pic_Main/login.gif" ValidationGroup="set" OnClick="AdminLogin" runat="server" />
        </div>
        </div>
        <div class="info"><asp:Literal ID="Msg" runat="server"></asp:Literal></div>
    </div>
    <div id="footer">
      版权所有&copy; <a href="http://new.fedroad.com" title="FedRoad转运管理系统" target="_blank">Fedroad</a> 转运管理系统 <br />
      <a href="http://new.fedroad.com" title="Fedroad" target="_blank">Fedroad</a> &copy;Copyright 2010-2014 年 Allright Reserved.<br />
         </div>
    </form>
    </div>
</body>
</html>
