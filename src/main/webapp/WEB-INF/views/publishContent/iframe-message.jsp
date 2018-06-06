<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<html>
<head>
<meta charset="utf-8">
<title>上海市餐饮食品安全信息追溯系统</title>
<%@ include file="../include.jsp"%>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>
<script type="text/javascript">
$(function(){
	$.ajax({
		url: "../publishContent/countUnreadContent",
		type:"get",
		success:function(result){
			if(result.status==0){
				var publishment = result.body.publishment;
				var notification = result.body.notification;
				$("#publishment").text(publishment);
				$("#notification").text(notification);
			}
		}
	});
});	
</script>
</head>
<body>
<div class="ifr_box">
	 <h4 class="msg_tit">您有未读新消息：</h4>
     <p class="ifr_text">通知公告<a href="../findView/publishContent.publishContent?newSearch=1" class="msg_num" target="mainFrame" id="publishment">0</a>条</p>
     <p class="ifr_text">监管提示<a href="../findView/publishContent.supContent" class="msg_num" target="mainFrame" id="notification">0</a>条</p>
</div>
</body>
</html>