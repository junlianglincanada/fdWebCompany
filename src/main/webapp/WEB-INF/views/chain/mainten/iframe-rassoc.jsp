<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>
<script type="text/javascript">
var id="<%=id %>";
$(function(){
	$("input.btn_blue").live("click",function(){
		$("#loading").show();
		$(":button").attr("disabled",true);
		$.ajax({
			url:"../comRelationship/relationship/removeLinkToTrunk/"+id,
			type:"post",
			success:function(result){
				$(":button").attr("disabled",false);
				if(result.status==0){
					$("#loading").hide();
					window.top.location.href="../default.do";
				}else{
					window.parent.alert(result.message);
					$("#loading").hide();
					$(window.parent.document).find(".shadow_bg").fadeOut().remove();
					$(window.parent.document).find(".popup_box").fadeOut().remove();
				}
			},
			error:function(){
				alert("系统异常,删除失败");
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
     <p class="ifr_text">你确定解除关联关系吗？</p>
     <div class="ifr_btn">
          <input type="button" class="btn_blue" value="确定" />
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>
</body>
</html>