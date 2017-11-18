<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="payto.aspx.cs" Inherits="YouExPay.Pay.paypal.payto" %>
<%@ Reference Page="~/UserCenter/UserAccount.aspx" %>
<%@ Reference Page="~/Package/PayBill.aspx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Paypal在线支付</title>
    <link href="/template/default/skins/common.css" rel="stylesheet" type="text/css" />
    <link href="/template/default/skins/pay.css" rel="stylesheet" type="text/css" />
    <script src="/include/js/jquery-1.4.1.min.js" type="text/javascript"></script>
</head>
<body>
    <div id="content">
        <table class="pay_table">
            <form id="form1" runat="server">
                <tr>
                    <th>产品名称：</th>
                    <td>在线充值</td>
                </tr>
                <tr>
                    <th>付款金额：</th>
                    <td>￥<asp:Label ID="amountL" runat="server"></asp:Label></td>
                </tr>
            </form>
            <tr>
                <td align="center" colspan="2">
                    <asp:Label ID="lbButton" runat="server"></asp:Label></td>
            </tr>
        </table>
    </div>

</body>
</html>
