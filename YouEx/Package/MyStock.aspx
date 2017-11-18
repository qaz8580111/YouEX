<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MyStock.aspx.cs" Inherits="WebSite.Package.MyStock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="../Include/CSS/mystock.css"  />
    <link rel="stylesheet" type="text/css" href="../Include/CSS/loading.css"  />
    <link rel="shortcut icon" href="../Images/Pic_Main/logo-16.png" />
    <title>联邦转运FedRoad-运单操作</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
     <div class="main-meun"> 
   <div class="main-meun-box">
     <div class="word">
          <a href="./MyStock.aspx"><div class="stock">
          库存
          </div> </a>
          <a href="./MyStock.aspx?ordertype=delivery_waiting"><div class="pending-way-bill">
          待处理运单
          </div></a>
          <a href="./MyStock.aspx?ordertype=delivery_paybill"><div class="pay-bill-ing">
          待支付运单
          </div></a>
          <a href="./MyStock.aspx?ordertype=delivery_transport"><div class="transform-ing">
          运输中运单
          </div></a>
          <a href="./MyStock.aspx?ordertype=delivery_finished"><div class="finish-end">
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
                    <input type="checkbox" name="check_package" value="packagenoHere"/><span class="word">运单号：</span>
                    <div class="word" style="margin-left:15px;">shippingnoHere</div>
                    <img src="../Images/Pic_User/waybill-big.png" />
                    <img class="img_del_packagenoHere" src="../Images/Pic_User/tanhao.png" />
                    <input class="wu1" type="button" name="edit_packagenoHere" value="物品编辑" />
                </dd>
            </dl>
            <dl class="package_xin9">
                <dd>提交时间：createtimeHere</dd>
                <dd>入库时间：storagetimeHere</dd>
                <dd>重量：weightHere</dd>
                <dd>备注：remarkHere</dd>
            </dl>
            <dl class="xin10">
                <input class="delete_package" type="button" name="abort_packagenoHere" value="弃货" />
                <dd class="tui" id="packagetui_packagenoHere">退货</dd>
                <dd class="package_track" id="stockpackage_packagenoHere">包裹跟踪</dd>
            </dl>
            <div class="button">
              <input type="text" class="add_packages" name="packageadd_packagenoHere" value="合箱发货" />
              <input type="text" class="submit_default_package" name="packagedefault_packagenoHere" value="直接发货" />
              <input type="text" class="submit_explain_package" name="packageexplain_packagenoHere" value="分箱发货" />
            </div>
        </div>
     
<!--包裹商品编辑-->
<div class="edit-cargo_packagenoHere">
    <img class="cancel_mystock_goods_icon" src="../Images/Pic_User/XX1.png" />
    <div class="accont-info">
        <div class="title"><p>物品编辑</p><div class="line"></div></div>
    </div>
        <div class="last-div"></div>
        <div class="content-bj">
            <div class="content-box">
            <div class="t3">
                <div class="t3-title">
                    <div class="d1">商品名称</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="d1">品牌</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="d3">单价</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="d5">货币</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="d4">数量</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="d6">购买链接</div><img src="../Images/Pic_User/xuxian.png" />
                    <div class="d8">操作</div>
                </div>
                goodsHere
                <div class="button3">
                    <img id="relation_image_1" class="add" src="../Images/Pic_User/addpng.png" onclick="addTr7(this,-1);" />
                    <label class="addnewpackagegoods" onclick="addTr7(this,-1);">添加新商品</label>
                    <input type="button" class="add_package_sure" name="packagenoHere" />
                    <img class="no-sure" src="../Images/Pic_User/100-no-sure.png" />
                </div>
            </div>
            </div>
        </div>    
</div>

<!-- 合箱操作 -->
<div class="addpackage_packagenoHere">
  <div class="content-bj">
     <img class="cancel_mystock_add_icon" src="../Images/Pic_User/XX1.png" />
     <div class="content-box">
          <div class="t4">
           <div class="word">选择收货地址：</div>
           <div class="content">
               <select name="address_packagenoHere">
                    <option value="0">请选择收货地址</option>
                    addressHere
                </select>
           </div>
        </div>
        <div class="t5">
           <div class="title">选择路线：</div>
           <div class="content">
               <select name="roadline_packagenoHere">
                   <option value="0">请选择转运路线</option>
                    shippingHere
               </select>
           </div>
        </div>
        <div class="last-div"></div>
        <div class="t6">
           <div class="title">增值服务：</div>
           <div class="content">
              <div class="choose"><input id="relation_input_1_packagenoHere" type="checkbox" name="insurance_packagenoHere" class="c12" value="1" /><label for="relation_input_1_packagenoHere">购买保险</label></div>
              <div class="choose"><input id="relation_input_2_packagenoHere" type="checkbox" name="invoice_packagenoHere" class="c12" value="1" /><label for="relation_input_2_packagenoHere">需要发票</label></div>
           </div>
        </div>
        <div class="last-div"></div>
        <div class="t7">
            <div class="title">提醒方式：</div>
            <div class="content">
                <div class="choose"><div><input id="relation_input_3_packagenoHere" type="radio" name="type_notice_packagenoHere" class="c12" value="2" /></div><label for="relation_input_3_packagenoHere">不需要提醒</label></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_4_packagenoHere" type="radio" name="type_notice_packagenoHere" class="c12" value="0" /><label for="relation_input_4_packagenoHere">短信提醒</label><input class="c13" name="connection_packagenoHere" type="text" /></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_5_packagenoHere" type="radio" name="type_notice_packagenoHere" class="c12" value="1" /><label for="relation_input_5_packagenoHere">邮箱提醒</label><input class="c13" name="connection_packagenoHere" type="text" /></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t8"> 
            <div class="title">支付方式：</div>
            <div class="content">
              <div class="choose"><input id="relation_input_6_packagenoHere" type="radio" name="type_pay_packagenoHere" value="0" class="c12" checked="checked" /><label for="relation_input_6_packagenoHere">手动确认支付</label></div>
              <div class="choose"><input id="relation_input_7_packagenoHere" type="radio" name="type_pay_packagenoHere" value="1" class="c12" /><label for="relation_input_7_packagenoHere">称重后自动结算（需要有足够的余额）</label></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t9">
            <div class="title">同意条款：</div>
            <div class="content">
               <input id="relation_input_8_packagenoHere" type="checkbox" class="package_agree" checked="checked" /><label for="relation_input_8_packagenoHere">我已阅读，并同意</label><a href="../Help/PayAgreement.aspx">本站相关支付条款</a>
                <div class="cut-of-rule"></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="line"></div>
        <a><img class="cancel_add_package" src="../Images/Pic_User/quxiao.png" /></a>
        <input type="button" class="save_add_package" name="packagenoHere" value="保存" />
     </div>
    </div>
  </div>

<!--原箱操作-->
<div class="submitpackage_packagenoHere">
  <div class="content-bj">
     <img class="cancel_mystock_default_icon" src="../Images/Pic_User/XX1.png" />
     <div class="content-box">         
          <div class="t4">
           <div class="word">选择收货地址：</div>
           <div class="content">
               <select  name="address_d_packagenoHere">
                    <option value="0">请选择收货地址</option>
                    addressHere
                </select>
           </div>
        </div>
        <div class="t5">
           <div class="title">选择路线：</div>
           <div class="content">
               <select name="roadline_d_packagenoHere">
                   <option value="0">请选择转运路线</option>
                    shippingHere
               </select>
           </div>
        </div>
        <div class="last-div"></div>
        <div class="t6">
           <div class="title">增值服务：</div>
           <div class="content">
              <div class="choose"><input id="relation_input_9_packagenoHere" type="checkbox" name="insurance_d_packagenoHere" class="c12" value="1" /><label for="relation_input_9_packagenoHere">购买保险</label></div>
              <div class="choose"><input id="relation_input_10_packagenoHere" type="checkbox" name="invoice_d_packagenoHere" class="c12" value="1" /><label for="relation_input_10_packagenoHere">需要发票</label></div>
           </div>
        </div>
        <div class="last-div"></div>
        <div class="t7">
            <div class="title">提醒方式：</div>
            <div class="content">
                <div class="choose"><div><input id="relation_input_11_packagenoHere" type="radio" name="type_notice_d_packagenoHere" class="c12" value="2" /></div><label for="relation_input_11_packagenoHere">不需要提醒</label></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_12_packagenoHere" type="radio" name="type_notice_d_packagenoHere" class="c12" value="0" /><label for="relation_input_12_packagenoHere">短信提醒</label><input class="c13" name="connection_d_packagenoHere" type="text" /></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_13_packagenoHere" type="radio" name="type_notice_d_packagenoHere" class="c12" value="1" /><label for="relation_input_13_packagenoHere">邮箱提醒</label><input class="c13" name="connection_d_packagenoHere" type="text" /></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t8"> 
            <div class="title">支付方式：</div>
            <div class="content">
              <div class="choose"><input id="relation_input_14_packagenoHere" type="radio" name="type_pay_d_packagenoHere" value="0" class="c12" checked="checked" /><label for="relation_input_14_packagenoHere">手动确认支付</label></div>
              <div class="choose"><input id="relation_input_15_packagenoHere" type="radio" name="type_pay_d_packagenoHere" value="1" class="c12" /><label for="relation_input_15_packagenoHere">称重后自动结算（需要有足够的余额）</label></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t9">
            <div class="title">同意条款：</div>
            <div class="content">
               <input id="relation_input_16_packagenoHere" type="checkbox" class="package_d_agree" checked="checked" /><label for="relation_input_16_packagenoHere">我已阅读，并同意</label><a href="../Help/PayAgreement.aspx">本站相关支付条款</a>
                <div class="cut-of-rule"></div>                
            </div>
        </div>  
        <div class="last-div"></div>
        <div class="line"></div>
        <a><img class="cancel_d_package" src="../Images/Pic_User/quxiao.png" /></a>
        <input type="button" class="save_d_package" name="packagenoHere" value="保存" />
     </div>
  </div>
  </div>

<!--分箱编辑-->
<div class="explain_packagenoHere">
        <div class="newword"><span style="margin-left:25px;">原箱信息</span>
            <span style="margin-left:44%;">分箱信息</span>
            <img id="deliveryimageclose_packagenoHere" class="cancel_mystock_delivery_icon" src="../Images/Pic_User/XX1.png" />
        </div>
        <div id="clone_explain_packagenoHere">
        <div class="t3">
            <div class="delivery_info">
           <div class="word-title">
              <div class="word_name"><input id="clone_delivery_no_packagenoHere" value="1" />商品名称</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_brand">品牌</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_price">单价</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_amount">数量</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_buyurl">购买链接</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_action">操作</div>
               <div class="hide_calculate"><div class="calculate_amount_packagenoHere"><input name="clone_calculate" /></div></div>
           </div>
            explainbeforeHere
            </div>
           <div class="last-div"></div>
           <div class="t3-content2">
             <div class="add"><input type="button" onclick="addTr9(this, -1);" style="width:29px;height:29px;background:url('../Images/Pic_User/addpng.png')" name="packagenoHere" /><div>添加新商品</div></div>
               <div>
                   <select name="roadline_clone_packagenoHere">
                    <option value="0">请选择转运路线</option>
                    shippingHere
                    </select>
               </div>
               
               <div>
                   <select  name="address_clone_packagenoHere">
                        <option value="0">请选择收货地址</option>
                            addressHere
                    </select>
                   <input class="clone_remove" name="cloneremove_packagenoHere" value="删除" />
               </div>
           </div>
            </div>
            <div class="add_delivery_stock" id="sendvaluepack_packagenoHere">
                <span class="add_delivery_word">+新增分箱+</span>
            </div>
        </div>

        <div id="cloneing_explain_packagenoHere">
            <div id="cloneing_right"></div>
        </div>

        <div style="float:right;width:50%;">
        <div class="last-div"></div>
        <div class="t6">
           <div class="title">增值服务：</div>
           <div class="content">
              <div class="choose"><input id="relation_input_17_packagenoHere" type="checkbox" name="insurance_explain_packagenoHere" class="c12" value="1" /><label for="relation_input_17_packagenoHere">购买保险</label></div>
              <div class="choose"><input id="relation_input_18_packagenoHere" type="checkbox" name="invoice_explain_packagenoHere" class="c12" value="1" /><label for="relation_input_18_packagenoHere">需要发票</label></div>
           </div>
        </div>
        <div class="last-div"></div>
        <div class="t7">
            <div class="title">提醒方式：</div>
            <div class="content">
                <div class="choose"><div><input id="relation_input_19_packagenoHere" type="radio" name="type_notice_explain_packagenoHere" class="c12" value="2" /></div><label for="relation_input_19_packagenoHere">不需要提醒</label></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_20_packagenoHere" type="radio" name="type_notice_explain_packagenoHere" class="c12" value="0" /><label for="relation_input_20_packagenoHere">短信提醒</label><input class="c13" name="connection_explain_packagenoHere" type="text" /></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_21_packagenoHere" type="radio" name="type_notice_explain_packagenoHere" class="c12" value="1" /><label for="relation_input_21_packagenoHere">邮箱提醒</label><input class="c13" name="connection_explain_packagenoHere" type="text" /></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t8"> 
            <div class="title">支付方式：</div>
            <div class="content">
              <div class="choose"><input id="relation_input_22_packagenoHere" type="radio" name="type_pay_explain_packagenoHere" value="0" class="c12" checked="checked" /><label for="relation_input_22_packagenoHere">手动确认支付</label></div>
              <div class="choose"><input id="relation_input_23_packagenoHere" type="radio" name="type_pay_explain_packagenoHere" value="1" class="c12" /><label for="relation_input_23_packagenoHere">称重后自动结算（需要有足够的余额）</label></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t9">
            <div class="title">同意条款：</div>
            <div class="content">
               <input id="relation_input_24_packagenoHere" checked="checked" type="checkbox" class="explain_agree_packagenoHere" /><label for="relation_input_24_packagenoHere">我已阅读，并同意</label><a href="../Help/PayAgreement.aspx">本站相关支付条款</a>
            </div>
            <div class="last-div"></div>
            <div class="line"></div>
        </div>
        
    </div>
    <div class="fixed_showdelivery_button_delivery">        
        <div class="save_stock_good" id="savestockgood_packagenoHere"><span class="save_stock_good_word">保存</span></div>
        <div class="cancel_stock_good" id="cancelstockgood_packagenoHere"><span class="cancel_stock_good_word">取消</span></div>
    </div>
  </div>

<!--退货操作-->
<div class="refund_packagenoHere">
    <div class="title">退货</div>
    <div class="line1"><img src="../Images/Pic_User/xuxian-650.png"/></div>
    <div class="addressee">
       <div class="word">收件人：</div>
       <input name="refund_recipients_packagenoHere" />
    </div>
    <div class="last-div"></div>
    <div class="addressee-phone">
       <div class="word">收件人手机：</div>
       <input name="refund_mobile_packagenoHere" />
    </div>
    <div class="last-div"></div>
    <div class="address-one">
       <div class="word">地址第一行：</div>
       <input name="refund_addressone_packagenoHere" />
    </div>
    <div class="last-div"></div>
    <div class="address-one">
       <div class="word">地址第二行：</div>
       <input name="refund_addresstwo_packagenoHere" />
    </div>
    <div class="last-div"></div>
    <div class="zhou">
       <div class="word">州：</div>
       <input name="refund_province_packagenoHere" />
    </div>
    <div class="last-div"></div>
    <div class="zip-code">
       <div class="word">邮编：</div>
       <input name="refund_zipcode_packagenoHere" />
    </div>
    <div class="last-div"></div>
    <div class="e-mail">
         <div class="word">退运费用：</div>
         <input name="refund_price_packagenoHere" />
    </div>
    <div class="last-div"></div>
    <div class="e-mail">
         <div class="word">通知邮箱：</div>
         <input name="refund_email_packagenoHere" />
    </div>
    <div class="last-div"></div>
    <div class="button">
        <input class="refund_submit_button_p" name="refundsubmit_packagenoHere" />
        <input class="refund_cancel_button_p" name="refundcancel_packagenoHere" />
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

            <div class="show_package_default_deliverynoHere">
                <dl class="b9"><dd>
                    <div class="word">运单号：shippingnoHere</div>
                    <img src="../Images/Pic_User/waybill-big.png" />
                    <input class="wu1" type="button" name="edit_deliverynoHere" value="物品编辑" />
                </dd></dl>
                <dl class="bb9"><dd>
                    <img src="../Images/Pic_User/jiantou.png" style="margin-top:50px;" />
                </dd></dl>
                <dl class="bb9"><dd>
                    <div class="word">&nbsp;</div>
                    <img src="../Images/Pic_User/waybill-big.png" />
                </dd></dl>
            </div>

            <div class="show_package_split_deliverynoHere">
                <dl class="b9"><dd>
                    <div class="word">运单号：shippingnoHere</div>
                    <img src="../Images/Pic_User/waybill-big.png" />
                    <input class="wu1" type="button" name="edit_deliverynoHere" value="物品编辑" />
                </dd></dl>
                <dl class="bb9"><dd>
                    <img src="../Images/Pic_User/jiantou.png" style="margin-top:50px;" />
                </dd></dl>
                <dl class="bb9"><dd style="margin-right:-5px;">
                    <span class="split_img_1"><img src="../Images/Pic_User/waybill.png" />
                        <!--<strong>x</strong>
                        <strong>deliverycountHere</strong>-->
                    </span>
                    <span class="split_img_2"><img src="../Images/Pic_User/shi.png" /></span>
                    <span class="split_img_3"><img src="../Images/Pic_User/waybill.png" /></span>
                </dd></dl>
            </div>

            <div class="show_package_add_deliverynoHere">
                <dl class="b9"><dd>
                    <div class="word">运单号：shippingnoHere</div>
                    <span class="add_img_1"><img src="../Images/Pic_User/waybill.png" /></span>
                    <!--<strong>x</strong>
                    <strong>packagecountHere</strong>-->
                    <span class="add_img_2"><img src="../Images/Pic_User/shi.png" /></span>
                    <span class="add_img_3"><img src="../Images/Pic_User/waybill.png" /></span>
                    <input class="wu1" type="button" name="edit_deliverynoHere" value="物品编辑" />
                    <div class="addpage_beauty">&nbsp;</div>
                </dd></dl>
                <dl class="bb9"><dd>
                   <img src="../Images/Pic_User/jiantou.png" style="margin-top:70px;" />
                </dd></dl>
                <dl class="bb9"><dd>                    
                    <img src="../Images/Pic_User/waybill-big.png" style="margin-top:50px" />
                </dd></dl>
            </div>

            <dl class="xin9">
                <dd>提交时间：createtimeHere</dd>
                <dd>运输路线：shippingidHere</dd>
                <dd>重量：weightHere</dd>
                <dd>联系方式：notifyHere</dd>
            </dl>
            <dl class="xin10">
                <input class="delete_delivery" type="button" name="deliverynoHere" value="删除运单" />
                <dd class="package_track" id="waitingdelivery_deliverynoHere">包裹跟踪</dd>
            </dl>
            <div class="button">
              <input type="button" class="zhi-fahuo" name="deliverynoHere" />    
              <input type="button" class="cancel_delivery_action" name="deliverynoHere" id="cancelaction_deliverynoHere" value=""  />          
            </div>
            
        </div>      
     
<!--运单商品编辑-->
 <div class="edit-cargo_deliverynoHere">
     <img class="cancel_delivery_goods_icon" src="../Images/Pic_User/XX1.png" />
       <div class="accont-info">
          <div class="title"><p>物品编辑</p><div class="line"></div></div>
       </div>
          <div class="last-div"></div>
          <div class="content-bj">
             <div class="content-box">
                <div class="t3">
                   <div class="t3-title">
                      <div class="d1">商品名称</div><img src="../Images/Pic_User/xuxian.png" />
                      <div class="d1">品牌</div><img src="../Images/Pic_User/xuxian.png" />
                      <div class="d3">单价</div><img src="../Images/Pic_User/xuxian.png" />
                      <div class="d5">货币</div><img src="../Images/Pic_User/xuxian.png" />
                      <div class="d4">数量</div><img src="../Images/Pic_User/xuxian.png" />
                      <div class="d6">购买链接</div><img src="../Images/Pic_User/xuxian.png" />
                      <div class="d8">操作</div>
                   </div>
                    goodsHere
                  <div class="button3">
                     <img class="add" src="../Images/Pic_User/addpng.png" onclick="addTr7(this,-1);" />
                     <label for="relation_image_2" class="addnewpackagegoods" onclick="addTr7(this,-1);">添加新商品</label>
                     <input type="button" class="add_delivery_sure" name="deliverynoHere" />
                     <img class="no-sure" src="../Images/Pic_User/100-no-sure.png" />
                  </div>
               </div>
             </div>
          </div>
        </div>

<!--直接编辑-->
<div class="fahuo_deliverynoHere">
  <div class="content-bj">
    <img class="cancel_delivery_default_icon" src="../Images/Pic_User/XX1.png" />   
     <div class="content-box">
          <div class="t4">
           <div class="word">选择收货地址：</div>
           <div class="content">
               <select  name="address_deliverynoHere">
                    <option value="0">请选择收货地址</option>
                    addressHere
                </select>
           </div>
        </div>
        <div class="t5">
           <div class="title">选择路线：</div>
           <div class="content">
               <select name="roadline_deliverynoHere">
                   <option value="0">请选择转运路线</option>
                    shippingHere
               </select>
           </div>
        </div>
        <div class="last-div"></div>
        <div class="t6">
           <div class="title">增值服务：</div>
           <div class="content">
              <div class="choose"><input id="relation_input_25_deliverynoHere" type="checkbox" name="insurance_deliverynoHere" class="c12" value="1" /><label for="relation_input_25_deliverynoHere">购买保险</label></div>
              <div class="choose"><input id="relation_input_26_deliverynoHere" type="checkbox" name="invoice_deliverynoHere" class="c12" value="1" /><label for="relation_input_26_deliverynoHere">需要发票</label></div>
           </div>
        </div>
        <div class="last-div"></div>
        <div class="t7">
            <div class="title">提醒方式：</div>
            <div class="content">
                <div class="choose"><div><input id="relation_input_27_deliverynoHere" type="radio" name="type_notice_deliverynoHere" class="c12" value="2" /></div><label for="relation_input_27_deliverynoHere">不需要提醒</label></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_28_deliverynoHere" type="radio" name="type_notice_deliverynoHere" class="c12" value="0" /><label for="relation_input_28_deliverynoHere">短信提醒</label><input class="c13" name="connection_deliverynoHere" type="text" /></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_29_deliverynoHere" type="radio" name="type_notice_deliverynoHere" class="c12" value="1" /><label for="relation_input_29_deliverynoHere">邮箱提醒</label><input class="c13" name="connection_deliverynoHere" type="text" /></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t8"> 
            <div class="title">支付方式：</div>
            <div class="content">
              <div class="choose"><input id="relation_input_30_deliverynoHere" type="radio" name="type_pay_deliverynoHere" value="0" class="c12" /><label for="relation_input_30_deliverynoHere">手动确认支付</label></div>
              <div class="choose"><input id="relation_input_31_deliverynoHere" type="radio" name="type_pay_deliverynoHere" value="1" class="c12" /><label for="relation_input_31_deliverynoHere">称重后自动结算（需要有足够的余额）</label></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t9">
            <div class="title">同意条款：</div>
            <div class="content">
               <input id="relation_input_32_deliverynoHere" type="checkbox" class="default_agree_deliverynoHere" checked="checked" /><label for="relation_input_32_deliverynoHere">我已阅读，并同意</label><a href="../Help/PayAgreement.aspx">本站相关支付条款</a>               
            </div>    
        </div>
        <div class="last-div"></div>
        <div class="line"></div>
        <a><img class="button_delivery_default" src="../Images/Pic_User/quxiao.png" /></a>
        <input type="button" class="submit_delivery_default" name="deliverynoHere" value="保存" />
     </div>      
  </div>
  </div>

<!--分箱编辑-->
<div class="explain_deliverynoHere">
        <div class="newword">
            <span style="margin-left:25px;">原箱信息</span>
            <span style="margin-left:44%;">分箱信息</span>
            <img src="../Images/Pic_User/XX1.png" class="delivery_delivery_close" id="canceldelivery2_deliverynoHere" />
        </div>
        <div id="clone_explain_deliverynoHere">
        <div class="t3">
            <div class="delivery_info">
           <div class="word-title">
              <div class="word_name"><input id="clone_delivery_no_deliverynoHere" value="1" />商品名称</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_brand">品牌</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_price">单价</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_amount">数量</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_buyurl">购买链接</div><img src="../Images/Pic_User/xuxian.png" />
              <div class="word_action">操作</div>
               <div class="hide_calculate"><div class="calculate_amount_deliverynoHere"><input name="clone_calculate" /></div></div>
           </div>
            explainbeforeHere
            </div>

           <div class="last-div"></div>
           <div class="t3-content2">
             <div class="add"><input type="button" onclick="addTr9(this, -1);" style="width:29px;height:29px;background:url('../Images/Pic_User/addpng.png')" name="deliverynoHere" /><div>添加新商品</div></div>
               <div>
                   <select name="roadline_clone_deliverynoHere">
                       <option value="0">请选择转运路线</option>
                        shippingHere
                   </select>
               </div>
               
               <div>
                   <select  name="address_clone_deliverynoHere">
                        <option value="0">请选择收货地址</option>
                           addressHere
                    </select>
                   <input class="clone_remove" name="cloneremove_deliverynoHere" value="删除" />
               </div>
           </div>
            </div>
            <div class="add_delivery_wait" id="deliverywait_deliverynoHere"><span class="add_delivery_word" style="color: white;">+新增分箱+</span></div>
        </div>

        <div id="cloneing_explain_deliverynoHere">
            <div id="cloneing_right_de"></div>
        </div>

        <div style="float:right;width: 50%;">
        <div class="last-div"></div>
        <div class="t6">
           <div class="title">增值服务：</div>
           <div class="content">
              <div class="choose"><input id="relation_input_33_deliverynoHere" type="checkbox" name="insurance_explain_deliverynoHere" class="c12" value="1" /><label for="relation_input_33_deliverynoHere">购买保险</label></div>
              <div class="choose"><input id="relation_input_34_deliverynoHere" type="checkbox" name="invoice_explain_deliverynoHere" class="c12" value="1" /><label for="relation_input_34_deliverynoHere">需要发票</label></div>
           </div>
        </div>
        <div class="last-div"></div>
        <div class="t7">
            <div class="title">提醒方式：</div>
            <div class="content">
                <div class="choose"><div><input id="relation_input_35_deliverynoHere" type="radio" name="type_notice_explain_deliverynoHere" class="c12" value="2" /></div><label for="relation_input_35_deliverynoHere">不需要提醒</label></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_36_deliverynoHere" type="radio" name="type_notice_explain_deliverynoHere" class="c12" value="0" /><label for="relation_input_36_deliverynoHere">短信提醒</label><input class="c13" name="connection_explain_deliverynoHere" type="text" /></div>
                <div class="last-div"></div>
                <div class="choose"><input id="relation_input_37_deliverynoHere" type="radio" name="type_notice_explain_deliverynoHere" class="c12" value="1" /><label for="relation_input_37_deliverynoHere">邮箱提醒</label><input class="c13" name="connection_explain_deliverynoHere" type="text" /></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t8"> 
            <div class="title">支付方式：</div>
            <div class="content">
              <div class="choose"><input id="relation_input_38_deliverynoHere" type="radio" name="type_pay_explain_deliverynoHere" value="0" class="c12" /><label for="relation_input_38_deliverynoHere">手动确认支付</label></div>
              <div class="choose"><input id="relation_input_39_deliverynoHere" type="radio" name="type_pay_explain_deliverynoHere" value="1" class="c12" /><label for="relation_input_39_deliverynoHere">称重后自动结算（需要有足够的余额）</label></div>
            </div>
        </div>
        <div class="last-div"></div>
        <div class="t9">
            <div class="title">同意条款：</div>
            <div class="content">
               <input id="relation_input_40_deliverynoHere" type="checkbox" class="explain_agree_deliverynoHere" checked="checked" /><label for="relation_input_40_deliverynoHere">我已阅读，并同意</label><a href="../Help/PayAgreement.aspx">本站相关支付条款</a>
                <input class="hide_explain_roadline_deliverynoHere" style="display:none" />
                <input class="hide_explain_address_deliverynoHere" style="display:none" />

                <script>                     
                    if($(".hide_ordertype").val()=="")
                        $(".submit_default_package").dblclick();

                    if ("packagestatusshowHere" == "default") {
                        $(".show_package_default_deliverynoHere").show();
                    }
                    if ("packagestatusshowHere" == "split") {
                        $(".show_package_split_deliverynoHere").show();
                        $("#cancelaction_deliverynoHere").val("取消分箱");
                        $("#cancelaction_deliverynoHere").show();
                    }
                    if ("packagestatusshowHere" == "add") {
                        $(".show_package_add_deliverynoHere").show();
                        $("#cancelaction_deliverynoHere").val("取消合箱");
                        $("#cancelaction_deliverynoHere").show();
                    }
                    $(".fahuo_deliverynoHere .t4 .content option[value='addressnameHere']").prop("selected", true);
                    $(".fahuo_deliverynoHere .t5 .content option[value='shippingidintHere']").prop("selected", true);
                    if (invoiceHere == 1) {
                        $(".fahuo_deliverynoHere input[name='invoice_deliverynoHere']").prop("checked", "checked");
                        $(".explain_deliverynoHere input[name='invoice_explain_deliverynoHere']").prop("checked", "checked");
                    }
                    if (insuranceHere == 1)
                        $(".fahuo_deliverynoHere input[name='insurance_deliverynoHere']").prop("checked", "checked");
                        $(".explain_deliverynoHere input[name='insurance_explain_deliverynoHere']").prop("checked", "checked");
                    /*if (notifytypeHere < 2){
                        $(".fahuo_deliverynoHere input[name='type_notice_deliverynoHere']").eq(parseInt(notifytypeHere) + 1).prop("checked", "checked");
                        $(".explain_deliverynoHere input[name='type_notice_explain_deliverynoHere']").eq(parseInt(notifytypeHere)+1).prop("checked", "checked");
                    }else{
                        $(".fahuo_deliverynoHere input[name='type_notice_deliverynoHere']").eq(0).prop("checked", "checked");
                        $(".explain_deliverynoHere input[name='type_notice_explain_deliverynoHere']").eq(0).prop("checked", "checked");
                    }
                    $(".fahuo_deliverynoHere input[name='connection_deliverynoHere']").eq(parseInt(notifytypeHere)).val("notifyHere");
                    $(".fahuo_deliverynoHere input[name='type_pay_deliverynoHere']").eq(parseInt(autopayHere)).prop("checked", "checked");*/
                    $(".explain_deliverynoHere input[name='connection_explain_deliverynoHere']").eq(parseInt(notifytypeHere)).val("notifyHere");
                    $(".explain_deliverynoHere input[name='type_pay_explain_deliverynoHere']").eq(parseInt(autopayHere)).prop("checked", "checked");                    

                    var str_multi_rd = "roadlinemultiHere";
                    var str_multi_ad = "addressmultiHere";
                    $(".hide_explain_roadline_deliverynoHere").text(str_multi_rd);
                    $(".hide_explain_address_deliverynoHere").text(str_multi_ad);

                    $(".wu1,.delete_package,.tui,.package_track,.submit_default_package,.submit_explain_package,.add_packages,.return-button,.save_add_package,.cancel_add_package,"
                    + ".save_d_package,.cancel_d_package,.add_delivery_word,.save_stock_good_word,.cancel_stock_good_word,.delete_delivery,.clone_remove,.add_delivery_sure,"
                    + ".cancel_delivery_action,.add_delivery_word,.save_stock_good_word,.cancel_stock_good_word,.submit_delivery_default,.add_package_sure").mouseenter(function () {
                        $(this).css("text-decoration", "underline");
                    }).mouseleave(function () {
                        $(this).css("text-decoration", "none");
                    })
                </script>
            </div>
            <div class="last-div"></div>
            <div class="line"></div>
        </div>            
    </div>

        <div class="fixed_showdelivery_button_delivery">            
            <div class="save_stock_good" id="savedelivery_deliverynoHere"><span class="save_stock_good_word" style="color: white;">保存</span></div>
            <div class="cancel_stock_good" id="canceldelivery_deliverynoHere"><span class="cancel_stock_good_word">取消</span></div>
        </div>
  </div>

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
                <dd>包裹重量：weightHere</dd>
                <dd>包裹长度：lengthHere</dd>
                <dd>包裹宽度：widthHere</dd>
                <dd>包裹高度：heightHere</dd>
            </dl>
            <dl class="xin11">
                <dd class="package_track" id="paybilldelivery_deliverynoHere">包裹跟踪</dd>
            </dl>
            <div class="button">
              <input type="text" class="pay_bill" name="deliverynoHere" value="付款" />
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
                <dd class="package_track" id="transportdelivery_deliverynoHere">包裹跟踪</dd>
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
                <dd class="package_track" id="finisheddelivery_deliverynoHere">包裹跟踪</dd>
            </dl>
        </div>
        

    </asp:Literal>

 </div>



  <div class="return-button-box"><div class="return-button">返回</div></div>
  <div class="bj"></div>

    
    <asp:Literal ID="Literal_OrderType" runat="server">
        <input class="hide_ordertype" value="ordertypeHere" style="display:none;" />
    </asp:Literal>

</asp:Content>
