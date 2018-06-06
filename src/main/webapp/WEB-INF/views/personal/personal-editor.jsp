<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
 <%@ include file="../include.jsp" %>
<title>万达食品安全追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="main_box">
     <div class="main_con">
          <form id="saveForm" >
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/personal.personal">个人中心</a> > <a href='../findView/personal.personal-editor'>编辑</a></h3>
          <h4 class="per_title"><span>个人信息</span></h4>
          <div class="per_box">
               <table class="info_mation" style="width:859px; margin:0 auto;" id="table">
                   <tr>
                       <td class="td_lf" style="width:47px;"><em class="star">*</em>姓名</td>
                       <td><input maxlength="32" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))" type="text" class="input_code" style="width:166px;"  id="name" name="name"/></td>
                       <td class="td_lf">电话</td>
                       <td><input maxlength="12" type="text" class="input_code" style="width:166px;"  id="phone" name="phone" onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"/></td>
                    </tr>
                   <tr>
                       <td class="td_lf" style="width:47px;"><em class="star">*</em>手机</td>
                       <td><input type="text" class="input_code" style="width:166px;" value="" id="mobilePhone" name="mobilePhone" maxlength="11"/><i class="cert" id="verified" style="display:none">已认证</i></td>
                        
                       <td class="td_lf" style="width:47px;">邮箱</td>
                       <td><input maxlength="40" type="text" class="input_code" style="width:166px;"  id="email" name="email" onkeyup="value=value.replace(/[`~!#$%^&*()_+<>?:{},\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!#$%^&*()_+<>?:{},\/;[\]]/g,''))" /></td>
                    </tr>
                   <tr>
                       <td class="td_lf" style="width:47px;"><em class="star"></em>岗位</td>
                       	<td >
								<div class="select_s">
									<div class="select_is">
										<select class="select_cs" id="jobRole" name="jobRole">
										    <option value="">请选择岗位</option>
											<option value="厨师长">厨师长</option>
											<option value="法定代表人（负责人）">法定代表人（负责人）</option>
											<option value="门店经理">门店经理</option>
											<option value="采购负责人">采购负责人</option>
											<option value="大堂经理">大堂经理</option>
											<option value="食品安全管理人员（专职）">食品安全管理人员（专职）</option>
											<option value="食品安全管理人员（兼职）">食品安全管理人员（兼职）</option>
											<option value="原料采购人员">原料采购人员</option>
											<option value="分餐人员">分餐人员</option>
											<option value="专间操作人员">专间操作人员</option>
											<option value="餐饮具消毒人员">餐饮具消毒人员</option>
											<option value="餐饮主管人员">餐饮主管人员</option>
											<option value="厨师">厨师</option>
											<option value="其他">其他</option>
										</select>
									</div>
								</div>
							</td>
                       <%-- <input maxlength="20" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))" type="text" class="input_code" style="width:166px;"  id="jobRole" name="jobRole"/> 
                       </td> --%>
                       <td class="td_lf" style="width:47px;">部门</td>
                       <td><input maxlength="20" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))" type="text" class="input_code" style="width:166px;" id="jobTitle" name="jobTitle"/></td>
                   </tr>
               </table>
               </div>
               </form>
               <p class="save_box">
                  <input  id="saveFormSubmit" type="button" class="btn_save" value="保存"/>
                  <input  type="button" class="btn_save" value="返回" onClick="window.location.href='../findView/personal.personal'"/>
                  <input id="id" name="id" value="" type="hidden"/>
                  <input id="personId" name="personId" value="" type="hidden"/>
               </p>
               <div class="clear"></div>
          </div>
     </div>
<script type="text/javascript">
var Ohno={};
var id;
var personId;
var name;
var jobRole;
var jobTitle;
var phone;
var email;
var mobilePhone;
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
	     $("#saveFormSubmit").click(function () {
	    	 var ajaxFig=true;
	    	 $("#table").find(".text_ts").remove();
	    		$("body input[type='text']").not("#email").each(function(){
	    		    var inputValue=	$(this).val();
	    		    if(checkSpecificKey(inputValue)==false){
	    		    	$(this).after('<span class="text_ts">请勿输入特殊字符 </span>');
	    		    	ajaxFig=false;
	    		    	return false;
	    		    }
	    		});
	        	if(ajaxFig==false){
	        		return false;
	        	}
	    	 $("#table").find(".text_ts").remove();
	    		if($.trim($("#email").val())!=""){
	   	    	 var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
	   	    	 if(!reg.test($.trim($('#email').val()))){
	   	    		$("#email").after('<span class="text_ts">电子邮箱格式错误 </span>');
	   	    	  return false;
	   	    	 }
	   	    	}
	    		if($.trim($("#name").val())==""){
	    			$("#name").after('<span class="text_ts">姓名不能为空 </span>');
		    	 return false;
		    	}
	    		if($.trim($("#mobilePhone").val())==""){
	    			$("#mobilePhone").after('<span class="text_ts">手机号码不能为空 </span>');
		    	 return false;
		    	}
		    	if($.trim($("#mobilePhone").val())!=""){
		    	 var reg = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
		    	 if(!reg.test($.trim($('#mobilePhone').val()))){
		    		 $("#mobilePhone").after('<span class="text_ts">手机号码格式错误 </span>');
		    	  return false;
		    	 }
		    	}
		    	 if($.trim($("#phone").val())!=""){
		    	 var reg = /^((0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$|^((0\d{2,3}))?(\d{7,8})(-(\d{3,}))?$/;
		    	 if(!reg.test($.trim($('#phone').val()))){
		    		 $("#phone").after('<span class="text_ts">座机号码格式错误 </span>');
		    	  return false;
		    	 }
		    	}  
	    	    	$("#loading").show();
	    	    	Ohno.id = $("#id").val();
	    	    	Ohno.personId=$("#personId").val();
	    	    	Ohno.name = $("#name").val();
	    	    	Ohno.jobRole = $("#jobRole").val();
	    	    	Ohno.jobTitle = $("#jobTitle").val();
	    	    	Ohno.email = $("#email").val();
	    	    	Ohno.mobilePhone = $("#mobilePhone").val();
	    	    	Ohno.phone = $("#phone").val();
	    	        var options = {
	    	            url: "../security/systemUser/edit",
	    	            headers: {                         
	    	                'Accept': 'application/json',
	    	                'Content-Type': 'application/json' 
	    	            },
	    	            type: 'post',
	    	            dataType: 'json',
	    	            data:JSON.stringify(Ohno),
	    	            success: function (data) {
	    	            	refreshTopFrame();
	    	            	$("#loading").hide();
	    	                location.href="../findView/personal.personal";
	    	                },
   	          		 error:function(text) {
	    	            	$("#loading").hide();
 	           			 $("#saveFormSubmit").attr("disabled",false);
 	           		 }
	    	        };
	    	        $.ajax(options);
	    	        $("#saveFormSubmit").attr("disabled",true);
	    	        return false;
	                });
 $.ajax({
    async : false,
    cache : false,      type:"get",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },      dataType : "json",
    url: "../security/systemUser/getUser",//请求的action路径
    error: function (e) {//请求失败处理函数
    	console.log(e);
     alert('请求失败');
    },
     success:function(text){ //请求成功后处理函数。
         console.log(text.body);
    	 show(text);
    }
  });
function show(text){
	var sysLoginUser=text.body;
/* 	document.getElementById("name").innerHTML = sysLoginUser.name; */
	/* document.getElementById("phone").innerHTML = sysLoginUser.phone;
	document.getElementById("mobilePhone").innerHTML = sysLoginUser.mobilePhone;
	document.getElementById("email").innerHTML = sysLoginUser.email;
	document.getElementById("jobRole").innerHTML = sysLoginUser.department;
	document.getElementById("jobTitle").innerHTML = sysLoginUser.jobTitle; */
	$("#name").val(sysLoginUser.name);
	$("#phone").val(sysLoginUser.phone);
	$("#mobilePhone").val(sysLoginUser.mobilePhone);
	$("#email").val(sysLoginUser.email);
	$("#jobRole").val(sysLoginUser.jobRole);
	$("#jobTitle").val(sysLoginUser.jobTitle);
	$("#id").val(sysLoginUser.id);
	$("#personId").val(sysLoginUser.personId);
	var isPhoneReg = sysLoginUser.isPhoneReg;
	if(isPhoneReg==1){
		$("#mobilePhone").attr("disabled",true);
		$("#verified").show();
	}
}
});
function refreshTopFrame(){
	//刷新shangbian框架
	window.parent.location.reload();
	}
</script>
</body>
</html>