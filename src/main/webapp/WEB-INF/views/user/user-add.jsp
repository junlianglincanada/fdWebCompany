<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="../include.jsp" %>
<title>万达食品安全追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
  
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="user.user">用户管理</a> > <a href="user.user-add">新增用户</a> </h3>
          
          <div class="info_box">
                <form id="addForm" >
                 <table class="info_mation" style="border-bottom:1px solid #dcdddd;" id="table">
                     <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>选择从业人员</td>
                       <td>
                       <div class="sysel">
                                <span class="text_sysel" style="display:none;"></span>
                                <input type="button" class="btn_shang" value="从从业人员中选择" rel="popup" link="user.employed-name" title="关联从业人员"  id="congye"/>
                                <span class="text_gray">请从从业人员中选择姓名、手机等信息。</span>
                           </div>
						</td>
                  </tr>
                    <tr>
                       <td class="td_lf"><em class="star">*</em>姓名</td>
                       <td name="personName" value="" id="personName"  placeholder="请添加姓名"   maxlength="20"  disabled="true" ></td>
                       <!--   <td>
                       <div class="sysel">
                                <span class="text_sysel" style="display:none;"></span>
                                <input type="button" class="btn_shang" value="从从业人员中选择" rel="popup" link="user.employed-name" title="关联从业人员"  id="congye"/>
                                <span class="text_gray"> </span>
                           </div>
						</td> -->
                   </tr>
                   <tr>  
                   <tr>                 
                       <td class="td_lf"><em class="star">*</em>用户名</td>
                       <td><input type="text" class="input_code" name="username" value="" id="username"  placeholder="请输入用户名"   maxlength="30"/></td>
                       
                   </tr>
                    <tr>
                       <td class="td_lf"><em class="star">*</em>密码</td>
                       <td><input type="password" class="input_code" name="password" value=""  id="password"  placeholder="请输入密码" onkeyup="value=value.replace(/[`~!#$%^&*()+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!#$%^&*()+<>?:{},.\/;[\].]/g,''))"  maxlength="20"/>
                        <input id="personId" name="personId" type="hidden" /></td>
                   </tr> 
                   <tr>
                   	<td class="td_lf"><em class="star">*</em>确认密码</td>
                    <td><input type="password" class="input_code"  id="newPassword"  placeholder="请输入确认密码" onkeyup="value=value.replace(/[`~!#$%^&*()+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!#$%^&*()+<>?:{},.\/;[\].]/g,''))" maxlength="20" value="" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf">&nbsp;</td>
                       <td id="open"><input type="checkbox" class="check_open" value="1" checked="checked"/><label for="open">开通企业管家权限（手机应用）</label></td>
                   </tr>
                    <%-- <tr>
                       <td class="td_lf"><em class="star">*</em>确认密码</td>
                       <td><input type="password" class="input_code" name="password" value=""  id="password" placeholder="请输入确认密码" onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"  maxlength="20"/></td>
                   </tr>  --%>
                 
                   <tr>
                       <td class="td_lf"><em class="star">*</em>手机</td>
                       <td name="mobilePhone" value=""  id="mobilePhone"   placeholder="请添加手机号码"  maxlength="40"  disabled="true"></td>
                   </tr>
                  <%--  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>电话</td>
                       <td><input type="text" class="input_code" name="phone" value=""   id="phone"  onkeyup="value=value.replace(/[`~!@#$%^&*()+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"  maxlength="40"/></td>
                   </tr> --%>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>邮箱</td>
                       <td name="email" value=""   id="email"     maxlength="50"></td>
                   </tr>
                   <%-- <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>部门</td>
                       <td><input type="text" class="input_code" name="department" value=""  onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"  maxlength="20"/></td>
                   </tr> --%>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>岗位</td>
                       <td name="jobRole" value=""   id="jobRole"   placeholder="请添加岗位"   maxlength="20"  disabled="true"></td>
                   </tr>
                 
               </table>
               </form>
               	 
               <p class="save_box">
                
                  <input id="addFormSubmit" type="submit" class="btn_save" value="保存"  />                
                   <input type="submit" class="btn_save" value="返回" onclick="javascript:window.location.href ='../findView/user.user' " target="mainFrame" />
               </p>
                
               <div class="clear"></div>
          </div>
     </div>
</div>
<script type="text/javascript">


var id="<%=id %>";
var cpassword;
var params={};
var length;
 // $("#loading").show();
 
 
/*  这里是验证用户唯一性 */
  $("#username").blur(checkUserName);
 function checkUserName(){
	var ajaxFlag=true;
	var userName=$("#username").val();
	if(!checkSpecificKey(userName)){
		$("#username").next(".text_ts").remove();
		$("#username").after('<span class="text_ts" style="margin-left:45px;">请勿输入特殊字符 </span>');
		  $("#username").focus(function(){
			  $("#table").find(".text_ts").remove();
		  }); 
		  
		   //去掉了姓名后面的提示
		   $("#personName").focus(function(){
				  $("#table").find(".text_ts").remove();
			  }); 
		ajaxFlag=false;
	}
	if(ajaxFlag){
		$.ajax({
			url: "../register/checkUserExists",
			type:"post",
			dataType:'json',
			data:{"userName":userName},
			success: function(result) {
				if(result.body==true){
					$("#username").siblings(".text_ts").remove();					 
					  $("#username").after('<span class="text_ts">该用户名已存在 </span>');  //这里的方法有问题，问康哥
					checkUserNameFlag=false;
				}else{
					checkUserNameFlag=true;
				}
			},
			error: function(data) {
				alert("加载失败，请重试！");
			}
		});
	}
	
}
 
  
 
  
            //这里去掉了用户名后面的提示,这里取消了注释
	    $("#username").focus(function(){
		  $("#table").find(".text_ts").remove();
	  }); 
	    //这里去掉了密码后面的提示
	   $("#password").focus(function(){
			  $("#table").find(".text_ts").remove();
		  });
	   //去掉了确认密码的提示
	   $("#newPassword").focus(function(){
			  $("#table").find(".text_ts").remove();
		  });
	   //去掉了姓名后面的提示
	   $("#personName").focus(function(){
			  $("#table").find(".text_ts").remove();
		  });
	   //去掉了姓名的提示
	   $("#congye").focus(function(){
			  $("#table").find(".text_ts").remove();
		  });
         //调用这个事件，然后验证唯一性的
	  
	    
		     $("body").on("blur","input[type='text']",function(){
		    		$(this).siblings(".text_ts").remove();
		    		var inputValue=	$(this).val();
		    	    if(checkSpecificKey(inputValue)==false){
		    	    	
		    	    	$(this).after('<span class="text_ts" style="margin-left:45px;">请勿入特殊字符 </span>');
		    	    }
		    	});
		    		
		    	
		      	
         
	
	 
	  $("#addFormSubmit").click(function () {
		  //$("input").focus();
		  $("#table").find(".text_ts").remove();
	    	  params.id=$("#id").val();
	    	 
	          params.username=$("#username").val();
	          flag=true;
		      	$("body input[type='text']").each(function(){
		      	    var inputValue=	$(this).val();
		      	    $(this).next(".text_ts").remove();
		      	    if(checkSpecificKey(inputValue)==false){
		      	    	$(this).after('<span class="text_ts" style="margin-left:45px;">请勿输入特殊字符 </span>');
		      	    	flag=false;
		      	    	return ;
		      	    }
		      	});
		      	if(flag==false){
		      		return ;
		      	}
	          
	          if(params.username==""||username==null){
	    			$("#username").after('<span class="text_ts">用户名不能为空 </span>');
	    			ajaxFlag=false;
	    			return false;
	    		}
	         
	          //这里只需要提交一个personId就可以了，邮箱，姓名，手机，岗位都可以取消
	          params.personId=$("#personId").text();
	    	  params.password=$("#password").val();
	    	  if(params.password==""||password==null){
	    			$("#password").after('<span class="text_ts">密码不能为空 </span>');
	    			ajaxFlag=false;
	    			return false;
	    		}
	    	   if(params.password!="")
	   			{var reg = /^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?![_@]+$)[a-zA-Z0-9@_]{6,20}$/;
	   			if(!reg.test(params.password)){
	   				
	   		    	  $("#password").after('<span class="text_ts">密码是6-20位数字、大小写字母、@_的至少两种组合。 </span>');
	   		    	  return false;
	   			}
	   				} 
	    	 
	    	  
	    	    newPassword=$("#newPassword").val();
	    	  if(newPassword==""||newPassword==null){
	    			$("#newPassword").after('<span class="text_ts">确认密码不能为空 </span>');
	    			ajaxFlag=false;
	    			return false;
	    		}

	    	  if(params.password != newPassword){
	    			 
	    			 $("#newPassword").after('<span class="text_ts">您两次输入的密码不一致，请重新输入！！ </span>');
	    			 return false;
	    			 
	    		 } 
	    	 
	    	
	    		  
	    	  
	    	 
	    	  var personName=$("#personName").text();
	    	  params.personName=personName;
	    	   if(params.personName==""||personName==null){
	    		    alert("请在第一行添加从业人员的姓名、手机等相关信息");
	    			//$("#personName").after('<span class="text_ts">姓名请从从业人员中添加 </span>');
	    			ajaxFlag=false;
	    			return false;
	    		} 
	    	  var mobilePhone=$("#mobilePhone").text();	
	    	  params.mobilePhone=mobilePhone;
	    	 /*  if(params.mobilePhone==""||mobilePhone==null){
	    			$("#mobilePhone").after('<span class="text_ts">手机不能为空 ,请从从业人员添加</span>')
	    			ajaxFlag=false;
	    			return false;
	    		} */
	    	 /*  if(params.mobilePhone.length>11){
	    	  
	    		  $("#mobilePhone").after('<span class="text_ts">请输入正确的手机号码 ,请从从业人员添加</span>')
	    		  return false;

	    	  }
	    	  */
	    	  var email=$("#email").text();	
	    	  params.email=email;
	    	/*   if(params.email!="")
	   			{var  reg=/^([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/gi;
	   			if(!reg.test(params.email)){
	   				
	   		    	  $("#email").after('<span class="text_ts">邮箱只能包含字母、数字和下划线等合法字符，长度在6-18之间！ </span>');
	   		    	  return false;
	   			}
	   				}  */
	   		  var jobRole=$("#jobRole").text();	
	    	  params.jobRole=jobRole;
	    	  //params.enabled=null;
	    	  //console.log(JSON.stringify(params));
	    	  var hasAppMgrPermission=$("#open").find("input:checkbox:checked").val();
	    	  if(hasAppMgrPermission==1){
	    		  params.hasAppMgrPermission=hasAppMgrPermission;
	    	  }
	    	  console.log(params);
	          options = {
	            url: "../system/userMgr/createLoginUser",
	            headers: {                         
	                'Accept': 'application/json',
	                'Content-Type': 'application/json' 
	            },
	            type: 'post',
	            dataType: 'json',
	            data:JSON.stringify(params),
	            success: function (data) {
	                if (data.status == 0){
	                location.href="../findView/user.user";
	                //$("#loading").hide();
	                }else{
	                	console.log(data.message);   
	                	$("#username").after('<span class="text_ts">此用户名已被使用，请重新输入。 </span>');
	                
	                }
	                }
	          
	                	
	        };
	           
	        $.ajax(options);
	        return false;
	    });



</script>
</body>    
</html>