<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="UserAccount.aspx.cs" Inherits="WebSite.UserCenter.UserAccount" %>
<%@ Register Assembly="WebSite" Namespace="WebSite.Tool.Control" TagPrefix="nac" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/useraccount.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-我的账户</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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
      <div class="top-information-bj">
         <div class="top-user-information-box">
            <dl class="l1">
                <asp:Image ID="Image_Avatar" runat="server" title="点击上传头像" />
                <dd><asp:Label ID="Label_UserName" runat="server" Text=""></asp:Label></dd>
                <asp:Image ID="Image_Level" runat="server" />
            </dl>
            <dl><div>入库码</div><dd><asp:Label ID="Label_StorageNo" runat="server" Text=""></asp:Label></dd></dl>
            <dl><div>帐户余额</div><dd><asp:Label ID="Label_Money" runat="server" Text=""></asp:Label></dd></dl>
            <dl class="last"><div>F币余额</div><dd><asp:Label ID="Label_FlyMoney" runat="server" Text=""></asp:Label></dd></dl> 
         </div>
          <asp:FileUpload ID="FileUpload_Avatar" runat="server" Style="visibility: hidden;height:1px;" />
          <asp:Button ID="Button_Hide_Upload" runat="server" OnClientClick="if(!avatar_format()){return false;};" OnClick="Button_Hide_Upload_Click" />
          <script>
              $("#ctl00_ContentPlaceHolder1_Image_Avatar").click(function () {
                  $('#ctl00_ContentPlaceHolder1_FileUpload_Avatar').click()
              })
              $('#ctl00_ContentPlaceHolder1_FileUpload_Avatar').change(function () {
                  $("#ctl00_ContentPlaceHolder1_Button_Hide_Upload").click();
              })
      </script>
      </div>
    <asp:Literal ID="Literal_UserInfo" runat="server">
      <div class="last-div"></div>
      <div class="kuang">
     <div class="c1">
       <div>用户名：&nbsp;&nbsp;usernameHere</div>
       <span class="edit_password">修改密码</span>
     </div>
     <div class="last-div"></div>
     <div class="c2">
       <div>邮箱：&nbsp;&nbsp;emailHere</div>

     </div>
     <div class="last-div"></div>
     <div class="c3">
       <div>手机号码：&nbsp;&nbsp;mobileHere</div>

     </div>
     <div class="last-div"></div>
     <div class="c3">
       <div>帐户余额：&nbsp;&nbsp;moneyHere</div>
       <a class="color">充值</a>
     </div>
     <div class="last-div"></div>
      <div class="c4">
       <div>F户余额：&nbsp;&nbsp;moneyflyHere</div>
       <a class="color">充值</a>
     </div>
     <div class="last-div"></div>
     <div class="c3">
       <div>消费总额：&nbsp;&nbsp;creditHere</div>
     </div>
     <div class="last-div"></div>
     <div class="c3">
       <div>冻结资金：&nbsp;&nbsp;frozenHere</div>
     </div>
     <div class="last-div"></div>
     <div class="c5">
       <div>会员等级：&nbsp;&nbsp;</div>
       <img src="../Images/Pic_User/levelHere" />
     </div>
     <div class="last-div"></div>
    <div class="c6">
        <span>推广链接：&nbsp;&nbsp;</span>
        <input value="http://new.fedroad.com/UserCenter/UserRegister.aspx" type="url" class="spread_link" readonly="readonly"  />
        <span class="copy_spread_link">复制</span>
    </div>
    <div class="last-div"></div>
    <div class="return-button-box">
         <div class="button3">成为高级会员</div>
         <div class="button2">成为VIP</div>
         <a href="UserCenter.aspx"><div class="button4"> 返回</div></a>
    </div>
  </div>
    </asp:Literal>
</div>
    <script type="text/javascript">        
        $(".button3").click(function () {
            if (confirm("成为高级会员需要一次性充值2500F币") == true) {
                $(".pay,.bj").show();                
                $("#ctl00_ContentPlaceHolder1_TB_Recharge").val("2500");
                $("input[name='recharge_place']").eq(1).prop("checked", "checked");
            }
        })
        $(".button2").click(function () {
            if (confirm("成为VIP需要一次性充值5000F币") == true) {
                $(".pay,.bj").show();
                $("#ctl00_ContentPlaceHolder1_TB_Recharge").val("5000");
                $("input[name='recharge_place']").eq(1).prop("checked", "checked");
            }
        })        
    </script>

  <div class="bj"></div>


    <!--充值页面-->
  <div class="pay">
    <img src="../Images/Pic_User/XX2.png" class="pay_close" />
    <div class="d1">
       <div class="title"><p>充值金额</p><div class="line"></div></div>
       <div class="last-div"></div>
       <div class="content">
          <div class="v1">累计消费：0.00元</div>
          <div class="v1">帐户余额：<asp:Label ID="Label_Charge_Money" runat="server" Text=""></asp:Label>元</div>
          <div class="v2">F币余额：<asp:Label ID="Label_Charge_Fmoney" runat="server" Text=""></asp:Label>元</div>
          <div class="v1">冻结金额：0.00元</div>
          <div class="v1">请输入充值金额：<asp:TextBox ID="TB_Recharge" runat="server" ></asp:TextBox>元
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="*该字段为必填项" ControlToValidate="TB_Recharge" Display="Dynamic" 
              ValidationGroup="UserRecharge"  ForeColor="red" runat="server"></asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1"
              ControlToValidate="TB_Recharge" Display="Dynamic" ErrorMessage="*输入金额为整数" 
              ValidationExpression="^[1-9]\d*$" ValidationGroup="UserRecharge"  ForeColor="red"></asp:RegularExpressionValidator>
          </div>
       </div>    
    </div>
    <div class="d2">
        <div class="title"><p>充值到</p><div class="line"></div></div>
        <div class="last-div"></div>
        <div class="content">
          <div class="v1">
              <input id="relation_input_21" type="radio" name="recharge_place" value="1" />
              <label for="relation_input_21">帐户</label><span class="charge_type_word">(充值到账户余额,支持提现)</span></div>
          <div class="v1">
              <input id="relation_input_22" type="radio" name="recharge_place" value="2" />
              <label for="relation_input_22">F币</label><span class="charge_type_word">(成为会员或VIP需要充值F币,将获得更多优惠)</span></div>
        </div>
    </div>
    <div class="d3">
        <div class="title"><p>充值方式</p><div class="line"></div></div>
          <div class="last-div"></div>
        <div class="content1">
          <div class="p1">
              <input id="relation_input_23" type="radio" name="recharge_type" value="1" checked="checked" />
              <label for="relation_input_23"><img src="../Images/Pic_User/zhifubao.png" /></label></div>
          <div class="p2">
              <input id="relation_input_24" type="radio" name="recharge_type" value="2" />
              <label for="relation_input_24"><img src="../Images/Pic_User/paypal.png" /></label></div>
        </div>
      <div class="last-div"></div>
      <div class="d4">
      <asp:Button ID="Button_Recharge" runat="server" ValidationGroup="UserRecharge" OnClick="UserRecharge" />
      <img class="no-sure" src="../Images/Pic_User/100-no-sure.png"/>
      </div>
  </div>
    </div>


    <!--修改密码-->
    <div class="edit_page">
      <div class="word_pwd">修改密码</div>
      <div class="line_pwd"></div>
      <div class="content_pwd">
         <div class="w3">
            <div class="word">原密码：</div>
            <nac:TextBox ID="TB_Password_Old" CanBeNull="可空" ValidationGroup="EditPwd" runat="server" TextMode="Password"></nac:TextBox>
             <div class="tip-box">
                <div class="san"></div>
                <div class="zhe"></div>
                <div class="tip">不能为空</div>
             </div>
         </div>
         <div class="last-div"></div>
         <div class="w1">
            <div class="word">新密码：</div>
            <nac:TextBox ID="TB_Password_New" CanBeNull="可空" ValidationGroup="EditPwd" runat="server" TextMode="Password" ValidationExpression="\d{6,16}"></nac:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="TB_Password_New" ErrorMessage="" ValidationGroup="EditPwd" 
                ValidationExpression="\w{6,16}" runat="server" ></asp:RegularExpressionValidator>
             <div class="tip-box">
                <div class="san"></div>
                <div class="zhe"></div>
                <div class="tip">密码长度6-16个字符</div>
             </div>
         </div>
         <div class="last-div"></div>
         <div class="w2">
            <div class="word">确认密码：</div>
            <nac:TextBox ID="TB_Password_Renew" CanBeNull="可空" ValidationGroup="EditPwd" runat="server" TextMode="Password"></nac:TextBox>
            <div class="tip-box">
		       <div class="san"></div>
               <div class="zhe"></div>
               <div class="tip">密码输入不一致</div>
            </div>
         </div>
      </div>
      <div class="last-div"></div>
       <div class="button-box">
         <nac:Button ID="Button_Edit_Pwd" ValidationGroup="EditPwd" runat="server" Text="修改密码" OnClientClick="if(!ischecknull()){return false;}" OnClick="EditPassword" />
         <div class="button2">取消</div>         
      </div>
      <div class="hide_pwd_notice"></div>
    </div>

    <script>
        $(".pay_close").click(function () {
            $(".pay,.bj").hide();
        })
        $(".edit_password").click(function () {
            $(".edit_page,.bj").show();
        })
        $(".edit_page .button2").click(function () {
            $(".edit_page,.bj").hide();
        })        
        $(".color").eq(0).click(function () {
            $(".pay,.bj").show()
            $("#ctl00_ContentPlaceHolder1_TB_Recharge").val("");
            $("#relation_input_21").prop("checked", "checked");
        })
        $(".color").eq(1).click(function () {
            $(".pay,.bj").show();
            $("#ctl00_ContentPlaceHolder1_TB_Recharge").val("");
            $("#relation_input_22").prop("checked", "checked");
        })
        $("#ctl00_ContentPlaceHolder1_TB_Password_New").blur(function() {
            if ($("#ctl00_ContentPlaceHolder1_RegularExpressionValidator2").css("visibility") == "hidden")
            {
                $(".w3 .tip-box").hide();
            }            
        })
        $("#ctl00_ContentPlaceHolder1_TB_Password_New").blur(function() {
            if ($("#ctl00_ContentPlaceHolder1_RegularExpressionValidator2").css("visibility") == "visible")
            {
                $(".w1 .tip-box .tip").text("密码长度6-16个字符");
                $(".w1 .tip-box").show();
            }                
            if ($("#ctl00_ContentPlaceHolder1_RegularExpressionValidator2").css("visibility") == "hidden")
                $(".w1 .tip-box").hide();
        })
        $("#ctl00_ContentPlaceHolder1_TB_Password_Renew").blur(function () {
            if($("#ctl00_ContentPlaceHolder1_TB_Password_New").val() == $("#ctl00_ContentPlaceHolder1_TB_Password_Renew").val())
                $(".w2 .tip-box").hide();
            if ($("#ctl00_ContentPlaceHolder1_TB_Password_New").val() != $("#ctl00_ContentPlaceHolder1_TB_Password_Renew").val())
            {
                $(".w2 .tip-box .tip").text("密码输入不一致");
                $(".w2 .tip-box").show();
            }
        })
        $(".copy_spread_link").zclip({
            path: '../Include/JS/ZeroClipboard.swf',
            copy: function (){
                return $('.spread_link').val();
            },
            afterCopy: function (){
                alert('复制成功');
            }
        })
        $(".copy_spread_link,.edit_password,.button2,.button3,.button4,#ctl00_ContentPlaceHolder1_Button_Edit_Pwd").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
        function ischecknull() {
            if ($("#ctl00_ContentPlaceHolder1_TB_Password_Old").val() == "") {                
                $(".w3 .tip-box").show();
            }
            if($("#ctl00_ContentPlaceHolder1_TB_Password_New").val() == "") {
                $(".w1 .tip-box .tip").text("不能为空");
                $(".w1 .tip-box").show();
            }
            if($("#ctl00_ContentPlaceHolder1_TB_Password_Renew").val() == "") {
                $(".w2 .tip-box .tip").text("不能为空");
                $(".w2 .tip-box").show();
            }
            if ($(".w1 .tip-box").css("display") == "block" || $(".w2 .tip-box").css("display") == "block" || $(".w3 .tip-box").css("display") == "block") {
                return false;
            }
            else{
                return true;
            }
        }
        function avatar_format() {
            var format = new Array("jpg", "png", "gif", "bmp");
            if ($("#ctl00_ContentPlaceHolder1_uploadPicFront").val() != "") {
                var suffix = $("#ctl00_ContentPlaceHolder1_FileUpload_Avatar").val().split(".")[1];
                var isright = false;
                for (var i = 0; i < format.length; i++) {
                    if ((suffix.indexOf(format[i])) >= 0) { isright = true; }
                };
                if (!isright) {
                    alert('上传的图片格式错误');
                    return false;
                } else
                    return true;
            }
        }
    </script>

</asp:Content>
