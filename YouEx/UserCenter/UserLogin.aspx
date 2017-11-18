<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="WebSite.UserCenter.UserLogin" %>
<%@ Register Assembly="WebSite" Namespace="WebSite.Tool.Control" TagPrefix="nac" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/userlogin.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-用户登录</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
    <div class="content-box">
       <div class="left">
          <div class="sign">登录</div>
          <div class="line"></div>
          <div class="login-mail">
             <div class="word">登录帐户</div>
              <asp:TextBox ID="TB_UserName" runat="server" placeholder="手机号/电子邮箱"></asp:TextBox>
              <asp:RequiredFieldValidator ID="EmailRequiredValidator0" runat="server" 
                    ErrorMessage="*该字段为必填项" ControlToValidate="TB_UserName" Display="Dynamic" 
                    ValidationGroup="UserLoginGroup" ForeColor="red">
              </asp:RequiredFieldValidator>
          </div>
           <div class="lastdiv"></div>
          <div class="login-password">
             <div class="word">登录密码</div>              
              <asp:TextBox ID="TB_Password" runat="server" TextMode="Password" placeholder="输入6-16位字符"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="*该字段为必填项" ControlToValidate="TB_Password" Display="Dynamic" 
                    ValidationGroup="UserLoginGroup" ForeColor="red">
              </asp:RequiredFieldValidator>
          </div>
          <div class="lastdiv"></div>
          <div class="aut-login">
              <asp:CheckBox ID="CB_Remember" runat="server" value="" /><label for="ctl00_ContentPlaceHolder1_CB_Remember" class="word">记住帐号</label>
              <input name="hide_remember" style="display:none;" value="0" />
          </div>
          <div class="lastdiv"></div>
          <div class="login-button">
              <asp:Button ID="Button_Userlogin" runat="server" OnClientClick="check_agree();"  OnClick="UserLogin_Content" ValidationGroup="UserLoginGroup"/>
              <asp:Label ID="Label_Fail_Login" runat="server" Text="" CssClass="fail_login"></asp:Label>
          </div>
          <div class="f-password">忘记密码？</div>
          <div class="ver-line"></div>
       </div>
       <div class="right">
          <div><img src="../Images/Pic_Main/sao-weixin.jpg" /></div>
          <div class="word">还没有帐号？</div>
          <a href="./UserRegister.aspx"><img src="../Images/Pic_Main/re-button.jpg" /></a>
       </div>
       <asp:Label ID="Label_Hide_Message" runat="server" Text=""></asp:Label>
    </div>
</div>


    <div class="forget_password">
        <img src="../Images/Pic_User/XX2.png" class="icon_close" />
        <div class="fgt_sign">重设密码</div>
        <div class="fgt_word_head">验证码将会发送至你的邮箱或手机</div>

        <div class="first_floor">
            <div class="fgt_input_mobile">
                <asp:TextBox ID="TB_Get_Pwd_Mobile" placeholder="请输入您手机号码" runat="server"></asp:TextBox>
                <div class="glyphicon glyphicon-transfer"></div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ControlToValidate="TB_Get_Pwd_Mobile" ErrorMessage="" 
                    ValidationExpression="\d{11}" ValidationGroup="UserRegGroup">
                </asp:RegularExpressionValidator>
            </div>
            <div class="lastdiv"></div>
            <div class="fgt_input_email">
                <asp:TextBox ID="TB_Get_Pwd_Email" placeholder="请输入您的注册邮箱" runat="server"></asp:TextBox>
                <div class="glyphicon glyphicon-transfer"></div>
                <asp:RegularExpressionValidator ID="EmailRegularValidator" runat="server" 
                    ControlToValidate="TB_Get_Pwd_Email" ErrorMessage="" ValidationGroup="UserRegGroup"
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                </asp:RegularExpressionValidator>
                
            </div>
            <div class="tip-box">
                <div class="san"></div>
                <div class="zhe"></div>
                <div class="tip"></div>
            </div>
        </div>

        <div class="second_floor">
            <div class="lastdiv"></div>
            <div class="reset_pwd">
                <asp:TextBox ID="TB_Reset_Pwd" TextMode="Password" placeholder="您的新密码" runat="server"></asp:TextBox>
                <div class="glyphicon glyphicon-eye-open"></div>
                <asp:RegularExpressionValidator ID="ResetRegularExpressionValidator" runat="server" 
                    ControlToValidate="TB_Reset_Pwd" ErrorMessage="" ValidationExpression="\w{6,16}" ValidationGroup="UserRegGroup">
                </asp:RegularExpressionValidator>
            </div>
            <div class="tip-box">
                <div class="san"></div>
                <div class="zhe"></div>
                <div class="tip"></div>
            </div>
        </div>

        <div class="third_floor">
            <div class="lastdiv"></div>
            <div class="check_code">
                <asp:TextBox ID="TB_Check_Code" runat="server" placeholder="请输入六位数验证码"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="TB_Check_Code" ErrorMessage="" ValidationExpression="\d{6}" ValidationGroup="UserRegGroup">
                </asp:RegularExpressionValidator>
                <div class="get_check_code">获取验证码</div>
            </div>
            <div class="tip-box">
                <div class="san"></div>
                <div class="zhe"></div>
                <div class="tip"></div>
            </div>
        </div>

        <div class="four_floor">
            <div class="lastdiv"></div>
            <asp:Button ID="Button_Mobile_Reset" CssClass="reset_button" runat="server" Text="确认"
               OnClick="ResetPwdMobile" OnClientClick="if(!ischeck()){return false;}" />
            <asp:Button ID="Button_Email_Reset"  CssClass="reset_button" runat="server" Text="确认"
                OnClick="ResetPwdEmail" OnClientClick="if(!ischeck()){return false ;}" />
        </div>

    </div>
    <div class="bj"></div>
    <script>
        function check_agree() {
            if ($('#ctl00_ContentPlaceHolder1_CB_Remember').is(":checked")) {
                $('input[name="hide_remember"]').val("1");
            }
        }

        $(".f-password").click(function () {
            $(".forget_password , .bj").show();
        })        

        $(".icon_close").click(function () {
            $(".forget_password , .bj").hide();
            $(".icon_email,.icon_mobile,.sendtotype,.select_type").show();
            $(".get_pwd_email , .get_pwd_mobile").hide();
        })

        $(".first_floor .glyphicon").click(function () {
            $(".fgt_input_mobile,.fgt_input_email,#ctl00_ContentPlaceHolder1_Button_Mobile_Reset,#ctl00_ContentPlaceHolder1_Button_Email_Reset").toggle();
            $("#ctl00_ContentPlaceHolder1_TB_Get_Pwd_Mobile,#ctl00_ContentPlaceHolder1_TB_Get_Pwd_Email").val("");
            $(".first_floor .tip-box").hide();
        })
        $(".second_floor .glyphicon").click(function () {
            if ($("#ctl00_ContentPlaceHolder1_TB_Reset_Pwd").attr("type") == "password") {
                $(".second_floor .glyphicon").css("color", "black");
                $("#ctl00_ContentPlaceHolder1_TB_Reset_Pwd").attr("type","text");
            }
            else
            {
                $(".second_floor .glyphicon").css("color", "#BBB");
                $("#ctl00_ContentPlaceHolder1_TB_Reset_Pwd").attr("type", "password");
            }
        })
        $("#ctl00_ContentPlaceHolder1_TB_Get_Pwd_Mobile").blur(function () {
            if ($("#ctl00_ContentPlaceHolder1_RegularExpressionValidator2").css("visibility") == "visible") {
                $(".first_floor .tip-box .tip").text("手机格式有误");
                $(".first_floor .tip-box").css("margin-top", "-35px");
                $(".first_floor .tip-box").show();
            }else
                $(".first_floor .tip-box").hide();
        })
        $("#ctl00_ContentPlaceHolder1_TB_Get_Pwd_Email").blur(function () {
            if ($("#ctl00_ContentPlaceHolder1_EmailRegularValidator").css("visibility") == "visible") {
                $(".first_floor .tip-box .tip").text("邮箱格式有误");
                $(".first_floor .tip-box").css("margin-top", "-5px");
                $(".first_floor .tip-box").show();
            } else
                $(".first_floor .tip-box").hide();
        })
        $("#ctl00_ContentPlaceHolder1_TB_Reset_Pwd").blur(function () {
            if ($("#ctl00_ContentPlaceHolder1_ResetRegularExpressionValidator").css("visibility") == "visible") {
                $(".second_floor .tip-box .tip").text("密码格式有误");
                $(".second_floor .tip-box").show();
            } else
                $(".second_floor .tip-box").hide();
        })
        $("#ctl00_ContentPlaceHolder1_TB_Check_Code").blur(function () {
            if ($("#ctl00_ContentPlaceHolder1_RegularExpressionValidator1").css("visibility") == "visible") {
                $(".third_floor .tip-box .tip").text("验证码是六位数字");
                $(".third_floor .tip-box").show();
            } else
                $(".third_floor .tip-box").hide();
        })
        $(".get_check_code").click(function () {
            var send_type = "";
            var iscontinue = false;
            if ($("#ctl00_ContentPlaceHolder1_TB_Get_Pwd_Mobile").val() == "" && $("#ctl00_ContentPlaceHolder1_TB_Get_Pwd_Email").val() == "")
            {
                if ($(".fgt_input_mobile").is(":visible")) {
                    $(".first_floor .tip-box .tip").text("不能为空");
                    $(".first_floor .tip-box").css("margin-top", "-35px");
                    $(".first_floor .tip-box").show();
                } else {
                    $(".first_floor .tip-box .tip").text("不能为空");
                    $(".first_floor .tip-box").css("margin-top", "-5px");
                    $(".first_floor .tip-box").show();
                }
            }
            if ($("#ctl00_ContentPlaceHolder1_TB_Get_Pwd_Mobile").val() != "" && $(".first_floor .tip-box").css("display") != "block" &&
                 $(".second_floor .tip-box").css("display") != "block") {
                send_type = "mobile";
                iscontinue = true;
            }
            if ($("#ctl00_ContentPlaceHolder1_TB_Get_Pwd_Email").val() != "" && $(".first_floor .tip-box").css("display") != "block" &&
                 $(".second_floor .tip-box").css("display") != "block") {
                send_type = "email";
                iscontinue = true;
            }
            if (iscontinue && $(".get_check_code").text() == "获取验证码") {
                $(".get_check_code").css("background","#CCC");
                $.ajax({
                    type: "POST",
                    url: "./UserLogin.aspx?send_type=" + send_type,
                    data: $("form").serialize(),
                    datatype: "text",
                    async: false,
                    success: function (msg) {
                        if (msg > 0) {
                            $("#ctl00_ContentPlaceHolder1_Label_Hide_Message").val(msg);
                            var n = 60;
                            function TimeShow() {
                                if (n > 0) {
                                    n--;
                                    $(".get_check_code").text(n + "秒");
                                }
                                if (n == 0) {
                                    clearInterval(countdown);
                                    $(".get_check_code").text("获取验证码");
                                    $(".get_check_code").css("background", "#1a9dd1");
                                }
                            }
                            countdown = setInterval(TimeShow, 1000);
                        } else
                            alert("信息发送失败");
                    }
                })
            }
        })        
        function ischeck() {
            if ($("#ctl00_ContentPlaceHolder1_TB_Get_Pwd_Mobile").val() == "" && $("#ctl00_ContentPlaceHolder1_TB_Get_Pwd_Email").val() == "") {
                if ($(".fgt_input_mobile").is(":visible")) {
                    $(".first_floor .tip-box .tip").text("不能为空");
                    $(".first_floor .tip-box").css("margin-top", "-35px");
                    $(".first_floor .tip-box").show();
                } else {
                    $(".first_floor .tip-box .tip").text("不能为空");
                    $(".first_floor .tip-box").css("margin-top", "-5px");
                    $(".first_floor .tip-box").show();
                }
            }
            if ($("#ctl00_ContentPlaceHolder1_TB_Reset_Pwd").val() == "") {
                $(".second_floor .tip-box .tip").text("不能为空");
                $(".second_floor .tip-box").show();
            }
            if ($("#ctl00_ContentPlaceHolder1_TB_Check_Code").val() == "") {
                $(".third_floor .tip-box .tip").text("不能为空");
                $(".third_floor .tip-box").show();
            }
            if ($(".first_floor .tip-box").css("display") == "block" || $(".second_floor .tip-box").css("display") == "block" || $(".third_floor .tip-box").css("display") == "block") {
                return false;
            }
            else {
                var check_code_message = $("#ctl00_ContentPlaceHolder1_Label_Hide_Message").val();
                var isright = false;
                $.ajax({
                    type: "POST",
                    url: "./UserLogin.aspx?check_code=" + check_code_message,
                    data: $("form").serialize(),
                    datatype: "text",
                    async: false,
                    success: function (msg) {
                        if (msg == "yes") {
                            isright = true;
                        } else {
                            $(".third_floor .tip-box .tip").text("验证码错误");
                            $(".third_floor .tip-box").show();
                        }
                    }
                })
                if (isright)
                    return turn;
                else
                    return false;
            }
        }
    </script>

</asp:Content>


