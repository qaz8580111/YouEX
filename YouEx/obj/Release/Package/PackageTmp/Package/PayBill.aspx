<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="PayBill.aspx.cs" Inherits="WebSite.Package.PayBill" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/paybill.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-运单付款</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="content">
     <div class="xq">
        <div class="lanse"></div>
        <div class="title">账单详情</div>
        <div class="qian">
           总共需要需要支付：<span><asp:Label ID="Total_Cost" runat="server" Text=""></asp:Label></span>元
        </div>
        <div class="last-div"></div>
        <div class="line"></div>
        <asp:Literal ID="Literal_BillDetail" runat="server">
            <div class="nei">billdetailHere</div>
        </asp:Literal>
        <div class="cheng"></div>
     </div>
     <div class="pay">
        <div class="lanse"></div>
        <div class="title">选择支付方式</div>
         <asp:Literal ID="Literal_PayType" runat="server">
            <div class="yu">
              F币余额：<span>flymoneyHere</span>元
            </div>
            <div class="yu">
              账户余额：<span>amountHere</span>元
            </div>
        </asp:Literal>
        <div class="last-div"></div>
         <div class="line"></div>
        <div class="p0">
            <div class="p1">
               <input id="relation_input_1" type="checkbox" name="cb_money" /><label for="relation_input_1">账户</label><input  name="type_money"  value="0" />
            </div>
            <div class="p2">
               <input id="relation_input_2" type="checkbox" name="cb_flymoney" /><label for="relation_input_2">F币</label><input name="type_flymoney" value="0" />
            </div>
            <div class="p2">
               <input id="relation_input_6" type="checkbox" name="cb_coupon" />
                <label for="relation_input_6">优惠券
                    <select name="type_coupon">
                        <option value="">请选择优惠券</option>
                        <asp:Literal ID="Literal_Coupon" runat="server">
                            couponHere
                        </asp:Literal>
                    </select>
                </label>
            </div>
            <div class="last-div"></div>
            <div class="p3">
                <input id="relation_input_3" type="checkbox" name="cb_bank" /><label for="relation_input_3">平台支付</label><input name="type_bank" value="0" />                
            </div>
            <div class="p3">
                <input id="relation_input_4" type="radio" name="recharge_type"  value="1" checked="checked" />
                <label for="relation_input_4"><img src="../Images/Pic_User/zhifubao.png" /></label>
                <input id="relation_input_5" type="radio" name="recharge_type"  value="2" />
                <label for="relation_input_5"><img src="../Images/Pic_User/paypal.png" /></label>
            </div>
         </div>
         <div class="last-div"></div>
         <div class="cheng"></div>
        </div>

        <div class="last-div"></div>
        <div class="bj"></div>
        <div class="button2">返回</div>
        <input id="Button1" type="button" class="button_paybill" name="" value="付款" runat="server" onclick ="if (!PayBill()) { return false; }" onserverclick="PayBank" />
  </div>
    


    


    <script>
        $("input[name='cb_money']").click(function () {
            var need_money = (parseFloat($("#ctl00_ContentPlaceHolder1_Total_Cost").text()) - (parseFloat($("input[name='type_flymoney']").val()) +
                parseFloat($("input[name='type_bank']").val()))).toFixed(2);
            if ($("input[name='cb_money']").is(":checked")) {
                $("input[name='type_money']").show();
                $("input[name='type_money']").val(need_money);
            }
            else {
                $("input[name='type_money']").hide();
                $("input[name='type_money']").val("0");
            }
        })
        $("input[name='cb_flymoney']").click(function () {
            var need_flymoney = (parseFloat($("#ctl00_ContentPlaceHolder1_Total_Cost").text()) - (parseFloat($("input[name='type_money']").val()) +
                parseFloat($("input[name='type_bank']").val()))).toFixed(2);
            if ($("input[name='cb_flymoney']").is(":checked")) {
                $("input[name='type_flymoney']").show();
                $("input[name='type_flymoney']").val(need_flymoney);
            }
            else {
                $("input[name='type_flymoney']").hide();
                $("input[name='type_flymoney']").val("0");
            }
        })
        $("input[name='cb_coupon']").click(function () {
            if ($("input[name='cb_coupon']").is(":checked"))
                $("select[name='type_coupon']").show();
            else {
                $("select[name='type_coupon']").hide();
                $("select[name='type_coupon'] option").eq(0).prop("selected", "selected");
            }
        })
        $(function () {
            $(".button_paybill").attr("name", window.location.href.split("=")[1]);
        })
        $("input[name='cb_bank']").click(function () {
            var need_bank = (parseFloat($("#ctl00_ContentPlaceHolder1_Total_Cost").text()) - (parseFloat($("input[name='type_money']").val()) +
                parseFloat($("input[name='type_flymoney']").val()))).toFixed(2);
            if ($("input[name='cb_bank']").is(":checked")) {
                $("input[name='type_bank']").show();
                $("input[name='type_bank']").val(need_bank);
            }
            else {
                $("input[name='type_bank']").hide();
                $("input[name='type_bank']").val("0");
            }
        })
        $(".button2").click(function () {
            location.href = "./NewMyStock.aspx?ordertype=delivery_paybill";
        })
        
    </script>

</asp:Content>
