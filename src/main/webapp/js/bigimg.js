//$(function(){
//		   
//   /*---弹出大图片控件--*/
//	  var img_b ='<div class="shadow_bg">' + '</div>';
//	  var img_c ='<div class="big_img">' +
//							  
//					   '<a href="javascript:void(0)" class="img_closed" title="关闭">' + '<i>' + '</i>' + '</a>' +
//				  '</div>';		   
//     $("div[rel^='img']").live("click",function(){ //工程上动态生成的使用live或on绑定事件
//		  var orig_img = new Image();
//		       orig_img.src = $(this).children("img").attr("src");
//		  var img_src = orig_img.src;
//		  var img_w = orig_img.width,
//		      img_h = orig_img.height;
//		  var winW = $(window).width(),	 
//	          winH = $(window).height(),
//              winsW = winW*0.8,	 
//	          winsH = winH*0.8;
//		  
//          $("body").append(img_b);
//		  $("body").prepend(img_c);
//		  var div_img = '<img src=\"' + img_src +'\" id="imgdiv" name="imgdiv" class="imgdiv" style="width:100%;height:100%;" />' ;
//		  $(".big_img").prepend(div_img);
//		  
//		  if(img_w > winsW ){
//			   var anyW = (winW - winsW)/2 ;
//			   $(".big_img").css({width:winsW,left:anyW +"px"});  
//		  }
//		  if(img_h > winsH ){
//			   var anyH = (winH - winsH)/3 ;
//			   $(".big_img").css({height:winsH,top:anyH +"px"});  
//		  }
//		  if(img_w <= winsW ){
//			  var anyW = (winW - img_w)/2 ;
//			  $(".big_img").css({width:img_w,left:anyW +"px"});
//		  } 
//		  if(img_h <= winsH ){
//			   var anyH = (winH - img_h)/3 ;
//			   $(".big_img").css({height:img_h,top:anyH +"px"});
//		  }
//		  
//		  $(".shadow_bg").fadeIn();
//		  $(".big_img").fadeIn();
//  
//		  return false; 
//
//    });
//
//	//点击按钮关闭(Chrome上iframe内的按钮关闭必须在服务器上运行)
//	$("a.img_closed").live("click",function(){
//			  $(".shadow_bg").fadeOut().remove();
//			  $(".big_img").fadeOut().remove();
//			
//	});
//	
//	//缩动窗口控制	 
//	if($.browser.msie && ("6.0,7.0".indexOf($.browser.version) != -1)){	
//		    $("html,body,.shadow_bg").resize(function(){
//			         var winW = $(window).width(),	 
//				         winH = $(window).height();
//					 var anyW = (winW - $(".big_img").width())/2 , 
//					     anyH = (winH - $(".big_img").height())/3 ;
//					 $(".big_img").css({left:anyW +"px",top:anyH +"px"});
//					 $(".shadow_bg").fadeIn();
//					 $(".big_img").fadeIn();
//		    });  
//	}else{
//			$(window).resize(function(){
//			         var winW = $(window).width(),	 
//				         winH = $(window).height();
//					 var anyW = (winW - $(".big_img").width())/2 , 
//					     anyH = (winH - $(".big_img").height())/3 ;
//					 $(".big_img").css({left:anyW +"px",top:anyH +"px"});
//					 $(".shadow_bg").fadeIn();
//					 $(".big_img").fadeIn();
//                      return false; 
//		   });	
//	};
//	
// /*---jquery end---*/    
//});	