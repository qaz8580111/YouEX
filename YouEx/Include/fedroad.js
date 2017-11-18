//自带js
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
  $(".button5").click(function(){
	 $(this).addClass("change")
	 $(".button4").removeClass("change")
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
	 $(".use-address .no-sure").click(function(){
		$(".use-address,.bj").hide()
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
	$(".stock_address .button .no-sure").click(function(){
		$(".stock_address,.bj").hide()
	})
    
    $(".refund_cancel_button_d , .refund_cancel_button_p").click(function(){
		$("div[class^='refund_'],.bj").hide()
		})

	$("div[class^='edit-cargo'] .no-sure").click(function(){
		$("div[class^='edit-cargo'],.bj").hide()
		})
	$("div[class^='edit-cargo'] .cancel_mystock_goods_icon").click(function(){
	     $("div[class^='edit-cargo'],.bj").hide()
	   })
   $("div[class^='edit-cargo'] .cancel_delivery_goods_icon").click(function(){
	     $("div[class^='edit-cargo'],.bj").hide()
	   })
	 $("div[class^='fahuo_'] .button_delivery_default,.cancel_delivery_default_icon").click(function(){
		 $("div[class^='fahuo_'],.bj").hide()
		 })
	 $("div[class^='explain_'] .button_delivery_default").click(function(){
		 $("div[class^='explain_'],.bj").hide()
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
  $(".aut-login img").eq(1).hide()
  $(".aut-login img").click(function(){
	 $(this).hide().siblings().show()
	  })
$(".last-nav-bj a").mouseenter(function(){
	$(this).css("color","#1a9dd1").mouseleave(function(){
	$(this).css("color","#FFF")	}) 		
})










	
//js直接函数
	$(".defaultbox").mouseenter(function(){
		$(".defaultbox").css("background-color","#1A9DD1");
		$(".defaultbox_word").css("color","white");
	}).mouseleave(function(){
		if($(".show_delivery_default").is(":visible")){}else{
			$(".defaultbox").css("background-color","white");
			$(".defaultbox_word").css("color","#4C4C4C");
		}
	})

	$(".explainbox").mouseenter(function(){
		$(".explainbox").css("background-color","#1A9DD1");
		$(".explainbox_word").css("color","white");
	}).mouseleave(function(){
		if($(".explain_box").is(":visible")){}else{
			$(".explainbox").css("background-color","white");
			$(".explainbox_word").css("color","#4C4C4C");
		}
	})

	$(".defaultbox").click(function(){		
		if($("#ctl00_ContentPlaceHolder1_DropDownList_DepotId option:selected").val() != 0){
			$(".default_agree").prop("checked","checked");
			$(".show_delivery_default").show();
	   		$(".bj").show();
	   		$(".defaultbox").css("background-color","#1A9DD1");
			$(".defaultbox_word").css("color","white");
			$(".explainbox").css("background-color","white");
			$(".explainbox_word").css("color","#4C4C4C");
		}else
			alert("请选择收货仓库");
   })

   $(".explainbox").click(function(){
   		for (var i = 0; i <$("input[name='good_name']").length ; i++){
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

   		if($("#ctl00_ContentPlaceHolder1_DropDownList_DepotId option:selected").val() != 0){
   			var num1 = $(".package_info").find(".t3-content").length;
   			var num2 = $(".delivery_info").eq(0).find(".data_content").length;
   			for(var i=num1;i<num2;i++){
   				$(".delivery_info").eq(0).find(".data_content").eq(parseInt(num1)).remove();
   			}
   			$(".explain_agree").prop("checked","checked");
	   		$(".explain_box").show();
	   		$(".bj").show();
	   		$(".explainbox").css("background-color","#1A9DD1");
	   		$(".explainbox_word").css("color","white");
	   		$(".defaultbox").css("background-color","white");
			$(".defaultbox_word").css("color","#4C4C4C");
   		}else
   			alert("请选择收货仓库");
   })

   $(".save_delivery_default").click(function(){
   		if($(".default_agree").is(":checked")){
				if($("input[name='address_default']:checked").val() == 0){
					alert("请输入原箱的收货地址");
					return false;		
				}
				if($("select[name='roadline_default']").val() == 0){
					alert("请输入原箱的转运路线");					
					return false;
				}
				$(".show_delivery_default").hide();
   				$(".bj").hide();
				$('.isPackageType').attr("value","default");
			}
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
	$(".add_delivery").click(function(){
		var getdiv = $('#clone_explain');
        var newdiv = getdiv.clone(true);
        var no = $('.clone_delivery_no').length;
        newdiv.find('.clone_remove').attr('class','delivery_remove');
        newdiv.find('input[name="clone_name"]').attr("disabled",false);
        newdiv.find('input[name="clone_brand"]').attr("disabled",false);
        newdiv.find('input[name="clone_price"]').attr("disabled",false);
        newdiv.find('input[name="clone_amount"]').attr("disabled",false);
        newdiv.find('input[name="clone_buyurl"]').attr("disabled",false);
        newdiv.find('input[name="clone_amount"]').attr("class","data_count");
        newdiv.find('input[name="clone_amount"]').attr("name","delivery_count");
        newdiv.find('input[name="clone_brand"]').attr("name","delivery_brand");
        newdiv.find('input[name="clone_name"]').attr("name","delivery_name");
        newdiv.find('input[name="clone_price"]').attr("name","delivery_price");
        newdiv.find('input[name="clone_buyurl"]').attr("name","delivery_buyurl");
        newdiv.find('select[name="address_clone"]').attr("name","address_explain");
        newdiv.find('select[name="roadline_clone"]').attr("name","roadline_explain");
        newdiv.find('input[name="clone_calculate"]').attr("name","calculate");       
        newdiv.find(".clone_delivery_no").val(no);
        $('#cloneing_right').before(newdiv);
        clone_add_roadline();
	})

	$(".add_delivery_stock").click(function(){
		var deliveryno = this.id.split("_")[1];
		var getdiv = $('#clone_explain_'+deliveryno);
        var newdiv = getdiv.clone(true);
        var no = $('.explain_'+deliveryno+' #clone_delivery_no_'+deliveryno).length;
        newdiv.find('.calculate_amount input').attr('name','calculate_'+deliveryno);
        newdiv.find('input[name="clone_name_'+deliveryno+'"]').attr("disabled",false);
        newdiv.find('input[name="clone_brand_'+deliveryno+'"]').attr("disabled",false);
        newdiv.find('input[name="clone_price_'+deliveryno+'"]').attr("disabled",false);
        newdiv.find('input[name="clone_amount_'+deliveryno+'"]').attr("disabled",false);
        newdiv.find('input[name="clone_buyurl_'+deliveryno+'"]').attr("disabled",false);
        newdiv.find('input[name="clone_amount_'+deliveryno+'"]').attr("class","data_count");
        newdiv.find('input[name="clone_amount_'+deliveryno+'"]').attr("name","delivery_count_"+deliveryno);
        newdiv.find('input[name="clone_brand_'+deliveryno+'"]').attr("name","delivery_brand_"+deliveryno);
        newdiv.find('input[name="clone_name_'+deliveryno+'"]').attr("name","delivery_name_"+deliveryno);
        newdiv.find('input[name="clone_price_'+deliveryno+'"]').attr("name","delivery_price_"+deliveryno);
        newdiv.find('input[name="clone_buyurl_'+deliveryno+'"]').attr("name","delivery_buyurl_"+deliveryno);
        newdiv.find('select[name="address_clone_'+deliveryno+'"]').attr("name","address_explain_"+deliveryno);
        newdiv.find('select[name="roadline_clone_'+deliveryno+'"]').attr("name","roadline_explain_"+deliveryno);
        newdiv.find('input[name="clone_calculate"]').attr("name","calculate_"+deliveryno);
		newdiv.find('.add input').removeAttr("onclick").attr("onclick","addTr11(this, -1);");
		newdiv.find("#clone_delivery_no_"+deliveryno).val(no);
        $('.explain_'+deliveryno+'  #cloneing_right').before(newdiv);
	})

	$(".add_delivery_wait").click(function(){
		var deliveryno = this.id.split("_")[1];
		var getdiv = $('#clone_explain_'+deliveryno);
        var newdiv = getdiv.clone(true);
        var no = $('.explain_'+deliveryno+' #clone_delivery_no_'+deliveryno).length;
        newdiv.find('.calculate_amount input').attr('name','calculate_'+deliveryno);
        newdiv.find('input[name="clone_name_'+deliveryno+'"]').attr("disabled",false);
        newdiv.find('input[name="clone_brand_'+deliveryno+'"]').attr("disabled",false);
        newdiv.find('input[name="clone_price_'+deliveryno+'"]').attr("disabled",false);
        newdiv.find('input[name="clone_amount_'+deliveryno+'"]').attr("disabled",false);
        newdiv.find('input[name="clone_buyurl_'+deliveryno+'"]').attr("disabled",false);
        newdiv.find('input[name="clone_amount_'+deliveryno+'"]').attr("class","data_count");
        newdiv.find('input[name="clone_amount_'+deliveryno+'"]').attr("name","delivery_count_"+deliveryno);
        newdiv.find('input[name="clone_brand_'+deliveryno+'"]').attr("name","delivery_brand_"+deliveryno);
        newdiv.find('input[name="clone_name_'+deliveryno+'"]').attr("name","delivery_name_"+deliveryno);
        newdiv.find('input[name="clone_price_'+deliveryno+'"]').attr("name","delivery_price_"+deliveryno);
        newdiv.find('input[name="clone_buyurl_'+deliveryno+'"]').attr("name","delivery_buyurl_"+deliveryno);
        newdiv.find('select[name="address_clone_'+deliveryno+'"]').attr("name","address_explain_"+deliveryno);
        newdiv.find('select[name="roadline_clone_'+deliveryno+'"]').attr("name","roadline_explain_"+deliveryno);
        newdiv.find('input[name="clone_calculate"]').attr("name","calculate_"+deliveryno);
		newdiv.find('.add input').removeAttr("onclick").attr("onclick","addTr11(this, -1);");
		newdiv.find("#clone_delivery_no_"+deliveryno).val(no);
        $('.explain_'+deliveryno+'  #cloneing_right_de').before(newdiv);
	})

    $(".save_stock_good").click(function(){
    	var deliveryno = this.id.split("_")[1];
    	var connection_explain_isspecial = IsSpecialWord($("input[name='connection_explain_"+this.id.split("_")[1]+"']").val());	
		if(!connection_explain_isspecial && $("input[name='connection_explain_"+this.id.split("_")[1]+"']").val() == "")
			connection_explain_isspecial = true ;
		if(!connection_explain_isspecial){
			alert("输入的内容含有非法字符");
			return false;
		}
    	
		for(var i = 0 ; i < $("input[name='delivery_name_"+deliveryno+"']").length ; i++){
			if($("input[name='delivery_name_"+deliveryno+"']").eq(i).val()==""){
				alert("请输入商品名字");
				return false;
			}
			if(!IsSpecialWord($("input[name='delivery_name_"+deliveryno+"']").eq(i).val())){
				alert("输入的内容含有非法字符");
				return false;
			}
			if($("input[name='delivery_brand_"+deliveryno+"']").eq(i).val()==""){			
				alert("请输入商品品牌");
				return false;
			}
			if(!IsSpecialWord($("input[name='delivery_brand_"+deliveryno+"']").eq(i).val())){
				alert("输入的内容含有非法字符");
				return false;
			}
			if($("input[name='delivery_price_"+deliveryno+"']").eq(i).val()=="" ||
				!(/^\d+(\.\d{1,2})?$/.test($("input[name='delivery_price_"+deliveryno+"']").eq(i).val()))){
				alert("请输入正确的价格格式");
				return false;
			}
			if($("input[name='delivery_count_"+deliveryno+"']").eq(i).val()=="" ||
				!(/^\d{1,2}?$/.test($("input[name='delivery_count_"+deliveryno+"']").eq(i).val()))){						
				alert("请输入数量在1-99之间");
				return false;
			}
			if(!IsSpecialWord($("input[name='delivery_buyurl_"+deliveryno+"']").eq(i).val())){
				alert("输入的内容含有非法字符");
				return false;
			}
		}
		for (var i = 0; i < $("select[name='address_explain_"+deliveryno+"']").length; i++) {
			if($("select[name='roadline_explain_"+deliveryno+"']").eq(i).val() == 0){
				alert("请输入分箱的转运路线");
				return false;
			}
			if($("select[name='address_explain_"+deliveryno+"']").eq(i).val() == 0){
				alert("请输入分箱的收货地址");
				return false;
			}
		};

    	if($(".explain_agree_"+deliveryno).is(":checked")){
	      var names = new Array(20);
	      var clone_count = new Array(20);
	      var j = 0;
	      var isright=0;

	    
			for(var i=0;i<$("select[name='address_explain_"+deliveryno+"']").length;i++){
				var a = $("#cloneing_explain_"+deliveryno).find("#clone_explain_"+deliveryno).eq(i).find(".t3").find(".data_content").find(".data_name").length;
				$(".calculate_amount_"+deliveryno).eq(i+1).find("input[name='calculate_"+deliveryno+"']").val(a);
			}

	      for(var i=0;i<$("#clone_explain_"+deliveryno).find(".data_amount").length;i++){
	      	var item = 0;
		    names[i] = $('#clone_explain_'+deliveryno).eq(0).find(".data_name").eq(i).val();
		    var m = 0;
		    for(m=0;m<$('#cloneing_explain_'+deliveryno).find(".search_name input[value="+names[i]+"]").length;m++){			
				item += parseInt($('#cloneing_explain_'+deliveryno).find(".search_name input[value="+names[i]+"]").parent().parent().find('.data_count').eq(m).val());
			}
			clone_count[i] = item;
		}
		    for(var i=0;i<$("#clone_explain_"+deliveryno).find('.data_amount').length;i++){
		      if($("#clone_explain_"+deliveryno).find('.data_amount').eq(i).val() == clone_count[i]){
		        isright++;
		      }
		    }
		    if(isright != $("#clone_explain_"+deliveryno).find('input[name="clone_amount_'+deliveryno+'"]').length){
		        alert('商品数量不相等，请仔细核对');
		        return false;
	      }
		    save_explain_delivery(deliveryno);
	   		$(".explain_box,div[class^='explain_']").hide();
	   		$(".bj").hide();
   		}else{alert("请仔细阅读协议并同意");}
   })

   $(".clone_remove").click(function(){
   		if(this.name == null){
			$(this).parent().parent().parent().parent().remove();
			var no = $("#cloneing_explain .clone_delivery_no").length;		
			for(var i=0;i<no;i++){
				$("#cloneing_explain .clone_delivery_no").eq(i).val(i+1);
			}
		}
   		if(this.name != ""){
   			$(this).parent().parent().parent().parent().remove();
   			var deliveryno = this.name.split("_")[1];
   			var no_delivery = $("#cloneing_explain_"+deliveryno+" #clone_delivery_no_"+deliveryno).length;
   			for(var i=0;i<no_delivery;i++){
				$("#cloneing_explain_"+deliveryno+" #clone_delivery_no_"+deliveryno).eq(i).val(i+1);	
			}
   		}   		
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
		location.href="../Package/Package.aspx?shippingno="+$(".underuser_addpackage_input").val();	
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
        var str_photo_number = parseInt(Math.random() * 1000);
        var regstr_photo = new RegExp(str_photo, "g");
        div = div.replace(regstr_photo, "relationphoto_" + str_photo_number);
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
    })

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
        $(".blue1").css("margin-left","340px");
    }
    if ($(".hide_ordertype").val() == "delivery_finished") {
        $("#all_deliverys_finished").show();
        $(".finish-end").css("color","#4c4c4c");
        $(".blue1").css("margin-left","460px");
    }
    /*$(document).scroll(function(){
    	$(".last-nav-bj").css("position","inherit");
	})//滚动触发事件
    alert("页面高度:"+$(document).height()+
    	"当前可视页面:"+ $(window).height());
	alert($("#master_content").height() + "--" + parseInt($(window).height()-80));*/
    if($("#master_content").height() > parseInt($(window).height()-80)){
    	$(".last-nav-bj").css("position","inherit");
    }


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
        $("input[id^='relationnotice_']").attr("checked", true);
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
    $(document).on("click", "input[id^='relationphoto_']", function () {
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

    $(document).on("dblclick", "img[id^='ctl00_ContentPlaceHolder1_Image']", function () {
        var i = this.id.split("Image")[1];
        if (confirm("是否删除该照片？") == true) {
            $("#ctl00_ContentPlaceHolder1_Image" + i).attr("src", "");
            $("input[name='Label_Upload" + i + "']").val("")
            $("#ctl00_ContentPlaceHolder1_Image" + i).hide();
            $(this).parent().find(".show_upload_style").attr("onclick", "$('#ctl00_ContentPlaceHolder1_FileUpload" + i + "').click()");
        }
    })
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
    })
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
                if (msg == "reyes") {
                    alert("该货物已入库,请尽快提交发货");
                    location.href = "./MyStock.aspx" ;
                }
                if(msg == "yes"){
                	self_input.hide();
                }
                if(msg == "no"){
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
    });
})



























	//下面为JS函数
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
	function addTr(obj, row, trHtml){
		var $tr = $(obj).parent().parent().parent().find(".c3-box1 li").eq(row);
		$tr.after(trHtml);
		newpackage_reload();
	}

	function addTr3(obj, row) {
		var trHtml="<div class='last-div'></div><div class='data_content'>"+
		           "<div class='search_name'><input class='data_name' type='text' name='delivery_name' oninput='flush_name_value(this);' /></div>"+
		           "<input class='data_brand' type='text' name='delivery_brand' />"+
		           "<input class='data_price' type='text' name='delivery_price' />"+
		           "<input class='data_count' type='text' name='delivery_count' />"+
		           "<input class='data_buyurl' type='text' name='delivery_buyurl' />"+
		           "<input class='data_button' type='button' onclick='delTr(this);' value='删除' /></div>"
		addTr4(obj, row, trHtml);
	}
	function addTr4(obj, row, trHtml) {
	var $tr = $(obj).parent().parent().parent().find(".data_content").eq(row);
	$tr.after(trHtml);
	}

	function addTr5(data_content, row) {
	var trHtml="<div class='last-div'></div><div class='data_content'>"+
	           "<div class='search_name'><input class='data_name' type='text' name='clone_name' disabled='disabled' /></div>"+
	           "<input class='data_brand' type='text' name='clone_brand' disabled='disabled' />"+
	           "<input class='data_price' type='text' name='clone_price' disabled='disabled' />"+
	           "<input class='data_amount' type='text' name='clone_amount' disabled='disabled' />"+
	           "<input class='data_buyurl' type='text' name='clone_buyurl' disabled='disabled' />"+
	           "<input class='data_button' type='button' onclick='delTr(this);' value='删除' /></div>"
	addTr6("data_content", row, trHtml);
	}
	function addTr6(data_content, row, trHtml) {
	var $tr = $("#clone_explain").eq(0).find(".data_content").eq(row);
	$tr.after(trHtml);
	}

	function addTr7(obj, row) {
	var str_packageno = $(obj).parent().parent().parent().parent().parent().attr("class");
	var trHtml="<div class='t3-content'>"+
               "<div class='s1'><input type='text' name='good_name_"+str_packageno.split("_")[1]+"' /></div>" +
               "<div class='s2'><input type='text' name='good_brand_"+str_packageno.split("_")[1]+"' /></div>" +
               "<div class='s3'><input type='text' name='good_price_"+str_packageno.split("_")[1]+"' /></div>" +
               "<div class='s6'><span>（￥）</span></div>"+
               "<div class='s4'><input type='text' name='good_amount_"+str_packageno.split("_")[1]+"' /></div>" +
               "<div class='s5'><input type='text' name='good_buyurl_" + str_packageno.split("_")[1] + "' /></div>"+
               "<div class='s7'><input class='data_button' type='button' onclick='delTr_addPac(this);' value='删除' /></div></div>";
	addTr8(obj, row, trHtml);
	}
	function addTr8(obj, row, trHtml) {
	var $tr = $(obj).parent().parent().find(".t3-content").eq(row);
	$tr.after(trHtml);
	}

	function addTr9(obj, row) {
	var deliveryno = obj.name;
	var trHtml="<div class='data_content'>"+
	           "<div class='search_name'><input class='data_name' type='text' name='clone_name_"+deliveryno+"' oninput='flush_name_value(this);' /></div>"+
	           "<input class='data_brand' type='text' name='clone_brand_"+deliveryno+"' />"+
	           "<input class='data_price' type='text' name='clone_price_"+deliveryno+"' />"+
	           "<input class='data_amount' type='text' name='clone_amount_"+deliveryno+"' />"+
	           "<input class='data_buyurl' type='text' name='clone_buyurl_"+deliveryno+"' />"+
	           "<input class='data_button' type='button' onclick='delTr(this);' value='删除' /></div>"
	addTr10(obj, row, trHtml);
	}
	function addTr10(obj, row, trHtml) {
	var $tr = $(obj).parent().parent().parent().find('.data_content').eq(row);
	$tr.after(trHtml);
	}

	function addTr11(obj, row) {
	var deliveryno = obj.name;
	var trHtml="<div class='last-div'></div><div class='data_content'>"+
	           "<div class='search_name'><input class='data_name' type='text' name='delivery_name_"+deliveryno+"' oninput='flush_name_value(this);' /></div>"+
	           "<input class='data_brand' type='text' name='delivery_brand_"+deliveryno+"' />"+
	           "<input class='data_price' type='text' name='delivery_price_"+deliveryno+"' />"+
	           "<input class='data_count' type='text' name='delivery_count_"+deliveryno+"' />"+
	           "<input class='data_buyurl' type='text' name='delivery_buyurl_"+deliveryno+"' />"+
	           "<input class='data_button' type='button' onclick='delTr(this);' value='删除' /></div>"
	addTr4(obj, row, trHtml);
	}
	function addTr12(obj, row, trHtml) {
	var $tr = $(obj).parent().parent().parent().find(".data_content").eq(row);
	$tr.after(trHtml);
	}

	function delTr_addPac(obj){
		if($(obj).parent().parent().parent().find(".t3-content").length == 1)
			alert("只有一条数据，无法删除");
		else
			$(obj).parent().parent().remove();
	}

	function delTr(obj) {
		if($(obj).parent().parent().find("li").length > 1)		
			$(obj).parent().remove();
	}

	function add_package_default(obj){
      var t = $(obj).parent().find('input[name="good_amount"]');
          t.val(parseInt(t.val()) + 1);
    };
	function minus_package_explain(obj){
	      var t = $(obj).parent().find('input[name="delivery_count"]');
	      if (parseInt(t.val()) > 1)
	          t.val(parseInt(t.val()) - 1);
	      else
	          t.val(1);
    };

	function check_package(){		
		if($("input[name='shippingorder']").val()==""){
			alert("请输入运单号");
			return false;
		}
		if($("select[name='depotid']").val() == 0){
			alert("请选择收货仓库");
			return false;
		}
		for (var i = 0; i <$("input[name='good_name']").length ; i++) {
			if($("input[name='good_name']").eq(i).val()==""){
				alert("请输入商品名字");
				return false;
			}
			if($("input[name='good_brand']").eq(i).val()==""){
				alert("请输入商品品牌");
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
		};
		return true;
	}
	function check_delivery(){
		for(var i=0;i<$("select[name='address_explain']").length;i++){
			var a = $(".calculate_amount").eq(i+1).parent().parent().parent().parent().find("input[name='delivery_name']").length;
			$(".calculate_amount").eq(i+1).find("input[name='calculate']").val(a);
		}
		if($("input[name='shippingorder']").val()==""){
			alert("请输入运单号");
			return false;
		}
		if($("select[name='ctl00$ContentPlaceHolder1$DropDownList_DepotId']").val() == 0){
			alert("请选择收货仓库");
			return false;
		}
		var shippingname_isspecial = IsSpecialWord($("input[name='shippingorder']").val());
		var remark_isspecial = IsSpecialWord($("textarea[name='remark']").val());	
		if(!remark_isspecial && $("textarea[name='remark']").val() == "")
			remark_isspecial = true ;
		var photoremark_isspecial = IsSpecialWord($("input[name='photo_remark']").val());
		if(!photoremark_isspecial && $("input[name='photo_remark']").val() == "")
			photoremark_isspecial = true ;
		var reinforceremark_isspecial = IsSpecialWord($("input[name='reinforce_remark']").val());
		if(!reinforceremark_isspecial && $("input[name='reinforce_remark']").val() == "")
			reinforceremark_isspecial = true ;
		var connectiondefault_isspecial = IsSpecialWord($("input[name='connection_default']").val());
		if(!connectiondefault_isspecial && $("input[name='connection_default']").val() == "")
			connectiondefault_isspecial = true ;
		var connectionexplain_isspecial = IsSpecialWord($("input[name='connection_explain']").val());
		if(!connectionexplain_isspecial && $("input[name='connection_explain']").val() == "")
			connectionexplain_isspecial = true ;
		if(!shippingname_isspecial || !remark_isspecial || !photoremark_isspecial || !reinforceremark_isspecial
			|| !connectiondefault_isspecial || !connectionexplain_isspecial){
			alert("输入的内容含有非法字符");
			return false
		}

		for (var i = 0; i <$("input[name='good_name']").length ; i++){
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
		if($(".isPackageType").val() != "default" && $(".isPackageType").val() != "explain")
		{
			alert("请对包裹进行操作");
			return false;
		}
		return true;
	}

	function clone_flush(obj){
		$(obj).attr("value",obj.value);
	}
	function cleanrow(obj){
		$(obj).parent().parent().find("input").val("");
		$(obj).val("清空");
	}


	function address_func(obj){
		var format = new Array("jpg", "png", "gif", "bmp");		
		var addressname_isspecial = IsSpecialWord($("#ctl00_ContentPlaceHolder1_TB_Address_Name").val());
		var recipients_isspecial = IsSpecialWord($("#ctl00_ContentPlaceHolder1_TB_Address_Recipients").val());		
		var address_isspecial = IsSpecialWord($("#ctl00_ContentPlaceHolder1_TB_Address_Address").val());
		var zipcode_isspecial = IsSpecialWord($("#ctl00_ContentPlaceHolder1_TB_Address_ZipCode").val());		
		if(!zipcode_isspecial && $("#ctl00_ContentPlaceHolder1_TB_Address_ZipCode").val() == "")
			zipcode_isspecial = true;
		if($("#ctl00_ContentPlaceHolder1_DropDownList_country").find("option:selected").val() == 0 ||
		   $("#ctl00_ContentPlaceHolder1_DropDownList_province").find("option:selected").val() == 0 ||
		   $("#ctl00_ContentPlaceHolder1_DropDownList_city").find("option:selected").val() == 0)
			{alert('未填写地址');return false;}
		if($("#ctl00_ContentPlaceHolder1_Image_IdCardFront").attr("src") == "../Images/Pic_User/idcard_front.png" || 
		   $("#ctl00_ContentPlaceHolder1_Image_IdCardBack").attr("src") == "../Images/Pic_User/idcard_back.png")
		{
			alert("请上传您的正反面身份证");
			return false;
		}
		if($(".diffrent_addressname_notice").is(":visible")){
			return false;
		}
		if($("#ctl00_ContentPlaceHolder1_uploadPicFront").val() != ""){			
			var suffix_front = $("#ctl00_ContentPlaceHolder1_uploadPicFront").val().split(".")[1];
			var front_isright = false;
			for(var i=0;i<format.length;i++){	
				if((suffix_front.indexOf(format[i]))>=0){front_isright = true;}
			};
			if(!front_isright){
				alert('上传的图片格式错误');
				return false;
			}			
		}
		if($("#ctl00_ContentPlaceHolder1_uploadPicBack").val() != ""){
			var suffix_back  = $("#ctl00_ContentPlaceHolder1_uploadPicBack").val().split(".")[1];
			var back_isright = false;
			for(var i=0;i<format.length;i++){	
				if(suffix_back.indexOf(format[i])>=0){back_isright = true;}
			};
			if(!back_isright){
				alert('上传的图片格式错误');
				return false;
			}	
		}

		if(addressname_isspecial && recipients_isspecial && address_isspecial && zipcode_isspecial)
		{			
			return true;
		}
		else{
			alert("输入的内容含有非法字符");
			return false;
		}
	}

	//检查是否有特殊字符
	function IsSpecialWord(usertext){
		var result_isspecial = /^[\u4e00-\u9fa5a-zA-Z0-9,\/.?，。:：？（）()!！_-]+$/gi.test(usertext);
		if(result_isspecial)
			return true;
		else{
			return false;
		}
	}

	function save_explain_delivery(deliveryno){
		for(var i=0;i<$("select[name='address_explain_"+deliveryno+"']").length;i++){
			var a = $(".calculate_amount").eq(i+1).parent().parent().parent().find("input[name='delivery_name_"+deliveryno+"']").length;
			$(".calculate_amount").find("input[name='calculate_"+deliveryno+"']").val(a);
		}
		$.ajax({
			type: "POST",
                url: "../Ashx/mystock.ashx?save_explain_deliveryno="+deliveryno,
                data: $("form").serialize(),
                datatype: "text",
                success: function (msg) {
                    if (msg == "yes") {
                        alert("保存成功");
                        location.href = "./MyStock.aspx?ordertype=delivery_waiting";
                    }else
                    	alert("保存失败");
                    }
				})
		}

	function isReturnPackage(packageno){
		$.ajax({
            type: "POST",
            url: "../Ashx/mystock.ashx?show_delete_package=" + packageno,
            data: $("form").serialize(),
            datatype: "text",
            success: function (msg) {
                if (msg == "return_yes") {
            		$(".img_del_"+packageno).show();
            		$("input[name='edit_"+packageno+"']").hide();
            		$("#packagetui_"+packageno).hide();
            		$("input[name='packagedefault_"+packageno+"']").hide();
            		$("input[name='packageexplain_"+packageno+"']").hide();
            		$("input[value='"+packageno+"']").attr("disabled",true);
                }
                if (msg == "abort_yes") {
            		$(".img_del_"+packageno).show();
            		$("input[name='edit_"+packageno+"']").hide();
            		$("#packagetui_"+packageno).hide();
            		$("input[name='packagedefault_"+packageno+"']").hide();
            		$("input[name='packageexplain_"+packageno+"']").hide();
            		$("input[value='"+packageno+"']").attr("disabled",true);
            		$("input[name='abort_"+packageno+"']").hide();
                }
            }
        })
	}

	function deliveryGoodWriteIn(deliveryno) {
        $.ajax({
            type: "POST",
            url: "./MyStock.aspx?ordertype=delivery_waiting ",
            data: { "clonegoodsno": deliveryno },
            datatype: "text",
            async: false,
            success: function (msg) {
                var delivery_good = msg.split(",");
                for (var i = 0; i < delivery_good.length - 1; i++) {
                    $("#cloneing_explain_" + deliveryno).find(".word-title").eq(i).after(delivery_good[i]);
                }
            }
        })
    }

    function show_explain_rd_ad(deliveryno){
        var str_multi_rd_op = $(".hide_explain_roadline_" + deliveryno).text();
        var str_multi_ad_op = $(".hide_explain_address_" + deliveryno).text();
        var multi_rd = new Array(10);
        multi_rd = str_multi_rd_op.split(",");
        multi_rd.pop();
        var multi_ad = new Array(10);
        multi_ad = str_multi_ad_op.split(",");
        multi_ad.pop();
        for (var i = 0; i < multi_rd.length; i++) {
	        $("#cloneing_explain_" + deliveryno).find("select[name='roadline_explain_" + deliveryno + "']").eq(i).find("option[value='" + multi_rd[i] + "']").prop("selected", true);
	        $("#cloneing_explain_" + deliveryno).find("select[name='address_explain_" + deliveryno + "']").eq(i).find("option[value='" + multi_ad[i] + "']").prop("selected", true);
    	}
    }

	function PayBill(){
		if($("input[name='cb_bank']").is(":checked") && $("input[name='type_bank']").val() < 1){
			alert("银行充值支付的金额需大于1元");
			return false;
		}
    	var packageno = $(".button_paybill").attr("name");
    	var isbank = false;    	
		$.ajax({
			type: "POST",
            url: "../Package/PayBill.aspx?ispaybill="+packageno,
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

    function clone_add_roadline(){
    	var count = $("input[name='calculate']").length;
    	var depotid = $("#ctl00_ContentPlaceHolder1_DropDownList_DepotId option:selected").val();
		$.ajax({
			type: "POST",
            url: "../Package/Package.aspx?depotid="+depotid,
            data: $("form").serialize(),
            datatype: "text",
            success: function (data) {
                var jsonData = eval("(" + data + ")");
                for(var a=0; a<count ; a++){
                	$("select[name='roadline_explain']:eq("+a+") option:gt(0)").remove();
                }
                $.each(jsonData, function (i, k) {
                    var id = jsonData[i].ShippingId;
                    var name = jsonData[i].ShippingName;
                    for(var b=0; b<count; b++){                   
                		$('select[name^="roadline_explain"]:eq('+b+') option[value="0"]').after("<option value='" + id + "'>" + name + "</option>");
            		}
                })
            }
        })
    }

    function ReturnIsNotNull(packageno) {
         var count_null = 0;
         var array_str = new Array("refund_recipients_" + packageno, "refund_mobile_" + packageno, "refund_addressone_" + packageno,
             "refund_addresstwo_" + packageno, "refund_province_" + packageno, "refund_zipcode_" + packageno, "refund_price_" + packageno,
             "refund_email_" + packageno);
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







     //NewPackage
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
		for (var i = 0; i < $(".left .g-box").length; i++) {
			if($("input[name='shippingorder']").eq(i).val() == 0){
				alert("请输入运单号");
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













	//jqeury ajax 
	$(function(){
	$(".delete_package").click(function () {
            if (confirm("确定要弃货吗？") == true) {
            	//$(this).parent().parent().remove();
                $.ajax({
                    type: "POST",
                    url: "../Ashx/mystock.ashx",
                    data: { "delete_no": this.name.split("_")[1] },
                    datatype: "text",
                    success: function (msg) {
                        if (msg == "yes") {
                            alert("删除成功,请耐心等待工作人员审核");
                            location.href = "./MyStock.aspx";
                        }
                        if (msg == "no") {
                            alert("删除失败");
                        }
                        if(msg == "nono"){
                        	alert("该包裹正在操作,或有运单存在");
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
                            location.href = "./MyStock.aspx?ordertype=delivery_waiting";
                        }
                    }
                })
            }
        })
        //:hover{ transform:rotate(180deg)}transition:1s;
        $(".add_package_sure").click(function () {
        	for (var i = 0; i <$("input[name='good_brand_"+this.name+"']").length ; i++){
				if($("input[name='good_name_"+this.name+"']").eq(i).val()==""){
					alert("请输入商品名字");
					return false;
				}
				if(!IsSpecialWord($("input[name='good_name_"+this.name+"']").eq(i).val())){
					alert("输入的内容含有非法字符");
					return false;
				}
				if($("input[name='good_brand_"+this.name+"']").eq(i).val()==""){
					alert("请输入商品品牌");
					return false;
				}
				if(!IsSpecialWord($("input[name='good_brand_"+this.name+"']").eq(i).val())){
					alert("输入的内容含有非法字符");
					return false;
				}
				if($("input[name='good_price_"+this.name+"']").eq(i).val()=="" ||
					!(/^\d+(\.\d{1,2})?$/.test($("input[name='good_price_"+this.name+"']").eq(i).val()))){
					alert("请输入正确的价格格式");
					return false;
				}
				if($("input[name='good_amount_"+this.name+"']").eq(i).val()=="" ||
					!(/^\d{1,2}?$/.test($("input[name='good_amount_"+this.name+"']").eq(i).val()))){
					alert("请输入数量在1-99之间");
					return false;
				}
				if(!IsSpecialWord($("input[name='good_buyurl_"+this.name+"']").eq(i).val())){
					alert("输入的内容含有非法字符");
					return false;
				}
			}
            if (confirm("确定修改商品信息？") == true) {
                $.ajax({
                    type: "POST",
                    url: "../Ashx/mystock.ashx?edit_goodsno="+this.name,
                    data: $("form").serialize(),
                    datatype: "text",
                    success: function (msg) {
                        if (msg == "yes") {
                            alert("保存成功");
                            location.href="./MyStock.aspx";
                        }else
                            alert("保存失败");
                    }
                })
            }
        })

        $(".wu1").click(function () {
	    	var deliveryno = this.name.split("_")[1];
	    	$(".edit-cargo_" + deliveryno + ",.bj").show();
        })

        $(".zhi-fahuo").click(function () {
        	var deliveryno = this.name;
        	$(".spinner").show();
        	$.ajax({
                type: "POST",
                url: "../Ashx/mystock.ashx?count_deliveryno=" + this.name,
                data: $("form").serialize(),
                datatype: "text",
                success: function (msg) {
                    if (msg.split("_")[0] == "yes") {                    	
                    	if($("#cloneing_explain_"+deliveryno).find(".clone_remove").length < msg.split("_")[1])
                    	{
                    		for(var i=0;i<msg.split("_")[1];i++)
                    		{
                    			$("#deliverywait_"+deliveryno).click();
                    			$("#cloneing_explain_"+deliveryno).find(".data_button").click();
							}
							deliveryGoodWriteIn(deliveryno);
						}						
						show_explain_rd_ad(deliveryno);						
						$(".spinner").hide();
						$(".explain_" + deliveryno + ",.bj").show();
                    }                    
                    if(msg.split("_")[0] == "no"){
                    	$(".spinner").hide();
                    	$(".fahuo_"+deliveryno + ",.bj").show();
                    }
                }
            })	
        })
   	
		$(".submit_explain_package").click(function () {
        	var deliveryno = this.name.split("_")[1];
        	$.ajax({
                type: "POST",
                url: "../Ashx/mystock.ashx?excount_deliveryno=" + deliveryno,
                data: $("form").serialize(),
                datatype: "text",
                success: function (msg) {
                    if (msg == "yes") {              
                		$(".explain_" + deliveryno + ",.bj").show();
                    }else{
                    	$(".button input[name='"+deliveryno+"']").css("background-color","grey");
                    }
                }
            })
        })



        $(".add_delivery_sure").click(function (){
        	for (var i = 0; i <$("input[name='good_brand_"+this.name+"']").length ; i++){
				if($("input[name='good_name_"+this.name+"']").eq(i).val()==""){
					alert("请输入商品名字");
					return false;
				}
				if(!IsSpecialWord($("input[name='good_name_"+this.name+"']").eq(i).val())){
					alert("输入的内容含有非法字符");
					return false;
				}
				if($("input[name='good_brand_"+this.name+"']").eq(i).val()==""){
					alert("请输入商品品牌");
					return false;
				}
				if(!IsSpecialWord($("input[name='good_brand_"+this.name+"']").eq(i).val())){
					alert("输入的内容含有非法字符");
					return false;
				}
				if($("input[name='good_price_"+this.name+"']").eq(i).val()=="" ||
					!(/^\d+(\.\d{1,2})?$/.test($("input[name='good_price_"+this.name+"']").eq(i).val()))){
					alert("请输入正确的价格格式");
					return false;
				}
				if($("input[name='good_amount_"+this.name+"']").eq(i).val()=="" ||
					!(/^\d{1,2}?$/.test($("input[name='good_amount_"+this.name+"']").eq(i).val()))){
					alert("请输入数量在1-99之间");
					return false;
				}
				if(!IsSpecialWord($("input[name='good_buyurl_"+this.name+"']").eq(i).val())){
					alert("输入的内容含有非法字符");
					return false;
				}
			}
            if (confirm("确定修改商品信息？") == true) {
                $.ajax({
                    type: "POST",
                    url: "../Ashx/mystock.ashx?edit_delivgoodsno=" + this.name,
                    data: $("form").serialize(),
                    datatype: "text",
                    success: function (msg) {
                        if (msg == "yes") {
                            alert("保存成功");
                            location.href="./MyStock.aspx?ordertype=delivery_waiting";
                            //$(this).load(this.location.href+" .t3>*");
                        }else
                            alert("保存失败");
                    }
                })
            }
        })

        $(".submit_delivery_default").click(function (){        	
        	var deliveryno = this.name;        	
        	if($(".default_agree_"+deliveryno).is(":checked")){
                $.ajax({
                    type: "POST",
                    url: "../Ashx/mystock.ashx?submit_delivery=" + this.name,
                    data: $("form").serialize(),
                    datatype: "text",
                    success: function (msg) {
                    	alert(msg);
                        if (msg == "yes") {
                            alert("保存成功");
                            location.href = "./MyStock.aspx?ordertype=delivery_waiting";
                        } if(msg == "no")
                            alert("保存失败");
                    }
                })
            }else
            	alert("请仔细阅读协议并同意");
        })

    	$(".add_packages").click(function(){
    		var packageno = this.name.split("_")[1];
    		var packagesno = "";
    		for(var i = 0;i<$("input[name='check_package']:checked").length;i++)
    		{

    			packagesno += $("input[name='check_package']:checked").eq(i).val()+",";
    		}
    		packagesno = packagesno.substring(0,packagesno.length-1);
    		$.ajax({
                type: "POST",
                url: "../Ashx/mystock.ashx?add_count_deliveryno=" + packageno,
                data: {"add_packagesno":packagesno},
                datatype: "text",
                success: function (msg) {
                    if (msg == "yes") {              
                		if($("input[name='check_package']:checked").length >1)
                		{
							$(".addpackage_"+packageno +" ,.bj").show();
						}
                    }
                }
            })
    	})

    	$(".save_add_package").click(function(){
    		var connection_isspecial = IsSpecialWord($("input[name='connection_"+this.name+"']").val());	
			if(!connection_isspecial && $("input[name='connection_"+this.name+"']").val() == "")
				connection_isspecial = true ;
			if(!connection_isspecial){
				alert("输入的内容含有非法字符");
				return false;
			}
			if($("select[name='address_"+this.name+"'] option:checked").val() == 0){
				alert("请输入合箱的收货地址");
				return false;
			}
			if($("select[name='roadline_"+this.name+"'] option:checked").val() == 0){
				alert("请输入合箱的转运路线");
				return false;
			}
    		if($(".package_agree").is(":checked")){
				var packagesno = "";
				var packageno = this.name;
				for(var i=0;i<$("input[name='check_package']:checked").length;i++){
					packagesno += $("input[name='check_package']:checked").eq(i).val()+",";
				}
				packagesno = packagesno.substring(0,packagesno.length-1);
				$.ajax({
					type: "POST",
	                url: "../Ashx/mystock.ashx?add_packages=" + packagesno+"&&add_package="+packageno,
	                data: $("form").serialize(),
	                datatype: "text",
	                success: function (msg){
	                    if (msg == "yes") {
	                        alert("操作成功");
	                        location.href = "./MyStock.aspx?ordertype=delivery_waiting";
	                    } else
	                        alert("操作失败");
	                }
				})
			}else{alert("仔细阅读条款并同意");}
    	})

    	$(".pay_bill").click(function(){
    		var packageno = this.name;
    		$.ajax({
				type: "POST",
                url: "../Ashx/mystock.ashx?pay_bill=" + packageno,
                data: $("form").serialize(),
                datatype: "text",
                success: function (msg) {
                    if (msg == "yes") 
                        location.href="./PayBill.aspx?paypackageno="+packageno;
                }
			})
    	})

    	$(".cancel_delivery_action").click(function(){
    		if (confirm("确定要取消吗？") == true) {
    		var packageno = this.id.split("_")[1];
	    	$.ajax({
				type: "POST",
                url: "../Ashx/mystock.ashx?cancel_action=" + packageno,
                data: $("form").serialize(),
                datatype: "text",
                success: function (msg) {
                    if (msg == "yes") {
                        alert("取消分箱成功");
                        location.href="./MyStock.aspx?ordertype=delivery_waiting";
                        //$("#all_deliverys_waiting").load(location.href + " #all_deliverys_waiting>*");
                    }

                    if(msg == "no"){
                        alert("取消合箱成功");
                        location.href="./MyStock.aspx";
                    }
                }
			})	
	    	}
    	})

    	$(".submit_default_package").click(function(){
    		var packageno = this.name.split("_")[1];
    		$.ajax({
                type: "POST",
                url: "../Ashx/mystock.ashx?decount_deliveryno=" + packageno,
                data: $("form").serialize(),
                datatype: "text",
                success: function (msg) {
                    if (msg == "yes") {  
                		$(".submitpackage_" + packageno + ",.bj").show();
                    }
                }
            })
    	})

    	$(".submit_default_package").dblclick(function(){
    		var packageno = this.name.split("_")[1];
    		isReturnPackage(packageno);
    		$.ajax({
                type: "POST",
                url: "../Ashx/mystock.ashx?decount_deliveryno=" + packageno,
                data: $("form").serialize(),
                datatype: "text",
                success: function (msg) {
                    if (msg == "no") {
                		$(".button input[name='packagedefault_"+packageno+"']").css("background-color","grey");
                		$(".button input[name='packageexplain_"+packageno+"']").css("background-color","grey");
                		$(".button input[name='packageadd_"+packageno+"']").css("background-color","grey");
                    }
                }
            })
    	})

    	$(".save_d_package").click(function(){
			var packageno = this.name;
    		var connection_d_isspecial = IsSpecialWord($("input[name='connection_d_"+this.name+"']").val());	
			if(!connection_d_isspecial && $("input[name='connection_d_"+this.name+"']").val() == "")
				connection_d_isspecial = true ;
			if(!connection_d_isspecial){
				alert("输入的内容含有非法字符");
				return false;
			}
			if($("select[name='address_d_"+this.name+"'] option:checked").val() == 0){
				alert("请输入原箱的收货地址");
				return false;
			}
			if($("select[name='roadline_d_"+this.name+"'] option:checked").val() == 0){
				alert("请输入原箱的转运路线");
				return false;
			}
    		if($("#relation_input_16_"+packageno).is(":checked")){ 	
	    		$.ajax({
					type: "POST",
	                url: "../Ashx/mystock.ashx?submit_delivery_stock=" + packageno,
	                data: $("form").serialize(),
	                datatype: "text",
	                success: function (msg) {
	                    if (msg == "yes") {
	                        alert("提交成功");
	                        location.href="./MyStock.aspx?ordertype=delivery_waiting";
	                    }
	                }
				})
    		}else{alert("仔细阅读条款并同意");}
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
                url: "../Package/NewPackage.aspx?depotid="+depotid,
                data: $("form").serialize(),
                datatype: "text",
                success: function (data) {
                    var jsonData = eval("(" + data + ")");
                    //$("select[name='roadline_default'] option:gt(0)").remove();
                    for(var a=0; a<count; a++){
                    	$("select[name='roadline_explain']:eq("+a+") option:gt(0)").remove();
                    }
                    $.each(jsonData, function (i, k) {
                        var id = jsonData[i].ShippingId;
                        var name = jsonData[i].ShippingName;
                        //$('select[name="roadline_default"] option[value="0"]').after("<option value='" + id + "'>" + name + "</option>");
                    	for(var b=0; b<count; b++){                    		
                    		$('select[name="roadline_explain"]:eq('+b+') option[value="0"]').after("<option value='" + id + "'>" + name + "</option>");
                    	}
                    })
                }
            })
		})        

        $(".tui").click(function(){
    	var packageno = this.id.split("_")[1];
    	$.ajax({
				type: "POST",
                url: "../Ashx/mystock.ashx?isrefund_package="+packageno,
                data: $("form").serialize(),
                datatype: "text",
                success: function (msg) {
                    if (msg == "yes") {
                        $(".refund_"+packageno+",.bj").show()
                    }else
                    	alert("该包裹正在操作,或有运单存在");
                }
            })
		})
        
        $(".refund_submit_button_p").click(function(){
        	var packageno  = this.name.split("_")[1];
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
	                        location.href = "./MyStock.aspx";
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

        $(".news_redirect").click(function () {
            var newsid = this.id.split("_")[1];
            $.ajax({
                type: "POST",
                url: "../Ashx/common.ashx?atcid=" + newsid,
                data: $("form").serialize(),
                datatype: "html",
                success: function (msg) {
                	var jsonData = eval("(" + msg + ")");
                	$.each(jsonData, function (i, k) {
                		var NewsTime = eval('new ' + (jsonData.CreateTime.replace(/\//gi, '')));
                        $(".news-content-t").html(jsonData.Title);
                        $(".news-content-w").html("创建时间："+ NewsTime.getFullYear()+"-"+(NewsTime.getMonth()+1)+"-"+NewsTime.getDate());
                        $(".news-content-w1").html("作者："+jsonData.AuthorName);
                        $(".news-content-w2").html(jsonData.Content);
                    })
                }
            })
        })





})

			