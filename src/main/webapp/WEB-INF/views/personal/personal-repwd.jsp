<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<style >
span.text_ts1{color:#ff6600;margin-left:20px;}
span.text_ts2{color:#ff6600;margin-left:20px;}
span.text_ts3{color:#ff6600;margin-left:20px;}
</style>
<meta charset="utf-8">
 <%@ include file="../include.jsp" %>
<title>万达食品安全追溯系统</title>
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="main_box">
     <div class="main_con">
          <form id="saveForm" >
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/personal.personal">个人中心</a> > <a href='../findView/personal.personal-repwd?id=<%=id %>'>修改密码</a></h3>
          <h4 class="per_title"><span>账号信息</span></h4>
          <div class="per_box">
               <table class="info_mation" style="width:80%; margin:0 auto;" id="table">
                    <tr>
                   	<td class="td_lf" style="padding-left:82px;"><em class="star">*</em>原密码</td>
                    <td><input type="password" class="input_code" id="currentPassword" name="currentPassword" style="width:166px;"onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))" maxlength="20" value="" />
                    </td>
                   </tr>
                   <tr>
                   	<td class="td_lf" style="padding-left:82px;"><em class="star">*</em>修改密码</td>
                    <td><input type="password" class="input_code" id="newPassword" name="newPassword" style="width:166px;" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))" maxlength="20" value="" /></td>
                   </tr>

                   <tr>
                   		<td class="td_lf" style="padding-left:82px;"><em class="star">*</em>确认密码</td>
                       <td><input type="password" class="input_code" id="passwordNew" name="passwordNew" style="width:166px;"onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))" maxlength="20" value="" /></td>
                   </tr>
               </table>
               </div>
          </form>            
               <p class="save_box">
                 <input  id="saveFormSubmit" type="button" class="btn_save" value="保存" />
                  <input  type="button" class="btn_save" value="返回"  onClick="window.location.href='../findView/personal.personal'"/>
               </p>
              <div class="clear"></div>
          </div>
     </div>
<script type="text/ecmascript" src="../js/base64.js"></script>
<script type="text/javascript">
var repwd = {};
var companyUserId;
var currentPassword;
var newPassword;
$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};
$(document).ready(function () {
	$("body").on("blur","input[type='text']",function(){
 		$(this).next(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    }
	});
	  $("#currentPassword").focus(function(){
		  $("#table").find(".text_ts1").remove();
		  $("#table").find(".text_ts").remove();
	  });
	  $("#currentPassword").blur(function(){
		  var cpw=$("#currentPassword").val();
   		//判断输入框是否含有特殊字符
   		if(checkSpecificKey(cpw)==false){
   			$("#currentPassword").after('<span class="text_ts1" >请勿输入特殊字符 </span>');
   			return false;
   		}
   		//非空输入框非空验证
   		if(cpw==""||cpw==null){
   			$("#currentPassword").after('<span class="text_ts1">原密码不能为空 </span>');
   			ajaxFlag=false;
   			return false;
   		}
	  });
	  $("#newPassword").focus(function(){
		  $("#table").find(".text_ts2").remove();
	  });
	  $("#newPassword").blur(function(){
   	   var npw=$("#newPassword").val();
   		//判断输入框是否含有特殊字符
   		if(checkSpecificKey(npw)==false){
   			$("#newPassword").after('<span class="text_ts2">请勿输入特殊字符 </span>');
   			ajaxFlag=false;
   			return false;
   		}
   		//非空输入框非空验证
   		if(npw==""||npw==null){
   			$("#newPassword").after('<span class="text_ts2">新密码不能为空 </span>');
   			ajaxFlag=false;
   			return false;
   		}
   		if(npw!="")
   			{var reg = /^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?![_@]+$)[a-zA-Z0-9@_]{6,20}$/;
   			if(!reg.test(npw)){
   		    	  $("#newPassword").after('<span class="text_ts2">密码是6-20位数字、大小写字母、@_的至少两种组合。 </span>');

   		    	  return false;
   			}
   				}
	  });
	  $("#passwordNew").focus(function(){
		  $("#table").find(".text_ts3").remove();
	  });
	  $("#passwordNew").blur(function(){
   	   var npw=$("#newPassword").val();
   	   var pwn=$("#passwordNew").val();
   		//判断输入框是否含有特殊字符
   		if(checkSpecificKey(npw)==false||checkSpecificKey(pwn)==false){
   			$("#passwordNew").after('<span class="text_ts3">请勿输入特殊字符 </span>');

   			return false;
   		}
   		//非空输入框非空验证
   		if(pwn==""||pwn==null){
   			$("#passwordNew").after('<span class="text_ts3">确认密码不能为空 </span>');

   			return false;
   		}
   		if(pwn != npw){
	    		 $("#passwordNew").after('<span class="text_ts3">您两次输入的密码不一致，请重新输入！！ </span>');

	    		 return false;
	    	 }
	  });
	     $("#saveFormSubmit").click(function () {
	    	 var cpw=$("#currentPassword").val();
	    	   var npw=$("#newPassword").val();
	    	   var pwn=$("#passwordNew").val();
	    	 $("input").focus();
	    	 $("#table").find(".text_ts").remove();
	    	 if(npw!="")
	   			{var reg = /^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?![_@]+$)[a-zA-Z0-9@_]{6,20}$/;
	   			if(!reg.test(npw)){
	   		    	  return false;
	   			}
	   				}
	    	 if($("#newPassword").val()==$("#passwordNew").val()&&$("#newPassword").val()!=""&&checkSpecificKey(pwn)==true&&$("#newPassword").val()!=null&&$("#currentPassword").val()!=""&&$("#currentPassword").val()!=null){
	 	     
	    	    	$("#loading").show();
	    	    	var b = new Base64();
	     	    	repwd.companyUserId="<%=id %>";
	     	    	repwd.currentPassword = b.encode($("#currentPassword").val());
	     	    	repwd.newPassword = b.encode($("#newPassword").val());
	    	        var options = {
	    	            url: "../security/systemUser/changePassword",
	    	            headers: {                         
	    	                'Accept': 'application/json',
	    	                'Content-Type': 'application/json' 
	    	            },
	    	            type: 'post',
	    	            dataType: 'json',
	    	            data:JSON.stringify(repwd),
	    	            success: function (data) {
	    	            	$("#loading").hide();
	    	            	if(data.status==0){
	    	            		alert("密码修改成功");
	    	            		$(".btn_blue").click(function(){
	    	            			location.href="../findView/personal.personal";
	    	            		});
	    	            	}else{
	    	            		$("#table").find(".text_ts1").remove();
	    	            		$("#currentPassword").after('<span class="text_ts">原密码错误，请重新输入！！！ </span>');
	    	            		$('#currentPassword').val("");
	    	            		}
	    	                },
	    	          		 error:function(text) {
	 	    	            	$("#loading").hide();	    	           		 }
	    	        };
	    	        $.ajax(options);
	    	        return false;
	     }
	                });
});
</script>
</body>
</html>