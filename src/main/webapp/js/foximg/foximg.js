/*jQuery.foximg.js 查看大图片控件(旋转放大、缩小)*/

var DynamicLoading = {
    css: function(path){
		if(!path || path.length === 0){
			throw new Error('argument "path" is required !');
		}
		var head = document.getElementsByTagName('head')[0];
        var link = document.createElement('link');
	        link.href = path;
	        link.rel = 'stylesheet';
	        link.type = 'text/css';
        head.appendChild(link);
    },
    js: function(path){
		if(!path || path.length === 0){
			throw new Error('argument "path" is required !');
		}
		var head = document.getElementsByTagName('head')[0];
        var script = document.createElement('script');
	        script.src = path;
	        script.type = 'text/javascript';
        head.appendChild(script);
    }
}
/*DynamicLoading.css("../js/foximg/foximg.css");//动态加载 CSS 文件
DynamicLoading.js("../js/foximg/jquery-rotate-2.3.min.js");//动态js文件
DynamicLoading.js("../js/foximg/jquery.ui.js");*/

;(function($){
	$.fn.foximg = function(){
		var foximg_click=false;
	   /*---弹出大图控件--*/
	   var img_b ='<div class="shadow_bg">' + '</div>';
	   var img_c ='<div class="fox_img">'+
	  				'<div class="big_img">' +
							  
				    '</div>'+
				    '<a href="javascript:void(0)" class="img_closed" title="关闭">' + '<i>' + '</i>' + '</a>' +
					'<div class="foximg-buttons">'+
						  '<ul>'+// 添加左转右转按钮
						   	   '<li><a class="btnLeft" title="left" href="javascript:;">左转</a></li>'+
							   '<li><a class="btnToggle" title="Toggle size" href="javascript:;"></a></li>' +
			                   '<li><a class="btnRight" title="right" href="javascript:;">右转</a></li>'+
		                  '</ul>'+
	                 '</div>'+
				 '</div>';		   
	  function bigImg(options){ 
	   	 options.live('click',function(){
	   		if(foximg_click==true){
	   			return false;
	   		}
	   		foximg_click=true;
			  if($(this).children("img").attr("src")==null||$(this).children("img").attr("src")==""||$(this).children("img").attr("src")=="undefined"||$(this).children("img").attr("src")=="../images/no_user.png"){
				  foximg_click=false;
				  return false;
			  }
			  var orig_img = new Image();
		      orig_img.src = $(this).children("img").attr("src");
	   		img_time= window.setTimeout(function(){
	   			
			  var img_src = orig_img.src;
			  var img_w = orig_img.width,
			      img_h = orig_img.height; //console.log(img_src);
			  var winW = $(window).width(),	 
		          winH = $(window).height(),
	              winsW = winW*0.8,	 
		          winsH = winH*0.8;
			  
	          $("body").append(img_b);
			  $("body").prepend(img_c);
			  var div_img = '<img src=\"' + img_src +'\" id="imgdiv" name="imgdiv" class="imgdiv" style="width:100%;height:100%;" />' ;
			  $(".big_img").prepend(div_img);
			  
			  if(img_w > winsW ){
				   var anyW = (winW - winsW)/2 ;
				   $(".big_img").css({width:winsW,left:anyW +"px"}); 
			  }
			  if(img_h > winsH ){
				   var anyH = (winH - winsH)/3 ;
				   $(".big_img").css({height:winsH,top:anyH +"px"}); 
			  }
			  if(img_w <= winsW ){
				  var anyW = (winW - img_w)/2 ;
				  $(".big_img").css({width:img_w,left:anyW +"px"});
			  } 
			  if(img_h <= winsH ){
				   var anyH = (winH - img_h)/3 ;
				   $(".big_img").css({height:img_h,top:anyH +"px"});
			  }
			  
			  $(".shadow_bg").fadeIn();
			  $(".fox_img").fadeIn();

              //关闭
			  $('.img_closed').on('click',function(){
					closedImg();
			  });
	          
			  //单击左转
			  $('.btnLeft').on('click',function(){
			        rotateLeft();
			  }); 
			  //单击右转
			  $('.btnRight').on('click',function(){
			        rotateRight();
			  });

			 //缩放大小★
			  var img_sw = $(".big_img").width(),
	      	   	  img_sh = $(".big_img").height(),
	      	   	  any_sw = $(".big_img").position().left,
	      	   	  any_sh = $(".big_img").position().top; 
			  console.log(img_sw);
	      	   	console.log(any_sh);
	          $('.btnToggle').on('click',function(){
			       if(!$(this).hasClass('btnToggleOn')){
				   	   $(this).addClass('btnToggleOn');
				   	   $(".big_img").draggable({ disabled:false, cursor:"move"});  
				   	    var anyW = (winW - img_w)/2 ,
				   	        anyH = (winH - img_h)/3 ;
						  console.log(anyW);
				      	   	console.log(anyH);
				   	   $(this).closest(".fox_img").find(".big_img").css({"width":img_w+'px',"height":img_h+'px',"left":anyW+'px',"top":anyH+'px'});
				   }else{
				   	   $(this).removeClass('btnToggleOn');
				   	   $(".big_img").draggable({ disabled:false, revert:false});
				   	   $(this).closest(".fox_img").find(".big_img").css({"width":img_sw+'px',"height":img_sh+'px',"left":any_sw+'px',"top":any_sh+'px'});
				   }		             
			  });
	        //点击空白区域关闭弹窗
	   	   $(document).on("click",function(e){
	   		   e.stopPropagation(); 
	   		   var Darea = $(".big_img"),
	   		   	   Dareb = $(".foximg-buttons");   // 设置目标区域
	   		   if(!Darea.is(e.target) && Darea.has(e.target).length === 0 && !Dareb.is(e.target) && Dareb.has(e.target).length === 0){
	   			  $(".shadow_bg").fadeOut().remove();
	   			  $(".fox_img").fadeOut().remove();									  
	   		   }											
	   	    });
			  return false; 
	   		},100);
	   		foximg_click=false;
		  });
	   }

		//按钮关闭(Chrome上iframe内的按钮关闭必须在服务器上运行)
		var closedImg = function(){
			  $(".shadow_bg").fadeOut().remove();
			  $(".fox_img").fadeOut().remove();	
		};

		var rad = 0;
		//左转单击事件
		function rotateLeft() {
		    rad = rad - 90;
		    if (rad == -360) {
		        rad = 0;
		    }
		    $(".big_img").rotate(rad);
		}
		//右转单击事件
		function rotateRight() {
		    rad = rad + 90;
		    if (rad == 360) {
		        rad = 0;
		    }
		    $(".big_img").rotate(rad);
		}
		
		//缩动窗口控制	 
		$(window).resize(function(){
	         var winW = $(window).width(),winH = $(window).height();
			 var anyW = (winW - $(".fox_img").width())/2 ,anyH = (winH - $(".fox_img").height())/3 ;
			 $(".fox_img").css({left:anyW +"px",top:anyH +"px"});
			 $(".shadow_bg").fadeIn();
			 $(".fox_img").fadeIn();
              return false; 
	   });	

	   //初始化
		var init = function(_this){ 
			//console.log(eval(_this));
	 		bigImg(_this);
		};
		init($(this));
        return this;

	};
})(jQuery);

