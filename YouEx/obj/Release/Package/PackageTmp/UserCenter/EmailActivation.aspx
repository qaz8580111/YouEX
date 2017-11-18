<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="EmailActivation.aspx.cs" Inherits="WebSite.UserCenter.EmailActivation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/emailactivation.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-邮箱激活</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content">
    <div class="content-box">
       <div class="left">
          <div class="sign">1.注册</div>
          <img class="jian-16" src="../Images/Pic_User/jian-16.png" />
          <div class="activation">2.激活</div>
          <div class="lastdiv"></div>
          <div class="line"></div>
          <div class="c1">
              <img src="../Images/Pic_User/gou.png" />
              <div class="word">请激活！</div>
          </div>
          <div class="lastdiv"></div>
          <div class="c2">我们向您的注册邮箱发送了一封激活邮件，请及时激活！</div>
           <asp:Button ID="Button_EnterEmail" runat="server" Text="进入邮箱" CssClass="button-mail" OnClick="EnterEmail" />
          <div class="c1">
              <img src="../Images/Pic_User/wen.png" />
              <div class="word">没有收到激活邮件？</div>
          </div>
          <div class="lastdiv"></div>
          <div class="c3">
              <img src="../Images/Pic_User/deng.png" />
              <div class="word">
              <input id="b2" class="cd" type="button" runat="server" onserverclick="ReSendEmail" value="重新发送" />
              <div class="countdown"></div>
              </div>         
          </div>
          <div class="lastdiv"></div>
          <div class="ver-line"></div>
       </div>
       <div class="right">
          <div><img src="../Images/Pic_Main/sao-weixin.jpg" /></div>
          <div class="word">已有帐号,赶紧登录</div>
          <div class="isactive"><img src="../Images/Pic_Main/login-small.jpg" /></div>
       </div>
    </div>
 </div>




    <script>
        if ($.cookie('CountDown') == null) {
            var i = 60;
            var countdown = null;
            function timeShow() {
                if (i > 0) {
                    i--;
                    $.cookie("CountDown", i, { expires: 1 / 26400 });
                    $(".countdown").html("已发送，" + i + "秒可重新发送");
                }
                if (i == 0) {
                    clearInterval(countdown);
                    $(".countdown").hide();
                    $(".cd").show();
                    $.cookie('CountDown', '', { expires: -1 });
                }
            };
            countdown = setInterval(timeShow, 1000);
        }
        if ($.cookie('CountDown') > 0) {
            var countdown = null;
            function timeShow_() {
                var n = parseInt($.cookie('CountDown'));
                if (n > 0) {
                    n--;
                    $.cookie("CountDown", n, { expires: 1 / 26400 });
                    $(".countdown").html("已发送，" + n + "秒可重新发送");
                }
                if (n == 0) {
                    clearInterval(countdown);
                    $(".countdown").hide();
                    $(".cd").show();
                    $.cookie('CountDown', '', { expires: -1 });
                }
            }
            countdown = setInterval(timeShow_, 1000);
        }

        //账户是否激活
        $(".isactive").click(function(){
            $.ajax({
                type: "POST",
                url: "./EmailActivation.aspx?isactive=ok",
                data: $("form").serialize(),
                datatype: "text",
                success: function (msg) {
                    if (msg == "yes") {
                        alert("请激活账户或者退出登录");
                    } else
                        location.href = "UserLogin.aspx";
                }
            })
        })
    </script>




</asp:Content>
