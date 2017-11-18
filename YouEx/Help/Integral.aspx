<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Integral.aspx.cs" Inherits="WebSite.Help.Integral" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/integral.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-积分服务</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


     <div class="content">
     <div class="tiltle">积分服务</div>
     <img src="../Images/Pic_User/xuanxian-1150.png">
     <div class="word">
        <div class="t1">积分获取
        </div>
        <div class="c1">    
        联邦转运（FedRoad）注册会员享受成长机制，系统会根据账户活跃度自动赠送积分。<br>
        同时，会员也可以参与联邦转运（FedRoad）丰富的优惠活动赚取积分。
        </div>
         <div class="t1">积分使用
        </div>
        <div class="c1">    
         联邦转运（FedRoad）积分兑换比例为1积分=1元人民币运费，会员可以在结算运费时使用积分抵扣相应运费。<br>
         会员积分不可转赠，非活动规定积分不可提现，会员账户注销则积分作废。<br>
         联邦转运（FedRoad）会不时开展积分活动，具体请留意官网。
        </div>

         <div class="t1">兑换与提现
        </div>
        <div class="c1">    
       在具体活动中，联邦转运（FedRoad）会设定积分兑换实物和提现规则，届时将以具体规则为准。
        </div>
        <div class="c2">    
         会员积分规则最终解释权归联邦转运（FedRoad）公司所有。  
        </div>      
        <input class="button" type="button" onclick="javascript: history.back(-1) "value="返回" />
        </div>
    </div>

    <script>
        $(".button").mouseenter(function (){
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
    </script>

</asp:Content>
