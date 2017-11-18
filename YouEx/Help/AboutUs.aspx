<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="WebSite.Help.AboutUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/aboutus.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-关于我们</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


      <div class="content">
          <div class="left">
          <div class="k1">
             <a href="JoinUs.aspx"><div class="word1">加盟</div></a>
             <div class="last-div"></div>
             <div class="heng"></div>
          </div>
          <div class="last-div"></div>
          <div class="k1">
             <a href="Experience.aspx"><div class="word1">历程</div></a>
             <div class="last-div"></div>
             <div class="heng"></div>
          </div>
          <div class="last-div"></div>
          <div class="k1">
             <div class="shu"></div>
             <a href="AboutUs.aspx"><div class="word">关于我们</div></a>
             <div class="san"><img src="../Images/Pic_User/san-6-13.png" /></div>
             <div class="last-div"></div>
             <div class="heng"></div>
          </div>
          <div class="last-div"></div>
          <div class="k1">
             <a href="Distribution.aspx"><div class="word1">网点分布</div></a>
             <div class="last-div"></div>
             <div class="heng"></div>
          </div>
          <div class="last-div"></div>
          <div class="k1">
             <a href="ContactUs.aspx"><div class="word1">联系我们</div></a>
             <div class="last-div"></div>
             <div class="heng"></div>
          </div>          
     </div>
    <div class="right">
         <div class="title">关于我们</div>
         <div class="word2">
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;“FedRoad Logistics” 中文名为“联邦转运”，总部位于美国俄勒冈州波特兰市，是一家经营跨境物流及仓储服务的供应商
。<br />我们承担海铁联运、北美仓储管理、物流配送等业务。是波特兰港务局官方合作企业之一。<br />
<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;随着跨境电子贸易的勃兴，联邦转运提出了跨境电子商务物流仓储解决方案。我们在北美拥有数个大型货物仓储、转运中心，
并<br />配备了一支国际化的、富有经验的专业队伍，为外贸类电商企业和个人提供安全、快速、便捷的物流中转服务。<br />
<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在国内我们是首批跨境电子商务物流试点企业，与USPS、FedEx、DHL、UPS、PDX等公司是国际战略合作伙伴。我们具有独
立<br />快件通关能力以及个人物品保税仓，能够将品质优良的海外商品从免税州安全、快速地送达消费者手中。
      </div>
      <img src="../Images/Pic_User/about-pic2.png" />
  </div>
 </div>

    <div class="bj"></div>
 
   <script>
       $(".banner-bj a,.one").eq(1).hide()
       $(".one").mouseenter(function () {
           $(".one").eq(0).hide()
           $(".one").eq(1).show()
       }).mouseleave(function () {
           $(".one").eq(1).hide()
           $(".one").eq(0).show()
       })


       $(".top-nav a").mouseenter(function () {
           $(this).css("color", "#1a9dd1").mouseleave(function () {
               $(this).css("color", "#FFF")
           })
       })
       $(".last-nav-bj a").mouseenter(function () {
           $(this).css("color", "#1a9dd1").mouseleave(function () {
               $(this).css("color", "#FFF")
           })
       })

       $(".content .left .k1 *").mouseenter(function () {
           $(this).css("color", "#1a9dd1")
       }).mouseleave(function () {
           $(".word1").css("color", "#4c4c4c")
       })
  </script>

</asp:Content>
