<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="OperatingTutorial.aspx.cs" Inherits="WebSite.Help.OperatingTutorial" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/operatingtutorial.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-页面介绍</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="content-1">
   <div class="content-box">
            <div class="title">界面介绍</div>
       <img src="../Images/Pic_User/operating1-1.jpg"/>
       <div class="green-box">
             <span class="green-k"></span>
             <span class="green-w">点击绿框可添加一个包裹</span>
             <span class="red-k"></span>
             <span class="red-w">左边红框，框选的范围表示：您要寄到我们仓库的<br />包裹和包裹里所要填的信息</span>
             <span class="blue-k"></span>
             <span class="blue-w">右边蓝框，框选的范围表示：从我们仓库发出，寄<br />到您手中的包裹和每个包裹所需要的服务</span>
       </div>
   </div>
 </div>
  <div class="content-2">
   <div class="content-box">
       <img src="../Images/Pic_User/operating2-1.jpg"/>
       <div class="note-box">
             <div class="title">包裹数量</div>
             <div class="purple-k"></div>
             <div class="purple-w">深蓝色框，框选的地方表示：包裹的数量。<br />
             右边的例子的表示，您有两个包裹要入库，<br />同时要求我们发出两个包裹</div> 
       </div>
   </div>
 </div>
 <div class="content-3">
    <div class="content-box"> 
       <div class="title">包裹预报</div>
       <div class="word">包裹预报：1、是指您事先给我们打个招呼，准备向我们仓库发个包裹。<br />
                          2、在您的包裹没有到达我们仓库前，您不能在我们官网上看到这个包裹的信息<br />
                          3、包裹入库后需要在库存中重新提交发货。
       </div>
       <div class="title-1">预报的一般流程</div>
       <img src="../Images/Pic_User/operating3-1.jpg"/>
    </div>   
 </div>
 <div class="content-4">
     <div class="content-box">
        <div class="title">如何操作</div>
        <div class="word-box">
            请点击<a href="Operation.aspx">操作指南</a>，查看具体操作流程
        </div>
        <img src="../Images/Pic_User/operating4-1.png" />
     </div>
 </div>


</asp:Content>
