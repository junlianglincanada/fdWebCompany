<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
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
.info_box{min-height:160px;width:80%;margin:20px auto;}
</style>
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/reAlert.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/custome.js" type="text/javascript" charset="utf-8"></script>	
<script src="../js/checkCode.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
var params={};
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
	$("a.login_yzm").click(function(){
	     createCode();  
	});
	$(".btn_save").click(function(){
		var username=$("#username").val().trim();
		if(username==""){
			$("#errorMsg").text("用户名不能为空！");
			return false;
		}
		var checkCode=$("#checkCode").val().trim().toUpperCase();
		if(checkCode==""){
			$("#errorMsg").text("请输入验证码！");
			return false;
		}
		if(checkCode!=$(".pic_yzm").val()){
			$("#errorMsg").text("验证码错误,请重新输入！");
			createCode();
			return false;
		}
		params.username=username;
		$.ajax({
			url: "../forgetPwd/getUserMobilephone",
			type:"post",
			dataType:'json',
			data:params,
			success:function(result){
				if(result.status==0){
					var phone = result.body;
					window.location.href="forgot_second.jsp?username="+username+"&phone="+phone;
				}else{
					$("#errorMsg").text(result.message+",请联系客服 021-54644607 找回密码！");
				}
			}
		});
	})
})
</script>	
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="reg_fh"><a href="../login.jsp" target="_top"><i class="i_fh"></i><span>返回</span></a></h3>
          <div class="reg_tent">
               <div class="reg_title">
                    <ul class="reg_list">
                        <li class="default"><span><i>1</i><em>验证用户名</em></span></li>
                        <li><span><i>2</i><em>验证手机号</em></span></li>
                        <li><span><i>3</i><em>设置新密码</em></span></li>
                        <li><span><i>4</i><em>完成</em></span></li>
                    </ul>
               </div>
               <div class="reg_detail">
                    <div class="info_box">
                         <table class="info_mation">
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>用户名</td>
                                 <td>
                                     <input type="text" class="input_code" style="color:gray;" placeholder="请输入用户名" id="username"/>
                                 </td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>验证码</td>
                                 <td>
                                    <input type="text" class="input_code" style="width:82px;float:left; color:gray;" placeholder="请输入验证码" id="checkCode"/>
                         			<input type="button" id="code" class="pic_yzm" style="top:68px;left:304px;" onClick="createCode()"/>
                          			<a href="javascript:void(0)" style="top:71px;left:390px;" class="login_yzm">换一张</a>
                                 </td>
                            </tr>
                            <tr>
                                <td class="td_lf">&nbsp;</td>
                                <td><p class="ina_red" id="errorMsg"></p></td>
                            </tr>
                          </table>
                    </div>
                    <p class="save_box">
                       <input type="button" class="btn_save" value="下一步"/>
                    </p>
               </div>
          </div>
     </div>
</div>    
</body>
</html>