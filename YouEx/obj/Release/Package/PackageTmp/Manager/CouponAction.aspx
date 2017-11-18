<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CouponAction.aspx.cs" Inherits="WebSite.Manager.CouponAction" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div>优惠券类型：
            <asp:DropDownList ID="DropDownList" runat="server">
                <asp:ListItem Value="0" Text="--请选择优惠券类型--" Selected="True"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div>赠送指定用户：<asp:TextBox ID="TextBox_User" runat="server"></asp:TextBox></div>
        <div>发放数量：<asp:TextBox ID="TextBox_Amount" runat="server"></asp:TextBox>张/人</div>
        <div>有效期：从今日起至<asp:TextBox ID="TextBox_Date" runat="server"></asp:TextBox>后过期</div>
        <div>备注说明：<asp:TextBox ID="TextBox_Remark" runat="server" TextMode="MultiLine"></asp:TextBox></div>

    </div>
    </form>
</body>
</html>
