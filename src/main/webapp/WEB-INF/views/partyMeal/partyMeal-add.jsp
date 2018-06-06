<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp"%>
<style type="text/css">
span.text_ts {
	color: #ff6600;
	margin-left: 20px;
}

span.text_ts1 {
	color: #ff6600;
	margin-left: 20px;
}

span.text_ts2 {
	color: #ff6600;
	margin-left: 20px;
}
</style>
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" />
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js"
	type="text/javascript"></script>
<script type="text/javascript">

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
var delFlag;
var companyId;
params.partyMealDate="";
params.partyMealSeq="";
params.partyMealName="";
params.diningCount="";
params.partyMealType="";
params.remark="";


function isNumber(number){
	var patrn=/^\d{1,6}(?:\.\d{1,2}|\.?)$/;
	flg = patrn.test(number);
	if (flg) {
		return true;
	}
	return false;
}

$(function(){
	  
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}

	//这里去掉了宴会日期的提示
	$("#partyMealDate").focus(function(){
	 	$("#table").find(".text_ts").remove();
	 	
	 });   
	 
	 //这里去掉了宴会名称后面的提示
	 $("#partyMealName").focus(function(){
	 	$("#table").find(".text_ts1").remove();
	 	
	 });
	 
	 //这里去掉了就餐人数后面的提示
	 $("#diningCount").focus(function(){
	 		  $("#table").find(".text_ts2").remove();
	 		
	 	  });


	$(".btn_save").click( function(){
		$("#table").find(".text_ts").remove();
		$("#table").find(".text_ts1").remove();
		$("#table").find(".text_ts2").remove();
		var partyMealDate=$("#partyMealDate").val();
		var partyMealSeq=$("#partyMealSeq").find("input:radio:checked").val();
		var partyMealType=$("#partyMealType").find("input:radio:checked").val();
		var partyMealName=$("#partyMealName").val().trim();
		var diningCount=$("#diningCount").val().trim();
		
		var remark=$("#remark").val().trim(); 
		

		params.partyMealDate=partyMealDate;
	    params.partyMealSeq=partyMealSeq;
		params.partyMealName=partyMealName;
		params.diningCount=diningCount;
		params.partyMealType=partyMealType;
		params.remark=remark;
	

		
		   if(partyMealDate==""||partyMealDate==null){
			$("#partyMealDate").after('<span class="text_ts">宴会日期不能为空 </span>');
			ajaxFlag=false;
			return false;
		} 
      
     
      if(partyMealName==""||partyMealName==null){
			$("#partyMealName").after('<span class="text_ts1">宴会名称不能为空 </span>');
			ajaxFlag=false;
			return false;
		}
  

      
	  if(diningCount==""||diningCount==null||diningCount==0){
			$("#diningCount2").after('<span class="text_ts2">就餐人数不能为空 </span>');
			ajaxFlag=false;
			return false;
		}

		
		console.log(params);
		$("#loading").show();
			$.ajax({
				url:"../meal/partyMeal/createPartyMeal/",

										type : "post",
										data : JSON.stringify(params),
										dataType : "json",
										headers : {
											'Accept' : 'application/json',
											'Content-Type' : 'application/json'
										},
										success : function(result) {
											$("#loading").hide();
											//alert("保存成功！");
											window.location.href = "partyMeal.partyMeal";
										},
										error : function() {
											alert("系统异常，保存失败！");
										}
									});
						});

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
				<a href="#">编辑大型宴会申报</a>
			</h3>
			<div class="info_box">
				<table class="info_mation" id="table">
					<tr>
						<td class="td_lf"><em class="star">*</em>宴会日期</td>
						<td><input type="text" class="input_date"
							placeholder="请选择宴会日期" style="width: 222px;" id="partyMealDate"
							value="" readonly="readonly" /></td>

					</tr>
					<tr>
						<td class="td_lf"><em class="star">*</em>餐次</td>
						<td id="partyMealSeq"><label><input type="radio"
								name="radio_a" checked="checked" value="65001" /> 早餐</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<label><input type="radio" name="radio_a" value="65002" />
								中餐</label>&nbsp;&nbsp;&nbsp;&nbsp; <label><input type="radio"
								name="radio_a" value="65003" /> 晚餐</label>&nbsp;&nbsp;&nbsp;&nbsp; <label><input
								type="radio" name="radio_a" value="65004" /> 其它</label></td>


					</tr>
					<tr>
						<td class="td_lf"><em class="star">*</em>宴会名称</td>
						<td><input type="text" class="input_code" id="partyMealName"
							maxlength="100" /></td>
					</tr>
					<tr>
						<td class="td_lf"><em class="star">*</em>供餐人数</td>

						<td><input type="text" class="input_code necessary" value=""
							style="width: 50px; margin-right: 10px; float: left;"
							id="diningCount" maxlength="11"
							onkeyup="javascript:this.value=this.value.replace(/\D/g,'')">
							<span class="blues" id="diningCount2">人</span></td>
					</tr>
					<tr>
						<td class="td_lf"><em class="star">*</em>供餐方式</td>
						<td colspan="3" id="partyMealType"><label><input
								type="radio" name="radio_b" checked="checked" value="66001" />
								圆桌</label>&nbsp;&nbsp;&nbsp;&nbsp; <label><input type="radio"
								name="radio_b" value="66002" /> 自助餐</label>&nbsp;&nbsp;&nbsp;&nbsp; <label><input
								type="radio" name="radio_b" value="66003" /> 每人每 </label>&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td class="td_lf"><em class="star">&nbsp;</em>备注</td>
						<td colspan="3"><textarea class="textarea_code" id="remark"
								maxlength="255"></textarea><br /></td>
					</tr>
				</table>
				<p class="save_box">

					<input type="button" class="btn_save" value="保存" />


				</p>
				<div class="clear"></div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {

			/*--日历-发布--*/
			$('#partyMealDate').calendar({minDate:calDateByDay(-32), maxDate:calDateByDay(10)});

			/*-------jquery end-------*/
		});
	</script>
</body>
</html>