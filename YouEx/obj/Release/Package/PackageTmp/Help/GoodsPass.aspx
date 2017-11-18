<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="GoodsPass.aspx.cs" Inherits="WebSite.Help.GoodsPass" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/goodspass.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-通关详情</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="content">
     <div class="tiltle">货物通关</div>
     <img src="../Images/Pic_User/xuanxian-1150.png" />
     <div class="word">
     <div class="t1"> 通关详情
        </div>
        <div class="c1">    
            海淘商品按中国海关规定按进出境个人邮递物品通关。进出境个人邮递物品应以自用、合理数量为限。海关对进出境个人邮递物品的管理原则是：既方便正常往来，照顾个人合理需要，又要限制走私违法活动。
            据此原则，海关规定了个人每次邮寄物品的限值、免税额和禁止、限制邮寄物品的品种。对邮寄进出境的物品，海关依法进行查验，并按章征税或免税放行。因此要以合理自用数量为限，即自用指旅客本人使用、馈赠亲友而非为出售或出租。
            合理数量指海关根据具体情况所确定的正常数量。通关流程如下图示：
        </div>
        <img src="../Images/Pic_User/tihuo.jpg" />
         <div class="t1"> 关于联邦转运（FedRoad）代缴税平台： 
        </div>
        <div class="c1">
            如果产生关税，您须通过联邦转运FedRoad代缴税平台确认并支付关税，完成后我们即通知海关放行派送。
        </div>
       <a href="PayTaxes.aspx"><div class="sign-in">去缴税平台</div></a>

    <div class="button1"><input class="button" type="button" onclick="javascript: history.back(-1) "value="返回上一页" /></div>
    </div>
    </div>

    <script>
        $(".sign-in,.button1").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })        
    </script>

</asp:Content>
