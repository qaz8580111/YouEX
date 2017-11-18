<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebSite.WebSite.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="../Include/CSS/index.css"  />
    <script type="text/javascript" src="../Include/JS/jquery.min.js"></script>
    <link rel="shortcut icon" href="./Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-跨境物流专业服务供应商</title>
</head>
<body>
    <form id="form1" runat="server">
   <div class="top-nav-bj">

     <div class="top-nav-box">
       <div class="top-nav">
          <div class="left">
           <a href="../Default.aspx"> <img src="../Images/Pic_Main/logo.jpg" /></a> 
            <a href="./Help/Price.aspx">资费与支付</a>
            <a href=".">API</a>
            <a href="./Package/Search.aspx"><img class="one" src="../Images/Pic_Main/top-anniu.jpg" /></a> 
          </div>
          <div class="right" >
            <a href="./Help/Help.aspx">帮助中心</a><span class="help_height">&nbsp;|&nbsp;</span>
            <a href="../UserCenter/UserLogin.aspx">登录</a><a href="../UserCenter/UserRegister.aspx">注册&nbsp;&nbsp;</a>
            <span class="kefunocss">客服服务热线：4007-280-360&nbsp;|&nbsp;</span>
            <a href="http://crm2.qq.com/page/portalpage/wpa.php?uin=4007280360&aty=0&a=0&curl=&ty=1" target="_blank">在线客服&nbsp;|&nbsp;</a>
          </div>
          <div class="right">
            <a href="./Help/Help.aspx">帮助中心</a><span class="help_height">|&nbsp;</span>
            <input id="user_loginout" class="user_loginout" type="button" value="退出" runat="server" onclick="if (!isloginout()) { return false; };" onserverclick="UserLoginOut" />
              <asp:Label ID="Label_LoginName" runat="server" Text=""></asp:Label>&nbsp;&nbsp;<span class="kefunocss">客服服务热线：4007-280-360&nbsp;|&nbsp;</span>
              <a  href="http://crm2.qq.com/page/portalpage/wpa.php?uin=4007280360&aty=0&a=0&curl=&ty=1" target="_blank">在线客服&nbsp;|&nbsp;</a>
          </div>
           <asp:Label ID="Label_Show_LoginOut" runat="server" Text=""></asp:Label>

           <script>
               $("#Label_Show_LoginOut").hide();
               if ($("#Label_Show_LoginOut").text() == "user") {
                   $(".right").eq(0).hide();
               } else {
                   $(".right").eq(1).hide();
               }
               function isloginout() {
                   if (confirm("是否确定退出帐户？") == true) {
                       return true;
                   } else
                       return false;
               }      
           </script>

       </div> 
     </div>
  </div>

    <div class="banner-bj">
        <div class="news-box" onMouseMove="ting()" onMouseOut="dong()">
            <asp:Literal ID="Literal_News" runat="server">
                <div class="news1" ><img src="../Images/Pic_User/laba1.png">
                    <a href="../Help/NewsNotice.aspx?NewsId=newsidHere"><span title="titleHere">titleHere</span></a>
                </div>
            </asp:Literal>
        </div>

        <img class="banner" src="../Images/Pic_Main/banner.jpg" />
        <img class="icon" src="../Images/Pic_Main/big-ICON.png" />
        <div class="banner-word1">联邦转运</div>
        <div class="banner-word2">跨境物流引导者</div>
        <a href="./UserCenter/UserCenter.aspx"><img src="../Images/Pic_Main/banner-word.png" /></a>
      </div>
      <div class="co-brand">
         <img src="../Images/Pic_Main/Co brand.png" usemap="#Map" />
         <map name="Map">
           <area shape="rect" alt="" coords="-6,-13,88,48" href="http://www.amazon.com/" target="_blank" />
           <area shape="rect" alt="" coords="94,-21,198,36" href="http://www.ebay.com/" target="_blank" />
           <area shape="rect" alt="" coords="204,-19,299,35" href="http://www.ashford.com" target="_blank" />
           <area shape="rect" alt="" coords="312,-10,429,38" href="http://www.gnc.com/home/index.jsp" target="_blank" />
           <area shape="rect" alt="" coords="439,-3,569,38" href="http://www.6pm.com/" target="_blank" />
           <area shape="rect" alt="" coords="586,-3,632,39" href="http://www.11jishi.com/" target="_blank" />
           <area shape="rect" alt="" coords="651,-9,785,35" href="http://www.bybieyang.com/" target="_blank" />
           <area shape="rect" alt="" coords="794,3,899,32" href="http://www.iherb.com/" target="_blank" />
           <area shape="rect" alt="" coords="908,0,1018,34" href="http://www.rakuten.co.jp/" target="_blank" />
           <area shape="rect" alt="" coords="1025,-4,1168,38" href="#" target="_blank" />
         </map>
      </div>
      <div class="banner-word4">天下大同&nbsp;&nbsp;物畅其流</div>
      <div class="content-bj">
         <div class="content-box">
            <div class="content-icon1"><a href="./Help/Cooperation.aspx"><img src="../Images/Pic_Main/cilun.png"  /></a></div>
            <div class="content-text">
               <div class="content-title1">化繁为简&nbsp;&nbsp;便捷快速</div>
               <div class="content-text1">联邦转运集合众多海淘商城&nbsp;&nbsp;化繁为简<br/>让您轻松选购&nbsp;&nbsp;快速转运&nbsp;&nbsp;轻松完成繁杂的运单操作</div>
               <a href="./Help/Cooperation.aspx" class="content-href">看看我们的合作商城</a>
            </div>
            <div class="lastdiv"></div>
           <div class="content-icon2"><a href="./Help/Help.aspx"><img src="../Images/Pic_Main/xuetang.png" /></a></div>
           <div class="content-text2">
               <div class="content-title2">联邦动态&nbsp;&nbsp;帮助中心</div>
               <div class="content-text3">您可以通过这里了解常见的海淘问题和知识<br/>
    时刻关注联邦转运的动态&nbsp;&nbsp;获取最新的优惠福利 </div>
              <a href="./Help/Help.aspx" class="content-href2">我们的动态和帮助中心</a>
            </div>
             <div class="lastdiv"></div>
	       <div class="content-icon3"><a href="./Help/Price.aspx"><img src="../Images/Pic_Main/jiage.png" /></a></div>
           <div class="content-text4">
               <div class="content-title3">服务多一点&nbsp;&nbsp;运费少一点</div>
               <div class="content-text5">你可以透过预先储值，&nbsp;升级会员等级<br/>
    费用更精省，&nbsp;服务更提升 </div>
               <a href="./Help/Price.aspx" class="content-href3">我们的服务和优惠</a>
            </div>
        </div>
      </div>


  <div class="lastdiv"></div>
  <div class="button"><a href="./UserCenter/UserCenter.aspx"><img src="../Images/Pic_Main/banner-word2.png" /></a></div>
     <div class="last-nav-bj">
     <div class="last-nav-box">
        <a class="left" href="http://www.miitbeian.gov.cn">浙ICP备16005428号</a>
        <div class="right">
          <a href="./Help/JoinUs.aspx">加盟</a>&nbsp;&nbsp;
          <a href=".">历程</a>&nbsp;&nbsp;
          <a href="./Help/AboutUs.aspx">关于我们</a>&nbsp;&nbsp;
          <a href="./Help/Distribution.aspx">网点分布</a>&nbsp;&nbsp;
          <a href="./Help/Cooperation.aspx">我的合作伙伴</a>&nbsp;&nbsp;
          <a href="./Help/ContactUs.aspx">联系我们</a>&nbsp;&nbsp;
          <a href="."><img src="../Images/Pic_Main/in.png" /></a>&nbsp;&nbsp;
          <a href="."><img src="../Images/Pic_Main/weibo.png" /></a>&nbsp;&nbsp;
          <a href=".";class="weixin"><img src="../Images/Pic_Main/weixin.png" /></a>
            
        </div>
     </div>
  </div>


    <ul class="side-bar">
    <li class="qq-ship">
       <dl> 
          <dd><script charset="utf-8" type="text/javascript" src="http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODAwMTg4N18xMjU5MDdfNDAwNzI4MDM2MF8"></script></dd>
          <dd><script charset="utf-8" type="text/javascript" src="http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODAwMTg4N18xMjU5MDdfNDAwNzI4MDM2MF8"></script></dd>
       </dl>
    </li>
    <li class="tool-ship">
       <dl> 
         <dd><img src="../Images/Pic_Main/tool-show1.png" /></dd>
         <a href="./Help/ToolCalculate.aspx"><dd class="yunfei">运费估算</dd></a>
         <a href="./Help/ToolSize.aspx"><dd class="cima">尺码工具</dd></a>
         <a href="./Help/PayTaxes.aspx"><dd class="suilv">缴税平台</dd></a>
       </dl>
    </li>

    <li class="weixin-ship">
       <dl>
          <dd><img class="weixin_erweima" src="../Images/Pic_Main/erweima.png" /></dd>
       </dl>
    </li>
     <li class="help-ship"></li>
 </ul>



    </form>
</body>

    <script type="text/javascript">
        $("dl").eq(0).css("margin-left", 90);
        $("dl").eq(1).css("margin-left", 125);
        $("dl").eq(2).css("margin-left", 120);
        $(".side-bar li").eq(0).mouseenter(function () {
            $(this).children().animate({ marginLeft: -90 });
        }).mouseleave(function () {
            $(this).children().animate({ marginLeft: 90 });
        })
        $(".side-bar li").eq(1).mouseenter(function () {
            $(this).children().animate({ marginLeft: -125 });
        }).mouseleave(function () {
            $(this).children().animate({ marginLeft: 125 });
        })
        $(".side-bar li").eq(2).mouseenter(function () {
            $(this).children().animate({ marginLeft: -120 });
        }).mouseleave(function () {
            $(this).children().animate({ marginLeft: 120 });
        })

        $(".top-nav a").mouseenter(function () {
            $(this).css("color", "#1a9dd1").mouseleave(function () {
                $(this).css("color", "#FFF")
            })
        })
        $(".last-nav-bj a").mouseenter(function () {
            $(this).css("color", "#1a9dd1").mouseleave(function () {
                $(this).css("color", "#FFF")
            })
        })        
        $(".top-nav a").mouseenter(function (){
            $(this).css("color", "#1a9dd1").mouseleave(function(){
                $(this).css("color", "#FFF")
            })
        })
        $(".user_loginout").mouseenter(function () {
            $(this).css("color", "#1a9dd1").mouseleave(function () {
                $(this).css("color", "#FFF")
            })
        })
        $(".side-bar .help-ship").click(function () {
            $("html,body").animate({ scrollTop: 0 })
        })
        $(".tool-ship a").mouseenter(function () {
            $(this).children().css("color", "#a1daf0")
        })
        $(".tool-ship a").mouseleave(function () {
            $(this).children().css("color", "#FFF")
        })
        $(".last-nav-bj a").mouseenter(function () {
            $(this).css("color", "#1a9dd1").mouseleave(function () {
                $(this).css("color", "#FFF")
            })
        })
        $("#Label_LoginName").mouseenter(function () {
            $(this).css("text-decoration", "underline").mouseleave(function () {
                $(this).css("text-decoration", "none")
            })
        })
        $("#Label_LoginName").click(function () {
            location.href = "./UserCenter/UserCenter.aspx";
        })

        /*新闻导读*/
        $(".news-box .news1").hide().first().show()
        var x = 0;
        z = true
        function y() {
            if (z) {
                if (x < $(".news-box .news1").length - 1) { x = x + 1 } else { x = 0 }
                $(".news-box .news1").slideUp().eq(x).show()
            } else { $(".news-box .news1").hide().eq(x).show() }

        }
        setInterval(y, 3000)
        function ting() {
            z = false
        }
        function dong() {
            z = true
        }
        $(".news-box .news1").mouseenter(function () {
            $(".news-box span").css("border-bottom", "solid 1px #fff").mouseleave(function () {
                $(".news-box span").css("border-bottom", "none")
            });
            $(".news-box span")
        })
  </script>

</html>
