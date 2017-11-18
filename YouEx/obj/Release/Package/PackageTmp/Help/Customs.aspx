<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Customs.aspx.cs" Inherits="WebSite.Help.Customs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/customs.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-报关指南</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


      <div class="content">
    <div class="title">报关指南</div>
    <div class="line"></div>
    <div class="t1">为提高通关效率，落实海关对试点企业的要求，联邦转运系统增设详细申报板块。在此联邦转运对个人海淘可能遇到的海关申报问题和关务常识整理如下：</div>
    
    <div class="t2">海关允许海淘物品？ </div>
    <div class="c2">海关允许海淘个人合理自用范围内的生活、消费品。“个人”“生活、消费品”规定不能为商用、军用、工业用物品；“合理”规定数额必须在个人适用范围内，数量过多、购买过于频繁均有查扣风险。（参考43号文）</div>
    
     <div class="t2">关税如何计算？</div>
    <div class="c2">海关根据具体物品税率计算税额，小于等于50元人民币的物品免于征收，例如一双手套完税价格100元人民币，纺织品-配饰类税率20%，计算得到税额是20元人民币小于50元，则此手套免税放行。如果应税额超过50元，则以实际税额收取，不再减去其中的50元免税额。

对于同批货物中同一收件人所有包裹，海关将采取累加计算税额的办法，按照最终结果进行征税。其余应税部分计算请参考《完税价格表》和《归类表》。如果您在关税方面有任何疑问请咨询您的客户代表。（参考43号文）</div>

     <div class="t2">如何向海关申报？</div>
    <div class="c2">海关允许海淘个人合理自用范围内的生活、消费品。“个人”“生活、消费品”规定不能为商用、军用、工业用物品；“合理”规定数额必须在个人适用范围内，数量过多、购买过于频繁均有查扣风险。（参考43号文）</div>
    
     <div class="t3">相关文章：</div>
     <a href="http://www.customs.gov.cn/tabid/49659/Default.aspx"><div class="wen">海关总署政策法规页链接</div></a>
     <a href="http://www.customs.gov.cn/default.aspx?tabid=433&infoid=10510&settingmoduleid=1429"><div class="wen">海关总署令第43号（中华人民共和国禁止、限制进出境物品表）</div></a>
      <a href="http://www.customs.gov.cn/publish/portal0/tab3889/module1188/info362458.htm"><div class="wen">海关总署公告2012年第15号</div></a>
      <a href="http://www.customs.gov.cn/publish/portal0/tab399/info700322.htm"><div class="wen">海关总署令第221号（《中华人民共和国海关报关单位注册登记管理规定》）</div></a>
      <input class="button" type="button" onclick="javascript: history.back(-1) "value="返回上一页" />
  </div>

    
    <script>
        $(".content .wen").mouseenter(function () {
            $(this).css("color", "#4d4d4d").mouseleave(function () {
                $(this).css("color", "#808080")
            })
        })
        $(".button").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
  </script>


</asp:Content>
