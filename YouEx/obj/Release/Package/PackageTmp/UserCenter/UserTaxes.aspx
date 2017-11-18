<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="UserTaxes.aspx.cs" Inherits="WebSite.UserCenter.UserTaxes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/usertaxes.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-缴税信息</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="last-div"></div>
  <div class="top-title">
    <div>用户中心</div>
  </div>
  <div class="main-nav">
    <div class="word">
       <a href="UserAccount.aspx"><dl class="a1">我的帐户</dl></a>
      <a href="UserEdit.aspx"><dl class="a2">修改资料</dl></a>
      <a href="UserAddress.aspx"><dl class="a3">地址簿</dl></a>
      <a href="UserTaxes.aspx"><dl class="a5">缴税信息</dl></a>
    </div>
      <div class="last-div"></div>
    <div class="line1"> </div>
    <div class="line2"></div>
  </div>
  <div class="content">

      <div class="last-div"></div>
     <div class="line3"></div>
     <div class="sub-content">
         <div class="kuang">
             <div class="k1">
                <div class="w1">税单编号</div>
                <div class="w2">所属运单</div>
                <div class="w3">税单金额</div>
                <div class="w4">创建时间</div>
                <div class="w5">税单状态</div>
                <div class="w6">支付时间</div>
                <div class="w7">税单附件</div>
             </div>
             <div class="last-div"></div>
             <asp:Label ID="Label_HideStrItemFinal" runat="server" Text="" CssClass="hidestritemfinal"></asp:Label>
             <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                 <ContentTemplate>
                    <div class="k2">
                    <asp:Literal ID="Literal_Tax" runat="server">
                        <div class="w1">taxnoHere</div>
                        <div class="w2">shippingnoHere</div>
                        <div class="w3">moneyHere</div>
                        <div class="w4">createtimeHere</div>
                        <div class="w5">statusHere</div>
                        <div class="w6">paytimeHere</div>
                        <div class="w7">imageHere</div>
                    </asp:Literal>
                 </div>
                     <div class="page_action">
                        <asp:Button ID="Button_FirstPage" runat="server" Text="首页" OnClick="FirstPageClick" />
                        <asp:Button ID="Button_PrevPage" runat="server" Text="上一页" OnClick="PrevPageClick" />
                        <asp:Button ID="Button_NextPage" runat="server" Text="下一页" OnClick="NextPageClick" />
                        <asp:Button ID="Button_LastPage" runat="server" Text="末页" OnClick="LastPageClick" />
                        <asp:TextBox ID="TextBox_Page" runat="server"></asp:TextBox>
                        <asp:Label ID="Label_IsPage" runat="server" Text=""></asp:Label>/<asp:Label ID="Label_CountPage" runat="server" Text=""></asp:Label>
                        <asp:Button ID="Button_Redirect" runat="server" Text="GO" OnClick="RedirectClick" />
                    </div>
                 </ContentTemplate>
             </asp:UpdatePanel>
             
        </div>
  </div>

     </div>

   <div class="last-div"></div>
   <div class="return-button-box">
     <a href="UserCenter.aspx"><div class="button2"> 返回</div></a>
  </div>

    <script>        
        function CheckPageCss() {
            
        }
        $(".button2,#ctl00_ContentPlaceHolder1_Button_Redirect").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
    </script>

</asp:Content>
