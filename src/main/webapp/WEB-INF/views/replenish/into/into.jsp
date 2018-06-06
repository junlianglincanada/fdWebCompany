<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%    
    String id=request.getParameter("id");
    String pageNum=request.getParameter("pageNum");
    String productionDate=request.getParameter("productionDate");
%>        
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>

 <script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
 <link rel="Stylesheet" href="../js/jquery.autocomplete.css" /> 
<script type="text/javascript">
/* $(document).ready(function () {
	var Params={"type":'SUPPLIER'};
	$("#supplierName").focus(function(){
//	$("#supplierName").on("click keyup", function(){
	$.ajax({
	  	 type:"post",
	  	  headers: { 
	  	 	        'Accept': 'application/json',
	  	 	        'Content-Type': 'application/json' 
	  	 	    },
	  	 	    dataType:'json',
	   			data:JSON.stringify(Params),
	   			url: "../inputManage/supplier/intCompanyByTime/"+pageNum+"/"+pageSize,
	   			success: function(data) {
	   				$('#supplierName').bind("input.autocomplete", function () {
							 $(this).trigger('keydown.autocomplete');
				 });
			$("#supplierName").autocomplete(data.body,{
				minChars:0,
				width:301,
				max:10,
				
				cacheLength:1000,
				matchSubset:true,
				
				
				matchContains:true,
				autoFill:false,
				scroll:false,
				dataType:'json',
				
				formatItem: function(row, i, max) {
					return   row[1];
				},
				formatMatch: function(row, i, max) {
					return row[1] ;
				},
				formatResult: function(row) {
					return row[1];
				}
			}).result(function(event,data,formatted){
				
				var supplierId=data[0];
				if(supplierId!=null&&supplierId!=""){
					$("#supplierId").val(supplierId);
					modelId=supplierId;
					supplierName=$("#supplierName").val().trim();
				}
	        });
		     
			 initAutoComplete(json);	 	   	
	   			},
	   			error: function(data) {
	   				console.log("加载失败，请重试！");
	   				}
	   			});
}); 
	
}); */
//判断数据库的是否为空
function isnull(object){
	if(object==null||object=="null"||object==""){
		return "";
	}else{
		return object;
	}
}
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
var productionDate=isnull(<%=productionDate%>);
var modelId;
var exampleId;
var params5 = {};
var inputMatName;
var pageNum=1;
var totalPage;
var totalNum;
var pageSize=20;
var toUrl="";
var params = {};
var inputDate;
var materialName;
var supplierName;
var datas=[];
var params2= {};
var params3= {};
//带入的三个值： 规格  ； 生产单位名称； 保质期 
var spec;
var manufacture;
var productionDate;
var mc;
//关联的几个ID
var inputMatId;
var supplierId;
var oldguanlianID=0;
var newguanlianID=0;
var matLength=0;
var supLength=0;
$(function(){
	//下拉框
	   	   		
	//清空<tbody>里面的内容，
	//清空add-output中的输入框中的值，保留默认日期为当前日期
	//显示当前日期下的发货信息并显示，刷新表格		
	search(1);	 
	var keyWords = null; 
	var Params={'name':keyWords};
	$.ajax({
		url: "../inputManage/supplier/querySuppliersByName/-1/-1",
		type:"post",
		headers: { 
	        	'Accept': 'application/json',
	        	'Content-Type': 'application/json' 
	    	},
	    dataType:'json',
	    data:JSON.stringify(Params),
	    success: function(data) {
				$("#supplierName").autocomplete(data.body.resultList,{
					minChars: 0,
					width:301,
					max:10,
					delay:0,
					cacheLength:1000,
					matchSubset:true,
					matchContains:true,
					autoFill:false,
					scroll:false,
					dataType:'json',
					
					formatItem: function(row, i, max) {
						return   row.name;
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
			},
			error: function(data) {
				console.log("加载失败，请重试！");
			}
		});


	/* $("#supplierName").on("keyup", function(){
		var keyWords = $("#supplierName").val().trim(); 
		var Params={'name':keyWords};
		if(supLength!=keyWords.length){
			supLength=keyWords.length;
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
	   					minChars:1,
	   					width:301,
	   					max:10,
	   					delay:0,
	   					cacheLength:1000,
	   					matchSubset:true,
	   					matchContains:true,
	   					autoFill:false,
	   					scroll:false,
	   					dataType:'json',
	   					
	   					formatItem: function(row, i, max) {
	   						return   row.name;
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
   				},
	   			error: function(data) {
	   				console.log("加载失败，请重试！");
	   			}
   			});
		}
	});
	$("#inputMatName").focus(function(){
		var keyWords = $("#inputMatName").val();
		var params={'name':keyWords};
		$.ajax({
			//url: "../inputManage/inputMaterial/queryInputMaterialsByName/"+pageNum+"/"+pageSize,
	 	 	type:"post",
	 	 	headers: { 
	 	 		'Accept': 'application/json',
	 	 		'Content-Type': 'application/json' 
	 	 	},
	 	 	dataType:'json',
	  		data:JSON.stringify(params),
			success: function(data) {
				$('#inputMatName').bind("input.autocomplete", function () {
              		$(this).trigger('keydown.autocomplete');
         		});
   				$("#inputMatName").autocomplete(data.body.resultList,{
   					minChars: 0,
   					width: 301,
   					max:12,
   					matchContains: true,
   					autoFill: false,
   					scroll: false,
   					dataType: 'json',			   			   					
   					formatItem: function(row, i, max) {
   					mc=row.value.split(";")[0];
  						return  mc; 
   					},
   					formatMatch: function(row, i, max) {
   						return row.value ;
   					},
   					formatResult: function(row) {
   						return row.value;
   					}
   					}).result(function(event,data,formatted){
   						var inputMatId=data.id;
						if(inputMatId!=null&&inputMatId!=""){
							$("#inputMatId").val(inputMatId);
							exampleId=inputMatId;
							inputMatName=$("#inputMatName").val().trim();
							guanlian(data.id);
						}
	   		            var cp= $("#inputMatName").val();
	   		      		var mc = cp.split(";")[0];
	   		            
	   		            $("#inputMatName").val(mc);
	   		        });		  				
   				},
			error: function(data) {
				console.log("加载失败，请重试！");
			}
   		});
	}); */
	
	var keyWords = null; 
	var Params={'name':keyWords};
	$.ajax({
		url: "../inputManage/inputMaterial/queryInputMaterialsByName/-1/-1",
		type:"post",
		headers: { 
	        	'Accept': 'application/json',
	        	'Content-Type': 'application/json' 
	    	},
	    dataType:'json',
	    data:JSON.stringify(Params),
	    success: function(data) {
				$("#inputMatName").autocomplete(data.body.resultList,{
					minChars: 0,
					width: 301,
					max:12,
					matchContains: true,
					autoFill: false,
					scroll: false,
					dataType: 'json',			   			   					
					formatItem: function(row, i, max) {
					mc=row.value.split(";")[0];
						return  mc; 
					},
					formatMatch: function(row, i, max) {
						return row.value ;
					},
					formatResult: function(row) {
						return row.value;
					}
					}).result(function(event,data,formatted){
						
						
					var inputMatId=data.id;
				if(inputMatId!=null&&inputMatId!=""){
					$("#inputMatId").val(inputMatId);
					exampleId=inputMatId;
					var inputMatName1=$("#inputMatName").val().trim();
					inputMatName=inputMatName1.split(";")[0];
					guanlian(data.id);
					//supplierId=data.id;
					//$("#supplierId").val(supplierId);
		           // alert(data);
				}
		            var cp= $("#inputMatName").val();
		      		var mc = cp.split(";")[0];
		            
		      		//var spec = cp.split(";")[1];
		            $("#inputMatName").val(mc);
		        });		  				
			},
			error: function(data) {
				console.log("加载失败，请重试！");
			}
		});
	/* $("#inputMatName").on("keyup", function(){
		var keyWords = $("#inputMatName").val().trim();
		var params={'name':keyWords};
		if(matLength!=keyWords.length){
			matLength = keyWords.length;
			$.ajax({
				url: "../inputManage/inputMaterial/queryInputMaterialsByName/"+pageNum+"/"+pageSize,
				type:"post",
				headers: { 
					'Accept': 'application/json',
					'Content-Type': 'application/json' 
				},
				dataType:'json',
				data:JSON.stringify(params),
				success: function(data) {
					$('#inputMatName').bind("input.autocomplete", function () {
              			$(this).trigger('keydown.autocomplete');
         			});
   					$("#inputMatName").autocomplete(data.body.resultList,{
	   					minChars: 1,
	   					width: 301,
	   					max:12,
	   					matchContains: true,
	   					autoFill: false,
	   					scroll: false,
	   					dataType: 'json',			   			   					
	   					formatItem: function(row, i, max) {
	   					mc=row.value.split(";")[0];
	   						return  mc; 
	   					},
	   					formatMatch: function(row, i, max) {
	   						return row.value ;
	   					},
	   					formatResult: function(row) {
	   						return row.value;
	   					}
	   					}).result(function(event,data,formatted){
	   						
	   						
	   					var inputMatId=data.id;
						if(inputMatId!=null&&inputMatId!=""){
							$("#inputMatId").val(inputMatId);
							exampleId=inputMatId;
							inputMatName=$("#inputMatName").val().trim();
							guanlian(data.id);
	 					//supplierId=data.id;
	 					//$("#supplierId").val(supplierId);
	 		           // alert(data);
						}
	   		            var cp= $("#inputMatName").val();
	   		      		var mc = cp.split(";")[0];
	   		            
	   		      		//var spec = cp.split(";")[1];
	   		            $("#inputMatName").val(mc);
	   		        });		  				
   				},
   				error: function(data) {
   					console.log("加载失败，请重试！");
   				}
   			});
		}
		 
	}); 
 */
	function guanlian(str){
		var id=str;
		newguanlianID=id;
		if(id != -1 && oldguanlianID != newguanlianID){	
			oldguanlianID=newguanlianID;
			$.ajax({
				type:"get",
				url: "../inputManage/inputMaterial/getInputMaterialById/"+id,
				success: function(data){
					console.log(data);
					//inputMatName=data.body.inputMatName;
					bzq=data.body.guaranteeValue;
					spec=data.body.spec;
					manufacture=data.body.manufacture;
					document.getElementById("spec").value=spec;
					document.getElementById("manufacture").value =manufacture;		  			
				},
				error: function(data) {
					console.log("加载失败，请重试！");
				}
			});		  	
		}
	};
	   /*--日历-进货--*/			
	$('#date_into').calendar( { maxDate:'%y-%M-%d'});
	$('#date_into').calendar({
		onSetDate:function(){
			$('#date_into').val(null);
			$('#date_into').calendar( { maxDate:'#date_into'})
		} 
	}); 	   

	if(productionDate!=""){	    
		$("#date_prod").val(productionDate);
	}
});


//查询
function search(pageNum){
	$("#loading").show();
	$.ajax({
	url: "../inputManage/inputBatch/queryInputBatchs/"+pageNum+"/"+pageSize,
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params5),
	success:function(result) {
		$("#loading").hide();
		if(result.status==0){
			var resultList=result.body.resultList;
			$("#body").children().remove();
			//console.log(resultList);
			for(var i=0;i<resultList.length;i++){
				var id=resultList[i].id;
				var inputDate=isNullForTable(resultList[i].inputDate);
				var inputMatName=isNullForTable(resultList[i].inputMatName);
				var spec=isNullForTable(resultList[i].spec);
				var traceCode=isNullForTable(resultList[i].traceCode);
				var manufacture=isNullForTable(resultList[i].manufacture);
				var quantity=isNullForTable(resultList[i].quantity);
				var supplierId=resultList[i].supplierId;
				//alert(supplierId);
				var productionDate=isNullForTable(resultList[i].productionDate);
				//var productionDate=isnull(resultList[i].productionDate);
				var productionBatch=isNullForTable(resultList[i].productionBatch);
				var guarantee=isNullForTable(resultList[i].guaranteeValue)+""+isNullForTable(resultList[i].guaranteeUnitString);
				var supplierName=resultList[i].supplierName;
      			var $tr=$("<tr><td class='td_ser'>"+((pageNum-1)*pageSize+i+1)+"</td><td>"+inputDate+"</td><td>"+inputMatName+"</td><td>"+spec+"</td><td>"+manufacture+"</td><td>"+quantity+"</td><td>"+productionDate+"</td><td>"+productionBatch+"</td><td>"+guarantee+"</td>"+"<td>"+traceCode+"</td>"
      					+"<td class='editor_into'>"+supplierName+"</td><td class='td_oper'> <a href='javascript:void(0)' class='btn_green btn_green1'>编辑</a><a href='javascript:void(0)' class='btn_green' rel='popup' link='replenish.into.iframe-del?id="+id+"' title='提示'>删除</a></td></tr>");
				$tr.data("id",id);
				if(i%2==0){
					$tr.addClass("even");
				}

				$("#body").append($tr);
				
			}
		}
	 },   
	 error:function(text) {
		 $("#loading").hide();
// 		 alert("系统异常，查询失败！");
	 }
	});
}
$(function(){			
	//输入框安全限制
	function checkSpecificKey(keyCode) {
		var patrn=/[`~!@#$%^&*_+<>?:{},.\/;[\]]/im;
		var flg = false;
		flg = patrn.test(keyCode);
		if (flg) {
			return false;
		}
		return true;
	}
	
	
	//添加
	$("#save").click(function(){
		//$("#save").attr("disabled",true);
		$("#loading").show();
		var inputMatId=$("#inputMatId").val().trim();
        var supplierId=$("#supplierId").val().trim();       
		var inputDate=$("#date_into").val().trim();		
		var supplierName=$("#supplierName").val().trim();
		var inputMatName=$("#inputMatName").val().trim();
		var manufacture=$("#manufacture").val().trim();		
		var productionDate=$("#date_prod").val().trim();
		var traceCode=$("#traceCode").val().trim();
		var spec=$("#spec").val().trim();
		var quantity=$("#quantity").val().trim();
		if(quantity==""||quantity==null){
			alert("产品数量不能为空");
			$("#loading").hide();
			return;
		}
		if(isNumber(quantity)==false||1*quantity<=0){
			alert("请输入正确的数量<最大六位数值，小数最多两位>");
			$("#loading").hide();
			return;
		}
		params.quantity=quantity;
		var productionBatch=$("#productionBatch").val().trim();
		params.inputMatId=inputMatId;
		params.supplierId=supplierId;
		params.inputDate=inputDate;
		
		params.traceCode=traceCode;
		params.manufacture=manufacture;
		//params.productionDate=productionDate;
		params.spec=spec;
		params.quantity=quantity;
		// params.productionBatch=productionBatch;
		//判断输入框是否含有特殊字符
		if(checkSpecificKey(supplierName)==false||checkSpecificKey(traceCode)==false){
			alert("请勿输入特殊字符");
			$("#loading").hide();
			return;
		}else{
				
		}
		//非空输入框非空验证
		if(supplierId==""||supplierId==null){
			alert("请选择供应商！");
			$("#loading").hide();
			return;
		}else{
			//params.supplierName=supplierName;
		}
		if(inputMatId==""||inputMatId==null){
			alert("请选择采购品！");
			$("#loading").hide();
			return;
		}else{
			//params.inputMatId=inputMatId;
		}

	if(inputDate==""||inputDate==null){
		alert("进货日期不能为空");
		$("#loading").hide();
		return;
	}else{
		params.inputDate=inputDate;
	}
		if((productionDate==null||productionDate=="")&&(productionBatch==null||productionBatch=="")){
			alert("生产日期和生产批号必须选择一个");
			$("#loading").hide();
			return;
		}else{
			if(productionDate!=null&&productionDate!=""){	
				params.productionDate=productionDate;
			}
			if(productionBatch!=null&&productionBatch!=""){
				params.productionBatch=productionBatch;
			}
		}	
		
	    var inputDate=new Date(inputDate.replace("-", "/").replace("-", "/")); 
        var productionDate=new Date(productionDate.replace("-", "/").replace("-", "/"));
		if(inputDate<productionDate){
			alert("进货日期必须大于生产日期");
			$("#loading").hide();
			return;
		}
			console.log(params);
			 datas.push(params);
			 console.log(datas);
			 $("#save").attr("disabled",true);
			$.ajax({
				url:"../inputManage/inputBatch/createInputBatch",
				type:"post",
				data:JSON.stringify(datas),
				dataType:"json",
				headers: { 
			        'Accept': 'application/json',
			        'Content-Type': 'application/json' 
			    },
			    success:function(result){
			    	$("#loading").hide();
			    	$("#save").attr("disabled",false);
			    	datas=[];
			    	//清空
			      $("#spec").val("");
			      $("#quantity").val("");
			      //$("#supplierName").val("");
			     // $("#supplierId").val("");
			      $("#inputMatName").val("");
			      $("#inputMatId").val("");
			      $("#manufacture").val("");
			    	//alert("保存成功！");

			    	oldguanlianID=0;
			    	search(pageNum);
			    	
			    	//window.location.href="../findView/replenish.into.into?productionDate="+productionDate;
			    	
			    },
			    error:function(){
			    	
			    	oldguanlianID=0;
			    	$("#loading").hide();
			    	alert("系统异常，保存失败！");
			    }
			})
			
							
		});
		
	
	
	//绑定id
	$("body").on("click",".btn_green1",function(){
		var id=$(this).parent().parent().data("id");	
		params3.id=id;
		$.ajax({
				url:"../inputManage/inputBatch/getInputBatchById/"+id,
				type:"get",
				data:JSON.stringify(params3),
				dataType:"json",
				headers: { 
			        'Accept': 'application/json',
			        'Content-Type': 'application/json' 
			    },
			    success:function(result){
			    	$("#save").hide();
			    	$("#cancel").show();
		            $("#update_product").show();
			    	var dto=result.body;
			    	var id=dto.id;
					var inputDate=isnull(dto.inputDate);
					//var inputMatName=isnull(dto.inputMatName);
					var spec=isnull(dto.spec);
					var manufacture=isnull(dto.manufacture);
					var quantity=isnull(dto.quantity);
					var productionDate=isnull(dto.productionDate);
					var productionBatch=isnull(dto.productionBatch);
					var supplierId=isnull(dto.supplierId);
					var inputMatId=isnull(dto.inputMatId);
					//var supplierName=dto.supplierName;
					var traceCode=isnull(dto.traceCode);
					modelId=supplierId;
					 supplierName=dto.supplierName;
					 
					 inputMatName=isnull(dto.inputMatName);
					 exampleId=inputMatId;
					 
					$("#productId").text(id);
			    	$("#date_into").val(inputDate);
			    	$("#supplierName").val(supplierName);
			    	$("#inputMatName").val(inputMatName);
			    	$("#spec").val(spec);
			    	$("#manufacture").val(manufacture);
			    	$("#quantity").val(quantity);
			    	$("#date_prod").val(productionDate);
			    	$("#productionBatch").val(productionBatch);
			    	$("#supplierId").val(supplierId);
			        $("#traceCode").val(traceCode);
			        
			        $("#inputMatId").val(inputMatId);
			    	
			    },
			    error:function(){
			    	alert("系统异常，查询失败！");
			    }
			});
	});
	

	$(function(){
		$("#update_product").click(function(){
			//$("#loading").show();
			var id=$("#productId").text();
			var inputDate=$("#date_into").val();
			var quantity=$("#quantity").val().trim();
			if(quantity==""||quantity==null){
				alert("产品数量不能为空");
				$("#loading").hide();
				return;
			}
			if(isNumber(quantity)==false||1*quantity<=0){
				alert("请输入正确的数量<最大六位数值，小数最多两位>");
				$("#loading").hide();
				return;
			}
			params2.quantity=quantity;
			
			var inputMatId=$("#inputMatId").val().trim();
			
			var supplierName=$("#supplierName").val().trim();
			var inputMatName=$("#inputMatName").val().trim();
			
			var productionDate=$("#date_prod").val().trim();
			var productionBatch=$("#productionBatch").val().trim();
			var supplierId =$("#supplierId").val().trim();
			var traceCode=$("#traceCode").val().trim();
			params2.supplierId=supplierId;
		    params2.inputDate=inputDate;
		    params2.traceCode=traceCode;
		    params2.id=id;
			params2.delFlag=1;
			
			params2.inputMatId=inputMatId;
			
			//判断输入框是否含有特殊字符
			if(checkSpecificKey(supplierName)==false||checkSpecificKey(traceCode)==false){
				alert("请勿输入特殊字符");
				$("#loading").hide();
				return;
			}else{
				
			}	
			

		if(inputDate==""||inputDate==null){
			alert("进货日期不能为空");
			$("#loading").hide();
			return;
		}else{
			params2.inputDate=inputDate;
		}
			if((productionDate==null||productionDate=="")&&(productionBatch==null||productionBatch=="")){
				alert("生产日期和生产批号必须选择一个");
				$("#loading").hide();
				return;
			}else{
				if(productionDate!=null&&productionDate!=""){
					params2.productionDate=productionDate;
				}
				if(productionBatch!=null&&productionBatch!=""){
					params2.productionBatch=productionBatch;
				}
			} 
			if(supplierName==""||supplierName==null){
				alert("请选择供应商！");
				$("#loading").hide();
				return;
			}else{
				params.supplierName=supplierName;
			}
			if(inputMatName==""||inputMatName==null){
				alert("请选择采购品！");
				$("#loading").hide();
				return;
			}else{
				params.inputMatName=inputMatName;
			}
			if(inputDate<productionDate){
				alert("进货日期必须大于生产日期");
				$("#loading").hide();
				return;
			}
			console.log(params2);
			$.ajax({
				url:"../inputManage/inputBatch/updateInputBatch",
				type:"post",
				data:JSON.stringify(params2),
				dataType:"json",
				headers: { 
			        'Accept': 'application/json',
			        'Content-Type': 'application/json' 
			    },
			    success:function(result){
				    	//alert("修改成功！");
				    	$("#loading").hide();
				    	window.location.href="replenish.into.into";
	
			    },
			    error:function(){
			    	$("#loading").hide();
			    	alert("系统异常，保存失败！");
			    }
			});
		});
		
	});
$("#cancel").click(function(){
	$("#supplierId").text("");
	$("#supplierName").val("");
	$("#productId").text("");
	$("#inputMatName").val("");
	$("#spec").val("");
	$("#manufacture").val("");
	$("#quantity").val("");
	$("#date_prod").val("");
	$("#productionBatch").val("");
	//$("#supplierId").val("");
    $("#traceCode").val("");
    
   // $("#inputMatId").val("");
    
    $("#save").show();
    $("#update_product").hide();
    $("#cancel").hide();
    
    
});	

$("#supplierName").blur(function(){
	if($(this).val().trim()!=supplierName&&$("#supplierId").val().trim()==modelId){
			//alert(supplierName);
			//alert(modelId);
			$("#supplierId").val("");
			//alert("请选择正确的供应商！");
			$("#supplierName").val(supplierName);
	}
	if($(this).val().trim()==supplierName&&$("#supplierId").val().trim()!=modelId){
		//alert(modelId);
		$("#supplierId").val(modelId);
	}
	});
	
$("#inputMatName").blur(function(){
	if($(this).val().trim()!=inputMatName&&$("#inputMatId").val().trim()==exampleId){
			//alert(supplierName);
			//alert(modelId);
			$("#inputMatId").val("");
			//alert("请选择正确的产品");
			$("#inputMatName").val(inputMatName);
	}
	if($(this).val().trim()==inputMatName&&$("#inputMatId").val().trim()!=exampleId){
		//alert(modelId);
		$("#inputMatId").val(exampleId);
	}
	});	
	
});
</script>
<!--  //onload="document.getElementById('supplierName').focus()" -->
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.into.into">新增进货</a> </h3>
          <div class="info_tab">
               <a href="../findView/replenish.into.into" class="default">新增进货</a>
               <a href="../findView/replenish.into.into-commonly">常用进货</a>
          </div>
          <div class="query">
          
               <table class="query_table" style="width:900px;">
                 
                  <tr>
                      <td class="td_lf"><em class="star">*</em>进货日期</td>
                      <td><input type="text" class="input_date" id="date_into" value="" readonly="readonly" /></td>
                       <script type="text/javascript">
 						var mydateInput = document.getElementById("date_into");
						var date = new Date();
						var dateString = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
						mydateInput.value=dateString;
 					</script>
                      <td class="td_lf"><em class="star">*</em>供应商名称<span style='display:none;' id="productId"></span></td>
                      <td colspan="3"><input type="text" class="input_code" placeholder="请输入关键字选择供应商"  autocomplete="" id="supplierName" style="width:200px;"/>
                      <input type="text" id="supplierId" style="display:none">
                      <!-- <input type="button" class="btn_send" id="receiverButton" value="常用供应商列表" rel="popup" link="replenish.into.selectReceiver"  style="width:200px;margin-left:90px;" title="选择供应商" /> -->
                      </td>
                  </tr>
                  <tr>
                      <td class="td_lf"><em class="star">*</em>产品名称</td>
                      <td>
                      <input type="text" class="input_code" id="inputMatName" style="width:168px;" placeholder="请输入关键字选择产品"    />
                       <input type="text" id="inputMatId" style="display:none" />
                      </td>
                      <td class="td_lf"><em class="star"></em>生产单位</td>
                      <td><input type="text" class="input_code" value="" autocomplete="" id="manufacture" style="background:#e2e2e2;width:200px;" readOnly="true"/></td>
                      <td class="td_lf"><em class="star">&nbsp;</em>生产日期</td>
                      <td><input type="text" class="input_date" id="date_prod" value="" readonly="readonly" /></td>
                  </tr>
                  <tr>
                      <td class="td_lf"><em class="star">*</em>规格</td>
                      <td><input type="text" class="input_code" id="spec" style="width:168px; background:#dcdddd;" value="" readOnly="true"/></td>
                      <td class="td_lf"><em class="star">*</em>数量</td>
                      <td><input type="text" class="input_code" id="quantity" value="" style="width:200px;" maxlength="8"/></td>
                      <td class="td_lf"><em class="star">&nbsp;</em>生产批号</td>
                      <td><input type="text" class="input_code" id="productionBatch" style="width:168px;" value="" maxlength="20" /></td>   
                  </tr>
                  <tr>
                     <td class="td_lf"><em class="star"></em>追溯码</td>
                     <td colspan="5"><input type="text" class="input_code" maxlength="50" id="traceCode" value="" style="width:168px;"/></td>
                  </tr>
               </table>
               <div class="kuang" style="right:0; left:900px;bottom:130px; ">至少填写一项</div>
                
               <p class="query_btn"><input type="button" class="btn_query" value="保存" id="save"/>
               <input type="button" class="btn_query" value="修改" style="display:none;" id="update_product"/>
               <input type="button" class="btn_cancel" id="cancel"  value="取消" style="display:none;" />
               </p>
          </div>
          <div class="table_box">
               <table class="table_list">

                    <thead>
                       <tr>
                           <th>序号</th>                                         
                           <th style="min-width:65px">进货日期</th>
                           <th style="min-width:70px">产品名称</th>
                           <th style="min-width:45px">规格</th>
                           <th style="min-width:90px">生产单位</th>
                           <th style="min-width:35px">数量</th>
                           <th style="min-width:65px">生产日期</th>
                           <th style="min-width:60px">批次号</th>
                           <th style="min-width:50px">保质期</th>
                           <th style="min-width:50px">追溯码</th>
                           <th style="min-width:90px">供应商名称</th>
                          
                           <th>操作</th>
                       </tr>
                    </thead>
                    <tbody id="body">
                       <tr>
                           <td class="td_ser">1</td>                          
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                           <td></td>
                             
                            <td class="td_oper">
                           <a href="javascript:void(0)" class="btn_green">编辑</a> 
                           <a href="javascript:void(0)" class="btn_green" rel="popup" link="../frame/iframe-del.html" title="提示">删除</a>
                           </td>
                       </tr>
                      
                    </tbody>
                 </table>
                 <!--
                 <p class="paging_box">
                    <span class="paging_perv"><input type="button" value="<< 上一页" class="disabled" id="pre_page">></span>
                   <a href="#" class="default" id="page1">1</a>
                   <span class="paging_next"><input type="button" value="下一页 >>"  id="next_page"/></span>
                 </p>
                   -->
                 <div class="clear"></div>
          </div>
     </div>
</div>    
 
	
<script type="text/javascript">
$(function(){
   /*--日历-进货--*/				   
   $('#date_into').calendar({minDate:calDateByDay(-32),maxDate:calDateByDay(10)});
   
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
	
	$("#product_name").autocomplete({
        source: availableTags
    });
   
/*-------jquery end-------*/
});	
</script>
	
</body>
</html>