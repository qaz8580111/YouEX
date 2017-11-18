//js直接函数-------------------------------------------------------------------
$(function(){
	$("input[name='password']").focus(function () { if ($("input[name='password']").val() == '密码')
	$("input[name='password']").val(''); }).blur(function () { if ($("input[name='password']").val() == '')
	$("input[name='password']").val('密码') });

	$(".kuang").hide().first().show()
	 $(".c3 .color").click(function(){
		 $(".content2,.bj").show()
	 })
    $(".button6").click(function(){
		 $(".content2,.bj").hide()
	 })		 
	$(".button4").addClass("change")
	 $(".button4").click(function(){
		 $(this).addClass("change")
		 $(".button5").removeClass("change")
	 })    
    $(".pay .no-sure").click(function(){
	     $(".pay").hide()
		$(".bj").hide()
	   })   
    $(".p").click(function(){
	   $(".use-address").show()
	   $(".bj") .show()
    }) 
    $(".package_delivery_add_address").click(function(){
	   $(".use-address").show()
	   $(".bj") .show()
    })

	$(".use-address .no-sure-pac").click(function(){
		$(".use-address,.bj").hide()
	})

	$(".use-address .no-sure").click(function(){
		$(".use-address").hide()
	})

	$(".t5 .q1").click(function(){
		$(".wan-price").show()
		$(".bj") .show()
	})
    $(".wan-yin").click(function(){
		$(".wan-price").hide()
	})
	$(".t5 .q2").click(function(){
		$(".pu-price").show()
		$(".bj") .show()
	})
    $(".pu-yin").click(function(){
		$(".pu-price").hide()
	})
	$(".t5 .q3").click(function(){
		$(".milk-price").show()
		$(".bj") .show()
	})
    $(".milk-yin").click(function(){
		$(".milk-price").hide()
		})
    $(".t5 .q4").click(function(){
		$(".pu-price").show()
		$(".bj") .show()
	})
    $(".gang-yin").click(function(){
		$(".gang-price").hide()
	})
	$(".t5 .q5").click(function(){
		$(".usps-price").show()
		$(".bj") .show()
	})
    $(".usps-yin").click(function(){
		$(".usps-price").hide()
	})

    $(".stock_address,.he").hide()
    
    $(".edit-address").click(function(){
		$(".stock_address,.bj").show()	
	})

    $(".button_package").click(function(){
    	location.href="../UserCenter/UserCenter.aspx";
    })

    $("#email_register").click(function () {
        $(".email_register").show();
        $(".mobile_register").hide();
        $("#ctl00_ContentPlaceHolder1_TB_Rg_Mobile").val("");
        $("#ctl00_ContentPlaceHolder1_TB_Rg_Email").val("");
    })
    $("#mobile_register").click(function () {
        $(".mobile_register").show();
        $(".email_register").hide();
        $("#ctl00_ContentPlaceHolder1_TB_Rg_Mobile").val("");
        $("#ctl00_ContentPlaceHolder1_TB_Rg_Email").val("");
    })

    $(".button_mystock").click(function(){
    	var left_gbox_count = $(".left .g-box").length;
    	var right_gbox_count = $(".right .g-box").length;
    	var left_list_count = $(".left .c3-box1 li").length;
    	for(var i=1;i<left_gbox_count;i++){
    		$(".left .g-box").eq(1).remove();
    	}
    	for(var i=1;i<right_gbox_count;i++){
    		$(".right .g-box").eq(1).remove();
    	}
    	for(var i=1;i<left_list_count;i++){
    		$(".left .c3-box1 li").eq(1).remove();
    	}
    	$(".content-bj,.bj").hide();
    })

	$(".stock_address .button .no-sure").click(function(){
		$(".stock_address,.bj").hide()
	})
    
    $(".refund_cancel_button_d , .refund_cancel_button_p").click(function(){
		$(".refund,.bj").hide()
	})

	 $(".return-button").click(function(){
	 	location.href="../UserCenter/UserCenter.aspx";
	 })

   	$(".c4 .word").click(function(){
	   $(".c4 input").toggle()
   })

  	$(".c5 .word").click(function(){
	   $(".c5 .cc5").toggle()
	   $(".c5 input").show()
    })
  	$(".aut-login img").eq(1).hide();
  	$(".aut-login img").click(function(){
	 	$(this).hide().siblings().show()
  	})
  	$(".last-nav-bj a").mouseenter(function(){
		$(this).css("color","#1a9dd1").mouseleave(function(){
		$(this).css("color","#FFF")	}) 		
	})

   $(".cancel_delivery_good,.cancel_delivery_icon").click(function(){
   		$(".explain_box,.bj").hide();
   		$(".explain_agree").attr("checked",false);
   		$(".explainbox").css("background-color","white");
		$(".explainbox_word").css("color","#4C4C4C");
   })
   $(".cancel_stock_good,.delivery_delivery_close").click(function(){
   		$(".explain_"+this.id.split("_")[1]).hide();
   		$(".bj").hide();
   })

   $(".cancel_mystock_delivery_icon").click(function(){
	     $(".explain_"+this.id.split("_")[1]).hide();
   		$(".bj").hide();
	   })

   $(".cancel_delivery_default,.cancel_package_icon").click(function(){
   		$(".show_delivery_default,.bj").hide();
   		$(".default_agree").attr("checked",false);
   		$(".defaultbox").css("background-color","white");
		$(".defaultbox_word").css("color","#4C4C4C");
   })	

   $(".cancel_add_package").click(function(){
   		$("div[class^='addpackage'],.bj").hide()
   })
   $(".cancel_mystock_add_icon").click(function(){
	     $("div[class^='addpackage'],.bj").hide()
	   })

   $(".cancel_d_package").click(function(){
   		$("div[class^='submitpackage'],.bj").hide()
   })
   $(".cancel_mystock_default_icon").click(function(){
	     $("div[class^='submitpackage'],.bj").hide()
   })

   $(".package_track").click(function(){
    	var packageno = this.id.split("_")[1];
		location.href = "./Track.aspx?orderstatus="+packageno;
    })

   $(".underuser_addpackage").click(function(){
   	var shipping_isspecial = IsSpecialWord($(".underuser_addpackage_input").val());
   	if($(".underuser_addpackage_input").val() == "请输入运单号" || $(".underuser_addpackage_input").val() == "")
	{
		alert("请输入运单号");
		return false;
	}
	else
		location.href="../Package/NewPackage.aspx?shippingno="+$(".underuser_addpackage_input").val();	
   	if(!shipping_isspecial){
   		alert("输入的内容含有非法字符");
   		return false;
   	}	
	})

   	$("input[name='check_package']").click(function(){
   		if($(this).is(":checked") == false){
   			$(this).parent().parent().parent().find(".add_packages").hide();
   		}
	    if($("input[name='check_package']:checked").length >1)
	    {
	    	for(var i=0;i<$("input[name='check_package']:checked").length;i++){
	    		$("input[name='check_package']:checked").eq(i).parent().parent().parent().find(".add_packages").show();
	    	}
	    }
	})
	
    $("#ctl00_ContentPlaceHolder1_uploadPicFront").change(function () {
	    var objUrl = getObjectURL(this.files[0]);
	    console.log("objUrl = " + objUrl);
	    if (objUrl) {
	        $("#ctl00_ContentPlaceHolder1_IdCardFront").attr("src", objUrl);
	    }
    })

	$("#ctl00_ContentPlaceHolder1_uploadPicBack").change(function () {
	    var objUrl = getObjectURL(this.files[0]);
	    if (objUrl) {
	        $("#ctl00_ContentPlaceHolder1_IdCardBack").attr("src", objUrl);
	    }
  	})

   	$(".shopping-receipt .xx").click(function () {
        $(".shopping-receipt").hide()
        $(".bj").hide()
    })

   	//包裹和运单页面左边的增加操作
    $(".left .jia-26,.left .title-word").click(function () {    	
        var div = $(".hide_left_g_box").html();
        var final_number = 0;
        for(var i=0;i<50;i++){
            if (upload_count_arr[i] == null){
                final_number = parseInt(upload_count_arr[i - 1]) + 5;
                upload_count_arr[i] = i * 5;
                break;
            }
        }
        for (var i = 5; i < 10; i++){
            var str_file = "ctl00_ContentPlaceHolder1_FileUpload" + i;
            var str_image = "ctl00_ContentPlaceHolder1_Image" + i;
            var str_name = "ctl00$ContentPlaceHolder1$FileUpload" + i;
            var regstr_file = new RegExp(str_file, "g");
            var regstr_image = new RegExp(str_image, "g");
            div = div.replace(regstr_file, "ctl00_ContentPlaceHolder1_FileUpload" + final_number);
            div = div.replace(regstr_image, "ctl00_ContentPlaceHolder1_Image" + final_number);
            div = div.replace(str_name, "ctl00$ContentPlaceHolder1$FileUpload" + final_number);
            final_number++;
        }
        var str_photo = "relationphoto_1";
        var str_addgood = "relation_input_2";
        var str_photo_number = parseInt(Math.random() * 1000);
        var regstr_photo = new RegExp(str_photo, "g");
        var regstr_addgood = new RegExp(str_addgood, "g");
        div = div.replace(regstr_photo, "relationphoto_" + str_photo_number);
        div = div.replace(regstr_addgood, "relation_input_1a" + str_photo_number);
        div = div.replace("good_name_left", "good_name");
        div = div.replace("good_brand_left", "good_brand");
        div = div.replace("good_price_left", "good_price");
        div = div.replace("good_amount_left", "good_amount");
        div = div.replace("good_buyurl_left", "good_buyurl");
        div = div.replace("shippingorder_left", "shippingorder");
        div = div.replace("photo_left", "photo");
        div = div.replace("photo_remark_left", "photo_remark");
        div = div.replace("upload_pic_count_left", "upload_pic_count");
        div = div.replace("package_remark_left", "package_remark");
        $(".left .g-box").eq(parseInt($(".left .g-box").length) - 1).after(div);
        newpackage_reload();
        if(location.href.split("=")[1]!="delivery_waiting"){
        	$(".exist_shippingno").show();
        }
        if(location.href.indexOf("NewMyStock.aspx")>0){
        	$(".left .g-box .shippingorderno").attr("readonly","readonly");
        }
    })
	
	//包裹和运单页面右边的增加操作
    $(".right .jia-26,.right .title-word").click(function () {
        var div = $(".hide_right_g_box").html();
        var div_roadline = $(".right .g-box").eq(0).find("select[name='roadline_explain']").html();
        var str_number = parseInt(Math.random() * 1000);

        var str_jg = "relationjg_1";
        var regstr_jg = new RegExp(str_jg, "g");
        div = div.replace(regstr_jg, "relationjg_" + str_number);
        var str_notice = "relationnotice_1";
        var regstr_notice = new RegExp(str_notice, "g");
        div = div.replace(regstr_notice, "relationnotice_" + str_number);

        div = div.replace("roadline_explain_right", "roadline_explain");
        div = div.replace("address_delivery_right", "address_delivery");
        div = div.replace("reinforce_right", "reinforce");
        div = div.replace("reinforce_remark_right", "reinforce_remark");
        div = div.replace("notice_right", "notice");

        $(".right .g-box").eq(parseInt($(".right .g-box").length) - 1).after(div);
        $(".right .g-box").eq(parseInt($(".right .g-box").length) - 1).find("select[name='roadline_explain']").html(div_roadline);
        newpackage_reload();
    })	
})

$(function () {
    if ($(".hide_ordertype").val() == "") {
        $("#all_packages").show();
        $(".stock").css("color","#4c4c4c");var _time = null;        
    }
    if ($(".hide_ordertype").val() == "delivery_waiting") {
        $("#all_deliverys_waiting").show();
        $(".pending-way-bill").css("color","#4c4c4c");
        $(".blue1").css("margin-left","100px");
    }
    if ($(".hide_ordertype").val() == "delivery_paybill") {
        $("#all_deliverys_paybill").show();
        $(".pay-bill-ing").css("color","#4c4c4c");
        $(".blue1").css("margin-left","220px");
    }
    if ($(".hide_ordertype").val() == "delivery_transport") {
        $("#all_deliverys_transport").show();
        $(".transform-ing").css("color","#4c4c4c");
        $(".blue1").css("margin-left","345px");
    }
    if ($(".hide_ordertype").val() == "delivery_finished") {
        $("#all_deliverys_finished").show();
        $(".finish-end").css("color","#4c4c4c");
        $(".blue1").css("margin-left","465px");
    }


    //屏幕兼容
    if($(".return-button-box").length > 0){
    	if (($(window).scrollTop() * 2 + $(window).height() - $(".return-button-box").offset().top) > 115)
        	$(".last-nav-bj").css("margin-top", $(window).scrollTop() + $(window).height() - ($(".return-button-box").offset().top - $(window).scrollTop()) - 85);
	    else
	        $(".last-nav-bj").css("margin-top", "150px");
    }
    




    //on事件是为了激活未生成的事件
    $(document).on("click", ".left .box2 img", function () {
        if ($(this).parent().parent().parent().find(".g-box").length > 1)
        {
            var image_id_first = $(this).parent().parent().find("input[id^='ctl00_ContentPlaceHolder1_FileUpload']").eq(0).attr("id");
            var last_final = parseInt(GetWhichUpload(image_id_first));
            upload_count_arr[last_final/5] = null;
            $(this).parent().parent().remove();
        }
    });
    $(document).on("click", ".right .box2 img", function () {
        if ($(this).parent().parent().parent().find(".g-box").length > 1)
            $(this).parent().parent().remove();
    });
    $(document).on("click", ".right .address", function () {
        $(".use-address,.bj").show();
    });
        
    $(document).on("click", ".right .k5", function () {
    	if($("input[id^='relationnotice_']:eq(0)").is(":checked")){
        	$("input[id^='relationnotice_']").prop("checked", true);
        	for(var i=0;i<$("input[name='notice']").length;i++){
        		$("input[name='notice']").eq(i).val($("input[name='notice']:eq(0)").val());
        	}
    	}
        else{
        	$("input[id^='relationnotice_']").prop("checked", false);
        	for(var i=1;i<$("input[name='notice']").length;i++){
        		$("input[name='notice']").eq(i).val("");
        	}
        }
    });
    $(document).on("click", ".box4 .k1", function () {
        $(this).siblings(".box4 .kk").toggle();
    });
    $(document).on("click", ".left .upload", function () {
        $(this).parent().find(".shopping-receipt,.bj").show();
    });
    $(document).on("click", ".upload_shopping_pic", function () {
        $(this).parent().parent().find(".show_upload_img").show();
    });
    $(document).on("click", ".upload_close,.finish_shopping_pic", function () {
        $(this).parent().parent().find(".shopping-receipt,.bj").hide();
    });
    $(document).on("click", "input[id^='relationphoto_']", function(){
    	if($(this).is(":checked")==true)
        	$(this).parent().find("input[name='photo']").val(1);
        else
        	$(this).parent().find("input[name='photo']").val(0);
    });
    $(document).on("click", "input[id^='relationjg_']", function () {
    	if($(this).is(":checked")==true)
        	$(this).parent().find("input[name='reinforce']").val(1);
        else
        	$(this).parent().find("input[name='reinforce']").val(0);
    });

    //双击删除预览的照片
    $(document).on("dblclick", ".left img[id^='ctl00_ContentPlaceHolder1_Image']", function () {
        var i = this.id.split("Image")[1];
        if (confirm("是否删除该照片？") == true) {
            $("#ctl00_ContentPlaceHolder1_Image" + i).attr("src", "");
            $("input[name='Label_Upload" + i + "']").val("")
            $("#ctl00_ContentPlaceHolder1_Image" + i).hide();
            $(this).parent().find(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload" + i + "').click()");
        }
    })

    //保存预览的照片
    $(document).on("click", ".submit_upload_pic", function () {
        $(this).parent().parent().hide();
        var image_id_first = $(this).parent().parent().find("input[id^='ctl00_ContentPlaceHolder1_FileUpload']").eq(0).attr("id");
        var last_final = parseInt(GetWhichUpload(image_id_first));
        var a = 0;
        for (var i = parseInt(last_final) ; i < parseInt(last_final) + 5; i++) {
            if ($("#ctl00_ContentPlaceHolder1_Image" + i).attr("src") != "")
                a++;
        }
        $(this).parent().parent().parent().find(".upload_pic_count").val(a);
    });

    //删除所有预览的照片
    $(document).on("click", ".cancel_upload_pic", function () {
        if (confirm("取消后将重新上传,是否确定？") == true) {
        var image_id_first = $(this).parent().parent().find("input[id^='ctl00_ContentPlaceHolder1_FileUpload']").eq(0).attr("id");
        var last_final = parseInt(GetWhichUpload(image_id_first));
            $(this).parent().parent().find("img[id^='ctl00_ContentPlaceHolder1_Image']").attr("src", "");
            $(this).parent().parent().find("img[id^='ctl00_ContentPlaceHolder1_Image']").hide();
            $(this).parent().parent().find("input[name^='Label_Upload']").val("");
            $(this).parent().parent().find(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload" + last_final + "').click()");
            $(this).parent().parent().hide();
            $(this).parent().parent().parent().find(".upload_pic_count").text(0);
        }
    });

    //检查所填的运单号是否已预报或者已生成运单
    $(document).on("blur", "input[name='shippingorder']", function () {
    	var self_input = $(this).parent().find(".check_shippingorder_no");
    	var shippingorder_name = $(this).val();
    	if($("input[name='shippingorder']").val() !=""){
    		$.ajax({
			type: "POST",
            url: "../Ashx/package.ashx?shippingorder="+shippingorder_name,
            data: $("form").serialize(),
            datatype: "text",
            success: function (msg) {
                if(msg == "yes"){
                	self_input.hide();
                }
                if(msg.split('_')[0] == "no"){
                	self_input.parent().find(".exist_shippingno").trigger("change");//find(".exist_shippingno option[value='"+msg.split('_')[1]+"']").click();
                }
                if(msg == "nono"){
                	self_input.show();
                }
            }
        	})
    	}
    });

    //文件上传前的预览
    $(document).on("change", "input[id^='ctl00_ContentPlaceHolder1_FileUpload']", function () {    	
        var last_final = parseInt(GetWhichUpload($(this).attr("id")));
        var last_count = 0;
        var isright = isrightformat(this);
        if (!isright) {
            alert('上传的图片格式错误');
            return false;
        } else {
            var objUrl = getObjectURL(this.files[0]);
            console.log("objUrl = " + objUrl);
            if (objUrl) {
                $("#ctl00_ContentPlaceHolder1_Image" + last_final).attr("src", objUrl);
            }
            last_count = parseInt(last_final / 5) * 5 + 5;
            Check_IsImgNull(last_final, last_count);
        }
    })

    //根据已有运单自动填充
	$(document).on("change", ".exist_shippingno", function (data123) {
        var packageno = $(this).find("option:checked").val();
        if(packageno == 0){
        	var shippingorder = $(this).parent().find(".shippingorderno").val();
        	for(var i=0;i<$(this).find("option").length;i++){
        		if($(this).find("option").eq(i).text()==shippingorder)
        		{
        			packageno = $(this).find("option").eq(i).val();
        		}
        	}
        }
        var obj = $(this);
        var li_length = obj.parent().parent().find(".c3-box1 li").length;
        for(var i=1;i<li_length;i++)
        {
        	obj.parent().parent().find(".c3-box1 li").eq(1).remove();
        }
        $.ajax({
			type: "POST",
	        url: "../Ashx/package.ashx?auto_writein="+packageno,
	        data: $("form").serialize(),
	        datatype: "text",
	        async:false,
	        success: function (msg) {
	        	var getinfo = eval("(" + msg + ")");
	        	var packagecount = 0;

	        	AutoWriteInLeftPackage(getinfo,obj);
	        }
    	})
    })

    //库存页面包裹的编辑
    $(".edit_package_action").click(function(){
    	if($(this).parent().parent().find(".b9 img[class^='img_del_']").css("display") == "none"){
	    	var packageno = this.name;
	    	$(".hidden_packageno").attr("value",packageno);
	    	$.ajax({
				type: "POST",
		        url: "../Ashx/mystock.ashx?edit_package_action="+packageno,
		        data: $("form").serialize(),
		        datatype: "text",
		        async:false,
		        success: function (msg) {
		        	var getinfo = eval("(" + msg + ")");        	
		        	var packagecount = 0;   	
		        	GetLeftPackageGoods(getinfo,packagecount);
		        	GetMystockPackageRoadLine(getinfo);
		        	$("#relation_input_10").prop("checked",true);
		        	$(".left .g-box .shippingorderno").attr("readonly","readonly");
		        	$(".content-bj,.exist_shippingno,.bj").show();
		        }
	    	})
    	}else{
    		alert("该包裹正在申请退货处理,如有需求,请联系客服");
    	}
    })

    //待处理运单页面运单的编辑
    $(".edit_delivery_action").click(function(){
    	$(".spinner").show();
    	var orderno = this.name;
		$(".hidden_orderno").attr("value",orderno);
    	$.ajax({
			type: "POST",
	        url: "../Ashx/mystock.ashx?edit_delivery_action="+orderno,
	        data: $("form").serialize(),
	        datatype: "text",
	        async:false,
	        success: function (msg) {
	        	var getinfo = eval("(" + msg + ")");        	
	        	var packagecount = 0;
	        	var deliverycount = 0;
	        	GetOrderOtherService(getinfo);        	
	        	GetLeftPackageGoods(getinfo,packagecount);
	        	GetRightDeliveryGoods(getinfo,deliverycount);
	        	$(".spinner").hide();
	        	$(".content-bj,.bj").show();
	        }
    	})
    })

})


























//下面为JS函数----------------------------------------------------------------
function check_term(){
	if($("#ctl00_ContentPlaceHolder1_TB_Rg_Pwd").val() == $("#ctl00_ContentPlaceHolder1_TB_Rg_Repwd").val()){
		if($("#ctl00_ContentPlaceHolder1_CB_Rg_Agree").is(":checked")){
			if(($("#ctl00_ContentPlaceHolder1_TB_Rg_Mobile").val() =="" && $("#ctl00_ContentPlaceHolder1_TB_Rg_Email").val() !="") ||
			   ($("#ctl00_ContentPlaceHolder1_TB_Rg_Mobile").val() !="" && $("#ctl00_ContentPlaceHolder1_TB_Rg_Email").val() =="") )
				{
					return true;
				}else
				{
					alert('请填写手机或者邮箱');
					return false;
				}
		}else{
			alert('请仔细阅读协议');
			return false;
		}
	}else{
		alert('两次密码不一致');
		return false;
	}
}

//增加左边包裹的商品信息
function addTr2(obj, row) {
	var trHtml="<li style='list-style:none;'>"+
			   "<input class='i1' name='good_name' value='' oninput='clone_flush(this);' />"+
	           "<input class='i2' name='good_brand' value='' oninput='clone_flush(this);' />"+
	           "<input class='i3' name='good_price' value='' oninput='clone_flush(this);' />"+
	           "<span class='currency'>（￥）</span>"+	           
	           "<input class='i4' name='good_amount' value='' oninput='clone_flush(this);' />"+	           
	           "<input class='i5' name='good_buyurl' value='' oninput='clone_flush(this);' />"+
	           "<span class='del_good' onclick='delTr(this);'>删除</span></li>"
	addTr(obj, row, trHtml);
}

//增加右边运单的商品信息
function addTr3(){
	var trHtml="<li class='clone_deliverygoods'>"+
			   "<input class='i1' name='delivery_name' value='' oninput='clone_flush(this);' />"+
	           "<input class='i2' name='delivery_brand' value='' oninput='clone_flush(this);' />"+
	           "<input class='i3' name='delivery_price' value='' oninput='clone_flush(this);' />"+
	           "<span class='currency'>（￥）</span>"+	           
	           "<input class='i4' name='delivery_amount' value='' oninput='clone_flush(this);' />"+	           
	           "<input class='i5' name='delivery_buyurl' value='' oninput='clone_flush(this);' />"+
	           "<span class='del_good' onclick='delTr(this);'>删除</span></li>"
   return trHtml;
}

//将增加的商品信息添加到页面中
function addTr(obj, row, trHtml){
	var $tr = $(obj).parent().parent().parent().find(".c3-box1 li").eq(row);
	$tr.after(trHtml);
	newpackage_reload();
}

//删除商品信息
function delTr(obj) {
	if($(obj).parent().find("input[name='good_name']").length >0 && $(obj).parent().parent().find("li").length > 1){//左侧删除	
		$(obj).parent().remove();
	}
	if($(obj).parent().find("input[name='good_name']").length == 0){//右侧删除
		$(obj).parent().remove();
	}
	
}


function clone_flush(obj){
	$(obj).attr("value",obj.value);
	$(obj).attr("title",obj.value);
}

function cleanrow(obj){
	$(obj).parent().parent().find("input").val("");
	$(obj).val("清空");
}

function CheckNoticeType(obj){
	var noticeinfo = $(obj).val();
	if(noticeinfo.indexOf("@")>0)
	{
		if(!noticeinfo.match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/))
		{
			alert("邮箱格式不正确");
			return false;
		}
	}
	else{
		if(!noticeinfo.match(/^1[3|4|5|8][0-9]\d{4,8}$/) && noticeinfo!="")
		{
			alert("手机格式不正确");
			return false;
		}
	}
}

//增加地址簿前的检验
function Check_Address_Info(){
	var format = new Array("jpg", "png", "gif", "bmp");	
	if($("#ctl00_ContentPlaceHolder1_TB_Address_Name").val() =="" || $("#ctl00_ContentPlaceHolder1_TB_Address_Recipients").val() =="" ||
	   $("#ctl00_ContentPlaceHolder1_TB_Address_Mobile").val() =="" || $("#ctl00_ContentPlaceHolder1_TB_Address_Address").val() =="" ||
	   $("#ctl00_ContentPlaceHolder1_TB_Address_IdCard").val() =="")
	{
		alert("请将信息填写完整");
		return false;
	}
	if($("#ctl00_ContentPlaceHolder1_DropDownList_country").val()==0 || $("#ctl00_ContentPlaceHolder1_DropDownList_province").val()==0 ||
		$("#ctl00_ContentPlaceHolder1_DropDownList_city").val() ==0)
	{
		alert("请选择所在地区");
		return false;
	}
	if($("#ctl00_ContentPlaceHolder1_IdCardFront").attr("src") == "../Images/Pic_User/idcard_front.png" || 
	   $("#ctl00_ContentPlaceHolder1_IdCardBack").attr("src") == "../Images/Pic_User/idcard_back.png")
	{
		alert("请上传您的正反面身份证");
		return false;
	}
	if($(".diffrent_addressname_notice").is(":visible")){
		return false;
	}
	if($("#package_front_upload").val() != ""){
		var suffix_front = $("#package_front_upload").val().split(".")[1];
		var front_isright = false;
		for(var i=0;i<format.length;i++){	
			if((suffix_front.indexOf(format[i]))>=0){front_isright = true;}
		};
		if(!front_isright){
			alert('上传的图片格式错误');
			return false;
		}
	}
	if($("#package_back_upload").val() != ""){
		var suffix_back  = $("#package_back_upload").val().split(".")[1];
		var back_isright = false;
		for(var i=0;i<format.length;i++){	
			if(suffix_back.indexOf(format[i])>=0){back_isright = true;}
		};
		if(!back_isright){
			alert('上传的图片格式错误');
			return false;
		}
	}
}

//检查是否有特殊字符
function IsSpecialWord(usertext){
	var result_isspecial = /^[\u4e00-\u9fa5a-zA-Z0-9,\/.?， 。:：？（）()!！_-]+$/gi.test(usertext);
	if(result_isspecial)
		return true;
	else{
		return false;
	}
}

//付款前的检查
function PayBill(){
	if($("input[name='cb_bank']").is(":checked") && $("input[name='type_bank']").val() < 1){
		alert("银行充值支付的金额需大于1元");
		return false;
	}
	var orderno = $(".button_paybill").attr("name");
	var isbank = false;    	
	$.ajax({
		type: "POST",
        url: "../Package/PayBill.aspx?ispaybill="+orderno,
        data: $("form").serialize(),
        datatype: "text",
        async:false,
        success: function (msg){
            if(msg == "enough")
                alert("支付超额");
            if(msg == "notenough")
            	alert("支付不足");
            if(msg == "fail")
            	alert("支付失败");
            if(msg == "success"){
            	alert("支付成功");
            	location.href = "../Package/MyStock.aspx?ordertype=delivery_transport";
            }
            if(msg == "bank"){
            	isbank = true;
            }

        }
    })
    if(isbank)
    	return true;
}

function ReturnIsNotNull() {
     var count_null = 0;
     var array_str = new Array("refund_recipients" , "refund_mobile","refund_addressone","refund_addresstwo", "refund_province", "refund_zipcode", "refund_price","refund_email");
     for(var i = 0; i < array_str.length; i++){
        if ($("input[name='" + array_str[i] + "']").val() == ""){
            $("input[name='" + array_str[i] + "']").css("border-color", "red");
            count_null ++;
        }
        else
            $("input[name='" + array_str[i] + "']").css("border-color", "#BCBCBC");
     }
     return count_null;
 }







 //NewPackage--------
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

function newpackage_reload() {
    $(".left .c3-box1 li").draggable({
        appendTo: "body",
        cursor: "move",
        revert: "invalid",
        opacity: 0.7,
        helper: "clone"
    });
    $(".right .clone_place").droppable({                
        activeClass: "ui-state-default",
        hoverClass: "ui-state-hover",
        drop: function (event, ui) {
            var goods_str = ui.draggable.html();
            goods_str = goods_str.replace("good_name", "delivery_name");
            goods_str = goods_str.replace("good_brand", "delivery_brand");
            goods_str = goods_str.replace("good_price", "delivery_price");
            goods_str = goods_str.replace("good_amount", "delivery_amount");
            goods_str = goods_str.replace("good_buyurl", "delivery_buyurl");
            $("<li></li>").html(goods_str).appendTo(this);
        }
    })
}

//检查图片是否为空
function Check_IsImgNull(a, b) {
   for (var i = a; i < b; i++){
       if ($("#ctl00_ContentPlaceHolder1_Image" + i).attr("src") != "") {
           $("#ctl00_ContentPlaceHolder1_Image" + i).show();
           for (i = parseInt(a) + 1; i < b + 1;i++) {
               if ($("#ctl00_ContentPlaceHolder1_Image" + i).attr("src") == "") {
                   $("#ctl00_ContentPlaceHolder1_FileUpload"+a).parent().find(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload" + i + "').click()");
                   $("input[name='Label_Upload" + a + "']").val($("#ctl00_ContentPlaceHolder1_Image" + a).attr("src"));
                   break;
               }
               if (i == b) {
                   if ($("#ctl00_ContentPlaceHolder1_Image"+(b-1)).attr("src") != "") {
                       $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload" + (b - 1) + "').click()");
                       $("input[name='Label_Upload" + (b - 1) + "']").val($("#ctl00_ContentPlaceHolder1_Image" + (b - 1)).attr("src"));
                       if ($("#ctl00_ContentPlaceHolder1_Image"+(b-5)).attr("src") != "") {
                           $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload" + (b - 5) + "').click()");
                       }
                       if ($("#ctl00_ContentPlaceHolder1_Image" + (b - 4)).attr("src") != "") {
                           $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload" + (b - 4) + "').click()");
                       }
                       if ($("#ctl00_ContentPlaceHolder1_Image" + (b - 3)).attr("src") != "") {
                           $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload" + (b - 3) + "').click()");
                       }
                       if ($("#ctl00_ContentPlaceHolder1_Image" + (b - 2)).attr("src") != "") {
                           $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload" + (b - 2) + "').click()");
                       }
                   }
               }
           }
       }
       if ($("#ctl00_ContentPlaceHolder1_Image" + (b - 5)).attr("src") != "" && $("#ctl00_ContentPlaceHolder1_Image" + (b - 4)).attr("src") != "" &&
           $("#ctl00_ContentPlaceHolder1_Image" + (b - 3)).attr("src") != "" && $("#ctl00_ContentPlaceHolder1_Image" + (b - 2)).attr("src") != "" &&
           $("#ctl00_ContentPlaceHolder1_Image" + (b - 1)).attr("src") != "") {
           $(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload').click()");
           break;
       }
   }
}

function isrightformat(obj) {
    var format = new Array("jpg", "png", "gif", "bmp");
    if ($(obj).val() != "") {
        var suffix = $(obj).val().split(".")[1];
        var isright = false;
        for (var i = 0; i < format.length; i++) {
            if ((suffix.indexOf(format[i])) >= 0) { isright = true; }
        };
        return isright;
    }
}

function GetWhichUpload(str) {
    var last_one = str.substr(-1, 1);
    var last_two = str.substr(-2, 2);
    var last_final = 0;
    if (last_two.indexOf("d") >= 0)
        last_final = last_one;
    if (last_two.indexOf("d") < 0)
        last_final = last_two;
    return last_final;
}
function new_check_package(){
		if($("#ctl00_ContentPlaceHolder1_DropDownList_DepotId option:checked").val()==0)
		{
			alert("请选择收货仓库");
			return false;
		}
		Get_Upload_Image();
		if(!Check_Left_IsNull())
   		return false;
   	Get_Goods_Count();
   	return true;
}

function new_check_delivery() {
	Get_Upload_Image();
	if($(".check_shippingorder_no").length>0){
		if($(".check_shippingorder_no").css("display")!="none")
		return false;
	}		
	if($("#relation_input_10").is(":checked")==false)
	{
		alert("请仔细阅读协议并同意");
		return false;
	}
	if(!Check_Left_IsNull() || !Check_Right_IsNull())
		return false;
    if (!Check_Left_Right_Count()) {
       alert('数目不同');
       return false;
    }
   Get_Goods_Count();   
   return true;
}

//检查左右商品数目
function Check_Left_Right_Count()
{
   var good_count = $("input[name='good_amount']").length;
   var clone_count = $("input[name='delivery_amount']").length;
   var good_name_arr = new Array();
   var good_amount_arr = new Array();
   var clone_name_arr = new Array();
   var clone_amount_arr = new Array();
   //写入原箱商品的数组
   for (var i = 0; i < good_count; i++) {
       var str_good_name = $("input[name='good_amount']").eq(i).parent().find("input[name='good_name']").val();
       var str_good_brand = $("input[name='good_amount']").eq(i).parent().find("input[name='good_brand']").val();
       var str_good = str_good_name + str_good_brand;
       var int_arr_return = $.inArray(str_good, good_name_arr);
       if (int_arr_return >= 0) {
           good_amount_arr[int_arr_return] = parseInt(good_amount_arr[int_arr_return]) + parseInt($("input[name='good_amount']").eq(i).val());
       } else {
           good_name_arr[good_name_arr.length] = str_good;
           good_amount_arr[good_amount_arr.length] = $("input[name='good_amount']").eq(i).val();
       }
   }
   //写入操作后商品的数组
   for (var i = 0; i < clone_count; i++) {
       var str_delivery_name = $("input[name='delivery_amount']").eq(i).parent().find("input[name='delivery_name']").val();
       var str_delivery_brand = $("input[name='delivery_amount']").eq(i).parent().find("input[name='delivery_brand']").val();
       var str_delivery = str_delivery_name + str_delivery_brand;
       var int_arr_return = $.inArray(str_delivery, clone_name_arr);
       if (int_arr_return >= 0) {
           clone_amount_arr[int_arr_return] = parseInt(clone_amount_arr[int_arr_return]) + parseInt($("input[name='delivery_amount']").eq(i).val());
       } else {
           clone_name_arr[clone_name_arr.length] = str_delivery;
           clone_amount_arr[clone_amount_arr.length] = $("input[name='delivery_amount']").eq(i).val();
       }
   }
   var right_arr_count = 0;
   for (var i = 0; i < good_name_arr.length; i++) {
       var good_sec_return = $.inArray(good_name_arr[i], clone_name_arr);
       if (good_sec_return >= 0) {
           if (clone_amount_arr[good_sec_return] == good_amount_arr[i]) {
               right_arr_count++;
           }
       }
   }
   if (good_amount_arr.length == parseInt(right_arr_count))
       return true;
   else
       return false;
}

//检查左右商品数目是否为空
function Check_Left_IsNull(){
   	//左侧包裹
   	for (var i = 0; i < $(".left .g-box").length; i++) {
		if($("input[name='shippingorder']").eq(i).val() == 0){
			alert("请输入运单号");
			return false;
		}			
	}
   	for(var i = 0 ; i < $("input[name='good_name']").length ; i++){
		if($("input[name='good_name']").eq(i).val()==""){
			alert("请输入商品名字");
			return false;
		}
		if(!IsSpecialWord($("input[name='good_name']").eq(i).val())){
			alert("输入的内容含有非法字符");
			return false;
		}
		if($("input[name='good_brand']").eq(i).val()==""){			
			alert("请输入商品品牌");
			return false;
		}
		if(!IsSpecialWord($("input[name='good_brand']").eq(i).val())){
			alert("输入的内容含有非法字符");
			return false;
		}
		if($("input[name='good_price']").eq(i).val()=="" ||
			!(/^\d+(\.\d{1,2})?$/.test($("input[name='good_price']").eq(i).val()))){
			alert("请输入正确的价格格式");
			return false;
		}
		if($("input[name='good_amount']").eq(i).val()=="" ||
			!(/^\d{1,2}?$/.test($("input[name='good_amount']").eq(i).val()))){						
			alert("请输入数量在1-99之间");
			return false;
		}					
		if($("input[name='good_buyurl']").eq(i).val()==""){
			alert("请输入购买链接");
			return false;
		}
		if(!IsSpecialWord($("input[name='good_buyurl']").eq(i).val())){
			alert("输入的内容含有非法字符");
			return false;
		}			
	}	
	return true;
}
function Check_Right_IsNull(){
   	//右侧运单
   	for(var i = 0 ; i < $("input[name='delivery_name']").length ; i++){
		if($("input[name='delivery_name']").eq(i).val()==""){
			alert("请输入商品名字");
			return false;
		}
		if(!IsSpecialWord($("input[name='delivery_name']").eq(i).val())){
			alert("输入的内容含有非法字符");
			return false;
		}
		if($("input[name='delivery_brand']").eq(i).val()==""){			
			alert("请输入商品品牌");
			return false;
		}
		if(!IsSpecialWord($("input[name='delivery_brand']").eq(i).val())){
			alert("输入的内容含有非法字符");
			return false;
		}
		if($("input[name='delivery_price']").eq(i).val()=="" ||
			!(/^\d+(\.\d{1,2})?$/.test($("input[name='delivery_price']").eq(i).val()))){
			alert("请输入正确的价格格式");
			return false;
		}
		if($("input[name='delivery_amount']").eq(i).val()=="" ||
			!(/^\d{1,2}?$/.test($("input[name='delivery_amount']").eq(i).val()))){						
			alert("请输入数量在1-99之间");
			return false;
		}					
		if($("input[name='delivery_buyurl']").eq(i).val()==""){
			alert("请输入购买链接");
			return false;
		}
		if(!IsSpecialWord($("input[name='delivery_buyurl']").eq(i).val())){
			alert("输入的内容含有非法字符");
			return false;
		}
	}
	for (var i = 0; i < $(".right .g-box").length; i++) {
		if($("select[name='roadline_explain']").eq(i).val() == 0){
			alert("请输入分箱的转运路线");
			return false;
		}
		if($("select[name='address_delivery']").eq(i).val() == 0){
			alert("请输入分箱的收货地址");
			return false;
		}
	}
	return true;
}
function Get_Upload_Image(){
	var each_gbox_firstupload = "";
		for(var i=0;i<$(".left .g-box").length;i++){
			var firstupload = $(".left .g-box").eq(i).find("input[id^='ctl00_ContentPlaceHolder1_FileUpload']").eq(0).attr("id");
			if(i==0)
				each_gbox_firstupload += GetWhichUpload(firstupload);
			else
				each_gbox_firstupload += ","+GetWhichUpload(firstupload);
		}
		$(".each_first_goods_count").val(each_gbox_firstupload);
}
function Get_Goods_Count(){
	var total_left = $(".left .g-box").length;
    var total_right = $(".right .g-box").length;
    var left_nb = null;
    var right_nb = null;
    for (var i = 0; i < total_left; i++) {
       left_nb += $(".left .g-box").eq(i).find("input[name='good_name']").length;
       if (i != total_left - 1)
           left_nb += ",";
       $(".left_goods_count").val(left_nb);
    }
    for (var i = 0; i < total_right; i++) {
       right_nb += $(".right .g-box").eq(i).find("input[name='delivery_name']").length;
       if (i != total_right - 1)
           right_nb += ",";
       $(".right_goods_count").val(right_nb);
    }
}




//NewMyStock---------
//获取修改时的路线
function GetMystockPackageRoadLine(getinfo){
	$.ajax({
		type: "POST",
        url: "../Ashx/package.ashx?depotid="+getinfo["DepotId"],
        data: $("form").serialize(),
        datatype: "text",
        success: function (data) {
            var jsonData = eval("(" + data + ")");
            $("select[name='roadline_explain']:eq(0) option:gt(0)").remove();
            $.each(jsonData, function (i, k) {
                var id = jsonData[i].ShippingId;
                var name = jsonData[i].ShippingName;
    			$('select[name="roadline_explain"]:eq(0) option[value="0"]').after("<option value='" + id + "'>" + name + "</option>");
            })
        }
    })
}

function GetMystockRoadLine(getinfo,m){
	$.ajax({
		type: "POST",
        url: "../Ashx/package.ashx?depotid="+getinfo["DepotId"],
        data: $("form").serialize(),
        datatype: "text",
        success: function (data) {
            var jsonData = eval("(" + data + ")");
        	$("select[name='roadline_explain']:eq("+m+") option:gt(0)").remove();
            $.each(jsonData, function (i, k) {
                var id = jsonData[i].ShippingId;
                var name = jsonData[i].ShippingName;
                if(getinfo["RoadLine"].split(",")[m]==id)
                	$('select[name="roadline_explain"]:eq('+m+') option[value="0"]').after("<option value='" + id + "' selected='selected'>" + name + "</option>");
                else
        			$('select[name="roadline_explain"]:eq('+m+') option[value="0"]').after("<option value='" + id + "'>" + name + "</option>");
            })
        }
    })
}

//根据预报包裹自动填充
function AutoWriteInLeftPackage(getinfo,obj){
	for(var i=0;i<getinfo["PackageName"].split(",").length;i++){
		if(i!=0)
			obj.parent().parent().find(".add_packagegood").click();  	        		
		obj.parent().parent().find("input[name='good_name']").eq(i).attr("value",getinfo["PackageName"].split(",")[i]);
		obj.parent().parent().find("input[name='good_brand']").eq(i).attr("value",getinfo["PackageBrand"].split(",")[i]);
		obj.parent().parent().find("input[name='good_price']").eq(i).attr("value",getinfo["PackagePrice"].split(",")[i]);
		obj.parent().parent().find("input[name='good_amount']").eq(i).attr("value",getinfo["PackageCount"].split(",")[i]);
		obj.parent().parent().find("input[name='good_buyurl']").eq(i).attr("value",getinfo["PackageBuyUrl"].split(",")[i]);
	}
	obj.parent().find(".shippingorderno").val(getinfo["ShippingNo"]);
	obj.parent().parent().find("textarea[name='package_remark']").val(getinfo["Remark"]);
	obj.parent().parent().parent().parent().find("#ctl00_ContentPlaceHolder1_DropDownList_DepotId").find("option[value='"+getinfo['DepotId']+"']").prop("selected","selected");
	GetMystockPackageRoadLine(getinfo);
	if(getinfo["IsPhoto"] == 1){
		obj.parent().parent().find(".k1").prop("checked",true);
		obj.parent().parent().find("input[name='photo']").attr("value","1");
		obj.parent().parent().find("input[name='photo_remark']").show();
		obj.parent().parent().find("input[name='photo_remark']").val(getinfo["PhotoRemark"]);
	}else{
		obj.parent().parent().find(".k1").prop("checked",false);
		obj.parent().parent().find("input[name='photo_remark']").hide();
	}
}

//获取修改时左边包裹的商品
function GetLeftPackageGoods(getinfo,packagecount){	
	for(var i=0;i<getinfo["PackageGoodsCount"].split(",").length;i++)
	{
		if(i!=0)
			$(".left .jia-26").click();
		for(var j=0;j<getinfo["PackageGoodsCount"].split(",")[i];j++)
		{
			if(j!=0){
				$(".left .add_packagegood").eq(i).click();
			}
    		$(".left input[name='good_name']").eq(packagecount).attr("value",getinfo["PackageName"].split(",")[packagecount]);
    		$(".left input[name='good_brand']").eq(packagecount).attr("value",getinfo["PackageBrand"].split(",")[packagecount]);
    		$(".left input[name='good_price']").eq(packagecount).attr("value",getinfo["PackagePrice"].split(",")[packagecount]);
    		$(".left input[name='good_amount']").eq(packagecount).attr("value",getinfo["PackageCount"].split(",")[packagecount]);
    		$(".left input[name='good_buyurl']").eq(packagecount).attr("value",getinfo["PackageBuyUrl"].split(",")[packagecount]);
			packagecount++;
		}
		/*for(var j=0;j<getinfo["UploadImage"].split("-")[i].split("|").length;j++)
		{
			
		}
		$(".left .upload_pic_count").eq(i).attr("value",getinfo["UploadImage"].split(",")[i].split("|").length);*/
		$(".left .shippingorderno").eq(i).val(getinfo["ShippingNo"].split(",")[i]);
		$(".left textarea[name='package_remark']").eq(i).val(getinfo["Remark"].split("|")[i]);
		if(getinfo["IsPhoto"].split(",")[i] == 1){
			$(".left .k1").eq(i).prop("checked",true);
			$(".left input[name='photo']").eq(i).attr("value","1");
			$(".left input[name='photo_remark']").eq(i).show();
			$(".left input[name='photo_remark']").eq(i).val(getinfo["PhotoRemark"].split(",")[i]);
		}else{
			$(".left input[name='photo_remark']").eq(i).hide();
			$(".left .k1").eq(i).prop("checked",false);
		}        		
	}
}

//获取修改时右边包裹的商品
function GetRightDeliveryGoods(getinfo,deliverycount)
{
	for(var i=0;i<getinfo["DeliveryGoodsCount"].split(",").length;i++)
	{
		if(i!=0)
			$(".right .jia-26").click();
		GetMystockRoadLine(getinfo,i);
		for(var j=0;j<getinfo["DeliveryGoodsCount"].split(",")[i];j++){
			if(j !=0)
				$(".right .c3-box1").eq(i).find(".clone_deliverygoods").eq(j-1).after(addTr3());
			else
				$(".right .c3-box1").eq(i).find("li").html(addTr3());
    		$(".right input[name='delivery_name']").eq(deliverycount).attr("value",getinfo["DeliveryName"].split(",")[deliverycount]);
    		$(".right input[name='delivery_brand']").eq(deliverycount).attr("value",getinfo["DeliveryBrand"].split(",")[deliverycount]);
    		$(".right input[name='delivery_price']").eq(deliverycount).attr("value",getinfo["DeliveryPrice"].split(",")[deliverycount]);
    		$(".right input[name='delivery_amount']").eq(deliverycount).attr("value",getinfo["DeliveryCount"].split(",")[deliverycount]);
    		$(".right input[name='delivery_buyurl']").eq(deliverycount).attr("value",getinfo["DeliveryBuyUrl"].split(",")[deliverycount]);
			deliverycount++;
		}
		$(".right .shippingorderno").eq(i).val(getinfo["RoadLine"].split(",")[i]);
		$(".right textarea[name='package_remark']").eq(i).val(getinfo["Address"].split("|")[i]);
		$(".right .shippingorderno").eq(i).val(getinfo["NoticeInfo"].split(",")[i]);
		if(getinfo["IsReinforce"].split(",")[i] == 1){
			$(".right .k1").eq(i).prop("checked",true);
			$(".right input[name='reinforce']").eq(i).attr("value","1");
			$(".right input[name='reinforce_remark']").eq(i).show();
			$(".right input[name='reinforce_remark']").eq(i).val(getinfo["ReinforceRemark"].split(",")[i]);
		}else{
			$(".right input[name='reinforce_remark']").eq(i).hide();
			$(".right .k1").eq(i).prop("checked",false);
		}
		$(".right select[name='address_delivery']").eq(i).find("option[value='"+getinfo["Address"].split(",")[i]+"']").prop("selected","selected");
		$(".right input[name='notice']").eq(i).attr("value",getinfo["NoticeInfo"].split(",")[i]);
	}
}

//获取订单的其他服务
function GetOrderOtherService(getinfo)
{
	if(getinfo["OtherService"].split(",")[0] ==1)
		$("input[name='insurance_explain']").prop("checked",true);
	else
		$("input[name='insurance_explain']").prop("checked",false);
	if(getinfo["OtherService"].split(",")[1] ==1)
		$("input[name='invoice_explain']").prop("checked",true);
	else
		$("input[name='invoice_explain']").prop("checked",false);
	if(getinfo["OtherService"].split(",")[2] ==1)
		$("input[name='pay_type']").eq(1).prop("checked",true);
	else
		$("input[name='pay_type']").eq(0).prop("checked",true);
	$("#relation_input_10").prop("checked",true);
}





























//jqeury ajax ---------------------------------------------------------------------
$(function(){
$(".delete_package").click(function () {
    if (confirm("确定要弃货吗？") == true) {
        $.ajax({
            type: "POST",
            url: "../Ashx/mystock.ashx",
            data: { "delete_no": this.name.split("_")[1] },
            datatype: "text",
            success: function (msg) {
                if (msg == "yes") {
                    alert("删除成功,请耐心等待工作人员审核");
                    location.href = "./NewMyStock.aspx";
                }
            }
        })
    }
})

$(".delete_delivery").click(function () {
    if (confirm("确定要删除该运单吗？") == true) {
    	$(".spinner").show();
        $.ajax({
            type: "POST",
            url: "../Ashx/mystock.ashx",
            data: { "delete_delivno": this.name },
            datatype: "text",
            success: function (msg){
                if (msg == "yes") {
                	$(".spinner").hide();
                    alert("删除成功");
                    location.href = "./NewMyStock.aspx?ordertype=delivery_waiting";
                }
            }
        })
    }
})

$(".pay_bill").click(function(){
	var orderno = this.name;
	$.ajax({
		type: "POST",
        url: "../Ashx/mystock.ashx?pay_bill=" + orderno,
        data: $("form").serialize(),
        datatype: "text",
        success: function (msg) {
            if (msg == "yes") 
                location.href="./PayBill.aspx?orderno="+orderno;
        }
	})
})

$(".cancel_delivery_action").click(function(){
	if (confirm("确定要取消吗？") == true) {
	var orderno = this.name;
	$.ajax({
		type: "POST",
        url: "../Ashx/mystock.ashx?cancel_action=" + orderno,
        data: $("form").serialize(),
        datatype: "text",
        success: function (msg) {
            if (msg == "yes") {
                alert("取消成功");
                location.href="./NewMyStock.aspx?ordertype=delivery_waiting";
            }
        }
	})	
	}
})

$(".deluseradd").click(function(){
	if (confirm("确定要删除吗？") == true) {
	var addressname = this.id.split("_")[1];
	$(this).parent().remove();
	$.ajax({
		type: "POST",
        url: "../Ashx/userinfo.ashx?del_user_address="+addressname,
        data: $("form").serialize(),
        datatype: "text",
        success: function (msg) {
            if (msg == "yes") {
                alert("删除成功");
            }
            else
            	alert("删除失败");
        }
    })
	}
})

//jquery ajax根据地区选省份
$('#ctl00_ContentPlaceHolder1_DropDownList_country').change(function () {
    $.ajax({
        type: "POST",
        url: "../Ashx/userinfo.ashx",
        data: { "Cvalue": $('#ctl00_ContentPlaceHolder1_DropDownList_country').val()},
        dataType: "text",
        success: function (data) {
            var jsonData = eval("(" + data + ")");
            $("#ctl00_ContentPlaceHolder1_DropDownList_province option:gt(0)").remove();
            $("#ctl00_ContentPlaceHolder1_DropDownList_city option:gt(0)").remove();
            $.each(jsonData, function (i, k) {
                var id = jsonData[i].Id;
                var name = jsonData[i].Name;
                $('#ctl00_ContentPlaceHolder1_DropDownList_province option[value="0"]').after("<option value='" + id + "'>" + name + "</option>");
            })
        }
    })
})
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

//jquery ajax 根据省份选城市
$('#ctl00_ContentPlaceHolder1_DropDownList_province').change(function () {
    $.ajax({
        type: "POST",
        url: "../Ashx/userinfo.ashx",
        data: { "Pvalue": $('#ctl00_ContentPlaceHolder1_DropDownList_province').val() },
        dataType: "text",
        success: function (data) {
            var jsonData = eval("(" + data + ")");
            $("#ctl00_ContentPlaceHolder1_DropDownList_city option:gt(0)").remove();
            $.each(jsonData, function (i, k) {
                var id = jsonData[i].Id;
                var name = jsonData[i].Name;
                $('#ctl00_ContentPlaceHolder1_DropDownList_city option[value="0"]').after("<option value='" + id + "'>" + name + "</option>");
            })
        }
    })
})
$('#ContentPlaceHolder1_DropDownList_province').change(function () {
    $.ajax({
        type: "POST",
        url: "../YouEx_Ashx/package.ashx",
        data: { "Pvalue": $('#ContentPlaceHolder1_DropDownList_province').val() },
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

//jquery ajax 根据仓库显示路线
$("#ctl00_ContentPlaceHolder1_DropDownList_DepotId").change(function(){
	var count = $(".right select[name='roadline_explain']").length;        	
	var depotid = $("#ctl00_ContentPlaceHolder1_DropDownList_DepotId option:selected").val();
	$.ajax({
		type: "POST",
        url: "../Ashx/package.ashx?depotid="+depotid,
        data: $("form").serialize(),
        datatype: "text",
        success: function (data) {
            var jsonData = eval("(" + data + ")");
            for(var a=0; a<count; a++){
            	$("select[name='roadline_explain']:eq("+a+") option:gt(0)").remove();
            }
            $.each(jsonData, function (i, k) {
                var id = jsonData[i].ShippingId;
                var name = jsonData[i].ShippingName;
            	for(var b=0; b<count; b++){                    		
            		$('select[name="roadline_explain"]:eq('+b+') option[value="0"]').after("<option value='" + id + "'>" + name + "</option>");
            	}
            })
        }
    })
})        

$(".tui").click(function(){
	var packageno = this.id.split("_")[1];
	$(".refund_submit_button_p").attr("name",packageno);
	$(".refund,.bj").show();
})

//申请退货
$(".refund_submit_button_p").click(function(){
	var packageno  = this.name;
	var count_null = ReturnIsNotNull(packageno);
	if(count_null > 0)
		return false;
	else{
		$.ajax({
			type: "POST",
            url: "../Ashx/mystock.ashx?refund_package="+packageno,
            data: $("form").serialize(),
            datatype: "text",
            success: function (msg){
                if (msg == "yes") {
                    alert("操作成功,请耐心等待工作人员审核");
                    location.href = "./NewMyStock.aspx";
                }else
                	alert("操作失败");
            }
        })
	}
})


$("#ctl00_ContentPlaceHolder1_TB_Rg_Mobile").blur(function(){
	$.ajax({
		type: "POST",
        url: "../Ashx/userinfo.ashx?checkmobile="+$("#ctl00_ContentPlaceHolder1_TB_Rg_Mobile").val(),
        data: $("form").serialize(),
        datatype: "text",
        success: function (msg) {
            if (msg == "yes") {
                $("#mobile_glyphicon_remove").show();
            }else
            	$("#mobile_glyphicon_remove").hide();
        }
    })
})


$("#ctl00_ContentPlaceHolder1_TB_Rg_Email").blur(function(){
	$.ajax({
		type: "POST",
        url: "../Ashx/userinfo.ashx?checkEmail="+$("#ctl00_ContentPlaceHolder1_TB_Rg_Email").val(),
        data: $("form").serialize(),
        datatype: "text",
        success: function (msg) {
            if (msg == "yes") {
               $("#email_glyphicon_remove").show();
            }else
            	$("#email_glyphicon_remove").hide();
        }
    })
})        

$("#ctl00_ContentPlaceHolder1_TB_Address_Name").blur(function(){
	if(window.location.search == ""){
    	$.ajax({
			type: "POST",
            url: "../Ashx/userinfo.ashx?checkaddressname="+$("#ctl00_ContentPlaceHolder1_TB_Address_Name").val(),
            data: $("form").serialize(),
            datatype: "text",
            success: function (msg) {
                if (msg == "yes") {
                   $(".diffrent_addressname_notice").show();
                }else
                   $(".diffrent_addressname_notice").hide();
            }
        })
	}
})







})

			