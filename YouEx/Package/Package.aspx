<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Package.aspx.cs" Inherits="WebSite.Package.Package" EnableEventValidation="False" validateRequest="false" %>
<%@ Register Assembly="WebSite" Namespace="WebSite.Tool.Control" TagPrefix="nac" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/package.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-新增包裹</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="content-bj">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

<!--包裹信息-->
     <div class="content-box">
        <div class="t1"><div class="word">包裹运单号:</div><input type="text" name="shippingorder" />
            <span class="check_shippingorder_yes">该运单可以使用</span><span class="check_shippingorder_no">该运单不可以使用</span></div>
        <div class="t2">
           <div class="word">所属仓库:</div>
                <asp:DropDownList ID="DropDownList_DepotId" runat="server">
                    <asp:ListItem Value="0" Text="请选择海外收货仓库" Selected="True"></asp:ListItem>
                </asp:DropDownList>
        </div> 
    <div class="t3">
           <div class="word">商品信息:</div>
            <div class="package_info">
           <div class="t3-title">
              <div class="d1">商品名称</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="d1">品牌</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="d3">单价</div><img src="../Images/Pic_User/xuxian.png" />
               <div class="d5">货币</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="d4">数量</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="d6">购买链接</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="d8">操作</div>
           </div>
           <div class="t3-content">
               <div class="s1"><input type="text" name="good_name" oninput="flush_name(this);" /></div>
               <div class="s2"><input type="text" name="good_brand" oninput="flush_brand(this);" /></div>
               <div class="s3"><input type="text" name="good_price" oninput="flush_price(this);" /></div>
               <div class="s6"><span>（￥）</span></div>
               <div class="s4"><input type="text" name="good_amount" oninput="flush_amount(this);" /></div>
               <div class="s5"><input type="text" name="good_buyurl" oninput="flush_buyurl(this);" /></div>
               <div><input class="good_button_clean" type="button" value="清空" onclick="cleanrow(this);"  /></div>
           </div>
            </div>
           <div class="last-div"></div>
           <div class="t3-content2">
             <div class="add"><input id="relation_input_1" type="button" onclick="addTr2('package_info', -1);" style="width:29px;height:29px;background:url('../Images/Pic_User/addpng.png')" />
                 <label for="relation_input_1" class="relation_label_1" >添加新商品</label></div>
             <a><div class="upload">
               <img src="../Images/Pic_User/upload.png" /><div>上传购物截图（<div class="upload_pic_count">0</div>&nbsp;&nbsp;&nbsp;&nbsp;张）</div>
             </div></a>
            <div class="qingguansudu">(可以加快清关速度)</div>
           </div>
           <div class="t3-content3">
               <div class="remark_word">备注信息:</div>
              <textarea name="remark" style="width:500px;height:100px;color:#4C4C4C;"></textarea>
               <div class="photo_word">增值服务:</div>
                   <div class="service_style_package"><input id="relation_span_3" type="checkbox" name="isphoto" value="1" class="c12" />
                       <label for="relation_span_3" class="photo_word_2">拍照</label><input type="text" name="photo_remark" />
                   </div>
                   <div class="service_style_package"><input id="relation_span_4" type="checkbox" name="reinforce" value="1" class="c12" />
                        <label for="relation_span_4" class="photo_word_2">加固</label><input type="text" name="reinforce_remark" />
                   </div>
           </div>
        </div>
         
    <div class="show_delivery">
       <div class="two_action_word">选择以下操作，可以加速发货</div>
       <div class="last-div"></div>
       <div class="packageline"></div>
       <div class="choose">
           <div class="defaultbox"><span class="defaultbox_word">原箱操作</span></div>        
       </div>
        <div class="last-div"></div>
       <div class="choose">
           <div class="explainbox"><span class="explainbox_word">分箱操作</span></div>
       </div>
        <div class="last-div"></div>
        <div class="packageline"></div>
        <div class="last-button">
           <input type="checkbox" class="isPackageType" style="display:none;" name="isPackageType" checked="checked" />
           <a href="../UserCenter/UserCenter.aspx"><img class="button" style="width:70px;height:30px;border-radius: 2px;" src="../Images/Pic_User/quxiao.png" /></a>
           <input class="button_submit" type="button" runat="server" onclick="if (!check_delivery()) { return false; };" onserverclick="submit_delivery" value="提交发货" />
        </div>
     </div>
  </div>

  <div class="bj"></div>
  <div class="shopping-receipt">
    <img src="../Images/Pic_User/pay.jpg" />
    <img class="upload_close" src="../Images/Pic_User/XX.png" />
    <input id="upload_shopping_pic" type="button" class="upload_button" value="点击上传购物图片" />
    <input id="finish_shopping_pic" type="button" class="upload_button" value="完成购物图片上传" />
  </div>
   <div class="show_upload_img">
       <asp:FileUpload ID="FileUpload1" runat="server" Style="visibility: hidden;height:1px;" />
       <asp:FileUpload ID="FileUpload2" runat="server" Style="visibility: hidden;height:1px;" />
       <asp:FileUpload ID="FileUpload3" runat="server" Style="visibility: hidden;height:1px;" />
       <asp:FileUpload ID="FileUpload4" runat="server" Style="visibility: hidden;height:1px;" />
       <asp:FileUpload ID="FileUpload5" runat="server" Style="visibility: hidden;height:1px;" />
       <asp:Image ID="Shopping_Image1" runat="server" />
       <asp:Image ID="Shopping_Image2" runat="server" />
       <asp:Image ID="Shopping_Image3" runat="server" />
       <asp:Image ID="Shopping_Image4" runat="server" />
       <asp:Image ID="Shopping_Image5" runat="server" />
       <input name="Label_Upload1" class="lable_upload" />
       <input name="Label_Upload2" class="lable_upload" />
       <input name="Label_Upload3" class="lable_upload" />
       <input name="Label_Upload4" class="lable_upload" />
       <input name="Label_Upload5" class="lable_upload" />
       <input type="button" class="show_upload_style" value="可以上传5张图片"  onclick="$('#ctl00_ContentPlaceHolder1_FileUpload1').click()" />   
       <div class="upload_pic_action">
           <div class="submit_upload_pic">确定上传</div>
           <div class="cancel_upload_pic">取消上传</div>
           <div class="upload_delete_notice">双击图片可删除</div>
       </div>
   </div>
    <script>
        //文件上传前的预览
        $("#ctl00_ContentPlaceHolder1_FileUpload1").change(function () {
            var isright = isrightformat(this);
            if (!isright) {
                alert('上传的图片格式错误');
                return false;
            } else {
                var objUrl = getObjectURL(this.files[0]);
                console.log("objUrl = " + objUrl);
                if (objUrl) {
                    $("#ctl00_ContentPlaceHolder1_Shopping_Image1").attr("src", objUrl);
                }
                Check_IsImgNull(1);
            }
        })
        $("#ctl00_ContentPlaceHolder1_FileUpload2").change(function () {
            var isright = isrightformat(this);
            if (!isright) {
                alert('上传的图片格式错误');
                return false;
            } else {
                var objUrl = getObjectURL(this.files[0]);
                console.log("objUrl = " + objUrl);
                if (objUrl) {
                    $("#ctl00_ContentPlaceHolder1_Shopping_Image2").attr("src", objUrl);
                }
                Check_IsImgNull(2);
            }
        })
        $("#ctl00_ContentPlaceHolder1_FileUpload3").change(function () {
            var isright = isrightformat(this);
            if (!isright) {
                alert('上传的图片格式错误');
                return false;
            } else {
                var objUrl = getObjectURL(this.files[0]);
                console.log("objUrl = " + objUrl);
                if (objUrl) {
                    $("#ctl00_ContentPlaceHolder1_Shopping_Image3").attr("src", objUrl);
                }
                Check_IsImgNull(3);
            }
        })
        $("#ctl00_ContentPlaceHolder1_FileUpload4").change(function () {
            var isright = isrightformat(this);
            if (!isright) {
                alert('上传的图片格式错误');
                return false;
            } else {
                var objUrl = getObjectURL(this.files[0]);
                console.log("objUrl = " + objUrl);
                if (objUrl) {
                    $("#ctl00_ContentPlaceHolder1_Shopping_Image4").attr("src", objUrl);
                }
                Check_IsImgNull(4);
            }
        })
        $("#ctl00_ContentPlaceHolder1_FileUpload5").change(function () {
            var isright = isrightformat(this);
            if (!isright) {
                alert('上传的图片格式错误');
                return false;
            } else {
                var objUrl = getObjectURL(this.files[0]);
                console.log("objUrl = " + objUrl);
                if (objUrl) {
                    $("#ctl00_ContentPlaceHolder1_Shopping_Image5").attr("src", objUrl);
                }
                Check_IsImgNull(5);
            }
        })
        function getObjectURL(file) {
            var url = null;
            if (window.createObjectURL != undefined) {//basic
                url = window.createObjectURL(file);
            } else if (window.URL != undefined) { //mozilla(firefox)
                url = window.URL.createObjectURL(file);
            } else if (window.webkitURL != undefined) { //webkit or chrome
                url = window.webkitURL.createObjectURL(file);
            }
            return url;
        }
        function Check_IsImgNull(a) {
            for (var i = a; i < 6; i++) {
                if ($("#ctl00_ContentPlaceHolder1_Shopping_Image" + i).attr("src") != "") {
                    $("#ctl00_ContentPlaceHolder1_Shopping_Image" + i).show();
                    for (i = a + 1; i < 7; i++) {
                        if ($("#ctl00_ContentPlaceHolder1_Shopping_Image" + i).attr("src") == "") {
                            $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload" + i + "').click()");
                            $("input[name='Label_Upload"+a+"']").val($("#ctl00_ContentPlaceHolder1_Shopping_Image" + a).attr("src"));
                            break;
                        }
                        if (i == 6) {                            
                            if ($("#ctl00_ContentPlaceHolder1_Shopping_Image5").attr("src") != "") {
                                $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload5').click()");
                                $("input[name='Label_Upload5']").val($("#ctl00_ContentPlaceHolder1_Shopping_Image5").attr("src"));
                                if ($("#ctl00_ContentPlaceHolder1_Shopping_Image1").attr("src") != "") {
                                    $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload1').click()");
                                }
                                if ($("#ctl00_ContentPlaceHolder1_Shopping_Image2").attr("src") != "") {
                                    $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload2').click()");
                                }
                                if ($("#ctl00_ContentPlaceHolder1_Shopping_Image3").attr("src") != "") {
                                    $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload3').click()");
                                }
                                if ($("#ctl00_ContentPlaceHolder1_Shopping_Image4").attr("src") != "") {
                                    $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload4').click()");
                                }
                            }
                        }
                    }
                }
                if ($("#ctl00_ContentPlaceHolder1_Shopping_Image1").attr("src") != "" && $("#ctl00_ContentPlaceHolder1_Shopping_Image2").attr("src") != "" &&
                    $("#ctl00_ContentPlaceHolder1_Shopping_Image3").attr("src") != "" && $("#ctl00_ContentPlaceHolder1_Shopping_Image4").attr("src") != "" &&
                    $("#ctl00_ContentPlaceHolder1_Shopping_Image5").attr("src") != "") {
                    $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload6').click()");
                    break;
                }
            }
        }        
    </script>



<!--新增收货地址-->
    <div class="use-address">
     <div class="a1">
        <div class="word">地址分类：</div>
            <nac:TextBox ID="TB_Address_Name" CanBeNull="必填" ValidationGroup="AddAddress" runat="server" placeholder="每个地址名称必须不同。如：地址1，地址2"></nac:TextBox>
            <div class="diffrent_addressname_notice">地址分类名不可相同</div>
     </div>
     <div class="last-div"></div>
     <div class="a2">
         <div class="re1">
            <div class="word">收货人：</div>
            <nac:TextBox ID="TB_Address_Recipients" CanBeNull="必填" ValidationGroup="AddAddress" runat="server"></nac:TextBox>
         </div>
     <div class="last-div"></div>
     <div class="a3">
        <div class="word">收货电话：</div>
            <nac:TextBox ID="TB_Address_Mobile" CanBeNull="必填" ValidationGroup="AddAddress" runat="server" RequiredFieldType="移动手机"></nac:TextBox>
     </div>
     <div class="last-div"></div>
     <div class="a5">
        <div class="word">所在地区：</div>
            <asp:DropDownList ID="DropDownList_country" runat="server" >
                <asp:ListItem Value="0" Text="--请选择国家--"></asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="DropDownList_province" runat="server" >
                <asp:ListItem Value="0" Text="--请选择省份--"></asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="DropDownList_city" runat="server">
                <asp:ListItem Value="0" Text="--请选择城市--"></asp:ListItem>
            </asp:DropDownList>
        <script>
            $('#ContentPlaceHolder1_DropDownList_country').change(function () {
                $.ajax({
                    type: "POST",
                    url: "../YouEx_Ashx/package.ashx",
                    data: { "Cvalue": $('#ContentPlaceHolder1_DropDownList_country').val() },
                    dataType: "text",
                    success: function (data) {
                        var jsonData = eval("(" + data + ")");
                        $("#ContentPlaceHolder1_DropDownList_province option:gt(0)").remove();
                        $("#ContentPlaceHolder1_DropDownList_city option:gt(0)").remove();
                        $.each(jsonData, function (i, k) {
                            var id = jsonData[i].Id;
                            var name = jsonData[i].Name;
                            $('#ContentPlaceHolder1_DropDownList_province option[value="0"]').after("<option value='" + id + "'>" + name + "</option>");
                        })
                    }
                })
            })

            $('#ContentPlaceHolder1_DropDownList_province').change(function () {
                $.ajax({
                    type: "POST",
                    url: "../YouEx_Ashx/package.ashx",
                    data: { "Pvalue": $('#ContentPlaceHolder1_DropDownList_province').val()},
                    dataType: "text",
                    success: function (data) {
                        var jsonData = eval("(" + data + ")");
                        $("#ContentPlaceHolder1_DropDownList_city option:gt(0)").remove();
                        $.each(jsonData, function (i, k) {
                            var id = jsonData[i].Id;
                            var name = jsonData[i].Name;
                            $('#ContentPlaceHolder1_DropDownList_city option[value="0"]').after("<option value='" + id + "'>" + name + "</option>");
                        })
                    }
                })
            })
    </script>
     </div>
     <div class="last-div"></div>
     <div class="a6">
        <div class="word">收货地址：</div>
            <nac:TextBox ID="TB_Address_Address" CanBeNull="必填" ValidationGroup="AddAddress" runat="server" placeholder="仅需街道地址，如：XX路XX号XX室"></nac:TextBox>
     </div>
     <div class="last-div"></div>
     <div class="a8">
        <div class="word">邮编：</div>
            <nac:TextBox ID="TB_Address_ZipCode" CanBeNull="可为空" ValidationGroup="AddAddress" runat="server"></nac:TextBox>
     </div>
     <div class="last-div"></div>
     <div class="a10">
        <div class="word">身份证号码：</div>
            <nac:TextBox ID="TB_Address_IdCard" CanBeNull="必填" ValidationGroup="AddAddress" runat="server" RequiredFieldType="身份证号码"></nac:TextBox>
     </div>
     <div class="last-div"></div>
     <div class="a11">
         <div class="word">身份证正面：</div>
            <asp:FileUpload ID="uploadPicFront" runat="server" />
            <asp:Image ID="Image_IdCardFront" runat="server"  />
      </div>
     <div class="last-div"></div>
     <div class="a11">
         <div class="word">身份证反面：</div>
            <asp:FileUpload ID="uploadPicBack" runat="server" />
            <asp:Image ID="Image_IdCardBack" runat="server" />
      </div>
      <div class="last-div"></div>
      <div class="button_address_button">
         <nac:Button ID="Button_AddUserAddress" ValidationGroup="AddAddress" runat="server" Text="增加新地址" OnClick="addAddress" OnClientClick="if(!address_func()){return false;}" />
         <img class="no-sure" src="../Images/Pic_User/no-sure.png" />
      </div>
      <script>
          //文件上传前的预览
          $("#ctl00_ContentPlaceHolder1_uploadPicFront").change(function () {
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
     </div>  
    </div>



<!--分箱操作-->
    <div class="explain_box">
        <div class="newword">
            <span style="margin-left:25px;">原箱信息</span>
            <span style="margin-left:44%;">分箱信息</span>
            <span class="package_delivery_add_address">新增地址</span>
            <img class="cancel_delivery_icon" src="../Images/Pic_User/XX1.png" />
        </div>
    <div id="clone_explain">
        <div class="t3">
            <div class="delivery_info">
           <div class="word-title">
              <div class="word_name"><input class="clone_delivery_no" value="1" />商品名称</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_brand">品牌</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_price">单价</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_amount">数量</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_buyurl">购买链接</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_action">操作</div>
               <div class="hide_calculate"><div class="calculate_amount"><input name="clone_calculate" /></div></div>
           </div>           
           <div class="data_content">               
               <div class="search_name"><input class="data_name" type="text" name="clone_name" disabled="disabled" /></div>
               <input class="data_brand" type="text" name="clone_brand" disabled="disabled" />
               <input class="data_price" type="text" name="clone_price" disabled="disabled" />
               <input class="data_amount" type="text" name="clone_amount" disabled="disabled" />
               <input class="data_buyurl" type="text" name="clone_buyurl" disabled="disabled" />
               <input class="data_button" type="button" onclick="delTr(this);" value="删除" />
           </div>
            </div>
           <div class="last-div"></div>
           <div class="t3-content2">
             <div class="add"><input type="button" onclick="addTr3(this, -1);" style="width:29px;height:29px;background:url('../Images/Pic_User/addpng.png')" /><div>添加新商品</div></div>
               <div>              
                <select  name="roadline_explain">
                    <option value="0">请选择转运路线</option>
                    <asp:Literal ID="Literal_roadline_explain" runat="server">
                        <option value="nameHere">addressHere</option>
                    </asp:Literal>
                </select>

                <select  name="address_clone">
                    <option value="0">请选择收货地址</option>
                    <asp:Literal ID="Literal_select_address" runat="server">
                        <option value="nameHere">addressHere</option>
                    </asp:Literal>
                </select>
                <div class="clone_remove"><span class="delete_clone_delivery" style="float:left">删除</span></div>
               </div>
           </div>
        </div>
        <div class="add_delivery"><span class="add_delivery_word">+新增分箱+</span></div>
    </div>
    
        <div id="cloneing_explain">
            <div id="cloneing_right"></div>
        </div>

        <div style="float:right;width:50%;">
        <div class="last-div"></div>
        <div class="t6">
           <div class="title">增值服务：</div>
           <div class="content">
              <div class="choose"><input id="relation_input_5" type="checkbox" name="insurance_explain" class="c12" value="1" /><label for="relation_input_5">购买保险</label></div>
              <div class="choose"><input id="relation_input_6" type="checkbox" name="invoice_explain" class="c12" value="1" /><label for="relation_input_6">需要发票</label></div>
           </div>
        </div>
        <div class="last-div"></div>
        <div class="t7">
            <div class="title">提醒方式：</div>
            <div class="content">
                <div class="choose"><div><input id="relation_input_7" type="radio" name="type_notice_explain" class="c12" value="2" /></div><label for="relation_input_7">不需要提醒</label></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_8" type="radio" name="type_notice_explain" class="c12" value="0" checked="checked" /><label for="relation_input_8">短信提醒</label><input class="c13" name="connection_explain" type="text" /></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_9" type="radio" name="type_notice_explain" class="c12" value="1" /><label for="relation_input_9">邮箱提醒</label><input class="c13" name="connection_explain" type="text" /></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t8"> 
            <div class="title">支付方式：</div>
            <div class="content">
              <div class="choose"><input id="relation_input_10" type="radio" name="type_pay_explain" value="0" class="c12" checked="checked" /><label for="relation_input_10">手动确认支付</label></div>
              <div class="choose"><input id="relation_input_11" type="radio" name="type_pay_explain" value="1" class="c12" /><label for="relation_input_11">称重后自动结算（需要有足够的余额）</label></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t9">
            <div class="title">同意条款：</div>
            <div class="content">
               <input id="relation_input_12" type="checkbox" class="explain_agree" /><label for="relation_input_12">我已阅读，并同意</label><a href="../Help/PayAgreement.aspx">本站相关支付条款</a>

            </div>
        </div>
            
        <div class="last-div"></div>
        <div class="line"></div>
            <div class="last-div"></div>
        </div>

        <div class="fixed_showdelivery_button">
            <div class="save_delivery_good"><span class="save_delivery_good_word">下一步</span></div>
            <div class="cancel_delivery_good"><span class="cancel_delivery_good_word">取消</span></div>
        </div>
    </div>



<!--原箱操作-->
    <div class="show_delivery_default">
        <img class="cancel_package_icon" src="../Images/Pic_User/XX1.png" />
        <div class="content-box">
         <div class="t4">
           <div class="word">选择收货地址：<div class="p">新增地址</div></div>
           <div class="content">
               <select name="address_default">
                   <option value="0">请选择收货地址</option>
                   <asp:Literal ID="LiteralAddress" runat="server">
                       <option value="nameHere">addressHere</option>
                    <script>
                        $("input[name='shippingorder']").val("shippingnoHere");
                    </script>
                   </asp:Literal>
               </select>
                
            
           </div>
        </div>
        <div class="t5">
           <div class="title">选择路线：</div>
           <div class="content">
                <select  name="roadline_default">
                    <option value="0">请选择转运路线</option>
                    <asp:Literal ID="Literal_roadline_default" runat="server">
                        <option value="nameHere">addressHere</option>
                    </asp:Literal>
                </select>                                               
           </div>
        </div>
        <div class="last-div"></div>
        <div class="t6">
           <div class="title">增值服务：</div>
           <div class="content">
              <div class="choose"><input id="relation_input_13" type="checkbox" name="insurance_default" class="c12" value="1" /><label for="relation_input_13">购买保险</label></div>
              <div class="choose"><input id="relation_input_14" type="checkbox" name="invoice_default" class="c12" value="1" /><label for="relation_input_14">需要发票</label></div>
           </div>
        </div>
        <div class="last-div"></div>
        <div class="t7">
            <div class="title">提醒方式：</div>
            <div class="content">
                <div class="choose"><div><input id="relation_input_15" type="radio" name="type_notice_default" class="c12" value="2" /></div><label for="relation_input_15">不需要提醒</label></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_16" type="radio" name="type_notice_default" class="c12" value="0" /><label for="relation_input_16">短信提醒</label><input class="c13" name="connection_default" type="text"  /></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_17" type="radio" name="type_notice_default" class="c12" value="1" /><label for="relation_input_17">邮箱提醒</label><input class="c13" name="connection_default" type="text"  /></div>
            </div>
            <asp:Literal ID="Literal_NoticeType" runat="server">
            <script>
                //原箱
                if (("mobileHere" != "" && "emailHere" == "") || ("mobileHere" != "" && "emailHere" != "")) {
                    $("#relation_input_16").prop("checked", "checked");
                    $("input[name='connection_default']").eq(0).val("mobileHere");
                }
                if ("mobileHere" == "" && "emailHere" != "") {
                    $("#relation_input_17").prop("checked", "checked");
                    $("input[name='connection_default']").eq(1).val("emailHere");
                }
                $("input[name='type_notice_default']").click(function () {
                    if ($("#relation_input_15").is(":checked")) {
                        $("input[name='connection_default']").eq(0).val("");
                        $("input[name='connection_default']").eq(1).val("");
                    }
                    if ($("#relation_input_16").is(":checked"))
                        $("input[name='connection_default']").eq(1).val("");
                    if ($("#relation_input_17").is(":checked"))
                        $("input[name='connection_default']").eq(0).val("");
                })
                //分箱
                if (("mobileHere" != "" && "emailHere" == "") || ("mobileHere" != "" && "emailHere" != "")) {
                    $("#relation_input_8").prop("checked", "checked");
                    $("input[name='connection_explain']").eq(0).val("mobileHere");
                }
                if ("mobileHere" == "" && "emailHere" != "") {
                    $("#relation_input_9").prop("checked", "checked");
                    $("input[name='connection_explain']").eq(1).val("emailHere");
                }
                $("input[name='type_notice_explain']").click(function () {
                    if ($("#relation_input_7").is(":checked")) {
                        $("input[name='connection_explain']").eq(0).val("");
                        $("input[name='connection_explain']").eq(1).val("");
                    }
                    if ($("#relation_input_8").is(":checked"))
                        $("input[name='connection_explain']").eq(1).val("");
                    if ($("#relation_input_9").is(":checked"))
                        $("input[name='connection_explain']").eq(0).val("");
                })
            </script>
            </asp:Literal>
            
        </div>
        <div class="last-div"></div>
        <div class="t8"> 
            <div class="title">支付方式：</div>
            <div class="content">
              <div class="choose"><input id="relation_input_18" type="radio" name="type_pay_default" value="0" class="c12" checked="checked" /><label for="relation_input_18">手动确认支付</label></div>
              <div class="choose"><input id="relation_input_19" type="radio" name="type_pay_default" value="1" class="c12" /><label for="relation_input_19">称重后自动结算（需要有足够的余额）</label></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t9">
            <div class="title">同意条款：</div>
            <div class="content">
               <input id="relation_input_20" type="checkbox" class="default_agree" /><label for="relation_input_20">我已阅读，并同意</label><a href="../Help/PayAgreement.aspx">本站相关支付条款</a>                
            </div>
        </div>            
        </div>

        <div>
            <div class="last-div"></div>
            <div class="line_default_package"></div>
            <div class="last-div"></div>
            <div class="cancel_delivery_default"><span class="cancel_delivery_default_word">取消</span></div>
            <div class="save_delivery_default"><span class="save_delivery_default_word">下一步</span></div>
        </div>
    </div>
        

  <div class="wan-price">
    <img src="../Images/Pic_Main/wan.jpg" />
    <img class="wan-yin" src="../Images/Pic_Main/wan-yin.jpg" />
  </div>
  <div class="pu-price">
    <img src="../Images/Pic_Main/pu.jpg" />
    <img class="pu-yin" src="../Images/Pic_Main/pu-yin.jpg" />
  </div>
  <div class="milk-price">
    <img src="../Images/Pic_Main/milk.jpg" />
    <img class="milk-yin" src="../Images/Pic_Main/milk-yin.jpg" />
  </div>
  <div class="gang-price">
    <img src="../Images/Pic_Main/gang.jpg" />
    <img class="gang-yin" src="../Images/Pic_Main/gang.jpg" />
  </div>
  <div class="usps-price">
    <img src="../Images/Pic_Main/usps.jpg" />
    <img class="usps-yin" src="../Images/Pic_Main/usps-yin.jpg" />
  </div>

</div>
    <script>
        $(".save_delivery_default_word,.button_submit,.cancel_delivery_default_word,.p,#ctl00_ContentPlaceHolder1_Button_AddUserAddress,.add_delivery_word,"
            +".save_delivery_good_word,.cancel_delivery_good_word,.package_delivery_add_address").mouseenter(function () {
            $(this).css("text-decoration", "underline");
        }).mouseleave(function () {
            $(this).css("text-decoration", "none");
        })
        function isrightformat(obj) {
            var format = new Array("jpg", "png", "gif", "bmp");
            if ($(obj).val() != "") {
                var suffix = $(obj).val().split(".")[1];
                var isright = false;
                for (var i = 0; i < format.length; i++) {
                    if ((suffix.indexOf(format[i])) >= 0) { isright = true; }
                };
                return isright ;
            }
        }
    </script>
</asp:Content>


