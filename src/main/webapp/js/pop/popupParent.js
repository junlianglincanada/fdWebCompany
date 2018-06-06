
function introFile(path, types){
	var fileref = "";
	if (types=="js"){
	  var fileref=document.createElement('script');
		  fileref.setAttribute("type","text/javascript");
		  fileref.setAttribute("src", path);
	}else if(types=="css"){ 
	  var fileref=document.createElement("link");
	  	  fileref.setAttribute("href", path);
		  fileref.setAttribute("rel", "stylesheet");
		  fileref.setAttribute("type", "text/css");
		  
	}
	if(typeof fileref!="undefined"){
	  	  document.getElementsByTagName("head")[0].appendChild(fileref);
	}
}
var filesAdded="";
function LoadCss(path, types){
	if(filesAdded.indexOf("["+path+"]")==-1){
	  	introFile(path, types);
	  	filesAdded+="["+path+"]"; 
	}else{
		throw new Error('file already added!');
	}
}
LoadCss("js/pop/popupParent.css", "css"); //动态加载css文件


/*-弹出提示控件*/
var popup = function(w,h,title,url){
	var html_b ='<div class="shadow_bg">' + '</div>';
	var html_c ='<div class="popup_box">' +
					    '<div class="popup_top">' + 
							  
							  '<a href="javascript:;" onclick="closed()" class="popup_closed" title="关闭">' + '<i class="i_closed">' + '</i>' + '</a>' +  
					    '</div>' +
						
				  '</div>';		   
	var popup_title = title
	var popup_link = url;
	$("body").append(html_b);
	$("body").prepend(html_c);

    var div_h4 = '<h4 class="popup_title">' + popup_title + '</h4>';
    var div_iframe = 	'<iframe src=\"' + popup_link +'\" scrolling="auto" frameborder="0" id="iframe_popup" name="iframe_popup" class="popup_iframe" allowtransparency="true">' + '</iframe>' ;
    $(".popup_top").prepend(div_h4);
    $(".popup_box").append(div_iframe);

    var winW = $(window).width(),
		winH = $(window).height();
	var anyW = (winW - w)/2 ;
	var anyH =  (winH - h)/3 ;
	var titH = $(".popup_top").height();
	$(".popup_box").css({width:w,height:h}); 
	$("iframe.popup_iframe").css({height:h - titH +"px"});
    Setpopup(anyW,anyH);
    $(".shadow_bg").show();
	$(".popup_box").show();
    return false; 
}

function closed(){
      $(".shadow_bg").hide().remove();
	  $(".popup_box").hide().remove();
	  $("iframe.popup_iframe").remove(); //解决IE下iframe冲突	  
	  return false; 
}

function Setpopup(anyW,anyH){
	$(".popup_box").css({left:anyW +"px",top:anyH +"px"}); 	
}

$(function(){	
	//缩动浏览器窗口控制	 
    $(window).on('resize',function(){
           setTimeout(function(){
	          var winW = $(this).width(),
				  winH = $(this).height();
			  var w = $(".popup_box").width(),
				  h = $(".popup_box").height();
			  var anyW = (winW - w)/2 , 
				  anyH =  (winH - h) /3 ;
	          Setpopup(anyW,anyH);
              
          }, 200);
          return false;
    });

});