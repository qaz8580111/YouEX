<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ToolSize.aspx.cs" Inherits="WebSite.Help.ToolSize" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/toolsize.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-尺码对照</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


      <div class="content">
       <div class="tiltle">海淘购物尺码对照表</div>
     <img src="../Images/Pic_User/xuanxian-1150.png">
     <div class="c1">
       <div class="word">女装上衣尺寸</div>
       <img src="../Images/Pic_User/20145319025326.png" />
     </div>
     <div class="c1">
       <div class="word">女装裤子尺寸</div>
       <img src="../Images/Pic_User/20145319025346.png" />
     </div>
       <div class="last-div"></div>
     <div class="c2">
       <img src="../Images/Pic_User/3.png" />
       <img src="../Images/Pic_User/5.png" />
       <img src="../Images/Pic_User/4.png" />
     </div>
     <div class="c3">
       英寸(in)=2.54CM / 英尺(ft)=30.48C<br /> 
       海外商品实际上比标识尺码略大一些，敬请参考。<br />  
       上述腰围指实际腰身尺寸，并不是裤子的尺码。 <br /> 
       P码:是XS~XXS之间 <br /> 
       部分裤装根据裤长不同，尺码上分为S R L，S为短板，R为正常版，L为加长版
     </div>  
     <div class="c4">
       <div class="word">测量方法</div>
       <img src="../Images/Pic_User/6.png" />
       <img src="../Images/Pic_User/7.png" />
     </div>
     <div class="c5">
     衣服平铺尺寸测量方法:<br /><br /> 
      衣长：衣服后背肩线正中到下摆的垂直距离<br />
      胸围：从BP点(乳点) 绕过肩胛骨测量<br />
      肩宽：两侧肩线之间的距离，无肩线设计的衣服则无法测量肩宽<br />
      领围：衣领跟衣身接缝那一圈的围度<br />
      袖长：肩线到袖口的距离
     </div>
     <div class="c1">
       <div class="word">女鞋尺码换算表</div>
       <img src="../Images/Pic_User/8.png" />
     </div> 
      <div class="c5">
         温馨提示：<br /><br />
        小码(S)、中码(M)、大码(L)标识的指S=5/6、M=7/8、L=9/10 尺码。<br />
        尺码速查表内的尺寸为一般尺寸对比表，根据制造商不同存在一些差异。<br />
        该尺码速查标识的是普通的美国尺码，根据款式和品牌多少存在一些差异。<br />
        部分欧洲尺码和意大利尺码，没有半幅尺寸的请参考括号中的US尺码。<br />
        1.不可抬脚测量（抬脚后，脚长会缩短）；<br />
        2.虽然双脚基本相称，但一般会有一个稍大，要测量大的；
        3.如脚掌较宽或较肥则需要考虑大一号订购。
        4.部分裤子根据裤长不同分为S < R < L，S为短版，R为正常版，L为加长版。
      </div> 
     <div class="c1">
       <div class="word">男装衬衫尺码换算表</div>
       <img src="../Images/Pic_User/9.png" />
     </div> 
     <div class="c1">
       <div class="word">男装裤子尺码换算表</div>
       <img src="../Images/Pic_User/10.png" />
     </div>  
     <div class="c1">
       <div class="word">男鞋尺码换算表</div>
       <img src="../Images/Pic_User/11.png" />
     </div>
     <div class="c1">
       <div class="word">童装尺码换算表</div>
       <img src="../Images/Pic_User/12.png" />
     </div>
     <div class="c1">
       <div class="word">男装便衣尺码换算表</div>
       <img src="../Images/Pic_User/13.png" />
     </div> 
     <div class="c6">
        <img src="../Images/Pic_User/14.png" />
     </div>  
     <div class="c5">
     温馨提示：<br /><br />
     腰围：在髋骨上部沿着自然腰身线条从内衣外进行测量
     </div>     
  </div>
    <script>
        $(".top-nav a").mouseenter(function () {
            $(this).css("color", "#1a9dd1").mouseleave(function () {
                $(this).css("color", "#FFF")
            })
        })
 </script>

</asp:Content>
