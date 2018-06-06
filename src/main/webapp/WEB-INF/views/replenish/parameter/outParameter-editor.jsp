<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" /> 
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">

var params = {};
var id="<%=id%>";
var modelId;
var pageNum=1;
var pageSize=20;
var receiverName;
function isNumber(number){
	var patrn=/^\d{1,6}(?:\.\d{1,2}|\.?)$/;
	flg = patrn.test(number);
	if (flg) {
		return true;
	}
	return false;
}

$(function(){
	
	
$.ajax({
		url:"../outputManage/outputBatch/getOutputBatchById/"+id,
		type:"get",
		data:JSON.stringify(params),
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    success:function(result){
	    	var dto=result.body;
	    	//var id=dto.id;
			var outputDate=isnull(dto.outputDate);
			var outputMatName=isnull(dto.outputMatName);
			var spec=isnull(dto.spec);
			var manufacture=isnull(dto.manufacture);
			var quantity=isnull(dto.quantity);
			//var newBatchId=isnull(dto.newBatchId);
			var productionDate=isnull(dto.productionDate);
			var productionBatch=isnull(dto.productionBatch);
			var receiverName=isnull(dto.receiverName);
			var receiverId=isnull(dto.receiverId);
			var delFlag=isnull(dto.delFlag);
			var outputMatId=isnull(dto.outputMatId);
			var traceCode=isnull(dto.traceCode);
			modelId=receiverId;
			
			
	    	$("#date_para").val(outputDate);
	    	$("#receiverName").val(receiverName);
	    	$("#spec").text(spec);
	    	$("#manufacture").text(manufacture);
	    	$("#quantity").val(quantity);
	    	$("#date_prod").val(productionDate);
	    	$("#productionBatch").val(productionBatch);
	    	$("#outputMatName").text(outputMatName);
	    	$("#receiverId").val(receiverId);
	    	$("#delFlag").val(delFlag);
	    	$("#outputMatId").val(outputMatId);	
	    	$("#traceCode").val(traceCode);
	    	$('#date_prod').calendar( { maxDate:'#date_para'});
			document.getElementById("name1").innerHTML = result.body.receiverName;

	    },
	    error:function(){
	    	alert("系统异常，查询失败！");
	    	
	    }
	});
	

$("#receiverName").focus(function(){
	var keyWords = $("#receiverName").val().trim();
	var Params={'name':keyWords};
	$.ajax({
 	 		type:"post",
 	 	    headers: { 
 	 	        'Accept': 'application/json',
 	 	        'Content-Type': 'application/json' 
 	 	    },
 	 	    dataType:'json',
  			data:JSON.stringify(Params),
  			url: "../inputManage/receiver/queryReceiversByName/"+pageNum+"/"+pageSize,
  			success: function(data) {
  				 //alert(result.body);
  				$('#receiverName').bind("input.autocomplete", function () {
      							 $(this).trigger('keydown.autocomplete');
  					 });
  				$("#receiverName ").autocomplete(data.body.resultList,{
  					minChars: 0,
  					width: 208,
  					max:12,
  					matchContains: true,
  					autoFill: false,
  					scroll: false,
  					dataType: 'json',
  					
  					formatItem: function(row, i, max) {
  						return  "<font color=green>" + row.name + "</font>" ;
  					},
  					formatMatch: function(row, i, max) {
  						return row.name ;
  					},
  					formatResult: function(row) {
  						return row.name;
  					}
  				}).result(function(event,data,formatted){
  					document.getElementById("receiverName").style.borderColor="#cccccc";//边框颜色
  					var receiverId=data.id;
  					if(receiverId!=null&&receiverId!=""){
  						$("#receiverId").val(receiverId);
  						modelId=receiverId;
  						receiverName=$("#receiverName").val().trim();
  					}
		        });
				/* initAutoComplete(json);	 */	
  				},
  			error: function(data) {
  				alert("加载失败，请重试！");
  				}
  			});
});	  


$("body").on("blur","input[type='text']",function(){
	$(this).next(".text_ts").remove();
	var inputValue=	$(this).val();
	if(checkSpecificKey(inputValue)==false){
	$(this).after('<span class="text_ts" style="margin-left:45px;">请勿入特殊字符 </span>');
	}
});


	
$(".btn_save").click( function(){
	
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
	var outputDate=$("#date_para").val();
	var quantity=$("#quantity").val().trim();
	var productionDate=$("#date_prod").val().trim();
	var productionBatch=$("#productionBatch").val().trim();
	var receiverId =$("#receiverId").val().trim();
	var traceCode=$("#traceCode").val().trim();	
	//var delFlag ;
	var outputMatId=$("#outputMatId").val().trim(); 
	//var outputMatName =$("#outputMatName").val().trim();
	//params.receiverName=receiverName;
	//params.outputMatName=outputMatName;

	params.receiverId=receiverId;
    params.id=id;
	params.outputDate=outputDate;
	params.delFlag=1;
	params.outputMatId=outputMatId;
	params.traceCode=traceCode;
	if(outputDate==null||outputDate==""){
		$("#date_para").after('<span class="text_ts" style="margin-left:50px;">请选择发货日期 </span>');
		
		return;
	}

	if(receiverId==null||receiverId==""){
		$("#receiverId").after('<span class="text_ts" style="margin-left:45px;">收货商不存在</span>');

		//alert("收货商不存在");
		document.getElementById("receiverName").style.borderColor="#ff0000";//边框颜色
		document.getElementById("receiverName").value = null;
		return;
	}

	if(quantity==""||quantity==null){
		$("#quantity").after('<span class="text_ts" style="margin-left:50px;">产品数量不能为空 </span>');
		//alert("产品数量不能为空");
		return;
	}	
	if(isNumber(quantity)==false||1*quantity<=0){
		$("#quantity").after('<span class="text_ts" style="margin-left:50px;">请输入正确的数量 </span>');

		//alert("请输入正确的数量");
		return;
	}else{
		params.quantity=quantity;
	}

	if((productionDate==null||productionDate=="")&&(productionBatch==null||productionBatch=="")){
		$("#productionBatch").after('<span class="text_ts" style="margin-left:45px;">生产日期和批次号填写一项</span>');

		//alert("生产日期和批次号填写一项");
		return;
	}else{
		if(productionDate!=null&&productionDate!=""){
			params.productionDate=productionDate;
		}
		if(productionBatch!=null&&productionBatch!=""){
			params.productionBatch=productionBatch;
		}
	}
	
	console.log(params);
	$("#loading").show();
		$.ajax({
			url:"../outputManage/outputBatch/updateOutputBatch",
			type:"post",
			data:JSON.stringify(params),
			dataType:"json",
			headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    success:function(result){
		    	$("#loading").hide();
		    	alert("保存成功！");
		    	window.location.href="replenish.parameter.outParameter";
		    },
		    error:function(){
		    	alert("系统异常，保存失败！");
		    }
		});
	});
	
$("#receiverName").blur(function(){
	if($(this).val().trim()!=receiverName&&$("#receiverId").val().trim()==modelId){
			//alert(supplierName);
			//alert(modelId);
			$("#receiverId").val("");
			$("#receiverName").val(receiverName);
	}
	if($(this).val().trim()==receiverName&&$("#receiverId").val().trim()!=modelId){
		//alert(modelId);
		$("#receiverId").val(modelId);
	}
	});		
	
var availableTags = [
					 "上海华美饮料有限公司", 
					 "上海力华营销有限公司",
					 "上海耀剑农产品有限公司",
					 "上海新华农业信用合作社"
					 ];
	
$("#receiver_name").autocomplete({
    source: availableTags
});
	
});


</script>
</head>
<body>

<div class="main_box">
	<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>

     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.parameter.outParameter">近期发货维护></a> <a href="#">编辑近期发货维护</a>  > <a id="name1"></a>
          </h3>
          <div class="info_box">
               <table class="info_mation">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>发货日期</td>
                       <td><input type="text" class="input_date" style="width:222px;" id="date_para"   value="" readonly="readonly" /></td>
                   </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>收货商名称</td>
                       <td>
                       <input type="text" class="input_code" id="receiverName" maxlength="30"  />
                       <input type="text" id="receiverId" style="display:none">
                        <input type="text" id="id" style="display:none">
                       </td>
                   </tr>
                   <tr>
                   	   
                       <td class="td_lf"><em class="star">*</em>产品名称</td>
                       <td id="outputMatName" ></td>
                   <input type="text" id=outputMatId style="display:none">
                  </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>规格</td>
                       
                       <td id="spec"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star"></em>生产单位</td>
                       <td id="manufacture"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>数量</td>
                       <td><input type="text" class="input_code" id="quantity" maxlength="6"/></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>生产日期</td>
                       <td><input type="text" class="input_date" style="width:222px;" id="date_prod" value=""  readonly="readonly" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>批次号</td>
                       <td><input type="text" class="input_code" id="productionBatch" maxlength="20" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>追溯码</td>
                       <td><input type="text" class="input_code" id="traceCode" maxlength="50" /></td>
                   </tr>
               </table>
              
                <div class="kuang" style="right:0; left:474px;bottom:155px;" id="kuang">至少填写一项</div>
               <p class="save_box">
               
                  <input type="button" class="btn_save" value="保存" />
                  <div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
                  
               </p>
               <div class="clear"></div>
          </div>
     </div>
</div>    

<script type="text/javascript">
$(function(){
  			   
   /*--日历-发货--*/	
    $('#date_para').calendar({ minDate:calDateByDay(-32),maxDate:calDateByDay(10),onSetDate:function(){
    	$('#date_prod').val(null);
    /* 	 $('#date_para').calendar({ minDate:'#date_prod'}); */
    $('#date_prod').calendar({ maxDate:'#date_para'});} }); 
   
   /*--日历-生产--*/				   
   $('#date_prod').calendar();
   
});	
</script>	
</body>
</html>