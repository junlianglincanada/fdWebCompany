<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="../../include.jsp" %>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.purchased.purchased"">采购品</a> > <a href="#">查看采购品</a> > <a id="name1"></a> </h3>
          <div class="info_tab">
               <a href="../findView/replenish.purchased.purchased-view?id=<%=id %>"">基本信息</a>
                <a href="../findView/replenish.purchased.purchased-view-photo?id=<%=id %>"" class="default">图片信息</a>
                <a href="../findView/replenish.purchased.purchased-view-supplier?id=<%=id %>">供过货的供应商</a>
          </div>
          <div class="info_box">
               <div class="photo_big">
                    <div class="big_con">
                         <h5 class="title">采购品图片</h5>
                         <div class="photo_purch" id="reportImg">
<!--                               <img id="inputImage" src=""  rel="img" style="width:100%;"/> -->
                               <div class="bigimg_imgcon" rel="img" style="overflow:hidden; position:relative;">
                                        <img  id="inputImage" src="" style="margin:auto; position:absolute; top:0;left:0;bottom:0; right:0;" /> 
                                   </div>
                         </div>
                    </div>
               </div>
               <div class="photo_small">
                    <div class="small_con">
                         <h5 class="title">检验检测报告</h5>
                         <div class="photo_report">
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
                    <div class="small_con" style="margin-top:56px;">
                         <h5 class="title">生产许可证</h5>
                         <div class="photo_licen">
                              <div class="upload_show">
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
          </div>
     </div>
</div>    
 
<script src="../js/bigimg.js" type="text/javascript" charset="utf-8"></script>	
<script type="text/javascript">
 var imageTypes=new Array();
 imageTypes[0]="INPUTMAT_IMAGE";
 imageTypes[1]="JY_JC_REPORT";
 imageTypes[2]="PRODUCTION_CERTUFUCATE";
 var id=<%=id%>;
$(function(){

  
 	
/*-------jquery end-------*/

  search(id);
  


	
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
           	$("#loading").hide();
          }
	 },   
	 error:function(text) {
	 }
	});
}
 function show(result){
	 var inputImageList=result.INPUTMAT_IMAGE;
	 var jyjcrepportList=result.JY_JC_REPORT;
	 var roductionList=result.PRODUCTION_CERTUFUCATE;
	 if(null!=inputImageList&&inputImageList.length>0){
		 console.log("path:"+inputImageList[0].filePath)
		 $("#inputImage").attr("src",imgFilePath+inputImageList[0].filePath);
	 }else{
		 $("#reportImg").remove();
	 }
		 
	 if(null!=jyjcrepportList&&jyjcrepportList.length>0){
		for(var i=0;i<jyjcrepportList.length;i++){
			var path=imgFilePath+jyjcrepportList[i].filePath;
			var html='<div class="report_img" rel="img"><img src="'+path+'" /></div>';
			 $("#jyjcreport").append(html);
		}
		 report_Roll();
	 }
	 if(null!=roductionList&&roductionList.length>0){
			for(var i=0;i<roductionList.length;i++){
				var path=imgFilePath+roductionList[i].filePath;
				var html='<div class="licen_img" rel="img"><img src="'+path+'" /></div>';
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
			$(".photo_report .show_box").css({"padding-left":"0px"});
		    return false;
		}
	};	
	
	//生产许可证
	function licen_Roll(){
		var $show_w = $(".photo_licen .show_box").width();
		var $img_w  = $(".licen_img").width();
		var $img_len = $(".licen_img").length;
		var $con_w = ($img_w+18) * $img_len;
		$(".photo_licen .show_con").width($con_w);
// 		alert($img_len);
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
			$(".photo_licen .show_box").css({"padding-left":"0px"});
		    return false;
		}
	};	 
</script>		
</body>
</html>