<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<title>万达食品安全追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

</script>  
</head>
<body>
<div class="main_box">
<form id="addForm" action="../restaurant/cleanWasteComMgr/addWasteRecycleRecord" method="post" enctype="multipart/form-data">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/recycle.kitchen.kitchen">餐厨垃圾</a> > <a href="#">新增餐厨垃圾</a> </h3>
          <div class="info_box"> 
               <table class="info_mation" style="border-bottom:1px solid #dcdddd;">
                  <tr>
                       <td class="td_lf"><em class="star">*</em>台账日期</td>
                       <td><input type="text" class="input_date" id="recycleDate" name ="recycleDate"  readonly="readonly" /></td>               
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>回收单位</td>
                       <td id="name"></td>
                  </tr>
                  
                  <tr>
                       <td class="td_lf"><em class="star">*</em>数量</td>
                       <td><input id="amount" name="amount"type="text" class="input_code" value="" style="width:168px;" maxlength="9"  />桶
                       <input id="id" name="id" type="hidden" />
                       <input id="unit" name="unit" type="hidden" />
                       <input id="companyWasteRecycleId" name="companyWasteRecycleId" type="hidden" value="" /></td>
                  </tr>                
                  <tr>     
                       <td class="td_lf"><em class="star">*</em>回收人</td>
                       <td><input type="text" class="input_code"  value="" name = "recyclePerson"id="recyclePerson" style="width:168px;"  maxlength="20"/></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>单据图片</td>
                        <td id="certufucate">
                        <div class="" style="margin:0; height:auto;">
                          <div class="upload_thumib"  id="upload_thumib">
                           <div class="photo_upload" style="margin:0 auto;">
                              <i class="i_upload_small"></i>
                              <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                          </div>
                          <input name="WASTE_RECYCLE_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload" id="small_upload"/>
                     </div>
                     <div class="licen_img"  style="display:none;">
                          <div rel="img" style="border:1px dotted #ddd;" id="previewImg"><img src="../images/i_user.jpg" id="photoPath"/></div>
                          <a href="javascript:void(0)" class="del_img" title="删除"></a>
                     </div>
                        </div>
                       </td>
                  </tr>
                </table>
          </div>
          <p class="save_box">
             <input type="button" id="btn_save" class="btn_save" value="保存" />
             <input type="reset" id="reset" class="btn_save" value="返回" />
          </p>
          </div>
     </form>
</div>
<script type="text/javascript">


var id="<%=id %>";
var params={};
var length;
  
$("#loading").show();
	   function isnull(object){
			if(object==null||object==""||object=="null"){
				return true;
			}else{
				return false;
			}
		}
		function getObjectURL(file) {
			var url = null ; 
			if($.browser.safari){//Safari
			     alert("您的浏览器不支持图片预览功能，"+"请选择其它浏览器！");
				 obj.value="";
				 return false;
			}
			else{
			if (window.createObjectURL!=undefined) { // basic
				url = window.createObjectURL(file) ;
			} else if (window.URL!=undefined) { // mozilla(firefox)
				url = window.URL.createObjectURL(file) ;
			} else if (window.webkitURL!=undefined) { // webkit or chrome
				url = window.webkitURL.createObjectURL(file) ;
			}
			return url ;
		}}
		function isLience(object) {
			 var filter  = /^[a-zA-Z0-9]*$/;
			 if (filter.test(object)) 
				 return true;
			 else {
			 return false;
			 }
		}	   
		
	
$(function(){
	/* $('#recycleDate').calendar(); */
	 $('#recycleDate').calendar({ minDate:calDateByDay(-32), maxDate:calDateByDay(10)});
	//	$("#refresh").live("click",function(){
	//		$(".text_ts").remove();
	//	});
			 
		    // ajaxSubmit
		/*    $(".small_upload").change(function(){
			var objUrl = getObjectURL(this.files[0]) ;
			//console.log(objUrl);
			if (this.files &&this.files[0]){
				var picval = parseInt(this.files[0].size/1048576);
				if (picval >= 1){
					$(this).parent().after('<span class="text_ts">该图片大于1M, 上传图片建议小于1M </span>');
					this.value="";
					return ;
				}
			};
			//kankankan 	 
			//kankankan 	 
			if (objUrl){
				var htm='<input name="KITCHEN_RECYCLE_IMAGE" accept=".jpg,.png,.gif"  type="file" accept=".jpg,.png,.gif" multiple="true" class="small_upload" id="testimage" />';
				$("#in").append(htm);
				var html=' <div class="licen_img" ><div rel="img"><img src="'+objUrl+'" /></div><a  href="javascript:void(0)" class="del_img" title="删除"></a></div>';
				 $("#certufucate").append(html);
//				$("#certufucate").attr("src", objUrl) ;
//				$("#certufucate").parent().parent().show(); 
//				$(".upload_thumib").hide();
			   };
		   });
			//删除上传的预览图片 
			$(".licen_img .del_img").live("click",function(){
			       $(this).parent("div").find("img").attr("src","");
				   $(this).parent("div").hide(); 
				   $(this).parent().parent().find(".upload_thumib").show();
				   $(this).parent().parent().find("input:file").val("");
			}); */
			
			$("body").on("blur","input[id='amount']",function(){
	    		$(this).siblings(".text_ts").remove();
	    		var inputValue=	$(this).val();
	    	    if(checkSpecificKey(inputValue)==false){
	    	    	$("#id").after('<span class="text_ts">请勿输入特殊字符 </span>');
	    	    }
	    	}); 
			$("body").on("focus","input[id='amount']",function(){
				$(this).siblings(".text_ts").remove();
			}); 
			
	    	$("body").on("blur","input[id='recyclePerson']",function(){
	    		$(this).siblings(".text_ts").remove();
	    		var inputValue=	$(this).val();
	    	    if(checkSpecificKey(inputValue)==false){
	    	    	$("#recyclePerson").after('<span class="text_ts">请勿输入特殊字符 </span>');
	    	    }
	    	}); 	
	    	$("body").on("focus","input[id='recyclePerson']",function(){
				$(this).siblings(".text_ts").remove();
			}); 
			
			
		    $("#btn_save").live("click",function(){
		    	 $("#loading").show();
		    $("#btn_save").attr("disabled",true);
		    $("#reset").attr("disabled",true);
		    $("#companyWasteRecycleId").val(companyWasteRecycleId);
		    $(".info_mation").find(".text_ts").remove();
			var recycleDate=$("#recycleDate").val().trim();
// 			$("#companyWasteRecycleId").val(companyWasteRecycleId);
			var amount=$("#amount").val().trim();//数量					
			var recyclePerson=$("#recyclePerson").val().trim();//回收人
		/* 	$("body input[type='text']").not("#email").each(function(){
			    var inputValue=	$(this).val();
			    if(checkSpecificKey(inputValue)==false){
			    	$(this).after('<span class="text_ts">请勿输入特殊字符 </span>');
			    	return false;
			    }
			}); */
			if(recycleDate==""||recycleDate==null){
				$("#recycleDate").after('<span class="text_ts">请选择日期 </span>');
				$("#loading").hide();
				$("#btn_save").attr("disabled",false);
				 $("#reset").attr("disabled",false);
				return false;
			}
			if(amount==""||amount==null){
				
				$("#id").after('<span class="text_ts">数量不能为空 </span>');
				$("#loading").hide();
				$("#btn_save").attr("disabled",false);
				 $("#reset").attr("disabled",false);
				return false;
			}
			if(amount>999999.99){
				$("#id").after('<span class="text_ts">请输入正确的数量 </span>');
				$("#loading").hide();
				$("#btn_save").attr("disabled",false);
				 $("#reset").attr("disabled",false);
				return false;
			}
			 var str=amount;
			 var pattern =/^[0-9]+([.]\d{1,2})?$/;
			 if(!pattern.test(str)){
			     $("#id").after('<span class="text_ts">请输入正确格式的数字(例:2.22),最高保留两位小数 </span>');
				 $("#loading").hide();
				 $("#btn_save").attr("disabled",false);
				 $("#reset").attr("disabled",false);
			    return false;
			 }
			  if(checkSpecificKey(recyclePerson)==false){
			    	$("#recyclePerson").after('<span class="text_ts">请勿输入特殊字符 </span>');
			    	$("#loading").hide();
			    	$("#btn_save").attr("disabled",false);
					 $("#reset").attr("disabled",false);
			    	return false;
			    }			
			  if(recyclePerson==""||recyclePerson==null){
				
				$("#recyclePerson").after('<span class="text_ts">回收人姓名不能为空 </span>');
				$("#loading").hide();
				$("#btn_save").attr("disabled",false);
				 $("#reset").attr("disabled",false);
				return false;
			}
			
			/*   $("body").find("input:text").not("#email").on("keyup",function(){
					if(checkSpecificKey($(this).val())==false){
						 var v= $(this).val();
						v= v.replace(/[`~!@#$%^&*+<>?:{},.\/;[\]]/g,'');
						$(this).val(v);
					}  
				}); */
			
			
			// ajaxForm
			   //提交表单
		var options = {
		success: function (data) {
			 $("#loading").hide();
			if(data.status==0){
			    window.location.href="../findView/recycle.kitchen.kitchen"; 
			}else{
				alert("服务器异常,保存失败");
				
				$("#btn_save").attr("disabled",false);
				 $("#reset").attr("disabled",false);
			}
		}
		};
		$("#addForm").ajaxForm(options);
		$("#addForm").submit();
			/* $("#btn_save").click(function(){
				$("#addForm").ajaxForm(options);
				$("#addForm").submit();
			}); */
			});
		  
		});
		function previewImg(obj){
		  	if($.browser.msie){
		  		var ie=$.browser.version;
		  		if(ie=="11.0"||ie=="10.0"){
		  			if (obj.files &&obj.files[0]){
		  				var picval = parseInt(obj.files[0].size/1048576);
		  				if (picval >= 1){
		  					$(obj).parent().after('<span class="text_ts">'+obj.files[0].name +'  大于1M, 上传图片建议小于1M </span>');;
		  					obj.value="";
		  					return  ;
		  				};
		  			 } 
		  			var objUrl = getObjectURL(obj.files[0]) ;
		  			if (objUrl) {
		  				$(obj).parent().hide();
		  				var html=' <div class="photo_report" style="margin:0; height:auto;"><div class="upload_thumib"  id="upload_thumib"><div class="photo_upload" style="margin:0 auto;"><i class="i_upload_small"></i><em class="upload_small_text">上传图片<br/>建议小于1M</em></div><input name="WASTE_RECYCLE_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload" id="small_upload"/></div><div class="licen_img" id="licen_img" style="display:none;"><div rel="img" style="border:1px dotted #ddd;" id="previewImg"><img src="../images/i_user.jpg" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div></div>';
		  				$("#certufucate").append(html);
		  				$(obj).parent().parent().find("img").attr("src", objUrl) ;
		  				$(obj).parent().parent().find(".licen_img").show();
//		   				$(".upload_thumib").hide();
		  			};
		  		}else{
		  			alert("上传图片,目前暂不支持IE 9及以下版本");
		  			obj.value="";
		  			return;
		  		}
			}else{ 
				if (obj.files &&obj.files[0]){
					var picval = parseInt(obj.files[0].size/1048576);
					if (picval >= 1){
						$(obj).parent().after('<span class="text_ts">'+obj.files[0].name +'  大于1M, 上传图片建议小于1M </span>');;
						obj.value="";
						return  ;
					};
				 } 
				var objUrl = getObjectURL(obj.files[0]) ;
				console.log(objUrl);
				if (objUrl) {
					console.log("22");
					$(obj).parent().hide();
					var html='<div style="height:auto;margin-right:18px;"><div class="upload_thumib" ><div class="photo_upload" style="margin:0 auto;"><i class="i_upload_small"></i><em class="upload_small_text">上传图片<br/>建议小于1M</em></div><input name="WASTE_RECYCLE_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload" /></div><div class="licen_img"  style="display:none;"><div rel="img" style="border:1px dotted #ddd;" ><img src="../images/i_user.jpg" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div></div>';
					console.log(html);
					$("#certufucate").prepend(html);
					$(obj).parent().parent().find("img").attr("src", objUrl) ;
					$(obj).parent().parent().find(".licen_img").show();
		 			//$(".upload_thumib").hide();
				};
			} ;
		}
		//删除上传的预览图片 
		$(".licen_img .del_img").live("click",function(){
		       $(this).parent().parent().remove();
		});
		$("#reset").live("click",function(){
			window.location.href="../findView/recycle.kitchen.kitchen";
		});
		
		function uploadForm(){
			$(".text_ts").remove();

			var id=$("#id").val().trim();
			var amount=$("#amount").val().trim();//
			var unitValue=$("#unitValue").val().trim();//				
			var unit=$("#unit").val().trim();//
			var companyWasteRecycleId=$("#companyWasteRecycleId").val().trim();//
			var recyclePerson=$("#recyclePerson").val().trim();// 
			var recycleDate=$("#recycleDate").val().trim();
			$("body input[type='text']").not("#email").each(function(){
			    var inputValue=	$(this).val();
			    if(checkSpecificKey(inputValue)==false){
			    	$(this).after('<span class="text_ts">请勿输入特殊字符 </span>');
			    	return false;
			    }
			});
			// ajaxForm
			   //提交表单
			var options = {
			success: function (data) {
			 $("#loading").hide();
			 $("#btn_save").attr("disabled",false);
			 $("#reset").attr("disabled",false);
			if(data.status==0){
				queryCompany(id);
			    <%--  window.location.href="../findView/recycle.oil.oil";  --%>
			}else{
				alert("服务器异常,修改失败");
			}
			}
			};
			
			$("#btn_save").attr("disabled",true);
			 //$("#reset").attr("disabled",true);
			$("#loading").show();
			$("#addForm").ajaxForm(options);
			$("#addForm").submit();
			$("#test3").val("");
			};

	  $.ajax({
		  async : false,
		  cache : false,      type:"get",
		  headers: { 
		      'Accept': 'application/json',
		      'Content-Type': 'application/json' 
		  },      dataType : "json",

		  url: "../restaurant/oilCleanComMgr/listCompanyWasteRecycle",//请求的action路径
		  error: function (e) {//请求失败处理函数
		  	console.log(e);
		   alert('请求失败');
		  },
		   success:function(text){ //请求成功后处理函数。
			   console.log(text);
		  	 if(text.body==""||text.body==null){
		  		 alert("请在回收单位管理处添加回收单位");
		  		$(".btn_blue").click(function(){
        			location.href="../findView/recycle.unit.unit";
        		});
		  	 }
		  	 else{
		       console.log(text.body);
		       document.getElementById("name").innerHTML = text.body.name;
		       companyWasteRecycleId=text.body.id;
		       console.log(companyWasteRecycleId);
		      
		     
		  	 }
		  }
		  }); 
	  $("#loading").hide();
	 
		
	
	  
</script>
</body>    
</html>