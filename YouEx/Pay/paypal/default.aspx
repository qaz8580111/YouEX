<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="YouExPay.Pay.paypal._default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Paypal在线支付</title>
    <link href="/template/default/skins/common.css" rel="stylesheet" type="text/css" />
    <link href="/template/default/skins/pay.css" rel="stylesheet" type="text/css" />
    <script src="/include/js/jquery-1.4.1.min.js" type="text/javascript"></script>
</head>
<body>

    <form id="form1" action="payto.aspx" method="post" target="_blank">
    <div id="content">
        <div class="pd10 center hint">
           当前1元人民币=<%=ExchangeRate%>美元
        </div>
        <table class="pay_table">
           <tr>
              <th>产品名称：</th>
              <td>
                  在线充值</td>
           </tr>
           <tr>
              <th>支付金额：</th>
              <td>$
                  <asp:Literal ID="amountL" runat="server"></asp:Literal>(折合<%=CnyAmount%>元人民币)</td>
           </tr>
           <tr>
              <th>手续费：</th>
              <td><%=ChargeRate * 100%>%
              </td>
           </tr>
           <tr>
              <th>实际需支付金额：</th>
              <td style="font-size:14px; font-weight:bold; color:#f60">
                  $<asp:Label ID="totalPriceL" runat="server"></asp:Label>
               </td>
           </tr>
           <tr>
               <td align="center" colspan="2">
                  <input id="price" name="orderIdtb" type="hidden" runat="server" />
                    <input id="currency_code" name="orderIdtb" type="hidden" runat="server" />
                    <input id="subtn" type="image" src="/images/Paypal/paynow.gif" />
               </td>
           </tr>
        </table>
    </div>

    </form>
</body>
</html>
