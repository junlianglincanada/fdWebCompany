<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
</head>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>
<script type="text/javascript">
var params = {};
var id="<%=id%>";
function toDelete(params){
	$.ajax({
		url:"../outputManage/outputBatch/updateOutputBatch",
		type:"post",
		data:JSON.stringify(params),
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    success:function(result){
	    	//alert("删除成功！");
	    	$(":button").attr("disabled",false);
	    	$("#loading").hide();
	    	window.parent.location.href="../findView/replenish.send.output-add";
	    },
	    error:function(){
	    	$("#loading").hide();
       	 alert("删除失败,已关联其他数据");
       	window.parent.location.href="../findView/replenish.send.output-add";
	    }
	});
}
$(function(){
	$(".btn_blue").click(function(){
		$(":button").attr("disabled",true);
		$("#loading").show();
		$.ajax({
			url:"../outputManage/outputBatch/getOutputBatchById/"+id,
			type:"get",
			data:JSON.stringify(params),
			dataType:"json",
			headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    success:function(result){
		    	var dto=result.body;
		    	var id=dto.id;
				var outputDate=dto.outputDate;
				var quantity=dto.quantity;
				var productionDate=dto.productionDate;
				var productionBatch=dto.productionBatch;
				var receiverId=dto.receiverId;
		        var delFlag=0;
		        params.receiverId=receiverId;
			    params.id=id;
				params.outputDate=outputDate;
				params.quantity=quantity;
				params.productionDate=productionDate;
				params.productionBatch=productionBatch;
				params.delFlag=delFlag;
				toDelete(params);
		    	
		    },
		    error:function(){
		    	alert("系统异常，查询失败！");
		    }
		});
	});
	$(".btn_gray").click(function(){
		$(window.parent.document).find(".shadow_bg").fadeOut().remove(); 
	      $(window.parent.document).find(".popup_box").fadeOut().remove();
	});
	
});
</script>
</head>
<body>
<div class="ifr_box">
     <p class="ifr_text">是否确认删除？</p>
     <div class="ifr_btn">
          <input type="button" class="btn_blue" value="确定" />
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>
</body>
</html>