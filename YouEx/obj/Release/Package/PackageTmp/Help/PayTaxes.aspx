<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="PayTaxes.aspx.cs" Inherits="WebSite.Help.PayTax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/paytax.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-税金代缴</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="Label_IsShow" runat="server" Text=""></asp:Label>
    <asp:Label ID="Label_HideShippingOrder" runat="server" Text=""></asp:Label>
    <div class="content">
    <div class="title">税金查询代缴系统</div>
    <div class="search">
        <input type="text" name="search_shippingorder" placeholder='请输入联邦转运快递单号,如:900091000178' />
        <input type="button" class="search_button" value="查询缴税" runat="server" onclick="if (!Check_Taxes()) { return false; }" onserverclick="searchClick" />
        <div class="lastdiv"></div>
        <div class="isnonetaxes">没有查询到该快递单号</div>
        <div class="lastdiv"></div>
        <asp:Image ID="Image_Tax" runat="server" />
        <div>
            <asp:Button ID="Button_Tax" runat="server" Text="立即缴税" OnClick="PayTax_Button" />
            <asp:Button ID="Button_Tax_Finish" runat="server" Text="已完成缴税" Enabled="false" />
        </div>
    </div>
        
</div>   

    <script>
        function Check_Taxes(){
            if ($("input[name='search_shippingorder']").val() == "") {
                $("input[name='search_shippingorder']").css("border", "2px solid red");
                return false;
            }
            return true;
        }
        $(".search_button").blur(function () {
            $("input[name='search_shippingorder']").css("border", "2px solid #7EA3B2");
        })
        if ($("#ctl00_ContentPlaceHolder1_Label_IsShow").text() == "yesyes") {
            $("#ctl00_ContentPlaceHolder1_Image_Tax").show();
            $("#ctl00_ContentPlaceHolder1_Button_Tax_Finish").show();
        }
        if ($("#ctl00_ContentPlaceHolder1_Label_IsShow").text() == "yes"){
            $("#ctl00_ContentPlaceHolder1_Image_Tax").show();
            $("#ctl00_ContentPlaceHolder1_Button_Tax").show();
        }
        if ($("#ctl00_ContentPlaceHolder1_Label_IsShow").text() == "none")
            $("#ctl00_ContentPlaceHolder1_Image_Tax").hide();
        if ($("#ctl00_ContentPlaceHolder1_Label_IsShow").text() == "no")
            $(".isnonetaxes").show();
    </script>
</asp:Content>
