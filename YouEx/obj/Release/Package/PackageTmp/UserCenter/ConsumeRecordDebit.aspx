<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ConsumeRecordDebit.aspx.cs" Inherits="WebSite.UserCenter.ConsumeRecordDebit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/consumerecord_debit.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-增值服务</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="last-div"></div>
  <div class="top-title">
    <div>财务管理</div>
  </div>
  <div class="main-nav">
    <div class="word">
      <a href="ConsumeRecordSale.aspx"><dl class="a1">我的账单</dl></a>
      <a href="ConsumeRecordDebit.aspx"><dl class="a2">增值服务</dl></a>
      <a href="ConsumeRecordRecharge.aspx"><dl class="a3">充值记录</dl></a>
      <a href="ConsumeCoupon.aspx"><dl class="a4">我的优惠券</dl></a>
      <a href="ConsumeRefund.aspx"><dl class="a5">申请退款</dl></a>
    </div>
    <div class="last-div"></div>
    <div class="line1"> </div>
    <div class="line2"></div>
  </div>


    <div class="last-div"></div>
     <div class="line3"></div>
     <div class="sub-content">
         <div class="kuang">
             <div class="k1">
                <div class="w1">服务编号</div>
                <div class="w2">所属包裹</div>
                <div class="w3">服务名称</div>
                <div class="w4">支付状态</div>
                <div class="w6">创建时间</div>
                <div class="w6">支付时间</div>
                <div class="w7">服务需求</div>
                <div class="w8">服务附件</div>
             </div>
             <div class="last-div"></div>
             <asp:Label ID="Label_HideStrItemFinal" runat="server" Text="" CssClass="hidestritemfinal"></asp:Label>
             <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <div class="k2">
                    <asp:Literal ID="Literal_Service" runat="server">
                        <div class="w1">&nbsp;servicenoHere</div>
                        <div class="w2">&nbsp;packagenoHere</div>
                        <div class="w3">&nbsp;servicenameHere</div>
                        <div class="w4">&nbsp;paystatusHere</div>
                        <div class="w6">&nbsp;createtimeHere</div>
                        <div class="w6">&nbsp;accesstimeHere</div>
                        <div class="w7">&nbsp;requestHere</div>
                        <div class="w8">&nbsp;</div>
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



    <div class="last-div"></div>
    <div class="return-button-box">
        <div class="button2"> 返回</div>
    </div>

    <script>
        $(".button2").click(function () {
            location.href = "UserCenter.aspx";
        })
        function CheckPageCss() {
            
        }
        $(".button2,#ctl00_ContentPlaceHolder1_Button_Redirect").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
    </script>

</asp:Content>
