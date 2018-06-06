<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"  import="java.util.*,java.io.*"%>
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
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>
<script type="text/javascript">
var personId="<%=id%>";
var appLoginUserList;
var ajaxFlag=true;
function queryAccount(id){
	$.ajax({
		url:"../restaurant/comEmployee/accountExistAbooutEmp/"+id,
		type:"post",
		dataType:"json",
		success:function(result){
			console.log(result.body);
			if(result.status==0){
				appLoginUserList=result.body.resultList;
				if(appLoginUserList!=null&&appLoginUserList.length>0){
					$("#confirm1").hide();
					$("#confirm2").show();
				}
			}else{
				$("#confirm2").hide();
				$("#confirm1").show();
			}
			$("#loading").hide();
		},
		error:function() {
			alert("系统异常,数据加载失败");
		}
	});
}
function deleteAccount(id){
	$.ajax({
		url:"../system/userMgr/deleteLoginUser/"+id,
		type:"post",
		async:false,
	    headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
		data:null,
		success:function(result){
			if(result.status!=0){
				ajaxFlag=false;
				window.parent.alert(result.message);
				$(window.parent.document).find(".shadow_bg").fadeOut().remove();
				$(window.parent.document).find(".popup_box").fadeOut().remove();
			}
		},   
		error:function(e){
			console.log(e);
		}
	});
}
$(function(){
	queryAccount(personId);
	//确定按钮操作
	$("#btn_blue1").click(function(){
		$(":button").attr("disabled",true);
		$("#loading").show();
		$.ajax({
			url:"../restaurant/comEmployee/deleteComEmployee/"+personId,
			type:"get",
			success:function(result){
				$(":button").attr("disabled",false);
				console.log(result);
	        	if(result.status==0){
		        	$("#loading").hide();
		        	window.parent.location.href='../findView/restEmployee.restEmployeeView';
				}else{
		        	$("#loading").hide();
		        	window.parent.alert(result.message);
		        	$(window.parent.document).find(".shadow_bg").fadeOut().remove();
		     		$(window.parent.document).find(".popup_box").fadeOut().remove();
	        	}  

			},
			error:function(){
				window.parent.alert("系统异常,删除失败");
				$(window.parent.document).find(".shadow_bg").fadeOut().remove();
		     	$(window.parent.document).find(".popup_box").fadeOut().remove();
		    	$("#loading").hide();
			}
		});
	});
	$("#btn_blue2").click(function(){
		if(ajaxFlag){
			for(var i=0;i<appLoginUserList.length;i++){
				var accountId=appLoginUserList[i].id;
				deleteAccount(accountId);
			}
			$("#btn_blue1").click();
		}
	})
	//取消按钮操作
	$("input.btn_gray").live("click",function(){
		$(window.parent.document).find(".shadow_bg").fadeOut().remove();
		$(window.parent.document).find(".popup_box").fadeOut().remove();
	});
});
</script>
</head>
<body>
 <div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="ifr_box" id="confirm1" style="display:none">
     <p class="ifr_text">是否确认删除？</p>
     <div class="ifr_btn">
          <input type="button" class="btn_blue" value="确定" id="btn_blue1"/>
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>
<div class="ifr_box" id="confirm2" style="display:none">
     <p class="ifr_text">该从业人员已绑定系统账号，删除该从业人员将同时删除账号信息，是否确认删除？</p>
     <div class="ifr_btn">
          <input type="button" class="btn_blue" value="确定" id="btn_blue2"/>
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>
</body>
</html>