<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.wondersgroup.framework.util.FileUploadUtils"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../include.jsp" %>
<script type="text/javascript">
$(function(){
	//进货台账提交模板excel

    // ajaxForm
    $("#uploadFormInputBath").ajaxForm(options);
    // ajaxSubmit
    $("#uploadFormInputButton").click(function () {
    	$("#inputupload_name").val("");
    	$("#uploadFormInputButton").attr("disabled",true);
    	$("#uploadFormInputButton").removeClass("import_upload").addClass("import_gray")
		$("#uploadFormInputBath").submit();
    	$("#loading").show();
    });
    


    //发货台账提交模板excel
    // ajaxForm
    $("#uploadFormOutputBath").ajaxForm(optionsOutput);
    // ajaxSubmit
    $("#uploadFormOutputButton").click(function () {
    	$("#outputupload_name").val("");
		$("#uploadFormOutputButton").attr("disabled",true);
		$("#uploadFormOutputButton").removeClass("import_upload").addClass("import_gray")
        $("#uploadFormOutputBath").submit();
     	$("#loading").show();
    });
    
  	//留样台账提交模板excel

    // ajaxForm
    $("#uploadFormSampleBath").ajaxForm(sampleOptions);
    // ajaxSubmit
    $("#uploadFormSampleButton").click(function () {
     	$("#sampleupload_name").val("");
    	$("#uploadFormSampleButton").attr("disabled",true);
    	$("#uploadFormSampleButton").removeClass("import_upload").addClass("import_gray")
        $("#uploadFormSampleBath").submit();
     	$("#loading").show();
    });

   	//采购品
    // ajaxForm  uploadFormInputMaterialButton
    $("#uploadFormInputMaterial").ajaxForm(inputMaterialOptions);
    // ajaxSubmit
    $("#uploadFormInputMaterialButton").click(function () {
     	$("#inputMaterialupload_name").val("");
    	$("#uploadFormInputMaterialButton").attr("disabled",true);
    	$("#uploadFormInputMaterialButton").removeClass("import_upload").addClass("import_gray")
        $("#uploadFormInputMaterial").submit();
     	$("#loading").show();
    });
    
   	// 产出品
    // ajaxForm  uploadFormInputMaterialButton
    $("#uploadFormOutputMaterial").ajaxForm(outputMaterialOptions);
    // ajaxSubmit
    $("#uploadFormOutputMaterialButton").click(function () {
     	$("#outputMaterialupload_name").val("");
    	$("#uploadFormOutputMaterialButton").attr("disabled",true);
    	$("#uploadFormOutputMaterialButton").removeClass("import_upload").addClass("import_gray")
        $("#uploadFormOutputMaterial").submit();
     	$("#loading").show();
    });
    
 	//供应商
    // ajaxForm  uploadFormInputMaterialButton
    $("#uploadFormSupplier").ajaxForm(supplierOptions);
    // ajaxSubmit
    $("#uploadFormSupplierButton").click(function () {
     	$("#supplierupload_name").val("");
    	$("#uploadFormSupplierButton").attr("disabled",true);
    	$("#uploadFormSupplierButton").removeClass("import_upload").addClass("import_gray")
        $("#uploadFormSupplier").submit();
     	$("#loading").show();
    });
    //收货商
    // ajaxForm  uploadFormInputMaterialButton
    $("#uploadFormReceiver").ajaxForm(receiverOptions);
    // ajaxSubmit
    $("#uploadFormReceiverButton").click(function () {
     	$("#receiverupload_name").val("");
    	$("#uploadFormReceiverButton").attr("disabled",true);
    	$("#uploadFormReceiverButton").removeClass("import_upload").addClass("import_gray")
        $("#uploadFormReceiver").submit();
     	$("#loading").show();
    });
    //从业人员
    $("#uploadFormComEmployee").ajaxForm(comEmployeeOptions);
    // ajaxSubmit
    $("#uploadFormComEmployeeButton").click(function () {
     	$("#comEmployeeupload_name").val("");
    	$("#uploadFormComEmployeeButton").attr("disabled",true);
    	$("#uploadFormComEmployeeButton").removeClass("import_upload").addClass("import_gray")
        $("#uploadFormComEmployee").submit();
     	$("#loading").show();
    });
    
    //清空 
    $("#inputname").click(function () {
    	$(".upload_ts").html("");
// 		$("#uploadFormInputBath_ts").html("");
    });
    $("#outputname").click(function () {
    	$(".upload_ts").html("");
//     	$("#uploadFormOutputBath_ts").html("");
    });
    $("#samplename").click(function () {
    	$(".upload_ts").html("");
// 		$("#uploadFormInputBath_ts").html("");
    });
    
    $("#inputMaterialName").click(function () {
    	$(".upload_ts").html("");
//     	$("#uploadFormInputMaterial_ts").html("");
    });
    $("#outputMaterialName").click(function () {
    	$(".upload_ts").html("");
//     	$("#uploadFormOutputMaterial_ts").html("");
    });
    $("#supplierName").click(function () {
    	$(".upload_ts").html("");
//     	$("#uploadFormSupplier_ts").html("");
    });
    $("#receiverName").click(function () {
    	$(".upload_ts").html("");
//     	$("#uploadFormReceiver_ts").html("");
    });
    $("#comEmployeeName").click(function () {
    	$(".upload_ts").html("");
//     	$("#uploadFormReceiver_ts").html("");
    });
})
function inputshowname(){
	var tt = document.getElementById("inputname");
	var fileName=tt.value;
	fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
	$("#inputupload_name").val(fileName);
    if(fileName!=null&&fileName!=""){
		$("#uploadFormInputButton").attr("disabled",false);
		$("#uploadFormInputButton").removeClass("import_gray").addClass("import_upload");
		var picval = parseInt(tt.files[0].size/1048576);
		console.log(picval);
		if (picval >= 2){
			$("#inputupload_name").val("");
			var ht= "上传文件为"+picval+"M,太大了建议小于2M";
			$("#uploadFormInputBath_ts").text(ht);
			$("#inputname").val("");
			$("#uploadFormInputButton").attr("disabled",true);
			$("#uploadFormInputButton").removeClass("import_upload").addClass("import_gray");
		}
   	}else{
   	  	$("#uploadFormInputButton").attr("disabled",true);
       	$("#uploadFormInputButton").removeClass("import_upload").addClass("import_gray");
   	}
}
function outputshowname(){
	var tt = document.getElementById("outputname");
	var fileName=tt.value;
	fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
	$("#outputupload_name").val(fileName);
    if(fileName!=null&&fileName!=""){
		$("#uploadFormOutputButton").attr("disabled",false);
		$("#uploadFormOutputButton").removeClass("import_gray").addClass("import_upload");
		var picval = parseInt(tt.files[0].size/1048576);
		if (picval >= 2){
			$("#outputupload_name").val("");
			var ht= "上传文件为"+picval+"M,太大了建议小于2M";
			$("#uploadFormOutputBath_ts").html(ht);
			$("#outputname").val("");
			$("#uploadFormOutputButton").attr("disabled",true);
			$("#uploadFormOutputButton").removeClass("import_upload").addClass("import_gray");
		}
   	}else{
   	  	$("#uploadFormOutputButton").attr("disabled",true);
       	$("#uploadFormOutputButton").removeClass("import_upload").addClass("import_gray");
   	}
}
function sampleshowname(){
	var tt = document.getElementById("samplename");
	var fileName=tt.value;
	fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
	$("#sampleupload_name").val(fileName);
    if(fileName!=null&&fileName!=""){
		$("#uploadFormSampleButton").attr("disabled",false);
		$("#uploadFormSampleButton").removeClass("import_gray").addClass("import_upload");
		var picval = parseInt(tt.files[0].size/1048576);
		if (picval >= 2){
			$("#sampleupload_name").val("");
			var ht= "上传文件为"+picval+"M,太大了建议小于2M";
			$("#uploadFormSampleBath_ts").html(ht);
			$("#samplename").val("");
			$("#uploadFormSampleButton").attr("disabled",true);
			$("#uploadFormSampleButton").removeClass("import_upload").addClass("import_gray");
		}
   	}else{
   	  	$("#uploadFormSampleButton").attr("disabled",true);
       	$("#uploadFormSampleButton").removeClass("import_upload").addClass("import_gray");
   	}
}
function inputMaterialshowname(){
	var tt = document.getElementById("inputMaterialName");
	var fileName=tt.value;
	fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
	$("#inputMaterialupload_name").val(fileName);
    if(fileName!=null&&fileName!=""){
		$("#uploadFormInputMaterialButton").attr("disabled",false);
		$("#uploadFormInputMaterialButton").removeClass("import_gray").addClass("import_upload");
		var picval = parseInt(tt.files[0].size/1048576);
		if (picval >= 2){
			$("#inputMaterialupload_name").val("");
			var ht= "上传文件为"+picval+"M,太大了建议小于2M";
			$("#uploadFormInputMaterial_ts").html(ht);
			$("#inputMaterialName").val("");
			$("#uploadFormInputMaterialButton").attr("disabled",true);
			$("#uploadFormInputMaterialButton").removeClass("import_upload").addClass("import_gray");
		}
   	}else{
   	  	$("#uploadFormInputMaterialButton").attr("disabled",true);
       	$("#uploadFormInputMaterialButton").removeClass("import_upload").addClass("import_gray");
   	}
}
function outputMaterialshowname(){
	var tt = document.getElementById("outputMaterialName");
	var fileName=tt.value;
	fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
	$("#outputMaterialupload_name").val(fileName);
    if(fileName!=null&&fileName!=""){
		$("#uploadFormOutputMaterialButton").attr("disabled",false);
		$("#uploadFormOutputMaterialButton").removeClass("import_gray").addClass("import_upload");
		var picval = parseInt(tt.files[0].size/1048576);
		if (picval >= 2){
			$("#outputMaterialupload_name").val("");
			var ht= "上传文件为"+picval+"M,太大了建议小于2M";
			$("#uploadFormOutputMaterial_ts").html(ht);
			$("#outputMaterialName").val("");
			$("#uploadFormOutputMaterialButton").attr("disabled",true);
			$("#uploadFormOutputMaterialButton").removeClass("import_upload").addClass("import_gray");
		}
   	}else{
   	  	$("#uploadFormOutputMaterialButton").attr("disabled",true);
       	$("#uploadFormOutputMaterialButton").removeClass("import_upload").addClass("import_gray");
   	}
}
function suppliershowname(){
	var tt = document.getElementById("supplierName");
	var fileName=tt.value;
	fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
	$("#supplierupload_name").val(fileName);
    if(fileName!=null&&fileName!=""){
		$("#uploadFormSupplierButton").attr("disabled",false);
		$("#uploadFormSupplierButton").removeClass("import_gray").addClass("import_upload");
		var picval = parseInt(tt.files[0].size/1048576);
		if (picval >= 2){
			$("#supplierupload_name").val("");
			var ht= "上传文件为"+picval+"M,太大了建议小于2M";
			$("#uploadFormSupplier_ts").html(ht);
			$("#supplierName").val("");
			$("#uploadFormSupplierButton").attr("disabled",true);
			$("#uploadFormSupplierButton").removeClass("import_upload").addClass("import_gray");
		}
   	}else{
   	  	$("#uploadFormSupplierButton").attr("disabled",true);
       	$("#uploadFormSupplierButton").removeClass("import_upload").addClass("import_gray");
   	}
}
function receivershowname(){
	var tt = document.getElementById("receiverName");
	var fileName=tt.value;
	fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
	$("#receiverupload_name").val(fileName);
    if(fileName!=null&&fileName!=""){
		$("#uploadFormReceiverButton").attr("disabled",false);
		$("#uploadFormReceiverButton").removeClass("import_gray").addClass("import_upload");
		var picval = parseInt(tt.files[0].size/1048576);
		if (picval >= 2){
			$("#receiverupload_name").val("");
			var ht= "上传文件为"+picval+"M,太大了建议小于2M";
			$("#uploadFormReceiver_ts").html(ht);
			$("#receiverName").val("");
			$("#uploadFormReceiverButton").attr("disabled",true);
			$("#uploadFormReceiverButton").removeClass("import_upload").addClass("import_gray");
		}
   	}else{
   	  	$("#uploadFormReceiverButton").attr("disabled",true);
       	$("#uploadFormReceiverButton").removeClass("import_upload").addClass("import_gray");
   	}
}
function comEmployeeshowname(){
	var tt = document.getElementById("comEmployeeName");
	var fileName=tt.value;
	fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
	$("#comEmployeeupload_name").val(fileName);
    if(fileName!=null&&fileName!=""){
		$("#uploadFormComEmployeeButton").attr("disabled",false);
		$("#uploadFormComEmployeeButton").removeClass("import_gray").addClass("import_upload");
		var picval = parseInt(tt.files[0].size/1048576);
		if (picval >= 2){
			$("#comEmployeeupload_name").val("");
			var ht= "上传文件为"+picval+"M,太大了建议小于2M";
			$("#uploadFormComEmployee_ts").html(ht);
			$("#comEmployeeName").val("");
			$("#uploadFormComEmployeeButton").attr("disabled",true);
			$("#uploadFormComEmployeeButton").removeClass("import_upload").addClass("import_gray");
		}
   	}else{
   	  	$("#uploadFormComEmployeeButton").attr("disabled",true);
       	$("#uploadFormComEmployeeButton").removeClass("import_upload").addClass("import_gray");
   	}
}
//进货台账提交模板excel
var options = {
	success: function (data) {
	    if(data.status==0){
	    	$("#uploadFormInputBath_ts").text("上传成功！");
	 		setTimeout('cleanShow()',2000); 
	    }else{
	   		if(data.message=="操作失败"){
	       		console.log(data.message);
	        	$("#uploadFormInputBath_ts").text("上传失败:请修正返回的文件中有红色标记的数据!");
	       		window.location.href=imgFilePath+data.body;
	   		}else{
	           	$("#uploadFormInputBath_ts").html(data.message);
	   		}
	    }
		$("#inputname").val("");
		$("#uploadFormInputButton").attr("disabled",true);
		$("#uploadFormInputButton").removeClass("import_upload").addClass("import_gray")
	 	$("#loading").hide();
	}       	
};
//发货台账提交模板excel
var optionsOutput = {
	success: function (data) {
		if(data.status==0){
			$("#uploadFormOutputBath_ts").html("上传成功！");
			setTimeout('cleanShow()',2000); 
		}else{
			if(data.message=="操作失败"){
				console.log(data.message);
				$("#uploadFormOutputBath_ts").html("上传失败:请修正返回的文件中有红色标记的数据!");
				window.location.href=imgFilePath+data.body;
			}else{
				$("#uploadFormOutputBath_ts").html(data.message);
			}
		}
		$("#outputname").val("");
		$("#uploadFormOutputButton").attr("disabled",true);
		$("#uploadFormOutputButton").removeClass("import_upload").addClass("import_gray")
		$("#loading").hide();
	}
};
var sampleOptions = {
	success: function (data) {
		if(data.status==0){
			$("#uploadFormSampleBath_ts").html("上传成功！");
			setTimeout('cleanShow()',2000); 
		}else{
			if(data.message=="操作失败"){
				console.log(data.message);
				$("#uploadFormSampleBath_ts").html("上传失败:请修正返回的文件中有红色标记的数据!");
				window.location.href=imgFilePath+data.body;
			}else{
				$("#uploadFormSampleBath_ts").html(data.message);
			}
		}
		$("#samplename").val("");
		$("#uploadFormSampleButton").attr("disabled",true);
		$("#uploadFormSampleButton").removeClass("import_upload").addClass("import_gray")
		$("#loading").hide();
	}
};
var inputMaterialOptions = {
	success: function (data) {
		if(data.status==0){
			$("#uploadFormInputMaterial_ts").html("上传成功！");
			setTimeout('cleanShow()',2000); 
		}else{
			if(data.message=="操作失败"){
				console.log(data.message);
				$("#uploadFormInputMaterial_ts").html("上传失败:请修正返回的文件中有红色标记的数据!");
				window.location.href=imgFilePath+data.body;
			}else{
				$("#uploadFormInputMaterial_ts").html(data.message);
			}
		}
		$("#inputMaterialName").val("");
		$("#uploadFormInputMaterialButton").attr("disabled",true);
		$("#uploadFormInputMaterialButton").removeClass("import_upload").addClass("import_gray")
		$("#loading").hide();
	}
};
var outputMaterialOptions = {
	success: function (data) {
		if(data.status==0){
			$("#uploadFormOutputMaterial_ts").html("上传成功！");
			setTimeout('cleanShow()',2000); 
		}else{
			if(data.message=="操作失败"){
				console.log(data.message);
				$("#uploadFormOutputMaterial_ts").html("上传失败:请修正返回的文件中有红色标记的数据!");
				window.location.href=imgFilePath+data.body;
			}else{
				$("#uploadFormOutputMaterial_ts").html(data.message);
			}
		}
		$("#outputMaterialName").val("");
		$("#uploadFormOutputMaterialButton").attr("disabled",true);
		$("#uploadFormOutputMaterialButton").removeClass("import_upload").addClass("import_gray")
		$("#loading").hide();
	}
};
var supplierOptions = {
	success: function (data) {
		if(data.status==0){
			$("#uploadFormSupplier_ts").html("上传成功！");
			setTimeout('cleanShow()',2000); 
		}else{
			if(data.message=="操作失败"){
				console.log(data.message);
				$("#uploadFormSupplier_ts").html("上传失败:请修正返回的文件中有红色标记的数据!");
				window.location.href=imgFilePath+data.body;
			}else{
				$("#uploadFormSupplier_ts").html(data.message);
			}
		}
		$("#supplierName").val("");
		$("#uploadFormSupplierButton").attr("disabled",true);
		$("#uploadFormSupplierButton").removeClass("import_upload").addClass("import_gray")
		$("#loading").hide();
	}
};
var receiverOptions = {
	success: function (data) {
		if(data.status==0){
			$("#uploadFormReceiver_ts").html("上传成功！");
			setTimeout('cleanShow()',2000); 
		}else{
			if(data.message=="操作失败"){
				console.log(data.message);
				$("#uploadFormReceiver_ts").html("上传失败:请修正返回的文件中有红色标记的数据!");
				window.location.href=imgFilePath+data.body;
			}else{
				$("#uploadFormReceiver_ts").html(data.message);
			}
		}
		$("#receiverName").val("");
		$("#uploadFormReceiverButton").attr("disabled",true);
		$("#uploadFormReceiverButton").removeClass("import_upload").addClass("import_gray")
		$("#loading").hide();
	}
};
var comEmployeeOptions = {
	success: function (data) {
		if(data.status==0){
			$("#uploadFormComEmployee_ts").html("上传成功！");
			setTimeout('cleanShow()',2000); 
		}else{
			if(data.message=="操作失败"){
				console.log(data.message);
				$("#uploadFormComEmployee_ts").html("上传失败:请修正返回的文件中有红色标记的数据!");
				window.location.href=imgFilePath+data.body;
			}else{
				$("#uploadFormComEmployee_ts").html(data.message);
			}
		}
		$("#comEmployeeName").val("");
		$("#uploadFormComEmployeeButton").attr("disabled",true);
		$("#uploadFormComEmployeeButton").removeClass("import_upload").addClass("import_gray")
		$("#loading").hide();
	}
};
function cleanShow(){ 
	$("#uploadFormInputBath_ts").html("");
	$("#uploadFormOutputBath_ts").html("");
	$("#uploadFormSampleBath_ts").html("");
	$("#uploadFormInputMaterial_ts").html("");
	$("#uploadFormOutputMaterial_ts").html("");
	$("#uploadFormInputMaterial_ts").html("");	
	$("#uploadFormOutputMaterial_ts").html("");
	$("#uploadFormComEmployee_ts").html("");
} 
</script>	
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">数据导入</a></h3>
          <div class="import_table">
          	<div>
				<div style="width:100%;height:20px;font:14px/20px 'Simsun';color:red;text-align:left;background:yellow;">发货台账和从业人员数据导入模板有新模板V20170223，非此模板的请更新。</div>
			</div>
               <h4 class="import_title">台账</h4>
               <table class="import_list">
                   <tr>
                      <td class="td_imlf">
                          <i class="im1"></i>
                          <span>进货台账</span>
                      </td>
                      <td style="padding-right:0;">
                          <div class="import_down">
                               <i class="i_down"></i>
                               
                               <a href="https://image.safe517.com/fdWebFile/attach/IMPORT_EXCEL_TEMPLATE/进货台账导入_V20151130.xlsx">进货台账模板</a>
                          </div>
                          <div class="import_upload">
                              <div class="import_img">
                                   <input type="text" class="import_name" value="" id="inputupload_name"/>
                                   <input type="text" class="btn_query" value="选择文件" />
                              </div>
                              <div class="import_cont">
                              <form id="uploadFormInputBath" action="../inputManage/inputBatch/importInputBatch" method="post" enctype="multipart/form-data">
                                   <input accept=".xlsx" type="file" class="import_file" value="" name="name" id="inputname" onChange="javascript:inputshowname()" />
                                   <input id="uploadFormInputButton" type="button" class="import_gray" disabled="disabled" value="上传" />
                                   <span id="uploadFormInputBath_ts" class="file_ts" style=""></span>
                              </form>
                              </div>
                          </div>
                      </td>
                   </tr>
                   <tr>
                      <td class="td_imlf">
                          <i class="im2"></i>
                          <span>发货台账</span>
                      </td>
                      <td style="padding-right:0;">
                          <div class="import_down">
                               <i class="i_down"></i>
                               <a href="<%=FileUploadUtils.getImageFilePath()%>/attach/IMPORT_EXCEL_TEMPLATE/发货台账导入_V20170223.xlsx">发货台账模板</a>
                          </div>
                          <div class="import_upload">
                              <div class="import_img">
                                   <input type="text" class="import_name" value="" id="outputupload_name"/>
                                   <input type="text" class="btn_query" value="选择文件" /><!--覆盖的样式-->
                              </div>
                              <div class="import_cont">
                              <form id="uploadFormOutputBath" action="../outputManage/outputBatch/importOutputBatch" method="post" enctype="multipart/form-data">
                                   <input  accept=".xlsx" type="file" class="import_file" value="" name="name" id="outputname" onChange="javascript:outputshowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                   <input id="uploadFormOutputButton" type="button" class="import_gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                   <span  id="uploadFormOutputBath_ts"  class="file_ts" style=""></span>
                              </form>
                              </div>
                          </div>
                      </td>
                   </tr>
                   <tr>
                      <td class="td_imlf">
                          <i class="im7"></i>
                          <span>留样登记台账</span>
                      </td>
                      <td style="padding-right:0;">
                          <div class="import_down">
                               <i class="i_down"></i>
                               <a href=" https://image.safe517.com/fdWebFile/attach/IMPORT_EXCEL_TEMPLATE/留样登记_V20151230.xlsx">留样登记台账模板</a>
                          </div>
                          <div class="import_upload">
                              <div class="import_img">
                                   <input type="text" class="import_name" value="" id="sampleupload_name"/>
                                   <input type="text" class="btn_query" value="选择文件" /><!--覆盖的样式-->
                              </div>
                              <div class="import_cont">
                              <form id="uploadFormSampleBath" action="../retentionSample/importSample" method="post" enctype="multipart/form-data">
                                   <input  accept=".xlsx" type="file" class="import_file" value="" name="name" id="samplename" onChange="javascript:sampleshowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                   <input id="uploadFormSampleButton" type="button" class="import_gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                   <span  id="uploadFormSampleBath_ts"  class="file_ts" style=""></span>
                              </form>
                              </div>
                          </div>
                      </td>
                   </tr>
               </table>
          </div>
          <div class="import_table">
               <h4 class="import_title">基础数据</h4>
               <table class="import_list">
                   <tr>
                      <td class="td_imlf">
                          <i class="im3"></i>
                          <span>采购品</span>
                      </td>
                      <td style="padding-right:0;">
                          <div class="import_down">
                               <i class="i_down"></i>
                               <a href=" https://image.safe517.com/fdWebFile/attach/IMPORT_EXCEL_TEMPLATE/采购品导入_V20151130.xlsx">采购品模板</a>
                          </div>
                          <div class="import_upload">
                              <div class="import_img">
                                   <input type="text" class="import_name" value="" id="inputMaterialupload_name"/>
                                   <input type="text" class="btn_query" value="选择文件" /><!--覆盖的样式-->
                              </div>
                              <div class="import_cont">
                              <form id="uploadFormInputMaterial" action="../inputManage/inputMaterial/importInputMaterial" method="post" enctype="multipart/form-data">
                                   <input  accept=".xlsx" type="file" class="import_file" value="" name="name" id="inputMaterialName" onChange="javascript:inputMaterialshowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                   <input id="uploadFormInputMaterialButton" type="button" class="import_gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                   <span  id="uploadFormInputMaterial_ts"  class="file_ts" style=""></span>
                              </form>
                              </div>
                          </div>
                      </td>
                   </tr>
                   <tr>
                      <td class="td_imlf">
                          <i class="im4"></i>
                          <span>产出品</span>
                      </td>
                      <td style="padding-right:0;">
                          <div class="import_down">
                               <i class="i_down"></i>
                               <a href=" https://image.safe517.com/fdWebFile/attach/IMPORT_EXCEL_TEMPLATE/产出品导入_V20151130.xlsx">产出品模板</a>
                          </div>
                          <div class="import_upload">
                              <div class="import_img">
                                   <input type="text" class="import_name" value="" id="outputMaterialupload_name"/>
                                   <input type="text" class="btn_query" value="选择文件" /><!--覆盖的样式-->
                              </div>
                              <div class="import_cont">
                                   <form id="uploadFormOutputMaterial" action="../outputManage/outputMaterial/importOutputMaterial" method="post" enctype="multipart/form-data">
                                        <input  accept=".xlsx" type="file" class="import_file" value="" name="name" id="outputMaterialName" onChange="javascript:outputMaterialshowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                        <input id="uploadFormOutputMaterialButton" type="button" class="import_gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                        <span  id="uploadFormOutputMaterial_ts"  class="file_ts" style=""></span>
                                   </form>
                              </div>
                          </div>
                      </td>
                   </tr>
                   <tr>
                      <td class="td_imlf">
                          <i class="im5"></i>
                          <span>供应商</span>
                      </td>
                      <td style="padding-right:0;">
                          <div class="import_down">
                               <i class="i_down"></i>
                               <a href="https://image.safe517.com/fdWebFile/attach/IMPORT_EXCEL_TEMPLATE/供应商导入_V20160130.xlsx">供应商模板</a>
                          </div>
                          <div class="import_upload">
                              <div class="import_img">
                                   <input type="text" class="import_name" value="" id="supplierupload_name"/>
                                   <input type="text" class="btn_query" value="选择文件" /><!--覆盖的样式-->
                              </div>
                              <div class="import_cont">
                                   <form id="uploadFormSupplier" action="../inputManage/supplier/importSupplier" method="post" enctype="multipart/form-data">
                                        <input  accept=".xlsx" type="file" class="import_file" value="" name="name" id="supplierName" onChange="javascript:suppliershowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                        <input id="uploadFormSupplierButton" type="button" class="import_gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                        <span  id="uploadFormSupplier_ts"  class="file_ts" style=""></span>
                                   </form>
                              </div>
                          </div>
                      </td>
                   </tr>
                   <tr>
                      <td class="td_imlf">
                          <i class="im6"></i>
                          <span>收货商</span>
                      </td>
                      <td style="padding-right:0;">
                          <div class="import_down">
                               <i class="i_down"></i>
                               <a href="https://image.safe517.com/fdWebFile/attach/IMPORT_EXCEL_TEMPLATE/收货商导入_V20160130.xlsx">收货商模板</a>
                          </div>
                          <div class="import_upload">
                              <div class="import_img">
                                   <input type="text" class="import_name" value="" id="receiverupload_name"/>
                                   <input type="text" class="btn_query" value="选择文件" /><!--覆盖的样式-->
                              </div>
                              <div class="import_cont">
                                   <form id="uploadFormReceiver" action="../inputManage/receiver/importReceiver" method="post" enctype="multipart/form-data">
                                        <input  accept=".xlsx" type="file" class="import_file" value="" name="name" id="receiverName" onChange="javascript:receivershowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                        <input id="uploadFormReceiverButton" type="button" class="import_gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                        <span  id="uploadFormReceiver_ts"  class="file_ts" style=""></span>
                                   </form>
                              </div>
                          </div>
                      </td>
                   </tr>
                   <tr>
                      <td class="td_imlf">
                          <i class="im8"></i>
                          <span>从业人员</span>
                      </td>
                      <td style="padding-right:0;">
                          <div class="import_down">
                               <i class="i_down"></i>
                               <a href="<%=FileUploadUtils.getImageFilePath()%>/attach/IMPORT_EXCEL_TEMPLATE/从业人员_V20170223.xlsx">从业人员模板</a>
                          </div>
                          <div class="import_upload">
                              <div class="import_img">
                                   <input type="text" class="import_name" value="" id="comEmployeeupload_name"/>
                                   <input type="text" class="btn_query" value="选择文件" /><!--覆盖的样式-->
                              </div>
                              <div class="import_cont">
                                   <form id="uploadFormComEmployee" action="../restaurant/comEmployee/importComEmployee" method="post" enctype="multipart/form-data">
                                        <input  accept=".xlsx" type="file" class="import_file" value="" name="name" id="comEmployeeName" onChange="javascript:comEmployeeshowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                        <input id="uploadFormComEmployeeButton" type="button" class="import_gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                        <span  id="uploadFormComEmployee_ts"  class="file_ts" style=""></span>
                                   </form>
                              </div>
                          </div>
                      </td>
                   </tr>
               </table>
          </div>
          <div class="import_prompt">
               <div class="prompt_lf">
                    <h5>导入方法：</h5>
                    <p>请下载相应的模板，并将台账数据填到模板中，<br/>保存后将该文件上传系统。</p>
                    <h6>常见问题：</h6>
                    <p>1.使用的模板不是最新的模板。如模板有更新，应用会在导入时候用红色字体标注;</p>
                    <p>2.Excel版本低。应用需要使用Excel2007及以上版本编制的excel文件，即文件扩展名为xlsx的文件可被识别。</p>
               </div>
               <div class="prompt_rt">
                    <h5>注：</h5>
                    <p>1.模板数据顺序不允许修改</p>
                    <p>2.下拉选择的数据项不能填写选项以外的数据</p>
                    <p>3.上传的文件必须是原来的模板文件</p>
                    <p class="yellow">4.上传的文件大小不超过2M</p>
               </div>
               <div class="clear"></div>
          </div>
     </div>
</div>
</body>
</html>