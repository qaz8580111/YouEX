<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Shopping.aspx.cs" Inherits="WebSite.Help.Shopping" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/shopping.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-购物指南</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="content">
  <div class="title">
     <div class="big">购物指南</div>
     <div class="small">(以亚马逊为例)</div>
     <div class="last-div"></div>
  </div>
  <div class="c1">
     <div class="w1">
     第1步：注册新用户
     </div>
     <img src="../Images/Pic_User/a1.jpg" />
  </div>
  <div class="c1">
     <div class="w1">
     第2步：填写您的注册信息
     </div>
     <img src="../Images/Pic_User/a2.jpg" />
  </div>
  <div class="c1">
     <div class="w1">
     第3步：搜索您需要的商品
     </div>
     <img src="../Images/Pic_User/a3.jpg" />
  </div>
  <div class="c1">
     <div class="w1">
     第4步：添加商品到购物车
     </div>
     <img src="../Images/Pic_User/a4.jpg" />
  </div>
  <div class="c1">
     <div class="w1">
     第5步：去结算
     </div>
     <img src="../Images/Pic_User/a5.jpg" />
  </div>
  <div class="c1">
     <div class="w1">
     第6步：结算时候需要您重新确认登录
     </div>
     <img src="../Images/Pic_User/a6.jpg" />
  </div>
  <div class="c1">
     <div class="w1">
     第7步：输入您的专属仓库地址
     </div>
     <img src="../Images/Pic_User/a7.jpg" />
  </div>
  <div class="c1">
     <div class="w1">
     第8步：选择配送方式
     </div>
     <img src="../Images/Pic_User/a8.jpg" />
  </div>
  <div class="c1">
     <div class="w1">
     第9步：选择支付方式 填写卡片信息
     </div>
     <img src="../Images/Pic_User/a9.jpg" />
  </div>
  <div class="c1">
     <div class="w1">
     第10步：确认支付方式
     </div>
     <img src="../Images/Pic_User/a10.jpg" />
  </div>
  <div class="c1">
     <div class="w1">
     第11步：确认账单寄送地址
     </div>
     <img src="../Images/Pic_User/a11.jpg" />
  </div>
  <div class="c2">
     <div class="w1">
     第12步：最终确认订单信息无误后提交
     </div>
     <img src="../Images/Pic_User/a12.jpg" />
  </div>  
</div>
<div class="button1"><input class="button" type="button" onclick="javascript: history.back(-1) "value="返回上一页" /></div>

    <script>
        $(".button1").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
    </script>

</asp:Content>
