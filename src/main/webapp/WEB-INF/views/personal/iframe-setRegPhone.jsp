<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String phone=request.getParameter("phone");
%>
<!DOCTYPE html>
<html>
<head>
 <%@ include file="../include.jsp" %>
<meta charset="utf-8"/>
<title>上海市餐饮食品安全信息追溯系统</title>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
.ifr_box{width:500px;padding:30px 10px 10px;}
table.info_mation td.td_lf{width:86px;padding-left:0;}
table.info_mation td input.input_code{float:left;}
a.btn_mesg{margin-left:10px;height:27px;line-height:27px;}
a.btn_gray,a.btn_gray:hover{border:1px solid #c1c1c1;color:#898989;cursor:default;}
span.ina_red{color:#e60012;}
.save_box{margin-top:10px;}
.suc_box{width:254px;height:84px;background:url(../images/shadow_bg.png) repeat; position:fixed;top:20%; left:27%}
i.i_success{display:block;width:70px;height:26px;margin:30px auto;background:url(../images/i_success.png) 0 0 no-repeat;padding-left:36px;font:14px/26px 'Simsun';color:#fff;}
</style>
<script type="text/javascript">
var params = {};
var isClicked = false;
var phone = "<%=phone %>";
function sendMessage(){
	var flag = $(".btn_mesg").text();
	$(".btn_mesg").attr("disabled",true);
	if(flag != "获取短信验证码"){
		return;
	}
	$("span.gray").removeClass("ina_red");
	$("span.gray").text("");
	params.phone=phone;
	var times = parseInt(59);
	$.ajax({
		url: "../security/systemUser/sendCheckMsg",
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
			if(!isClicked){
				$("#message").text("短信已发送到您的手机，若在60秒内还没有收到短信验证码，请重新获取验证码。");
			}
			$(".btn_mesg").attr("disabled",false);
			return;
		}else{
			$(".btn_mesg").addClass("btn_gray");
			$(".btn_mesg").text("重新发送(" + times + "s)");
			if(!isClicked){
				$("#message").text("短信已发送到您的手机，若在60秒内还没有收到短信验证码，请重新获取验证码。");
			}
			times--;
        }
    },1000);
}
$(function(){
	//弹出窗口宽高控制            
	function iframe_wh(){
		var par_W = $(window.parent.document).width();
		var ifr_W = $(window.document).find(".ifr_box").width();
		var pos_W = (par_W - ifr_W)/2 ; 
		//alert(par_W);
		$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:386+"px",left:pos_W +"px",top:20+"px"});
		$(window.parent.document).find(".popup_iframe").css({height:340 +"px"});
		$(window).resize(function(){ //对浏览器窗口调整大小进行计数
			var par_W = $(window.parent.document).width();
			var pos_W = (par_W - ifr_W)/2; 
			//alert(par_W);
			$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:386 +"px",left:pos_W +"px",top:20+"px"});
			$(window.parent.document).find(".popup_iframe").css({height:340 +"px"});
			return false;
		});
	};
	iframe_wh(); //计算窗口宽度高度的函数
	
	//提交
	$(".btn_save").click(function(){
		var code = $("#code").val().trim();
		if(code=="" || code==null){
			$("span.gray").addClass("ina_red");
			$("span.gray").text("短信验证码不能为空！");
			return false;
        }
		params.code=code;
		$.ajax({
    		url: "../security/systemUser/setVerifiedPhone",
    		type:"post",
    		dataType:'json',
    		data:params,
    		success:function(result){
    			if(result.status==0){
    				$("span.gray").hide();
					var sucM = '<div class="suc_box">'+'<i class="i_success">'+'提交成功'+'</i>'+'</div>';
					$(window.document).find("body").append(sucM);         
					//关闭弹窗
					setTimeout(function(){
						window.parent.location.href="personal.personal";
						/* $(window.parent.document).find(".shadow_bg").fadeOut().remove(); 
						$(window.parent.document).find(".popup_box").fadeOut().remove(); */
					},2000);   
    			}else{
    				isClicked = true;
    				$("span.gray").addClass("ina_red");
    				$("span.gray").text(result.message);
    			}
    		}
    	});
    });
})
</script>
</head>
<body>
<div class="ifr_box">
     <table class="info_mation">
            <tr>
                 <td class="td_lf"><em class="star"></em>手机号码</td>
                 <td id="phone"><%=phone %></td>
            </tr>
            <tr>
                 <td class="td_lf"><em class="star">*</em>短信验证码</td>
                 <td class="td_mob">
                    <input type="text" class="input_code" placeholder="请输入新手机号收到的短信验证码" name="message" value="" id="code"/>
                    <a href="javascript:sendMessage()" class="btn_mesg">获取短信验证码</a>
                </td>
            </tr>
            <tr>
                <td class="td_lf">&nbsp;</td>
                <td><span class="gray" id="message">&nbsp;</span></td>
            </tr>
    </table>
    <p class="save_box">
       <input type="button" class="btn_save" value="提交" />
    </p>
</div>
</body>
</html>