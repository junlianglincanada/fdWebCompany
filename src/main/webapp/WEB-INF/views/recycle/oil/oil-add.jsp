<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
.upload_thumib{margin-right:15px;}
</style>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function () {
	//回收单位
	$.ajax({
		url:"../restaurant/oilCleanComMgr/listCompanyOilRecycle",
	      headers: { 
              'Accept': 'application/json',
              'Content-Type': 'application/json' 
          },
		type: "get",
		data:"json",
		success:function(data){
			if(data.body==null){
				alert("请添加废弃油脂回收单位");
				$(".btn_blue").click(function(){
        			location.href="../findView/recycle.unit.unit";
        		});
			}else{
				employee=data.body;
				document.getElementById("name").innerHTML = employee.name;
				var companyOilRecycleId=employee.id;
				$("#companyOilRecycleId").val(companyOilRecycleId);
			};
			}
          }); 
});
var params={};
function isNumber(object) {
	 var filter  = /^[0-9]*$/;
	 if (filter.test(object)) 
		 return true;
	 else {
	 return false;}
	}
function isnull(object){
	if(object==null||object==""||object=="null"){
		return true;
	}else{
		return false;
	}
}
function getObjectURL(file) {
	var url = null ; 
	if($.browser.safari){//Safari
	     alert("您的浏览器不支持图片预览功能，"+"请选择其它浏览器！");
		 obj.value="";
		 return false;
	}
	else{
	if (window.createObjectURL!=undefined) { // basic
		url = window.createObjectURL(file) ;
	} else if (window.URL!=undefined) { // mozilla(firefox)
		url = window.URL.createObjectURL(file) ;
	} else if (window.webkitURL!=undefined) { // webkit or chrome
		url = window.webkitURL.createObjectURL(file) ;
	}
	return url ;
}}
function isLience(object) {
	 var filter  = /^[a-zA-Z0-9]*$/;
	 if (filter.test(object)) 
		 return true;
	 else {
	 return false;
	 }
}
$(function(){
	/* $('#date_para').calendar(); */
	 $('#date_para').calendar({ minDate:calDateByDay(-32), maxDate:calDateByDay(10)});
	$("body").on("focus","input[id='amount']",function(){
		$(this).siblings(".text_ts").remove();
	}); 
	$("body").on("blur","input[id='amount']",function(){
		$(this).siblings(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	$("#id").after('<span class="text_ts">请输入正确格式的数字(例:2.22),最高保留两位小数 </span>');
	    }
	}); 
	$("body").on("focus","input[id='recyclePerson']",function(){
		$(this).siblings(".text_ts").remove();
	}); 
	$("body").on("blur","input[id='recyclePerson']",function(){
		$(this).siblings(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	$("#recyclePerson").after('<span class="text_ts">请勿输入特殊字符 </span>');
	    }
	}); 
    $("#btn_save").live("click",function(){
    	$("#loading").show();
    	$(".info_mation").find(".text_ts").remove();

    	$("#reset").attr("disabled",true);
        $("#btn_save").attr("disabled",true);
	$("#type label input:checked").attr("name", "type");
	$(".info_mation").find(".text_ts").remove();
	var companyOilRecycleId=$("#companyOilRecycleId").val().trim();
	var recyclePerson=$("#recyclePerson").val().trim();
	var amount=$("#amount").val().trim();
	var recycleDate=$("#date_para").val().trim();
	var typevalue=$("#type label input:checked").text();
	$("#typeValue").val(typevalue);
	$("#companyOilRecycleId").val(companyOilRecycleId);


	if(recycleDate==""||recycleDate==null){
		$("#date_para").after('<span class="text_ts">请选择日期 </span>');

		$("#loading").hide();
		$("#btn_save").attr("disabled",false);
		$("#reset").attr("disabled",false);
		return false;
	}
	if(amount==""||amount==null){
		$("#id").after('<span class="text_ts">数量不能为空 </span>');
		$("#loading").hide();
		$("#btn_save").attr("disabled",false);
		$("#reset").attr("disabled",false);
		return false;
		}
	if(amount>999999.99){
		$("#id").after('<span class="text_ts">请输入正确的数量 </span>');
		$("#loading").hide();
		$("#btn_save").attr("disabled",false);
		$("#reset").attr("disabled",false);
		return false;
	}
	 var str=amount;
	 var pattern =/^[0-9]+([.]\d{1,2})?$/;
	 if(!pattern.test(str)){
	     $("#id").after('<span class="text_ts">请输入正确格式的数字(例:2.22),最高保留两位小数 </span>');
		 $("#loading").hide();
		 $("#btn_save").attr("disabled",false);
		 $("#reset").attr("disabled",false);
	    return false;
	 }

	    if(checkSpecificKey(recyclePerson)==false){
	    	$("#recyclePerson").after('<span class="text_ts">请勿输入特殊字符 </span>');
	    	$("#loading").hide();
			$("#btn_save").attr("disabled",false);
			$("#reset").attr("disabled",false);
	    	return false;
	    }
	if(recyclePerson==""||recyclePerson==null){
		$("#recyclePerson").after('<span class="text_ts">回收人姓名不能为空 </span>');
		$("#loading").hide();
		$("#btn_save").attr("disabled",false);
		$("#reset").attr("disabled",false);
		return false;
	}
	// ajaxForm
	   //提交表单
var options = {
success: function (data) {
	/*  console.log(data); */
	 $("#loading").hide();
	if(data.status==0){
	    window.location.href="../findView/recycle.oil.oil"; 
	}else{
		//alert("服务器异常,保存失败");

		$("#loading").hide();
		$("#btn_save").attr("disabled",false);
		$("#reset").attr("disabled",false);
	}
}
};
$("#addForm").ajaxForm(options);
$("#addForm").submit();
	});
});
function previewImg(obj){
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
  			if (objUrl) {
  				$(obj).parent().hide();
  				var html=' <div style="margin:0; height:auto;"><div class="upload_thumib"  ><div class="photo_upload" style="margin:0 auto;"><i class="i_upload_small"></i><em class="upload_small_text">上传图片<br/>建议小于1M</em></div><input name="OIL_RECYCLE_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload"/></div><div class="licen_img"style="display:none;"><div rel="img" style="border:1px dotted #ddd;"><img src="../images/i_user.jpg" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div></div>';
  				$("#certufucate").prepend(html);
  				$(obj).parent().parent().find("img").attr("src", objUrl) ;
  				$(obj).parent().parent().find(".licen_img").show();
//   				$(".upload_thumib").hide();
  			};
  		}else{
  			alert("上传图片,目前暂不支持IE 9及以下版本");
  			obj.value="";
  			return;
  		}
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
		console.log(objUrl);
		if (objUrl) {
			console.log("22");
			$(obj).parent().hide();
			var html='<div style="height:auto;margin-right:8px;"><div class="upload_thumib" ><div class="photo_upload" style="margin:0 auto;"><i class="i_upload_small"></i><em class="upload_small_text">上传图片<br/>建议小于1M</em></div><input name="OIL_RECYCLE_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload" /></div><div class="licen_img"  style="display:none;"><div rel="img" style="border:1px dotted #ddd;" ><img src="../images/i_user.jpg" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div></div>';
			console.log(html);
			$("#certufucate").prepend(html);
			$(obj).parent().parent().find("img").attr("src", objUrl) ;
			$(obj).parent().parent().find(".licen_img").show();
		};
	} ;
}
//删除上传的预览图片 
$(".licen_img .del_img").live("click",function(){
       $(this).parent().parent().remove();
});
$("#reset").live("click",function(){
	window.location.href="../findView/recycle.oil.oil";
});
</script>
</head>
<body>
<div class="main_box">
<form id="addForm" action="../recycle/cleanOilComMgr/addOilRecycleRecord" method="post" enctype="multipart/form-data">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/recycle.oil.oil">废弃油脂</a> > <a href="#">新增废弃油脂</a> </h3>
          <div class="info_box"> 
               <table class="info_mation" style="border-bottom:1px solid #dcdddd;">
                  <tr>
                       <td class="td_lf"><em class="star">*</em>台账日期</td>
                       <td><input type="text" class="input_date" id="date_para" name ="recycleDate"  readonly="readonly"/></td>               
                  </tr>
                  <tr>    
                       <td class="td_lf"><em class="star">*</em>种类</td>
                       <td id="type">
                            <label><input type="radio" value="31002" name="radio_c" checked="checked"/> 废油</label> &nbsp;&nbsp;&nbsp;&nbsp;
                            <label><input type="radio" value="31001" name="radio_c" /> 含油废水</label>
                       </td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>数量</td>
                       <td>
                       <input id="amount" name="amount"type="text" class="input_code" value="" style="width:168px;"maxlength="9" /> 公斤
                       <input id="id" name="id" type="hidden" />
                       <input id="unit" name="unit" type="hidden" />
                       <input id="typeValue" name="typeValue" type="hidden" />
                       <input id="unitValue" name="unitValue" type="hidden" />
                       <input id="companyOilRecycleId" name="companyOilRecycleId" type="hidden" /></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>回收单位</td>
                       <td id="name"></td>
                  </tr>
                  <tr>     
                       <td class="td_lf"><em class="star">*</em>回收人</td>
                       <td><input type="text" class="input_code" value="" name = "recyclePerson"id="recyclePerson" style="width:168px;"maxlength="20" /></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>单据图片</td>
                        <td id="certufucate">
                        <div class="" style="margin:0; height:auto;">
                          <div class="upload_thumib"  id="upload_thumib">
                           <div class="photo_upload" style="margin:0 auto;">
                              <i class="i_upload_small"></i>
                              <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                          </div>
                          <input name="OIL_RECYCLE_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload" id="small_upload"/>
                     </div>
                     <div class="licen_img"  style="display:none;">
                          <div rel="img" style="border:1px dotted #ddd;" id="previewImg"><img src="../images/i_user.jpg" id="photoPath"/></div>
                          <a href="javascript:void(0)" class="del_img" title="删除"></a>
                     </div>
                        </div>
                       </td>
                  </tr>
                </table>
          </div>
          <p class="save_box">
             <input type="button" id="btn_save" class="btn_save" value="保存" />
             <input type="button" id="reset" class="btn_save" value="返回"/>
          </p>
          </div>
     </form>
</div>
</body>
</html>