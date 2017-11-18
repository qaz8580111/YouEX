<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MobileActivation.aspx.cs" Inherits="WebSite.UserCenter.MobileActivation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/mobileactivation.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-手机激活</title>
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
          <div class="c2">我们向您的注册手机发送短信，请查看验证码及时激活！</div>

          <div class="lastdiv"></div>
          <div class="c5">
              <div class="lastdiv"></div>
              <div class="cc5">
                <div class="lastdiv"></div>
                 <div class="tui"></div>
                  <div class="lastdiv"></div>    
                  <asp:TextBox ID="TB_MobileCheck" runat="server"></asp:TextBox>
                  <asp:Button ID="Button_ActivationMobile" runat="server" Text="确定" CssClass="email_change" OnClick="ActivationMobile" />  
                  <asp:Label ID="Label_HideMsgCode" runat="server"></asp:Label>
              </div> 
              <div class="c1">
              <img src="../Images/Pic_User/wen.png" />
              <div class="msg_word">没有收到短信？</div>
          </div>
          <div class="lastdiv"></div>
          <div class="c3">
              <img src="../Images/Pic_User/deng.png" />
              <div class="re_msg_word">
              <input id="b2" class="cd" type="button" runat="server" onserverclick="ReSendMobile" value="重新发送" />
              <div class="countdown"></div>
              </div>         
          </div>
          </div>
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
        $(".isactive").click(function () {
            $.ajax({
                type: "POST",
                url: "./MobileActivation.aspx?isactive=ok",
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

        /*$(function () {
            $(".cd").bind("click", function () {
                $.cookie('CountDown', '', { expires: -1 });
                $this = $(this);
                //没有被禁用时禁用并执行倒计时
                if (!$this[0].disabled) {
                    $this[0].disabled = 'disabled';
                    if ($this.attr("id") == "b1") {
                        inter1 = setInterval(function () { countDown($this) }, 1000)
                    }
                    if ($this.attr("id") == "b2") {
                        inter2 = setInterval(function () { countDown($this) }, 1000)
                    }

                }
            })
        })*/
    </script>


</asp:Content>
