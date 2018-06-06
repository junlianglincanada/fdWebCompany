<%@ page language="java" pageEncoding="UTF-8"%>
<%
   
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

 <%@ include file="../include.jsp" %>
</head>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
</style>

<script type="text/javascript">
var id="<%=id %>";
var backId;
var loginUserId;
$(function(){
/* 	//判断是否当前用户
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
	     success:function(text){ 
	         console.log(text.body);
	         loginUserId=text.body.id;
	         if(loginUserId==id){
	        	 $(".ifr_text").text("该用户为当前登录用户，删除后将自动登出，你确定删除本信息？");
	         }
}       
	    }); */
	
	$("input.btn_blue").live("click",function(){
		$("#loading").show();
		 $("#deleteLogin").attr("disabled",true);
		   if(id!=null)
		 $.ajax({
				url:"../system/userMgr/deleteLoginUser/"+id,
				type:"post",
			    headers: { 
			        'Accept': 'application/json',
			        'Content-Type': 'application/json' 
			    },
			    dataType:'json',
				data:null,
				success:function(text) {
					if(text.status==0){
						backId=text.body;
						if(backId==id)
							{window.parent.location.href="..";}
						else{
						window.parent.location.href="../findView/user.user";}
					}else{
						window.parent.alert(text.message);
						$(window.parent.document).find(".shadow_bg").fadeOut().remove();
						$(window.parent.document).find(".popup_box").fadeOut().remove();
					}
					$("#loading").hide();
				 },   
				 error:function(text) {
					 console.log(text);
						$("#table_jg").html("删除失败！！")
				 }
				});
	});
	$("input.btn_gray").live("click",function(){
		$(window.parent.document).find(".shadow_bg").fadeOut().remove();
		$(window.parent.document).find(".popup_box").fadeOut().remove();
	});
/*-------jquery end-------*/
});	
</script>
</head>
<body>
<div class="ifr_box">
     <p class="ifr_text">是否确认删除？</p>
     <div class="ifr_btn">
          <input id="deleteLogin" type="button" class="btn_blue" value="确定" />
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div>
</body>
</html>