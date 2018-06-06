<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>   
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<title>新增发货</title>
<%@ include file="../../include.jsp" %>
<style type="text/css">
table.table_list tbody tr.even{ background:#efefef;}
.i_del{ background:url(../images/i_camera.png) no-repeat;}
table.query_table tr.select_send td{ height:auto; border:1px dotted #efefef; padding-top:5px;}
</style>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>

<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" /> 
<script type="text/javascript">
function isNumber(number){
	var patrn=/^\d{1,6}(?:\.\d{1,2}|\.?)$/;
	flg = patrn.test(number);
	if (flg) {
		return true;
	}
	return false;
}

var pageNum=1;
var totalPage;
var totalNum;
var pageSize=20;
var toUrl="";
var params = {};
var Out = {};
var modifyParams = {};
var outputDate;
var receiverName;
var outputMatName;
var temptimeout=null;
var queryReceiver;
var queryProduct;
//带入的三个值： 规格  ； 生产单位名称； 保质期 
var productName;
var selectName;
var mc;
//关联的几个ID
var productID=-1;
var receiverID;
var doFlag=1;
var oldguanlianID=0;
var newguanlianID=0;
var matLength=0;
$(function(){
	function isNumber(number){
		var patrn=/^\d{1,6}(?:\.\d{1,2}|\.?)$/;
		flg = patrn.test(number);
		if (flg) {
			return true;
		}
		return false;
	}
	
	$("body").on("blur","input[type='text']",function(){
 		//$(this).next(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	//$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    	alert("请勿入特殊字符");
	    	$(this).val("");
	    }
	}); 
	
<%-- <%-- 	oldUrl="../outputManage/outputMaterial/queryOutputMaterialsByName/1/10"+"?time=new Date()"; --%>

		
	
$("#output_product").focus(function(){

	 //pageSize=60;
	 //$("#output_product").autocomplete().unbind();
	 var theWords = $("#output_product").val().trim();
	 var pparams={'name':theWords};
	 /* $("#loading").show(); */
	 if(doFlag != 0 ){
		 
		 doFlag=0;
	 $.ajax({
  	 		type:"post",
  	 	    headers: { 
  	 	        'Accept': 'application/json',
  	 	        'Content-Type': 'application/json', 
  	 	    }, 
  	 	    dataType:'json',
   			data:JSON.stringify(pparams),
   			url: "../outputManage/outputMaterial/queryOutputMaterialsByName/"+pageNum+"/"+pageSize,
   			success: function(data) {

							 $("#output_product").bind("keydown.autocomplete");
   							 $('#output_product').bind("input.autocomplete", function () {	  
   	                				$(this).trigger('keydown.autocomplete');
   	           				 }); 
   			   				$("#output_product").autocomplete(data.body.resultList,{
   			   					minChars: 0,
   			   					width: 301,
   			   					max:12,
   			   					matchContains: true,
   			   					autoFill: false,
   			   					scroll: false,
   			   				 	//delay: 1000,
   			   					//matchSubset: false,
   			   					//selectFirst: true,
   			   					dataType: 'json',			   			   					
   			   					formatItem: function(row, i, max) {
   			   						 mc=row.value.split(";")[0];
   			   						/* return  "<font color=green>" + mc + "</font>" ;  */
   			   						return mc;
   			   					//return  "<font color=green>" + row.value + "</font>" ;
   			   					},
   			   					formatMatch: function(row, i, max) {
   			   					//mc=row.value.split(";")[0];
   			   						return row.value ;
   			   					},
   			   					formatResult: function(row) {
   			   						
   			   						return row.value;
   			   					}
   			   					}).result(function(event,data,formatted){
   				   		            var cp= data.value;
   				   		      		mc = cp.split(";")[0];
   				   		      		//thespec = cp.split(";")[1]; 
   				   		      		selectName=mc; 
   				   		      		//selectName=data.value;
   				   		      		
   				   		            guanlian(data.id);
   				   		            productID=data.id;    
   				   		     		 $("#selectproductId").val(productID);
   				   		     	
   			   				});
   			   			
   			},
   			   			error: function(data) {
   			   				$("#selectproductId").val(null);
//	   			   				alert("加载失败，请重试！");
   			   			}
   			   			});
	//$("#output_product").autocomplete().unbind();
	//pageSize=10;
	
	 }else{			//对doFlag！=1 的处理
		 
		 var d = new Date();
		 while(true){
		 	var d1 = new Date();
			var i = d1-d;
		 	if(i >500)
		 		{
		 		//console.log("ssds"+"+++++++time"+d+"///"+d1+"----"+i+"      woqu");
		 		 break;//3秒后跳出循环
		 		}
			
		 }
		 doFlag=1;
		 
	 }
});
	 $("#output_product").on("keyup", function(){

		 //pageSize=60;
		 //$("#output_product").autocomplete().unbind();
		 var theWords = $("#output_product").val().trim();
		 var pparams={'name':theWords};
		 /* $("#loading").show(); */
		 if(theWords.length!=matLength){
			 matLength = theWords.length;
			 if(doFlag != 0 ){
				 
				 doFlag=0;
			 $.ajax({
		  	 		type:"post",
		  	 	    headers: { 
		  	 	        'Accept': 'application/json',
		  	 	        'Content-Type': 'application/json', 
		  	 	    }, 
		  	 	    dataType:'json',
		   			data:JSON.stringify(pparams),
		   			url: "../outputManage/outputMaterial/queryOutputMaterialsByName/"+pageNum+"/"+pageSize,
		   			success: function(data) {

									 $("#output_product").bind("keydown.autocomplete");
		   							 $('#output_product').bind("input.autocomplete", function () {	  
		   	                				$(this).trigger('keydown.autocomplete');
		   	           				 }); 
		   			   				$("#output_product").autocomplete(data.body.resultList,{
		   			   					minChars: 0,
		   			   					width: 301,
		   			   					max:12,
		   			   					matchContains: true,
		   			   					autoFill: false,
		   			   					scroll: false,
		   			   				 	//delay: 1000,
		   			   					//matchSubset: false,
		   			   					//selectFirst: true,
		   			   					dataType: 'json',			   			   					
		   			   					formatItem: function(row, i, max) {
		   			   						 mc=row.value.split(";")[0];
		   			   						/* return  "<font color=green>" + mc + "</font>" ;  */
		   			   						return mc;
		   			   					//return  "<font color=green>" + row.value + "</font>" ;
		   			   					},
		   			   					formatMatch: function(row, i, max) {
		   			   					//mc=row.value.split(";")[0];
		   			   						return row.value ;
		   			   					},
		   			   					formatResult: function(row) {
		   			   						
		   			   						return row.value;
		   			   					}
		   			   					}).result(function(event,data,formatted){
		   				   		            var cp= data.value;
		   				   		      		mc = cp.split(";")[0];
		   				   		      		//thespec = cp.split(";")[1]; 
		   				   		      		selectName=mc; 
		   				   		      		//selectName=data.value;
		   				   		      		
		   				   		            guanlian(data.id);
		   				   		            productID=data.id;    
		   				   		     		 $("#selectproductId").val(productID);
		   				   		     	
		   			   				});
		   			   			
		   			},
		   			   			error: function(data) {
		   			   				$("#selectproductId").val(null);
//			   			   				alert("加载失败，请重试！");
		   			   			}
		   			   			});
			//$("#output_product").autocomplete().unbind();
			//pageSize=10;
			
			 }else{			//对doFlag！=1 的处理
				 
				 var d = new Date();
				 while(true){
				 	var d1 = new Date();
					var i = d1-d;
				 	if(i >500)
				 		{
				 		//console.log("ssds"+"+++++++time"+d+"///"+d1+"----"+i+"      woqu");
				 		 break;//3秒后跳出循环
				 		}
					
				 }
				 doFlag=1;
				 
			 }
		 }
    }); 
	
   /*--日历-发货--*/			
   $('#date_outputprod').calendar( { maxDate:'%y-%M-%d'});
    $('#date_output').calendar({minDate:calDateByDay(-32),maxDate:calDateByDay(10), onSetDate:function(){
    	$('#date_outputprod').val(null);
    	$('#date_outputprod').calendar( { maxDate:'#date_output'})} }); 

   
		if(pageNum==null||pageNum==""){
			pageNum=1;
		}
		search(pageNum);

function search(pageNum){
	$("#loading").show();
	$.ajax({
	url: "../outputManage/outputBatch/queryOutputBatchs/"+pageNum+"/"+pageSize,
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json', 
    }, 
    dataType:'json',
	data:JSON.stringify(params),
	success:function(result) {
		$("#loading").hide();
		if(result.status==0){
			/* page(result); */
			var resultList=result.body.resultList;
			$("#body").children().remove();
			for(var i=0;i<resultList.length;i++){
				var num=i+1;
				var id=resultList[i].id;
				var outputDate=isNullForTable(resultList[i].outputDate);
				var outputMatName=isNullForTable(resultList[i].outputMatName);
				var spec=isNullForTable(resultList[i].spec);
				var traceCode=isNullForTable(resultList[i].traceCode);
				var quantity=isNullForTable(resultList[i].quantity);
				var manufacture=isNullForTable(resultList[i].manufacture);
				var guaranteeValue=isNullForTable(resultList[i].guaranteeValue);
				var newBatchId=isNullForTable(resultList[i].productionBatch);
				var guarantee=isNullForTable(resultList[i].guaranteeValue)+""+isNullForTable(resultList[i].guaranteeUnitString);
				var guaranteeUnit=isNullForTable(resultList[i].guaranteeUnit);
				var productionDate=isNullForTable(resultList[i].productionDate);
				var receiverName=isNullForTable(resultList[i].receiverName);
			 var $tr=$("<tr><td class='td_ser'>"+((pageNum-1)*pageSize+num)+"</td><td>"+outputDate+"</td><td>"+outputMatName+"</td><td>"+spec+"</td><td>"+manufacture+"</td><td>"+quantity+"</td><td>"+productionDate+"</td><td>"+newBatchId+"</td><td>"+guarantee+"</td><td>"+traceCode+"</td>"
   					+"<td>"+receiverName+"</td ><td class='td_oper'><a href='javascript:void(0)' class='editor_into btn_green'>编辑</a><a href='javascript:void(0)' class='btn_green' rel='popup' link='replenish.send.out-iframe-del?id="+id+"' title='提示'>删除</a></td></tr>");
			 if(i%2==0){
					$tr.addClass("even");
				}	
			 $tr.data("id",id);
				$("#body").append($tr);
			};
		};
		
	 },   
	 error:function(text) {
		 alert("系统异常，查询失败！");
	 },
	});
}
			 
			
			 
			 function guanlian(productID){
				 var id=productID;
				 newguanlianID=id;
				 if(id != -1 && oldguanlianID != newguanlianID){	
					 oldguanlianID=newguanlianID;
					$.ajax({
				 	 		type:"get",
							headers:{'Accept': 'application/json',
				  	 	        'Content-Type': 'application/json',},
				  			url: "../outputManage/outputMaterial/getOutputMaterialById/"+productID,
				  			success: function(data)
				  			{
				  				
				  				var theproductName=data.body.manufacture;
				  				var thename=data.body.name;
				  				selectName=thename;
				  				var sspec=data.body.spec;
				  				document.getElementById("output_product").value = thename;
				  				document.getElementById("spec").value = html_decode(sspec);
				  				document.getElementById("product_name").value =theproductName;
				  			},
				  			error: function(data) {
					   				alert("加载失败，请重试！");
					   				}
						        });	 
				 }
				};
			 
			 	$("#output_product").blur(function(){
					//guanlian(productID);
					if($(this).val().trim()!=selectName && $("#selectproductId").val().trim()==productID){
							//alert(supplierName);
							//alert(modelId);
							//$("#selectproductId").val("");
							$("#output_product").val(selectName);
					}
					if($(this).val().trim()==selectName && $("#selectproductId").val().trim()!=productID){
						//alert(modelId);
						$("#selectproductId").val(productID);
					}
					});
				
		 
				//保存事件，显示保存成功或者失败
			    $("#save").click(function () { 
			    	$("#loading").show();
			    	Out.outputDate = $("#date_output").val().trim();	    	
			    	Out.outputMatId = $("#selectproductId").val();
			    	outputMatName = $("#output_product").val().trim();
			    	if(outputMatName != selectName)
			    	Out.manufacture = $("#product_name").val().trim();
			    	Out.spec = $("#spec").val().trim();
			    	Out.quantity = $("#quen").val().trim();
			    	Out.productionDate = $("#date_outputprod").val().trim();
			    	Out.productionBatch = $("#pihao").val().trim();
			    	var traceCode=$("#traceCode").val().trim();
			    	Out.traceCode=traceCode;
			    	var selP1 = $(".select_sendD span.send_checked em");	
			    	var selP2 = $(".select_sendD span.send_checked p");	

			    	if(selP1.length == 0)
			    		{
			    			alert("至少选择一个收货商！");
			    			$("#loading").hide();
			    			return;
			    		};
			    		if($("#selectproductId").val() == 0)
			    		{
			    			alert("至少选择一个产品！");
			    			$("#loading").hide();
			    			return;
			    		};
			    		if(isNumber(Out.quantity)==false){
			    			alert("请输入正确的数量");
			    			$("#loading").hide();
			    			return;
			    		}
			    		//数量必须为数字
						if (Out.quantity=="" || Out.quantity==null || Out.quantity == 0){
							 alert("数量不能为空!");
							 $("#loading").hide();
							 return;
							};
								//批号和日期必须二选一
						if((Out.productionDate==null||Out.productionDate=="")&&(Out.productionBatch==null||Out.productionBatch=="")){
									alert("生产日期和生产批号必须选择一个!");
									$("#loading").hide();
									return;
							};
			    		//jishu=selP1.length;
			    		var receiverIdListArray=new Array();
					  for(var i=0;i<selP1.length;i++){				  
						  receiverName = $(selP1[i]).text();  
						  //Out.receiverId = $(selP2[i]).text();
						  receiverIdListArray[i] = $(selP2[i]).text();
						  $("#recId").text($(selP2[i]).text());
						  $("#receiverModify").val(receiverName);
						//非空输入框非空验证
						if(receiverName=="" || receiverName==null || outputMatName=="" || outputMatName==null|| $(selP2[i]).text()==null || Out.outputMatId==null || Out.outputMatId==""){
							alert("供应商和产品不能为空!");
							$("#loading").hide();
							return;
						};

				 		};
				 		Out.receiverId = receiverIdListArray;
						
       					$.ajax({		
       						url:"../outputManage/outputBatch/createOutputBatch",
        					headers: { 
            							'Accept': 'application/json',
            							'Content-Type': 'application/json', 
       							 	}, 
        					type: 'post',
        					dataType: 'json',
       						 data:JSON.stringify(Out),
        					success: function (data) {	
        						 //if(jishu==1){
        							 if(data.status==0)
        								 {
        								 oldguanlianID=0;
        								 	search(pageNum);
        								 }else{
        									 oldguanlianID=0;
        									 alert("新增发货失败，服务器端异常！");
        								 }
    								
    							//}; 
    							//jishu=jishu-1;
            				},
            				error: function(){
            					oldguanlianID=0;
            					alert("保存失败，请重试！！！");
            				},
       				});	
      
				 		
				 $("#loading").hide();
					clearAndSave();
			        //return false;
			  });
				
				//取消函数
				$("#cancel").click(function () {
			    	$("#save").show();
		            $("#modify").hide();
		            /* $("#cancel").hide(); */
		            
		            $("#receiverButton").show();
			        $("#receiverModify").hide();
					clearAndSave();
				});
				
		/* 		$("#modify").click(function () {
					idList
				}); */
				
				//修改函数
		 $("#modify").click(function () {
					 modifyParams.id = $("#productId").text();
					 modifyParams.outputDate = $("#date_output").val().trim();
			    	
					 receiverName = $("#receiverModify").val().trim();   
					 modifyParams.receiverId = $("#recId").text().trim();
					 
					  
			    	var outputMatId =  $("#selectproductId").val();
			    	var outputMatName = $("#output_product").val().trim();
			    	if(outputMatName != selectName)
			    		{
			    		alert("请选择正确的产品名称！");
						$("#loading").hide();
						return;
			    		}
			    	modifyParams.outputMatId = outputMatId;
			    	modifyParams.quantity= $("#quen").val().trim();
			    	modifyParams.traceCode= $("#traceCode").val().trim();
			    	modifyParams.productionDate = $("#date_outputprod").val().trim();
			    	modifyParams.productionBatch = $("#pihao").val().trim();
					if(isNumber(modifyParams.quantity)==false){
						alert("请输入正确的数量");
						$("#loading").hide();
						return;
					}
					
						//非空输入框非空验证
						if(receiverName=="" || receiverName==null || outputMatName=="" || outputMatName==null|| modifyParams.receiverId==null|| outputMatId==null){
							alert("供应商和产品不能为空!");
							return;
						};
							//数量必须为数字
							if (modifyParams.quantity=="" || modifyParams.quantity==null || Out.quantity == 0){
								 alert("数量不能为空!");
								 return;
								};
							
								
									//批号和日期必须二选一
									if((modifyParams.productionDate==null||modifyParams.productionDate=="")&&(modifyParams.productionBatch==null||modifyParams.productionBatch=="")){
										alert("生产日期和生产批号必须选择一个！");
										return;
									}
									else{
										//类似于12306 的判断验证
										/* if() 思路是    产品名称 输入结束后，判断是否为结果集中的值， 不是得话，就试着input边框为红，有一个标识的calss或者别的
										然后再此处判断 input的属性 ，异常则终止往下走，且清空intput
											{}; */
											
											
										params.delFlag=1;
										$("#loading").show();
											$.ajax({
												url:"../outputManage/outputBatch/updateOutputBatch",
												type:"post",
												data:JSON.stringify(modifyParams),
												dataType:"json",
												 headers: { 
											        'Accept': 'application/json',
											        'Content-Type': 'application/json', 
											    }, 
											    success:function(result){
											    	$("#loading").hide();
											    	search(pageNum);
											    	$("#save").show();
										            $("#modify").hide();
										            
										            $("#receiverButton").show();
										            $("#receiverModify").hide();
										            oldguanlianID=0;
										           /*  $("#cancel").hide(); */
										            clearAndSave();
													
														
											    },
											    });
											};
									
					
			        return false;
			    });
});	
  
//清空并保存
function clearAndSave(){
		document.getElementById("spec").value = null;
		document.getElementById("product_name").value =null;
		document.getElementById("output_product").value = null;
		//document.getElementById("date_outputprod").value =null;
		document.getElementById("quen").value =null;
		document.getElementById("traceCode").value =null;
		document.getElementById("pihao").value =null;	
		var ssw=0;
		$("#selectproductId").val(ssw);
		selectName=null;
		//alert($("#selectproductId").text());
		/* var selP1 = $(".select_sendD span.send_checked em");		
		  for(var i=0;i<selP1.length;i++){	
			  $(selP1[i]).parent("span.send_checked").remove();
		  };
		   
			   var scid=$("#recId").text();
				var rn=$("#receiverModify").val();
				var $a=$('<span class="send_checked" ><em>'+ rn +'</em><i class="i_del">X</i><p hidden>'+ scid +'</p></span>');
				if(rn != null && scid != null && rn != "" && scid != "")
					{
					$(".send_names").append($a);
						
					};  */
		  
}

/* $("body").on("click",".editor_into",function() */

//绑定id
$("a.editor_into").live("click",function(){
	var thisid=$(this).parents("tr").data("id");	
	$.ajax({
			url:"../outputManage/outputBatch/getOutputBatchById/"+thisid,
			type:"get",
			headers:{'Accept': 'application/json',
  	 	        'Content-Type': 'application/json',},
		    success:function(result){
		    	$("#save").hide();
	            $("#modify").show();
		    	var dto=result.body;
		    	var Id=dto.id;
				var OutputDate=isnull(dto.outputDate);
				var OutputMatName=isnull(dto.outputMatName);
				var Spec=isnull(dto.spec);
				var Manufacture=isnull(dto.manufacture);
				var Quantity=isnull(dto.quantity);
				var ProductionDate=isnull(dto.productionDate);
				var ProductionBatch=isnull(dto.productionBatch);
				var ReceiverId=isnull(dto.receiverId);
				var OutputMatId=isnull(dto.outputMatId);
				var TraceCode=isnull(dto.traceCode);
				var ReceiverName=dto.receiverName;
				$("#productId").text(thisid);
				$("#selectproductId").val(OutputMatId);
		    	$("#date_output").val(OutputDate);
				$('#date_outputprod').calendar( { maxDate:'#date_output'}); 
		    	$("#receiverButton").hide();
	            $("#receiverModify").show();
		    	
		    	$("#receiverModify").val(ReceiverName); 
		    	$("#traceCode").val(TraceCode);
		    	$("#output_product").val(OutputMatName);
		    	selectName=OutputMatName;
		    	$("#spec").val(Spec);
		    	$("#product_name").val(Manufacture);
		    	$("#quen").val(Quantity);
		    	$("#date_outputprod").val(ProductionDate);
		    	$("#pihao").val(ProductionBatch);
		    	
		        $("#recId").text(ReceiverId); 
		        var selP1 = $(".select_sendD span.send_checked em");		
				  for(var i=0;i<selP1.length;i++){	
					  $(selP1[i]).parent("span.send_checked").remove();
				  };
		        var $a=$('<span class="send_checked" ><em>'+ ReceiverName +'</em><i class="i_del">X</i><p hidden>'+ ReceiverId +'</p></span>');
		        $(".send_names").append($a);
		    	
		    },
		    error:function(){
		    	alert("系统异常，查询失败！");
		    }
		});
});

$("i.i_del").live("click",function(){
    $(this).parent("span.send_checked").remove();
/*     $("#recId").text(null);
	$("#receiverModify").val(null); */
    
});

/*-------jquery end-------*/
</script>
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">新增发货</a> </h3>
          <div class="query">
          <form id="add-output">
               <table class="query_table"  style="width:895px;">
                  <tr>
                      <td class="td_lf"><em class="star">*</em>发货日期</td>
                       <td><input type="text" class="input_date" id="date_output"  readOnly="true"  /></td>
                      <script type="text/javascript">
 						var mydateInput = document.getElementById("date_output");
						var date = new Date();
						var dateString = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
						mydateInput.value=dateString;
 					</script>
					<td class="td_lf"><em class="star">*</em>收货商名称<span style='display:none;' id="productId"></span></td>
                       <td colspan="3">
                       <div style=" height:27px; position:relative;">
                       <span style='display:none;' id="recId"></span>
                       <input type="text" class="input_code"  style="display:none;" id="receiverModify" style=" width:200px;" readOnly="true"/>
                       <input type="button" class="btn_send" id="receiverButton" value="请选择收货商" rel="popup" link="replenish.send.selectReceiver"  style="width:200px;" title="选择收货商" /><br /></td>
                  		</div>
                  </tr>
                  <tr class="select_send"  style="display: table-row;" id="receiverSelect" >
                      <td colspan="6" class="select_sendD">
                       <div class="send_names select_sendD" id="sendName">  
                       </div>
                      </td> 
                  </tr>
                  <tr>
                      <td class="td_lf"><em class="star">*</em>产品名称</td>
                      <td><input type="text" class="input_code" style="width:168px;"  placeholder="请输入关键字选择产品" id="output_product" maxlength="20" onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},\/;[\].]/g,''))"/>
                     
                      <input type="text" id="selectproductId" style="display:none" />
                      </td>
                      <td class="td_lf"><em class="star"></em>生产单位</td>
                      <td><input type="text" class="input_code"   id="product_name" style=" width:200px; background:#dcdddd;" readOnly="true"/></td>
                      <td class="td_lf"><em class="star">&nbsp;</em>生产日期</td>
                      <td><input type="text" class="input_date" id="date_outputprod" value="" readOnly="true" placeholder="请选择生产日期" /></td>
                  </tr>
                  <tr>
                      <td class="td_lf"><em class="star">*</em>规      &nbsp;&nbsp;  格&nbsp;&nbsp;</td>
                      <td><input type="text" class="input_code" style="width:168px; background:#dcdddd;"  readOnly="true" id="spec"  /></td>
                      <td class="td_lf"><em class="star">*</em>数     &nbsp;&nbsp;  量&nbsp;&nbsp;</td>
                     <!--  onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d.]/g,''))" -->
                      <td><input type="text" class="input_code" value="" id="quen" style=" width:200px;" placeholder="请输入数量" maxlength="9"  onkeyup="value=value.replace(/[^\d.]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d.]/g,''))" /></td>
                      <td class="td_lf"><em class="star">&nbsp;</em>生产批号</td>
                      <td><input type="text" class="input_code" style="width:168px;" id="pihao" value="" maxlength="20" placeholder="请输入生产批号" onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"
                       /></td>
                  </tr>
                  <tr>
                     <td class="td_lf"><em class="star"></em>追溯码</td>
                     <td colspan="5"><input type="text" class="input_code" maxlength="50" id="traceCode" value="" style="width:168px;"/></td>
                  </tr>
               </table>
               <div class="kuang" style="right:0; left:895px;">至少填写一项</div>
               </form>
               <p class="query_btn"><input type="button" id="save" class="btn_query" value="新增" /><input type="button" id="modify" class="btn_query" value="修改" style="display:none;" id="update_product"/><input type="button" class="btn_cancel" id="cancel"  value="取消" /></p>
          </div>
          <div class="table_box">
               <table class="table_list" style="min-width:895px;">
                    <thead>
                       <tr>
                           <th style="min-width:30px">序号</th>                                         
                           <th style="min-width:70px">发货日期</th>
                           <th style="min-width:80px">产品名称</th>
                           <th style="min-width:50px">规格</th>
                           <th style="min-width:100px">生产单位</th>
                           <th style="min-width:30px">数量</th>
                           <th style="min-width:70px">生产日期</th>
                           <th style="min-width:50px">批次号</th>
                           <th style="min-width:40px">保质期</th>
                           <th style="min-width:50px">追溯码</th>
                           <th style="min-width:70px">收货商名称</th>
                           <th style="min-width:80px">操作</th>
                       </tr>
                    </thead>
                      <tbody id="body">                    
                    </tbody> 
                 </table>
 					<%-- <p class="paging_box">
                    <span class="paging_perv"><input type="button" value="<< 上一页" class="disabled" id="pre_page"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>"  id="next_page"/></span>
                 </p> --%>
                 <div class="clear"></div>
          </div>
     </div>
      
</div>    


</body>
</html>