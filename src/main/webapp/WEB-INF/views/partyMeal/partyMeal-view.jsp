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
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" />
<style type="text/css">
table.info_mation td{vertical-align:middle;}
table.info_mation td.td_lf{line-height:25px;}
</style>
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
var id="<%=id%>";

var pageNum=-1;
var totalPage;
var totalNum;
var pageSize=-1;
var toUrl="";
var params = {};
var num;

var partyMealDate;
var partyMealSeq;
var partyMealName;
var diningCount;
var partyMealType;
var remark;
var sampleMeals={"":"","65001":"早餐","65002":"中餐","65003":"晚餐","65004":"其他"};
var sampleTypes={"":"","66001":"圆桌","66002":"自助餐","66003":"每人每"};
params.companyId="";
params.companyName="";
params.startDate="";
params.endDate="";
params.pageNo="";
params.pageSize="";

function search(pageNum){
	
	$("#loading").show();
	
	$.ajax({
		url: "../meal/partyMeal/getPartyMealById/"+id,

		type:"get",
	    headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
		data:JSON.stringify(params),
		
		success:function(result) {
			if(result.status==0){
				page(result);
				var resultList=result.body;
				$("#body").children().remove();
				
				console.log(resultList);
			
					
						id = resultList.id;
						companyId = isnull(resultList.companyId);
						partyMealDate = isnull(resultList.partyMealDate);
						partyMealSeq = sampleMeals[isnull(resultList.partyMealSeq)];
						partyMealName = isnull(resultList.partyMealName);
						diningCount = isnull(resultList.diningCount);
						partyMealType = sampleTypes[isnull(resultList.partyMealType)];
						remark = isnull(resultList.remark);
						delFlag = isnull(resultList.delFlag);

						createDate = resultList.createDate;
						if(partyMealDate!=""){
							var startDate=calDateByDay(-32);
							var endDate=calDateByDay(10);
							if(compareTime(partyMealDate.substring(0,10),startDate)||compareTime(endDate,partyMealDate.substring(0,10))){
								$("#btn_batch").remove();
							}
						}
						
						$("#partyMealDate").text(partyMealDate);
						$("#remark").text(remark);
						$("#partyMealName").text(partyMealName);
						$("#diningCount").text(diningCount);
						$("#partyMealType").text(partyMealType);
						$("#partyMealSeq").text(partyMealSeq);
						$("#loading").hide();
					}
					;
				},
				error : function(text) {
					console.log(text.message);
				}
			});
} 
$(function(){

    
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
	search(pageNum);
});

</script>
</head>
<body>


	<div class="main_box">
		<div id="loading"
			style="position: absolute; top: 50%; left: 50%; margin: 0 auto; height: 300px; z-index: 888; display: none;">
			<img src="../img/loading.gif">
		</div>

		<div class="main_con">
			<h3 class="process_title">
				<span>当前位置: </span><a
					href="../findView/partyMeal.partyMeal">大型宴会申报></a>
				<a href="#">查看大型宴会申报</a>

				<div class="btn_opera">
					<input type="button" class="btn_batch" value="编辑" id="btn_batch"
						onClick="window.location.href='../findView/partyMeal.partyMeal-edit?id=<%=id %>'" />
				</div>
			</h3>
			<div class="per_box">
				<table class="info_mation" style="width: auto;">
					<tr>
					<tr>
						<td class="td_lf"><em class="star">*</em>宴会日期</td>

						<td id="partyMealDate"></td>

					</tr>
					<tr>
						<td class="td_lf"><em class="star">*</em>餐次</td>
						<td id="partyMealSeq"></td>
					</tr>
					</tr>

					<tr>
					<tr>
						<td class="td_lf"><em class="star">*</em>宴会名称</td>
						<td id="partyMealName" style="word-wrap: break-word"></td>
					</tr>
					<tr>
						<td class="td_lf"><em class="star">*</em>就餐人数</td>

						<td id="diningCount"><span class="blues">人</span></td>

					</tr>
					<tr>
						<td class="td_lf"><em class="star">*</em>供餐方式</td>
						<td id="partyMealType"></td>
					</tr>
					<tr>
						<td class="td_lf"><em class="star"></em>备注</td>
						<td id="remark" Columns="50" TextMode="MultiLine"
							style="word-wrap: break-word; height: 80px; word-break: break-all;"></td>
					</tr>
				</table>
				<p class="save_box">

					<input type="button" class="btn_save" value="返回"
						onClick="window.location.href='../findView/partyMeal.partyMeal'" />
				<div id="loading"
					style="position: absolute; top: 50%; left: 50%; margin: 0 auto; height: 300px; z-index: 888; display: none;">
					<img src="../img/loading.gif">
				</div>

				</p>
				<div class="clear"></div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {

			/*--日历-发货--*/

			$('#date_para').calendar({
				onSetDate : function() {
					$('#date_prod').val(null);
					//
					$('#date_prod').calendar({
						maxDate : '#date_para'
					})
				}
			});

			/*--日历-生产--*/
			$('#date_prod').calendar();

			/*-------jquery end-------*/
		});
	</script>
</body>
</html>