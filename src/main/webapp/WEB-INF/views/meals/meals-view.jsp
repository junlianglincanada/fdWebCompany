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
<style type="text/css">
table.info_mation td{vertical-align:middle;}
table.info_mation td.td_lf{line-height:25px;}
</style>
<script type="text/javascript">
var id="<%=id %>";
var groupMealSeqs={"":"","62001":"早餐","62002":"中餐","62003":"晚餐","62004":"其他"};
var groupMealTypes={"":"","63001":"自助餐","63002":"桌餐","63003":"简单餐","63004":"每人份餐","63005":"其他"};
var outputCategories={"":"","64001":"净菜","64002":"调理半成品","64003":"即食冷膳食","64004":"即食热膳食","64005":"即食果蔬","64006":"其他"}

String.prototype.trimcode=function() { return this.replace(/(^,*)|(,*$)/g, ""); }
$(function(){
	$("#loading").show();
	$.ajax({
		url:"../meal/groupMeal/getGroupMealById/"+id,
		type:"get",
		headers:{},
		success:function(result){
			if(result.status==0){
				console.log(result.body);
				var diningCompanyName=isnull(result.body.diningCompanyName);
				var diningCompanyAddress=isnull(result.body.diningCompanyAddress);
				var diningCompanyContactPerson=isnull(result.body.diningCompanyContactPerson);
				var diningCompanyContactPhone=isnull(result.body.diningCompanyContactPhone);
				var groupMealDate=isnull(result.body.groupMealDate);
				var groupMealSeq=groupMealSeqs[isnull(result.body.groupMealSeq)];
				var diningCount=isnull(result.body.diningCount);
				var groupMealType=groupMealTypes[isnull(result.body.groupMealType)];
				var foodSafeStaff=isnull(result.body.foodSafeStaff);
				var foodSafeStaffPhone=isnull(result.body.foodSafeStaffPhone);
				var outputCategory=isnull(result.body.outputCategory);
				var groupMealTypeDesc=isnull(result.body.groupMealTypeDesc);
				var outputCategoryDesc=isnull(result.body.outputCategoryDesc);
				if(groupMealDate!=""){
					var startDate=calDateByDay(-32);
					var endDate=calDateByDay(10);
					if(compareTime(groupMealDate.substring(0,10),startDate)||compareTime(endDate,groupMealDate.substring(0,10))){
						$("#btn_batch").remove();
					}
				}
				
				$("#diningCompanyName").text(diningCompanyName);
				$("#diningCompanyAddress").text(diningCompanyAddress);
				$("#diningCompanyContactPerson").text(diningCompanyContactPerson);
				$("#diningCompanyContactPhone").text(diningCompanyContactPhone);
				$("#groupMealDate").text(groupMealDate);
				$("#groupMealSeq").text(groupMealSeq);
				$("#diningCount").text(diningCount);
				if(groupMealType=="其他"){
					groupMealType=groupMealTypeDesc;
				}
				$("#groupMealType").text(groupMealType);
				$("#foodSafeStaff").text(foodSafeStaff);
				$("#foodSafeStaffPhone").text(foodSafeStaffPhone);
				if(outputCategory!=""){
					var str=outputCategory.split(",");
					var output="";
					for(var i=0;i<str.length;i++){
						var opt=outputCategories[str[i]];
						if(opt=="其他"){
							opt=outputCategoryDesc;
						}
						output+=opt+",";
					}
					output=output.trimcode();
					$("#output").text(output);
				}
				$("#loading").hide();
			}
		},
		error:function(){
			alert("系统异常，查询失败");
		}
	});
}); 
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="meals.meals">团膳外卖登记</a> > <a href="javascript:void(0)">查看团膳外卖登记</a> 
              <div class="btn_opera"> 
                   <input type="button"  id="btn_batch" class="btn_add" value="编辑" onClick="window.location.href='meals.meals-editor?id=<%=id %>'" />
              </div>
          </h3>
          <h4 class="per_title"><span>团膳用餐单位信息</span></h4>
          <div class="per_box">
               <table class="info_mation" style="width:auto;">
                   <tr>
                       <td class="td_lf" style="text-align:right;" ><em class="star">*</em>名称</td>
                       <td id="diningCompanyName"></td>
                       <td class="td_lf" style="text-align:right;"><em class="star">*</em>地址</td>
                       <td id="diningCompanyAddress"></td>
                   </tr>
                   <tr>
                       <td class="td_lf" style="text-align:right;"><em class="star">&nbsp;</em>联系人</td>
                       <td id="diningCompanyContactPerson"></td>
                       <td class="td_lf" style="text-align:right;"><em class="star">&nbsp;</em>联系电话</td>
                       <td id="diningCompanyContactPhone"></td>
                   </tr>
               </table>
          </div>
          <h4 class="per_title"><span>供餐点信息</span></h4>
          <div class="per_box">
               <table class="info_mation" style="width:auto;">
                   <tr>
                       <td class="td_lf" style="text-align:right;"><em class="star">*</em>供餐日期</td>
                       <td colspan="3" id="groupMealDate"></td>
                   </tr>
                   <tr>
                       <td class="td_lf" style="text-align:right;"><em class="star">*</em>餐次</td>
                       <td id="groupMealSeq"></td> 
                       <td class="td_lf" style="text-align:right;"><em class="star">*</em>用餐人数</td>
                       <td><span id="diningCount"></span> <span class="blues">人</span></td>
                   </tr>
                   <tr>
                       <td class="td_lf" style="text-align:right;"><em class="star">*</em>供餐方式</td>
                       <td colspan="3" id="groupMealType"></td>
                   </tr>
                   <tr>
                       <td class="td_lf" style="text-align:right;"><em class="star">*</em>配送品种</td>
                       <td colspan="3" id="output"></td> 
                   </tr>
                   <tr>
                       <td class="td_lf" style="text-align:right;"><em class="star">*</em>食品安全管理人员</td>
                       <td id="foodSafeStaff"></td> 
                       <td class="td_lf" style="text-align:right;"><em class="star">*</em>电话</td>
                       <td id="foodSafeStaffPhone"></td>
                   </tr>
               </table>
          </div>
     </div>
</div>    	
</body>
</html>