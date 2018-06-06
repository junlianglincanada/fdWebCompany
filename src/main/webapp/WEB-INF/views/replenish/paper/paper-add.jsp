<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    
    String id=request.getParameter("id");

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<link href="../js/calendar/calendar.min.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.upload_thumib{margin-right:15px;}
</style>
<script src="../js/calendar/calendar.min.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript">
var params={};
var datas=[];
//var id=suppilerId;
function isNull(object){
	if(object==null||object==""||object=="null"){
		return true;
	}else{
		return false;
	}
}

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


var ajFig=true;
$(function(){
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
       
		$(".info_mation").find(".text_ts").remove();
		
		var name=$("#name").val();//供应商名称
		var inputDate=$("#calendar").val().trim();
		if(isNull(name)==true||name=="选择供应商"){
			$("#name").after('<span class="text_ts">请输入供应商名称 </span>');
			$("#loading").hide();
			return false;
			 
		}
		if(isNull(inputDate)==true){
			$("#calendar").after('<span class="text_ts">请输入日期 </span>');
			 $("#loading").hide();
			return false;
			
		}
	    var options = {
		         success: function (data) {
		        	 console.log(data);
		        	 $("#loading").hide();
		         	if(data.status==0){        	
		         		//supplierId=data.id;
						//$("#supplierId").val(supplierId);		         
		         		//var suppilerId=data.body;
		         		window.location.href="../findView/replenish.paper.paper1";
		         	}else{
		         		alert("服务器异常,保存失败");
		         		$(":button").attr("disabled",false);
		         	}
		         
		         }
		         };
		// $(":button").attr("disabled",true);
		var cun= $("body input[type='file']").length;
		console.log(cun);
		if(cun >= 2){
			$("#addForm").ajaxForm(options);
			$("#addForm").submit();
		}else{
			alert("图片不能为空");
		}
	/* 	 $("body input[type='file']").each(function(){
			 if(this.value!=""){
					// ajaxForm
				   //提交表单
		    $("#addForm").ajaxForm(options);
			$("#addForm").submit();
			return false;
			 }
		 }); */
	});
	
});

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
  				var html=' <div style="margin:0; height:auto;"><div class="upload_thumib"  ><div class="photo_upload" style="margin:0 auto;"><i class="i_upload_small"></i><em class="upload_small_text">上传图片<br/>建议小于1M</em></div><input name="OINPUT_RECEIPT_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload"/></div><div class="licen_img"style="display:none;"><div rel="img" style="border:1px dotted #ddd;"><img src="../images/i_user.jpg" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div></div>';
  				$("#certufucate").prepend(html);
  				$(obj).parent().parent().find("img").attr("src", objUrl) ;
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
		if (objUrl) {
			console.log("22");
			$(obj).parent().hide();
			var html='<div style="height:auto;margin-right:8px;"><div class="upload_thumib" ><div class="photo_upload" style="margin:0 auto;"><i class="i_upload_small"></i><em class="upload_small_text">上传图片<br/>建议小于1M</em></div><input name="OINPUT_RECEIPT_IMAGE" accept=".jpg,.png,.gif" type="file" onchange="previewImg(this)" class="small_upload" /></div><div class="licen_img"  style="display:none;"><div rel="img" style="border:1px dotted #ddd;" ><img src="../images/i_user.jpg" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div></div>';
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
</script>
</head>
<body>
<div class="main_box">
<form id="addForm" action="../inputManage/inputReceipt/createInputReceipt" method="post" enctype="multipart/form-data">
<input type="text"  id="suppilerId"  name="suppilerId" style="display: none;" />
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.paper.paper1">票据管理</a> > <a href="../findView/replenish.paper.paper-add">新增票据</a> </h3>
          <div class="info_box">
               <table class="info_mation">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>供应商</td>
                       <td>
                           <div style=" height:27px; position:relative;">
                                 <input type="button" class="btn_shang"  id="name" style="margin-left:10px;" value="选择供应商" rel="popup" link="replenish.paper.iframe-name" title="选择供应商" />
                           </div>
                           
                       </td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>进货日期</td>
                       <td><input type="text" class="input_date" id="calendar" name="inputDate" value="" readonly="readonly" style="width:208px;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;" /></td>
                 	   <script type="text/javascript">
 						var mydateInput = document.getElementById("calendar");
						var date = new Date();
						var dateString = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
						mydateInput.value=dateString;
 					</script>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>票据图片</td>
                       <td id="certufucate">
                           <div >
                              <div class="upload_thumib" id="upload_thumib">
                                   <div class="photo_upload" style="margin:0 auto;">
                                        <i class="i_upload_small" ></i>
                                        <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                   </div>
                                   <input accept=".jpg,.png,.gif" type="file" name="OINPUT_RECEIPT_IMAGE" class="small_upload" id="small_upload" onchange="previewImg(this)"/>
                              </div>
                              <div class="licen_img" style="display:none;" >
                                   <div ><div rel="img" id="previewImg"><img src="../images/img_paper.jpg" id="photoPath"/>
                                   </div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                              </div>
                          </div>
                          
                       </td>
                  </tr>
                </table>
                <div class="clear"></div>
                <p class="save_box">
                  <input type="button" class="btn_save" value="保存" />
                </p>
               
          </div>
     </div>
     </form>
</div>     	
<script type="text/javascript">
$(function(){
   /*--日历多选--*/				   
  

/*-------jquery end-------*/
});	
</script>
</body>
</html>