<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.wondersgroup.framework.util.FileUploadUtils"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
  <%@ include file="../include.jsp" %>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">数据导入</a>
          </h3>
              <div class="import_box">
               <div class="import_lf">
                <h4 class="import_title">台账</h4>
                    <div class="parameter">
                         <h5><span>进货台账</span><b></b></h5>
                         <div class="para_con">
                              <div class="para_download">
                                   <i class="i_download"></i>
                                   <span>模板：</span>
                                   <a href="<%=FileUploadUtils.getImageFilePath()%>/attach/IMPORT_EXCEL_TEMPLATE/进货台账导入_V20151130.xlsx">导入进货台账模板v20151130</a>
                              </div>
                              <div class="para_upload">
                                   <div class="upload_img"></div>
                                    
                                   <div class="upload_btn">
                                   <form id="uploadFormInputBath" action="../inputManage/inputBatch/importInputBatch" method="post" enctype="multipart/form-data">
                                        <input accept=".xlsx" type="file" class="upload_file" value="" name="name" id="inputname" " onChange="javascript:inputshowname()" />
                                        <input id="uploadFormInputButton" type="button" class="gray" disabled="disabled" value="上传" />
                                        <span id="uploadFormInputBath_ts" class="upload_ts" style=""></span>
                                        <span id="inputupload_name"   class="upload_name"></span>
                                    </form>
                                   </div>
                                  
                              </div>
                         </div>
                    </div>
                    <div class="parameter">
                         <h5><span>发货台账</span><b></b></h5>
                         <div class="para_con">
                              <div class="para_download">
                                   <i class="i_download"></i>
                                   <span>模板：</span>
                                   <a href="<%=FileUploadUtils.getImageFilePath()%>/attach/IMPORT_EXCEL_TEMPLATE/发货台账导入_V20151130.xlsx">导入发货台账模板v20151130</a>
                              </div>
                              <div class="para_upload">
                                   <div class="upload_img"></div> <!--若导入不能点击 上传状态为灰色  upload_gray-->
                                   <div class="upload_btn">
                                    <form id="uploadFormOutputBath" action="../outputManage/outputBatch/importOutputBatch" method="post" enctype="multipart/form-data">
                                        <input  accept=".xlsx" type="file" class="upload_file" value="" name="name" id="outputname" onChange="javascript:outputshowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                        <input id="uploadFormOutputButton" type="button" class="gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                        <span  id="uploadFormOutputBath_ts""  class="upload_ts" style=""></span>
                                        <span id="outputupload_name" class="upload_name"></span>
                                    </form>
                                   </div>
                              </div>
                         </div>
                    </div>
                    <div class="parameter">
                         <h5><span>留样登记台账</span><b></b></h5>
                         <div class="para_con">
                              <div class="para_download">
                                   <i class="i_download"></i>
                                   <span>模板：</span>
                                   <a href="<%=FileUploadUtils.getImageFilePath()%>/attach/IMPORT_EXCEL_TEMPLATE/留样登记_V20151230.xlsx">导入留样登记台账模板v20151230</a>
                              </div>
                              <div class="para_upload">
                                   <div class="upload_img"></div> <!--若导入不能点击 上传状态为灰色  upload_gray-->
                                   <div class="upload_btn">
                                    <form id="uploadFormSampleBath" action="../retentionSample/importSample" method="post" enctype="multipart/form-data">
                                        <input  accept=".xlsx" type="file" class="upload_file" value="" name="name" id="samplename" onChange="javascript:sampleshowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                        <input id="uploadFormSampleButton" type="button" class="gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                        <span  id="uploadFormSampleBath_ts""  class="upload_ts" style=""></span>
                                        <span id="sampleupload_name" class="upload_name"></span>
                                    </form>
                                   </div>
                              </div>
                         </div>
                    </div>
                              <h4 class="import_title">基础数据</h4>
                             <div class="parameter">
                         <h5><span>采购品</span><b></b></h5>
                         <div class="para_con">
                              <div class="para_download">
                                   <i class="i_download"></i>
                                   <span>模板：</span>
                                   <a href="<%=FileUploadUtils.getImageFilePath()%>/attach/IMPORT_EXCEL_TEMPLATE/采购品导入_V20151130.xlsx">导入采购品模板v20151130</a>
                              </div>
                              <div class="para_upload">
                                   <div class="upload_img"></div> <!--若导入不能点击 上传状态为灰色  upload_gray-->
                                   <div class="upload_btn">
                                    <form id="uploadFormInputMaterial" action="../inputManage/inputMaterial/importInputMaterial" method="post" enctype="multipart/form-data">
                                        <input  accept=".xlsx" type="file" class="upload_file" value="" name="name" id="inputMaterialName" onChange="javascript:inputMaterialshowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                        <input id="uploadFormInputMaterialButton" type="button" class="gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                        <span  id="uploadFormInputMaterial_ts""  class="upload_ts" style=""></span>
                                        <span id="inputMaterialupload_name" class="upload_name"></span>
                                    </form>
                                   </div>
                              </div>
                         </div>
                    </div>
                    
                                              <div class="parameter">
                         <h5><span>产出品</span><b></b></h5>
                         <div class="para_con">
                              <div class="para_download">
                                   <i class="i_download"></i>
                                   <span>模板：</span>
                                   <a href="<%=FileUploadUtils.getImageFilePath()%>/attach/IMPORT_EXCEL_TEMPLATE/产出品导入_V20151130.xlsx">导入产出品模板v20151130</a>
                              </div>
                              <div class="para_upload">
                                   <div class="upload_img"></div> <!--若导入不能点击 上传状态为灰色  upload_gray-->
                                   <div class="upload_btn">
                                    <form id="uploadFormOutputMaterial" action="../outputManage/outputMaterial/importOutputMaterial" method="post" enctype="multipart/form-data">
                                        <input  accept=".xlsx" type="file" class="upload_file" value="" name="name" id="outputMaterialName" onChange="javascript:outputMaterialshowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                        <input id="uploadFormOutputMaterialButton" type="button" class="gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                        <span  id="uploadFormOutputMaterial_ts""  class="upload_ts" style=""></span>
                                        <span id="outputMaterialupload_name" class="upload_name"></span>
                                    </form>
                                   </div>
                              </div>
                         </div>
                    </div>
                                                                 <div class="parameter">
                         <h5><span>供应商</span><b></b></h5>
                         <div class="para_con">
                              <div class="para_download">
                                   <i class="i_download"></i>
                                   <span>模板：</span>
                                   <a href="<%=FileUploadUtils.getImageFilePath()%>/attach/IMPORT_EXCEL_TEMPLATE/供应商导入_V20160130.xlsx">导入供应商模板v20160130</a>
                              </div>
                              <div class="para_upload">
                                   <div class="upload_img"></div> <!--若导入不能点击 上传状态为灰色  upload_gray-->
                                   <div class="upload_btn">
                                    <form id="uploadFormSupplier" action="../inputManage/supplier/importSupplier" method="post" enctype="multipart/form-data">
                                        <input  accept=".xlsx" type="file" class="upload_file" value="" name="name" id="supplierName" onChange="javascript:suppliershowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                        <input id="uploadFormSupplierButton" type="button" class="gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                        <span  id="uploadFormSupplier_ts""  class="upload_ts" style=""></span>
                                        <span id="supplierupload_name" class="upload_name"></span>
                                    </form>
                                   </div>
                              </div>
                         </div>
                    </div>
                    
                                                                                  <div class="parameter">
                         <h5><span>收货商</span><b></b></h5>
                         <div class="para_con">
                              <div class="para_download">
                                   <i class="i_download"></i>
                                   <span>模板：</span>
                                   <a href="<%=FileUploadUtils.getImageFilePath()%>/attach/IMPORT_EXCEL_TEMPLATE/收货商导入_V20160130.xlsx">导入收货商模板v20160130</a>
                              </div>
                              <div class="para_upload">
                                   <div class="upload_img"></div> <!--若导入不能点击 上传状态为灰色  upload_gray-->
                                   <div class="upload_btn">
                                    <form id="uploadFormReceiver" action="../inputManage/receiver/importReceiver" method="post" enctype="multipart/form-data">
                                        <input  accept=".xlsx" type="file" class="upload_file" value="" name="name" id="receiverName" onChange="javascript:receivershowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                        <input id="uploadFormReceiverButton" type="button" class="gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                        <span  id="uploadFormReceiver_ts""  class="upload_ts" style=""></span>
                                        <span id="receiverupload_name" class="upload_name"></span>
                                    </form>
                                   </div>
                              </div>
                         </div>
                    </div>
                                                                                          <div class="parameter">
                         <h5><span>从业人员</span><b></b></h5>
                         <div class="para_con">
                              <div class="para_download">
                                   <i class="i_download"></i>
                                   <span>模板：</span>
                                   <a href="<%=FileUploadUtils.getImageFilePath()%>/attach/IMPORT_EXCEL_TEMPLATE/从业人员_V20151130.xlsx">导入从业人员模板v20151130</a>
                              </div>
                              <div class="para_upload">
                                   <div class="upload_img"></div> <!--若导入不能点击 上传状态为灰色  upload_gray-->
                                   <div class="upload_btn">
                                    <form id="uploadFormComEmployee" action="../restaurant/comEmployee/importComEmployee" method="post" enctype="multipart/form-data">
                                        <input  accept=".xlsx" type="file" class="upload_file" value="" name="name" id="comEmployeeName" onChange="javascript:comEmployeeshowname()"/> <!--未选择路径上导入不能点击  disabled="disabled"-->
                                        <input id="uploadFormComEmployeeButton" type="button" class="gray" disabled="disabled" value="上传" />          <!--若导入不能点击 上传状态为灰色  gray-->
                                        <span  id="uploadFormComEmployee_ts""  class="upload_ts" style=""></span>
                                        <span id="comEmployeeupload_name" class="upload_name"></span>
                                    </form>
                                   </div>
                              </div>
                         </div>
                    </div>
               </div>
               <div class="import_rt">
           <div class="import_ts">
                         <h6>导入方法</h6>
                         <p>请下载相应的模板，并将台账数据填到模板中，保存后将该文件上传系统。</p>
                    </div>
                    <div class="import_ts">
                         <h6>注：</h6>
                         <p>1.模板数据顺序不允许修改</p>
                         <p>2.下拉选择的数据项不能填写选项以外的数据</p>
                         <p>3.上传的文件必须是原来的模板文件</p>
                         <p>4.上传的文件大小不超过2M</p>
                    </div>
                    <div class="import_ts">
                         <h6>常见问题：</h6>
                         <p>1.使用的模板不是最新的模板。如模板有更新，应用会在导入时候用红色字体标注。</p>
                         <p>2.Excel版本低。应用需要使用Excel2007及以上版本编制的excel文件，即文件扩展名为xlsx的文件可被识别。</p>
                         
                    </div>
               </div>
          </div>
          <div class="clear"></div>
<!--           <div class="query" style="min-height:430px;"> -->
<!--                <ul class="query_list"> -->
               
<!--                    <li> -->
<%--                        <form id="uploadFormInputBath" action="../inputManage/inputBatch/importInputBatch" method="post" enctype="multipart/form-data"> --%>
<!--                        <span><em>导入进货台账:</em><input type="file" accept=".xls,.xlsx" class="query_input" value="" name="productionBarcode" id="productionBarcode"/></span> -->
<!--                        <input id="uploadFormInputButton" type="button" class="btn_green"  value="上传" /> -->
<!--                        </form> -->
<!--                        <font id="uploadFormInputBath_ts" class="upload_ts" style="display:none;">上传成功！</font> -->
<!--                    </li> -->
<!--                    <li> -->
<%--                      <form id="uploadFormOutputBath" action="../outputManage/outputBatch/importOutputBatch" method="post" enctype="multipart/form-data"> --%>
<!--                        <span><em>导入发货台账:</em><input type="file"  accept=".xls,.xlsx" class="query_input" value=""  name="name" id="name"/></span> -->
<!--                        <input id="uploadFormOutputButton" type="button" class="btn_green" value="上传" /> -->
<!--                       </form> -->
<!--                        <font id="uploadFormOutputBath_ts" class="upload_ts" style="display:none;">上传成功！</font> -->
<!--                    </li><br/> -->
<!--                    <li> -->
<!--                        <span><em>导入采购品:</em><input type="file" class="query_input" value="" name="productionBarcode" id="productionBarcode"/></span> -->
<!--                        <input type="button" class="btn_green" value="上传" /> -->
                       
<!--                        <font class="upload_ts" style="display:none;">上传成功！</font> -->
<!--                    </li> -->
<!--                    <li> -->
<!--                        <span><em>导入产出品:</em><input type="file" class="query_input" value=""  name="name" id="name"/></span> -->
<!--                        <input type="button" class="btn_green" value="上传" /> -->
                       
<!--                        <font class="upload_ts" style="display:none;">上传成功！</font> -->
<!--                    </li> -->
<!--                    <li> -->
<!--                        <span><em>导入供应商:</em><input type="file" class="query_input" value="" name="productionBarcode" id="productionBarcode"/></span> -->
<!--                        <input type="button" class="btn_green" value="上传" /> -->
                       
<!--                        <font class="upload_ts" style="display:none;">上传成功！</font> -->
<!--                    </li> -->
<!--                    <li> -->
<!--                        <span><em>导入收货商:</em><input type="file" class="query_input" value=""  name="name" id="name"/></span> -->
<!--                        <input type="button" class="btn_green" value="上传" /> -->
                       
<!--                        <font class="upload_ts" style="display:none;">上传成功！</font> -->
<!--                    </li> -->
<!--                </ul> -->
<!--           </div> -->
     </div>
</div>    
 
<script type="text/javascript"> 
	
	$(function(){

// 		  var picval = parseInt(file_upload.files[0].size/1048576);
// 		  if (picval > 1) return alert(file_upload.files[0].name + ",尺寸为：" + picval + "M," + " " + "上传图片建议小于1M"),
		
		
		
		  //进货台账提交模板excel

        // ajaxForm
        $("#uploadFormInputBath").ajaxForm(options);
        // ajaxSubmit
        $("#uploadFormInputButton").click(function () {
         	$("#inputupload_name").text("");
        	$("#uploadFormInputButton").attr("disabled",true);
        	$("#uploadFormInputButton").removeClass("btn_upload").addClass("gray")
            $("#uploadFormInputBath").submit();
         	$("#loading").show();
        });
        

 
	       //发货台账提交模板excel
        // ajaxForm
        $("#uploadFormOutputBath").ajaxForm(optionsOutput);
        // ajaxSubmit
        $("#uploadFormOutputButton").click(function () {
        	$("#loading").show();
       
    		$("#uploadFormOutputButton").attr("disabled",true);
    		$("#uploadFormOutputButton").removeClass("btn_upload").addClass("gray")
            $("#uploadFormOutputBath").submit();
         	$("#loading").show();
        });
        
      //留样台账提交模板excel

        // ajaxForm
        $("#uploadFormSampleBath").ajaxForm(sampleOptions);
        // ajaxSubmit
        $("#uploadFormSampleButton").click(function () {
         	$("#sampleupload_name").text("");
        	$("#uploadFormSampleButton").attr("disabled",true);
        	$("#uploadFormSampleButton").removeClass("btn_upload").addClass("gray")
            $("#uploadFormSampleBath").submit();
         	$("#loading").show();
        });

       //采购品
        // ajaxForm  uploadFormInputMaterialButton
        $("#uploadFormInputMaterial").ajaxForm(inputMaterialOptions);
        // ajaxSubmit
        $("#uploadFormInputMaterialButton").click(function () {
         	$("#inputMaterialupload_name").text("");
        	$("#uploadFormInputMaterialButton").attr("disabled",true);
        	$("#uploadFormInputMaterialButton").removeClass("btn_upload").addClass("gray")
            $("#uploadFormInputMaterial").submit();
         	$("#loading").show();
        });
        
       // 产出品
        // ajaxForm  uploadFormInputMaterialButton
        $("#uploadFormOutputMaterial").ajaxForm(outputMaterialOptions);
        // ajaxSubmit
        $("#uploadFormOutputMaterialButton").click(function () {
         	$("#outputMaterialupload_name").text("");
        	$("#uploadFormOutputMaterialButton").attr("disabled",true);
        	$("#uploadFormOutputMaterialButton").removeClass("btn_upload").addClass("gray")
            $("#uploadFormOutputMaterial").submit();
         	$("#loading").show();
        });
        
     //供应商
        // ajaxForm  uploadFormInputMaterialButton
        $("#uploadFormSupplier").ajaxForm(supplierOptions);
        // ajaxSubmit
        $("#uploadFormSupplierButton").click(function () {
         	$("#supplierupload_name").text("");
        	$("#uploadFormSupplierButton").attr("disabled",true);
        	$("#uploadFormSupplierButton").removeClass("btn_upload").addClass("gray")
            $("#uploadFormSupplier").submit();
         	$("#loading").show();
        });
        //收货商
        // ajaxForm  uploadFormInputMaterialButton
        $("#uploadFormReceiver").ajaxForm(receiverOptions);
        // ajaxSubmit
        $("#uploadFormReceiverButton").click(function () {
         	$("#receiverupload_name").text("");
        	$("#uploadFormReceiverButton").attr("disabled",true);
        	$("#uploadFormReceiverButton").removeClass("btn_upload").addClass("gray")
            $("#uploadFormReceiver").submit();
         	$("#loading").show();
        });
        //从业人员
        $("#uploadFormComEmployee").ajaxForm(comEmployeeOptions);
        // ajaxSubmit
        $("#uploadFormComEmployeeButton").click(function () {
         	$("#comEmployeeupload_name").text("");
        	$("#uploadFormComEmployeeButton").attr("disabled",true);
        	$("#uploadFormComEmployeeButton").removeClass("btn_upload").addClass("gray")
            $("#uploadFormComEmployee").submit();
         	$("#loading").show();
        });
        
        //清空 
        $("#inputname").click(function () {
        	$(".upload_ts").html("");
//     		$("#uploadFormInputBath_ts").html("");
        });
        $("#outputname").click(function () {
        	$(".upload_ts").html("");
//         	$("#uploadFormOutputBath_ts").html("");
        });
        $("#samplename").click(function () {
        	$(".upload_ts").html("");
//     		$("#uploadFormInputBath_ts").html("");
        });
        
        $("#inputMaterialName").click(function () {
        	$(".upload_ts").html("");
//         	$("#uploadFormInputMaterial_ts").html("");
        });
        $("#outputMaterialName").click(function () {
        	$(".upload_ts").html("");
//         	$("#uploadFormOutputMaterial_ts").html("");
        });
        $("#supplierName").click(function () {
        	$(".upload_ts").html("");
//         	$("#uploadFormSupplier_ts").html("");
        });
        $("#receiverName").click(function () {
        	$(".upload_ts").html("");
//         	$("#uploadFormReceiver_ts").html("");
        });
        $("#comEmployeeName").click(function () {
        	$(".upload_ts").html("");
//         	$("#uploadFormReceiver_ts").html("");
        });
	})
function inputshowname(){
		var tt = document.getElementById("inputname");
	  	   var fileName=tt.value;
	         fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
	 		$("#inputupload_name").text(fileName);
     	if(fileName!=null&&fileName!=""){
		$("#uploadFormInputButton").attr("disabled",false);
		$("#uploadFormInputButton").removeClass("gray").addClass("btn_upload");
	  var picval = parseInt(tt.files[0].size/1048576);
		console.log(picval);
	  if (picval >= 2){
			$("#inputupload_name").text("");
		    var ht= "上传文件为"+picval+"M,太大了建议小于2M";
	    	$("#uploadFormInputBath_ts").html(ht);
	       	$("#inputname").val("");
        	$("#uploadFormInputButton").attr("disabled",true);
        	$("#uploadFormInputButton").removeClass("btn_upload").addClass("gray");
	      }
    	}else{
    	  	$("#uploadFormInputButton").attr("disabled",true);
        	$("#uploadFormInputButton").removeClass("btn_upload").addClass("gray");
    	}

	}
	function outputshowname(){
		var tt = document.getElementById("outputname");
         var fileName=tt.value;
         fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
		$("#outputupload_name").text(fileName);
		if(fileName!=null&&fileName!=""){
		$("#uploadFormOutputButton").attr("disabled",false);
		$("#uploadFormOutputButton").removeClass("gray").addClass("btn_upload");
		  var picval = parseInt(tt.files[0].size/1048576);
		  if (picval >= 2){
				$("#outputupload_name").text("");
			    var ht= "上传文件为"+picval+"M,太大了建议小于2M";
		    	$("#uploadFormOutputBath_ts").html(ht);
        	$("#outputname").val("");
        	$("#uploadFormOutputButton").attr("disabled",true);
    		$("#uploadFormOutputButton").removeClass("btn_upload").addClass("gray")
		  }
		}else{
    	  	$("#uploadFormInputButton").attr("disabled",true);
        	$("#uploadFormInputButton").removeClass("btn_upload").addClass("gray");
    	}
	}
	function sampleshowname(){
		var tt = document.getElementById("samplename");
         var fileName=tt.value;
         fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
		$("#sampleupload_name").text(fileName);
		if(fileName!=null&&fileName!=""){
		$("#uploadFormSampleButton").attr("disabled",false);
		$("#uploadFormSampleButton").removeClass("gray").addClass("btn_upload");
		  var picval = parseInt(tt.files[0].size/1048576);
		  if (picval >= 2){
				$("#sampleupload_name").text("");
			    var ht= "上传文件为"+picval+"M,太大了建议小于2M";
		    	$("#uploadFormSampleBath_ts").html(ht);
        	$("#samplename").val("");
        	$("#uploadFormSampleButton").attr("disabled",true);
    		$("#uploadFormSampleButton").removeClass("btn_upload").addClass("gray")
		  }
		}else{
    	  	$("#uploadFormInputButton").attr("disabled",true);
        	$("#uploadFormInputButton").removeClass("btn_upload").addClass("gray");
    	}
	}
	//采购品
	function inputMaterialshowname(){
		var tt = document.getElementById("inputMaterialName");
        var fileName=tt.value;
        fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
		$("#inputMaterialupload_name").text(fileName);
		if(fileName!=null&&fileName!=""){
		$("#uploadFormInputMaterialButton").attr("disabled",false);
		$("#uploadFormInputMaterialButton").removeClass("gray").addClass("btn_upload");
		  var picval = parseInt(tt.files[0].size/1048576);
		  if (picval >= 2){
			$("#inputMaterialupload_name").text("");
		    var ht= "上传文件为"+picval+"M,太大了建议小于2M";
		    $("#uploadFormInputMaterial_ts").html(ht);
    		$("#inputMaterialName").val("");
        	$("#uploadFormInputMaterialButton").attr("disabled",true);
        	$("#uploadFormInputMaterialButton").removeClass("btn_upload").addClass("gray")
		  }
		}else{
    	  	$("#uploadFormInputMaterialButton").attr("disabled",true);
        	$("#uploadFormInputMaterialButton").removeClass("btn_upload").addClass("gray");
    	}
	}
	//产出品
	function outputMaterialshowname(){
		var tt = document.getElementById("outputMaterialName");
        var fileName=tt.value;
        fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
		$("#outputMaterialupload_name").text(fileName);
		if(fileName!=null&&fileName!=""){
		$("#uploadFormOutputMaterialButton").attr("disabled",false);
		$("#uploadFormOutputMaterialButton").removeClass("gray").addClass("btn_upload");
		  var picval = parseInt(tt.files[0].size/1048576);
		  if (picval >= 2){
				$("#outputMaterialupload_name").text("");
			    var ht= "上传文件为"+picval+"M,太大了建议小于2M";
			    $("#outputMaterialName").val("");
		    	$("#uploadFormOutputMaterial_ts").html(ht);
	            $("#uploadFormOutputMaterialButton").attr("disabled",true);
	            $("#uploadFormOutputMaterialButton").removeClass("btn_upload").addClass("gray")
		  }
		}else{
    	  	$("#uploadFormOutputMaterialButton").attr("disabled",true);
        	$("#uploadFormOutputMaterialButton").removeClass("btn_upload").addClass("gray");
    	}
	}
	//供应商
	function suppliershowname(){
		var tt = document.getElementById("supplierName");
        var fileName=tt.value;
        fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
		$("#supplierupload_name").text(fileName);
		if(fileName!=null&&fileName!=""){
		$("#uploadFormSupplierButton").attr("disabled",false);
		$("#uploadFormSupplierButton").removeClass("gray").addClass("btn_upload");
		  var picval = parseInt(tt.files[0].size/1048576);
		  if (picval >= 2){
				$("#supplierupload_name").text("");
			    var ht= "上传文件为"+picval+"M,太大了建议小于2M";
		    	$("#uploadFormSupplier_ts").html(ht);
	           $("#supplierName").val("");
	           $("#uploadFormSupplierButton").attr("disabled",true);
	           $("#uploadFormSupplierButton").removeClass("btn_upload").addClass("gray");
		  }
		}else{
    	  	$("#uploadFormSupplierButton").attr("disabled",true);
        	$("#uploadFormSupplierButton").removeClass("btn_upload").addClass("gray");
    	}
	}
	//收货商
	function receivershowname(){
		var tt = document.getElementById("receiverName");
        var fileName=tt.value;
        fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
		$("#receiverupload_name").text(fileName);
		if(fileName!=null&&fileName!=""){
		$("#uploadFormReceiverButton").attr("disabled",false);
		$("#uploadFormReceiverButton").removeClass("gray").addClass("btn_upload");
		  var picval = parseInt(tt.files[0].size/1048576);
		  if (picval >= 2){
				$("#receiverupload_name").text("");
			    var ht= "上传文件为"+picval+"M,太大了建议小于2M";
		    	$("#uploadFormReceiver_ts").html(ht);
			$("#uploadFormReceiver_ts").html(data.message);
	        $("#receiverName").val("");
	        $("#uploadFormReceiverButton").attr("disabled",true);
	        $("#uploadFormReceiverButton").removeClass("btn_upload").addClass("gray")
		  }
		}else{
    	  	$("#uploadFormReceiverButton").attr("disabled",true);
        	$("#uploadFormReceiverButton").removeClass("btn_upload").addClass("gray");
    	}
	}
	//从业人员
	function comEmployeeshowname(){
		var tt = document.getElementById("comEmployeeName");
        var fileName=tt.value;
        fileName=fileName.substr(fileName.lastIndexOf("\\")+1,fileName.length-1);
		$("#comEmployeeupload_name").text(fileName);
		if(fileName!=null&&fileName!=""){
		$("#uploadFormComEmployeeButton").attr("disabled",false);
		$("#uploadFormComEmployeeButton").removeClass("gray").addClass("btn_upload");
		  var picval = parseInt(tt.files[0].size/1048576);
		  if (picval >= 2){
				$("#comEmployeeupload_name").text("");
			    var ht= "上传文件为"+picval+"M,太大了建议小于2M";
		    	$("#uploadFormComEmployee_ts").html(ht);
			$("#uploadFormComEmployee_ts").html(data.message);
	        $("#comEmployeeName").val("");
	        $("#uploadFormComEmployeeButton").attr("disabled",true);
	        $("#uploadFormComEmployeeButton").removeClass("btn_upload").addClass("gray")
		  }
		}else{
    	  	$("#uploadFormComEmployeeButton").attr("disabled",true);
        	$("#uploadFormComEmployeeButton").removeClass("btn_upload").addClass("gray");
    	}
	}
	
	
	//===========
			       //进货台账提交模板excel
        var options = {
        success: function (data) {
            $("#responseText").text(data);
            console.log(data);
            if(data.status==0){
            	$("#uploadFormInputBath_ts").html("上传成功！");
            	  setTimeout('cleanShow()',2000); 
            	}else{
            		if(data.message=="操作失败"){
                	console.log(data.message);
                 	$("#uploadFormInputBath_ts").html("上传失败:请修正返回的文件中有红色标记的数据!");
                	window.location.href=imgFilePath+data.body;
            		}else{
                    	$("#uploadFormInputBath_ts").html(data.message);
            		}
            }

        	$("#inputname").val("");
        	$("#uploadFormInputButton").attr("disabled",true);
        	$("#uploadFormInputButton").removeClass("btn_upload").addClass("gray")
         	$("#loading").hide();
        }       	
        };
			       //发货台账提交模板excel
        var optionsOutput = {
        success: function (data) {
            console.log(data);
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
         	$("#outputupload_name").text("");
        	$("#outputname").val("");
        	$("#uploadFormOutputButton").attr("disabled",true);
    		$("#uploadFormOutputButton").removeClass("btn_upload").addClass("gray")
         	$("#loading").hide();
        }
        };
        var sampleOptions = {
                success: function (data) {
                    console.log(data);
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
                 	$("#sampleupload_name").text("");
                	$("#samplename").val("");
                	$("#uploadFormSampleButton").attr("disabled",true);
            		$("#uploadFormSampleButton").removeClass("btn_upload").addClass("gray")
                 	$("#loading").hide();
                }
                };
		        //采购品
        var inputMaterialOptions = {
        success: function (data) {
            $("#responseText").text(data);
            console.log(data);
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
        	$("#uploadFormInputMaterial").attr("disabled",true);
        	$("#uploadFormInputMaterialButton").removeClass("btn_upload").addClass("gray")
         	$("#loading").hide();
        }       	
        };
		         //产出品
        var outputMaterialOptions = {
        success: function (data) {
            $("#responseText").text(data);
            console.log(data);
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
        	$("#uploadFormOutputMaterial").attr("disabled",true);
        	$("#uploadFormOutputMaterialButton").removeClass("btn_upload").addClass("gray")
         	$("#loading").hide();
        }      	
        };
		        //供应商
        var supplierOptions = {
        success: function (data) {
            $("#responseText").text(data);
            console.log(data);
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
        	$("#uploadFormSupplier").attr("disabled",true);
        	$("#uploadFormSupplierButton").removeClass("btn_upload").addClass("gray")
         	$("#loading").hide();
           }      	
        };
	//收货商
        var receiverOptions = {
                success: function (data) {
                    $("#responseText").text(data);
                    console.log(data);
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
                	$("#uploadFormReceiver").attr("disabled",true);
                	$("#uploadFormReceiverButton").removeClass("btn_upload").addClass("gray")
                 	$("#loading").hide();
                   }  	
                };
      
	
    	//从业人员
        var comEmployeeOptions = {
                success: function (data) {
                    $("#responseText").text(data);
                    console.log(data);
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
                	$("#uploadFormComEmployee").attr("disabled",true);
                	$("#uploadFormComEmployeeButton").removeClass("btn_upload").addClass("gray")
                 	$("#loading").hide();
                   }  	
                };
        function cleanShow() 
        { 
        	$("#uploadFormInputBath_ts").html("");
        	$("#uploadFormOutputBath_ts").html("");
        	$("#uploadFormSampleBath_ts").html("");
    		$("#uploadFormInputMaterial_ts").html("");
    		$("#uploadFormOutputBath_ts").html("");
    		$("#uploadFormInputMaterial_ts").html("");	
    		$("#uploadFormOutputMaterial_ts").html("");
    		$("#uploadFormComEmployee_ts").html("");
        } 
  
            </script>
</body>
</html>