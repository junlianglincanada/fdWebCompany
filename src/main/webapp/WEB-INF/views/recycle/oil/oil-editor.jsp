<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<style type="text/css">
.upload_thumib{margin-right:15px;}
</style>
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" /> 
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<script type="text/javascript">
$(function(){
	   /*--到期日期--*/				   
	   $('#date_para').calendar({ minDate:calDateByDay(-32), maxDate:calDateByDay(10)});
	   
	   /*--输入搜索关键词控制--*/				   
//	  var availableTags = [
//						   "上海长泾油脂有限公司",
//						   "上海华美饮料有限公司", 
//						   "上海力华营销有限公司",
//						   "上海耀剑农产品有限公司",
//						   "上海新华农业信用合作社"
//						   ];
//	  $("#unit_name").autocomplete({
//		  source: availableTags
//	  });
	   
	/*-------jquery end-------*/
	});	
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/recycle.oil.oil?id=<%=id %>">废弃油脂</a> > <a href="#">编辑废弃油脂</a> > <a id="name1"></a> </h3>
          <div class="info_box"> 
			<form id="addForm" action="../recycle/cleanOilComMgr/updateOilRecycleRecord" method="post" enctype="multipart/form-data">
			<input id="unitValue" name="unitValue" style="display:none;"/>
			<input id="unit" name="unit" style="display:none;"/>
			<input id="companyOilRecycleId" name="companyOilRecycleId"style="display:none;"/>
			<input id="typeValue" name="typeValue" style="display:none;"/>
               <table class="info_mation" style="border-bottom:1px solid #dcdddd;">
                  <tr>
                       <td class="td_lf"><em class="star">*</em>台账日期</td>
                       <td><input type="text" class="input_date" id="date_para" value="" name="recycleDate" readonly="readonly" /></td>
                  </tr>
                  <tr>    
                       <td class="td_lf"><em class="star">*</em>种类</td>
                       <td id="type">
                            <label for="radio_c1"><input type="radio" name="radio_c" id="radio_c1" value="31002" /> 废油</label> &nbsp;&nbsp;&nbsp;&nbsp;
                            <label for="radio_c2"><input type="radio" name="radio_c" id="radio_c2" value="31001"/> 含油废水</label>
                       </td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>数量</td>
                       <td><input id="amount" name="amount" type="text" class="input_code" style="width:168px;"maxlength="9"/> 公斤<input id="id" name="id" style="display:none;"/></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>回收单位</td>
                       <td id="name"></td>
                  </tr>
                  <tr>     
                       <td class="td_lf"><em class="star">*</em>回收人</td>
                       <td><input type="text" class="input_code"  id="recyclePerson" name="recyclePerson" style="width:168px;" value="" maxlength="20" /></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>单据图片</td>
                        <td id="into">
                           <div class="photo_licen" style="margin:0; height:auto;float: left;">
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
                              <!-- 怎么做 -->
                             <!--  <div class="licen_img" style="height:auto;padding-left:30px;display:none;">
                                    <div rel="img" style="border:1px dotted #ddd;"  id="previewImg"><img src="../images/i_user.jpg" id="photoPath"/></div>
                          			<a href="javascript:void(0)" class="del_img" title="删除"></a>
                              </div> -->
                              
                         </div>
                         
                       </td>
                  </tr>
                </table>
                </form>
          </div>
           <p class="save_box">
             <input type="button" class="btn_save" value="保存" id="save" />
             <input type="button" class="btn_save" value="返回"  id="reset"/>
          </p>
     </div>
</div>
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

			if(data.body==""){
				alert ("请添加废弃油脂回收单位");
			}else{
				employee=data.body;
				document.getElementById("name").innerHTML = employee.name;
				document.getElementById("name1").innerHTML = employee.name;
				var companyOilRecycleId=employee.id;
				$("#companyOilRecycleId").val(companyOilRecycleId);
		};
		}
          }); 
});
//建立一個可存取到該file的url
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
function isNumber(object) {
	 var filter  = /^[0-9]*$/;
	 if (filter.test(object)) 
		 return true;
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
	window.location.href="../findView/recycle.oil.oil";
});
//查询方法
function queryCompany(id){
	$("#loading").show();
	$("#save").attr("disabled",true);
	$.ajax({
		url:"../recycle/cleanOilComMgr/getOilRecycleRecord/"+id,
		type:"get",
		dataType:"json",
		success:function(result){
			$("#save").attr("disabled",false);
			if(result.status==0){
				 employee=result.body;
				 var id=isnull(employee.id);
				 var amount=isnull(employee.amount);//数量
				 var unitValue=isnull(employee.unitValue);//
				 var unit=isnull(employee.unit);//
				 var typeValue=isnull(employee.typeValue);//类型
				 var companyOilRecycleId=isnull(employee.companyOilRecycleId);//ID
				 var type=isnull(employee.type); //
				 var recyclePerson=isnull(employee.recyclePerson);//回收人
				 var recycleDate=isnull(employee.recycleDate);//日期
				 var roductionList=result.body.dtoAttachments;
//				 var photoPath=isnull(employee.dtoAttachments.photoPath);//图片地址
				$("#id").val(id);
				$("#amount").val(amount);
				$("#unitValue").val(unitValue);
				$("#unit").val(unit);
				$("#companyOilRecycleId").val(companyOilRecycleId);
				$("#typeValue").val(typeValue);
				$("#recyclePerson").val(recyclePerson);
				$("#date_para").val(recycleDate);
				$("#certufucate").children().remove();
				 if(null!=roductionList&&roductionList.length>0){
						for(var i=0;i<roductionList.length;i++){
							var path=imgFilePath+roductionList[i].filePath;
							var id=roductionList[i].id;
// 							var html='<div class="licen_img" ><div rel="img"><img src="'+path+'" /></div><a  href="javascript:void(0)" class="del_img" title="删除" onclick="deleteImage('+id+')"></a></div>';
// 							 $(".upload_thumib").after(html);
								var html='<div style="height:auto;margin-right:8px;"><div class="licen_img"  ><div rel="img" style="border:1px dotted #ddd;" ><img src="'+path+'" id="photoPath"/></div><a href="javascript:void(0)" onclick="deleteImage('+id+')" class="del_img" title="删除"></a></div></div>';
								console.log(html);
								$("#into").append(html);
						}
						 licen_Roll();
					 }
				if (type == 31002) {
					$("#radio_c1").attr("checked", "checked");
				} else {
					$("#radio_c2").attr("checked", "checked");
				}
					}
			$("#loading").hide();
				},
				error : function() {
					alert("系统异常,数据加载失败");
					$("#loading").hide();
				}
			});
		}
//生产许可证
function licen_Roll(){
	var $show_w = $(".photo_licen .show_box").width();
	var $img_w  = $(".licen_img").width();
	var $img_len = $(".licen_img").length;
	var $con_w = ($img_w+18) * $img_len;
	$(".photo_licen .show_con").width($con_w);
//		alert($img_len);
	if($con_w >= $show_w ){
	    $(".photo_licen .show_rt").show();
		$(".photo_licen .show_rt").click(function(){
				$(".photo_licen .show_lf").show();								   
		        $(".licen_img:first").remove().appendTo(".photo_licen .show_con");
				$(".photo_licen .show_lf").click(function(){
						$(".licen_img:last").remove().prependTo(".photo_licen .show_con");
				});
		});
	} else {
		$(".photo_licen .show_box").css({"padding-left":"0px"});
	    return false;
	}
};
// var img = new Image();
// function previewImg(obj){
// 	$(".text_ts").remove();
// 		if (obj.files &&obj.files[0]){
// 			var picval = parseInt(obj.files[0].size/1048576);
// 			if (picval >= 1){
// 				$(obj).parent().after('<span class="text_ts">'+obj.files[0].name +'  大于1M, 上传图片建议小于1M </span>');;
// 				obj.value="";
// 				return  ;
// 			}
// 		/* } */
// 		var objUrl = getObjectURL(obj.files[0]) ;
// 		console.log(objUrl);
// 		if (objUrl) {
// 			$("#certufucate").attr("src", objUrl) ;
// 			$("#certufucate").parent().parent().show(); 
// 			$(".upload_thumib").hide();
// 		}
// 	} 
// }
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
  				var html=' <div style="margin:0; height:auto;"><div class="upload_thumib"  ><div class="photo_upload" style="margin:0 auto;"><i class="i_upload_small"></i><em class="upload_small_text">上传图片<br/>建议小于1M</em></div><input name="OIL_RECYCLE_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload"/></div><div><div class="licen_img" style="display:none;"><div rel="img" style="border:1px dotted #ddd;"><img src="../images/i_user.jpg" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div><div></div>';
  				$("#into").prepend(html);
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
			$("#into").prepend(html);
			$(obj).parent().parent().find("img").attr("src", objUrl) ;
			$(obj).parent().parent().find(".licen_img").show();
		};
	} ;
}
//删除上传的预览图片 
$(".licen_img .del_img").live("click",function(){
    $(this).parent("div").find("img").attr("src","");
	   $(this).parent("div").hide(); 
	   $(this).parent().parent().find("input:file").val("");
});
$(function (){
	queryCompany(id);
	$("body").on("focus","input[id='amount']",function(){
		$(this).siblings(".text_ts").remove();
	}); 
	$("body").on("blur","input[id='amount']",function(){
		$(this).siblings(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	$("#id").after('<span class="text_ts">请输入正确格式的数字(例:2.22),最高保留两位小数</span>');
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
    // ajaxSubmit
    $("#save").live("click",function(){

     $(".info_mation").find(".text_ts").remove();
   	 $("#loading").show();
	 $(":button").attr("disabled",true);
    	$(".info_mation").find(".text_ts").remove();
    	if(null!=restIdList&&restIdList.length>0){
    		deleteImageList(restIdList);
    	}
    	$(".info_mation").find(".text_ts").remove();
	$(".text_ts").remove();
	var id=$("#id").val().trim();
	var amount=$("#amount").val().trim();//
	var unitValue=$("#unitValue").val().trim();//
	$("#type label input:checked").attr("name", "type");
	var type=$("#type label input:checked").text();
	$("#typeValue").val(type);
	var unit=$("#unit").val().trim();//
	var companyOilRecycleId=$("#companyOilRecycleId").val().trim();//
	var recyclePerson=$("#recyclePerson").val().trim();// 
	var recycleDate=$("#date_para").val().trim();
	// ajaxForm
	   //提交表单
	if(recycleDate==""||recycleDate==null){
		$("#date_para").after('<span class="text_ts">请选择日期 </span>');

		$("#loading").hide();
		$(":button").attr("disabled",false);
		return false;
	}
	if(amount==""||amount==null){
			
			$("#id").after('<span class="text_ts">数量不能为空 </span>');
			$("#loading").hide();
			$("#save").attr("disabled",false);
			return false;
		}
	if(amount>999999.99){
		$("#id").after('<span class="text_ts">请输入正确的数量 </span>');
		$("#loading").hide();
		$("#save").attr("disabled",false);
		return false;
	}
	 var str=amount;
	 var pattern =/^[0-9]+([.]\d{1,2})?$/;
	 if(!pattern.test(str)){
	     $("#id").after('<span class="text_ts">请输入正确格式的数字(例:2.22),最高保留两位小数 </span>');
		 $("#loading").hide();
		 $("#save").attr("disabled",false);
	    return false;
	 }

	 if(checkSpecificKey(recyclePerson)==false){
	    	$("#recyclePerson").after('<span class="text_ts">请勿输入特殊字符 </span>');
	    	$("#loading").hide();
			$(":button").attr("disabled",false);
			return false;
	    }
	if(recyclePerson==""||recyclePerson==null){
		$("#recyclePerson").after('<span class="text_ts">回收人姓名不能为空 </span>');
		$("#loading").hide();
		$("#save").attr("disabled",false);
		return false;
	}
var options = {
success: function (data) {
	if(data.status==0){
	     window.location.href="../findView/recycle.oil.oil"; 
	}else{

		 $("#loading").hide();
		 $(":button").attr("disabled",false);
		alert("服务器异常,修改失败");
	}
}
};

// $("#save").attr("disabled",true);
// $("#loading").show();

$("#addForm").ajaxForm(options);
$("#addForm").submit();
$("#test3").val("");
    });

});	
function deleteImage(attachId){
	restIdList.push(attachId);
}
function deleteImageList(attachId){
// 	restIdList.push(attachId);

	$.ajax({
		url:"../delAttachments",
		type:"post",
	    headers: { 
	    	  'X-CSRF-TOKEN': '${_csrf.token}',
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
	    data:JSON.stringify(attachId),
		success:function(text) {
	          console.log(text.body);
	          if(text.status==0){
	        	  search(id);
	          }
		 },   
		 error:function(text) {
		 return false;
		 }
		});
}
</script>
</body>
</html>