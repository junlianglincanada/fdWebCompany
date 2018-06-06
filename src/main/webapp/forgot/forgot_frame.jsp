<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta name="renderer" content="webkit" />
<title>上海市餐饮食品安全信息追溯系统</title>
<link href="../images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
html{overflow-x:hidden;overflow-y:hidden;}
</style>
</head>
<body>
<div class="wrap">
     <div class="header_box">
          <iframe src="forgot_header.jsp" scrolling="no" frameborder="0" name="topFrame" id="topFrame" class="header_iframe" allowtransparency="true"></iframe>
     </div>
     <div class="mainbody">
          <iframe src="forgot_first.jsp" scrolling="auto" frameborder="0" name="mainFrame" id="mainFrame" class="main_iframe" allowtransparency="true"></iframe>
     </div>
     <div class="footer_box">
          <iframe src="forgot_footer.jsp" scrolling="no" frameborder="0" name="bottomFrame" id="bottomFrame" class="footer_iframe" allowtransparency="true"></iframe>
      </div>
</div>
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
    //计算屏幕高度
    function win_index(){		   
	  var winH = $(window).height(),
		  mainh = winH-76-37; 
	  $(".mainbody,iframe.main_iframe").css({height:mainh});
	  var resizeTimer = null;
	  $(window).resize(function(){ //对浏览器窗口调整大小进行计数
			if (resizeTimer) {
				clearTimeout(resizeTimer)
			}	
			resizeTimer = setTimeout(function(){
				var winH = $(window).height(),
			    mainh = winH-76-37; 
			    $(".mainbody,iframe.main_iframe").css({height:mainh});
			}, 400);
			return false
		});
	}
	win_index();
	
/*-------jquery end-------*/
});	
</script>	
</body>
</html>