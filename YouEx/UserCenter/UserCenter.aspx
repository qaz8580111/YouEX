<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="UserCenter.aspx.cs" Inherits="WebSite.UserCenter.UserCenter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/usercenter.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-用户中心</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <div class="last-div"></div>
  <div class="top-banner">
     <img src="../Images/Pic_User/banner-wan.jpg"/>
     <img src="../Images/Pic_User/banner-te.jpg"/>
     <img src="../Images/Pic_User/banner-pu.jpg" />     
     <img src="../Images/Pic_User/banner-nai.jpg"/>
     <div class="z"></div>
     <div class="y"></div>
     <ul>
        <li class="lanse"></li>
        <li></li>
        <li></li>
        <li></li>
     </ul>
  </div>

    <div class="last-div"></div>
  <div class="top-information-bj">
     <div class="top-user-information-box">
        <dl class="l1">            
            <asp:Image ID="Image_Avatar" runat="server" />            
            <dd><asp:Label ID="Label_RealName" runat="server" Text=""></asp:Label></dd>
            <asp:Image ID="Image_level" runat="server" /></dl>
        <dl><div>入库码</div><dd><asp:Label ID="Label_StorageNo" runat="server" Text=""></asp:Label></dd></dl>
        <dl><div>上次登录</div><dd><asp:Label ID="Label_RegTime" runat="server" Text=""></asp:Label></dd></dl>
        <dl><div>帐户余额</div><dd style="text-align:center;"><asp:Label ID="Label_Money" runat="server" Text=""></asp:Label></dd><a href="./UserAccount.aspx">充值</a></dl>
        <dl class="last"><div>F币余额</div><dd style="text-align:center;"><asp:Label ID="Label_FlyMoney" runat="server" Text=""></asp:Label></dd><a href="./UserAccount.aspx">充值</a></dl>
     </div>
  </div>

  <div class="search">
    <div class="search-box">
      <input type="text" class="underuser_addpackage_input" placeholder="请输入运单号" /><span class="underuser_addpackage" ></span>
    </div>
  </div>
  <div class="last-div"></div>

 <div class="bj"></div>
 <div class="shi-address">
    <img src="../Images/Pic_User/shi-address.jpg" />
    <img class="button" src="../Images/Pic_User/shut.png" />
 </div>
 <div class="waybill">
   <div class="waybill-box"> 
      <div class="waybill-border">
           <div class="left">
              <div class="word"> 运单管理</div><img class="img_link_delivery" src="../Images/Pic_User/package.png" />
          </div>

          <div class="right">
              <div class="title">基本操作</div>
              <div class="content">
                <a href="../Package/NewPackage.aspx">新包裹</a>
                <a href="../Package/NewMyStock.aspx">包裹库存</a>
              </div>
          </div>

          <div class="right">
              <div class="title">运单信息</div>
              <div class="content">                
                <a href="../Package/NewMyStock.aspx?ordertype=delivery_waiting">待处理运单</a>
                <a href="../Package/NewMyStock.aspx?ordertype=delivery_paybill">待支付运单</a>
                <a href="../Package/NewMyStock.aspx?ordertype=delivery_transport">运输中运单</a>
                <a href="../Package/NewMyStock.aspx?ordertype=delivery_finished">已完成运单</a>
              </div>
          </div>

      </div>
   </div>
 </div>
    <div class="last-div"></div>
  <div class="warehouse-address">
    <div class="warehouse-address-box">
       <div class="warehouse-address-border">
          <div class="left">
             <div class="word">海外仓库地址</div><img class="img_link_address" src="../Images/Pic_User/dingwei.png" />
          </div>
          
           <div class="right">
              <div class="title">美国仓库</div>
              <div class="content">
                <a href="UsaOregon.aspx">俄勒冈免税州</a>
              </div>              
          </div>
          <div class="right">
              <div class="title">意大利仓库</div>
              <div class="content">
                <a href="ItalyOregon.aspx">布雷西亚</a>
              </div>
          </div>
          <div class="right">
              <div class="title">日本仓库</div>
              <div class="content">
                <a href="JapanOregon.aspx">大阪</a>
              </div>
          </div>
       </div>
    </div>
 </div>
 <div class="bj"></div>
 <div class="shi-address">
    <img src="../Images/Pic_User/shi-address.jpg" />
    <img class="button" src="../Images/Pic_User/shut.png" />
 </div> 
  <div class="finance">
   <div class="finance-box"> 
      <div class="finance-border">
           <div class="left">
              <div class="word">财务管理</div><img class="img_link_money" src="../Images/Pic_User/finance.png" />
          </div>
          <div class="right">
              <div class="title">基本操作</div>
              <div class="content">
                <a href="ConsumeRefund.aspx">申请退款</a>
              </div>
          </div>
          <div class="right">
              <div class="title">信息查询</div>
              <div class="content">
                <a href="ConsumeRecordSale.aspx">我的账单</a>
                <a href="ConsumeRecordDebit.aspx">增值服务</a>
                <a href="ConsumeRecordRecharge.aspx">充值记录</a>
                <a href="ConsumeCoupon.aspx">我的优惠券</a>
              </div>
          </div>
      </div>
   </div>
 </div>
 <div class="finance">
   <div class="finance-box"> 
      <div class="finance-border">
           <div class="left">
              <div class="word">用户中心</div><img class="img_link_user" src="../Images/Pic_User/tool.png" />
          </div>
          <div class="right">
              <div class="title">基本操作</div>
              <div class="content">
                <a href="UserEdit.aspx">修改资料</a>
              </div>
          </div>
          <div class="right">
              <div class="title">信息查询</div>
              <div class="content">
                <a href="UserAccount.aspx">我的帐户</a>
                <a href="UserAddress.aspx">地址簿</a>
                <a href="UserTaxes.aspx">缴税信息</a>
              </div>
          </div>
      </div>
   </div>
 </div>
    <script>
        $(".img_link_delivery").click(function () {
            location.href = "../Package/NewMyStock.aspx?ordertype=delivery_waiting";
        })
        $(".img_link_address").click(function () {
            location.href = "./UsaOregon.aspx";
        })
        $(".img_link_money").click(function () {
            location.href = "./ConsumeRecordSale.aspx";
        })
        $(".img_link_user").click(function () {
            location.href = "./UserAccount.aspx";
        })
        /*图片轮播*/
        var x = 0
        $(".top-banner img").hide().first().show()
        $(".top-banner .y").click(function () {
            if (x < $(".top-banner img").length - 1) { x = x + 1 } else { x = 0 }
            $(".top-banner img").hide().eq(x).show()
            $(".top-banner li").removeClass("lanse").eq(x).addClass("lanse")
        })
        $(".top-banner .z").click(function () {
            if (x > 0) { x = x - 1 } else { x = $(".top-banner img").length - 1 }
            $(".top-banner img").hide().eq(x).show()
            $(".top-banner li").removeClass("lanse").eq(x).addClass("lanse")
        })
        $(".top-banner li").click(function () {
            x = $(this).index()
            $(".top-banner img").hide().eq(x).show()
            $(".top-banner li").removeClass("lanse").eq(x).addClass("lanse")
        })

        function y() {
            if (x < $(".top-banner img").length - 1) { x = x + 1 } else { x = 0 }
            $(".top-banner img").hide().eq(x).show()
            $(".top-banner li").removeClass("lanse").eq(x).addClass("lanse")
        }
        setInterval(y, 5000)
    </script>
</asp:Content>
