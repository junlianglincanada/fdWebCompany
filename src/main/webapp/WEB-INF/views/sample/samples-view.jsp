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
var sampleMeals={"":"","52001":"早餐","52002":"中餐","52003":"晚餐","52004":"其他"};
var sampleTypes={"":"","53001":"食堂","53002":"集体配送","53003":"重大活动","53004":"餐饮服务"};
var sampleUnits={"":"","50001":"g","50002":"份"};
$(function(){
	$("#loading").show();
	$.ajax({
		url:"../retentionSample/getSampleById/"+id,
		type:"get",
		headers:{},
		success:function(result){
			if(result.status==0){
				console.log(result.body);
				var sampleDate=isnull(result.body.sampleDate);
				if(sampleDate!=""){
					var startDate=calDateByDay(-32);
					var endDate=calDateByDay(10);
					if(compareTime(sampleDate.substring(0,10),startDate)||compareTime(endDate,sampleDate.substring(0,10))){
						$("#btn_add").remove();
					}
				}
				
				var sampleMeal=sampleMeals[isnull(result.body.sampleMeal)];
				var sampleType=sampleTypes[isnull(result.body.sampleType)];
				var diningCount=isnull(result.body.diningCount);
				var sampleDescription=isnull(result.body.sampleDescription);
				var cateringWay=isnull(result.body.cateringWay);
				$("#sampleDate").text(sampleDate);
				$("#sampleMeal").text(sampleMeal);
				$("#sampleType").text(sampleType);
				$("#diningCount").text(diningCount);
				if(sampleType=="集体配送"){
					$("#count_text").html('<em class="star">&nbsp;</em>配送数量');
					$(".blues").hide();
				}
				if(sampleType=="重大活动"){
					var $tr=$('<tr><td class="td_lf"><em class="star">&nbsp;</em>供餐方式</td><td>'+cateringWay+'</td><td class="td_lf"></td><td>&nbsp;</td></tr>');
					$(".info_mation tr:eq(3)").after($tr)
				}
				if(sampleType=="餐饮服务"){
					$(".info_mation tr:eq(3)").remove();
				}
				$("#sampleDescription").text(sampleDescription);
				var samples=result.body.sampleDetailList;
				$("#mainTable").children().remove();
				for(var i=0;i<samples.length;i++){
					var sampleName=isnull(samples[i].sampleName);
					var sampleQty=isnull(samples[i].sampleQty);
					var sampleUnit=sampleUnits[isnull(samples[i].sampleUnit)];
					var content='<tr>';
					content+='<td class="td_lf"><em class="star">&nbsp;</em>样品名称</td>';
					content+='<td>'+sampleName+'</td>';
					content+='<td class="td_lf"><em class="star">&nbsp;</em>样品数量</td>';
					content+='<td>'+sampleQty+' '+sampleUnit+'</td>';
					content+='</tr>';
					var $tr=$(content);
					$("#mainTable").append($tr);
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
          <h3 class="process_title"><span>当前位置: </span><a href="sample.samples">留样登记</a> > <a href="javascript:void(0)">查看留样登记</a> 
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" id="btn_add" value="编辑" onClick="window.location.href='sample.samples-editor?id=<%=id %>'" />
              </div>
          </h3>
          <h4 class="per_title"><span>基本信息</span></h4>
          <div class="per_box">
               <table class="info_mation" style="table-layout:fixed; width:auto;">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>留样日期</td>
                       <td id="sampleDate"></td>
                       <td class="td_lf">&nbsp;</td>
                       <td>&nbsp;</td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>留样餐次</td>
                       <td id="sampleMeal"></td>
                       <td class="td_lf">&nbsp;</td>
                       <td>&nbsp;</td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>留样类型</td>
                       <td id="sampleType"></td>
                       <td class="td_lf">&nbsp;</td>
                       <td>&nbsp;</td>
                   </tr>
                   <tr>
                       <td class="td_lf"><span id="count_text"><em class="star">&nbsp;</em>就餐人数</span></td>
                       <td><span id="diningCount"></span> <span class="blues">人</span></td>
                       <td class="td_lf">&nbsp;</td>
                       <td>&nbsp;</td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>留样说明</td>
                       <td colspan="3" id="sampleDescription" style="word-break:break-all;">&nbsp;</td>
                       <td class="td_lf">&nbsp;</td>
                       <td>&nbsp;</td>
                   </tr>
               </table>
          </div>
          <h4 class="per_title"><span>样品信息</span></h4>
          <div class="per_box">
               <table class="info_mation" style="width:auto;" id="mainTable">
               </table>
          </div>
     </div>
</div>    
</body>
</html>