<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String username=request.getParameter("username")==null?"":request.getParameter("username");
	String phone=request.getParameter("phone")==null?"":request.getParameter("phone");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>上海市餐饮食品安全信息追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.reg_tent{width:90%;}
ul.reg_list li{width:22.5%;}
ul.reg_list li span{padding-left:20%;}
.info_box{width:700px;min-height:160px;margin:20px auto;}
a.btn_gray,a.btn_gray:hover{border:1px solid #c1c1c1;color:#898989;cursor:default;}
</style>
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/reAlert.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/custome.js" type="text/javascript" charset="utf-8"></script>	
<script type="text/javascript">
var username="<%=username%>";
var phone="<%=phone%>";
var params={"username":username,"phone":phone};
//手机号中间4位加密
function reloadTEL(tel){
   var reg = /^(\d{3})\d{4}(\d{4})$/;
   tel = tel.replace(reg, "$1****$2");//$1是第一个小括号里的 ,$2是第2个小括号里的 
   $("#moblie").text(tel);
}
function sendMessage(){
	var times = parseInt(59);
	var flag = $(".btn_mesg").text();
	$(".btn_mesg").attr("disabled",true);
	if(flag != "获取短信验证码"){
		return;
	}
	$.ajax({
		url: "../forgetPwd/sendCheckMsg",
		type:"post",
		dataType:'json',
		data:params,
		success:function(result){
		}
	});
	settimes = setInterval(function(){
		if(times<=0){
			clearInterval(settimes);
			$(".btn_mesg").removeClass("btn_gray");
			$(".btn_mesg").text("获取短信验证码"); 
			$(".btn_mesg").next("span.gray").text("手机号无法接收短信时，请联系客服021-54644607找回密码!");
			$(".btn_mesg").attr("disabled",false);
			return;
		}else{
			$(".btn_mesg").addClass("btn_gray");
			$(".btn_mesg").text("重新发送(" + times + "s)");
			$(".btn_mesg").next("span.gray").text("短信已发送到您的手机，若在60秒内还没有收到短信验证码，请重新获取验证码。");
			times--;
        }
    },1000);
}
function isPwd(code){
	var reCode = /^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?![_@]+$)[a-zA-Z0-9@_]{6,20}$/;
	return (reCode.test(code));
}
//点击“获取短信验证码”后，按钮置灰不可用或60倒计时，给出提示：短信已发送到您的手机，若在60秒内还没有收到短信验证码，请重新获取验证码。
//在60秒倒计时之内，用户刷新页面，再次点击“获取短信验证码”时，系统给出提示：发送短信验证码太过频繁，请60秒后再试。
$(function(){
	$("#update").hide();
	//手机号中间4位加密
	reloadTEL(phone);
	$("#submit").click(function(){
		var checkCode = $("#smsCode").val().trim();
		if(checkCode==""){
			$(".ina_red").text("请输入短信验证码");
			return;
		}
		params.phone=phone;
		params.code=checkCode;
		$.ajax({
			url: "../forgetPwd/checkCode",
			type:"post",
			dataType:'json',
			data:params,
			success:function(result){
				if(result.status==0){
					$("#check").hide();
					$("#update").show();
				}else{
					$("#error_msg1").text("短信验证码错误");
				}
			},
			error:function(){
				alert("服务端异常，请稍后重试！");
			}
		});
	});
	$("#newSet").click(function(){
		var password=$("#password").val().trim();
		if(!isPwd(password)){
			$("#error_msg2").text("请输入正确密码");
			return false;
		}
		if($("#password_confirm").val().trim()!=$("#password").val().trim()){
			$("#error_msg2").text("输入密码不一致");
			return false;
		}
		params.username=username;
		params.password=password;
		$.ajax({
			url: "../forgetPwd/setNewPassword",
			type:"post",
			dataType:'json',
			data:params,
			success:function(result){
				if(result.status==0){
					window.location.href="forgot_fourth.jsp";
				}
			},
			error:function(){
				alert("服务端异常，请稍后重试！");
			}
		});
	});
}); 

</script>   
</head>
<body>
<div class="main_box">
     <div class="main_con" id="check">
          <h3 class="reg_fh"><a href="../login.jsp" target="_top"><i class="i_fh"></i><span>返回</span></a></h3>
          <div class="reg_tent">
               <div class="reg_title">
                    <ul class="reg_list">
                        <li><span><i>1</i><em>验证用户名</em></span></li>
                        <li class="default"><span><i>2</i><em>验证手机号</em></span></li>
                        <li><span><i>3</i><em>设置新密码</em></span></li>
                        <li><span><i>4</i><em>完成</em></span></li>
                    </ul>
               </div>
               <div class="reg_detail">
                    <div class="info_box">
                         <table class="info_mation">
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>用户名</td>
                                 <td><span><%=username%></span></td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>手机号</td>
                                 <td class="td_mob">
                                    <span id="moblie"></span>
                                    <a href="javascript:sendMessage()" class="btn_mesg">获取短信验证码</a>
                                    <span class="gray">手机号无法接收短信时，<br />请联系客服021-54644607找回密码!</span>
                                </td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>短信验证码</td>
                                 <td>
                                     <input type="text" class="input_code" style="color:gray;" placeholder="请输入短信验证码" id="smsCode"/>
                                 </td>
                            </tr>
                            <tr>
                                <td class="td_lf">&nbsp;</td>
                                <td><p class="ina_red" id="error_msg1"></p></td>
                            </tr>
                          </table>
                    </div>
                    <p class="save_box">
                       <input type="button" class="btn_save" value="上一步" onClick="window.history.back(-1)"/>
                       <input type="submit" class="btn_save" value="下一步"/ id="submit">
                    </p>
               </div>
           </div>
     </div>
     <div class="main_con" id="update">
          <h3 class="reg_fh"><a href="../login.jsp" target="_top"><i class="i_fh"></i><span>返回</span></a></h3>
          <div class="reg_tent">
               <div class="reg_title">
                    <ul class="reg_list">
                        <li><span><i>1</i><em>验证用户名</em></span></li>
                        <li><span><i>2</i><em>验证手机号</em></span></li>
                        <li class="default"><span><i>3</i><em>设置新密码</em></span></li>
                        <li><span><i>4</i><em>完成</em></span></li>
                    </ul>
               </div>
               <div class="reg_detail">
                    <div class="info_box">
                         <table class="info_mation">
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>新密码</td>
                                 <td><input id="password" type="password" class="input_code" style="color:gray;" placeholder="6-20位大小写字母或数字,@_" /></td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>确认新密码</td>
                                 <td><input id="password_confirm" type="password" class="input_code" style="color:gray;"/></td>
                            </tr>
                            <tr>
                                <td class="td_lf">&nbsp;</td>
                                <td><p class="ina_red" id="error_msg2"></p></td>
                            </tr>
                          </table>
                    </div>
                    <p class="save_box">
                       <input type="button" class="btn_save" value="上一步" onClick="window.location.reload()"/>
                       <input type="button" class="btn_save" value="提交" id="newSet"/>
                    </p>
               </div
          ></div>
     </div>
</div>    
</body>
</html>