<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
   String id1=request.getParameter("id");
  // String supplierId=request.getParameter("supplierId");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<link href="../js/calendar/calendar.min.css" rel="stylesheet" type="text/css" />
<script src="../js/calendar/calendar.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

function isNull(object){
	if(object==null||object==""||object=="null"){
		return true;
	}else{
		return false;
	}
}
//建立一個可存取到該file的url
function getObjectURL(file) {
	var url = null ; 
	if (window.createObjectURL!=undefined) { // basic
		url = window.createObjectURL(file) ;
	} else if (window.URL!=undefined) { // mozilla(firefox)
		url = window.URL.createObjectURL(file) ;
	} else if (window.webkitURL!=undefined) { // webkit or chrome
		url = window.webkitURL.createObjectURL(file) ;
	}
	return url ;
}

var id1="<%=id1 %>";
var restIdList=new Array;

var employee={};
var fileServer = "<%=fdWebFileURL%>";
var datas=[];	
//查询方法
 function queryImage(attachmentId){
	$("#loading").show();
	$(":button").attr("disabled",true);
	$.ajax({
		url:"../inputManage/inputReceipt/queryInputReceiptBySupperlierId/"+attachmentId,
		type:"get",
		dataType:"json",
		success:function(result){
			$(":button").attr("disabled",false);
			if(result.status==0){
				console.log(result);
	        	 employee=result.body;
				 var filePath=isnull(employee.filePath);
				 var inputDate=isnull(employee.inputDate);//数量
				 var name=isnull(employee.name);// 
				 var supplierId=isnull(employee.supplierId);
//				 var photoPath=isnull(employee.dtoAttachments.photoPath);//图片地址
				$("#id").val(id1);
				$("#calendar").val(inputDate);
				$("#name").val(name);
				$("#suppilerId").val(supplierId);
				
				$("#certufucate").children().remove();
				 if(filePath!=""){
					 filePath=fileServer+filePath;
					 console.log(filePath);
					 $(".licen_img").find("img").attr("src",filePath);
					 $(".licen_img").show();
                    //   var html=$('<div class="" style="height:auto;padding-left:30px;"><div class="licen_img"><div rel="img" id="previewImg"><img src='+filePath+' id="photoPath"/></div><a href="javascript:void(0)" onclick="deleteImage('+id1+')" class="del_img" title="删除"></a></div></div>');
							//var html='<div style="height:auto;margin-right:8px;"><div class="licen_img"  ><div rel="img" style="border:1px dotted #ddd;" ><img src="'+path+'" id="photoPath"/></div><a href="javascript:void(0)" onclick="deleteImage('+id+')" class="del_img" title="删除"></a></div></div>';
							/* 	$("#into").append(html); */
						
					 } 
			
					}
			$("#loading").hide();
				},
				error : function() {
					alert("系统异常,数据加载失败");
					$("#loading").hide();
				}
			});
		}

function previewImg(obj){
	$(".text_ts").remove();
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
  				var html=' <div><div class="upload_thumib"  ><div class="photo_upload" style="margin:0 auto;"><i class="i_upload_small"></i><em class="upload_small_text">上传图片<br/>建议小于1M</em></div><input name="OINPUT_RECEIPT_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload"/></div><div class="licen_img"style="display:none;"><div rel="img" style="border:1px dotted #ddd;"><img src="../images/i_user.jpg" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div></div>';
  				$("#into").prepend(html);
  				$(obj).parent().parent().find("img").attr("src", objUrl);
  				$(obj).parent().parent().find(".licen_img").show();
//   				$(".upload_thumib").hide();
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
			var html='<div><div class="upload_thumib" ><div class="photo_upload" style="margin:0 auto;"><i class="i_upload_small"></i><em class="upload_small_text">上传图片<br/>建议小于1M</em></div><input name="OINPUT_RECEIPT_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload" /></div><div class="licen_img"  style="display:none;"><div rel="img" style="border:1px dotted #ddd;" ><img src="../images/i_user.jpg" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div></div>';
			console.log(html);
			$("#into").prepend(html);
			$(obj).parent().parent().find("img").attr("src", objUrl) ;
			$(obj).parent().parent().find(".licen_img").show();
 			//$(".upload_thumib").hide();
		};
	} ;
}
//删除上传的预览图片 
/* $(".licen_img .del_img").live("click",function(){
    $(this).parent("div").find("img").attr("src","");
	   $(this).parent("div").hide(); 
	   $(this).parent().parent().find("input:file").val("");
});
 */


$(function(){
	queryImage(id1);
	<%-- $("#delectImg").click(function(){
		//deleteImageList(id1);
		window.location.href="../findView/replenish.iframe-del";
	}); --%>
	//console.log(attachmentId);
	 /*--日历多选--*/				   
	   $("#calendar").Calendar({
			time:false,  //是否显示时间节点					
			multiple:false, //是否多选
		   // range: ['2015-09-01', '2015-09-30'], //多选时间区域
			maxdays: 7,
			overdays: function(days) {
				alert('添加的日期已达 ' + days + ' 天上限');
			}
	  });
	 
	   $(".btn_save").live("click",function(){
		   var params={};
	        $(":button").attr("disabled",true);
			$(".info_mation").find(".text_ts").remove();
			
			if(null!=restIdList&&restIdList.length>0){
	    		deleteImageList(restIdList);
	    	}
			$(".info_mation").find(".text_ts").remove();
			$(".text_ts").remove();
			
			var inputDate=$("#calendar").val().trim();	
			//var name=$("#name").val().trim();
			var supplierId=$("#suppilerId").val();
			
		   //var certufucate=$("#input_date").val();
			
			params.id=id1;
			params.inputDate=inputDate;
			params.suppilerId=$("#suppilerId").val();
			//params.name=name;
			console.log(params);
			$.ajax({
				url:"../inputManage/inputReceipt/updateInputReceipt",
				type:"post",
				data:JSON.stringify(params),
				dataType:"json",
				headers: { 
			        'Accept': 'application/json',
			        'Content-Type': 'application/json' 
			    },
			    success:function(result){
			    	if(result.status==0){
				    	//alert("修改成功！");
				    	$("#loading").hide();
				    	window.location.href="../findView/replenish.paper.paper1";
			    	}else{
			    		alert("保存失败！");
			    	}
			    },
			    error:function(){
			    	$("#loading").hide();
			    	alert("系统异常，保存失败！");
			    }
			});
			
				   //提交表单
	        // var options = {
	        // success: function (data) {
	        //	 console.log(data);
	        //	 $("#loading").hide();
	        // 	if(data.status==0){
	        // 	     
	        // 	}else{
	         //		alert("服务器异常,保存失败");
	         //		$(":button").attr("disabled",false);
	         //	}
	        // 
	       //  }
	       //  };
		  //  $("#addForm").ajaxForm(options);
			//$("#addForm").submit();
			
		});
	
});

function deleteImageList(attachId){		
	restIdList=[];
 	restIdList.push(attachId);
 	$("#loading").show();
	$.ajax({
		url:"../inputManage/inputReceipt/delInputReceipt",
		type:"post",
	    headers: { 
	    	  'X-CSRF-TOKEN': '${_csrf.token}',
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
	    data:JSON.stringify(restIdList),
		success:function(text) {
			$("#loading").hide();
	          if(text.status==0){
	        	  window.location.href="../findView/replenish.paper.paper1";
	        	   $("#delectImg").parent("div").find("img").attr("src","");
	        	   $("#delectImg").parent("div").hide(); 
	        	   $("#delectImg").parent().parent().find("input:file").val("");
	          }
		 },   
		 error:function(text) {
			 $("#loading").hide();
		 return false;
		 }
		});
	
}
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.paper.paper1">票据管理</a> > <a href="#">编辑票据</a> </h3>
          <div class="info_box">
          <form id="addForm" action="../inputManage/inputReceipt/updateInputReceipt" method="post" enctype="multipart/form-data">
               <table class="info_mation">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>供应商</td>
                       <td>
                           <div style=" height:27px; position:relative;">
                                 <input type="button" class="btn_shang" name="name" id="name" style="min-width:190px;" value="" rel="popup" link="replenish.paper.iframe-name" title="选择供应商" />
                                 <input type="text" value="" id="suppilerId" style="display:none ;"/>
                           </div>
                       </td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>进货日期</td>
                       <td><input type="text" class="input_date" id="calendar" name="inputDate" value="" readonly="readonly" style="width:208px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden; z-index:10000" /></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>票据图片</td>
                       <td id="into">
                           <div >
                          <!--     <div class="upload_thumib">
                                   <div class="photo_upload" style="margin:0 auto;">
                                        <i class="i_upload_small"></i>
                                        <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                   </div>
                                   <input accept=".jpg,.png,.gif" type="file" class="small_upload" name="OINPUT_RECEIPT_IMAGE" onchange="previewImg(this)" id="small_upload" />
                              </div> -->
                              <div class="licen_img" style="height:120px;display: none;">
                                  <div rel="img" id="previewImg">
                                  <img src="" id="photoPath"/>
                                  </div>
                                  <!--  <a href="javascript:void(0)" class="del_img" title="删除" id="delectImg"></a>-->
                               </div>
                              </div>
                          </div>
                       </td>
                  </tr>
                </table>
                </form>
                <div class="clear"></div>
                <p class="save_box">
                   <input type="button" class="btn_save" value="保存" />
                   <input type="button" class="btn_dels" rel="popup" id="delectImg" link="../findView/replenish.paper.iframe-del?id=<%=id1%>" title="提示" value="删除票据"/>
                </p>
               
          </div>
     </div>
</div>    	
<script type="text/javascript">
$(function(){
   /*--日历多选--*/				   
   $("#calendar").Calendar({
		time:false,  //是否显示时间节点					
		multiple:false, //是否多选
	   // range: ['2015-09-01', '2015-09-30'], //多选时间区域
		maxdays: 7,
		overdays: function(days) {
			alert('添加的日期已达 ' + days + ' 天上限');
		}
  });

});	
</script>
</body>
</html>