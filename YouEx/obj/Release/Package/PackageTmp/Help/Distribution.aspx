<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Distribution.aspx.cs" Inherits="WebSite.Help.Distribution" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/distribution.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-网点分布</title>
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
             <a href="AboutUs.aspx"><div class="word1">关于我们</div></a>
             <div class="last-div"></div>
             <div class="heng"></div>
          </div>
          <div class="last-div"></div>
          <div class="k1">
             <div class="shu"></div>
             <a href="Distribution.aspx"><div class="word">网点分布</div></a>
             <div class="san"><img src="../Images/Pic_User/san-6-13.png" /></div>
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
         <div class="title">网点分布</div>
      <img src="../Images/Pic_User/distribution.png" usemap="#distribution" />
      <map name="distribution">
          <area shape="rect" alt="" coords="175,190,204,220" href="../UserCenter/UsaOregon.aspx" target="_blank" />
          <area shape="rect" alt="" coords="40,546,260,583" href="../UserCenter/UsaOregon.aspx" target="_blank" />
          <area shape="rect" alt="" coords="415,194,435,200" href="../UserCenter/ItalyOregon.aspx" target="_blank" />
          <area shape="rect" alt="" coords="570,546,790,585" href="../UserCenter/ItalyOregon.aspx" target="_blank" />
          <area shape="rect" alt="" coords="635,210,655,215" href="../UserCenter/JapanOregon.aspx" target="_blank" />
          <area shape="rect" alt="" coords="300,546,520,583" href="../UserCenter/JapanOregon.aspx" target="_blank" />
      </map>
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
