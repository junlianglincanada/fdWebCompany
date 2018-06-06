<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*" %>
<%

    String id=request.getParameter("id");
	String pageNum=request.getParameter("pageNum");
	String outputDate2;
	    if(request.getParameter("outputDate2")!=null&&request.getParameter("outputDate2")!="null"&&request.getParameter("outputDate2")!=""){
	    	outputDate2=request.getParameter("outputDate2");
	    }else{
	    	outputDate2="";
	    }
	String materialName2;
	    if(request.getParameter("materialName2")!=null&&request.getParameter("materialName2")!="null"&&request.getParameter("materialName2")!=""){
	  	  materialName2=java.net.URLDecoder.decode(request.getParameter("materialName2"), "UTF-8");
	    }else{
			materialName2="";
	    }
	String receiverName2;
	    if(request.getParameter("receiverName2")!=null&&request.getParameter("receiverName2")!="null"&&request.getParameter("receiverName2")!=""){
	    	receiverName2=java.net.URLDecoder.decode(request.getParameter("receiverName2"), "UTF-8");
	    }else{		
	    	receiverName2="";
	    }	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
</head>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>
<%@ include file="../../include.jsp" %>
<script type="text/javascript">
var params = {};
var id="<%=id%>";
var pageNum=<%=pageNum%>;
var outputDate2="<%=outputDate2%>";
var materialName2="<%=materialName2%>";
var receiverName2="<%=receiverName2%>";
function toDelete(params){
	$.ajax({
		url:"../outputManage/outputBatch/deleteOutputBatch/"+id,
		type:"post",
		data:JSON.stringify(params),
		dataType:"json",
		headers: { 
			  'X-CSRF-TOKEN': '${_csrf.token}',
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    success:function(result){
	    	
	    	//alert("删除成功！");
	    	window.parent.location.href="../findView/replenish.parameter.outParameter?pageNum="+pageNum+"&outputDate2="+outputDate2+"&materialName2="+encodeURI(encodeURI(materialName2))+"&receiverName2="+encodeURI(encodeURI(receiverName2))+"";
	    },
	    error:function(){
	    	alert("系统异常，删除失败！");
	    }
	});
}
$(function(){
	$(".btn_blue").click(function(){
		$.ajax({
			url:"../outputManage/outputBatch/getOutputBatchById/"+id,
			type:"get",
			data:JSON.stringify(params),
			dataType:"json",
			headers: { 
				  'X-CSRF-TOKEN': '${_csrf.token}',
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
	$("input.btn_gray").live("click",function(){
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