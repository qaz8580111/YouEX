<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="UserRegister.aspx.cs" Inherits="WebSite.UserCenter.UserRegister" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/userregister.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-用户注册</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content">
    <div class="content-box">
       <div class="left">
          <div class="sign">1.注册</div>
          <img class="jian-16" src="../Images/Pic_User/jian-16.png" /><span class="sign_2">2.激活</span>
           <div class="lastdiv"></div>
          <div class="line"></div>
           <div class="mobile_register">
          <div class="login-mail">
             <div class="word">手机号码</div>
              <asp:TextBox ID="TB_Rg_Mobile" runat="server" placeholder="11位数的手机号"></asp:TextBox>
              <span class="check_notice_word" id="mobile_glyphicon_remove">手机已经存在</span>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ControlToValidate="TB_Rg_Mobile" Display="Dynamic" ErrorMessage="*输入的手机格式错误" 
                    ValidationExpression="\d{11}" 
                    ValidationGroup="UserRegGroup"  ForeColor="red">
            </asp:RegularExpressionValidator>
          </div>
           <div class="lastdiv"></div>
           <div style="margin-left:75px;">没有手机？<span id="email_register">用邮箱注册</span></div>
            </div>

           <div class="lastdiv"></div>
           <div class="email_register" style="display:none;">
          <div class="login-mail">
             <div class="word">电子邮箱</div>
              <asp:TextBox ID="TB_Rg_Email" runat="server" placeholder="您常用的电子邮箱"></asp:TextBox>
              <span class="check_notice_word" id="email_glyphicon_remove">邮箱已经存在</span>
            <asp:RegularExpressionValidator ID="EmailRegularValidator" runat="server" 
                    ControlToValidate="TB_Rg_Email" Display="Dynamic" ErrorMessage="*输入的邮箱格式有误" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                    ValidationGroup="UserRegGroup"  ForeColor="red">
            </asp:RegularExpressionValidator>
          </div>
           <div class="lastdiv"></div>
           <div style="margin-left:75px;">没有邮箱？<span id="mobile_register">用手机注册</span></div>
            </div>

           <div class="lastdiv"></div>
          <div class="login-password">
             <div class="word5">中文名</div>
             <asp:TextBox ID="TB_Rg_RealName" runat="server" placeholder="中文名字"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ErrorMessage="*该字段为必填项" ControlToValidate="TB_Rg_RealName" Display="Dynamic" 
                    ValidationGroup="UserRegGroup"  ForeColor="red">
              </asp:RequiredFieldValidator>
          </div>

           <div class="lastdiv"></div>
          <div class="login-password">
             <div class="word5">英文名：</div>
             <asp:TextBox ID="TB_Rg_FirstName" runat="server" placeholder="FirstName"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                    ErrorMessage="" ControlToValidate="TB_Rg_FirstName" Display="Dynamic" 
                    ValidationGroup="UserRegGroup"  ForeColor="red">
              </asp:RequiredFieldValidator>
              <div class="word5" style="margin-left:10px;">英文姓：</div>
             <asp:TextBox ID="TB_Rg_SecondName" runat="server" placeholder="LastName"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                    ErrorMessage="*该字段为必填项" ControlToValidate="TB_Rg_SecondName" Display="Dynamic" 
                    ValidationGroup="UserRegGroup"  ForeColor="red">
              </asp:RequiredFieldValidator>
          </div>

          <div class="lastdiv"></div>
          <div class="login-password">
             <div class="word2">登录密码</div>
             <asp:TextBox ID="TB_Rg_Pwd" runat="server" TextMode="Password" placeholder="密码长度6-16位字符"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="*该字段为必填项" ControlToValidate="TB_Rg_Pwd" Display="Dynamic" 
                    ValidationGroup="UserRegGroup"  ForeColor="red">
              </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="TB_Rg_Pwd" Display="Dynamic" ErrorMessage="*输入的密码格式有误" 
                    ValidationExpression="\w{6,16}"
                    ValidationGroup="UserRegGroup"  ForeColor="red">
              </asp:RegularExpressionValidator>
          </div>
          <div class="lastdiv"></div>
          <div class="login-password1">
             <div class="word">确认登录密码</div>
              <asp:TextBox ID="TB_Rg_Repwd" runat="server" TextMode="Password" placeholder="再次重复您的密码"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ErrorMessage="*该字段为必填项" ControlToValidate="TB_Rg_Repwd" Display="Dynamic" 
                    ValidationGroup="UserRegGroup"  ForeColor="red">
              </asp:RequiredFieldValidator>
          </div>
          <div class="lastdiv"></div>
          <div class="aut-login">
             <asp:CheckBox ID="CB_Rg_Agree" runat="server" />
            <div class="word"><label for="ctl00_ContentPlaceHolder1_CB_Rg_Agree">已经阅读并同意FedRoad</label><a href="../Help/Illustrates.aspx">注册条款</a></div>
          </div>
          <div class="lastdiv"></div>
          <div class="login-button">              
              <asp:Button ID="Button_Register" ValidationGroup="UserRegGroup" runat="server" OnClientClick="if(!check_term()){return false;};" OnClick="UserRegister_Content"  />
          </div>
          <div class="ver-line"></div>
       </div>
       <div class="right">
          <div><img src="../Images/Pic_Main/sao-weixin.jpg" /></div>
          <div class="word">已有帐号，赶紧登录</div>
          <a href="./UserLogin.aspx"><img src="../Images/Pic_Main/login-small.jpg" /></a>
       </div>
    </div>
</div>

</asp:Content>
