<%@ page language="java" pageEncoding="UTF-8"%>
<%
   
String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
</head>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>

<script type="text/javascript">

var id="<%=id%>";
$(function(){
	$("input.btn_blue").live("click",function(){
		
		
		$("#loading").show();
		 $("#deleteLogin").attr("disabled",true);
		 
		 $.ajax({
			 
				url: "../restaurant/oilCleanComMgr/clean/deleteCleanWasteRecycleCom/"+id,
				type:"get",
			    headers: { 
			        'Accept': 'application/json',
			        'Content-Type': 'application/json' 
			    },
			   
				success:function(str) {
					
					if(str.status==0){
						//alert("删除成功");
						window.parent.location.href="../findView/recycle.unit.unit";					
					}			       
				 },   
				 error:function() {
					 alert("系统异常，删除失败！");
					 	$("#loading").hide();
				 }
				});
	});
	$("input.btn_gray").live("click",function(){
		$(window.parent.document).find(".shadow_bg").fadeOut().remove();
		$(window.parent.document).find(".popup_box").fadeOut().remove();
	});
/*-------jquery end-------*/
});	
</script>
</head>
<body>
<div class="ifr_box">
     <p class="ifr_text">是否确认删除？</p>
     <div class="ifr_btn">
          <input id="deleteLogin" type="button" class="btn_blue" value="确定" />
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>
</body>
</html>