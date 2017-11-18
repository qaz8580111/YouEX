<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="WebSite.Help.Help" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/help.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-帮助中心</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content">
     <div class="title">帮助中心</div>
     <div class="line"></div>
       <div class="big-box">
             <div class="box1">
               <div class="box-title">联邦转运</div>
               <div class="box-title2">-&nbsp;新闻中心&nbsp;-</div>
               <img src="../Images/Pic_User/news-tubiao.png"/>
             </div>
             <div class="box2">
               <a href="NewsNotice.aspx?typeid=1"><div class="w0">重要通知</div></a>
               <a href="NewsNotice.aspx?typeid=2"><div class="w1">行业新闻</div></a>
               <a href="NewsNotice.aspx?typeid=3"><div class="w1">最新优惠</div></a>
             </div>
             <div class="last-div"></div>
       </div>
       <div class="big-box2">
             <div class="box1">
               <div class="box-title">联邦转运</div>
               <div class="box-title2">-&nbsp;新手指南&nbsp;-</div>
               <img src="../Images/Pic_User/shop-tubiao.png"/>
             </div>
             <div class="box2">
               <a href="Operation.aspx"><div class="w0">操作指南</div></a>
               <a href="Shopping.aspx"><div class="w1">如何购物</div></a>
             </div>
       </div>

       <div class="big-box3">
             <div class="box1">
               <div class="box-title">联邦转运</div>
               <div class="box-title2">-&nbsp;常见问题&nbsp;-</div>
               <img src="../Images/Pic_User/help-tubiao.png"/>
             </div>
             <div class="box2">
               <a href="Customs.aspx"><div class="w0">报关指南</div></a>
               <a href="FQA.aspx"><div class="w1">用户答疑</div></a>
               <a href="GoodsPass.aspx"><div class="w1">货物通关</div></a>
               <a href="Integral.aspx"><div class="w1">会员积分</div></a>
               <a href="Embargo.aspx"><div class="w1">禁运物品</div></a>
             </div>
             <div class="last-div"></div>
       </div>
       <div class="big-box4">
             <div class="box1">
               <div class="box-title">联邦转运</div>
               <div class="box-title2">-&nbsp;服务条款&nbsp;-</div>
               <img src="../Images/Pic_User/fuwu-tubiao.png"/>
             </div>
             <div class="box2">
               <a href="TaxRate.aspx"><div class="w0">免税州税率</div></a>
               <a href="Disclaimer.aspx"><div class="w1">免责声明</div></a>
               <a href="Description.aspx"><div class="w1">理赔条款</div></a>
               <a href="GoGlobal.aspx"><div class="w1">去泡操作</div></a>
             </div>
       </div>       
  </div>


    <script>
        $(".content .w0,.content .w1").mouseenter(function () {
            $(this).css("color", "#116172").mouseleave(function () {
                $(this).css("color", "#4ab0c6")
            })
        })
        $(function () { $(".last-nav-bj").css("position","inherit");})
  </script>

</asp:Content>
