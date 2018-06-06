<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false"%>
 <%
    String id=request.getParameter("id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8"/>
<%@ include file="../../include.jsp" %>
<title>上海市餐饮食品安全信息追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>
 <script type="text/javascript">
 $(document).ready(function(){
	   //弹出窗口宽度控制					   
	   function iframe_w(){	
			var par_W = $(window.parent.document).width();
			var ifr_W = $(window.document).find("#img_ts1").width();
			var pos_W = (par_W - ifr_W)/2 ; 
			//alert(par_W);
			$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",left:pos_W +"px"});		
	  	    $(window).resize(function(){ //对浏览器窗口调整大小进行计数
	    			  var par_W = $(window.parent.document).width();
	    			  var ifr_W = $(window.document).find("#img_ts1").width();
	    			  var pos_W = (par_W - ifr_W)/2 ;  
	    			  $(window.parent.document).find(".popup_box").css({width:ifr_W +"px",left:pos_W +"px"});
	    			  return false;
	  		  });	  
		};
	  var href = $(window.parent.document).find("#iframe_popup").attr("src");
	  var name = href.substring(href.lastIndexOf('=')+1,href.length),//截取最后一个=后面的
	      IDname = "#"+name;
	  $(window).load(function(){ 
	     //alert(IDname);
	     $(IDname).css({"display":"block"});
	     if(IDname == "#gs"){
	        $("#img_ts1").css({"display":"block"});
	        iframe_w();
	     }  
	  });
	});	
var id="<%=id%>";
//alert(id);
$(function(){
	if(id=="gs"){
		   $(".img_ts").hide();
	       $("#img_ts1").show(); 
	   }else if(id=="jy"){
		   $(".img_ts").hide();
	       $("#img_ts2").show(); 
	   }else if(id=="sc"){
		   $(".img_ts").hide();
	       $("#img_ts3").show(); 
	   }else if(id=="lt"){
		   $(".img_ts").hide();
	       $("#img_ts4").show(); 
	   }else {
		   $(".img_ts").hide();
		   $("#img_ts5").show(); 
	   }
});
</script>
</head>
<body>
<div class="img_box">
     <div class="img_ts" id="img_ts1" style="width:740px;display:none">
          <img src="../images/reg_f11.jpg"/>
          <p>工商营业执照 （旧版15位）， 请填写此字段</p>
          <img src="../images/reg_f12.jpg"/>
          <p>工商营业执照 （新版18位）， 请填写此字段</p>  
     </div>
     <div class="img_ts" id="img_ts2" style="display:none">
          <img src="../images/reg_f2.jpg"/>
          <p>食品经营许可证 请填写此字段</p>
     </div>
     <div class="img_ts" id="img_ts3" style="display:none">
          <img src="../images/reg_f3.jpg"/>
          <p>食品生产许可证 请填写此字段</p>
     </div>
     <div class="img_ts" id="img_ts4" style="display:none">
          <img src="../images/reg_f4.jpg"/>
          <p>食品流通许可证 请填写此字段</p>
     </div>
     <div class="img_ts" id="img_ts5" style="display:none">
          <img src="../images/reg_f5.jpg"/>
          <p>餐饮服务许可证 请填写此字段</p>
     </div>
</div>
</body>
</html>