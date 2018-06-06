<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>上海市餐饮食品安全追溯与信用服务运营平台</title>
<%@ include file="include.jsp" %>
<script src="../js/jquery-1.6.2.min.js" type="text/javascript"></script>
<link rel="shortcut icon" type="image/x-icon" href="../images/shipin.ico" media="screen" />
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
			<div style="float: left;"><img src="../images/u6.png"/></div>
			<div style="">食安平台-运营管理系统</div>
		</div>
	</div>
	
	<!-- south -->
   	<div showHeader="false" region="south" style="border: 1; text-align: center;" height="40" showSplit="false">
		版权所有 Copyright © 2014 www.wondersgroup.com Inc. All Rights Reserved.</div>
    
    <!-- center -->
    <div title="center" region="center" style="border:0;" bodyStyle="overflow:hidden;">
    	<div class="description" style="width: 80%;" id="resetPwdForm">
        	<h3 >请设置您的密码<span id="goHome" style="float: right;"><a class="mini-button" href="../" iconCls="icon-housego" plain="true" >返回登录</a></span></h3>
    		<table border="0" bordercolor="#a0c6e5" style="border-collapse:collapse;height:25px;line-height:30px;">
			    <tr>
			        <td style="width:220px;text-align: right;"><font color="red">*</font>新密码：</td>
			        <td style="width:300px;">
			        	<input id="passwordNew" name="passwordNew" class="mini-password" onvalidation="onPasswordNewValidation" emptyText="请输入新密码" style="width: 90%;" required="true" requiredErrorText="新密码不能为空"/>
			        </td>
			    </tr>
				<tr>
			        <td style="width:220px;text-align: right;"><font color="red">*</font>新密码确认：</td>
			        <td >
			        	<input id="passwordNew2" name="passwordNew2" class="mini-password" onvalidation="onRePasswordNew2Validation" emptyText="请再次输入新密码" style="width: 90%;" required="true" requiredErrorText="确认密码不能为空"/>
			        </td>
			    </tr>
			    <tr>
			        <td style="width:220px;text-align: right;"></td>
			        <td >
			        	<a onclick="submitForm" class="mini-button" style="width: 60px;">确定</a>
			        </td>
			    </tr>
			</table>
    	</div>
    </div>
</div>
<script type="text/javascript">
	mini.parse();
	var loginName = "${username}"
	function submitForm() {
        var form = new mini.Form("#resetPwdForm");
        form.validate();
        if (form.isValid() == false) return;

        //提交数据
        var data = form.getData();
        var passwordNew = mini.get("passwordNew");
        var json ="{\"loginName\":\""+loginName+"\",\"password\":\""+passwordNew.getValue()+"\"}";
        $.ajax({
            url: "../system/userMgr/changePassword",
            contentType:"application/json",
            type: "post",
            data: json,
            success: function (text) {
            	if(text.status ==0){
            		mini.alert("保存数据成功!", "系统提示");
            		form.clear();
            	}else{
            		mini.alert("保存数据失败!", "系统提示");
            	}
            }
        });
    }
	
	//密码
	function onPasswordNewValidation(e){
		if (e.isValid) {
			if(e.value){
				var reg = /^[a-zA-Z\d_]{6,18}$/;
	            if (!reg.test(e.value)) {
	                e.errorText = "只能包含字母、数字和下划线，长度在6-18之间！";
	                e.isValid = false;
	            };
			};
        };
	}
	
	function onRePasswordNew2Validation(e){
		if (e.isValid) {
			if(e.value){
				var pwdControl = mini.get("passwordNew");
				var pwdVal = pwdControl.getValue();
				var reg = /^[a-zA-Z\d_]{6,18}$/;
	            if (!reg.test(e.value)) {
	                e.errorText = "只能包含字母、数字和下划线，长度在6-18之间！";
	                e.isValid = false;
	            }else if(pwdVal != e.value){
	            	e.errorText = "您两次输入的密码不一致，请重新输入！";
	                e.isValid = false;
	            }
			};
        };
	}
 </script>

</body>
</html>