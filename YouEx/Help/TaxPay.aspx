<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="TaxPay.aspx.cs" Inherits="WebSite.Help.TaxPay" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/taxpay.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-支付页面</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pay">
        <div class="d1">
           <div class="content">
              <div class="v1">
                  <strong>缴税金额：</strong>
                  <asp:TextBox ID="TB_Recharge" runat="server" Enabled="false" ></asp:TextBox><strong>(人民币)</strong>
              </div>
           </div>    
        </div>
        <div class="last-div"></div>
        <div class="d1">
            <div class="content1">
              <div class="v1">
                  <strong style="float:left;">付款方式：</strong>
                  <div class="alipay_img">
                      <input id="relation_input_23" type="radio" name="recharge_type" value="1" checked="checked" />
                      <label for="relation_input_23"><img src="../Images/Pic_User/zhifubao.png" /></label>
                  </div>
                  <div class="paypal_img">
                      <input id="relation_input_24" type="radio" name="recharge_type" value="2" />
                      <label for="relation_input_24"><img src="../Images/Pic_User/paypal.png" /></label>
                  </div>
              </div>
            </div>    
          </div>
        <div class="last-div"></div>
        <div class="d1">
            <div class="content1">
              <div class="v1">
                  <strong>支付说明：</strong>
                  <div class="alipay_tip">
                      <p>支付宝(http://www.alipay.com)</p>
                      <p>阿里巴巴集团旗下，支付宝(中国)网络技术有限公司。支持60多种国内银行卡，支付操作简单便利。优惠期间免手续费。</p>
                      <p>支付宝充值常见问题：</p>
                      <p>没有支付宝账户，但有网银，可以使用吗？ </p>
                      <p>答：可以。只要您拥有开通网上支付功能的银行卡或信用卡都可使用此方式充值，只需按照页面提示填写相关信息即可。</p>
                      <p>有任何充值方面的问题，请及时和我们联系。</p>
                  </div>
                  <div class="paypal_tip">
                      <p>PayPal（http://www.paypal.com）</p>
                      <p>PayPal在全球190个国家和地区支持多达23种货币进行交易； PayPal为您提供安全高效的一站式支付方案，集国际流行的信用卡，
                          借记卡，电子支票等支付方式与一身。帮助买卖双方解决各种交易过程中的支付难题。</p>
                      <p>目前在跨国交易中超过90%的卖家和超过85% 的买家认可并正在使用 PayPal 电子支付业务。</p>
                      <p>有任何充值方面的问题，请及时和我们联系。</p>
                      <p>请注意：通过PayPal 充值将会收取4%的手续费用。</p>
                  </div>
              </div>
            </div>    
          </div>
          <div class="last-div"></div>
          <div class="d1">
          <asp:Button ID="Button_Recharge" runat="server" Text="提交订单" ValidationGroup="UserRecharge" OnClick="PayTax" />
          </div>
      </div>
    <script>
        $(".alipay_img").click(function () {
            $(".alipay_tip").show();
            $(".paypal_tip").hide();
        })
        $(".paypal_img").click(function () {
            $(".alipay_tip").hide();
            $(".paypal_tip").show();
        })
    </script>
</asp:Content>
