<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="WebSite.Package.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/tracksearch.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-物流查询</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content">
    <div class="title">包裹追踪</div>
        <div class="lastdiv"></div>
        <div class="search">
        <input type="text" name="search_shippingorder" placeholder='请输入运单号,如：HE50110370TW' />
        <input type="button" class="search_button" value="查询包裹" runat="server" onclick="if (!Check_Search()) { return false; };" onserverclick="searchClick" />
        <div class="isnoneshipping"></div>
        
            <table class="trackinfo">
                <tr>
                    <td class="word_title_time">时间</td>
                    <td class="word_title_message">物流信息</td>
                </tr>
                <asp:Literal ID="Literal_AllTrack" runat="server">
                    <tr>
                        <td class="word_time">tracktimeHere</td>
                        <td class="word_message">messageHere</td>
                    </tr>
                    <script>
                        if ("isshowHere" == "yes")
                            $(".trackinfo").show();
                        if ("isshowHere" == "no")
                            $(".isnoneshipping").text("没有您所需要查询的单号，请重新确认再进行查询");
                        if ("isshowHere" == "none")
                            $(".isnoneshipping").text("");
                    </script>
                </asp:Literal>
            </table>
        </div>

 </div>

    <script>
        function Check_Search() {
            if ($("input[name='search_shippingorder']").val() == "") {
                $("input[name='search_shippingorder']").css("border", "2px solid red");
                return false;
            }
            return true;
        }
        $(".search_button").blur(function () {
            $("input[name='search_shippingorder']").css("border", "2px solid #7EA3B2");
        })
    </script>

</asp:Content>
