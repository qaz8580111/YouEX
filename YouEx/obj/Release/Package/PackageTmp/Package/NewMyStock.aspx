<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="NewMyStock.aspx.cs" Inherits="WebSite.Package.NewMyStock" %>
<%@ Register Assembly="WebSite" Namespace="WebSite.Tool.Control" TagPrefix="nac" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/newmystock.css"  />
    <link rel="stylesheet" type="text/css" href="../Include/CSS/loading.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-运单操作</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        $(function () {            
            newpackage_reload();
            window.upload_count_arr = new Array();
            upload_count_arr[0] = 0;
        });
    </script>

    <div class="main-meun"> 
   <div class="main-meun-box">
     <div class="word">
          <a href="./NewMyStock.aspx"><div class="stock">
          库存
          </div> </a>
          <a href="./NewMyStock.aspx?ordertype=delivery_waiting"><div class="pending-way-bill">
          待处理运单
          </div></a>
          <a href="./NewMyStock.aspx?ordertype=delivery_paybill"><div class="pay-bill-ing">
          待支付运单
          </div></a>
          <a href="./NewMyStock.aspx?ordertype=delivery_transport"><div class="transform-ing">
          运输中运单
          </div></a>
          <a href="./NewMyStock.aspx?ordertype=delivery_finished"><div class="finish-end">
          已完成运单
          </div></a>
          <a href="./NewPackage.aspx" style="width:100px;margin-left:475px"><img src="../Images/Pic_User/new-p-100.png"/></a>
      </div>
      <div class="last-div"></div>
      <div class="blue-ht">
        <div class="blue1"></div>
      </div>
      <div class="ht"></div>
   </div>
 </div>

     <div class="spinner">
      <div class="spinner-container container1">
        <div class="circle1"></div>
        <div class="circle2"></div>
        <div class="circle3"></div>
      </div>
      <div class="spinner-container container2">
        <div class="circle1"></div>
        <div class="circle2"></div>
        <div class="circle3"></div>
        <div class="circle4"></div>
      </div>
      <div class="spinner-container container3">
        <div class="circle1"></div>
        <div class="circle2"></div>
        <div class="circle3"></div>
        <div class="circle4"></div>
      </div>
    </div>

     <div class="pending-content" id="all_packages">
   
     <asp:Literal ID="Literal_Package" runat="server">   
        <div class="pu-waybill">
            <div class="title">
                <div class="w1">我的包裹</div>
                <div class="w2">包裹信息</div>
                <div class="w3">基本操作</div>
            </div>
            <div class="last-div"></div>
            <dl>
                <dd class="b9">
                    <span class="word">运单号：shippingnoHere</span>
                    <img src="../Images/Pic_User/waybill-big.png" />
                    <img class="img_del_packagenoHere" src="../Images/Pic_User/tanhao.png" title="退货审核中" />
                    <script>
                        if ("statusHere" == "23")                            
                            $(".img_del_packagenoHere").show();
                    </script>
                </dd>
            </dl>
            <dl class="package_xin9">
                <dd>提交时间：createtimeHere</dd>
                <dd>入库时间：storagetimeHere</dd>
                <dd>备注：remarkHere</dd>
            </dl>
            <dl class="mystock_xin10">
                <input class="delete_package" type="button" name="abort_packagenoHere" value="弃货" />
                <dd class="tui" id="packagetui_packagenoHere">退货</dd>
            </dl>
            <div class="button">
              <input type="button" class="edit_package_action" name="packagenoHere" value="提交包裹" />
            </div>
        </div>
    </asp:Literal>
   </div>

     <div class="pending-content" id="all_deliverys_waiting">
     <asp:Literal ID="Literal_Delivery_Waiting" runat="server">
        <div class="pu-waybill">
            <div class="title">
                <div class="w1">我的运单</div>
                <div class="w4">&nbsp;</div>
                <div class="w2">运单信息</div>
                <div class="w3">基本操作</div>
            </div>
            <div class="last-div"></div>

            <div class="show_package_default_packagenoHere">
                <dl class="b9"><dd>
                    <div class="word">运单号：shippingnoHere</div>
                    <img src="../Images/Pic_User/waybill-big.png" />
                </dd></dl>
                <dl class="bb9"><dd>
                    <img src="../Images/Pic_User/jiantou.png" style="margin-top:50px;" />
                </dd></dl>
                <dl class="bb9"><dd>
                    <div class="word">&nbsp;</div>
                    <img src="../Images/Pic_User/waybill-big.png" />
                </dd></dl>
            </div>

            <div class="show_package_split_packagenoHere">
                <dl class="b9"><dd>
                    <div class="word">运单号：shippingnoHere</div>
                    <img src="../Images/Pic_User/waybill-big.png" />
                </dd></dl>
                <dl class="bb9"><dd>
                    <img src="../Images/Pic_User/jiantou.png" style="margin-top:50px;" />
                </dd></dl>
                <dl class="bb9"><dd style="margin-right:-5px;">
                    <span class="split_img_1"><img src="../Images/Pic_User/waybill.png" />
                    </span>
                    <span class="split_img_2"><img src="../Images/Pic_User/shi.png" /></span>
                    <span class="split_img_3"><img src="../Images/Pic_User/waybill.png" /></span>
                </dd></dl>
            </div>

            <div class="show_package_add_packagenoHere">
                <dl class="b9"><dd>
                    <div class="word">运单号：shippingnoHere</div>
                    <span class="add_img_1"><img src="../Images/Pic_User/waybill.png" /></span>
                    <span class="add_img_2"><img src="../Images/Pic_User/shi.png" /></span>
                    <span class="add_img_3"><img src="../Images/Pic_User/waybill.png" /></span>
                    <div class="addpage_beauty">&nbsp;</div>
                </dd></dl>
                <dl class="bb9"><dd>
                   <img src="../Images/Pic_User/jiantou.png" style="margin-top:70px;" />
                </dd></dl>
                <dl class="bb9"><dd>                    
                    <img src="../Images/Pic_User/waybill-big.png" style="margin-top:50px" />
                </dd></dl>
            </div>

            <div class="show_package_multi_packagenoHere">
                <dl class="b9"><dd>
                    <div class="word">运单号：shippingnoHere</div>
                    <span class="add_img_1"><img src="../Images/Pic_User/waybill.png" /></span>
                    <span class="add_img_2"><img src="../Images/Pic_User/shi.png" /></span>
                    <span class="add_img_3"><img src="../Images/Pic_User/waybill.png" /></span>
                    <div class="addpage_beauty">&nbsp;</div>
                </dd></dl>
                <dl class="bb9"><dd>
                   <img src="../Images/Pic_User/jiantou.png" style="margin-top:70px;" />
                </dd></dl>
                <dl class="b9_multi"><dd>
                    <span class="add_img_1"><img src="../Images/Pic_User/waybill.png" /></span>
                    <span class="add_img_2"><img src="../Images/Pic_User/shi.png" /></span>
                    <span class="add_img_3"><img src="../Images/Pic_User/waybill.png" /></span>
                    <div class="addpage_beauty">&nbsp;</div>
                </dd></dl>
            </div>

            <dl class="xin9">
                <dd>提交时间：createtimeHere</dd>
                <dd>运输路线：shippingidHere</dd>
                <dd>联系方式：notifyHere</dd>
                <dd>备注：remarkHere</dd>
            </dl>
            <dl class="xin10">
                <input class="delete_delivery" type="button" name="ordernoHere" value="删除运单" />
                <dd class="package_track" id="waitingdelivery_packagenoHere">包裹跟踪</dd>
            </dl>
            <div class="button">
              <input type="button" class="edit_delivery_action" name="ordernoHere" value="编辑运单" />    
              <input type="button" class="cancel_delivery_action" name="ordernoHere" id="cancelaction_packagenoHere"  value=""  />          
            </div>
            
        </div>       
    
       <script>
             if ("packagestatusshowHere" == "default") {
                 $(".show_package_default_packagenoHere").show();
             }
             if ("packagestatusshowHere" == "split") {
                 $(".show_package_split_packagenoHere").show();
                 $("#cancelaction_packagenoHere").val("取消分箱");
                 $("#cancelaction_packagenoHere").show();
             }
             if ("packagestatusshowHere" == "add") {
                 $(".show_package_add_packagenoHere").show();
                 $("#cancelaction_packagenoHere").val("取消合箱");
                 $("#cancelaction_packagenoHere").show();
             }
             if ("packagestatusshowHere" == "multi") {
                 $(".show_package_multi_packagenoHere").show();
                 $("#cancelaction_packagenoHere").val("取消操作");
                 $("#cancelaction_packagenoHere").show();
             }

           $(".delete_package,.tui,.package_track,.return-button,.edit_delivery_action,.cancel_add_package,"
             + ".save_d_package,.add_delivery_word,.save_stock_good_word,.cancel_stock_good_word,.delete_delivery,.clone_remove,.add_delivery_sure,"
             + ".cancel_delivery_action,.add_delivery_word,.save_stock_good_word,.cancel_stock_good_word,.submit_delivery_default,.add_package_sure").mouseenter(function () {
                 $(this).css("text-decoration", "underline");
             }).mouseleave(function () {
                 $(this).css("text-decoration", "none");
             })
                </script>

    </asp:Literal>

    </div>

     <div class="pending-content" id="all_deliverys_paybill">
   
     <asp:Literal ID="Literal_Delivery_PayBill" runat="server">
        <div class="pu-waybill">
            <div class="title">
                <div class="w1">待支付运单</div>
                <div class="w2">运单信息</div>
                <div class="w3">基本操作</div>
            </div>
            <div class="last-div"></div>
            <dl>
                <dd class="paybill_b9">
                    <div class="word">运单号：shippingnoHere</div>
                    <img src="../Images/Pic_User/waybill-big.png" />
                </dd>
            </dl>
            <dl class="paybill_xin9">
                <dd>提交时间：createtimeHere</dd>
                <dd>运输路线：shippingidHere</dd>
                <dd>联系方式：notifyHere</dd>
                <dd>备注：remarkHere</dd>
            </dl>
            <dl class="xin11">
                <dd class="package_track" id="paybilldelivery_packagenoHere">包裹跟踪</dd>
            </dl>
            <div class="button">
              <input type="text" class="pay_bill" name="ordernoHere" value="付款" />
            </div>
        </div>
         

    </asp:Literal>

    </div>

     <div class="pending-content" id="all_deliverys_transport">
   
     <asp:Literal ID="Literal_Delivery_Transport" runat="server">
        <div class="pu-waybill">
            <div class="title">
                <div class="w1">发出运单</div>
                <div class="w2">运单信息</div>
                <div class="w3">基本操作</div>
            </div>
            <div class="last-div"></div>
            <dl>
                <dd class="b9">
                    <div class="word">运单号：shippingnoHere</div>
                    <img src="../Images/Pic_User/waybill-big.png" />
                </dd>
            </dl>
            <dl class="transform_xin9">
                <dd>提交时间：createtimeHere</dd>
                <dd>运输路线：shippingidHere</dd>
                <dd>包裹重量：weightHere</dd>
                <dd>包裹长度：lengthHere</dd>
                <dd>包裹宽度：widthHere</dd>
                <dd>包裹高度：heightHere</dd>
            </dl>
            <dl class="xin11">
                <dd class="package_track" id="transportdelivery_packagenoHere">包裹跟踪</dd>
            </dl>
        </div>
         

    </asp:Literal>

 </div>

     <div class="pending-content" id="all_deliverys_finished">
   
     <asp:Literal ID="Literal_Delivery_Finished" runat="server">
        <div class="pu-waybill">
            <div class="title">
                <div class="w1">完成运单</div>
                <div class="w2">运单信息</div>
                <div class="w3">基本操作</div>
            </div>
            <div class="last-div"></div>
            <dl>
                <dd class="b9">
                    <div class="word">运单号：shippingnoHere</div>
                    <img src="../Images/Pic_User/waybill-big.png" />
                </dd>
            </dl>
            <dl class="finished_xin9">
                <dd>提交时间：createtimeHere</dd>
                <dd>运输路线：shippingidHere</dd>
                <dd>包裹重量：weightHere</dd>
                <dd>包裹长度：lengthHere</dd>
                <dd>包裹宽度：widthHere</dd>
                <dd>包裹高度：heightHere</dd>
                <dd>备注：remarkHere</dd>
            </dl>
            <dl class="xin11">
                <dd class="package_track" id="finisheddelivery_packagenoHere">包裹跟踪</dd>
            </dl>
        </div>
        

    </asp:Literal>

 </div>

  <div class="return-button-box"><div class="return-button">返回</div></div>
  <div class="bj"></div>

  <asp:Literal ID="Literal_OrderType" runat="server">
        <input class="hide_ordertype" value="ordertypeHere" style="display:none;" />
  </asp:Literal>


    <!--退货操作-->
   <div class="refund">
    <div class="title">退货</div>
    <div class="line1"><img src="../Images/Pic_User/xuxian-650.png"/></div>
    <div class="addressee">
       <div class="word">收件人：</div>
       <input name="refund_recipients" />
    </div>
    <div class="last-div"></div>
    <div class="addressee-phone">
       <div class="word">收件人手机：</div>
       <input name="refund_mobile" />
    </div>
    <div class="last-div"></div>
    <div class="address-one">
       <div class="word">地址第一行：</div>
       <input name="refund_addressone" />
    </div>
    <div class="last-div"></div>
    <div class="address-one">
       <div class="word">地址第二行：</div>
       <input name="refund_addresstwo" />
    </div>
    <div class="last-div"></div>
    <div class="zhou">
       <div class="word">州：</div>
       <input name="refund_province" />
    </div>
    <div class="last-div"></div>
    <div class="zip-code">
       <div class="word">邮编：</div>
       <input name="refund_zipcode" />
    </div>
    <div class="last-div"></div>
    <div class="e-mail">
         <div class="word">退运费用：</div>
         <input name="refund_price" />
    </div>
    <div class="last-div"></div>
    <div class="e-mail">
         <div class="word">通知邮箱：</div>
         <input name="refund_email" />
    </div>
    <div class="last-div"></div>
    <div class="button">
        <input class="refund_submit_button_p"  />
        <input class="refund_cancel_button_p"  />
    </div>
  </div>


<!---------------NewPackage------------------->

   <div class="content-bj">
    <!--左侧-->
    <asp:Panel ID="Panel1" runat="server">
     <div class="left">
         <div class="title-word">添加新包裹</div><img class="jia-26" src="../Images/Pic_User/jia-26.png"/>  
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
                        <input class="i1" name="good_name" value="" oninput="clone_flush(this);" />
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
     </div>
    
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
          <div class="button-box">
            <input class="NewDelivery_Submit" type="button" runat="server" onclick="if (!new_check_delivery()) { return false; };" onserverclick="SubmitDelivery" value="修改运单"  />
            <div class="button_mystock">取消</div>
            <input class="hidden_packageno" name="hidden_packageno" value="" />
            <input class="hidden_orderno" name="hidden_orderno" value="" />
          </div> 
        </div>
    </div>
    </asp:Panel>

  </div>   

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
         <img class="no-sure" src="../Images/Pic_User/no-sure.png" />
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
