<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
.select_s{width:182px; float:left;}
.select_is{width:182px;}
select.select_cs{width:212px; background-position:-16px -122px;}
table.table_list td.td_oper{text-align:left;}
</style>
<script type="text/javascript">
$(function(){
	$.ajax({
		url:"../company/getHeadquartersInfo",
		type:"get",
		success:function(result){
			if(result.status==0){
				var companyName=isnull(result.body.companyName);
				var companyId=isnull(result.body.companyId);
				$("#companyName").text(companyName);
				$(".assoc_text").find("a").attr("link","chain.mainten.iframe-rassoc?id="+companyId);
			}
		}
	});
});
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="javascript:void(0)">门店管理</a>  </h3>
          <div class="assoc_text">本单位已与“<span id="companyName"></span>”建立了连锁管理关系。<a href="javascript:void(0)" rel="popup" link="" title="提示">解除关联</a></div>
     </div>
</div>      
</body>
</html>