<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/restEmployee.restEmployeeView">从业人员</a> > <a href="#">编辑从业人员</a> </h3>
          <div class="info_tab">
               <a href="../findView/restEmployee.restEmployee-editer?id=<%=id%>">基本信息</a>
               <a href="../findView/restEmployee.restEmployee-editer-photo?id=<%=id%>" class="default">证件信息</a>
          </div>
           <form id="uploadForm" action="../restaurant/comEmployee/updateComEmpLicence" method="post" enctype="multipart/form-data">
          <div class="info_box"> 
          <input id="personId" name="personId" value="<%=id %>" style="display:none;"/>
               <table class="info_mation" style="border-bottom:1px solid #dcdddd;">
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>健康证号码</td>
                       <td><input type="text" class="input_code" value="" id="licenceNum" style=" width:168px;" name="licenceNum" maxlength="30"/></td>                   
                  </tr>
                  <tr>
                    <td class="td_lf" ><em class="star">&nbsp;</em>到期日期</td>
                    <td><input type="text" class="input_date" id="expireDate"  value="" readonly="readonly" name="licenceNumExpireDate" /></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>健康证图片</td>
                       <td>
                           <div class="photo_report" style="margin:0;">
                              <div class="upload_thumib" id="upload_thumib" >
                                   <div class="photo_upload" style="margin:0 auto;">
                                        <i class="i_upload_small"></i>
                                        <em class="upload_small_text">上传图片<br/><b>建议小于1M</b></em>
                                   </div>
                                   <input onchange="previewImg(this)" name="EMPLOYEE_LINCENCE" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload1"/>
                              </div>
                              <div class="licen_img" style="display:none;" id="licen_img">
                                   <div rel="img"><img src="" id="filePath"/></div>
                                   <a href="javascript:void(0)" class="del_img" title="删除"></a>
                              </div>
                          </div>
                       </td>
                  </tr>
                </table>
                <table class="info_mation">
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>培训证号码</td>
                       <td><input type="text" class="input_code" style=" width:168px;" value="" id="trainingOrgType" name="trainLicenceNum" maxlength="18"/></td>
                      
                  </tr>
                  <tr> 
                       <td class="td_lf"><em class="star">&nbsp;</em>等级</td>   
                       <td >
                           <div class="select_s" style="width:188px;">
                            <div class="select_is" style="width:188px;">
                               <select class="select_cs" style="width:218px; background-position:-6px -122px; " name="licenceLevel" id="licenceLevel">
                                      <option value="27012">A1</option>
                                      <option value="27013">A2</option>
                                       <option value="27016">A3</option>
                                      <option value="27014">B</option>
                                      <option value="27015">C</option>
                                      <option value="27017">D</option>
                               </select>
                             </div>
                           </div>
                       </td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>到期日期</td>
                       <td><input type="text" class="input_date" id="endDate" value="" readonly="readonly" name="trainLicenceNumExpireDate" /></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>培训证图片</td>
                       <td>
                           <div class="photo_report" style="margin:0;">
                           
                              <div class="upload_thumib" id="upload_thumib1" >
                                   <div class="photo_upload" style="margin:0 auto;" >
                                        <i class="i_upload_small"></i>
                                        <em class="upload_small_text">上传图片<br/><b>建议小于1M</b></em>
                                   </div>
                                   <input onchange="previewImg(this)" name="EMPLOYEE_TRAIN_LINCENCE" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload"/>
                              </div>
                              <div class="licen_img" style="display:none;" id="licen_img1">
                                   <div rel="img"><img src=""  id="trainingImg"/></div>
                                   <a href="javascript:void(0)" class="del_img" title="删除"></a>
                              </div>
                              
                          </div>
                       </td>
                  </tr>
                </table>
                
          </div>
          <p class="save_box">
             <input type="button" class="btn_save" value="保存" id="save" />
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

function isNull(object){
	if(object==null||object==""||object=="null"){
		return true;
	}else{
		return false;
	}
}
var id="<%=id %>";
//查询方法
function queryCompany(id){
	$("#loading").show();
	$.ajax({
		url:"../restaurant/comEmployee/getComEmployee/"+id,
		type:"post",
		dataType:"json",
		success:function(result){
			if(result.status==0){
				
				var licence=isnull(result.body.licence);
				console.log(licence);
				if(licence!=""){
					for(var i=0;i<licence.length;i++){
						if(licence[i].licenceType==26001){
							var expireDate=isnull(licence[i].expireDate);
							var filePath=isnull(licence[i].filePath);
							var licenceNum=isnull(licence[i].licenceNum);
							var fileId=isnull(licence[i].fileId);
							$("#expireDate").val(expireDate);
							$("#licenceNum").val(licenceNum);
							if(filePath!=""){
								$("#filePath").data("id",fileId);
								$("#upload_thumib").hide();
								$("#licen_img").show();
								$("#filePath").attr("src","<%=fdWebFileURL%>"+filePath);
							}
						}
						if(licence[i].licenceType==26002){
							var expireDate=isnull(licence[i].expireDate);
							var filePath=isnull(licence[i].filePath);
							var licenceNum=isnull(licence[i].licenceNum);
							var licenceLevelValue=isnull(licence[i].licenceLevelValue);
							var fileId=isnull(licence[i].fileId);
							if(licenceLevelValue!=""){
								$("#licenceLevel option").each(function() {
									if ($(this).text() == licenceLevelValue) {
										$(this).attr("selected", "selected");
									}
								});
							}
							$("#endDate").val(expireDate);
							$("#trainingOrgType").val(licenceNum);
							if(filePath!=""){
								$("#trainingImg").data("id",fileId);
								$("#upload_thumib1").hide();
								$("#licen_img1").show();
								$("#trainingImg").attr("src","<%=fdWebFileURL%>" + filePath);
								}
							}
						}
					}
					$("#loading").hide();
				}
			},
			error : function() {
				alert("系统异常,数据加载失败");
				$("#loading").hide();
			}
		});
	}
function previewImg(obj){
	$(".text_ts").remove();
	var num=isnull($(obj).parent().parent().parent().parent().parent().find("input").eq(0).val());
	if(num==""){
		$(obj).parent().parent().parent().parent().parent().parent().find("input").eq(0).after('<span class="text_ts">请输入证件号码 </span>');
		$(obj).val("");
		return ;
	}
	var ie=$.browser.version;
	if($.browser.msie){
		if(ie=="11.0"||ie=="10.0"){
			if (obj.files &&obj.files[0]){
				var picval = parseInt(obj.files[0].size/1048576);
				if (picval >= 1){
					$(obj).parent().after('<span class="text_ts">'+this.files[0].name +'  大于1M, 上传图片建议小于1M </span>');;
					obj.value="";
					return ;
				}
			}
			var objUrl = getObjectURL(obj.files[0]) ;
			if (objUrl) {
				$(obj).parent().parent().find("img").attr("src", objUrl) ;
				$(obj).parent().hide();
				$(obj).parent().parent().find(".licen_img").show(); 
			}
		}else{
			alert("上传图片,目前暂不支持IE 9及以下版本");
			$(obj).val("");
		}
	}else{
		if (obj.files &&obj.files[0]){
			var picval = parseInt(obj.files[0].size/1048576);
			if (picval >= 1){
				$(obj).parent().after('<span class="text_ts">'+obj.files[0].name +'  大于1M, 上传图片建议小于1M </span>');;
				obj.value="";
				return ;
			}
		}
		var objUrl = getObjectURL(obj.files[0]) ;
		if (objUrl) {
			$(obj).parent().parent().find("img").attr("src", objUrl) ;
			$(obj).parent().hide();
			$(obj).parent().parent().find(".licen_img").show(); 
			
		}
	}
	
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
	$(function() {
		queryCompany(id);
		$("body").on("blur","input[type='text']",function(){
	 		$(this).next(".text_ts").remove();
			var inputValue=	$(this).val();
		    if(checkSpecificKey(inputValue)==false){
		    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
		    }
		});
		
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
			var licenceNum=$("#licenceNum").val().trim();//健康证号
			var expireDate=$("#expireDate").val().trim();
			var small_upload1=$("#small_upload1").val().trim();
			if(isNull(licenceNum)==true&&small_upload1!=""){
				$("#licenceNum").after('<span class="text_ts">请输入证件号码 </span>');
				return false;
			} 
			if(isNull(licenceNum)==true&&isNull(expireDate)==false){
				$("#licenceNum").after('<span class="text_ts">请输入证件号码 </span>');
				return false;
			}
			
			if(isNull(expireDate)==true&&isNull(licenceNum)==false){
				$("#expireDate").after('<span class="text_ts">请选择到期日期 </span>');
				return false;
			}
			
			if(isNull(licenceNum)==true&&isnull($("#filePath").attr("src"))!=""){
				$("#licenceNum").after('<span class="text_ts">请输入证件号码 </span>');
				return false;
			} 

			var trainingOrgType=$("#trainingOrgType").val().trim();
			var endDate=$("#endDate").val().trim();
			var small_upload=isnull($("#small_upload").val());
		 	if(isNull(trainingOrgType)==true&&small_upload!=""){
				$("#trainingOrgType").after('<span class="text_ts">请输入证件号码 </span>');
				return false;
			} 
		 	if(isNull(trainingOrgType)==true&&isNull(endDate)==false){
				$("#trainingOrgType").after('<span class="text_ts">请输入证件号码 </span>');
				return false;
			}
		 	if(isNull(endDate)==true&&isNull(trainingOrgType)==false){
				$("#endDate").after('<span class="text_ts">请选择到期日期 </span>');
				return false;
			}
		 	if(isNull(trainingOrgType)==true&&isnull($("#trainingImg").attr("src"))!=""){
				$("#trainingOrgType").after('<span class="text_ts">请输入证件号码 </span>');
				return false;
			} 
			$("body input[type='text']").each(function(){
	    	    var inputValue=	$(this).val();
	    	    if(checkSpecificKey(inputValue)==false){
	    	    	$(this).after('<span class="text_ts">请务输入特殊字符 </span>');
	    	    	return false;
	    	    }
	    	});
			// ajaxForm
			   //提交表单
	     var options = {
	     success: function (data) {
	    	 $(":button").attr("disabled",false);
	    	 $("#loading").hide();
	     	if(data.status==0){
	     	     window.location.href="../findView/restEmployee.restEmployeeView"; 
	     	}
	     }
	     };
	     $("#loading").show();
	     $(":button").attr("disabled",true);
	    $("#uploadForm").ajaxForm(options);
		 $("#uploadForm").submit();
			
		});
		
		/*--到期日期--*/
		$('#expireDate').calendar();
		$('#endDate').calendar();
		
		//删除上传的预览图片 
		$(".licen_img .del_img").live("click",function(){
			  var id=isnull($(this).parent().find("img").data("id"));
			  if(id!=""){
				  deleteImage(id);
				  $(this).parent().find("img").data("id","");
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