<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>上海市餐饮食品安全信息追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/reAlert.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
var params={};
$(function(){
	$("#getPFMCompany").click(function(){
		var appID=$("#appID").val().trim();
		params.appID=appID;
		var key=$("#key").val().trim();
		params.key=key;
		var PFMCompanyID=$("#PFMCompanyID").val().trim();
		params.PFMCompanyID=PFMCompanyID;
		$.ajax({
			url: "../webservice/getPFMCompany/",
			type:"get",
			dataType:'json',
			data:params,
			success:function(result){
				$("#result").text(JSON.stringify(result));
			}
		});
	})
	$("#appBatchDetail").click(function(){
		var appID=$("#appID").val().trim();
		var key=$("#key").val().trim();
		var content=$("#content").val().trim();
		params.appID=appID;
		params.key=key;
		params.content=content;
		$.ajax({
			url: "../webservice/appBatchDetail/",
			type:"post",
			dataType:'json',
			data:params,
			success:function(result){
				$("#result").text(JSON.stringify(result));
			}
		});
	})
	$("#erpInputBatchDetail").click(function(){
		var appID=$("#appID").val().trim();
		var key=$("#key").val().trim();
		var companyID=$("#companyID").val().trim();
		var content=$("#content").val().trim();
		params.appID=appID;
		params.key=key;
		params.companyID=companyID;
		params.content=content;
		$.ajax({
			url: "../webservice/erpInputBatchDetail/",
			type:"post",
			dataType:'json',
			data:params,
			success:function(result){
				$("#result").text(JSON.stringify(result));
			}
		});
	})
	$("#erpOutputBatchDetail").click(function(){
		var appID=$("#appID").val().trim();
		var key=$("#key").val().trim();
		var companyID=$("#companyID").val().trim();
		var content=$("#content").val().trim();
		params.appID=appID;
		params.key=key;
		params.companyID=companyID;
		params.content=content;
		$.ajax({
			url: "../webservice/erpOutputBatchDetail/",
			type:"post",
			dataType:'json',
			data:params,
			success:function(result){
				$("#result").text(JSON.stringify(result));
			}
		});
	})
	$("#uploadImage").click(function(){
		var appID=$("#appID").val().trim();
		var key=$("#key").val().trim();
		var companyID=$("#companyID").val().trim();
		var content=$("#content").val().trim();
		var image=$("#image").val().trim();
		params.appID=appID;
		params.key=key;
		params.companyID=companyID;
		params.content=content;
		params.image=image;
		$.ajax({
			url: "../webservice/uploadImage/",
			type:"post",
			dataType:'json',
			data:params,
			success:function(result){
				$("#result").text(JSON.stringify(result));
			}
		});
	})
	$("#erpRetentionSamples").click(function(){
		var appID=$("#appID").val().trim();
		var key=$("#key").val().trim();
		var companyID=$("#companyID").val().trim();
		var content=$("#content").val().trim();
		params.appID=appID;
		params.key=key;
		params.companyID=companyID;
		params.content=content;
		$.ajax({
			url: "../webservice/erpRetentionSamples/",
			type:"post",
			dataType:'json',
			data:params,
			success:function(result){
				$("#result").text(JSON.stringify(result));
			}
		});
	})
	$("#erpEmployees").click(function(){
		var appID=$("#appID").val().trim();
		var key=$("#key").val().trim();
		var companyID=$("#companyID").val().trim();
		var content=$("#content").val().trim();
		params.appID=appID;
		params.key=key;
		params.companyID=companyID;
		params.content=content;
		$.ajax({
			url: "../webservice/erpEmployees/",
			type:"post",
			dataType:'json',
			data:params,
			success:function(result){
				$("#result").text(JSON.stringify(result));
			}
		});
	})
})
</script>
</head>
<body>
<div class="main_box" style="padding:0;">
     <div class="main_con">
          <div class="acc_box">
           	   <div>
                    <ul>                      
                        <li><i class="icon_user"></i><input type="text" class="text_login" id="appID" value="" style="color:gray" placeholder="appID"/></li>
                        <li><i class="icon_pwd"></i><input type="text" class="text_login" id="key" value="" style="color:gray" placeholder="key"/></li>
                        <li><i class="icon_user"></i><input type="text" class="text_login" id="companyID" value="" style="color:gray" placeholder="companyID"/></li>
                        <li><i class="icon_user"></i><input type="text" class="text_login" id="PFMCompanyID" value="" style="color:gray" placeholder="PFMCompanyID"/></li>
                        <li><textarea class="textarea_code" style="width:90%;color:gray;" id="content" placeholder="content"></textarea></li>
                        <li><textarea class="textarea_code" style="width:90%;color:gray;" id="image" placeholder="image"></textarea></li>
                    </ul>
               </div>
               <table class="info_mation">
               		<tr><td>/fdWebCompany/webservice/getPFMCompany</td><td><input type="button" class="paging_btn" value="提交" id="getPFMCompany"/></td></tr>
               		<tr><td>/fdWebCompany/webservice/appBatchDetail</td><td><input type="button" class="paging_btn" value="提交" id="appBatchDetail"/></td></tr>
               		<tr><td>/fdWebCompany/webservice/erpInputBatchDetail</td><td><input type="button" class="paging_btn" value="提交" id="erpInputBatchDetail"/></td></tr>
               		<tr><td>/fdWebCompany/webservice/erpOutputBatchDetail</td><td><input type="button" class="paging_btn" value="提交" id="erpOutputBatchDetail"/></td></tr>
               		<tr><td>/fdWebCompany/webservice/uploadImage</td><td><input type="button" class="paging_btn" value="提交" id="uploadImage"/></td></tr>
               		<tr><td>/fdWebCompany/webservice/erpRetentionSamples</td><td><input type="button" class="paging_btn" value="提交" id="erpRetentionSamples"/></td></tr>
               		<tr><td>/fdWebCompany/webservice/erpEmployees</td><td><input type="button" class="paging_btn" value="提交" id="erpEmployees"/></td></tr>
               		<tr><td colspan="2" id="result" style="color:red"></td></tr>
               </table>
          </div>
     </div>
</div>    
</body>
</html>