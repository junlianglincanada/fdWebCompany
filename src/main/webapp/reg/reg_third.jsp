<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
	String webPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	String path = request.getContextPath();
	webPath += path;
	request.setAttribute("webPath", webPath);
	String company=request.getParameter("company");
	company=java.net.URLDecoder.decode(company, "UTF-8");
	String user=request.getParameter("user");
	user=java.net.URLDecoder.decode(user, "UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/reAlert.js" type="text/javascript" charset="utf-8"></script>	
<script src="../js/custome.js" type="text/javascript" charset="utf-8"></script>	
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="reg_fh"><a href="javascript:history.back(-1);" target="_top"><i class="i_fh"></i><span>返回</span></a></h3>
          <div class="reg_tent">
               <div class="reg_title">
                    <ul class="reg_list">
                        <li><span><i>1</i><em>验证</em></span></li>
                        <li><span><i>2</i><em>注册</em></span></li>
                        <li class="default"><span><i>3</i><em>完成</em></span></li>
                    </ul>
               </div>
               <div class="reg_detail">
                    <div class="info_box" style="min-height:200px;">
                         <div class="reg_succed">
                              <i class="i_aucced"></i>
                              <p style="padding-left:10px;">你好！</p>
                              <p class="blue"><%=company %>  <%=user %>  用户</p>
                              <p>您已注册成功！</p>
                         </div>
                    </div>
                    <p class="save_box">
                       <input type="button" class="btn_save" value="马上登录" onClick="window.parent.location.href='<%=webPath %>'"/>
                    </p>
               </div
          ></div>
     </div>
</div>
</body>
</html>