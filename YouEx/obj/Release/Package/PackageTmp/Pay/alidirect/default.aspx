<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="YouExPay.Pay.alidirect._default" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>支付宝 - 网上支付 安全快速！</title>
    <link href="../template/default/skins/common.css" rel="stylesheet" type="text/css" />
    <link href="../template/default/skins/pay.css" rel="stylesheet" type="text/css" />
    <script src="../include/js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../include/js/maj.common.js" type="text/javascript"></script>
    
	
    <script language="JavaScript" type="text/javascript">
<!--
        var amount=<%=money %>;
        //校验输入框  -->
        function CheckForm() {
            if (document.alipayment.aliorder.value.length == 0) {
                alert("请输入商品名称.");
                document.alipayment.aliorder.focus();
                return false;
            }
            if (document.alipayment.alimoney.value.length == 0) {
                alert("请输入付款金额.");
                document.alipayment.alimoney.focus();
                return false;
            }
            var reg = new RegExp(/^\d*\.?\d{0,2}$/);
            if (!reg.test(document.alipayment.alimoney.value)) {
                alert("请正确输入付款金额");
                document.alipayment.alimoney.focus();
                return false;
            }
            if (Number(document.alipayment.alimoney.value) < 0.01) {
                alert("付款金额金额最小是0.01.");
                document.alipayment.alimoney.focus();
                return false;
            }
        }  
        $(document).ready(function(){
        $("#alimoney").keyup(function(){
           if(amount!=''){
               $("#alimoney").val(amount);
           }
        });
        });
    </script>
</head>
<body>

<div id="content">
       <div class="blank10"></div>
       <div class="orderTit"><img src="/images/pic_order.gif" alt="在线充值" /></div>
       <div class="orderFrm">
       <form name="alipayment" onsubmit="return CheckForm();" action="alipayto.aspx" method="post"
            target="_blank">
       <table class="pay_table">
           <tr>
               <th>收款方：</th>
               <td>

               </td>
           </tr>
           <tr>
               <th><span>*</span>标题：</th>
               <td>
                   <input size="30" id="aliorder" name="aliorder" maxlength="200" value="在线充值" runat="server" /><span>如：7月5日定货款。</span>
               </td>
           </tr>
           <tr>
               <th><span>*</span>付款金额：</th>
               <td>
                   <input maxlength="10" size="30" id="alimoney" name="alimoney" onfocus="if(Number(this.value)==0){this.value='';}" value="00.00" runat="server" />
                   <span>如：112.21</span>
               </td>
           </tr>
           <tr>
               <th valign="top"><span>*</span>备注：</th>
               <td>
                   <textarea id="alibody" name="alibody" rows="4" cols="40" wrap="physical" runat="server"></textarea><br/>
                   <input id="orderIdtb" name="orderIdtb" type="hidden" runat="server" />
                   <span>（如联系方法，商品要求、数量等。100汉字内）</span>
               </td>
           </tr>
           <tr>
            <th valign="top">
                支付方式：</th>
            <td>
                <table>
                    <tr>
                        <td>
                            <input type="radio" name="pay_bank" value="directPay" checked /><img src="/images/Alipay/alipay.gif"
                                border="0" /></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="radio" name="pay_bank" value="ICBCB2C" /><img src="/images/Alipay/ICBC_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="CMB" /><img src="/images/Alipay/CMB_OUT.gif" border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="CCB" /><img src="/images/Alipay/CCB_OUT.gif" border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="BOCB2C"/><img src="/images/Alipay/BOC_OUT.gif"
                                border="0" /></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="radio" name="pay_bank" value="ABC" /><img src="/images/Alipay/ABC_OUT.gif" border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="COMM" /><img src="/images/Alipay/COMM_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="SPDB" /><img src="/images/Alipay/SPDB_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="GDB" /><img src="/images/Alipay/GDB_OUT.gif" border="0" /></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="radio" name="pay_bank" value="CITIC" /><img src="/images/Alipay/CITIC_OUT.gif" 
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="CEBBANK" /><img src="/images/Alipay/CEB_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="CIB" /><img src="/images/Alipay/CIB_OUT.gif" border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="SDB" /><img src="/images/Alipay/SDB_OUT.gif" border="0" /></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="radio" name="pay_bank" value="CMBC" /><img src="/images/Alipay/CMBC_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="HZCBB2C" /><img src="/images/Alipay/HZCB_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="SHBANK" /><img src="/images/Alipay/SHBANK_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="NBBANK" /><img src="/images/Alipay/NBBANK_OUT.gif"
                                border="0" /></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="radio" name="pay_bank" value="SPABANK" /><img src="/images/Alipay/SPABANK_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="BJRCB" /><img src="/images/Alipay/BJRCB_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="ICBCBTB" /><img src="/images/Alipay/ENV_ICBC_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="CCBBTB" /><img src="/images/Alipay/ENV_CCB_OUT.gif"
                                border="0" /></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="radio" name="pay_bank" value="SPDBB2B" /><img src="/images/Alipay/ENV_SPDB_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="ABCBTB" /><img src="/images/Alipay/ENV_ABC_OUT.gif"
                                border="0" /></td>
                        <td>
                            <input type="radio" name="pay_bank" value="fdb101" /><img src="/images/Alipay/FDB_OUT.gif"
                                border="0" /></td>
                        <td><input type="radio" name="pay_bank" value="PSBC-DEBIT" /><img src="/images/Alipay/PSBC_OUT.gif"
                                border="0" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
           <tr>
               <th>&nbsp;</th>
               <td>
                   <input class="btn" type="image" src="/images/Alipay/button_sure.gif" value="确认订单" name="nextstep" />
               </td>
           </tr>
       </table>
        </form>
       </div>
</div>

</body>
</html>
