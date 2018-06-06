<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>上海市餐饮食品安全信息追溯系统</title>
</head>
  <%@ include file="../include.jsp" %>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>
</head>

<body>
<div class="ifr_box">
     <p class="ifr_text">您确定要退出登录吗？</p>
     <div class="ifr_btn">
          <input type="button" class="btn_blue" value="确定" />
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>

<script type="text/javascript">
$(function(){
   //点击按钮关闭(Chrome上iframe内的按钮关闭必须在服务器上运行 根据需求可注释掉)
	$("input.btn_blue").live("click",function(){
		window.parent.location.href="../logout?${_csrf.parameterName}=${_csrf.token}";	
	});
	
	$("input.btn_gray").live("click",function(){
		$(window.parent.document).find(".shadow_bg").fadeOut().remove();
		$(window.parent.document).find(".popup_box").fadeOut().remove();
	});
/*-------jquery end-------*/
});	
</script>
	
</body>
</html>