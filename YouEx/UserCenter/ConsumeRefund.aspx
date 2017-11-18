<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ConsumeRefund.aspx.cs" Inherits="WebSite.UserCenter.ConsumeRefund" %>
<%@ Register Assembly="WebSite" Namespace="WebSite.Tool.Control" TagPrefix="nac" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/consumerefund.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-申请退款</title>
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
  <div class="tip">
    <div class="word">注意: 提现申请当日只能提交一次，请谨慎操作。 退款只针对账户余额操作，已购买的F币不支持退款。</div>
  </div>
  <div class="content">
      <div class="c1">
        <div class="word1">退款金额：</div>
          <nac:TextBox ID="Tb_Money" runat="server" CanBeNull="必填" ValidationGroup="RefundMoney"></nac:TextBox>
      </div>
      <div class="last-div"></div>
      <div class="c2">
        <div class="word1">退款方式：</div>
          <nac:TextBox ID="Tb_Type" runat="server" TextMode="MultiLine" CanBeNull="必填" ValidationGroup="RefundMoney"></nac:TextBox>
      </div>
  </div>
  <div class="last-div">
      <div class="tip2">
         <div class="word2"> *若您的充值时间在两个月内，将可按充值原路退回。否则，退款将通过“付款”形式退还，系统将收取4%手续费。</div>
      </div>
        <div class="tip2">
         <div class="word2"> *若您在退款时仍有订单或包裹未支付，为避免您重新充值产生手续费，我们可能会终止您的申请。</div>
      </div>
  </div>
  <div class="yanzheng">
      <div class="word3">验证码：</div>
      <nac:TextBox ID="Tb_CheckCode" runat="server" ValidationGroup="RefundMoney"></nac:TextBox>
      <img id="imgverify" src="../Help/VerifyCode.aspx" alt="看不清？点击更换" onclick="this.src=this.src+'?';" />
      <asp:Label ID="Label_Hide_Check" runat="server" Text=""></asp:Label>
  </div>
  <div class="last-div"></div>
  <div class="return-button-box">
      <nac:Button runat="server" Text="确定" ValidationGroup="RefundMoney" OnClick="RefundMoney" CssClass="button" />
     <a href="UserCenter.aspx"><div class="button2"> 返回</div></a>
  </div>

    <script>
        $(".button2,#ctl00_ContentPlaceHolder1_Button_Redirect,.button").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
    </script>

</asp:Content>
