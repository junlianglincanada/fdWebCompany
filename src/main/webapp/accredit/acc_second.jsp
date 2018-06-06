<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
	String companyName=request.getParameter("companyName")==null?"":request.getParameter("companyName");
	if(!companyName.equals("")){
		companyName=java.net.URLDecoder.decode(companyName, "UTF-8");
	}
	String appName=request.getParameter("appName")==null?"":request.getParameter("appName");
	if(!appName.equals("")){
		appName=java.net.URLDecoder.decode(appName, "UTF-8");
	}
	String callbackURL=request.getParameter("callbackURL")==null?"":request.getParameter("callbackURL");
	String companyId=request.getParameter("companyId")==null?"":request.getParameter("companyId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>上海市餐饮食品安全信息追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/reAlert.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
function timer(num){
	self.setInterval(function(){
		num--;
		$("#CountDown").text(num);
		if(num==0){
			window.top.location.href='//<%=callbackURL%>?companyId=<%=companyId%>'; //设置跳转的URL
		}
	},1000);
}
$(function(){
    //倒计时-页面跳转
    timer(5);
});	
</script>	
</head>
<body>
<div class="main_box" style="padding:0;">
     <div class="main_con">
          <div class="acc_box">
               <i class="i_acc"></i>
               <p class="acc_t1">授权成功</p>
               <p class="acc_t2"><span id="CountDown">5</span>秒后自动关闭</p>
           	   <p class="acc_t3"><span><%=companyName%></span>已成功授权<span><%=appName%></span>使用上海市餐饮食品安全信息追溯系统接口上传数据。</p>
          </div>
     </div>
</div>    
</body>
</html>