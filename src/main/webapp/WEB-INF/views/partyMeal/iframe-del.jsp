<%@ page language="java" pageEncoding="UTF-8"
	import="java.util.*,java.io.*"%>
<%
	String id = request.getParameter("id");
	//  String pageNum=request.getParameter("pageNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp"%>
</head>
<style type="text/css">
html,body {
	background: #fff;
	overflow-x: hidden;
}
</style>

<script type="text/javascript">
$(function(){
	$("input.btn_blue").live("click",function(){
	});
	$("input.btn_gray").live("click",function(){
		$(window.parent.document).find(".shadow_bg").fadeOut().remove();
		$(window.parent.document).find(".popup_box").fadeOut().remove();
	});
/*-------jquery end-------*/
});	
var params = {};
var id="<%=id%>";
<%-- var pageNum="<%=pageNum%>"; --%>

$(function(){
	
	$(".btn_blue").click(function(){
		params.id=id;
		console.log(id);
		$("#deleteLogin").attr("disabled",true);
		$.ajax({
			url:"../meal/partyMeal/deletePartyMeal/"+id,
			type:"post",
			dataType:"json",
			headers: { 
				  'X-CSRF-TOKEN': '${_csrf.token}',
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    success:function(result){
		    	
		    console.log(result);
		     // alert("删除成功");
		     window.parent.location.href="../findView/partyMeal.partyMeal";
		    },
		    error:function(){
		    	alert("系统异常，删除失败！");
		    }
		});
	});
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