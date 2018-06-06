$(function(){
    /*-弹出提示控件*/
	  var html_b ='<div class="shadow_bg">' + '</div>';
	  var html_c ='<div class="popup_box">' +
					    '<div class="popup_top">' + 
							  
							  '<a href="javascript:void(0)" class="popup_closed" title="关闭">' + '<i class="closed">' + '</i>' + '</a>' +  
					    '</div>' +
						
				  '</div>';		   
    $("input[rel='popup'],a[rel='popup']").live("click",function(){ //项目工程上需用live方法
		  var popup_title = $(this).attr("title"); // var popup_title = $(this).val() || $(this).text();
		  var popup_link = $(this).attr("link");
		  
          $("body").append(html_b);
		  $("body").prepend(html_c);
		  
		  var div_h4 = '<h4 class="popup_tit">' + popup_title + '</h4>';
		  var div_iframe = 	'<iframe src=\"' + popup_link +'\" scrolling="auto" frameborder="0" id="iframe_popup" name="iframe_popup" class="popup_iframe" allowtransparency="true">' + '</iframe>' ;
		  
		  $(".popup_top").prepend(div_h4);
		  $(".popup_box").append(div_iframe);

		  var winW = $(window).width();	 
	      var winH = $(window).height();
		  /*弹出框在窗口上的横向位置*/
		  var anyW = (winW - $(".popup_box").width() )/2 ; 
		  /*弹出框在窗口上的纵向位置*/
		  //var anyH =( $(window).scrollTop() + (winH - $(".popup_box").height() ) ) /3 ;
		  var anyH =  ( winH - $(".popup_box").height() ) /3 ;
		  $(".popup_box").css({left:anyW +"px",top:anyH +"px"}); 
          
		  $(".shadow_bg").fadeIn();
		  $(".popup_box").fadeIn();
  
		  return false; 

    });
    
    
	  var html_qrcode ='<div class="popup_box" style="width:480px;height:450px;">' +
				  '</div>';		   
    $("input[rel='popup_qrcode'],a[rel='popup_qrcode']").live("mouseover mouseout",function(event){
    	if(event.type=="mouseover"){
    	  $(".popup_box").remove();
          var popup_link = $(this).attr("link");
          var m=popup_link.split("_");
     /*     console.log(m[0],m[1],m[2],m[3]);*/
  		  $("body").prepend(html_qrcode);
  		  $(".popup_box").append('<div class="ifr_box" style="width:480px;padding:0;">'
  				  	+'<div class="qrcode_box"><div class="qrcode_img"></div>'
  				  	+' <p class="qrcode_blue">'+m[1]+'</p>'
  				  	+' <p class="qrcode_ts">提示：使用本网站配套的手机软件扫描二维码，可以上传票据或证照图片</p>'
  				  	+' </div>'
  				  	+'</div>');
    		$('.qrcode_img').qrcode({
      			render:"canvas", //设置渲染方式 canvas或table 
      			width:248,     //设置宽度  
      			height:248,    //设置高度   
      			background:"#ffffff", //背景颜色  
      			foreground:"#000000", //前景颜色
      			text:JSON.stringify({"companyId":m[0],"type":m[3],"id":m[2]}) //二维码内容 
      	   });
  		  var winW = $(window).width();	 
  	      var winH = $(window).height();
  		  /*弹出框在窗口上的横向位置*/
  		  var anyW = (winW - $(".popup_box").width() )/2 ; 
  		  var anyH =  ( winH - $(".popup_box").height() ) /3 ;
  		  $(".popup_box").css({left:anyW +"px",top:anyH +"px"}); 
  		  $(".popup_box").show();
    	}else{
    		$(".popup_box").remove();
    	}
    });

	//点击按钮关闭(Chrome上iframe内的按钮关闭必须在服务器上运行)
	$("a.popup_closed").live("click",function(){
			  $(".shadow_bg").fadeOut().remove();
			  $("#iframe_popup").remove(); //解决IE下iframe冲突
			  $(".popup_box").fadeOut().remove();
			  if($.browser.msie) { 
                  CollectGarbage();	//IE下清缓存
              }  
			  return true; 
	});
	
	//缩动窗口控制	 
	if($.browser.msie && ("6.0,7.0".indexOf($.browser.version) != -1)){	
		    $("html,body,.shadow_bg").resize(function(){
			         var winW = $(window).width();	 
					 var winH = $(window).height();
					 var anyW = (winW - $(".popup_box").width() )/2 ; 
					 var anyH = ( $(window).scrollTop() + (winH - $(".popup_box").height() ) ) /3 ;
					 $(".popup_box").css({left:anyW +"px",top:anyH +"px"}).fadeIn(); 
					 $(".shadow_bg").fadeIn();
		    });  
	}else{
			$(window).resize(function(){
			          var winW = $(window).width();	 
					  var winH = $(window).height();
					  var anyW = (winW - $(".popup_box").width() )/2 ; 
					  var anyH = ( winH - $(".popup_box").height() ) /3 ;
					  $(".popup_box").css({left:anyW +"px",top:anyH +"px"}).fadeIn(); 
					  $(".shadow_bg").fadeIn();
                      return false; 
		   });	
	};
	
 /*---jquery end---*/    
});	