﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp"%>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/restEmployee.restEmployeeView">从业人员</a> > <a href="#">编辑从业人员</a> </h3>
          <div class="info_tab">
               <a href="../findView/restEmployee.restEmployee-editer?id=<%=id%>" class="default">基本信息</a>
               <a href="../findView/restEmployee.restEmployee-editer-photo?id=<%=id%>">证件信息</a>
          </div>
          <form id="addForm" action="../restaurant/comEmployee/updateComEmployee" method="post" enctype="multipart/form-data">
          <div class="info_box">
          <input id="personId" name="personId" value="<%=id %>" style="display:none;"/>
               <table class="info_mation" style="border-bottom:1px solid #dcdddd; margin-top: 20px;">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>姓名</td>
                       <td><input type="text" class="input_code" value="" id="personName" name="personName" maxlength="30"/></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>性别</td>
                       <td id="sex">
                           <label for="radio_c1"><input type="radio" name="sex" id="radio_c1" checked="checked" value="1"/> 男</label> &nbsp;&nbsp;&nbsp;&nbsp;
                           <label for="radio_c2"><input type="radio" name="sex" id="radio_c2" value="0" /> 女</label>
                       </td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>证件类型</td>
                       <td >
                           <div class="select_s" style="width:182px; float:left;">
                            <div class="select_is" style="width:182px;">
                               <select class="select_cs" style="width:212px; background-position:-12px -122px; " id="idType" name="idType"> 
                                      <option value="">请选择证件类型</option>
                                      <option value="11005">居民身份证</option>
                                      <option value="11004">台湾居民来往大陆通行证</option>
                                      <option value="11003">港澳居民来往内地通行证</option>
                                      <option value="11002">外国人居留证</option>
                                      <option value="11001">护照</option>
                               </select>
                             </div>
                           </div>
                           <input type="text" id="idNumber" name="idNumber" class="input_code" style="width:152px;float:left;margin-left:10px; " value="" maxlength="18" />
                       </td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>手机</td>
                       <td><input type="text" class="input_code" value="" id="mobilePhone" name="mobilePhone" maxlength="11"/><i class="cert" id="verified" style="display:none">已认证</i></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>电话</td>
                       <td><input type="text" class="input_code" value="" id="phone"  name="phone" maxlength="20" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>邮箱</td>
                       <td><input type="text" class="input_code" value="" id="email" name="email" maxlength="50" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>岗位</td>
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
											<option value="食品安全管理人员(专职)">食品安全管理人员(专职)</option>
											<option value="食品安全管理人员(兼职)">食品安全管理人员(兼职)</option>
											<option value="原料采购人员">原料采购人员</option>
											<option value="分餐人员">分餐人员</option>
											<option value="专间操作人员">专间操作人员</option>
											<option value="餐饮具消毒人员">餐饮具消毒人员</option>
											<option value="餐饮主管人员">餐饮主管人员</option>
											<option value="厨师">厨师</option>
											<option value="其他" >其他</option>
										</select>
									</div>
								</div>
							</td>
                   </tr>
                </table>  
                <div class="photo_report" style="margin:0;position:absolute;top:2px; left:620px; z-index:200;">
                     <div class="upload_thumib"  id="upload_thumib">
                          <div class="photo_upload" style="margin:0 auto;">
                              <i class="i_upload_user"></i>
                              <em class="upload_small_text">上传照片</em>
                          </div>
                          <input name="EMPLOYEE_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload" id="small_upload"/>
                     </div>
                     <div class="licen_img" id="licen_img" style="display:none;">
                          <div rel="img" style="border:1px dotted #ddd;" id="previewImg"><img src="../images/i_user.jpg" id="photoPath"/></div>
                          <a href="javascript:void(0)" class="del_img" title="删除"></a>
                     </div>
                </div>
          </div>
          <p class="save_box">
             <input type="button" class="btn_save" value="保存" id="save" />
             <input type="button" class="btn_save" value="重置"  id="reset"/>
          </p>
           </form>
     </div>
</div>    
<script type="text/javascript">
//建立一個可存取到該file的url
function getObjectURL(file) {
	var url = null ; 
	if (window.createObjectURL!=undefined) { // basic
		url = window.createObjectURL(file) ;
	} else if (window.URL!=undefined) { // mozilla(firefox)
		url = window.URL.createObjectURL(file) ;
	} else if (window.webkitURL!=undefined) { // webkit or chrome
		url = window.webkitURL.createObjectURL(file) ;
	}
	return url ;
}
function checkMail(mail) {
	 var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	 if (filter.test(mail)) return true;
	 else {
	 return false;}
	}

function identity(num) {
	 var identity  =/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/ ;
	 if (identity.test(num)) return true;
	 else {
	 return false;}
	}
	
function isNull(object){
	if(object==null||object==""||object=="null"){
		return true;
	}else{
		return false;
	}
}
var id="<%=id %>";
var restIdList=new Array;
var employee={};
//重置方法
$("#reset").click(function(){
	$(".text_ts").remove();
	var personId=employee.personId;
	var personName=isnull(employee.personName);//人员名称
	var jobRole=isnull(employee.jobRole);//岗位
	var sex=isnull(employee.sex);//性别
	var idTypeValue=isnull(employee.idTypeValue);//证件类型
	var mobilePhone=isnull(employee.mobilePhone);//手机号码
	var phone=isnull(employee.phone);//电话号码
	var idNumber=isnull(employee.idNumber);//证件号码
	var email=isnull(employee.email);//邮箱
	var photoPath=isnull(employee.photoPath);//图片地址
	$("#phone").val(phone);
	$("#personId").val(personId);
	if(photoPath!=""){
		$("#upload_thumib").hide();
		$("#licen_img").show();
		$("#photoPath").attr("src","<%=fdWebFileURL%>"+photoPath);
	}
	$("#personName").val(personName);
	if(jobRole!=""){
		$("#jobRole option").each(function() {
			if ($(this).text() == jobRole) {
				$(this).attr("selected", "selected");
			}
		});
	}else{
		$("#jobRole option").eq(0).attr("selected", "selected");
	}
	if (sex == 1) {
		$("#radio_c1").attr("checked", "checked");
	} else {
		$("#radio_c2").attr("checked", "checked");
	}
	$("#idTypeValue").text(idTypeValue+"：   "+idNumber);
	$("#mobilePhone").val(mobilePhone);
	$("#email").val(email);
	if(idTypeValue!=""){
		$("#idType option").each(function() {
			if ($(this).text() == idTypeValue) {
				$(this).attr("selected", "selected");
			}
		});
	}else{
		$("#idType option").eq(0).attr("selected", "selected");
	}
	
	$("#idNumber").val(idNumber);
	
});

//查询方法
function queryCompany(id){
	$("#loading").show();
	$(":button").attr("disabled",true);
	$.ajax({
		url:"../restaurant/comEmployee/getComEmployee/"+id,
		type:"post",
		dataType:"json",
		success:function(result){
			$(":button").attr("disabled",false);
			if(result.status==0){
				 employee=result.body.employee;
				 console.log(employee);
				var personId=employee.personId;
				var personName=isnull(employee.personName);//人员名称
				var jobRole=isnull(employee.jobRole);//岗位
				var sex=isnull(employee.sex);//性别
				var idTypeValue=isnull(employee.idTypeValue);//证件类型
				var mobilePhone=isnull(employee.mobilePhone);//手机号码
				var phone=isnull(employee.phone);//电话号码
				var idNumber=isnull(employee.idNumber);//证件号码
				var email=isnull(employee.email);//邮箱
				var photoPath=isnull(employee.photoPath);//图片地址
				var photoId=isnull(employee.photoId);
				var isPhoneReg = employee.isPhoneReg;
				if(isPhoneReg==1){
					$("#mobilePhone").attr("disabled",true);
					$("#verified").show();
				}
				$("#phone").val(phone);
				if(photoPath!=""){
					$("body").data("id",photoId);
					$("#upload_thumib").hide();
					$("#licen_img").show();
					$("#photoPath").attr("src","<%=fdWebFileURL%>"+photoPath);
				}
				$("#personName").val(personName);
				if(jobRole!=""){
					$("#jobRole option").each(function() {
						if ($(this).text() == jobRole) {
							$(this).attr("selected", "selected");
						}
					});
				}
				
				if (sex == 1) {
					$("#radio_c1").attr("checked", "checked");
				} else {
					$("#radio_c2").attr("checked", "checked");
				}
				$("#idTypeValue").text(idTypeValue+"：   "+idNumber);
				$("#mobilePhone").val(mobilePhone);
				$("#email").val(email);
				$("#idType option").each(function() {
					if ($(this).text() == idTypeValue) {
						$(this).attr("selected", "selected");
					}
				});
				$("#idNumber").val(idNumber);
					}
			$("#loading").hide();
				},
				error : function() {
					alert("系统异常,数据加载失败");
					$("#loading").hide();
				}
			});
		}
function previewImg(obj){
	$(".text_ts").remove();
  	if($.browser.msie){
  		var ie=$.browser.version;
  		if(ie=="11.0"||ie=="10.0"){
  			if (obj.files &&obj.files[0]){
  				var picval = parseInt(obj.files[0].size/1048576);
  				if (picval >= 1){
  					$(obj).parent().after('<span class="text_ts">'+obj.files[0].name +'  大于1M, 上传图片建议小于1M </span>');;
  					obj.value="";
  					return  ;
  				};
  			 } 
  			var objUrl = getObjectURL(obj.files[0]) ;
  			console.log(objUrl);
  			if (objUrl) {
  				$("#photoPath").attr("src", objUrl) ;
  				$("#photoPath").parent().parent().show(); 
  				$(".upload_thumib").hide();
  			};
  		}else{
  			alert("上传图片,目前暂不支持IE 9及以下版本");
  			obj.value="";
  			return;
  		}
  		
/*  		obj.select();
 		var nfile = document.selection.createRange().text;
 		document.selection.empty();
 		document.getElementById("previewImg").style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src='"+nfile+"')";
 		$(".upload_thumib").hide();
 		$("#previewImg").find("img").remove();
 		$("#previewImg").parent().show(); */
	}else{ 
		if (obj.files &&obj.files[0]){
			var picval = parseInt(obj.files[0].size/1048576);
			if (picval >= 1){
				$(obj).parent().after('<span class="text_ts">'+obj.files[0].name +'  大于1M, 上传图片建议小于1M </span>');;
				obj.value="";
				return  ;
			};
		 } 
		var objUrl = getObjectURL(obj.files[0]) ;
		if (objUrl) {
			$("#photoPath").attr("src", objUrl) ;
			$("#photoPath").parent().parent().show(); 
			$(".upload_thumib").hide();
		};
	} ;
}
function deleteImage(attachId){
	var restIdList=new Array;
	$("#loading").show();
	 restIdList.push(attachId);
	$.ajax({
		url:"../delAttachments",
		type:"post",
		headers: { 
			'X-CSRF-TOKEN': '${_csrf.token}',
			'Accept': 'application/json',
			'Content-Type': 'application/json' 
		},
		dataType:'json',
		data:JSON.stringify(restIdList),
		async : false,
		success:function(result) {
			$("#loading").hide();
		},   
		error:function(text){
			alert("系统异常,删除失败");
			return false;
		}
	});
}
$(function(){
	queryCompany(id);
 	$("body").on("blur","input[type='text']",function(){
 		$(this).next(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    }
	}); 
    // ajaxSubmit
    $("#save").live("click",function(){
    	var ajaxFig=true;
	$(".text_ts").remove();
	$("body input[type='text']").each(function(){
	    var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    	ajaxFig=false;
	    	return false;
	    }
	});
	if(ajaxFig==false){
		return false;
	}
	if($.browser.msie){
		var ie=$.browser.version;
		if(ie!="11.0"&&ie!="10.0"){
			alert("本次操作,目前暂不支持IE 9及以下版本");
			return false;
		}
	}
	var personName=$("#personName").val().trim();//名称
	//var jobRole=$("#jobRole option:selected").val();//岗位
	//var sex=$("#sex label input:checked").val();//性别
	var idType=$("#idType option:selected").val();//证件类型
	var idNumber=$("#idNumber").val().trim();//证件号码
	var mobilePhone=$("#mobilePhone").val().trim();//手机号
	var phone=$("#phone").val().trim();// 电话
	var email=$("#email").val().trim();//邮箱

	if(isNull(personName)==true){
		$("#personName").after('<span class="text_ts">请输入姓名 </span>');
		return false;
	}
	if(isNull(idType)==true){
		$("#idNumber").after('<span class="text_ts">请选择证件类型</span>');
		return false;
	}
	if(idType==11005&&identity(idNumber)==false){
		$("#idNumber").after('<span class="text_ts">请输入正确的身份证号码 </span>');
		return false;
	}
	
	if(isNull(idNumber)==true){
		$("#idNumber").after('<span class="text_ts">请输入证件号码 </span>');
		return false;
	}
	if(isNull(mobilePhone)==true||isMobilephone(mobilePhone)==false){
		$("#mobilePhone").after('<span class="text_ts">请输入正确的手机号码 </span>');
		return false;
	}
	if(isNull(phone)==false&&isPhone(phone)==false){
		$("#phone").after('<span class="text_ts">请输入正确的电话号码 </span>');
		return false;
	}
	if(isNull(email)==false&&checkMail(email)==false){
		$("#email").after('<span class="text_ts">请输入正确的邮箱 </span>');
		return false;
	}
	// ajaxForm
		   //提交表单
     var options = {
     success: function (data) {
    	 $("#loading").hide();
    	 $(":button").attr("disabled",false);
     	if(data.status==0){
     	     window.location.href="../findView/restEmployee.restEmployee-editer-photo?id=<%=id%>"; 
     	}else{
     		/* alert("修改失败,存在重复的从业人员"); */
     		alert("从业人员的证件已被使用");
     	}
     }
     };
     $(":button").attr("disabled",true);
     $("#loading").show();
    $("#addForm").ajaxForm(options);
	 $("#addForm").submit();
    });
	//删除上传的预览图片 
	$(".licen_img .del_img").live("click",function(){
		var id=isnull($("body").data("id"));
		if(id!=""){
			deleteImage(id);
			$("body").data("id","");
		}
	       $(this).parent("div").find("img").attr("src","");
		   $(this).parent("div").hide(); 
		   $(this).parent().parent().find(".upload_thumib").show();
		   $(this).parent().parent().find("input:file").val("");
	});
});	
</script>
</body>
</html>