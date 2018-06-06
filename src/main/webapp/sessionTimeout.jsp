<%@ page language="java" pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>用户登录已超时</title>
	<style type="text/css">
		body {
			text-align: center;
		}
		#sessionOut {
			margin: 0 auto;
			padding: 15px 50px;
			width: 500px;
			border: 2px solid red;
			background-color: yellow;
			text-align: center;
		}
		a {
			font-weight: bold;
			font-family: "宋体";
			font-size: 18px;
		}
	</style>
</head>
<body>
	<div id="sessionOut">
		您长时间未操作系统，为确保您的资料及数据信息安全， 系统自动超时退出，请重新<a href="javascript:void(0);" target="_parent" onclick="login();">登录</a>系统！
	</div>
</body>
<script type="text/javascript">  
	if (self != top){  
       window.top.location = window.location;  
	}
	
	function login(){
		window.location = "<%=request.getContextPath()%>";
	}
	
	document.onkeydown= function(e){
		e = e ? e : event; 
		if(e.keyCode == 13){ 
			login();
     	} 
    }
</script>
</html>
