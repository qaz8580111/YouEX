<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="JoinUs.aspx.cs" Inherits="WebSite.Help.JoinUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/joinus.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-加入我们</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


     <div class="content">
     <div class="left">
          <div class="k1">
             <div class="shu"></div>
             <a href="JoinUs.aspx"><div class="word">加盟</div></a>
             <div class="san"><img src="../Images/Pic_User/san-6-13.png" /></div>
             <div class="last-div"></div>
             <div class="heng"></div>
          </div>
         <div class="last-div"></div>
          <div class="k1">
             <a href="Experience.aspx"><div class="word1">历程</div></a>
             <div class="last-div"></div>
             <div class="heng"></div>
          </div>
          <div class="last-div"></div>
          <div class="k1">
             <a href="AboutUs.aspx"><div class="word1">关于我们</div></a>
             <div class="last-div"></div>
             <div class="heng"></div>
          </div>
          <div class="last-div"></div>
          <div class="k1">
             <a href="Distribution.aspx"><div class="word1">网点分布</div></a>
             <div class="last-div"></div>
             <div class="heng"></div>
          </div>
          <div class="last-div"></div>
          <div class="k1">
             <a href="ContactUs.aspx"><div class="word1">联系我们</div></a>
             <div class="last-div"></div>
             <div class="heng"></div>
          </div>          
     </div>
    <div class="right">
         <div class="title">加盟</div>
         <div class="explain">期待您的加入，成为覆盖全球的跨境物流引导者</div>
      <div class="explain1">
              我们的<span class="yan">核心优势：</span><br />
              1 首批跨境电子商务物流试点企业<br />
              2 强大的跨境物流系统设计和研发能力<br />
              3 历经锤炼的运营服务团队<br />
              <span class="yan">我们的业务已经已覆盖国家：美国、意大利、法国、德国和西班牙等</span>
      </div>
      <div class="explain">加盟流程：</div>
         <img src="../Images/Pic_User/join-process.png" usemap="#Map" border="0" />
          <map name="Map" id="Map">
            <area alt="" class="tijiao" shape="rect" coords="229,73,336,101" href="#" />
            <area alt="" class="tijiao1" shape="rect" coords="555,93,638,174" href="#" />
          </map>
          <img src="../Images/Pic_User/join-process1.png" usemap="#Map" border="0" />
          <map name="Map" id="Map1">
            <area alt="" class="tijiao" shape="rect" coords="453,133,504,151" href="#" />
            <area alt="" class="tijiao1" shape="rect" coords="555,93,638,174" href="#" />
      </map>
    </div>
  </div>    

    <div class="bj"></div>
  <div class="biao">
     <img class="xx1" src="../Images/Pic_User/XX1.png" />
     <div class="w1">
       <div class="word">您的公司</div>
       <input />
     </div>
     <div class="w2">
       <div class="word">您所在的国家</div>
       <input />
     </div>
     <div class="w2">
       <div class="word">您所从事的行业</div>
       <input />
     </div>
     <div class="w2">
       <div class="word">您是否拥有仓储场地</div>
       <input />
     </div>
     <div class="w2">
       <div class="word">您的姓名</div>
       <input />
     </div>
     <div class="w2">
       <div class="word">您的联系电话</div>
       <input />
     </div>
     <div class="w2">
       <div class="word">您的联系邮箱</div>
       <input />
     </div>
     <div class="tip">您提交了加盟申请后会有商务专员联系您</div>
     <div class="button">申请加盟</div>
  </div>

    <script>
        $(".tijiao,.tijiao1").click(function () {
            $(".bj,.biao").show()
        })
        $(".xx1").click(function () {
            $(".bj,.biao").hide()
        })
        $(".right img").eq(2).hide()
        $(".button a,.right img").eq(1).hide()
        $(".banner-bj a,.one").eq(1).hide()
        $(".banner-bj a").mouseenter(function () {
            $(".banner-bj a").eq(0).hide()
            $(".banner-bj a").eq(1).show()
        }).mouseleave(function () {
            $(".banner-bj a").eq(1).hide()
            $(".banner-bj a").eq(0).show()
        })


        $(".one").mouseenter(function () {
            $(".one").eq(0).hide()
            $(".one").eq(1).show()
        }).mouseleave(function () {
            $(".one").eq(1).hide()
            $(".one").eq(0).show()
        })


        $(".tijiao").mouseenter(function () {
            $(".right img").eq(0).hide()
            $(".right img").eq(2).hide()
            $(".right img").eq(1).show()
        }).mouseleave(function () {
            $(".right img").eq(1).hide()
            $(".right img").eq(0).show()
            $(".right img").eq(2).hide()
        })
        $(".tijiao1").mouseenter(function () {
            $(".right img").eq(0).hide()
            $(".right img").eq(1).hide()
            $(".right img").eq(2).show()
        }).mouseleave(function () {
            $(".right img").eq(1).hide()
            $(".right img").eq(0).show()
            $(".right img").eq(2).hide()
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

        $(".content .left .k1 *").mouseenter(function () {
            $(this).css("color", "#1a9dd1")
        }).mouseleave(function () {
            $(".word1").css("color", "#4c4c4c")
        })
    </script>


</asp:Content>
