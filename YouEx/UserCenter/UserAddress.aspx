<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="UserAddress.aspx.cs" Inherits="WebSite.UserCenter.UserAddress" EnableEventValidation="false" %>
<%@ Register Assembly="WebSite" Namespace="WebSite.Tool.Control" TagPrefix="nac" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/useraddress.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-地址簿</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="last-div"></div>
  <div class="top-title">
    <div>用户中心</div>
      <!--<asp:Label ID="Label_IsFirst" runat="server" Text=""></asp:Label>-->
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
     <div class="table"> 
       <table  cellpadding="0" cellspacing="0">
          <tr style="height:40px;">
            <td class="t1">&nbsp;</td>
            <td class="t2">地址名</td>
            <td class="t3">收货人</td>
            <td class="t4">收货人地址</td>
            <td class="t5">手机号码</td>
            <td class="t6">邮编</td>
            <td class="t7">身份证号码</td>
            <td class="t9">操作</td>
          </tr>
           <asp:Literal ID="Literal_AllAddress" runat="server">
          <tr>
            <td class="tt1"><input type="radio" name="isedit_address" id="iseditaddress_nameHere"/></td>
            <td class="tt2">nameHere</td>
            <td class="tt3">recipientsHere</td>
            <td class="tt4">countryHere&nbsp;provinceHere&nbsp;cityHere&nbsp;addressHere</td>
            <td class="tt5">mobileHere</td>
            <td class="tt6">zipcodeHere</td>
            <td class="tt7">idcardHere</td>
            <td class="deluseradd" id="deluseradd_nameHere">删除</td>
          </tr>
            </asp:Literal>
        </table>
     </div>
          
     <div class="button4">新增收货地址</div>
     <div class="button5">修改收货地址</div>
     <div class="last-div"></div>
      <div class="line3"><img src="../Images/Pic_User/xuxian-650.png" /></div>
      <div class="c1">
         <div class="word">地址分类：</div>
          <nac:TextBox ID="TB_Address_Name" CanBeNull="必填" ValidationGroup="AddAddress" runat="server" placeholder="每个地址名称必须不同。如：地址1，地址2" ></nac:TextBox>
          <div class="diffrent_addressname_notice">地址分类名不可相同</div>
      </div>
      <div class="last-div"></div>
      <div class="c2">
          <div class="word">收货人：</div>
          <nac:TextBox ID="TB_Address_Recipients" CanBeNull="必填" ValidationGroup="AddAddress" runat="server"></nac:TextBox>
      </div>
      <div class="last-div"></div>
      <div class="c3">
          <div class="word">收货人手机：</div>
          <nac:TextBox ID="TB_Address_Mobile" CanBeNull="必填" ValidationGroup="AddAddress" runat="server" RequiredFieldType="移动手机"></nac:TextBox>
      </div>
      <div class="last-div"></div>
       <div class="c4">
          <div class="word">所在地区：</div>
           <div class="last-div"></div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:DropDownList ID="DropDownList_country" runat="server" style="margin-left: 420px;" >
                    <asp:ListItem Value="0" Text="--请选择国家--" Selected="True"></asp:ListItem>
                </asp:DropDownList>            
                <asp:DropDownList ID="DropDownList_province" runat="server" >
                    <asp:ListItem Value="0" Text="--请选择省份--" Selected="True"></asp:ListItem>
                </asp:DropDownList>            
                <asp:DropDownList ID="DropDownList_city" runat="server" >
                    <asp:ListItem Value="0" Text="--请选择城市--" Selected="True"></asp:ListItem>
                </asp:DropDownList>
            </ContentTemplate>
        </asp:UpdatePanel>
           <dialog ></dialog>
      </div>
      <div class="last-div"></div>
      <div class="c5">
          <div class="word">收货地址：</div>
           <nac:TextBox ID="TB_Address_Address" CanBeNull="必填" ValidationGroup="AddAddress" runat="server" placeholder="仅需街道地址，如：XX路XX号XX室"></nac:TextBox>
      </div>
      <div class="last-div"></div>
      <div class="c6">
          <div class="word">邮编：</div>
          <nac:TextBox ID="TB_Address_ZipCode" CanBeNull="可为空" ValidationGroup="AddAddress" runat="server"></nac:TextBox>
      </div>
      <div class="last-div"></div>
      <div class="c5">
          <div class="word">证件类型：</div>
          <asp:DropDownList ID="DropDownList_CardType" runat="server">
              <asp:ListItem Value="0" Text="--请选择证件类型--" Selected="True"></asp:ListItem>
              <asp:ListItem Value="1" Text="身份证" ></asp:ListItem>
              <asp:ListItem Value="2" Text="驾驶证" ></asp:ListItem>
              <asp:ListItem Value="3" Text="军官证" ></asp:ListItem>
              <asp:ListItem Value="4" Text="护照" ></asp:ListItem>
          </asp:DropDownList>
      </div>
      <div class="last-div"></div>
      <div class="c8">
          <div class="word">请输入证件号码：</div>
          <nac:TextBox ID="TB_Address_IdCard" CanBeNull="必填" ValidationGroup="AddAddress" runat="server" RequiredFieldType="身份证号码"></nac:TextBox>
      </div>
      <div class="last-div"></div>
      <div class="c9">
          <div class="word">身份证正面：</div>
          <asp:FileUpload ID="uploadPicFront" runat="server" />
          <asp:Image ID="IdCardFront" runat="server"  />
      </div>
      <div class="last-div"></div>
      <div class="c9">
          <div class="word">身份证反面：</div>
          <asp:FileUpload ID="uploadPicBack" runat="server" />
          <asp:Image ID="IdCardBack" runat="server" />
      </div>
</div>

   <div class="last-div"></div>
   <div class="return-button-box">
     <nac:Button ID="Button_AddUserAddress" ValidationGroup="AddAddress" runat="server" Text="确定增加" OnClick="addAddress" OnClientClick="if(!Check_Address_Info(this)){return false;};" />
     <nac:Button ID="Button_EditUserAddress" ValidationGroup="AddAddress" runat="server" Text="确定修改" OnClick="updateAddress" OnClientClick="if(!Check_Address_Info(this)){return false;};" />
     <a href="UserCenter.aspx"><div class="button2">返回</div></a>
  </div>

    <asp:Label ID="Label_ShowTable" runat="server" Text="" CssClass="showtable"></asp:Label>
    <script>
        $(".button4").click(function () {
            location.href = "./UserAddress.aspx";

        })
        $("input[name='isedit_address']").click(function () {
            var addressname = this.id.split("_")[1];
            location.href = "./UserAddress.aspx?edit_addressno=" + addressname;
        })
        $("#ctl00_ContentPlaceHolder1_Button_AddUserAddress,.button2,.button4,.button5").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
    </script>

    <asp:Literal ID="Literal_Address" runat="server">
    <script>
        $(function () {
            if ("iseditHere" == "True") {
                $("#ctl00_ContentPlaceHolder1_Button_EditUserAddress").show();
                $("#ctl00_ContentPlaceHolder1_Button_AddUserAddress").hide();
                $("#ctl00_ContentPlaceHolder1_TB_Address_Recipients").val("recipientsHere");
                $("#ctl00_ContentPlaceHolder1_TB_Address_Name").val("nameHere");
                $("#ctl00_ContentPlaceHolder1_TB_Address_Mobile").val("mobileHere");
                $("#ctl00_ContentPlaceHolder1_TB_Address_ZipCode").val("zipcodeHere");
                $("#ctl00_ContentPlaceHolder1_TB_Address_Address").val("addressHere");
                $("#ctl00_ContentPlaceHolder1_TB_Address_IdCard").val("idcardHere");
                $("#ctl00_ContentPlaceHolder1_DropDownList_country option[value='countryHere']").prop("selected", true);
                $("#ctl00_ContentPlaceHolder1_DropDownList_province option[value='provinceHere']").prop("selected", true);
                $("#ctl00_ContentPlaceHolder1_DropDownList_city option[value='cityHere']").prop("selected", true);
                $(".button5").css("background-color", "#1A9DD1");
                $(".button5").css("color", "white");
                $(".button4").css("background-color", "#BFBFBF");
                $(".button4").css("color", "#4C4C4C");
            }
            if ($(".showtable").text() == "none")
                $(".table").hide();
            /*if($("#ctl00_ContentPlaceHolder1_Label_IsFirst").text() == "isfirst")
                alert("亲爱的用户，由于您是首次使用联邦转运，请尽快填写地址，开始海淘之旅吧");*/
        })
        //文件上传前的预览
        $("#ctl00_ContentPlaceHolder1_uploadPicFront").change(function (){
            var objUrl = getObjectURL(this.files[0]);
            console.log("objUrl = " + objUrl);
            if (objUrl) {
                $("#ctl00_ContentPlaceHolder1_Image_IdCardFront").attr("src", objUrl);
            }
        })
        $("#ctl00_ContentPlaceHolder1_uploadPicBack").change(function () {
            var objUrl = getObjectURL(this.files[0]);
            if (objUrl) {
                $("#ctl00_ContentPlaceHolder1_Image_IdCardBack").attr("src", objUrl);
            }
        })
        function getObjectURL(file) {
            var url = null;
            if (window.createObjectURL != undefined) {// basic
                url = window.createObjectURL(file);
            } else if (window.URL != undefined) { // mozilla(firefox)
                url = window.URL.createObjectURL(file);
            } else if (window.webkitURL != undefined) { // webkit or chrome
                url = window.webkitURL.createObjectURL(file);                
            }
            return url;
        }
    </script>
    </asp:Literal>
</asp:Content>