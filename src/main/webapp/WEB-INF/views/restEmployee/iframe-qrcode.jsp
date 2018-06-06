<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<%
String name=request.getParameter("name");
name=java.net.URLDecoder.decode(name, "UTF-8");
String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../include.jsp" %>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>
<script src="../js/jquery.qrcode.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
var id="<%=id%>"
var name="<%=name%>";
$(function(){
	//弹出窗口宽高控制					   
	function iframe_wh(){	
		var par_W = $(window.parent.document).width();
		var ifr_W = $(window.document).find(".ifr_box").width();
		var pos_W = (par_W - ifr_W)/2 ; 
		$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"490px",left:pos_W +"px",top:25 +"px"});
		$(window.parent.document).find(".popup_iframe").css({height:"442px"});
		
	    $(window).resize(function(){ //对浏览器窗口调整大小进行计数
			var par_W = $(window.parent.document).width();
			var ifr_W = $(window.document).find(".ifr_box").width();
			var pos_W = (par_W - ifr_W)/2 ; 
			$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"490px",left:pos_W +"px",top:25 +"px"});
			$(window.parent.document).find(".popup_iframe").css({height:"442px"});
			return false;
		});
	};
	iframe_wh(); //计算窗口宽度高度的函数
	$('.qrcode_img').qrcode({
		render:"canvas", //设置渲染方式 canvas或table 
		width:248,     //设置宽度  
		height:248,    //设置高度   
		background:"#ffffff", //背景颜色  
		foreground:"#000000", //前景颜色
		text:JSON.stringify({"companyId":<%=SecurityUtils.getCurrentUserCompanyId()%>,"type":"EMP","id":<%=id%>}) //二维码内容 
   });
})
</script>
</head>
<body>
<div class="ifr_box" style="width:480px;padding:0;">
     <div class="qrcode_box">
          <div class="qrcode_img"></div>
          <p class="qrcode_blue"><%=name%></p>
          <p class="qrcode_ts">提示：使用本网站配套的手机软件扫描二维码，可以上传票据或证照图片</p>
     </div>
</div>
</body>
</html>