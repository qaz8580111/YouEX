<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="NewPackage.aspx.cs" Inherits="WebSite.Package.NewPackage" EnableEventValidation="False" validateRequest="false" %>
<%@ Register Assembly="WebSite" Namespace="WebSite.Tool.Control" TagPrefix="nac" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/newpackage.css"  />
    <link rel="stylesheet" type="text/css" href="../Include/CSS/jquery-ui-git.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-新增包裹</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        $(function () {
            newpackage_reload();
            window.upload_count_arr = new Array();
            upload_count_arr[0] = 0;
            if (location.href.split("=")[1] != "")
                $(".left .shippingorderno").attr("value", location.href.split("=")[1]);
        });
    </script>    

    <div class="content-bj">
<!--左侧-->
    <asp:Panel ID="Panel1" runat="server">
     <div class="left">
         <div class="title-word">添加新包裹</div><img class="jia-26" src="../Images/Pic_User/jia-26.png"/>  
         <div class="last-div"></div>
         <div class="box1">
            <div class="c1">所属仓库：</div>
            <asp:DropDownList ID="DropDownList_DepotId" runat="server">
                <asp:ListItem Value="0" Text="请选择海外收货仓库" Selected="True"></asp:ListItem>
            </asp:DropDownList>
            <div class="introduce"><a class="introduce_word" href="../Help/OperatingTutorial.aspx">页面介绍</a></div>
         </div> 
         <div class="last-div"></div>
         <div class="big-box">
            <div class="g-box">
              <div class="box2">
                <div class="c2">包裹运单号:</div>
                <input class="shippingorderno" name="shippingorder" />
                  <select class="exist_shippingno">
                        <option value="0">已预报运单</option>
                        <asp:Literal ID="Literal_ForcastDelivery" runat="server">
                            <option value="packagenoHere">shippingnoHere</option>
                        </asp:Literal>
                    </select>
                <div class="check_shippingorder_no">运单不可用</div>
                <img class="cancel_package" src="../Images/Pic_User/xx2.png" />
              </div>
              <div class="last-div"></div>
              <div class="box3">
                 <div class="c3">商品信息：</div>
                 <div class="c3_box">
                    <div class="w1">商品名称</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w2">品牌</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w3">单价</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w4">货币</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w5">数量</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w6">购买链接</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w7">操作</div>
                 </div>
                 <ul class="c3-box1">
                    <li style="list-style:none;">
                        <input class="i1" name="good_name"  value="" oninput="clone_flush(this);" />
                        <input class="i2" name="good_brand" value="" oninput="clone_flush(this);" />
                        <input class="i3" name="good_price" value="" oninput="clone_flush(this);" />
                        <span class="currency">（￥）</span>
                        <input class="i4" name="good_amount" value="" oninput="clone_flush(this);" />
                        <input class="i5" name="good_buyurl" value="" oninput="clone_flush(this);" />
                        <span class="clear" onclick="delTr(this);">删除</span>
                    </li>
                 </ul>
                 <div class="last-div"></div>
                 <div class="c3-box2">
                    <div class="add">
                        <input id="relation_input_1" type="button" class="add_packagegood" onclick="addTr2(this, -1);" />
                        <label for="relation_input_1" class="relation_label_1" >添加新商品</label>
                    </div>
                    <div class="upload">
                      <img src="../Images/Pic_User/upload-26.png" />
                      <div style="width:130px;">上传购物截图（<input name="upload_pic_count" class="upload_pic_count" value="0" />&nbsp;&nbsp;&nbsp;&nbsp;张）
                      </div><span>(可以加快清关速度)</span>
                    </div>

                     <div class="bj"></div>
                     <!--上传小票-->
                     <div class="shopping-receipt">
                        <img src="../Images/Pic_User/pay.jpg" />
                        <img class="upload_close" src="../Images/Pic_User/xx2.png" />
                        <input type="button" class="upload_shopping_pic" value="点击上传购物图片" />
                        <input type="button" class="finish_shopping_pic" value="完成购物图片上传" />
                      </div>
                     <div class="show_upload_img">
                           <asp:FileUpload ID="FileUpload0" runat="server" Style="visibility: hidden;height:1px;" />
                           <asp:FileUpload ID="FileUpload1" runat="server" Style="visibility: hidden;height:1px;" />
                           <asp:FileUpload ID="FileUpload2" runat="server" Style="visibility: hidden;height:1px;" />
                           <asp:FileUpload ID="FileUpload3" runat="server" Style="visibility: hidden;height:1px;" />
                           <asp:FileUpload ID="FileUpload4" runat="server" Style="visibility: hidden;height:1px;" />
                           <asp:Image ID="Image0" runat="server" />
                           <asp:Image ID="Image1" runat="server" />
                           <asp:Image ID="Image2" runat="server" />
                           <asp:Image ID="Image3" runat="server" />
                           <asp:Image ID="Image4" runat="server" />
                           <input name="Label_Upload1" class="lable_upload" />
                           <input name="Label_Upload2" class="lable_upload" />
                           <input name="Label_Upload3" class="lable_upload" />
                           <input name="Label_Upload4" class="lable_upload" />
                           <input name="Label_Upload5" class="lable_upload" />
                           <input type="button" class="show_upload_style" value="可以上传5张图片"  onclick="$('#ctl00_ContentPlaceHolder1_FileUpload0').click()" />   
                           <div class="upload_pic_action">
                               <div class="submit_upload_pic">确定上传</div>
                               <div class="cancel_upload_pic">取消上传</div>
                               <div class="upload_delete_notice">双击图片可删除</div>
                           </div>
                       </div>   

                 </div>
              </div>
              <div class="last-div"></div>
              <div class="box4">
                 <div class="c4">增值服务：</div>
                 <input id="relationphoto_10000" class="k1" type="checkbox" />
                 <label for="relationphoto_10000">拍照</label>
                 <input class="kk" name="photo_remark" />
                 <input type="hidden" name="photo" value="0" />
              </div>
              <div class="last-div"></div>
              <div class="box5">
                 <div class="c5">备注信息：</div>
                 <textarea name="package_remark"></textarea>
              </div>
            </div>
         </div>
         <input name="left_goods_count" class="left_goods_count" />
         <input name="right_goods_count" class="right_goods_count" />
         <input name="each_first_goods_count" class="each_first_goods_count" /> 
         <input class="button-left" type="button" runat="server" value="预报入库" onclick="if (!new_check_package()) { return false; };" onserverclick="ForcastDelivery" />
     </div>
    </asp:Panel>
<!--右侧-->     

     <div class="right">
         <div class="title-word">包裹操作</div><img class="jia-26" src="../Images/Pic_User/jia-26.png"/>   
         <div class="last-div"></div>
         <div class="big-box">
            <div class="g-box">
              <div class="box2"><img src="../Images/Pic_User/xx2.png" /></div>
              <div class="box3">
                 <div class="c3">商品信息：<div class="address">新增地址</div></div>
                 
                 <div class="c3_box">
                    <div class="w1">商品名称</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w2">品牌</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w3">单价</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w4">货币</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w5">数量</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w6">购买链接</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w7">操作</div>
                 </div>
                 <ul class="c3-box1">
                    <li class="clone_place"></li>
                 </ul>
                 <div class="last-div"></div>
                 <div class="c3-box2">
                   <select  name="roadline_explain">
                        <option value="0">请选择转运路线</option>
                   </select>
                   <select  name="address_delivery">
                        <option value="0">请选择收货地址</option>
                        <asp:Literal ID="Literal_select_address" runat="server">
                            <option value="nameHere">addressHere</option>
                        </asp:Literal>
                    </select>
                 </div>
              </div>
              <div class="last-div"></div>
              <div class="box4">
                 <div class="c4">增值服务：</div>                 
                 <input id="relationjg_10000" class="k1" type="checkbox" />
                 <label for="relationjg_10000">加固</label>
                 <input class="kk" name="reinforce_remark" />
                 <input type="hidden" name="reinforce" value="0" />
              </div>
              <div class="last-div"></div>
              <div class="box5">
                 <div class="c5">提醒方式：</div> 
                  <input class="k4" type='text' name='notice' placeholder='请输入手机号码或者邮箱' onblur='CheckNoticeType(this)' id='input_name' />
                  <input id="relationnotice_0" class="k5" type="checkbox"  />
                  <label for="relationnotice_0">(设为默认提醒方式)</label>
              </div>
            </div>
         </div>
        <div class="right2">
          <div class="big-box2">
                <div class="c4">其他服务：</div>
                <input id="relation_input_4" class="k2" type="checkbox" name="insurance_explain" value="1" />
                <label for="relation_input_4">购买保险</label>
                <input id="relation_input_5" class="k2" type="checkbox" name="invoice_explain" value="1" />
                <label for="relation_input_5">需要发票</label>
                         
                <div class="tx">支付方式：</div>
                <div class="tx-box">
                   <input id="relation_input_8" type="radio" name="pay_type" value="0" checked="checked"/> 
                   <label for="relation_input_8">手动确认支付</label>
                </div>
                <div class="tx-box">
                   <input id="relation_input_9" type="radio" name="pay_type" value="1"/> 
                   <label for="relation_input_9">称重后自动结算（需要有足够的余额）</label>
                </div>
                <div class="tx">同意条款：</div>
                <div class="tx-box">
                   <input id="relation_input_10" type="checkbox" name="agree_check"/> 
                   <label for="relation_input_10">我已阅读，并同意本站<a href="../Help/PayAgreement.aspx">相关支付条款</a></label>
                </div>  
          </div>
        </div>
    </div>

  </div>

   <div class="return-button-box">
        <input class="NewPackage_Submit" type="button" runat="server" onclick="if (!new_check_delivery()){ return false; };" onserverclick="SubmitDelivery" value="提交发货" />
        <div class="button_package">取消</div>        
   </div> 
    





   <!--新增收货地址-->
   <div class="use-address">
     <div class="addinner_word">新增地址</div>
     <div class="addinner_line"></div>
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
     <div class="a5">
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
     <div class="a10">
        <div class="word">身份证号码：</div>
            <nac:TextBox ID="TB_Address_IdCard" CanBeNull="必填" ValidationGroup="AddAddress" runat="server" RequiredFieldType="身份证号码"></nac:TextBox>
     </div>
     <div class="last-div"></div>
     <div class="a11">
         <div class="word">身份证正面：</div>
            <asp:FileUpload ID="uploadPicFront" runat="server" />
            <asp:Image ID="IdCardFront" runat="server"  />
      </div>
     <div class="last-div"></div>
     <div class="a11">
         <div class="word">身份证反面：</div>
            <asp:FileUpload ID="uploadPicBack" runat="server" />
            <asp:Image ID="IdCardBack" runat="server" />
      </div>
      <div class="last-div"></div>
      <div class="button_address_button">
         <nac:Button ID="Button_AddUserAddress" ValidationGroup="AddAddress" runat="server" Text="增加新地址" OnClick="addAddress" OnClientClick="if(!Check_Address_Info()){return false;}" />
         <img class="no-sure-pac" src="../Images/Pic_User/no-sure.png" />
      </div>
     </div>  
    </div>

   <!--被克隆的div-->
   <div class="hide_left_g_box">
       <div class="g-box">
              <div class="box2">
                <div class="c2">包裹运单号:</div>
                <input class="shippingorderno" name="shippingorder_left" />
                <select class="exist_shippingno">
                    <option value="0">已预报运单</option>
                    <asp:Literal ID="Literal_ForcastDelivery_Clone" runat="server">
                        <option value="packagenoHere">shippingnoHere</option>
                    </asp:Literal>
                </select>
                <div class="check_shippingorder_no">已存在</div>
                <img class="cancel_package" src="../Images/Pic_User/xx2.png" />
              </div>
              <div class="last-div"></div>
              <div class="box3">
                 <div class="c3">商品信息：</div>
                 <div class="c3_box">
                    <div class="w1">商品名称</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w2">品牌</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w3">单价</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w4">货币</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w5">数量</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w6">购买链接</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w7">操作</div>
                 </div>
                 <ul class="c3-box1">
                    <li style="list-style:none;" title="拖动商品空白处至目标包裹">
                        <input class="i1" name="good_name_left" value="" oninput="clone_flush(this);" />
                        <input class="i2" name="good_brand_left" value="" oninput="clone_flush(this);" />
                        <input class="i3" name="good_price_left" value="" oninput="clone_flush(this);" />
                        <span class="currency">（￥）</span>
                        <input class="i4" name="good_amount_left" value="" oninput="clone_flush(this);" />
                        <input class="i5" name="good_buyurl_left" value="" oninput="clone_flush(this);" />
                        <span class="clear" onclick="delTr(this);">删除</span>
                    </li>
                 </ul>
                 <div class="last-div"></div>
                 <div class="c3-box2">
                    <div class="add">
                        <input id="relation_input_2" type="button" class="add_packagegood" onclick="addTr2(this, -1);" />
                        <label for="relation_input_2" class="relation_label_2" >添加新商品</label>
                    </div>
                    <div class="upload">
                      <img src="../Images/Pic_User/upload-26.png" /><div style="width:130px;">上传购物截图（<input name="upload_pic_count_left" class="upload_pic_count" value="0" />&nbsp;&nbsp;&nbsp;&nbsp;张）</div><span>(可以加快清关速度)</span>
                    </div>

                     <div class="bj"></div>

                     <!--上传小票-->
                     <div class="shopping-receipt">
                        <img src="../Images/Pic_User/pay.jpg" />
                        <img class="upload_close" src="../Images/Pic_User/xx2.png" />
                        <input type="button" class="upload_shopping_pic" value="点击上传购物图片" />
                        <input type="button" class="finish_shopping_pic" value="完成购物图片上传" />
                      </div>
                     <div class="show_upload_img">
                           <asp:FileUpload ID="FileUpload5" runat="server" Style="visibility: hidden;height:1px;" />
                           <asp:FileUpload ID="FileUpload6" runat="server" Style="visibility: hidden;height:1px;" />
                           <asp:FileUpload ID="FileUpload7" runat="server" Style="visibility: hidden;height:1px;" />
                           <asp:FileUpload ID="FileUpload8" runat="server" Style="visibility: hidden;height:1px;" />
                           <asp:FileUpload ID="FileUpload9" runat="server" Style="visibility: hidden;height:1px;" />
                           <asp:Image ID="Image5" runat="server" />
                           <asp:Image ID="Image6" runat="server" />
                           <asp:Image ID="Image7" runat="server" />
                           <asp:Image ID="Image8" runat="server" />
                           <asp:Image ID="Image9" runat="server" />
                           <input name="Label_Upload1" class="lable_upload" />
                           <input name="Label_Upload2" class="lable_upload" />
                           <input name="Label_Upload3" class="lable_upload" />
                           <input name="Label_Upload4" class="lable_upload" />
                           <input name="Label_Upload5" class="lable_upload" />
                           <input type="button" class="show_upload_style" value="可以上传5张图片"  onclick="$('#ctl00_ContentPlaceHolder1_FileUpload5').click()" />   
                           <div class="upload_pic_action">
                               <div class="submit_upload_pic">确定上传</div>
                               <div class="cancel_upload_pic">取消上传</div>
                               <div class="upload_delete_notice">双击图片可删除</div>
                           </div>
                       </div>   

                 </div>
              </div>
              <div class="last-div"></div>
              <div class="box4">
                 <div class="c4">增值服务：</div>
                 <input id="relationphoto_1" class="k1" type="checkbox" />
                 <label for="relationphoto_1">拍照</label>
                 <input class="kk" name="photo_remark_left" />
                 <input type="hidden" name="photo_left" value="0" />
              </div>
              <div class="last-div"></div>
              <div class="box5">
                 <div class="c5">备注信息：</div>
                 <textarea name="package_remark_left"></textarea>
              </div>
        </div>
   </div>

   <div class="hide_right_g_box">
       <div class="g-box">
              <div class="box2"><img src="../Images/Pic_User/xx2.png" /></div>
              <div class="box3">
                 <div class="c3">商品信息：<div class="address">新增地址</div></div>
                 
                 <div class="c3_box">
                    <div class="w1">商品名称</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w2">品牌</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w3">单价</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w4">货币</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w5">数量</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w6">购买链接</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="w7">操作</div>
                 </div>
                 <ul class="c3-box1">
                    <li class="clone_place"></li>
                 </ul>
                 <div class="last-div"></div>
                 <div class="c3-box2">
                    <select  name="roadline_explain_right">
                        <option value="0">请选择转运路线</option>
                   </select>
                    <select  name="address_delivery_right">
                        <option value="0">请选择收货地址</option>
                        <asp:Literal ID="Literal_Address_Clone" runat="server">
                            <option value="nameHere">addressHere</option>
                        </asp:Literal>
                    </select>
                 </div>
              </div>
              <div class="last-div"></div>
              <div class="box4">
                 <div class="c4">增值服务：</div>
                 <input id="relationjg_1" class="k1" type="checkbox" />
                 <label for="relationjg_1">加固</label>
                 <input class="kk" name="reinforce_remark_right" />
                 <input type="hidden" name="reinforce_right" value="0" />
              </div>
              <div class="last-div"></div>
              <div class="box5">
                 <div class="c5">提醒方式：</div> 
                  <input class="k4" type='text' name='notice_right' placeholder='请输入手机号码或者邮箱' onblur='CheckNoticeType(this)' id='Text1' />
                  <input id="relationnotice_1" class="k5" type="checkbox"  />
                  <label for="relationnotice_1">(设为默认提醒方式)</label>
              </div>
            </div>
   </div>

</asp:Content>
