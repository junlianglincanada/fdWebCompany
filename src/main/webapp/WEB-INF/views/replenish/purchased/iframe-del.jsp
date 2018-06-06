<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/popup.js" type="text/javascript"></script>	
<script type="text/javascript">
var id="<%=id %>";
$(function(){
	$("input.btn_blue").live("click",function(){
		$("#loading").show();
		 $("#deleteinput").attr("disabled",true);
		$.ajax({
			url:"../inputManage/inputMaterial/deleteInputMaterial/"+id,
			type:"get",
		    headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    dataType:'json',
			success:function(result){
				if(result.status==0){
				
					window.parent.location.href="../findView/replenish.purchased.purchased";
				}
			},
			error:function(){
				alert("系统异常,删除失败");
				 $("#deleteinput").attr("disabled",false);
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
          <input id="deleteinput" type="button" class="btn_blue" value="确定" />
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>
</body>
</html>