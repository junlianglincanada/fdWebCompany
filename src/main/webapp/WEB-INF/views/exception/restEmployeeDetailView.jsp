<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
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
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/exception.exception-warn">人员预警</a> > <a href="#">查看详情</a>
           </h3>
          <div class="info_tab">
               <a href="../findView/exception.restEmployeeDetailView?id=<%=id %>" class="default">基本信息</a>
               <a href="../findView/exception.restEmployeeDetailView-photo?id=<%=id %>">证件信息</a>
          </div>
          <div class="info_box">
               <table class="info_mation" style="border-bottom:1px solid #dcdddd;">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>姓名</td>
                       <td id="personName"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>性别</td>
                       <td id="sexValue"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>证件类型</td>
                       <td id="idTypeValue"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>手机</td>
                       <td id="mobilePhone"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>电话</td>
                       <td id="phone"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>邮箱</td>
                       <td id="email"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>岗位</td>
                       <td id="jobRole"></td>
                   </tr>
               </table>  
               <div class="photo_report" style="margin:0;position:absolute;top:0px; left:620px; z-index:200;">
                     <div class="licen_img">
                          <div rel="img" style="border:1px dotted #ddd;"><img src="../images/i_user.jpg" id="photoPath"/></div>
                     </div>
               </div>
          </div>
         <%--  <p class="save_box">
             <input type="button" class="btn_save" value="返回" onClick="window.location.href='/findView/restEmployee.restEmployeeView'"/>
          </p> --%>
     </div>
</div>    
<script type="text/javascript">
var id="<%=id %>";
//查询方法
function queryCompany(id){
	$("#loading").show();
	$.ajax({
		url:"../restaurant/comEmployee/getComEmployee/"+id,
		type:"post",
		dataType:"json",
		success:function(result){
			console.log(result.body);
			if(result.status==0){
				var employee=result.body.employee;
				var personName=isnull(employee.personName);//人员名称
				var jobRole=isnull(employee.jobRole);//岗位
				var sexValue=isnull(employee.sexValue);//性别
				var idTypeValue=isnull(employee.idTypeValue);//证件类型
				var mobilePhone=isnull(employee.mobilePhone);//手机号码
				var phone=isnull(employee.phone);//电话号码
				var idNumber=isnull(employee.idNumber);//证件号码
				var email=isnull(employee.email);//邮箱
				var photoPath=isnull(employee.photoPath);//图片地址
				if(photoPath!=""){
					$("#photoPath").attr("src","<%=fdWebFileURL%>"+photoPath);
				}
				
				$("#personName").text(personName);
				$("#jobRole").text(jobRole);
				$("#sexValue").text(sexValue);
				if(idTypeValue!=""){
					$("#idTypeValue").text(idTypeValue+"：   "+idNumber);	
				}
				$("#mobilePhone").text(mobilePhone);
				$("#phone").text(phone);
				$("#email").text(email);
				
					}
			$("#loading").hide();
				},
				error : function() {
					alert("系统异常,数据加载失败");
					$("#loading").hide();
				}
			});
		}
	
$(function(){
	queryCompany(id);
	
});	
</script>
</body>
</html>