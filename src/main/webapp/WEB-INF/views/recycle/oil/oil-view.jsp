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
<script type="text/javascript">
$(function(){
	   /*--到期日期--*/				   
	   $('#date_para').calendar();
	   

	   
	  
	/*-------jquery end-------*/
	});	
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/recycle.oil.oil?id=<%=id %>">废弃油脂</a> > <a href="#">查看废弃油脂</a> > <a id="name1"></a> 
          <div class="btn_opera"> 
          
               <input type="button" class="btn_add" id="btn_add" value="编辑" onClick="window.location.href='../findView/recycle.oil.oil-editor?id=<%=id %>'" />
          </div>
          </h3>
          <div class="info_box"> 
               <table class="info_mation" style="border-bottom:1px solid #dcdddd;">
                  <tr>
                       <td class="td_lf"><em class="star">*</em>台账日期</td>
                       <td id="recycleDate"></td>
                  </tr>
                  <tr>    
                       <td class="td_lf"><em class="star">*</em>种类</td>
                       <td id="typeValue"></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>数量</td>
                       <td id="amount"></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>回收单位</td>
                       <td id="name"></td>
                  </tr>
                  <tr>     
                       <td class="td_lf"><em class="star">*</em>回收人</td>
                       <td id="recyclePerson"></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>单据图片</td>
                       <td>
                         <div class="photo_licen">
                              <div class="upload_show" style="width:600px;">
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
          </div>
          <p class="save_box">
             <input type="button" class="btn_save" value="返回" onClick="window.location.href='../findView/recycle.oil.oil'" />
          </p>
     </div>
</div>
<script src="../js/bigimg.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function () {
	//回收单位
	$.ajax({
		url:"../restaurant/oilCleanComMgr/listCompanyOilRecycle",
	      headers: { 
              'Accept': 'application/json',
              'Content-Type': 'application/json' 
          },
		type: "get",
		data:"json",
		success:function(data){

			if(data.body==""){
				alert ("请添加废弃油脂回收单位");
			}else{
				employee=data.body;
				document.getElementById("name").innerHTML = employee.name;
				document.getElementById("name1").innerHTML = employee.name;
				var companyOilRecycleId=employee.id;
				$("#companyOilRecycleId").val(companyOilRecycleId);				
		};
		}
          }); 
});




var id="<%=id %>";
//查询方法
function queryCompany(id){
	$("#loading").show();
	$.ajax({
		url:"../recycle/cleanOilComMgr/getOilRecycleRecord/"+id,
		type:"get",
		dataType:"json",
		success:function(result){
			if(result.status==0){
				 var roductionList=result.body.dtoAttachments;
				 employee=result.body;
				 var amount=isnull(employee.amount);//数量
				 var unitValue=isnull(employee.unitValue);//
				 var unit=isnull(employee.unit);//
				 var typeValue=isnull(employee.typeValue);//类型
				 var oilCleanCompanyName=isnull(employee.oilCleanCompanyName);//ID
				 var recyclePerson=isnull(employee.recyclePerson);//回收人
				 var recycleDate=isnull(employee.recycleDate);//日期
					if(recycleDate!=""){
						var startDate=calDateByDay(-32);
						var endDate=calDateByDay(10);
						if(compareTime(recycleDate.substring(0,10),startDate)||compareTime(endDate,recycleDate.substring(0,10))){
							$("#btn_add").remove();
						}
					}
				 $("#amount").text(amount);
				 $("#unit").text(unit);
				 $("#oilCleanCompanyName").text(oilCleanCompanyName);
				 $("#typeValue").text(typeValue);
				 $("#recyclePerson").text(recyclePerson);
				 $("#recycleDate").text(recycleDate);
				 if(null!=roductionList&&roductionList.length>0){
						for(var i=0;i<roductionList.length;i++){
							var path=imgFilePath+roductionList[i].filePath;
							var html='<div class="licen_img" rel="img"><img src="'+path+'" /></div>';
							 $("#certufucate").append(html);
						}
						 licen_Roll();
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
$(function(){
	queryCompany(id);
	
});	
</script>
</body>
</html>