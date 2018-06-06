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
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/recycle.kitchen.kitchen?id=<%=id%>">餐具垃圾</a> > <a href="../findView/recycle.kitchen.kitchen-view">查看餐具垃圾</a> > <a id="name1"></a> 
              <div class="btn_opera"> 
                  
                   <input type="button" class="btn_add" value="编辑" id="btn_add" onClick="window.location.href='../findView/recycle.kitchen.kitchen-editor?id=<%= id %>'" />
              </div>
          </h3>
            <div class="info_box">
               <table class="info_mation">
                    <tr>
                       <td class="td_lf"><em class="star">*</em>台账日期:</td>
						<td id=recycleDate></td>
					</tr>
                    <tr>
                       <td class="td_lf"><em class="star">*</em>回收单位:</td>
                       <td id="comRecycleName"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>数量:</td>
                       <td id="amount"></td>
                   </tr>                  
                    <tr>
                       <td class="td_lf"><em class="star">*</em>回收人:</td>
                       <td id="recyclePerson"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>单据照片:</td>
                      <td><div class="photo_licen">
                              <div class="upload_show">
                                   <div class="show_box">
                                        <div class="show_lf" style="display:none;"><a href="javascript:void(0)">左</a></div>
                                        <div id="certufucate" class="show_con">
                                  
                                        </div>
                                        <div class="show_rt" style="display:none;"><a href="javascript:void(0)">右</a></div>
                                   </div>
                              </div>
                         </div>
                       </td>
                   </tr>

               </table>
                </form>
               <p class="save_box">                
                   <input  type="button" class="btn_save" value="返回" onclick="javascript:window.location.href='../findView/recycle.kitchen.kitchen'"/> 
               </p>                                                       
               <div class="clear"></div>                             
          </div>
     </div>
</div>    
<script type="text/javascript">
var params={};
var id="<%=id%>";
$("#loading").show();

$(document).ready(function () {

	search(id);
});

function search(id){
	
	$.ajax({
	url:"../restaurant/cleanWasteComMgr/getWasteRecycleRecord/"+id,
	type:"get",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:null,
	success:function(text) {
          //console.log(text.body);
          if(text.status==0){
              show(text);
              $("#loading").hide();
          }
	 },   
	 error:function(text) {
	 }
	});
}

function show(text){
	var roductionList=text.body.dtoAttachments;     
	var recycleDate=isnull(text.body.recycleDate);
	if(recycleDate!=""){
		var startDate=calDateByDay(-32);
		var endDate=calDateByDay(10);
		if(compareTime(recycleDate.substring(0,10),startDate)||compareTime(endDate,recycleDate.substring(0,10))){
			$("#btn_add").remove();
		}
	}
	$("#recycleDate").text(text.body.recycleDate);
	$("#comRecycleName").text(text.body.comRecycleName);
	$("#name1").text(text.body.comRecycleName);
	$("#amount").text(text.body.amount);           //给td赋值默认的死text的格式
	$("#recyclePerson").text(text.body.recyclePerson); 
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
	var $show_w = $(".photo_licen .show_box").width();
	var $img_w  = $(".licen_img").width();
	var $img_len = $(".licen_img").length;
	var $con_w = ($img_w+18) * $img_len;
	$(".photo_licen .show_con").width($con_w);
//		alert($img_len);
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