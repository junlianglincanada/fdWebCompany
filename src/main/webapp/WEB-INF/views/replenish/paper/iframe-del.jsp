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
function deleteImageList(attachId){		
	restIdList=[];
 	restIdList.push(attachId);
 	$("#loading").show();
	$.ajax({
		url:"../inputManage/inputReceipt/delInputReceipt",
		type:"post",
	    headers: { 
	    	  'X-CSRF-TOKEN': '${_csrf.token}',
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
	    data:JSON.stringify(restIdList),
		success:function(text) {
			$("#loading").hide();
	          if(text.status==0){
	        	  window.parent.location.href="../findView/replenish.paper.paper1";
	        	   $("#delectImg").parent("div").find("img").attr("src","");
	        	   $("#delectImg").parent("div").hide(); 
	        	   $("#delectImg").parent().parent().find("input:file").val("");
	          }
		 },   
		 error:function(text) {
			 $("#loading").hide();
		 return false;
		 }
		});
	
}
$(function(){
	//确定按钮操作
	$(".btn_blue").click(function(){
		$(":button").attr("disabled",true);
		deleteImageList(id);
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
     <p class="ifr_text">是否确定删除？</p>
     <div class="ifr_btn">
          <input type="button" class="btn_blue" value="确定"/>
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>
</body>
</html>