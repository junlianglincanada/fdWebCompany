<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String appID=request.getParameter("appID")==null?"":request.getParameter("appID");;
	String key=request.getParameter("key")==null?"":request.getParameter("key");;
	String PFMCompanyID=request.getParameter("PFMCompanyID")==null?"":request.getParameter("PFMCompanyID");;
	String callbackURL=request.getParameter("callbackURL")==null?"":request.getParameter("callbackURL");;
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
<script src="../js/checkCode.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
var appID="<%=appID%>";
var key="<%=key%>";
var PFMCompanyID="<%=PFMCompanyID%>";
var callbackURL="<%=callbackURL%>";
var params={};
var companyName;
var appName;
function createCode(){  
    code = "";   
    var codeLength = 4;//验证码的长度  
    var checkCode = document.getElementById("code");   
    var radNum = new Array(2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R',  
    'S','T','U','V','W','X','Y','Z');//随机数  
    for(var i = 0; i < codeLength; i++) {//循环操作  
       var index = Math.floor(Math.random()*32);//取得随机数的索引（0~35）  
       code += radNum[index];//根据索引取得随机数加到code上  
   }  
   checkCode.value = code;//把code值赋给验证码  
} 
$(function(){
	createCode();
	$.ajax({
		url: "../webservice/getPlatformById/"+appID,
		type:"get",
		success:function(result){
			if(result.status==0){
				appName=result.body.appName;
				$("#companyInfo").text(appName);
			}
		}
	});
	$("a.login_yzm").click(function(){
	     createCode();  
	});
	$(".btn_acc").click(function(){
		$(".error_login").hide();
		var username=$("#username").val().trim();
		if(username==""){
			$(".error_login").show();
			$("#errorMsg").text("用户名不能为空！");
			return false;
		}
		var password=$("#password").val().trim();
		if(password==""){
			$(".error_login").show();
			$("#errorMsg").text("密码不能为空！");
			return false;
		}
		var checkCode=$("#checkCode").val().trim().toUpperCase();
		if(checkCode==""){
			$(".error_login").show();
			$("#errorMsg").text("请输入验证码！");
			return false;
		}
		if(checkCode!=$(".pic_yzm").val()){
			$(".error_login").show();
			$("#errorMsg").text("验证码错误,请重新输入！");
			createCode();
			return false;
		}
		params.appId=appID;
		params.key=key;
		params.platformCompanyId=PFMCompanyID;
		params.username=username;
		params.password=password;
		$.ajax({
			url: "../webservice/authorizeCompany",
			type:"post",
			headers: { 
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			data:JSON.stringify(params),
			success:function(result){
				console.log(result);
				if(result.status==0){
					var companyId = result.body.companyId;
					companyName = result.body.companyName;
					window.location.href="acc_second.jsp?companyId="+companyId+"&callbackURL="+callbackURL+"&companyName="+encodeURI(encodeURI(companyName))+"&appName="+encodeURI(encodeURI(appName));
				}else{
					$(".error_login").show();
					var error=result.message;
					if(result.messageCode=="012003"){
						error+="您还有"+(4-result.body)+"次机会重试";
					}
					$("#errorMsg").text(error);
				}
			}
		});
	})
});
</script>
</head>
<body>
<div class="main_box" style="padding:0;">
     <div class="main_con">
          <div class="acc_box">
           	   <div class="acc_lf">
                    <ul>                      
                        <li><i class="icon_user"></i><input type="text" class="text_login" placeholder="用户名" style="color:gray" id="username"/></li>
                        <li><i class="icon_pwd"></i><input type="password" class="text_login" placeholder="密  码" style="color:gray" id="password"/></li>
                        <li class="li_yzm">
                          <i class="icon_yzm"></i>
                            <input type="text" class="text_login" placeholder="验证码" style="color:gray;width:50px;" id="checkCode"/>
                         	<input type="button" id="code" class="pic_yzm" onClick="createCode()"/>
                          	<a href="javascript:void(0)" class="login_yzm">看不清,换一个</a>
                        </li>
                        <li class="error_login" style="display:none;"><i class="icon_ts"></i> <span id="errorMsg"></span></li>
                    </ul>
                    <p class="acc_btn"><input type="button" class="btn_acc" value="授 权"/></p> 
               </div>
         	   <div class="acc_rt">授权后表明你已同意<span id="companyInfo"></span>将追溯主体企业的进货、配送等台账信息，产品、供应商、收货商等基本 信息（不包括价格、金额等敏感信息）上传至上海市餐饮食品安全信息追溯系统。</div>
          </div>
     </div>
</div>    
</body>
</html>