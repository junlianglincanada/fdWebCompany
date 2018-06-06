<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
	String webPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	String path = request.getContextPath();
	webPath += path;
	request.setAttribute("webPath", webPath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script src="<%=webPath %>/js/boot.js" type="text/javascript"></script>
<script src="<%=webPath%>/js/miniuiHelper.js" type="text/javascript"></script>
<link href="<%=webPath%>/css/home.css" rel="stylesheet" type="text/css"  />
<link rel="shortcut icon" type="image/x-icon" href="<%=webPath%>/images/shipin.ico" media="screen" />
<style type="text/css">
	.description{
		margin:0 auto;
    	padding-bottom:30px;
    	font-family:Verdana;
	}
	.description h3{
    	color:#000000;
    	font-size:16px;
    	margin:0 30px 10px 0px;
    	padding:25px 0 8px;
    	border-bottom:solid 1px #888;
	}
</style>
<body>
    
<!--Layout-->
<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
    <!-- header -->
    <div title="north" region="north" class="header" bodyStyle="overflow:hidden;" height="70" showHeader="false"
		showSplit="false">
		<div>
			<div style="float: left;"><img src="<%=webPath%>/images/u6.png"/></div>
			<div style="">食安平台-运营管理系统</div>
		</div>
	</div>
	
	<!-- south -->
   	<div showHeader="false" region="south" style="border: 1; text-align: center;" height="40" showSplit="false">
		版权所有 Copyright © 2014 www.wondersgroup.com Inc. All Rights Reserved.</div>
    
    <!-- center -->
    <div title="center" region="center" style="border:0;" bodyStyle="overflow:hidden;">
    	<div class="description" style="width: 80%;" >
        	<h3 style="font-size: 12px;font-weight: normal;"><img src="<%=webPath %>/images/u37.png" style="width: 16px;height: 16px;"/>&nbsp;登陆首页 / 忘记密码<span id="goHome" style="float: right;"><a class="mini-button" href="<%=webPath %>/" iconCls="icon-housego" plain="true" >返回登录</a></span></h3>
    	</div>
    	
        <div id="forgetHome" class="description" style="width: 70%;" >
        	<h3>请选择找回密码方式</h3>
        	<p><a class="mini-button" href="javascript:void(0);" id="phonebtn" iconCls="icon-phone" >手机找回</a></p>
        	<p><a class="mini-button" href="javascript:void(0);" id="emailbtn" iconCls="icon-email">邮箱找回</a></p>
    	</div>
    	
    	<div id="phoneFound" class="description" style="width: 70%;" >
        	<h3>手机找回<span id="goHome" style="float: right;font-size: 12px;font-weight: normal;"><a class="mini-button" id="phoneback" iconCls="icon-undo" plain="true" >返回</a></span></h3>
        	<p>
        		<a onclick="sendVerifCode" class="mini-button" style="width: 120px;">发送验证码</a>
        	</p>
        	<p>
        		验证码：<input id="email" name="email" class="mini-textbox" required="true" requiredErrorText="验证码不能为空" style="width: 300px;" />
        		<a onclick="phoneFound" class="mini-button" style="width: 60px;">确定</a>
        	</p>
    	</div>
    	
    	<div id="emailFound" class="description" style="width: 70%;" >
        	<h3>邮箱找回<span id="goHome" style="float: right;font-size: 12px;font-weight: normal;"><a class="mini-button" id="emailback" iconCls="icon-undo" plain="true" >返回</a></span></h3>
        	<p>
        		<table border="0" bordercolor="#a0c6e5" style="border-collapse:collapse;height:25px;line-height:30px;">
        		<tr>
			        <td style="width:120px;text-align: right;">用户名<font color="red">*</font>：</td>
			        <td style="width:300px;">
			        	 <input id="username" name="username" class="mini-textbox" required="true" requiredErrorText="用户名不能为空" onvalidation="onLoginNameValidation" emptyText="请输入您注册时的用户名" style="width: 300px;" />
			        </td>
			    </tr>
        		<tr>
			        <td style="width:120px;text-align: right;">邮箱地址<font color="red">*</font>：</td>
			        <td style="width:300px;">
			        	 <input id="email" name="email" class="mini-textbox" required="true" requiredErrorText="用户邮箱不能为空" vtype="email" emptyText="请输入您注册时的邮箱" style="width: 300px;" />
			        </td>
			    </tr>
			    <tr>
			        <td style="width:120px;text-align: right;"></td>
			        <td style="width:300px;text-align: right;">
			        	 <a onclick="emailFound" class="mini-button" style="width: 60px;">确定</a>
			        </td>
			    </tr>
			    </table>
        	</p>
    	</div>
    </div>
</div>
<script type="text/javascript">
	mini.parse();
	var emailFound = new mini.Form("#emailFound");
	
	$(function(){
		$("#phoneFound,#emailFound").hide();
		$("#phonebtn").click(function(){					 
			  $("#forgetHome,#emailFound").hide();
			  $("#phoneFound").show();
		});
		$("#emailbtn").click(function(){
			  $("#forgetHome,#phoneFound").hide();
			  $("#emailFound").show();
		});
		$("#emailback,#phoneback").click(function(){
			  $("#emailFound,#phoneFound").hide();
			  $("#forgetHome").show();
		});
	});
	
	function sendVerifCode(){
		
	}
	
	function phoneFound(){
		
	}
	
	function emailFound(){
		emailFound.validate();
	    if (emailFound.isValid() == false) return;

	    //提交数据
	    var data = emailFound.getData();      
	    var json = mini.encode(data);
		var msgid = mini.loading("数据正在处理，请稍后......", "系统提示");
		$.ajax({
            url: "<%=webPath%>/system/userMgr/resetPassword.do",
            contentType:"application/json",
            type: "post",
            data: json,
            success: function (text) {
            	mini.hideMessageBox(msgid);
            	if(text.status == 0 && text.message == "success"){
            		mini.alert("已经将最新密码发送到您的邮箱");
            	}else{
            		mini.alert(text.message, "系统提示");
            	}
            }
        });
	}
	
 </script>

</body>
</html>