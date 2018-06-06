<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
  <%@ include file="../include.jsp" %>
<script type="text/javascript">
function countUnread(){
	$.ajax({
		url: "../publishContent/countUnreadContent",
		type:"get",
		success:function(result){
			if(result.status==0){
				$(".i_num").show();
				var publishment = result.body.publishment;
				var notification = result.body.notification;
				var total = parseInt(publishment)+parseInt(notification);
				$(".i_num").text(total);
				if(total == 0){
					$(".i_num").hide();
				}
			}
		}
	});
}
$(function(){
	countUnread();
   //点击退出登录弹出提示框
	var html_b ='<div class="shadow_bg">' + '</div>';
	var html_c ='<div class="popup_box">' +
					    '<div class="popup_top">' + 
							  
							  '<a href="javascript:void(0)" class="popup_closed" title="关闭">' + '<i class="closed">' + '</i>' + '</a>' +  
					    '</div>' +
						
				  '</div>';		   
    $("a[rel='popup']").bind("click",function(){ 
		  var popup_title = $(this).attr("title"); // var popup_title = $(this).val() || $(this).text();
		  var popup_link = $(this).attr("link");

		  $(window.parent.parent.frames["mainFrame"].document).find("body").append(html_b);
		  $(window.parent.parent.frames["mainFrame"].document).find("body").prepend(html_c);
		  
		  var div_h4 = '<h4 class="popup_tit">' + popup_title + '</h4>';
		  var div_iframe = 	'<iframe src=\"' + popup_link +'\" scrolling="auto" frameborder="0" id="iframe_popup" name="iframe_popup" class="popup_iframe" allowtransparency="true">' + '</iframe>' ;
		  
		  $(window.parent.parent.frames["mainFrame"].document).find(".popup_top").prepend(div_h4);
		  $(window.parent.parent.frames["mainFrame"].document).find(".popup_box").append(div_iframe);

		  var winW = $(window.parent.parent.frames["mainFrame"].document).width();	 
	      var winH = $(window.parent.parent.frames["mainFrame"].document).height();
		  /*弹出框在窗口上的横向位置*/
		  var anyW = (winW - $(window.parent.parent.frames["mainFrame"].document).find(".popup_box").width() )/2 ; 
		  /*弹出框在窗口上的纵向位置*/
		  //var anyH =( $(window).scrollTop() + (winH - $(".popup_box").height() ) ) /3 ;
		  var anyH=120;
		  //var anyH =  ( winH - $(window.parent.parent.frames["mainFrame"].document).find(".popup_box").height() ) /3 ;
		  $(window.parent.parent.frames["mainFrame"].document).find(".popup_box").css({left:anyW +"px",top:anyH +"px"}); 
          
		  $(window.parent.parent.frames["mainFrame"].document).find(".shadow_bg").fadeIn();
		  $(window.parent.parent.frames["mainFrame"].document).find(".popup_box").fadeIn();
  
		  return false; 

    });

	
	//缩动窗口控制	 
	if($.browser.msie && ("6.0,7.0".indexOf($.browser.version) != -1)){	
		    $("html,body,.shadow_bg").resize(function(){
			         var winW = $(window.parent.parent.frames["mainFrame"].document).width();	 
					 var winH = $(window.parent.parent.frames["mainFrame"].document).height();
					 var anyW = (winW - $(window.parent.parent.frames["mainFrame"].document).find(".popup_box").width() )/2 ; 
					 var anyH = ( $(window.parent.parent.frames["mainFrame"].document).scrollTop() + (winH - $(window.parent.parent.frames["mainFrame"].document).find(".popup_box").height() ) ) /3 ;
					 $(window.parent.parent.frames["mainFrame"].document).find(".popup_box").css({left:anyW +"px",top:anyH +"px"}).fadeIn(); 
					 $(window.parent.parent.frames["mainFrame"].document).find(".shadow_bg").fadeIn();
		    });  
	}else{
			$(window).resize(function(){
			          var winW = $(window.parent.parent.frames["mainFrame"].document).width();	 
					  var winH = $(window.parent.parent.frames["mainFrame"].document).height();
					  var anyW = (winW - $(window.parent.parent.frames["mainFrame"].document).find(".popup_box").width() )/2 ; 
					  var anyH=120;
					  //var anyH = ( winH - $(window.parent.parent.frames["mainFrame"].document).find(".popup_box").height() ) /3 ;
					  $(window.parent.parent.frames["mainFrame"].document).find(".popup_box").css({left:anyW +"px",top:anyH +"px"}).fadeIn(); 
					  $(window.parent.parent.frames["mainFrame"].document).find(".shadow_bg").fadeIn();
                      return false; 
		   });	
	};
	
	
});	
</script> 
</head>
<body>
<div class="header">
     <div class="head_lf">
          <h1 class="head_logo" title="上海市餐饮食品安全信息追溯系统"><a  target="_top">上海市餐饮食品安全信息追溯系统</a></h1>
          <p class="hlf_text">
             <span><a href="../findView/system.account.account-view" target="mainFrame"><%=SecurityUtils.getCurrentUserCompanyName() %></a></span>
             <span><a href="../findView/personal.personal" target="mainFrame"><%=SecurityUtils.getCurrentUserRealName() %></a></span>
          </p>
     </div>
     <div class="head_rt">
           <a href="javascript:void(0);" rel="popup" link="../findView/frame.iframe-exit" title="提示">
             <i class="i_exit"></i>
             <span>退出登录</span>
          </a>
          <a href="../findView/consult.consult" target="mainFrame">
             <i class="i_consult"></i>
             <span>咨询帮助</span>
          </a>	
          <a href="javascript:void(0);" rel="popup" link="../findView/publishContent.iframe-message" title="提示">
             <i class="i_msg"></i>
             <span>消息</span>
             <em class="i_num">0</em>
          </a>
     </div>     
</div>   
</body>
</html>