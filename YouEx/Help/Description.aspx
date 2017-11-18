<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Description.aspx.cs" Inherits="WebSite.Help.Description" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/description.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-理赔说明</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


     <div class="content">
     <div class="tiltle">理赔说明</div>
     <img class="line" src="../Images/Pic_User/xuanxian-1150.png">
     <img src="../Images/Pic_User/claims-lc.png" />
     <img class="line1" src="../Images/Pic_User/xuanxian-1150.png">
     <div class="table">
        <table cellpadding="0" cellspacing="0">
          <tr > 
              <td class="t1-1"></td>
              <td class="t2-1"></td>
              <td class="t3-1">已加固</td>
               <td class="t3-1">未加固</td>
            </tr>
          <tr > 
              <td class="t1">&nbsp;<br /><br /><br /><br /><br />
                  破损赔付</td>
              <td class="t2">全部破损，物品完全没法使用</td>
              <td class="t3">全额赔偿物品申报价值，最高不超过3000RMB</td>
              <td class="t3">赔偿物品申报价值50%，最高不得超过1000RMB</td>
            </tr>
          <tr > 
              <td class="t1"></td>
              <td class="t2">部分破损，不影响物品使用</td>
              <td class="t3">按破损申报价值物品占整个包裹的比例进行赔偿，<br />
最高不超过3000RMB</td>
              <td class="t3">按破损物品占整个包裹的比例进行赔偿，最高赔偿<br />
物品申报价值的30%，最高不超过1000RMB</td>
            </tr>
          <tr > 
              <td class="t1-2"></td>
              <td class="t2">包装破损，不影响物品使用</td>
              <td class="t3">最高赔偿物品申报价值10%，最高不超过3000RMB</td>
              <td class="t3">不予理赔</td>
            </tr>

        </table>
       <div class="word">*针对全部破损完全无法使用的物品，需寄回联邦转运公司进行审核后，进行赔偿</div>
     </div>
     
    <div class="table">
        <table cellpadding="0" cellspacing="0">
          <tr > 
              <td class="t1-1"></td>
              <td class="t2-1"></td>
              <td class="t3-1">已保价</td>
               <td class="t3-1">未保价</td>
          </tr>
          <tr > 
              <td class="t1">
                  丢失理赔</td>
              <td class="t2">全部丢失</td>
              <td class="t3">全额赔偿物品申报价值+全段运费，最高不超过5000RMB</td>
              <td class="t3">全额赔偿物品申报价值+全段运费，最高不超过1000RMB</td>
          </tr>
          <tr > 
              <td class="t1-2"></td>
              <td class="t2">部分丢失</td>
            <td class="t3">全额赔偿丢失物品申报价值+部分运费，最高不超过5000RMB
            <td class="t3">全额赔偿丢失物品申报价值+部分运费，最高不超过1000RMB
          </tr>

        </table>
     </div>
     
       <div class="table">
        <table cellpadding="0" cellspacing="0">
          <tr > 
              <td class="t1-1"></td>
              <td class="tt3-1">已保价</td>
               <td class="tt3-1">未保价</td>
          </tr>
          <tr > 
              <td class="t1">
                  差重理赔</td>
              <td class="t3" colspan="2"; rowspan="2">
                  <span class="word_10">收到货后，在未拆箱前称重；</span><br />
                  <span class="word_11">申请理赔材料：</span><br />
                  1包裹外包装照片，需包含完整清晰面单<br />
                  2.包裹称重照片，重量保留小数点后两位<br />
                </td>
              
          </tr>
          <tr > 
              <td class="t1-2"></td>
          </tr>

        </table>
     </div>
       <input class="button" type="button" onclick="javascript: history.back(-1) "value="返回" />
  </div>

    <script>
        $(".button").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
    </script>

</asp:Content>
