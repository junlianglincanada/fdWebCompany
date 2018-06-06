<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/exception.exception-warn">人员预警</a> > <a href="#">查看详情</a> </h3>
          <div class="info_tab">
               <a href="../findView/exception.restEmployeeDetailView?id=<%=id %>">基本信息</a>
               <a href="../findView/exception.restEmployeeDetailView-photo?id=<%=id %>" class="default">证件信息</a>
          </div>
          <div class="info_box">
               <table class="info_mation" style="border-bottom:1px solid #dcdddd;">
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>健康证号码</td>
                       <td  id="licenceNum"></td>
                      
                  </tr>
                  <tr> <td class="td_lf" ><em class="star">&nbsp;</em>到期日期</td>
                       <td id="expireDate"></td></tr>
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>健康证图片</td>
                       <td >
                           <div class="photo_report" style="margin:0;display:none;" id="photo_report">
                              <div class="licen_img">
                                   <div rel="img"><img src=""  id="filePath"/></div>
                              </div>
                          </div>
                       </td>
                  </tr>
				</table>
                <table class="info_mation">
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>培训证号码</td>
                       <td  id="trainingOrgType"></td>
                      
                  </tr>
                  <tr> <td class="td_lf" ><em class="star">&nbsp;</em>等级</td>
                       <td id="licenceLevelValue"></td></tr>
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>到期日期</td>
                       <td  id="endDate"></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>培训证图片</td>
                       <td colspan="3">
                           <div class="photo_report" style="margin:0;display:none;" id="photo_report1">
                              <div class="licen_img">
                                   <div rel="img"><img src="" id="trainingImg"/></div>
                              </div>
                          </div>
                       </td>
                  </tr>
                </table>
          </div>
      <%--  <p class="save_box">
             <input type="button" class="btn_save" value="返回" onClick="window.location.href='../findView/restEmployee.restEmployeeView'" /></p> --%>
         
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
			if(result.status==0){
				var licence=isnull(result.body.licence);
				if(licence!=""){
					for(var i=0;i<licence.length;i++){
						if(licence[i].licenceType==26001){
							var expireDate=isnull(licence[i].expireDate);
							var filePath=isnull(licence[i].filePath);
							var licenceNum=isnull(licence[i].licenceNum);
							$("#expireDate").text(expireDate);
							$("#licenceNum").text(licenceNum);
							if(filePath!=""){
								$("#photo_report").show();
								$("#filePath").attr("src","<%=fdWebFileURL%>"+filePath);
							}
						}
						if(licence[i].licenceType==26002){
							var expireDate=isnull(licence[i].expireDate);
							var licenceLevelValue=isnull(licence[i].licenceLevelValue);
							var filePath=isnull(licence[i].filePath);
							var licenceNum=isnull(licence[i].licenceNum);
							$("#endDate").text(expireDate);
							$("#licenceLevelValue").text(licenceLevelValue);
							$("#trainingOrgType").text(licenceNum);
							if(filePath!=""){
								$("#photo_report1").show();
								$("#trainingImg").attr("src","<%=fdWebFileURL%>"+filePath);
							}
						}
				}
			
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


$(function(){
	queryCompany(id);
});	
</script>
</body>
</html>