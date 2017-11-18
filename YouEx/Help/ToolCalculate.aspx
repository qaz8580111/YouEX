<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ToolCalculate.aspx.cs" Inherits="WebSite.Help.ToolCalculate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/toolcalculate.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-运费计算</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="content">
   <div class="tiltle">运费计算器</div>
     <img src="../Images/Pic_User/xuanxian-1150.png" />
     <div class="remark">【1英寸=2.54 厘米(cm)、1磅=0.4535924千克(kg)】</div>
     <div class="calculator">
         <div class="c1">
           <div class="chang">长:</div>
             <asp:TextBox ID="TB_Length" runat="server"></asp:TextBox><div>英寸</div>
         </div>
         <div class="c1">
         <div class="chang">宽:</div>
             <asp:TextBox ID="TB_Width" runat="server"></asp:TextBox><div>英寸</div>
         </div>
         <div class="c1">
           <div class="chang">高:</div>
             <asp:TextBox ID="TB_Height" runat="server"></asp:TextBox><div>英寸</div>
         </div>
         <div class="c1">
           <div class="chang">实际重量:</div>
             <asp:TextBox ID="TB_Weight" runat="server"></asp:TextBox><div>磅</div>
         </div>
         <div class="c2">
             <asp:Button ID="Button1" runat="server" Text="计算" CssClass="button" OnClick="CalculatePrice" />
         </div>
     </div>

             <div class="last-div"></div>
     <div class="table"> 
       <table  cellpadding="0" cellspacing="0">
          <tr>
              <td class="t1">
                <div class="word1">各线路会员运费</div>
                <div class="word2"><div class="color">汇率</div>&nbsp;&nbsp;<span>$1：￥</span><asp:Label ID="Label_Rate" runat="server" Text=""></asp:Label></div>
              </td>
          </tr>
          <div class="last-div"></div>
          <tr>
              <td class="t2">服务</td>
              <td class="t2">普通会员</td>
              <td class="t2">高级会员</td>
              <td class="t3">VIP会员</td>
          </tr>       
          <tr>
              <td class="t4">万国邮盟线</td>
              <td class="t4"><span>$</span><asp:Label ID="Label_wgym_1" runat="server" Text="10.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_wgym_1_cny" runat="server" Text="65.00"></asp:Label><span>)</span></td>
              <td class="t4"><span>$</span><asp:Label ID="Label_wgym_2" runat="server" Text="9.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_wgym_2_cny" runat="server" Text="58.50"></asp:Label><span>)</span></td>
              <td class="t5"><span>$</span><asp:Label ID="Label_wgym_3" runat="server" Text="8.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_wgym_3_cny" runat="server" Text="52.00"></asp:Label><span>)</span></td>
          </tr>
          <tr>
              <td class="t4">普货线</td>
              <td class="t4"><span>$</span><asp:Label ID="Label_ph_1" runat="server" Text="10.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_ph_1_cny" runat="server" Text="65.00"></asp:Label><span>)</span></td>
              <td class="t4"><span>$</span><asp:Label ID="Label_ph_2" runat="server" Text="9.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_ph_2_cny" runat="server" Text="58.50"></asp:Label><span>)</span></td>
              <td class="t5"><span>$</span><asp:Label ID="Label_ph_3" runat="server" Text="8.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_ph_3_cny" runat="server" Text="52.00"></asp:Label><span>)</span></td>
          </tr>
          <tr>
              <td class="t4">USPS线</td>
              <td class="t4"><span>$</span><asp:Label ID="Label_usps_1" runat="server" Text="45.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_usps_1_cny" runat="server" Text="292.50"></asp:Label><span>)</span></td>
              <td class="t4"><span>$</span><asp:Label ID="Label_usps_2" runat="server" Text="45.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_usps_2_cny" runat="server" Text="292.50"></asp:Label><span>)</span></td>
              <td class="t5"><span>$</span><asp:Label ID="Label_usps_3" runat="server" Text="45.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_usps_3_cny" runat="server" Text="292.50"></asp:Label><span>)</span></td>
          </tr>
          <tr>
              <td class="t6">奶粉报税线</td>
              <td class="t6"><span>$</span><asp:Label ID="Label_nf_1" runat="server" Text="8.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_nf_1_cny" runat="server" Text="52.00"></asp:Label><span>)</span></td>
              <td class="t6"><span>$</span><asp:Label ID="Label_nf_2" runat="server" Text="8.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_nf_2_cny" runat="server" Text="52.00"></asp:Label><span>)</span></td>
              <td class="t7"><span>$</span><asp:Label ID="Label_nf_3" runat="server" Text="8.00"></asp:Label>
                  <span>(￥</span><asp:Label ID="Label_nf_3_cny" runat="server" Text="52.00"></asp:Label><span>)</span></td>
          </tr>
        </table> 
     <div class="word">因个别线路中对体积、异形物品、限重、保险费等有特殊限定，参看《资费与支付》页面，故本工具得出结果供您参考之用，不完全代表真实计费，如需帮助请联系客服。</div>
  </div>          
  </div>  


</asp:Content>
