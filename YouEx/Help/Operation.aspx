<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Operation.aspx.cs" Inherits="WebSite.Help.Operation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/operation.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-操作指南</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


     <div class="content">
    <div class="title">操作指南</div>
    <div class="c1">
       <div class="title1">
         <span class="yanse">STEP1.</span>新用户注册或已有账号登录
       </div>
       <div class="content1">
        <img src="../Images/Pic_Main/caozuo-1-1.png" />
        <img class="caozuo-1-2" src="../Images/Pic_Main/caozuo-1-2.png" />
        <img src="../Images/Pic_Main/caozuo-1-4.png" />
        <img class="caozuo-1-2" src="../Images/Pic_Main/caozuo-1-3.png" />
       </div>
    </div>
    <div class="last-div"></div>
    <div class="c2">
       <div class="title1">
         <span class="yanse">STEP2.</span>在<span class="yanse">海外仓库地址</span>获取仓库地址
       </div>
       <div class="title2">
         在海外仓库地址中，找到您所需的地址，点击即可获取相应地址
       </div>
       <div class="content1">
        <img src="../Images/Pic_Main/caozuo-2-1.png" />
        <img class="caozuo-1-2" src="../Images/Pic_Main/caozuo-2-2.png" />
        <img src="../Images/Pic_Main/caozuo-2-4.png" />
        <img class="caozuo-1-2" src="../Images/Pic_Main/caozuo-2-3.png" />
       </div>
    </div>
    <div class="last-div"></div>
    <div class="c3">
       <div class="title1">
         <span class="yanse">STEP3.</span>海外电商网站购物
       </div>
       <div class="title2">
         在下单时收货地址填写<span class="yanse">联邦转运的仓库地址</span>
       </div>
       <div class="content1">
        <img src="../Images/Pic_Main/caozuo-3-1.png" />
       </div>
    </div>
    <div class="last-div"></div>
    <div class="c4">
       <div class="title1">
         <span class="yanse">STEP4.</span>创建新包裹
       </div>
       <div class="title2">
         推荐使用<span class="yanse">称重后自动结算</span>，提高效率（需要确保账户里有足够的余额）
       </div>
       <div class="content1">
        <img src="../Images/Pic_Main/caozuo-4-1.png" />
        <img class="caozuo-1-2" src="../Images/Pic_Main/caozuo-4-2.png" />
        <img src="../Images/Pic_Main/caozuo-4-4.gif" />
        <img class="caozuo-1-2" src="../Images/Pic_Main/caozuo-4-3.png" />
        <img src="../Images/Pic_Main/caozuo-4-5.png" />
        <img class="caozuo-1-2" src="../Images/Pic_Main/caozuo-4-6.png" />
       </div>
    </div>
    <div class="last-div"></div>
    <div class="c5">
       <div class="title1">
         <span class="yanse">STEP5.</span>包裹入库支付费用
       </div>
       <div class="title2">
         支付运费后包裹会出库发往国内
       </div>
       <div class="content1">
            <img class="caozuo5-1" src="../Images/Pic_Main/caozuo-5-1.png" />
            <img class="caozuo-5-2" src="../Images/Pic_Main/caozuo-5-2.png" />
            <img src="../Images/Pic_Main/caozuo-5-3.png" />
            <img src="../Images/Pic_Main/caozuo-5-4.png" style="margin-top:-360px;" />
       </div>
    </div>
    <div class="last-div"></div>
    <div class="c6">
       <div class="title1">
         <span class="yanse">STEP6.</span>到货签收
       </div>
       <div class="title2">
         收货后到<span class="yanse">海淘之家</span>等知名论坛<span class="yanse">晒单</span>，还可以获得优惠券
       </div>
       <div class="content1">
         <img src="../Images/Pic_User/operation-pic8.jpg" />
       </div>
    </div>
</div>
<div class="button1"><input class="button" type="button" onclick="javascript: history.back(-1) "value="返回上一页" /></div>

    <script>
        $(".button").mouseenter(function () {
            $(this).css("text-decoration","underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
    </script>

</asp:Content>
