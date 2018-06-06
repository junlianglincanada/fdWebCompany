<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
   
%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="../include.jsp" %>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/user.user?id=<%=id%>">用户管理</a> > <a href="../findView/user.user-view">查看用户</a> 
              <div class="btn_opera"> 
                  
                   <input type="button" class="btn_add" value="编辑用户" onClick="window.location.href='../findView/user.user-editor?id=<%= id %>'" />
              </div>
          </h3>
            <div class="info_box">
               <table class="info_mation">
                    <tr>
                       <td class="td_lf"><em class="star">*</em>用户名:</td>
						<td id=username></td>
					</tr>
					<tr>
                       <td class="td_lf">&nbsp;</td>
                       <td><input type="checkbox" class="check_open" value="1" id="open" disabled="disabled"/><label for="open">开通企业管家权限（手机应用）</label></td>
                   </tr>
                    <tr>
                       <td class="td_lf"><em class="star">*</em>姓名:</td>
                       <td id="personName"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>手机:</td>
                       <td id="mobilePhone"></td>
                   </tr>
                   <!--  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>电话:</td>
                       <td id="phone"></td>
                   </tr> -->
                    <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>邮箱:</td>
                       <td id="email"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>岗位:</td>
                       <td id="jobRole"></td>
                   </tr>

               </table>
               
               <p class="save_box">
                 

                   <input  type="button" class="btn_save" value="返回" onclick="javascript:window.location.href='../findView/user.user'"/>
 
               </p>
              
               
              
             
               <div class="clear"></div>                             
          </div>
     </div>
</div>    
<script type="text/javascript">
var params={};
var id="<%=id%>";
$("#loading").show();

//console.log(username);

$(document).ready(function () {

	search(id);
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
          //console.log(text.body);
          if(text.status==0){
              show(text);
              $("#loading").hide();
          }
	 },   
	 error:function(text) {
	 }
	});
}

function show(text){
	var mobilePhone=isnull(text.body.mobilePhone) ;
	 var jobRole=isnull(text.body.jobRole) ;
	 var personName=isnull(text.body.personName) ;
	 var email=isnull(text.body.email) ;
	 var username=isnull(text.body.username) ;
	 var hasAppMgrPermission=isnull(text.body.hasAppMgrPermission);
	 if(hasAppMgrPermission==1){
		 $("#open").attr("checked",true);
	 }
	 
	$("#username").text(username);
	$("#personName").text(personName);
	$("#mobilePhone").text(mobilePhone);           //给td赋值默认的死text的格式
	$("#email").text(email);
	$("#jobRole").text(jobRole);
	                            
	}
</script>


	
</body>
</html>