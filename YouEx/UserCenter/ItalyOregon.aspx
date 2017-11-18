<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ItalyOregon.aspx.cs" Inherits="WebSite.UserCenter.ItalyOregon" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/italyoregon.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-意大利仓库地址</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="last-div"></div>
  <div class="top-title">
    <div>海外仓库地址</div>
  </div>
  <div class="main-nav">
    <div class="word">
      <a href="./UsaOregon.aspx"><dl class="a2">美国仓库</dl></a>
       <a href="./ItalyOregon.aspx"><dl class="a1">意大利仓库</dl></a>
       <a href="./JapanOregon.aspx"><dl class="a1">日本仓库</dl></a>
    </div>
      <div class="last-div"></div>
    <div class="line1"> </div>
    <div class="line2"></div>
  </div>
  <div class="content">
 
   <div class="content-nav">
         <div class="box1">意大利布雷西亚</div>
         </div>
         <div class="last-div"></div>
         <div class="sub-content">     
         <div class="warehouse-address-box">
           <div class="warehouse-address-border">
              <div class="address">
                    <div class="last-div"></div>
                    <div class="ht"></div>
                    <div class="ht" style="display:none"></div>
                    <div class="last-div"></div>
                    <div class="content-border">
                       <div class="word-left">
                         <div class="frist-name">名（IL nome）  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：<asp:Label ID="Label_FirstName" runat="server" Text=""></asp:Label> </div>
                         <div class="city">城市（La Città di）  &nbsp;：BRESCIA </div>
                         <div class="country">国家（Paese）  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;： ITALIA </div>
                         <div class="tel">电话（IL telefono）&nbsp;：0302681563</div>
                       </div>
                       <div class="word-right">
                         <div class="last-name">姓（IL cognome）：<asp:Label ID="Label_LastName" runat="server" Text=""></asp:Label> </div>
                         <div class="state">省（Provincia）&nbsp;&nbsp;&nbsp;&nbsp;：BS</div>
                         <div class="zip-code">邮编（CAP）  ：25125</div>
                       </div>
                       <div class="last-div"></div>
                       <div class="address-line1">地址第一行(Address Line 1)：<span class="address_line_one">VIA ABBIATI LUIGI 3</span><span class="copy_line_one">复制</span></div>
                       <div class="address-line2">地址第二行(Address Line 2)：<span class="address_line_two">Numero civico 3#<asp:Label ID="Label_Storage" runat="server" Text=""></asp:Label></span><span class="copy_line_two">复制</span></div>
                       <div class="help"><div class="word"> 如果对地址有疑问，请点击&nbsp;&nbsp;</div><img src="../Images/Pic_User/yamaxun.png" /></div>
                    </div>
                 </div>
             </div>
          </div>
                   
     </div>
     
     <div class="last-div"></div>
    <div class="here">
          <div class="word1">我们在这里</div>
          <div class="time">工作时间：9：00-19：00（意大利时间）（周一到周六）<br /> 非工作时间送达我仓的包裹，承运方将于下一工作日重新派送</div>
          <div class="last-div"></div> 
          <div class="line3"></div> 
          <div class="map"><img src="../Images/Pic_User/map-yidali.jpg"/></div>    
    </div>
     <div class="bj"></div>
    <div class="shi-address">
    <img src="../Images/Pic_User/shi-address-yidali.jpg">
    <img class="button" src="../Images/Pic_User/shut.png">
    </div> 
    <input class="button2" type="button" onclick="javascript: history.back(-1) "value="返回">
  <script>
      $(".warehouse-address-border .help img").click(function () {
          $(".shi-address,.bj").show()
      })
      $(".shi-address .button").click(function () {
          $(".shi-address,.bj").hide()
      })
      $(".button2").click(function () {
          location.href = "UserCenter.aspx";
      })
      $(".button2,.copy_line_one,.copy_line_two").mouseenter(function () {
          $(this).css("text-decoration", "underline");
      }).mouseleave(function () {
          $(this).css("text-decoration", "none");
      })

      $(".copy_line_one").zclip({
          path: '../Include/JS/ZeroClipboard.swf',
          copy: function () {
              return $('.address_line_one').text();
          },
          afterCopy: function () {
              alert('复制成功');
          }
      });
      $(".copy_line_two").zclip({
          path: "../Include/JS/ZeroClipboard.swf",
          copy: function () {
              return $(".address_line_two").text();
          },
          afterCopy: function () {
              alert('复制成功');
          }
      });
 </script>


</asp:Content>
