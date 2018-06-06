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
<title>万达食品安全追溯系统</title>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.purchased.purchased"">采购品</a> > <a href="#">编辑采购品</a> > <a id="name1"></a> </h3>
          <div class="info_tab">
               <a href="../findView/replenish.purchased.purchased-editor?id=<%=id %>">基本信息</a>
               <a href="../findView/replenish.purchased.purchased-editor-photo?id=<%=id %>" class="default">图片信息</a>
          </div>
          <div class="info_box">
            <form id="uploadForm" action="../inputManage/inputMaterial/updateInputMaterialImage/<%=id %>" method="post" enctype="multipart/form-data"> 
            
                    <div class="photo_big">
                    <div class="big_con">
                         <h5 class="title">采购品图片</h5>
                               <div class="photo_purch">
                              <div class="bigimg_photo" id="bigimg_photo" style="display:none;">
                                  <div class="bigimg_photo_inner">
                                    <div class="photo_upload">
                                         <i class="i_upload_big"></i>
                                         <em class="upload_big_text">上传图片</em>
                                    </div>
                                    <input name="INPUTMAT_IMAGE" accept=".jpg,.png,.gif" type="file" class="big_upload" id="big_upload" onChange="javascript:uploadForm()" />
                                  </div>  
                              </div>     
                              <div class="bigimg_img" id="reportImg">
<!--                                    <div class="bigimg_imgcon" rel="img" style="overflow:hidden; position:relative;"> -->
<!--                                         <img src="" id="preview" style="margin:auto; position:absolute; top:0;left:0;bottom:0; right:0;" />  -->
<!--                                    </div> -->
<!--                                    <a href="javascript:void(0)" class="del_img" title="删除" id="big_del_img"></a> -->
                              </div>
                         </div>
<!--                          <div class="photo_purch" id="reportImg"> -->
<!--                          <img id="inputImage" src=""  rel="img" style="width:100%;"/> --> 
<!--                                <div class="bigimg_imgcon" rel="img" style="overflow:hidden; position:relative;"> -->
<!--                                         <img  id="inputImage" src="" style="margin:auto; position:absolute; top:0;left:0;bottom:0; right:0;" />  -->
<!--                                    </div> -->
<!--                          </div> -->
                    </div>
               </div>
                <div class="photo_small">
                    <div class="small_con">
                         <h5 class="title">检验检测报告</h5>
                         <div class="photo_report">
                              <div class="upload_thumib">
                                   <div class="photo_upload">
                                        <i class="i_upload_small"></i>
                                        <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                   </div>
                                   <input name="JY_JC_REPORT" type="file" accept=".jpg,.png,.gif" multiple="true" class="small_upload" id="test2" onChange="javascript:uploadForm()" />
                              </div>
                              <div class="upload_show">
                                   <div class="show_box">
                                        <div class="show_lf" style="display:none;"><a href="javascript:void(0)">左</a></div>
                                       <div id="jyjcreport" class="show_con">
                                        </div>
                                        <div class="show_rt" style="display:none;"><a href="javascript:void(0)">右</a></div>
                                   </div>
                              </div>
                         </div>
                    </div>
                    <div class="small_con" >
                         <h5 class="title">生产许可证</h5>
                         <div class="photo_licen">
                             <div class="upload_thumib">
                                   <div class="photo_upload">
                                        <i class="i_upload_small"></i>
                                        <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                   </div>
                               <input name="PRODUCTION_CERTUFUCATE" type="file" accept=".jpg,.png,.gif" multiple="true" class="small_upload" id="test3" onChange="javascript:uploadForm()" />
                          
                              </div>
                              <div class="upload_show" >
                                   <div class="show_box">
                                        <div class="show_lf" style="display:none;"><a href="javascript:void(0)">左</a></div>
                                          <div id="certufucate" class="show_con">
                                  
                                        </div>
                                        <div class="show_rt" style="display:none;"><a href="javascript:void(0)">右</a></div>
                                   </div>
                              </div>
                           </div>   
                     </div>
               </div>
          
               <div class="clear"></div>
               <p class="save_box">
                  <input type="button" class="btn_save" value="保存" />
               </p>
               <div class="clear"></div>
                    </form>
          </div>
     </div>
</div>    
 <script type="text/javascript"> 
//图片上传预览
// window.URL = window.URL || window.webkitURL;
// function SetBigPreview() {  
// 	var img_txt, Thumb = document.getElementById("bigimg_photo"),
// 		file_upload = document.getElementById("big_upload"),
// 		reportImg = document.getElementById("reportImg"),
// 		preview = document.getElementById("preview"),
// 		picture = file_upload.value; 
// 	var img = new Image();
	
// // 	if (!picture.match(/.jpg|.png|.gif/i)) return alert("图片格式不对"),
// // 	!1; 
	
// 	 if (file_upload.files && file_upload.files[0]){
// 	//  if(window.URL){ //File API
// 		  var picval = parseInt(file_upload.files[0].size/1048576);
// 		  if (picval > 1) return alert(file_upload.files[0].name + ",尺寸为：" + picval + "M," + " " + "上传图片建议小于1M"),
// 		  !1; 
// 		  preview.src = window.navigator.userAgent.indexOf("Chrome") >= 1 || window.navigator.userAgent.indexOf("Safari") >= 1 ? window.webkitURL.createObjectURL(file_upload.files[0]) : window.URL.createObjectURL(file_upload.files[0]);
// 		  img.src = preview.src;
// 		  Thumb.style.display = "none";
// 		  reportImg.style.display = "block";
		  
// 	  }else if(window.FileReader){ //opera用FileReader对象来处理
// 			var reader = new FileReader();
// 			reader.readAsDataURL(files[0]);
// 			reader.onload = function(e){
// 				var picvalOpera = parseInt(e.total/1048576);
// 				if (picvalOpera > 1) return alert(file_upload.files[0].name + ",尺寸为：" + picvalOpera + "M," + " " + "上传图片建议小于1M"),
// 				!1;
// 				img.src = this.result;
// 				preview.src = img.src;
// 			}	    
// 	 } else { //ie  
// 		  file_upload.select(),  
// 		  file_upload.blur(),  
// 		  img_txt = document.selection.createRange().text; 
// 		  document.selection.empty();
// 		  img.src = img_txt;
// 		  img.onload=function(){
// 			  var picvalIE = parseInt(img.fileSize/1048576);
// 			  if (picvalIE > 1) {
// 					   return alert(img_txt + ",尺寸为：" + picvalIE + "M," + " " + "上传图片建议小于1M"),!1;
// 					   Thumb.style.display = "block";
// 					   reportImg.style.display = "none"; 
// 			  } 
// 		  }
// 		  //preview.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='image',src='"+img_txt+"')";
// 		  preview.src = img.src;
// 		  Thumb.style.display = "none";
// 		  reportImg.style.display = "block";
// 	}  
// 	  uploadForm();
// }  

</script>

<script type="text/javascript">
var imageTypes=["INPUTMAT_IMAGE","JY_JC_REPORT","PRODUCTION_CERTUFUCATE"];
var restIdList=new Array;
var id=<%=id%>;
$(function(){
	//删除上传的预览图片 - 采购品
// 	$("#big_del_img").live("click",function(){
// 	       $(this).prev("div").find("img").attr("src","");
// 		   $("#reportImg").hide();
// 		   $("#bigimg_photo").show();  
// 	});
	search(id);
	$(".btn_save").click(function(){
	       location.href="../findView/replenish.purchased.purchased";
	});
});	

function search(id){
	$.ajax({
		url:"../inputManage/inputMaterial/getInputMaterialById/"+id,
		type:"get",
		headers:{},
		success:function(result){
			if(result.status==0){
				console.log(result.body);
				document.getElementById("name1").innerHTML = result.body.name;
			}
		},
	});	
 	$("#loading").show();
	console.log("!!!:"+imageTypes);
	$.ajax({
	url:"../inputManage/inputMaterial/queryInputMaterialImage/"+id,
	type:"post",
    headers: { 
    	  'X-CSRF-TOKEN': '${_csrf.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
    data:JSON.stringify(imageTypes),
	success:function(text) {
          console.log(text.body);
          if(text.status==0){
              show(text.body);
          }
      	$("#loading").hide();
	 },   
	 error:function(text) {
	 }
	});
}
 function show(result){
	 var inputImageList=result.INPUTMAT_IMAGE;
	 var jyjcrepportList=result.JY_JC_REPORT;
	 var roductionList=result.PRODUCTION_CERTUFUCATE;
	 $("#reportImg").children().remove();
	 if(null!=inputImageList&&inputImageList.length>0){
		 	 $("#bigimg_photo").hide();
// 		 $("#preview").attr("src",imgFilePath+inputImageList[0].filePath);
	 	    var path=imgFilePath+inputImageList[0].filePath;
	         var id=inputImageList[0].id;
	var html='<div class="bigimg_imgcon" rel="img" ><img src="'+path+'" style="margin:auto; position:absolute; top:0;left:0;bottom:0; right:0;" /></div><a href="javascript:void(0)" class="del_img" title="删除"  onclick="deleteImage('+id+')" id="big_del_img"></a>';
	$("#reportImg").append(html);
	 }else{
		   $("#bigimg_photo").show(); 
	 }
 
	 $("#jyjcreport").children().remove();
	 if(null!=jyjcrepportList&&jyjcrepportList.length>0){

		for(var i=0;i<jyjcrepportList.length;i++){
			var path=imgFilePath+jyjcrepportList[i].filePath;
			var id=jyjcrepportList[i].id;
			var html='<div class="report_img"><div rel="img"><img src="'+path+'" /></div><a  href="javascript:void(0)" onclick="deleteImage('+id+')" class="del_img" title="删除"></a></div>';
			$("#jyjcreport").append(html);
		}
		 report_Roll();
	 }
	 $("#certufucate").children().remove();
	 if(null!=roductionList&&roductionList.length>0){
	
			for(var i=0;i<roductionList.length;i++){
				var path=imgFilePath+roductionList[i].filePath;
				var id=roductionList[i].id;
				var html='<div class="licen_img" ><div rel="img"><img src="'+path+'" /></div><a  href="javascript:void(0)"   onclick="deleteImage('+id+')" class="del_img" title="删除"></a></div>';
				$("#certufucate").append(html);
			}
			 licen_Roll();
		 }
	
 }
//判断页面图片个数及宽度-检验检测报告		   
function report_Roll(){
	var $show_w = $(".photo_report .show_box").width();
	var $img_w  = $(".report_img").width();
	var $img_len = $(".report_img").length;
	var $con_w = ($img_w+18) * $img_len;
	$(".photo_report .show_con").width($con_w);
	//alert($img_w+18);
	if($con_w >= $show_w ){
	    $(".photo_report .show_rt").show();
		$(".photo_report .show_rt").click(function(){
				$(".photo_report .show_lf").show();								   
		        $(".report_img:first").remove().appendTo(".photo_report .show_con");
				$(".photo_report .show_lf").click(function(){
						$(".report_img:last").remove().prependTo(".photo_report .show_con");
				});
		});
	} else {
	    return false;
	}
};	

//生产许可证
function licen_Roll(){
	var $show_w = $(".photo_report .show_box").width();
	var $img_w  = $(".licen_img").width();
	var $img_len = $(".licen_img").length;
	var $con_w = ($img_w+18) * $img_len;
	$(".photo_licen .show_con").width($con_w);
	//alert($img_len);
	if($con_w >= $show_w ){
	    $(".photo_licen .show_rt").show();
		$(".photo_licen .show_rt").click(function(){
				$(".photo_licen .show_lf").show();								   
		        $(".licen_img:first").remove().appendTo(".photo_licen .show_con");
				$(".photo_licen .show_lf").click(function(){
						$(".licen_img:last").remove().prependTo(".photo_licen .show_con");
				});
		});
	} else {
	    return false;
	}
};	   

function uploadForm(){

 	$("#loading").show();
    //提交表单
    console.log("22222222")
    var options = {
    success: function (data) {
    	if(data.status==0){
    		search(id);
    	}else{
    		$("#loading").hide();
    	}
    }
    };
    // ajaxForm
    $("#uploadForm").ajaxForm(options);
    // ajaxSubmit
//         $("#uploadForm").ajaxSubmit(options);
      $("#uploadForm").submit();
     $("#big_upload").val("");
    $("#test2").val("");
    $("#test3").val("");


}
function deleteImage(attachId){
	restIdList.push(attachId);

	$.ajax({
		url:"../delAttachments",
		type:"post",
	    headers: { 
	    	  'X-CSRF-TOKEN': '${_csrf.token}',
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
	    data:JSON.stringify(restIdList),
		success:function(text) {
	          console.log(text.body);
	          if(text.status==0){
	        	  search(id);
	        	  
	          }
		 },   
		 error:function(text) {
			 
		 return false;
		 }
		});
}
</script>	
</body>
</html>