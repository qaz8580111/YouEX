<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Track.aspx.cs" Inherits="WebSite.Package.Track" EnableEventValidation="False" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/packagetrack.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-物流跟踪</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content">

     <div class="title">包裹跟踪</div>
     <img src="../Images/Pic_User/waybill-big.png"/>    

<asp:Literal ID="Literal_Track" runat="server">

     <div class="forward">
        <dl class="f1"></dl>
        <dl class="f2">
          <dl class="line"></dl>
          <dl class="round"></dl>
        </dl>
        <dl class="f3">
          <dl class="line"></dl>
          <dl class="round"></dl>
        </dl>
        <dl class="f4">
          <dl class="line"></dl>
          <dl class="round"></dl>
        </dl>
        <dl class="f5">
          <dl class="line"></dl>
          <dl class="round"></dl>
        </dl>
        <dl class="f6">
          <dl class="line"></dl>
          <dl class="round"></dl>
        </dl>
     </div>
     <div class="last-div"></div>

     <div class="word">
        <dl class="w1">等待入库</dl>
        <dl class="w2">
           <div class="state">包裹入库</div>
           <!--<div class="time">trackoneHere</div>-->
        </dl>
                <dl class="w3">
           <div class="state">处理完成</div>
           <!--<div class="time">tracktwoHere</div>-->
        </dl>
                <dl class="w4">
           <div class="state">等待出库</div>
           <!--<div class="time">trackthreeHere</div>-->
        </dl>
                <dl class="w5">
           <div class="state">运输途中</div>
           <!--<div class="time">trackfourHere</div>-->
        </dl>
                <dl class="w6">
           <div class="state">已经签收</div>
           <!--<div class="time">trackfiveHere</div>-->
        </dl>
     </div>

        <script>
            if (showblueHere == 1) {
                $(".f1").css("background-color", "#1a9dd1");
            }
            if (showblueHere == 2) {
                $(".f1,.f2 *").css("background-color", "#1a9dd1");
            }
            if (showblueHere == 3) {
                $(".f1,.f2 *,.f3 *").css("background-color", "#1a9dd1");
            }
            if (showblueHere == 4) {
                $(".f1,.f2 *,.f3 *,.f4 *").css("background-color", "#1a9dd1");
            }
            if (showblueHere == 5) {
                $(".f1,.f2 *,.f3 *,.f4 *,.f5 *").css("background-color", "#1a9dd1");
            }
            if (showblueHere == 6) {
                $(".f1,.f2 *,.f3 *,.f4 *,.f5 *,.f6 *").css("background-color", "#1a9dd1");
            }
            if (showblueHere == 7) {
                $(".f1,.f2 *,.f3 *,.f4 *,.f5 *,.f6 *,.f7 *").css("background-color", "#1a9dd1");
            }
        </script>

        </asp:Literal>

  </div>
    <div class="last-div"></div>
    <div class="return-button-box" onclick="javascript:history.back();">返回</div>
    
    <script>
        $(".button").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
    </script>    

</asp:Content>
