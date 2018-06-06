<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*" %>
<%
    String id=request.getParameter("id");
    String pageNum=request.getParameter("pageNum"); 
    String importDate;
    if(request.getParameter("importDate")!=null&&request.getParameter("importDate")!="null"&&request.getParameter("importDate")!=""){
    	importDate=request.getParameter("importDate");
    }else{
    	importDate="";
    }
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
var pageNum="<%=pageNum%>";
var importDate="<%=importDate%>";
$(function(){
	
	$(".btn_blue").click(function(){
		params.id=id;
		console.log(id);
		$("#loading").show();
		$(":button").attr("disabled",true);
		$.ajax({
			url:"../outputManage/outputBatch/deleteImportFileList/"+id,
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
		     window.parent.location.href="../findView/replenish.parameter.outbatch?pageNum="+pageNum+"&importDate="+importDate+"";
		    	
		    },
		    error:function(){
		    }
		});
	});
});
</script>
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:100px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
  
<div class="ifr_box">
     <p class="ifr_text">将删除该文件对应的全部台账数据,是否确定删除?</p>
     <div class="ifr_btn">
          <input type="button" class="btn_blue" value="确定"/>
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>
</body>
</html>