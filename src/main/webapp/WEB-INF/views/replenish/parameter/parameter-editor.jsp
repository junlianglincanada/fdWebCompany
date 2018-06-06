<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String id=request.getParameter("id");
  //String number=request.getParameter("pageNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" /> 
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<script type="text/javascript">
var params = {};
var Params={};
var id="<%=id%>";
var pageNum=1;
var pageSize=20;
var supplierName;
var modelId;
var flag=true;
function isNumber(number){
	var patrn=/^\d{1,6}(?:\.\d{1,2}|\.?)$/;
	flg = patrn.test(number);
	if (flg) {
		return true;
	}
	return false;
}
function onlyNumber() {
	var code;
	var character;
	if (document.all) {
		code = window.event.keyCode;
	} else {
		code = arguments.callee.caller.arguments[0].which;
	}
	   character = String.fromCharCode(code);
	//var txt = new RegExp(/[`~!@#$%^&*()_+<>?:{},\/;[\]]/g);
	var txt=new RegExp(/[^\d.]/g);
	if (txt.test(character)) {
		if (document.all) {
			window.event.returnValue = false;
		} else {
			arguments.callee.caller.arguments[0].preventDefault();
		}
	}
}
function processSpelChar() {
	var code;
	var character;
	if (document.all) {
		code = window.event.keyCode;
	} else {
		code = arguments.callee.caller.arguments[0].which;
	}
	   character = String.fromCharCode(code);
	var txt = new RegExp(/[`~!#$%^&*+<>?:{},;[\]]/im);
	//var txt=new RegExp(/[^\d.]/g);
	if (txt.test(character)) {
		if (document.all) {
			window.event.returnValue = false;
		} else {
			arguments.callee.caller.arguments[0].preventDefault();
		}
	}
}
$(function(){
$("#loading").show();
$.ajax({
		url:"../inputManage/inputBatch/getInputBatchById/"+id,
		type:"get",
		data:JSON.stringify(params),
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    success:function(result){
	    	if(result.status==0){
	    		
	    	var dto=result.body;
	    	document.getElementById("name1").innerHTML = dto.supplierName;
	    	var id=dto.id;
			var inputDate=isnull(dto.inputDate);
			var inputMatName=isnull(dto.inputMatName);
			var spec=isnull(dto.spec);
			var manufacture=isnull(dto.manufacture);
			var quantity=isnull(dto.quantity);
			var productionDate=isnull(dto.productionDate);
			var productionBatch=isnull(dto.productionBatch);
			var supplierId=isnull(dto.supplierId);
			var inputMatId=isnull(dto.inputMatId);
			var traceCode=isnull(dto.traceCode);
			modelId=supplierId;
			//var inputMatId=isnull(dto.inputMatId);
			 supplierName=dto.supplierName;
	    	$("#date_into").val(inputDate);
	    	$("#supplierName").val(supplierName);
	    	$("#inputMatName").text(inputMatName);
	    	$("#spec").text(spec);
	    	$("#manufacture").text(manufacture);
	    	$("#quantity").val(quantity);
	    	$("#date_prod").val(productionDate);
	    	$("#productionBatch").val(productionBatch);
	    	$("#supplierId").val(supplierId);
	    	$("#inputMatId").text(inputMatId);
	    	$("#traceCode").val(traceCode);
	    	$("#loading").hide();
	    	}
	    },
	    error:function(){
	    	alert("系统异常，查询失败！");
	    }
	});
$("#supplierName").on("keyup", function(){
	 var keyWords = $("#supplierName").val().trim(); 
	 var Params={'name':keyWords};
	 $.ajax({
 	 		type:"post",
 	 	    headers: { 
 	 	        'Accept': 'application/json',
 	 	        'Content-Type': 'application/json' 
 	 	    },
 	 	    dataType:'json',
  			data:JSON.stringify(Params),
  			url: "../inputManage/supplier/querySuppliersByName/"+pageNum+"/"+pageSize,
  			success: function(data) {
  				
  				$('#supplierName').bind("input.autocomplete", function () {
      							 $(this).trigger('keydown.autocomplete');
  					 });
  				$("#supplierName").autocomplete(data.body.resultList,{
  					minChars: 0,
  					width: 253,
  					max:12,
  					scrollHeight:400,
  					matchContains: true,
  					autoFill: false,
  					scroll: false,
  					/* delay:400, */
  					dataType: 'json',
  					
  					formatItem: function(row, i, max) {
  						return  row.name ;
  					},
  					formatMatch: function(row, i, max) {
  						return row.name ;
  					},
  					formatResult: function(row) {
  						return row.name;
  					}
  				}).result(function(event,data,formatted){
  					
  					var supplierId=data.id;
 					if(supplierId!=null&&supplierId!=""){
 						$("#supplierId").val(supplierId);
 						modelId=supplierId;
 						supplierName=$("#supplierName").val().trim();
  					//supplierId=data.id;
  					//$("#supplierId").val(supplierId);
  		           // alert(data);
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

		$(".btn_save").click(function(){
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
			$(".info_mation").find(".text_ts").remove();
			var inputDate=$("#date_into").val();
			var quantity=$("#quantity").val().trim();
			
			var productionDate=$("#date_prod").val().trim();
			var productionBatch=$("#productionBatch").val().trim();
			//alert(productionBatch);
			var supplierId =$("#supplierId").val().trim();
			var inputMatId=$("#inputMatId").text().trim();
			var traceCode=$("#traceCode").val().trim();
			if(inputDate==null||inputDate==""){
				$("#date_into").after('<span class="text_ts" style="margin-left:50px;">请选择进货日期 </span>');
				//alert("请选择进货日期");
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
			if(supplierId==null||supplierId==""||supplierId=="null"){
				alert("供应商不存在");
				return;
			}
			if(inputMatId==null||inputMatId==""||inputMatId=="null"){
				alert("该产品不存在");
				return;
			}
			var inputDate=new Date(inputDate.replace("-", "/").replace("-", "/")); 
	        var productionDate=new Date(productionDate.replace("-", "/").replace("-", "/"));
			if(inputDate<productionDate){
				$("#date_prod").after('<span class="text_ts" style="margin-left:45px;">进货日期必须大于生产日期 </span>');
				//alert("进货日期必须大于生产日期");
				$("#loading").hide();
				return;
			}
			//params.supplierId=supplierId;
		    params.id=id;
			params.inputDate=inputDate;
			params.supplierId=supplierId;
			params.inputMatId=inputMatId;
			params.traceCode=traceCode;
			params.delFlag=1;
			
			if((productionDate==null||productionDate=="")&&(productionBatch==null||productionBatch=="")){
				
				$("#productionBatch").after('<span class="text_ts " style="margin-left:50px;">生产日期和批次号必须选择一个 </span>');
				//alert("生产日期和批次号必须选择一个");
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
		    if(flag==false){
				return ;
			}
			$("#loading").show();
			$.ajax({
				url:"../inputManage/inputBatch/updateInputBatch",
				type:"post",
				data:JSON.stringify(params),
				dataType:"json",
				headers: { 
			        'Accept': 'application/json',
			        'Content-Type': 'application/json' 
			    },
			    success:function(result){
			    	//alert("保存成功！");
			    	window.location.href="replenish.parameter.parameter";
			    	$("#loading").hide();
			    },
			    error:function(){
			    	alert("系统异常，保存失败！");
			    }
			});
		});
		//输入框失去焦点时候supplierId值的变化
		//$("#supplierName").click(function(){
			//$(this).val("");
			//$("supplierId").val("");
		//});
		$("#supplierName").blur(function(){
		if($(this).val().trim()!=supplierName&&$("#supplierId").val().trim()==modelId){
				//alert(supplierName);
				//alert(modelId);
				$("#supplierId").val("");
				$("#supplierName").val(supplierName);
		}
		if($(this).val().trim()==supplierName&&$("#supplierId").val().trim()!=modelId){
			//alert(modelId);
			$("#supplierId").val(modelId);
		}
		});
	    /*--日历-进货--*/				   
		   $('#date_into').calendar({ minDate:calDateByDay(-32), maxDate:calDateByDay(10)});
		   /*--日历-生产--*/				   
		   $('#date_prod').calendar();
		   /*--输入搜索关键词控制--*/				   
		   var availableTags = [
								 "上海华美饮料有限公司", 
								 "上海力华营销有限公司",
								 "上海耀剑农产品有限公司",
								 "上海新华农业信用合作社"
								 ];

		   $("#supplier_name").autocomplete({
		       source: availableTags
		   });
			
	
});

</script>
</head>
<body>
<div class="main_box">
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.parameter.parameter">近期进货维护</a> > <a href="#">编辑近期进货</a> > <a id="name1"></a> </h3>
          <div class="info_box">
                <table class="info_mation" style="width:747px;">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>进货日期</td>
                       <td><input type="text" class="input_date" style="width:222px;" id="date_into" value="" readonly="readonly" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>供应商名称</td>
                       <td>
                       <input type="text" class="input_code" id="supplierName" value="" maxlength="100" />
                       <input type="text" id="supplierId" style="display:none" >
                       </td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>产品名称</td>
                       <td id="inputMatName" ></td>
                       <td id="inputMatId"  style="display:none"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>规格</td>
                       <td id="spec"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>生产单位</td>
                       <td id="manufacture"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star" >*</em>数量</td>
                       <td><input type="text" class="input_code" id="quantity" value="" maxlength="8"  /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>生产日期</td>
                       <td><input type="text" class="input_date" style="width:222px;" id="date_prod" value="" readonly="readonly" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>批次号</td>
                       <td><input type="text" class="input_code" id="productionBatch" value="" maxlength="20" /></td>
                   </tr>
                    <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>追溯码</td>
                       <td><input type="text" class="input_code" id="traceCode" maxlength="50" /></td>
                   </tr>
               </table>
              <div class="kuang" style="right:0; left:474px;bottom:149px; width: 89px" >至少填写一项</div>
                 
               <p class="save_box">
                  <input type="button" class="btn_save" value="保存" />
               </p>
               <div class="clear"></div>
          </div>
     </div>
</div>    	
</body>
</html>