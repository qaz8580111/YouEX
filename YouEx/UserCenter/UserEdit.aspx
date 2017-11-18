<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="UserEdit.aspx.cs" Inherits="WebSite.UserCenter.UserEdit" EnableEventValidation="False"%>
<%@ Register Assembly="WebSite" Namespace="WebSite.Tool.Control" TagPrefix="nac" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
    <link rel="stylesheet" type="text/css" href="../Include/CSS/useredit.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-修改资料</title>
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
     <div class="c1">
        <div class="word1">库位号：</div>
         <asp:Label ID="Label_Storage" runat="server" Text="" CssClass="color1"></asp:Label>
     </div>

      <div class="last-div"></div>
      <div class="c20">
        <div class="word1">中文名：</div>
        <div class="symbol">*</div> 
            <nac:TextBox ID="Tb_RealName" runat="server" CanBeNull="必填" ValidationGroup="UserEdit"></nac:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                    ControlToValidate="Tb_RealName" Display="Dynamic" ErrorMessage="*输入中文名格式错误" 
                    ValidationExpression="^[\u4e00-\u9fa5]{2,8}" 
                    ValidationGroup="UserRegGroup"  ForeColor="red">
            </asp:RegularExpressionValidator>            
      </div>

     <div class="last-div"></div>
     <div class="c2">
        <div class="left">
            <div class="word1">名(First Name)： </div>
            <div class="symbol">*</div>
            <nac:TextBox ID="Tb_FirstName" runat="server" CanBeNull="必填" ValidationGroup="UserEdit"></nac:TextBox>
        </div>

        <div class="right">
            <div class="word1">姓(Last Name)：</div>
            <div class="symbol">*</div>
            <nac:TextBox ID="Tb_LastName" runat="server" CanBeNull="必填" ValidationGroup="UserEdit"></nac:TextBox>
        </div>
     </div>

     <div class="last-div"></div>
     <div class="c7">
        <div class="word1">手机号码：</div>
        <div class="symbol">*</div>
        <nac:TextBox ID="Tb_Mobile" runat="server" CanBeNull="必填" ValidationGroup="UserEdit" ></nac:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                    ControlToValidate="Tb_Mobile" Display="Dynamic" ErrorMessage="*输入的手机格式错误" 
                    ValidationExpression="\d{11}" 
                    ValidationGroup="UserRegGroup"  ForeColor="red">
        </asp:RegularExpressionValidator>
        <div id="user_editmobile" class="edit_button">修改手机</div>
     </div>

     <div class="last-div"></div>
     <div class="c6">
        <div class="word1">电子邮箱：</div>
        <div class="symbol">*</div>
        <nac:TextBox ID="Tb_Email" runat="server" CanBeNull="必填" ValidationGroup="UserEdit" ></nac:TextBox>
        <asp:RegularExpressionValidator ID="EmailRegularValidator" runat="server" 
                    ControlToValidate="Tb_Email" Display="Dynamic" ErrorMessage="*输入的邮箱格式有误" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                    ValidationGroup="UserRegGroup"  ForeColor="red">
        </asp:RegularExpressionValidator>
        <div id="user_editemail" class="edit_button">修改邮箱</div>
     </div>    
       
     <div class="last-div"></div>
     <div class="c6">
        <div class="word1">微信号码：</div>
         <div class="symbol">*</div>
         <nac:TextBox ID="Tb_WeiXin" runat="server" CanBeNull="必填" ValidationGroup="UserEdit"></nac:TextBox>
         <div id="user_editweixin" class="edit_button">修改微信</div>
     </div>

     <div class="last-div"></div>
     <div class="c3">
        <div class="word1">性别：</div>
        <asp:RadioButtonList ID="Rbl_Gender" runat="server">
            <asp:ListItem Value="0" Selected="True">女</asp:ListItem>
            <asp:ListItem Value="1">男</asp:ListItem>
        </asp:RadioButtonList>
     </div>

      <div class="last-div"></div>
      <div class="c6">
        <div class="word1">备用电话：</div>
          <nac:TextBox ID="Tb_Phone" runat="server" RequiredFieldType="家用电话"></nac:TextBox>
     </div>

      <div class="last-div"></div>
      <div class="c10">
        <div class="word1">个人说明：</div>
          <nac:TextBox ID="Tb_Remark" runat="server" TextMode="MultiLine"></nac:TextBox>
     </div>
  </div>

  <div class="last-div"></div>
   <div class="return-button-box"  style="margin-bottom:80px">
       <nac:Button ID="Button1" runat="server" Text="确认修改" CssClass="edit_userinfo" OnClick="EditUser" ValidationGroup="UserEdit"
         OnClientClick="if(!edit_isspecial()){return false;}"  />
     <a href="UserCenter.aspx"><div class="button2"> 返回</div></a>
  </div>
  
  <div class="bj"></div>

  <div class="showeditmobile">
    <div class="title">
     <div class="word">修改手机</div>
     <div class="line3"></div>
    </div>
    <div class="last-div"></div>
     <div class="w1">
        <div class="word">新手机：</div>
         <nac:TextBox ID="Tb_NewMobile" runat="server" CanBeNull="可空" ValidationGroup="UserEditMobile"></nac:TextBox>
         <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ControlToValidate="Tb_NewMobile" ErrorMessage="" 
                    ValidationExpression="\d{11}"  ValidationGroup="UserEditMobile" >
        </asp:RegularExpressionValidator>
        <div class="tip-box">
            <div class="san"></div>
            <div class="zhe"></div>
            <div class="tip"></div>
        </div>
     </div>
     <div class="last-div"></div>
     <div class="w2">
        <div class="word">验证码：</div>
         <nac:TextBox ID="Tb_CheckCode" runat="server" ValidationGroup="UserEditMobile"></nac:TextBox>
         <span class="checkcode_notice">发送短信</span>
         <asp:Label ID="Label_HideMsgCode" runat="server" Text=""></asp:Label>
     </div>
     <div class="last-div"></div>
     <div class="button4">
        <nac:Button runat="server" Text="确定修改" CssClass="edit_show_button" OnClick="EditMobile" OnClientClick="if(!ischeckmobile()){return false;}" 
            ValidationGroup="UserEditMobile"  />
        <div class="button6">取消</div>
     </div>
  </div>

    <div class="showeditemail">
    <div class="title">
     <div class="word">修改邮箱</div>
     <div class="line3"></div>
    </div>
    <div class="last-div"></div>
    <div class="w1">
        <div class="word">新邮箱：</div>
         <nac:TextBox ID="Tb_NewEmail" runat="server" CanBeNull="可空" ValidationGroup="UserEditEmail"></nac:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="Tb_NewEmail" ErrorMessage="" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  ValidationGroup="UserEditEmail" >
         </asp:RegularExpressionValidator>
         <div class="tip-box">
            <div class="san"></div>
            <div class="zhe"></div>
            <div class="tip"></div>
        </div>
     </div>
     
     <div class="last-div"></div>
     <div class="button4">
        <nac:Button runat="server" Text="确定修改" CssClass="edit_show_button" OnClick="EditEmail" OnClientClick="if(!ischeckemail()){return false;}"
            ValidationGroup="UserEditEmail" />
        <div class="button6">取消</div>
     </div>
  </div>

    <div class="showeditweixin">
    <div class="title">
     <div class="word">修改微信</div>
     <div class="line3"></div>
    </div>
     <div class="last-div"></div>
     <div class="w1">
        <div class="word">新微信：</div>
         <nac:TextBox ID="Tb_NewWeiXin" runat="server" CanBeNull="可空" ValidationGroup="UserEditWeiXin" ></nac:TextBox>
         <div class="tip-box">
            <div class="san"></div>
            <div class="zhe"></div>
            <div class="tip"></div>
        </div>
     </div>
     <div class="last-div"></div>
     <div class="button4">
         <nac:Button runat="server" Text="确定修改" CssClass="edit_show_button" OnClick="EditWeiXin" OnClientClick="if(!ischeckweixin()){return false;}"
             ValidationGroup="UserEditWeiXin" />
        <div class="button6">取消</div>
     </div>
  </div>

    <script>
        $(function () {            
            if ($("#ctl00_ContentPlaceHolder1_Tb_Mobile").val() != "")
            {
                $("#ctl00_ContentPlaceHolder1_Tb_Mobile").attr("disabled", "disabled");
                $("#user_editmobile").show();
            }
            if ($("#ctl00_ContentPlaceHolder1_Tb_Email").val() != "") {
                $("#ctl00_ContentPlaceHolder1_Tb_Email").attr("disabled", "disabled");
                $("#user_editemail").show();
            }
            if ($("#ctl00_ContentPlaceHolder1_Tb_WeiXin").val() != "") {
                $("#ctl00_ContentPlaceHolder1_Tb_WeiXin").attr("disabled", "disabled");
                $("#user_editweixin").show();
            }
            if ($("#ctl00_ContentPlaceHolder1_Label_HideMsgCode").text() == "验证码错误")
            {
                $(".showeditmobile,.bj").show();
            }
            if ($.cookie('CountDown') > 0) {
                function timeShow_() {
                    var n = parseInt($.cookie('CountDown'));
                    if (n > 0) {
                        n--;
                        $.cookie("CountDown", n, { expires: 1 / 26400 });
                        $(".checkcode_notice").text(n + "秒");
                    }
                    if (n == 0) {
                        $(".checkcode_notice").text("重新发送");
                        $.cookie('CountDown', '', { expires: -1 });
                    }
                }
                setInterval(timeShow_, 1000);
            }
            if ($.cookie('CountDown') == 0) {
                $(".checkcode_notice").text("重新发送");
                $.cookie('CountDown', '', { expires: -1 });
            }
        })
        $("#user_editmobile").click(function () {
            $(".showeditmobile , .bj").show();
        })
        $("#user_editemail").click(function () {
            $(".showeditemail , .bj").show();
        })
        $("#user_editweixin").click(function () {
            $(".showeditweixin , .bj").show();
        })
        $(".button6").click(function () {
            $(".showeditemail , .showeditmobile , .showeditweixin , .bj").hide();
        })
       
        $(".checkcode_notice").click(function () {
            if ($("#ctl00_ContentPlaceHolder1_Label_Check_Mobile").text() != "手机号码重复" &&
                $("#ctl00_ContentPlaceHolder1_Tb_NewMobile").val() != "" && $("#ctl00_ContentPlaceHolder1_RegularExpressionValidator2").css("visibility") == "hidden") {
                if ($.cookie('CountDown') == null) {
                    var i = 60;
                    sendmsg();
                    function timeShow(){
                        if (i > 0) {
                            i--;
                            $.cookie("CountDown", i, { expires: 1 / 26400 });
                            i = parseInt($.cookie('CountDown'));
                            $(".checkcode_notice").text(i + "秒");
                        }
                        if (i == 0) {
                            $(".checkcode_notice").text("重新发送");
                            $.cookie('CountDown', '', { expires: -1 });
                            clearInterval(timer);
                        }
                    }
                    var timer = setInterval(timeShow, 1000);
                }
            }
        })
        $("#ctl00_ContentPlaceHolder1_Tb_NewMobile").blur(function () {
            if ($("#ctl00_ContentPlaceHolder1_RegularExpressionValidator2").css("visibility") == "visible") {
                $(".showeditmobile .tip-box .tip").text("手机号码格式不正确");
                $(".showeditmobile .tip-box").show();
            }
            if ($("#ctl00_ContentPlaceHolder1_RegularExpressionValidator2").css("visibility") == "hidden"){
                $(".showeditmobile .tip-box").hide();
            }
            $.ajax({
                type: "POST",
                url: "./UserEdit.aspx?isoldmobile=send",
                data: $("form").serialize(),
                datatype: "text",
                success: function (msg) {
                    if (msg == "no")
                    {
                        $(".showeditmobile .tip-box .tip").text("手机号码重复");
                        $(".showeditmobile .tip-box").show();
                    }
                }
            })
        })
        $("#ctl00_ContentPlaceHolder1_Tb_NewEmail").blur(function (){
            if ($("#ctl00_ContentPlaceHolder1_RegularExpressionValidator1").css("visibility") == "visible") {
                $(".showeditemail .tip-box .tip").text("电子邮箱格式不正确");
                $(".showeditemail .tip-box").show();
            }
            if ($("#ctl00_ContentPlaceHolder1_RegularExpressionValidator1").css("visibility") == "hidden") {
                $(".showeditemail .tip-box").hide();
            }
        })
        $("#ctl00_ContentPlaceHolder1_Tb_NewWeiXin").blur(function () {
            if ($("#ctl00_ContentPlaceHolder1_Tb_NewWeiXin").val() != "") {
                $(".showeditweixin .tip-box").hide();
            }
        })
        function sendmsg() {
            $.ajax({
                type: "POST",
                url: "./UserEdit.aspx?issendmsg=send",
                data: $("form").serialize(),
                datatype: "text",
                success: function (msg) {
                    if (msg == "no")
                        alert("发送失败");
                }
            })
        }
        $("#user_editmobile,#user_editemail,#user_editweixin").mouseenter(function (){
            $(this).css("background-color", "#1a9dd1");
            $(this).css("color", "white");
        }).mouseleave(function () {
            $(this).css("background-color", "unset");
            $(this).css("color", "#4c4c4c");
        })
        $("#ctl00_ContentPlaceHolder1_Button1,.button2,.edit_show_button,.button6,.checkcode_notice").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
        function edit_isspecial() {
            var realname_isspecial = IsSpecialWord($("#ctl00_ContentPlaceHolder1_Tb_RealName").val());
            var firstname_isspecial = IsSpecialWord($("#ctl00_ContentPlaceHolder1_Tb_FirstName").val());
            var lastname_isspecial = IsSpecialWord($("#ctl00_ContentPlaceHolder1_Tb_LastName").val());
            var remark_isspecial = IsSpecialWord($("#ctl00_ContentPlaceHolder1_Tb_Remark").val());
            if (!remark_isspecial && $("#ctl00_ContentPlaceHolder1_Tb_Remark").val() == "")
                remark_isspecial = true;
            if (realname_isspecial && firstname_isspecial && lastname_isspecial && remark_isspecial)
                return true;
            else {
                alert("输入内容含有非法字符");
                return false;
            }
        }
        function ischeckmobile() {
            if ($("#ctl00_ContentPlaceHolder1_Tb_NewMobile").val() == "") {
                $(".showeditmobile .tip-box .tip").text("不能为空");
                $(".showeditmobile .tip-box").show();
            }
            if ($(".showeditmobile .tip-box").css("display") == "block") {
                return false;
            }
            else {
                return true;
            }
        }
        function ischeckemail() {
            if ($("#ctl00_ContentPlaceHolder1_Tb_NewEmail").val() == "") {
                $(".showeditemail .tip-box .tip").text("不能为空");
                $(".showeditemail .tip-box").show();
            }
            if ($(".showeditemail .tip-box").css("display") == "block") {
                return false;
            }
            else {
                return true;
            }
        }
        function ischeckweixin() {
            if ($("#ctl00_ContentPlaceHolder1_Tb_NewWeiXin").val() == "") {
                    $(".showeditweixin .tip-box .tip").text("不能为空");
                    $(".showeditweixin .tip-box").show();
                }
            if ($(".showeditweixin .tip-box").css("display") == "block") {
                return false;
            }
            var weixin_isspecial = IsSpecialWord($("#ctl00_ContentPlaceHolder1_Tb_NewWeiXin").val());
            if (weixin_isspecial)
            {
                return true;
            }
            else {
                $(".showeditweixin .tip-box .tip").text("输入的内容含有非法字符");
                $(".showeditweixin .tip-box").show();
                return false;
            }
        }
    </script>

</asp:Content>
