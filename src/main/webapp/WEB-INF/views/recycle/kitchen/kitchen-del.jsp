<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"  import="java.util.*,java.io.*"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp"%>	
</head>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>
<script type="text/javascript">
var id="<%=id%>";
$(function(){
	//确定按钮操作
	$(".btn_blue").click(function(){
		$(":button").attr("disabled",true);
		$("#loading").show();
		$.ajax({
			url:"../restaurant/cleanWasteComMgr/deleteWasteRecycleRecord/"+id,
			type:"get",
			success:function(result){
				window.parent.location.href="../findView/recycle.kitchen.kitchen";
				$(":button").attr("disabled",false);
	         if(result.status==0){
	        	 $("#loading").hide();
	        	 $(window.parent.document).find("#"+id+"").remove();
	        	 $(window.parent.document).find(".shadow_bg").fadeOut().remove();
		     	 $(window.parent.document).find(".popup_box").fadeOut().remove();
				}
	         if(result.status==1){
	        	 $("#loading").hide();
	        	 window.parent.alert("删除失败");
	        	 $(window.parent.document).find(".shadow_bg").fadeOut().remove();
	     		$(window.parent.document).find(".popup_box").fadeOut().remove();
	         } 
			},
			error:function(){
				 window.parent.alert("系统异常,删除失败");
				 $(window.parent.document).find(".shadow_bg").fadeOut().remove();
		     	 $(window.parent.document).find(".popup_box").fadeOut().remove();
		    	$("#loading").hide();
				}
		});
	});
	//取消按钮操作
	$("input.btn_gray").live("click",function(){
		$(window.parent.document).find(".shadow_bg").fadeOut().remove();
		$(window.parent.document).find(".popup_box").fadeOut().remove();
	});
});
</script>
</head>
<body>
 <div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="ifr_box">
     <p class="ifr_text">是否确认删除？</p>
     <div class="ifr_btn">
          <input type="button" class="btn_blue" value="确定"/>
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>
</body>
</html>