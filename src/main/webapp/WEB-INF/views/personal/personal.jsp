<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String phone=request.getParameter("phone");
%>
<!DOCTYPE html>
<html>
<head>
 <%@ include file="../include.jsp" %>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<style type="text/css">
span.gray{width: 269px;}
</style>
<script type="text/javascript">
var id;
$(function(){
	$("#loading").show();
	$.ajax({
		url: "../security/systemUser/getUser",//请求的action路径
	    headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    type:"get",
	    dataType : "json",
	    success:function(result){ //请求成功后处理函数。
			$("#loading").hide();
			console.log(result.body);
			id=result.body.id;
			$("#userName").text(isnull(result.body.userName));
			$("#name").text(isnull(result.body.name));
			$("#phone").text(isnull(result.body.phone));
			$("#mobilePhone").text(isnull(result.body.mobilePhone));
			$("#email").text(isnull(result.body.email));
			$("#jobRole").text(isnull(result.body.jobRole));
			$("#jobTitle").text(isnull(result.body.jobTitle));
			var flag = result.body.isPhoneReg;
			if(flag == 1){
				$("#verified").show();
			}else{
				$("#unverified").show();
				$("#toRegPhone").attr("link","personal.iframe-setRegPhone?phone="+isnull(result.body.mobilePhone));
			}
		},
	    error: function (e) {//请求失败处理函数
	    	console.log(e);
	    	alert('请求失败');
	    }
	});
	$("#editorpassword").click(function(){
		window.location.href="../findView/personal.personal-repwd?id="+id;
	})
});
</script>
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span></span><a href="../findView/personal.personal">个人中心</a> 

          </h3>
          <h4 class="per_title"><span>账号信息</span></h4>
          <div class="per_box">
          <div class="btn_opera"> 
                   <input id="editorpassword" type="button" class="btn_add" value="修改密码" />
              </div>
               <table class="info_mation" style="width:80%; margin:0 auto;">
                   <tr>
                       <td class="td_lf">用户名</td>
                       <td id="userName"></td>
                   </tr>
               </table>
          </div>
          <h4 class="per_title"><span>个人信息</span></h4>
          <div class="per_box">
                   <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="编辑个人信息" onClick="window.location.href='../findView/personal.personal-editor'" />
              </div>
               <table class="info_mation" style="width:80%; margin:0 auto;">
                   <tr>
                       <td class="td_lf">姓名</td>
                       <td id="name"></td>
                   </tr>
                   <tr>   
                       <td class="td_lf">电话</td>
                       <td id="phone"></td>
                   </tr>
                   <tr>
                       <td class="td_lf">手机</td>
                       <td>
                       	   <span class="mobile" id="mobilePhone"></span>
                           <span id="verified" style="display:none"><input type="button" class="input_search" style="margin-left:10px;" value="修改" rel="popup" link="personal.iframe-changePhone" title="修改" />
                           <i class="cert">已认证</i></span>
                           <span id="unverified" style="display:none"><input type="button" class="input_search" style="margin-left:10px;" value="认证手机号" rel="popup" link="" title="认证手机号" id="toRegPhone"/></span>
                           <span colspan="2" class="gray">&nbsp;&nbsp;注：认证手机后，可使用短信验证找回密码。<span>
                       </td>
                   </tr>
                   <tr>
                       <td class="td_lf">邮箱</td>
                       <td id="email"></td>
                   </tr>
                   <tr>
                       <td class="td_lf">岗位</td>
                       <td id="jobRole"></td>
                   </tr>
                   <tr>
                       <td class="td_lf">部门</td>
                       <td id="jobTitle">  </td>
                   </tr>
               </table>
          </div>
     </div>
</div>    
</body>
</html>