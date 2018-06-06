<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
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
		 $("#deleteoutput").attr("disabled",true);
		$.ajax({
			url:"../outputManage/outputMaterial/deleteOutputMaterial/"+id,
			type:"get",
		    headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    dataType:'json',
			success:function(result){
				if(result.status==0){
					window.parent.location.href="../findView/distribute.output.output";
				}
			},
			error:function(){
				alert("系统异常,删除失败");
				 $("#deleteoutput").attr("disabled",false);
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
          <input id="deleteoutput" type="button" class="btn_blue" value="确定" />
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>
</body>
</html>