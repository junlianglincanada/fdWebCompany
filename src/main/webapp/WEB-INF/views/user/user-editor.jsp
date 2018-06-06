<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
      String id=request.getParameter("id");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
 <%@ include file="../include.jsp" %>
<title>万达食品安全追溯系统</title>

</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/user.user">用户管理</a> > <a href="../findView/user.user-editor">编辑用户</a> 
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="删除用户" rel="popup" link="../findView/user.user-del?id=<%=id %>" title="提示"/>
              </div>
          </h3>
          <div class="info_box">
            <form id="saveForm" >
               <table class="info_mation"  id="table">
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
                       <td name="personName"  id="personName"></td>
                       <!--   <td>
                       <div class="sysel">
                                <span class="text_sysel" style="display:none;"></span>
                                <input type="button" class="btn_shang" value="从从业人员中选择" rel="popup" link="user.employed-name" title="关联从业人员"  id="congye"/>
                                <span class="text_gray"> </span>
                           </div>
						</td> -->
                   </tr>
                    <tr>
                       <td class="td_lf"><em class="star">*</em>用户名</td>
                       <td ><input type="text" class="input_code" value="" id="username" name="username"   maxlength="30"/></td>
                   </tr>
                     <tr>
                       <td class="td_lf"><em class="star">*</em>密码</td>
                       <td><input type="password" class="input_code" name="password" value=""  id="password"  placeholder="请输入密码" onpropertychange="handle();" oninput="handle();"  maxlength="20"/></td>
                   </tr> 
                   <tr>
                   	<td class="td_lf"><em class="star">*</em>确认密码</td>
                    <td><input type="password" class="input_code"  id="newPassword"  placeholder="请输入确认密码" onkeyup="value=value.replace(/[`~!#$%^&*()+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!#$%^&*()+<>?:{},.\/;[\].]/g,''))" maxlength="20" value="" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf">&nbsp;</td>
                       <td id="open"><input type="checkbox" class="check_open" value="1"/><label for="open">开通企业管家权限（手机应用）</label></td>
                   </tr> 
                   <tr>
                       <td class="td_lf"><em class="star">*</em>手机</td>
                       <td id="mobilePhone" ></td>
                   </tr>
                  <%--  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>电话</td>
                       <td><input type="text" class="input_code" name="phone" value=""   id="phone"  onkeyup="value=value.replace(/[`~!@#$%^&*()+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"  maxlength="40"/></td>
                   </tr> --%>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>邮箱</td>
                       <td id="email"></td>
                   </tr>
                   <%-- <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>部门</td>
                       <td><input type="text" class="input_code" name="department" value=""  onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"  maxlength="20"/></td>
                   </tr> --%>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>岗位</td>
                       <td id="jobRole"></td>
                   </tr>
                   <!--  5.9日bugfix-->
                     <tr style="display: none;">
                       <td id="personId"></td>
                   </tr>
                   
              </table>
               <p class="save_box">
                  <input id="id" name="id" value="<%=id%>" type="hidden"/>
                  <input id="saveFormSubmit" type="button" class="btn_save" value="保存" />

                   <input  type="button" class="btn_save" value="返回" onclick="javascript:window.location.href='../findView/user.user'"/>
 
               </p>
              
               <div class="clear"></div>
        
            </form>
          </div>
       
     </div>
</div>    
<script type="text/javascript">

var params={};
var newPassword;

var id="<%=id %>";
//这里去掉了用户名后面的提示
$("#username").focus(function(){
	$("#table").find(".text_ts").remove();
});
//这里去掉了姓名后面的提示
$("#personName").focus(function(){
		  $("#table").find(".text_ts").remove();
	  });
//这里去掉了手机后面的提示
$("#mobilePhone").focus(function(){
		  $("#table").find(".text_ts").remove();
	  });
//这里去掉了手机后面的提示
$("#password").focus(function(){
		  $("#table").find(".text_ts").remove();
	  });
//这里去掉了手机后面的提示
$("#newPassword").focus(function(){
		  $("#table").find(".text_ts").remove();
	  });

var idChangedPassword=0;

function handle()   
{   
	idChangedPassword=1;
}   

$(document).ready(function () {
	
	search(id);
	
	$("body").on("blur","input[type='text']",function(){
		$(this).siblings(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	
	    	$(this).after('<span class="text_ts" style="margin-left:45px;">请勿入特殊字符 </span>');
	    }
	});
		
	    $("#saveFormSubmit").click(function () {
	    	var ajaxFlag=true;
	    	$("#table").find(".text_ts").remove();
	    	  params.id=$("#id").val();
	          params.username=$("#username").val();
	          flag=true;
	      	$("body input[type='text']").each(function(){
	      	    var inputValue=	$(this).val();
	      	    $(this).next(".text_ts").remove();
	      	    if(checkSpecificKey(inputValue)==false){
	      	    	$(this).after('<span class="text_ts" style="margin-left:45px;">请勿入特殊字符 </span>');
	      	    	flag=false;
	      	    	return ;
	      	    }
	      	});
	      	if(flag==false){
	      		return ;
	      	}

	          if(params.username==""||username==null){
	    			$("#username").after('<span class="text_ts">用户名不能为空 </span>')
	    			ajaxFlag=false;
	    		}
	      
	         
	      
	      	
	     	   params.password=$("#password").val();
	     	  newPassword=$("#newPassword").val();
	     	  if(idChangedPassword==1){
		    	   if(params.password==""||password==null){
		    			$("#password").after('<span class="text_ts">密码不能为空 </span>')
		    			ajaxFlag=false;
		    		} 
		          if(params.password!=""){var reg = /^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?![_@]+$)[a-zA-Z0-9@_]{6,20}$/;
		   			if(!reg.test(params.password)){
		   				
		   		    	  $("#password").after('<span class="text_ts">密码是6-20位数字、大小写字母、@_的至少两种组合。  </span>');
		   		    	ajaxFlag=false;
		   			}
		   		} 
		          if(newPassword==""||newPassword==null){
		    			$("#newPassword").after('<span class="text_ts">确认密码不能为空 </span>');
		    			ajaxFlag=false;
		    		}

		    	  if(params.password != newPassword){
		    			 
		    			 $("#newPassword").after('<span class="text_ts">您两次输入的密码不一致，请重新输入！！ </span>');
		    			 ajaxFlag=false;
		    		 } 
	     	  }
	    	  if(ajaxFlag==false){
	    		  return false;
	    	  }
	    	  params.personName=$("#personName").text();
	    	  /* if(params.personName==""||personName==null){
	    			$("#personName").after('<span class="text_ts">姓名不能为空 </span>')
	    			ajaxFlag=false;
	    			return false;
	    		}
	    	  $("#table").find(".text_ts").remove(); */
	    	  params.mobilePhone=$("#mobilePhone").text();
	    	 /*  if(params.mobilePhone==""||mobilePhone==null){
	    			$("#mobilePhone").after('<span class="text_ts">手机不能为空 </span>')
	    			ajaxFlag=false;
	    			return false;
	    		}
	    	  if(params.mobilePhone.length>11){
		    	  
	    		  $("#mobilePhone").after('<span class="text_ts">请输入正确的手机号码 </span>')
	    		  return false;

	    	  } */
	    	
	    	 // params.phone=$("#phone").val();
	    	  params.email=$("#email").text();
	    	  /* if(params.email!="")
	   			{var  reg=/^([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\-|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/gi;
	   			if(!reg.test(params.email)){
	   				
	   		    	  $("#email").after('<span class="text_ts">邮箱只能包含字母、数字和下划线等合法字符，长度在6-18之间！ </span>');
	   		    	  return false;
	   			}
	   				}  */
	    	  params.jobRole=$("#jobRole").text();
	   		  params.personId=$("#personId").text();
	    	  params.enabled=null;
	    	  //console.log(JSON.stringify(params));
	    	  var hasAppMgrPermission=$("#open").find("input:checkbox:checked").val();
	    	  if(hasAppMgrPermission==1){
	    		  params.hasAppMgrPermission=hasAppMgrPermission;
	    	  }
	          options = {
	            url: "../system/userMgr/updateLoginUser",
	            headers: {                         
	                'Accept': 'application/json',
	                'Content-Type': 'application/json' 
	            },
	            type: 'post',
	            dataType: 'json',
	            data:JSON.stringify(params),
	            success: function (data) {
	                if (data.status == 0)
	                location.href="../findView/user.user";
	                else{
	                	console.log(data.message);   
	                	$("#username").after('<span class="text_ts">此用户名已被使用，请重新输入。 </span>');
	                
	                }
	                }  	
	        };
	        $.ajax(options);
	        return false;
	    });




});

function search(id){
	$.ajax({
	url:"../system/userMgr/getLoginUser/"+id,
	type:"get",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:null,
	success:function(text) {
		
	
	     $("#loading").hide();
	
          console.log(text.body);
          if(text.status==0){
        	  newPassword=text.body.password;
              show(text);
          }
	 },   
	 error:function(text) {
	 }
	});
}

function show(text){
	//var inputMaterialInfo=text.body;
	//var guaranteeUnit="";
	
	

	
	$("#username").val(text.body.username);
	$("#password").val(text.body.password);
	$("#newPassword").val(newPassword);
	//newPassword=text.body.password;
	$("#personName").text(text.body.personName);
	$("#mobilePhone").text(text.body.mobilePhone);
	//$("#phone").val(text.body.phone);
	$("#email").text(isnull(text.body.email));
	$("#jobRole").text(isnull(text.body.jobRole)); 
	var hasAppMgrPermission=isnull(text.body.hasAppMgrPermission);
	if(hasAppMgrPermission==1){
		$("#open").find("input:checkbox").attr("checked",true);
	}
	$("#personId").text(text.body.personId);
	//val是上面有这个属性
	
}


</script>
</body>
</html>