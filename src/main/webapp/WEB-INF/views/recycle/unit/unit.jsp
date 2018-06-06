<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
table.info_mation td.td_lf{width:120px;}
h4.per_title .btn_opera{padding-top:0;top:-15px;}
span.text_ts{color:#ff6600;margin-left:20px;}
span.text_ts1{color:#ff6600;margin-left:20px;}
span.text_ts2{color:#ff6600;margin-left:20px;}
span.text_ts3{color:#ff6600;margin-left:20px;} 
span.text_ts4{color:#ff6600;margin-left:20px;} 
</style>


<script type="text/javascript">
var id;
var param={};
var pparam ={};
var text ={};
var idOil;
var param2={};
var pparam2 ={};
var text2 ={};
var oilCleanCompanyId;
var companyName;
//餐厨编辑取消
var kitchen_name;
var kitchen_address;
var kitchen_contactPerson;
var kitchen_phoneNum;

$(function(){
	
	function show(str){		
		$("#id").text(str.body.id);
		$("#kitchen-name").text(str.body.name);
		$("#kitchen-address").text(str.body.address);
		$("#kitchen-contactPerson").text(str.body.contactPerson); 
		$("#kitchen-phoneNum").text(str.body.phoneNum);	
		$("#id2").val(str.body.id);
		$("#kitchen-name2").val(str.body.name);
		$("#kitchen-address2").val(str.body.address);
		$("#kitchen-contactPerson2").val(str.body.contactPerson);
		$("#kitchen-phoneNum2").val(str.body.phoneNum);
		
	
	}
	
	function show2(str){		

		$("#idOil").text(str.body.id);	
		$("#oil-name").text(str.body.name);
		$("#oil-address").text(str.body.address);
		$("#oil-contactPerson").text(str.body.contactPerson); 
		$("#oil-phoneNum").text(str.body.phoneNum);	
		
		
		$("#id_2").val(str.body.id);
		$("#selectqx-edit").val(str.body.name);

		$("#oil-address2").val(str.body.address);
		$("#oil-contactPerson2").val(str.body.contactPerson);
		$("#oil-phoneNum2").val(str.body.phoneNum);
	
	}
	

	function show3(){
		   $('#kitchen-name4').val('');
		   $('#kitchen-address4').val('');
		   $('#kitchen-contactPerson4').val('');
		   $('#kitchen-phoneNum4').val('');

	}

	function show4(){
		   $('#selectqx-new').val('');
		   $('#oil-address4').val('');
		   $('#oil-contactPerson4').val('');
		   $('#oil-phoneNum4').val('');

	}
	
	function  show5(){
			$("#table4").find(".text_ts").remove();
    		$("#table4").find(".text_ts1").remove();
    		$("#table4").find(".text_ts2").remove();
    		$("#table4").find(".text_ts3").remove(); 
	
	
			 }
	
	
	function  show6(){
	    $("#table").find(".text_ts").remove();
   		 $("#table").find(".text_ts1").remove();
   		$("#table").find(".text_ts2").remove();
   		$("#table").find(".text_ts3").remove(); 
		$('#kitchen-name2').val(kitchen_name);
		$('#kitchen-address2').val(kitchen_address);
		$('#kitchen-contactPerson2').val(kitchen_contactPerson);
		$('#kitchen-phoneNum2').val(kitchen_phoneNum);	 
	 }
	
	
	
//查询 餐厨单位
	function getView(){
	   	$.ajax({
    	    async : false,
    	    cache : false,  
    	    type:"get",
    	    headers: {
    	        'Accept': 'application/json',
    	        'Content-Type': 'application/json' 
    	    },      
    	    dataType : "json",
    	    url: "../restaurant/oilCleanComMgr/listCompanyWasteRecycle",//请求的action路径
    	    error: function (e) {//请求失败处理函数
    	    	console.log(e);
    	     alert('请求失败');
    	    },
    	     success:function(text){ //请求成功后处理函数。   	    
    	    	isExitsVariable(text);
    	    	
   			 }       
    	 });
    	
	}
	//查询 油脂 单位
	function getView2(){
	   	$.ajax({
    	    async : false,
    	    cache : false,  
    	    type:"get",
    	    headers: {
    	        'Accept': 'application/json',
    	        'Content-Type': 'application/json' 
    	    },      
    	    dataType : "json",
    	    url: "../restaurant/oilCleanComMgr/listCompanyOilRecycle",//请求的action路径
    	    error: function (e) {//请求失败处理函数
    	    	console.log(e);
    	     alert('请求失败');
    	    },
    	     success:function(text){ //请求成功后处理函数。
    	    	
    	    	 isExitsVariable2(text);
		  			
		     }       
    	 });
    	
	}
	
	
//获取废弃油脂单位列表

var pageNum=-1;
var pageSize=-1;
	function selectTypeGeneral(){
	
		$.ajax({
			url:"../restaurant/oilCleanComMgr/clean/queryOilCleanCompany/"+pageNum+"/"+pageSize,
		      headers: { 
	              'Accept': 'application/json',
	              'Content-Type': 'application/json' 
	          },
			type: "post",
			data:"json",
			
			 success:function(text){
				  
				 isExitsVariable3(text);
			 }, 
		});		
	}
	
	//根据ID查询废弃油脂单位 编辑
	function selectCompany(){
		oilCleanCompanyId=$("#selectqx-edit").val();
		$.ajax({
			url:"../restaurant/oilCleanComMgr/clean/queryOilCleanCompanyById/"+oilCleanCompanyId,
		      headers: { 
	              'Accept': 'application/json',
	              'Content-Type': 'application/json' ,
	          },
			type: "get",
			data:"json",
			
			 success:function(text){
				
					var st=text.body.companyAddress;
					var st1=text.body.contactPerson;
					var st2=text.body.phoneNum;
					$("#oil-address2").val(st);
					$("#oil-contactPerson2").val(st1);
					$("#oil-phoneNum2").val(st2);
					
			
			 }, 
		});		

	}
	 
	
	//根据ID查询废弃油脂单位  新增
	function selectCompany2(){
		oilCleanCompanyId=$("#selectqx-new").val();
		$.ajax({
			url:"../restaurant/oilCleanComMgr/clean/queryOilCleanCompanyById/"+oilCleanCompanyId,
		      headers: { 
	              'Accept': 'application/json',
	              'Content-Type': 'application/json' ,
	          },
			type: "get",
			data:"json",
			
			 success:function(text){
				 if(oilCleanCompanyId==0000){
						 $("#oil-address4").val("");
						$("#oil-contactPerson4").val("");
						$("#oil-phoneNum4").val("");
				 }
				
				
					var st3=text.body.companyAddress;
					var st4=text.body.contactPerson;
					var st5=text.body.phoneNum;
					$("#oil-address4").val(st3);
					$("#oil-contactPerson4").val(st4);
					$("#oil-phoneNum4").val(st5);
			 }, 
		});		

	}
	 
	//删除 单位
		$("#kitchen-delete").click(function(){
			var url = "recycle.unit.iframe?id="+id;
			$("#kitchen-delete").attr("link",url);
		});
	
		$("#oil-delete").click(function(){
			
			var url = "recycle.unit.iframe2?id="+idOil;
			$("#oil-delete").attr("link",url);
		});
		 
	 
	//点击编辑 修改信息
	$("#kitchen-edit").click(function(){
		            $(this).hide();
		            $("#unit-kitchen-view").hide();
		            $("#unit-kitchen-editor").show();
		            $("#kitchen-delete").show();
		        });
		    
	$("#oil-edit").click(function(){
	            $(this).hide();
	            $("#unit-oil-view").hide();
	            $("#unit-oil-editor").show();
	           $("#oil-delete").show();
	        });
		   
		    
	
	   //添加回收单位控制			   
	   $("#btn-oil-recycel").click(function(){
	       $(this).hide();
		   $("#unit-oil-new").show();
	   });
	   
	   $("#btn-kitchen-recycel").click(function(){
	       $(this).hide();
		   $("#unit-kitchen-new").show();
	   });
	   
	   //编辑页面的 取消操作
	   $("#btn-oil-cancel").click(function(){
		 
		 $("#oil-delete").hide();
		$("#oil-edit").show();
		   $("#unit-oil-editor").hide();
		   $("#unit-oil-view").show(); 
		   $("#selectqx-edit").siblings(".text_ts4").remove();
		   $("#oil-address2").siblings(".text_ts4").remove();
		   $("#oil-contactPerson2").siblings(".text_ts4").remove();
		   $("#oil-phoneNum2").siblings(".text_ts4").remove();
		   $(".text_ts").remove();
		   $(".text_ts1").remove();
		   $(".text_ts2").remove();
		   $(".text_ts3").remove();
		   getView2();	
		   show5();
		  
		   
		   selectTypeGeneral();
		   
	   });
	   
	   $("#btn-kitchen-cancel").click(function(){
		   $("#kitchen-name2").siblings(".text_ts4").remove();
		   $("#kitchen-address2").siblings(".text_ts4").remove();
		   $("#kitchen-contactPerson2").siblings(".text_ts4").remove();
		   $("#kitchen-phoneNum2").siblings(".text_ts4").remove();
		   $("#kitchen-delete").hide();
		   $("#kitchen-edit").show();
           $("#unit-kitchen-editor").hide();
           $("#unit-kitchen-view").show();
          
           $("#table4").find(".text_ts").remove();
           $("#table4").find(".text_ts1").remove();
           $("#table4").find(".text_ts2").remove();
           $("#table4").find (".text_ts3").remove();
           
           show6();
	   });
	   
	   
	  //新增页面的取消操作
	   $("#btn-oil-back").click(function(){
		  
		   $("#table3").find(".text_ts").remove();
	     	$("#table3").find(".text_ts1").remove();
	    	$("#table3").find(".text_ts2").remove();
	    	$("#table3").find(".text_ts3").remove(); 
	    	$("#selectqx-new").siblings(".text_ts4").remove();
	    	$("#oil-address4").siblings(".text_ts4").remove();
	    	$("#oil-contactPerson4").siblings(".text_ts4").remove();
	    	$("#oil-phoneNum4").siblings(".text_ts4").remove(); 
		   $("#btn-oil-recycel").show();
		   $("#unit-oil-new").hide();
		   show4();
	   });
	   
	   $("#btn-kitchen-back").click(function(){
		   
		   $("#table2").find(".text_ts").remove();
	     	$("#table2").find(".text_ts1").remove();
	    	$("#table2").find(".text_ts2").remove();
	    	$("#table2").find(".text_ts3").remove(); 
	    	$("#kitchen-name4").siblings(".text_ts4").remove();
	    	$("#kitchen-address4").siblings(".text_ts4").remove();
	    	$("#kitchen-contactPerson4").siblings(".text_ts4").remove();
	    	$("#kitchen-phoneNum4").siblings(".text_ts4").remove();
	       $("#btn-kitchen-recycel").show();
           $("#unit-kitchen-new").hide();
       		show3();
	   });
	   
	   
 /* ----------------------------餐厨修改 -----------------------------------*/
	  
		 //这里去掉了单位名称后面的提示
	   $("#kitchen-name2").focus(function(){
	    	$("#table").find(".text_ts").remove();
	    	
	    });   
	    
	    //这里去掉了单位地址后面的提示
	    $("#kitchen-address2").focus(function(){
	    	$("#table").find(".text_ts1").remove();
	    	
	    });
	    
	    //这里去掉了联系人后面的提示
	    $("#kitchen-contactPerson2").focus(function(){
	    		  $("#table").find(".text_ts2").remove();
	    		
	    	  });
	    //这里去掉了手机号码后面的提示
	    $("#kitchen-phoneNum2").focus(function(){
	    		  $("#table").find(".text_ts3").remove();
	    	
	    	  });
	   

 
 
		
/* ----------------------------油脂修改 -----------------------------------*/
		  
		 //这里去掉了单位名称后面的提示
	   $("#typeGeneral").focus(function(){
	    	$("#table4").find(".text_ts").remove();
	    	
	    });   
	    
	    //这里去掉了单位地址后面的提示
	    $("#oil-address2").focus(function(){
	    	$("#table4").find(".text_ts1").remove();
	    	
	    });
	    
	    //这里去掉了联系人后面的提示
	    $("#oil-contactPerson2").focus(function(){
	    		  $("#table4").find(".text_ts2").remove();
	    		
	    	  });
	    //这里去掉了手机号码后面的提示
	    $("#oil-phoneNum2").focus(function(){
	    		  $("#table4").find(".text_ts3").remove();
	    	
	    	  });
	   
	    
	    
	    
	    
	/* --------------------餐厨新增 ------------------*/
	    
	  //这里去掉了单位名称后面的提示
		   $("#kitchen-name4").focus(function(){
		    	$("#table2").find(".text_ts").remove();
		    	
		    });   
		    
		    //这里去掉了单位地址后面的提示
		    $("#kitchen-address4").focus(function(){
		    	$("#table2").find(".text_ts1").remove();
		    	
		    });
		    
		    //这里去掉了联系人后面的提示
		    $("#kitchen-contactPerson4").focus(function(){
		    		  $("#table2").find(".text_ts2").remove();
		    		
		    	  });
		    //这里去掉了手机号码后面的提示
		    $("#kitchen-phoneNum4").focus(function(){
	  		  $("#table2").find(".text_ts3").remove();
	  		
	  	  });
/* ----------------------------油脂新增 -----------------------------------*/


		 //这里去掉了单位名称后面的提示
	   $("#selectqx-new").focus(function(){
	    	$("#table3").find(".text_ts").remove();
	    	
	    });   
	    
	    //这里去掉了单位地址后面的提示
	    $("#oil-address4").focus(function(){
	    	$("#table3").find(".text_ts1").remove();
	    	
	    });
	    
	    //这里去掉了联系人后面的提示
	    $("#oil-contactPerson4").focus(function(){
	    		  $("#table3").find(".text_ts2").remove();
	    		
	    	  });
	    //这里去掉了手机号码后面的提示
	    $("#oil-phoneNum4").focus(function(){
	    		  $("#table3").find(".text_ts3").remove();
	    	
	    	  });
	    	  
	    $("body input[type='text']").focus(function(){
	  		  $(this).siblings(".text_ts4").remove();
	  		
	  	  });
		
	  
	    
	    function isExitsVariable(text) {
	    	
	        if (!text.body) {
	    		  text.body = 0;
	    		
	    	  };
	    	  
	    	        if (text.body != 0) {
	    	        	id=text.body.id;
	    	        	kitchen_name=text.body.name;
	    	        	kitchen_address=text.body.address;
	    	        	kitchen_contactPerson=text.body.contactPerson;
	    	        	kitchen_phoneNum=text.body.phoneNum;
	    	        console.log(text.body);
	    	        show(text);
	        	$("#unit-kitchen-view").show();
	        	$("#btn-kitchen-recycel").hide();
	        	$("#kitchen-edit").show();
	    	        } else {

	    	        	 $("#btn-kitchen-recycel").show();
	    	        	
	    	        }
	 
	}    
	  
  function isExitsVariable2(text) {
	  if (!text.body) {
		  text.body = 0;
		
	  };
	  
	        if (text.body != 0) {
	        	$("#unit-oil-view").show();
	        	$("#btn-oil-recycel").hide();
	        	$("#oil-edit").show();
	        	
	        	  idOil=text.body.id;		    	        
	        	  oilCleanCompanyId=text.body.oilCleanCompanyId;
	        	
	        	 console.log(text.body);
	        	 show2(text);
	        } else {
	        	
	        	 $("#btn-oil-recycel").show();
	        	
	        }
	  
	  
  }
	
  
  function isExitsVariable3(text) {
	  if (!oilCleanCompanyId) {
		  oilCleanCompanyId = 0;
		  
	  };
	 
	        if(oilCleanCompanyId!=0){
	        	
	        	for(var i=0;i<text.body.resultList.length;i++){
	        		
	        		if(oilCleanCompanyId==text.body.resultList[i].id){
	        			$("#selectqx-edit").append('<option  selected="selected" value='+text.body.resultList[i].id+'>'+text.body.resultList[i].companyName+'</option>');
			    		//$("#selectqx_oil").append('<option  selected="selected" value='+text.body.resultList[i].id+'>'+text.body.resultList[i].companyName+'</option>');
			    		//$("#selectqx-new").append("<option value='"+text.body.resultList[i].id+"'>"+text.body.resultList[i].companyName+"</option>");
				 	 }else{
				 		$("#selectqx-edit").append('<option  value='+text.body.resultList[i].id+'>'+text.body.resultList[i].companyName+'</option>');
						//$("#selectqx-new").append("<option value='"+text.body.resultList[i].id+"'>"+text.body.resultList[i].companyName+"</option>");
						//$("#selectqx_oil").append('<option  selected="selected" value='+text.body.resultList[i].id+'>'+text.body.resultList[i].companyName+'</option>');
				 	 };
	        		
	        	}
	        	
	        }else{
	        	for(var i=0;i<text.body.resultList.length;i++){
	        	
				$("#selectqx-new").append("<option value='"+text.body.resultList[i].id+"'>"+text.body.resultList[i].companyName+"</option>");
	        }
	     }
  }
  

/* -----------------	厨具单位 新增保存		--------------------- */
	    $("#addFormSubmit").click(function () {
	    	$("#addFormSubmit").attr("disabled",true);
	    	$("#table2").find(".text_ts").remove();
	     	$("#table2").find(".text_ts1").remove();
	    	$("#table2").find(".text_ts2").remove();
	    	$("#table2").find(".text_ts3").remove(); 
	    	/* $("#kitchen-name4").siblings(".text_ts4").remove();
	    	$("#kitchen-address4").siblings(".text_ts4").remove();
	    	$("#kitchen-contactPerson4").siblings(".text_ts4").remove();
	    	$("#kitchen-phoneNum4").siblings(".text_ts4").remove();
	    	   */
	    	   var id5=$("#id4").val();
	    	   var name5=$("#kitchen-name4").val();
	    	   var address5=$("#kitchen-address4").val();
	    	   var contactPerson5=$("#kitchen-contactPerson4").val();
	    	   var phoneNum5=$("#kitchen-phoneNum4").val();
	    	   
	    	   
	    	   
	    	    param.id=id5;
	    		param.name=name5;
	    		param.address=address5;
	    		param.contactPerson=contactPerson5;
	    		param.phoneNum=phoneNum5;
	    		 var ajaxFig=true;
 		    	
		    		//$(".text_ts").remove();
		    		
		    		 $("body input[type='text']").each(function(){
		    			 $(this).next(".text_ts4").remove();
		    		    var inputValue=	$(this).val();
		    		    if(checkSpecificKey(inputValue)==false){
		    		    	$(this).after('<span class="text_ts4">请勿入特殊字符 </span>');
		    		    	$("#addFormSubmit").attr("disabled",false);
		    		    	ajaxFig=false;
		    		    	return false;
		    		    }
		    		});
		    		
		    		if(ajaxFig==false){
		    			return false;
		    		} 
	    		
		    	
	    
	    		  if(name5==""||name5==null){
  	    			$("#kitchen-name4").after('<span class="text_ts">单位名称不能为空 </span>');
  	    			$("#addFormSubmit").attr("disabled",false);
  	    			ajaxFlag=false;
  	    			return false;
  	    		} 
  	          
  	         
  	          if(address5==""||address5==null){
  	    			$("#kitchen-address4").after('<span class="text_ts1">单位地址不能为空 </span>');
  	    			$("#addFormSubmit").attr("disabled",false);
  	    			ajaxFlag=false;
  	    			return false;
  	    		}
  	        
  	   
  	          
  	    	  if(contactPerson5==""||contactPerson5==null){
  	    			$("#kitchen-contactPerson4").after('<span class="text_ts2">联系人不能为空 </span>');
  	    			$("#addFormSubmit").attr("disabled",false);
  	    			ajaxFlag=false;
  	    			return false;
  	    		}
  	    	
  	    	
  	    	
  	    
  			if((isMobilephone(phoneNum5))||(isPhone(phoneNum5))){
  				
  			}else{
 	    	  
  				 $("#kitchen-phoneNum4").after('<span class="text_ts3">请输入正确的电话号码</span>');  			
  				$("#addFormSubmit").attr("disabled",false);
  				 ajaxFlag=false;
  				return false;
  			}
 	    	  
  			
  			$("#loading").show();
  		
	        var options = {
	            url: "../restaurant/oilCleanComMgr/clean/createCleanWasteRecycleCom",
	            headers: { 
	                'Accept': 'application/json',
	                'Content-Type': 'application/json' 
	            },
	            type: 'post',
	            dataType: 'json',
	            data:JSON.stringify(param),
	            success: function (data) {
	                if (data.status == 0){
	                	var id=data.body;
	                console.log(id);
	              
	                alert("新增成功");
	                location.reload();
	                $("#unit-kitchen-new").hide();
	                $("#unit-kitchen-view").show(); 
	              
	                }else{
	                	console.log(data.message);
	                	$("#loading").hide();
	                	$("#unit-kitchen-view").show(); 
	                	
	                }
	                }
	            ,
	   		 error:function(text) {
	   		
	   			$("#loading").hide();
	   			$("#addFormSubmit").attr("disabled",false);
	   		 }
	        };
	        $.ajax(options);
	   	
	   	 $("#loading").show();
	        return false;
	    });
	
 
	    	 
/*  --------------------------------	油脂单位 新增保存		--------------------------------------- */
		    		    $("#addFormSubmit2").click(function () {
		    		    	$("#addFormSubmit2").attr("disabled",true);
		    		    	//$("#table2").find(".text_ts").remove();
		    		    	$("#table3").find(".text_ts").remove();
		    		     	$("#table3").find(".text_ts1").remove();
		    		    	$("#table3").find(".text_ts2").remove();
		    		    	$("#table3").find(".text_ts3").remove(); 
		    		    	/* $("#selectqx-new").siblings(".text_ts4").remove();
		    		    	$("#oil-address4").siblings(".text_ts4").remove();
		    		    	$("#oil-contactPerson4").siblings(".text_ts4").remove();
		    		    	$("#oil-phoneNum4").siblings(".text_ts4").remove(); */
		    		    	
		    		
		    		    	var id5=$("#id_4").val();
		    		    	   var name5=$("#selectqx-new").val();
		    		    	   var address5=$("#oil-address4").val();
		    		    	   var contactPerson5=$("#oil-contactPerson4").val();
		    		    	   var phoneNum5=$("#oil-phoneNum4").val();
		    		    	   
		    		    	   param2.id=id5;
		    		    		param2.oilCleanCompanyId=name5;
		    		    		param2.address=address5;
		    		    		param2.contactPerson=contactPerson5;
		    		    		param2.phoneNum=phoneNum5;
		    		    		 var ajaxFig=true;
				    		    	
			    		    		//$(".text_ts").remove();
			    		    		
			    		    		 $("body input[type='text']").each(function(){
			    		    			 $(this).next(".text_ts4").remove();
			    		    		    var inputValue=	$(this).val();
			    		    		    if(checkSpecificKey(inputValue)==false){
			    		    		    	$(this).after('<span class="text_ts4">请勿入特殊字符 </span>');
			    		    		    	$("#addFormSubmit2").attr("disabled",false);
			    		    		    	ajaxFig=false;
			    		    		    	return false;
			    		    		    }
			    		    		});
			    		    		
			    		    		if(ajaxFig==false){
			    		    			return false;
			    		    		} 
			    		    	
			    		    	 if(param2.oilCleanCompanyId==0000){
									
							$("#selectqx-new1").after('<span class="text_ts">单位名称不能为空</span>');
					// document.getElementById("eee").innerText="单位名称不能为空";
								
									// alert("单位名称不能为空");
									$("#addFormSubmit2").attr("disabled",false);
			    	  	    			ajaxFlag=false;
			    	  	    			return false;
							 }
			    		    		
		    		    	
		    		    		  
		    	  	          if(param2.address==""||param2.address==null){
		    	  	    			$("#oil-address4").after('<span class="text_ts1">单位地址不能为空 </span>');
		    	  	    			$("#addFormSubmit2").attr("disabled",false);
		    	  	    			ajaxFlag=false;
		    	  	    			return false;
		    	  	    		}
		    	  	      
		    	  	        
		    	  	          
		    	  	    	  if(param2.contactPerson==""||param2.contactPerson==null){
		    	  	    			$("#oil-contactPerson4").after('<span class="text_ts2">联系人不能为空 </span>');
		    	  	    			$("#addFormSubmit2").attr("disabled",false);
		    	  	    			ajaxFlag=false;
		    	  	    			return false;
		    	  	    		}
		    	  	    	
		    	  	  
		    	  	    	   
		    	  	    	if((isMobilephone(param2.phoneNum))||(isPhone(param2.phoneNum))){
		    	  				
		    	  			}else{
		    	 	    	  
		    	  				$("#oil-phoneNum4").after('<span class="text_ts3">请输入正确的电话号码</span>');  			
		    	  				$("#addFormSubmit2").attr("disabled",false);
		    	  				ajaxFlag=false;
		    	  				return false;
		    	  			}
		    	  	    	
		    	  	    	$("#loading").hide();
		    		        var options = {
		    		            url: "../restaurant/oilCleanComMgr/clean/createCleanOilRecycleCom",
		    		            headers: { 
		    		                'Accept': 'application/json',
		    		                'Content-Type': 'application/json' 
		    		            },
		    		            type: 'post',
		    		            dataType: 'json',
		    		            data:JSON.stringify(param2),
		    		            success: function (data) {
		    		            	if (data.status == 0){
		    		                	var idOil=data.body;
		    		                console.log(idOil);
		    		                alert("新增成功");
		    		                $("#loading").hide();
		    		                location.reload();
		    		                $("#unit-oil-new").hide();
		    		                $("#unit-oil-view").show(); 
		    		            	
		    		                
		    		                }else{
		    		               
		    		                	console.log(data.message);
		    		                	$("#addFormSubmit2").attr("disabled",false);
		    		                	$("#loading").hide();
		    		                	$("#unit-oil-view").show(); 
		    		                	$("#oil-edit").hide(); 
		    		                }
		    		                }
		    		            ,
		    		   		 error:function(text) {
		    		   		
		    		   			$("#loading").hide();
		    		   			
		    		   		 }
		    		        };
		    		        $.ajax(options);
		    		   	
		    		   	 $("#loading").show();
		    		        return false;
		    		    });
		    		
		    		    	 
		    		    
	    
	/*   ----------------------------	 页面载入时加载   	--------------------------- */
	    $(document).ready(function () {
	     $("body").on("blur","input[type='text']",function(){
		  	    	$(this).siblings(".text_ts4").remove();
		  			var inputValue=	$(this).val();
		  		    if(checkSpecificKey(inputValue)==false){
		  		    	$(this).after('<span class="text_ts4">请勿入特殊字符 </span>');
		  		    	
		  		    }
		  		});  
	    	 getView();	
	    	 
	    	 getView2();	
	    
	    	 selectTypeGeneral();
	    	 
	    	 $("#selectqx-edit").change(function(){
	    		 selectCompany();
		    		
		    	});
	    	 $("#selectqx-new").change(function(){
	    		 selectCompany2();
	    		
	    		 }); 
	  	    
	    	//厨具修改 保存
	    	   $("#btn-kitchen-save").click(function () {
	    		   /* $("#kitchen-name2").siblings(".text_ts4").remove();
	    		   $("#kitchen-address2").siblings(".text_ts4").remove();
	    		   $("#kitchen-contactPerson2").siblings(".text_ts4").remove();
	    		   $("#kitchen-phoneNum2").siblings(".text_ts4").remove(); */
	    		   
	    		    $("#table").find(".text_ts").remove();
	   	    		$("#table").find(".text_ts1").remove();
	   	    		$("#table").find(".text_ts2").remove();
	   	    		$("#table").find(".text_ts3").remove(); 
	    	    	 
	    	    	 	var id3=$("#id2").val();
	    	    		var name3=$("#kitchen-name2").val().trim();
	    	    		var address3=$("#kitchen-address2").val().trim();
	    	    		var contactPerson3=$("#kitchen-contactPerson2").val().trim();
	    	    		var phoneNum3 =$("#kitchen-phoneNum2").val().trim();
	    	    		

	    	    		pparam.id=id3;
	    	    		pparam.name=name3;
	    	    		pparam.address=address3;
	    	    		pparam.contactPerson=contactPerson3;
	    	    		pparam.phoneNum=phoneNum3;
	    	    	
	    	    		 var ajaxFig=true;
		    		    	
	    		    		//$(".text_ts").remove();
	    		    		
	    		    		 $("body input[type='text']").each(function(){
	    		    			 $(this).next(".text_ts4").remove();
	    		    		    var inputValue=	$(this).val();
	    		    		    if(checkSpecificKey(inputValue)==false){
	    		    		    	$(this).after('<span class="text_ts4">请勿入特殊字符 </span>');
	    		    		    	
	    		    		    	ajaxFig=false;
	    		    		    	return false;
	    		    		    }
	    		    		});
	    		    		
	    		    		if(ajaxFig==false){
	    		    			return false;
	    		    		} 
	    	          if(name3==""||name3==null){
	    	    			$("#kitchen-name2").after('<span class="text_ts">单位名称不能为空 </span>');
	    	    			ajaxFlag=false;
	    	    			return false;
	    	    		} 
	    	          
	    	         
	    	          if(address3==""||address3==null){
	    	    			$("#kitchen-address2").after('<span class="text_ts1">单位地址不能为空 </span>');
	    	    			ajaxFlag=false;
	    	    			return false;
	    	    		}
	    	      
	    	   
	    	          
	    	    	  if(contactPerson3==""||contactPerson3==null){
	    	    			$("#kitchen-contactPerson2").after('<span class="text_ts2">联系人不能为空 </span>');
	    	    			ajaxFlag=false;
	    	    			return false;
	    	    		}
	    	    	  
	    	    	 
	    	    	  	
	    	    	  if((isMobilephone(phoneNum3))||(isPhone(phoneNum3))){
	    	  				
	    	  			}else{
	    	 	    	  
	    	  				$("#kitchen-phoneNum2").after('<span class="text_ts3">请输入正确的电话号码</span>');  			
	    	  				 ajaxFlag=false;
	    	  				return false;
	    	  			}
	    	    	  
	    	    	 /*  if(!(isMobilephone(phoneNum3))){
	    	    		  $("#phoneNum2").after('<span class="text_ts">请输入正确的手机号码 </span>');    	
							ajaxFlag=false;
	    	  				return false;
	    	  			}
	    	  	     */
	    	    	   
	    	    	  $("#loading").show(); 
	    	    	
	    	    	$.ajax({
	    	    	    async : false,
	    	    	    cache : false,  
	    	    	    type:"post",
	    	    	    headers: {
	    	    	        'Accept': 'application/json',
	    	    	        'Content-Type': 'application/json' ,
	    	    	    },      
	    	    	    dataType : "json",
	    	    	    data:JSON.stringify(pparam),
	    	    	    url: "../restaurant/oilCleanComMgr/clean/updateCleanWasteRecycleCom",
	    	    		 
	    	    		 
	    	    		    error: function (e) {//请求失败处理函数
	    		    	    	console.log(e);
	    		    	     alert('请求失败');
	    		    	    },
	    		    	     success:function(){ //请求成功后处理函数。 
	    		    	    	 $("#loading").hide();
	    		    	   		 console.log(pparam);
	    		    	    	 id3=pparam.id;
	    		    	    	 alert("保存成功");

	    		    	    	
	    		    	    		 location.reload();
		    	            		

	    		    	    	  $("#unit-kitchen-editor").hide();
	    		    	          $("#unit-kitchen-view").show();
	    		    	          $("#kitchen-delete").hide();
	    		    			   $("#kitchen-edit").show();
	    		    			   
	    		    			 
	    		    			
	    		    	    	 
	    		    	     }
	    	    		});
	    	    	});    
	    	/* ------------------------------油脂修改保存 ------------------------------------*/
	    	   $("#btn-oil-save").click(function () {
	    		  /*  $("#selectqx-edit").siblings(".text_ts4").remove();
	    		   $("#oil-address2").siblings(".text_ts4").remove();
	    		   $("#oil-contactPerson2").siblings(".text_ts4").remove();
	    		   $("#oil-phoneNum2").siblings(".text_ts4").remove(); */
	    		    $("#table4").find(".text_ts").remove();
	   	    		$("#table4").find(".text_ts1").remove();
	   	    		$("#table4").find(".text_ts2").remove();
	   	    		$("#table4").find(".text_ts3").remove(); 
	   	    	
	    	    	 	var id_3=$("#id_2").val();
	    	    		var oilCleanCompanyId3=$("#selectqx-edit").val().trim();
	    	    		var address3=$("#oil-address2").val().trim();
	    	    		var contactPerson3=$("#oil-contactPerson2").val().trim();
	    	    		var phoneNum3 =$("#oil-phoneNum2").val().trim();
	    	    		
	    	    		
	    	    		pparam2.id=id_3;
	    	    		pparam2.oilCleanCompanyId=oilCleanCompanyId3;
	    	    		pparam2.address=address3;
	    	    		pparam2.contactPerson=contactPerson3;
	    	    		pparam2.phoneNum=phoneNum3;
	    	    		
	    	    		 var ajaxFig=true;
		    		    	
	    		    		//$(".text_ts").remove();
	    		    		
	    		    		  $("body input[type='text']").each(function(){
	    		    		    var inputValue=	$(this).val();
	    		    		    $(this).next(".text_ts4").remove();
	    		    		    if(checkSpecificKey(inputValue)==false){
	    		    		    	$(this).after('<span class="text_ts4">请勿入特殊字符 </span>');
	    		    		    	
	    		    		    	ajaxFig=false;
	    		    		    	return false;
	    		    		    }
	    		    		});
	    		    		
	    		    		if(ajaxFig==false){
	    		    			return false;
	    		    		} 
	    	     
	    	          if(pparam2.oilCleanCompanyId==""||pparam2.oilCleanCompanyId==null){
	    	    			$("#typeGeneral").after('<span class="text_ts">单位名称不能为空 </span>');
	    	    			ajaxFlag=false;
	    	    			return false;
	    	    		} 
	    	          
	    	         
	    	          if(pparam2.address==""||pparam2.address==null){
	    	    			$("#oil-address2").after('<span class="text_ts1">单位地址不能为空 </span>');
	    	    			ajaxFlag=false;
	    	    			return false;
	    	    		}
	    	      
	    	       
	    	          
	    	    	  if(pparam2.contactPerson==""||pparam2.contactPerson==null){
	    	    			$("#oil-contactPerson2").after('<span class="text_ts2">联系人不能为空 </span>');
	    	    			ajaxFlag=false;
	    	    			return false;
	    	    		}
	    	    	 
	    	    	 
	    	    	  if((isMobilephone(pparam2.phoneNum))||(isPhone(pparam2.phoneNum))){
	    	  				
	    	  			}else{
	    	 	    	  
	    	  				 $("#oil-phoneNum2").after('<span class="text_ts3">请输入正确的电话号码</span>');  			
	    	  				 ajaxFlag=false;
	    	  				return false;
	    	  			}
	    	    	
	    		    	
	    	    	  $("#loading").show(); 
	    		    
	    	    	console.log(pparam2);
	    	    	 $.ajax({
	    	    	    async : false,
	    	    	    cache : false,  
	    	    	    type:"post",
	    	    	    headers: {
	    	    	        'Accept': 'application/json',
	    	    	        'Content-Type': 'application/json' ,
	    	    	    },      
	    	    	    dataType : "json",
	    	    	    data:JSON.stringify(pparam2),
	    	    	    url: "../restaurant/oilCleanComMgr/clean/updateCleanOilRecycleCom",
	    	    		 
	    	    		 
	    	    		    error: function (e) {//请求失败处理函数
	    		    	    	console.log(e);
	    		    	     alert('请求失败');
	    		    	    },
	    		    	     success:function(){ //请求成功后处理函数。
	    		    	    	
	    		    	    	 $("#loading").hide();
	    		    	   		 console.log(pparam2);
	    		    	    	 id_3=pparam2.id;
	    		    	    
	    		    	 		alert("保存成功"); 
	    		    	 		 
	    		    	    		 location.reload();
	    		    	    		  $("#unit-oil-editor").hide();
		    		    	          $("#unit-oil-view").show();
		    		    	          $("#oil-delete").hide();
		    		    			   $("#oil-edit").show();
		    	            	
	    		    	    	
	    		    		}
	    	    		}); 
	    	    	
	    	    	});   
	    	    	
	    });  
	
});
	

	 
	/*-------jquery end-------*/

</script>
</head>
<body>
<div class="main_box">

 <!-------------------------------餐厨垃圾  ------------------------------------>   
 
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">回收单位管理</a> </h3>
          <h4 class="per_title"><span>餐厨垃圾回收单位</span>
              <div class="btn_opera" style="padding-top:0; top:-15px;" > 
                   <input type="button" class="btn_editor" value="编辑" id="kitchen-edit" style="display:none;"/>
                   <input type="button" class="btn_editor" value="删除" id="kitchen-delete"   rel="popup"  title="提示"  style="display:none;"/>                 
 			 </div>
          </h4>
          
         
          <div class="per_box">
               <div class="btn_recycle" id="btn-kitchen-recycel" >
                    <div class="photo_upload">
                    
                        <i class="i_upload_recycle"></i>
                        <em class="upload_small_text">添加餐厨垃圾<br/>回收单位</em>
                    </div>
               </div>
              
               
                <div id="unit-kitchen-new" style="display:none;">
                   <table class="info_mation" id=table2>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>单位名称</td>
                          <td><input type="text"  id="kitchen-name4"  class="input_code" value=""  maxlength="50"/></td>
						 </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>单位地址</td>
                           <td><input type="text"  id="kitchen-address4"  class="input_code" value=""  maxlength="100"/>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系人</td>
                           <td><input type="text"  id="kitchen-contactPerson4" class="input_code" value="" maxlength="20"/></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系电话</td>
                           <td><input type="text" id="kitchen-phoneNum4" class="input_code" value=""  maxlength="20"/></td>
                       </tr>
                   </table>
           
                   <p class="save_box">
                       <input type="button" class="btn_save" value="保存" id="addFormSubmit"/>
                       <input type="button" class="btn_save" value="取消" id="btn-kitchen-back" />
                   </p>
               </div>
               
               
               <div id="unit-kitchen-editor" style="display:none;">
                   <table class="info_mation" id="table">
                       <tr>
                           <td class="td_lf"><em class="star">*</em>单位名称</td>
                          <td><input type="text"  id="kitchen-name2"  class="input_code" value=""  maxlength="50"/></td>
						 </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>单位地址</td>
                           <td><input type="text"  id="kitchen-address2"  class="input_code" value="" maxlength="100"/>
                           <input type="text" id="id2" style="display:none"></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系人</td>
                           <td><input type="text"  id="kitchen-contactPerson2" class="input_code" value=""  maxlength="20"/></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系电话</td>
                           <td><input type="text" id="kitchen-phoneNum2" class="input_code" value=""  maxlength="20"/></td>
                       </tr>
                   </table>
                   <p class="save_box">
                       <input type="button" class="btn_save" value="保存" id="btn-kitchen-save"/>
                       <input type="button" class="btn_save" value="取消" id="btn-kitchen-cancel" />
                   </p>
               </div>
               
               
               
               <div id="unit-kitchen-view" style="display:none;">
                   <table class="info_mation" >
                       <tr>
                           <td class="td_lf" style="min-width:168px"><em class="star">*</em>单位名称</td>
                           <td id="kitchen-name"></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>单位地址</td>
                           <input type="text" id="id" style="display:none">
                           <td id="kitchen-address" ></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系人</td>
                           <td id="kitchen-contactPerson"></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系电话</td>
                           <td id="kitchen-phoneNum"></td>
                       </tr>
                   </table>
               </div>
          </div>
          
          
 <!----------------------   废弃油脂 ----------------------------------------> 
     
          <h4 class="per_title" ><span>废弃油脂回收单位</span>
              <div class="btn_opera" > 
                   <input type="button" class="btn_editor" value="编辑" id="oil-edit" style="display:none;"/>
                   <input type="button" class="btn_editor" value="删除" id="oil-delete"   rel="popup"  title="提示"  style="display:none;"/>                 
              </div>
          </h4>
          
          
          <div class="per_box">
               <div class="btn_recycle" id="btn-oil-recycel" >
                    <div class="photo_upload" >
                        <i class="i_upload_recycle"></i>
                        <em class="upload_small_text">添加废弃油脂<br/>回收单位</em>
                    </div>
               </div>
               
               <div id="unit-oil-new" style="display:none;">
                   <table class="info_mation" id="table3" >
                       <tr>
                           <td class="td_lf"><em class="star">*</em>单位名称</td>
                           <td>
                          <div id="selectqx-new1" class="select_s" style="float:left;">
                            <div class="select_is">
                               <select id="selectqx-new" class="select_cs" name="typeGeneral">
                                   <option value ="0000"> 请选择</option>
                                
                               </select>
                              
                             </div>
                          </div>
                           
                           </td>
                            <td id=""><span id="eee"></span></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>单位地址</td>
                           <td><input type="text"  id="oil-address4"  class="input_code" value=""  maxlength="100"/></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系人</td>
                           <td><input type="text"  id="oil-contactPerson4" class="input_code" value="" maxlength="20"/></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系电话</td>
                           <td><input type="text" id="oil-phoneNum4" class="input_code" value=""  maxlength="20"/></td>
                       </tr>
                   </table>
                   <p class="save_box">
                       <input type="button" class="btn_save" value="保存" id="addFormSubmit2"/>
                       <input type="button" class="btn_save" value="取消" id="btn-oil-back" />
                   </p>
               </div>
               
               
               <div id="unit-oil-editor" style="display:none;">
                   <table class="info_mation" id="table4">
                       <tr>
                           <td class="td_lf"><em class="star">*</em>单位名称</td>
                         	 <td >
                           <div class="select_s" style="float:left;">
                            <div class="select_is">
                               <select id="selectqx-edit" class="select_cs" name="typeGeneral">
                                </select>
                             </div>
                          </div>
                  
                       </td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>单位地址</td>
                           <td><input type="text"  id="oil-address2"  class="input_code" value=""  maxlength="100"/>
                      		<input type="text" id="id_2" style="display:none">
                      		</td>
                      </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系人</td>
                           <td><input type="text"  id="oil-contactPerson2" class="input_code" value=""  maxlength="20"/></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系电话</td>
                           <td><input type="text" id="oil-phoneNum2" class="input_code" value=""  maxlength="20"/></td>
                       </tr>
                   </table>
                   <p class="save_box">
                       <input type="button" class="btn_save" value="保存" id="btn-oil-save"/>
                       <input type="button" class="btn_save" value="取消" id="btn-oil-cancel" />
                   </p>
               </div>
               
               
                <div id="unit-oil-view" style="display:none;">
                   <table class="info_mation">
                       <tr>
                           <td class="td_lf" style="min-width:168px"><em class="star">*</em >单位名称</td>
                           <td id="oil-name"></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>单位地址</td>
                           <td id="oil-address"></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系人</td>
                           <td id="oil-contactPerson"></td>
                       </tr>
                       <tr>
                           <td class="td_lf"><em class="star">*</em>联系电话</td>
                           <td id="oil-phoneNum"></td>
                       </tr>
                   </table>
               </div>    
          </div>
     </div>
</div>
</body>
</html>