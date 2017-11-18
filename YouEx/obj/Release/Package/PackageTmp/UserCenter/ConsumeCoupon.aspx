<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ConsumeCoupon.aspx.cs" Inherits="WebSite.UserCenter.ConsumeCoupon" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/consumecoupon.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-我的优惠券</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="last-div"></div>
  <div class="top-title">
    <div>财务管理</div>
  </div>
  <div class="main-nav">
    <div class="word">
      <a href="ConsumeRecordSale.aspx"><dl class="a1">我的账单</dl></a>
      <a href="ConsumeRecordDebit.aspx"><dl class="a2">增值服务</dl></a>
      <a href="ConsumeRecordRecharge.aspx"><dl class="a3">充值记录</dl></a>
      <a href="ConsumeCoupon.aspx"><dl class="a4">我的优惠券</dl></a>
      <a href="ConsumeRefund.aspx"><dl class="a5">申请退款</dl></a>
    </div>
      <div class="last-div"></div>
    <div class="line1"> </div>
    <div class="line2"></div>
  </div>
  <div class="content">
     <div class="last-div"></div>
     <div class="content-nav">
          <div class="box1"><a href="ConsumeCoupon.aspx">可用优惠券</a></div>
          <div class="box2"><a href="ConsumeCoupon.aspx?couponstatus=1">已使用优惠券</a></div>
          <div class="box3"><a href="ConsumeCoupon.aspx?couponstatus=2">已过期优惠券</a></div>
     </div>
     <div class="last-div"></div>
     <div class="sub-content" style="margin-top: 30px;">
         <div class="kuang">
             <div class="k1">
                <div class="w1">优惠券名称</div>
                <div class="w2">优惠券金额</div>
                <div class="w3">创建时间</div>
                <div class="w3">过期时间</div>
                <div class="w4">获取来源</div>
             </div>
             <div class="last-div"></div>
             <asp:Label ID="Label_HideStrItemFinal" runat="server" Text="" CssClass="hidestritemfinal"></asp:Label>
             <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                 <ContentTemplate>
                    <div class="k2">
                        <asp:Literal ID="Literal_Coupon" runat="server">
                            <div class="w1">couponnameHere</div>
                            <div class="w2">couponvalueHere</div>
                            <div class="w3">couponinvalidtimeHere</div>
                            <div class="w3">couponinvalidtimeHere</div>
                            <div class="w4">sourceHere</div>
                        </asp:Literal>
                     </div>
                     <div class="page_action">
                        <asp:Button ID="Button_FirstPage" runat="server" Text="首页" OnClick="FirstPageClick" />
                        <asp:Button ID="Button_PrevPage" runat="server" Text="上一页" OnClick="PrevPageClick" />
                        <asp:Button ID="Button_NextPage" runat="server" Text="下一页" OnClick="NextPageClick" />
                        <asp:Button ID="Button_LastPage" runat="server" Text="末页" OnClick="LastPageClick" />
                        <asp:TextBox ID="TextBox_Page" runat="server"></asp:TextBox>
                        <asp:Label ID="Label_IsPage" runat="server" Text=""></asp:Label>/<asp:Label ID="Label_CountPage" runat="server" Text=""></asp:Label>
                        <asp:Button ID="Button_Redirect" runat="server" Text="GO" OnClick="RedirectClick" />
                    </div>
                 </ContentTemplate>
             </asp:UpdatePanel>             
        </div>                
        
  </div>
  </div>
   <div class="last-div"></div>
    <asp:Label ID="Label_CouponStatus" runat="server" Text="" CssClass="hide_couponstatus"></asp:Label>
    <div class="return-button-box">
        <div class="button2"> 返回</div>
    </div>
    <div class="last-div"></div>

    <script>
        $(".button2").click(function(){
            location.href = "UserCenter.aspx";
        })
        if ($("#ctl00_ContentPlaceHolder1_Label_CouponStatus").text() == 0)
            $(".box1").css("background-color", "#e6e6e6");
        if ($("#ctl00_ContentPlaceHolder1_Label_CouponStatus").text() == 1)
            $(".box2").css("background-color", "#e6e6e6");
        if ($("#ctl00_ContentPlaceHolder1_Label_CouponStatus").text() == 2)
            $(".box3").css("background-color", "#e6e6e6");
        function CheckPageCss() {
            
        }
        $(".button2,#ctl00_ContentPlaceHolder1_Button_Redirect").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
    </script>
</asp:Content>
