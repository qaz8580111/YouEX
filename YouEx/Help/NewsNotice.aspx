<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="NewsNotice.aspx.cs" Inherits="WebSite.Help.NewsNotice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/newsnotice.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-重要通知</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="content">
     <div class="news-nav">
        <a href="NewsNotice.aspx"><div class="word1">新闻中心</div></a>
        <a href="NewsNotice.aspx?typeid=1"><div class="word2">重要通知</div></a>
        <a href="NewsNotice.aspx?typeid=2"><div class="word2">行业新闻</div></a>
        <a href="NewsNotice.aspx?typeid=3"><div class="word2">最新优惠</div></a>
        <div class="last-div"></div>
        <div class="line-blue"></div>
        <div class="line"></div>
         <asp:Label ID="Label_Hidden_WhichPage" runat="server" Text=""></asp:Label>
     </div>

    <asp:Label ID="Label_HideStrItemFinal" runat="server" Text="" CssClass="hidestritemfinal"></asp:Label>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel_News" runat="server">
        <ContentTemplate>
            <div class="news-title">
            <asp:Literal ID="Literal_News" runat="server">
                    <div class="word2">
                    <img class="laba" src="../Images/Pic_User/laba.png" />
                    <div class="news_redirect"><div class="c-word"><a href="NewsNotice.aspx?newsid=newsidHere">titleHere</a></div></div>
                    <div class="c-word2">createtimeHere</div>
                    <div class="last-div"></div>
                    <img class="xuxian" src="../Images/Pic_User/xuxian-1110.png" />
                    </div>
            </asp:Literal>
            </div>
        
            <div class="page_action">
                <asp:Button ID="Button_FirstPage" runat="server" Text="首页" OnClick="FirstPageClick" />
                <asp:Button ID="Button_PrevPage" runat="server" Text="上一页" OnClick="PrevPageClick" />
                <asp:Button ID="Button_NextPage" runat="server" Text="下一页" OnClick="NextPageClick" />
                <asp:Button ID="Button_LastPage" runat="server" Text="末页" OnClick="LastPageClick" />
                <asp:Label ID="Label_IsPage" runat="server" Text=""></asp:Label>
                <asp:Label ID="Label_CountPage" runat="server" Text=""></asp:Label>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
        

    <div class="news-content">
        <div class="news-content-t">
            <asp:Label ID="NewsContent_Title" runat="server" Text=""></asp:Label>
        </div>
        <div class="news-content-w">
            <asp:Label ID="NewsContent_CreateTime" runat="server" Text=""></asp:Label>
        </div>
        <div class="news-content-w1">
            <asp:Label ID="NewsContent_Author" runat="server" Text=""></asp:Label>
        </div>
        <div class="last-div"></div>
        <div class="line1"></div>
        <div class="news-content-w2">
            <asp:Label ID="NewsContent_Content" runat="server" Text=""></asp:Label>
        </div>
    </div>


    <div class="comment">
        <div class="red"></div>
        <div class="comment-w1">评论</div>
        <div class="last-div"></div>
        <asp:Image ID="Image_MyAvatar" runat="server" />
        <textarea name="comment_content" placeholder="来说两句吧（最多100字）"></textarea>
        <div class="last-div"></div>
        <input type="button" class="fabiao" runat="server" onclick="if (!submitcomment()){ return false; };" onserverclick="SubmitComment" value="发表" />
        <div class="last-div"></div>
        <div class="comment-w2">最新评论</div>
        <div class="line2"></div>

        <asp:Label ID="Label_HideStrItemFinalComment" runat="server" Text="" CssClass="hidestritemfinalcomment"></asp:Label>
        <asp:UpdatePanel ID="UpdatePanel_Comment" runat="server">
            <ContentTemplate>
                <div class="nocomment">暂无评论，赶快来抢沙发吧</div>
                <asp:Literal ID="Literal_Comment" runat="server">
                    <div class="comment-right">
                        <div class="comment-m1">realnameHere</div>
                        <div class="comment-t1">createtimeHere</div>
                        <div class="last-div"></div>
                        <div class="comment-w3">contentHere</div>
                    </div>
                    <div>
                        <div class="last-div"></div>
                        <img id="zan_commentidHere" class="zan" src="../Images/Pic_User/zan.png" />
                        <div class="comment-w4">upcountHere</div>
                        <img id="cai_commentidHere" class="cai" src="../Images/Pic_User/cai.png" />
                        <div class="comment-w4">downcountHere</div> 
                        <div class="last-div"></div>          
                        <div class="line1"></div>
                    </div>
                </asp:Literal>

                <div class="input-box1">
                    <asp:Button ID="Button_FirstPage_Comment" runat="server" Text="首页" OnClick="FirstPageCommentClick" />
                    <asp:Button ID="Button_PrevPage_Comment" runat="server" Text="上一页" OnClick="PrevPageCommentClick" />
                    <asp:Button ID="Button_NextPage_Comment" runat="server" Text="下一页" OnClick="NextPageCommentClick" />
                    <asp:Button ID="Button_LastPage_Comment" runat="server" Text="末页" OnClick="LastPageCommentClick" />
                    <asp:Label ID="Label_IsPage_Comment" runat="server" Text=""></asp:Label>
                    <asp:Label ID="Label_CountPage_Comment" runat="server" Text=""></asp:Label>
                    <asp:Label ID="Label_CountPage_NewsId" runat="server" Text=""></asp:Label>
                </div>
                <asp:Image ID="Image_UserAvatar_1" runat="server" />
                <asp:Image ID="Image_UserAvatar_2" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        
    </div>
  </div>


    <script>
        $(".input-box1 .input-2").eq(0).addClass("input-state")
        $(".input-box .input-2").eq(0).addClass("input-state")
        $(".content .input-3").mouseenter(function () {
            $(this).addClass("input-state").mouseleave(function () {
                $(this).removeClass("input-state")
            })
        })
        $(".content .input-2").click(function () {
            $(this).siblings().removeClass("input-state")
            $(this).addClass("input-state")
        })
        $("#ctl00_ContentPlaceHolder1_Button_FirstPage,#ctl00_ContentPlaceHolder1_Button_PrevPage," +
        "#ctl00_ContentPlaceHolder1_Button_NextPage,#ctl00_ContentPlaceHolder1_Button_LastPage").mouseenter(function(){
            $(this).css("background", "#1a9dd1");
            $(this).css("color", "white");
        }).mouseleave(function () {
            $(this).css("background", "#F0F0F0");
            $(this).css("color", "#666");
        })
        $(".news-title .word2").mouseenter(function () {
            $(this).find(".c-word").css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).find(".c-word").css("text-decoration", "none");
        })
        function submitcomment() {
            if ($("textarea[name='comment_content']").val() == "")
            {
                alert("评论内容不可为空");
                return false;
            }
            else
                return true;
        }
        FlushUserAvatar();
        function FlushUserAvatar() {
            if ($("#ctl00_ContentPlaceHolder1_Image_UserAvatar_1").attr("src") != "") {
                $("#ctl00_ContentPlaceHolder1_Image_UserAvatar_1").insertBefore($("#ctl00_ContentPlaceHolder1_UpdatePanel_Comment .comment-right").eq(0));
                $("#ctl00_ContentPlaceHolder1_Image_UserAvatar_1").show();
            }
            if ($("#ctl00_ContentPlaceHolder1_Image_UserAvatar_2").attr("src") != "") {
                $("#ctl00_ContentPlaceHolder1_Image_UserAvatar_2").insertBefore($("#ctl00_ContentPlaceHolder1_UpdatePanel_Comment .comment-right").eq(1));
                $("#ctl00_ContentPlaceHolder1_Image_UserAvatar_2").show();
            }
            if ($("#ctl00_ContentPlaceHolder1_Image_UserAvatar_1").attr("src") == "" && $("#ctl00_ContentPlaceHolder1_Image_UserAvatar_2").attr("src") == "")
                $(".nocomment").show();
            $(".zan").click(function () {
                var commentid = this.id.split("_")[1];
                var obj_zan = $(this).parent().find(".comment-w4").eq(0);
                var obj_zan_count = parseInt(obj_zan.text()) + 1;
                $.ajax({
                    type: "POST",
                    url: "../Ashx/common.ashx?upcount=" + commentid + "_" + obj_zan_count,
                    data: $("form").serialize(),
                    datatype: "text",
                    success: function (msg) {
                        if (msg == "yes")
                            obj_zan.text(obj_zan_count);
                    }
                })
            })

            $(".cai").click(function () {
                var commentid = this.id.split("_")[1];
                var obj_cai = $(this).parent().find(".comment-w4").eq(1);
                var obj_cai_count = parseInt(obj_cai.text()) + 1;
                $.ajax({
                    type: "POST",
                    url: "../Ashx/common.ashx?downcount=" + commentid + "_" + obj_cai_count,
                    data: $("form").serialize(),
                    datatype: "text",
                    success: function (msg) {
                        if (msg == "yes")
                            obj_cai.text(obj_cai_count);
                    }
                })
            })
        }
        if (window.location.href.indexOf("NewsId") > 0)
        {
            var id = window.location.href.split("=")[1];
            $("#newsindex_" + id).click();
        }
        if ($("#ctl00_ContentPlaceHolder1_Label_Hidden_WhichPage").text() == "1") {
            $(".line-blue").css("margin-left", "105px");
            $(".content .news-nav .word1").css("color", "#808080");
            $(".content .news-nav .word2").eq(0).css("color", "#4c4c4c");
        }
        if ($("#ctl00_ContentPlaceHolder1_Label_Hidden_WhichPage").text() == "2") {
            $(".line-blue").css("margin-left", "213px");
            $(".content .news-nav .word1").css("color", "#808080");
            $(".content .news-nav .word2").eq(1).css("color", "#4c4c4c");
        }
        if ($("#ctl00_ContentPlaceHolder1_Label_Hidden_WhichPage").text() == "3") {
            $(".line-blue").css("margin-left", "318px");
            $(".content .news-nav .word1").css("color", "#808080");
            $(".content .news-nav .word2").eq(2).css("color", "#4c4c4c");
        }
  </script>


</asp:Content>
