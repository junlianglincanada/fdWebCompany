<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
  <%@ include file="../../include.jsp" %>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/distribute.output.output">产出品</a> > <a href="#">查看产出品</a> </h3>
          <div class="info_tab">
               <a href="../findView/distribute.output.output-view?id=<%=id %>">基本信息</a>
               <a href="../findView/distribute.output.output-view-photo?id=<%=id %>" class="default">图片信息</a>
          </div>
          <div class="info_box">
               <div class="photo_big">
                    <div class="big_con">
                         <h5 class="title">产出品图片</h5>
                            <div class="photo_purch" id="reportImg">
<!--                               <img id="inputImage" src=""  rel="img" style="width:100%;"/> -->
                               <div class="bigimg_imgcon" rel="img" style="overflow:hidden; position:relative;">
                                        <img  id="outputImage" src="" style="margin:auto; position:absolute; top:0;left:0;bottom:0; right:0;" /> 
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
<!--                                              <div class="report_img" rel="img"><img src="../../images/img-xkz.jpg" /></div> -->
<!--                                              <div class="report_img" rel="img"><img src="../../images/img-xkz.jpg" /></div> -->
                                        </div>
                                        <div class="show_rt" style="display:none;"><a href="javascript:void(0)">右</a></div>
                                   </div>
                              </div>
                         </div>
                    </div>
                    <div class="small_con" style="margin-top:26px;">
                         <h5 class="title">生产许可证</h5>
                         <div class="photo_licen">
                              <div class="upload_show">
                                   <div class="show_box">
                                        <div class="show_lf" style="display:none;"><a href="javascript:void(0)">左</a></div>
                                        <div id="certufucate" class="show_con">
<!--                                              <div class="licen_img" rel="img"><img src="../../images/img-jcbg.jpg" /></div> -->
                             
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
 

<script type="text/javascript">
var imageTypes=["OUTPUTMAT_IMAGE","OUTPUTMAT_JY_JC_REPORT","OUTPUTMAT_PRODUCTION_CERTIFICATE"];
var id=<%=id%>;
$(function(){

search(id);
/*-------jquery end-------*/
});	
function search(id){
 	$("#loading").show();
	console.log("!!!:"+imageTypes);
	$.ajax({
	url:"../outputManage/outputMaterial/queryOutputMaterialImage/"+id,
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
	 var outputImage=result.OUTPUTMAT_IMAGE;
	 var jyjcrepportList=result.OUTPUTMAT_JY_JC_REPORT;
	 var roductionList=result.OUTPUTMAT_PRODUCTION_CERTIFICATE;
	 if(null!=outputImage&&outputImage.length>0){
		 console.log("path:"+outputImage[0].filePath)
		 $("#outputImage").attr("src",imgFilePath+outputImage[0].filePath);
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
		$(".photo_licen .show_box").css({"padding-left":"0px"});
	    return false;
	}
};	   
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
</script>		
</body>
</html>