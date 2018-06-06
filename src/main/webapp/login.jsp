<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
	String error = request.getParameter("login_error");
	if(null!=error){
		if(!error.equals("1")){
			error="1";
		}
	}
	Integer count = (Integer)request.getSession().getAttribute("loginErrorCount");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="renderer" content="webkit">
<meta charset="utf-8">

<link href="./css/common.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
<link href="./css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="login_wrap">
	<!-- <div>
	<div style="width:100%;height:40px;font:14px/40px 'Simsun';color:red;text-align:center;background:yellow;position:absolute;top:0;left:0; z-index:100;">我们将于2017年2月21日22点——22日6点进行系统服务，在此期间用户将无法使用网站、移动端各项应用。给您带来的不便，敬请谅解。</div>
	</div> -->
     <div class="login_top">
          <div class="login_btm">
               <div class="login">
                    <h1 class="login_logo"><a >上海市餐饮食品安全信息追溯系统</a></h1>
                    <div class="login_con">
                
				<form action="j_spring_security_check" method="post" id="springForm" onsubmit="return false;" autocomplete="off">
			        <ul>
<!--                        <li class="error_login" style="display:none;"><i class="icon_ts"></i> <span>用户名不存在，请重新输入</span></li> -->
                            <li class="error_login" style="display:none;"><i class="icon_ts"></i> <span id="error_msg">用户名或密码不匹配，请重新输入</span></li>
                            <li><i class="icon_user"></i><input id="j_username" name="j_username" type="text" class="text_login" value="" placeholder="用户名" style="color:gray"/></li>
                            <li><i class="icon_pwd"></i><input id="j_password" name="j_password" type="password" class="text_login" value="" placeholder="密  码" style="color:gray"/></li>
                            <li class="yzm" style = "display:none;" id="check_li"><i class="i_yzm"></i><input type="text" class="text_login" placeholder="验证码" value="" style="color:gray" id="checkCode"/>
								<img src="./checkCode/generate" class="yzm" id="imgObj"/>
								<a href="javascript:void(0)" class="yzm" onclick = "changeImg()">看不清换一张</a>
                            </li>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</ul>
				</form>
	
                 		<p class="login_reg" ><a href="forgot/forgot_frame.jsp" style="margin-right:140px;">忘记密码</a><a href="reg/reg_frame.jsp">新用户注册</a></p>
                       <p >  <input type="button" class="btn_login" value="登 录" onClick="onLoginClick()" /></p>
                       <p class="login_reg" ><a href="http://image.safe517.com/fdWebFile/attach/培训教程.rar">系统操作手册及视频</a></p>
                      <p class="login_ts">本系统仅限符合“上海市食品安全信息追溯管理办法”要求的食品生产经营者使用，其它单位或个人请勿注册。（推荐使用火狐浏览器）<span class="login_tel">客服电话:<b>021-54644607</b></span></p>
                        
                    </div>
                   <div class="login_footer">版权所有&nbsp;&nbsp;万达信息股份有限公司&nbsp;&nbsp;备案号&nbsp;&nbsp;沪ICP备12026857号</div>
                    </div>
               </div>
          </div>
     </div>
</div>
<script src="./js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="./js/custome.js" type="text/javascript"></script>
<script type="text/ecmascript" src="./js/base64.js"></script>
<script type="text/javascript">
var type = "<%=error%>";
var count = <%=count%>;
var msg="";
$(function(){
	if (type!='null') {
		if(type == "1"){
			$(".error_login").show();
			msg="用户名或密码不匹配，请重新输入";
		}else if(type == "2"){
			msg="账号已登录，请退出之后再登陆！";
		}else if(type == "3"){
			msg="禁止执行访问，请与管理员联系！";
		}
//		    alert(msg,"系统提示信息");
		$("#error_msg").text(msg);
	}
	if(count>3){
		$("#check_li").show();
	}
	function Win_Login(){		   
		  var winH = $(window).height(),
			  mainh = winH; 
		  $(".login").css({height:mainh});
		  var resizeTimer = null;
		  $(window).resize(function(){ //对浏览器窗口调整大小进行计数
			  if (resizeTimer) {
				  clearTimeout(resizeTimer)
			  }	
			  resizeTimer = setTimeout(function(){
				  var winH = $(window).height(),
				  mainh = winH-38; 
				  $(".login").css({height:mainh});
			  }, 400);
			  return false
		  })
		}
		//Win_Login();

});
	if (self != top){  
    	window.top.location = window.location;  
	}


// 	var loginWindow = mini.get("loginWindow");
// 	loginWindow.show();
	function onLoginClick() {
		var username = $("#j_username").val();
		var password = $("#j_password").val();
		if (username=="" || password=="") {
			alert("用户名或密码不能为空！", "系统提示信息");
			return;
		}
		if (password.length <6) {
			alert("密码不能少于6个字符！", "系统提示信息");
			return;
		}
//       	loginWindow.hide();
//       loading("正在登录系统，请稍候..", "系统提示信息");
		//var b = new Base64();  
		//password = b.encode(password);  
        //$("#j_password").val(password);
        var toCheck = $("#check_li").css("display") == 'none';
        var checkFlag = true;
        if(!toCheck){
        	var checkCode = $("#checkCode").val().trim();
            if(checkCode == ""){
            	alert("验证码不能为空！", "系统提示信息");
            	return;
            }
            $.ajax({
    			url: "./checkCode/check",
    			type:"post",
    			async:false,
    			dataType:'json',
    			data:{"code":checkCode},
    			success:function(result){
    				console.log(result);
    				if(result.status!=0){
    					checkFlag = false;
    				}
    			},
    			error:function(){
    				checkFlag = false;
    			}
    		});
        }
        if(!checkFlag){
        	$("#error_msg").text("验证码错误");
        	return;
        }
        document.getElementById("springForm").submit();
       	return false;
    }
	
    document.onkeydown= function(e){
		e = e ? e : event; 
		if(e.keyCode == 13){ 
     		onLoginClick();
     	} 
    }
    function changeImg() {
        var imgSrc = $("#imgObj");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", chgUrl(src));
    }
    //时间戳   
    //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳   
    function chgUrl(url) {
        var timestamp = (new Date()).valueOf();
        url = "./checkCode/generate";
        if ((url.indexOf("&") >= 0)) {
            url = url + "×tamp=" + timestamp;
        } else {
            url = url + "?timestamp=" + timestamp;
        }
        return url;
    }
    
    function forgetPassword(){
   		location.href="./forgetPwd.jsp";
    }
</script>	   
</body>
</html>