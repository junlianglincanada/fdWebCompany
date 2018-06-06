﻿<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>

<%

	  String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	    HttpSession Session = request.getSession();
	    Object pageNo=1;
	    Map<String, Object> paramMap=null;
	    
	    String outputDateEnd="";
	    String outputDateStart="";
	    String materialName="";
	    String receiverName="";
	    
	    if(newSearch.equals("")){
	    	pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
	    	paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
	    	if(null!=paramMap.get("outputDateStart")){
	    		outputDateStart=paramMap.get("outputDateStart").toString();
			}
	    	if(null!=paramMap.get("outputDateEnd")){
	    		outputDateEnd=paramMap.get("outputDateEnd").toString();
			}
	    	if(null!=paramMap.get("materialName")){
	    		materialName=paramMap.get("materialName").toString();
			}
	    	if(null!=paramMap.get("receiverName")){
	    		receiverName=paramMap.get("receiverName").toString();
			}
	    }

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script src="../js/reAlert.js" type="text/javascript"></script>
<style type="text/css">
p.gray{border-top: 0px solid #dcdddd;padding: 3px 0;}
</style>
<script type="text/javascript">

var totalPage;
var totalNum;
var pageSize=20;
var params = {};
var pageNum=parseInt("<%=pageNo%>");
var params = {"newSearch":"<%=newSearch%>"};

var outputDateStart="<%=outputDateStart%>";
var outputDateEnd="<%=outputDateEnd%>";
var materialName="<%=materialName%>";
var receiverName="<%=receiverName%>";
function search(pageNum){
	params.outDateStart=outputDateStart;
	params.outDateEnd=outputDateEnd;
	params.materialName=materialName;
	params.receiverName=receiverName;
	$(".paging_head").removeClass("disabled");
	$(".paging_head input").attr("disabled",false);
	$(".paging_perv").removeClass("disabled");
	$(".paging_perv input").attr("disabled",false);
	$(".paging_next").removeClass("disabled");
	$(".paging_next input").attr("disabled",false);
	$(".paging_trailer").removeClass("disabled");
	$(".paging_trailer input").attr("disabled",false);
	$("#loading").show();
	$.ajax({
	url: "../outputManage/outputBatch/queryOutputBatchsData/"+pageNum+"/"+pageSize,
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params),
	success:function(result) {
		if(result.status==0){
			var resultList=result.body.resultList;
			if(resultList==null||resultList.length==0){
				$("#table_box").hide();
				$("#no_box").show();
			}else{
				$("#table_box").show();
				$("#no_box").hide();
			}


			var	totalNum=result.body.totalRecord;
			$("#body").children().remove();
			for(var i=0;i<resultList.length;i++){
				var id=resultList[i].id;
				var outputDate=isNullForTable(resultList[i].outputDate);
				var outputMatName=isNullForTable(resultList[i].outputMatName);
				var spec=isNullForTable(resultList[i].spec);
				var manufacture=isNullForTable(resultList[i].manufacture);
				var quantity=isNullForTable(resultList[i].quantity);
				var productionDate=isNullForTable(resultList[i].productionDate);
				var productionBatch=isNullForTable(resultList[i].productionBatch);
// 				var guarantee=isNullForTable(resultList[i].guaranteeValue)+""+isNullForTable(resultList[i].guaranteeUnitString);
				var guarantee="";
                if(resultList[i].guaranteeUnitString!="日"&&resultList[i].guaranteeUnitString!="月"&&resultList[i].guaranteeUnitString!="年"&resultList[i].guaranteeUnitString!="小时"){
                	  guarantee=isNullForTable(resultList[i].guaranteeUnitString);	
                }
				var receiverName=isNullForTable(resultList[i].receiverName);
      			var $tr=$("<tr id="+id+"><td class='td_ser'>"+((pageNum-1)*pageSize+i+1)+"</td><td>"+outputDate+"</td><td >"+outputMatName+"</td><td>"+spec+"</td><td>"+manufacture+"</td><td>"+quantity+"</td><td>"+productionDate+"</td><td>"+productionBatch+"</td><td class='date'>"+guarantee+"</td><td>"+receiverName+"</td></tr>");
				$tr.data("id",id);
				if(i%2==0){
					$tr.addClass("even");
				}
// 				$("#totalPage em").text(totalPage);
				$("#body").append($tr);
				$("#paging_num").val(pageNum);
				if(pageNum==1){
					$(".paging_head").addClass("disabled");
					$(".paging_head input").attr("disabled",true);
					$(".paging_perv").addClass("disabled");
					$(".paging_perv input").attr("disabled",true);
				}
				if(resultList.length<pageSize){
					$(".paging_next").addClass("disabled");
					$(".paging_next input").attr("disabled",true);
					$(".paging_trailer").addClass("disabled");
					$(".paging_trailer input").attr("disabled",true);
				}
		    }
			$("#loading").hide();
		}
	 },   
	 error:function(text) {
		// alert("系统异常，查询失败！");
	 }
	});
}

function huifu(){
	$(".btn_export").removeAttr("disabled");
}

function compareTime(a, b) {
    var arr = a.split("-");
    var starttime = new Date(arr[0], arr[1], arr[2]);
    var starttimes = starttime.getTime();

    var arrs = b.split("-");
    var lktime = new Date(arrs[0], arrs[1], arrs[2]);
    var lktimes = lktime.getTime();

    if (starttimes > lktimes) {
        return false;
    }
    else{
    	return true;
    }
}

$(function(){
	$("#date_start").val(outputDateStart);
	$("#date_ends").val(outputDateEnd);
	$("#materialName").val(materialName);
	$("#receiverName").val(receiverName);
	
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
	 params.newSearch="1"; 
	search(pageNum);
	
	//点击上一页查询
	$(".paging_perv").click(function(){
		if(pageNum==1){
			params.newSearch="1";
			search(pageNum);
		}else{
			$(".paging_box a").removeClass("default");
			pageNum +=-1;
			$("#page"+pageNum).addClass("default");
			params.newSearch="1";
			search(pageNum);
		}
	});
	//点击下一页查询
	$(".paging_next").click(function(){
// 		if(pageNum==totalPage){
// 			params.newSearch="1";
// 			search(pageNum);
// 		}else{
			$(".paging_box a").removeClass("default");
			pageNum +=1;
			$("#page"+pageNum).addClass("default");
			params.newSearch="1";
			search(pageNum);
// 		}
	});
	 //点击查询按钮查询数据
	$(".btn_query").click(function(){
		outputDateStart=$("#date_start").val().trim();
		outputDateEnd=$("#date_ends").val().trim();
		materialName =$("#materialName").val().trim();
		receiverName =$("#receiverName").val().trim();
		pageNum=1;
		params.newSearch="1";
		search(pageNum);
		//$("#loading").hide();
	});
	/*
	//点击首页查询数据
	$(".paging_head").click(function(){
		pageNum=1;
		params.newSearch="1";
		search(pageNum);
	});
	//点击尾页查询数据
	$(".paging_trailer").click(function(){
		pageNum=totalPage;
		params.newSearch="1";
		search(pageNum);
	});
	//点击确定查询数据
	$("#page_btn").click(function(){
		var pageNO=$("#paging_num").val().trim();
		if(isNaN(pageNO)){
			return;
		}else{
			pageNum=$("#paging_num").val().trim();
			if(pageNum==null||pageNum==""||pageNum=="null"){
				pageNum=1;
				params.newSearch="1";
				search(pageNum);
			}else if(pageNum<1){
				pageNum=1;
				params.newSearch="1";
				search(pageNum);
			}else  if(pageNum>totalPage){
				pageNum=totalPage;
				params.newSearch="1";
				search(pageNum);
			}else{
				pageNum=parseInt(pageNum);
				params.newSearch="1";
				search(pageNum);	
			}
		}
		
	}); */
	document.onkeydown = function(e) {
		//捕捉回车事件
		 var ev = (typeof event!= 'undefined') ? window.event : e;
		 if(ev.keyCode == 13 ) {
			 $(".btn_query").click(); 
		 }
		};
    /*--日历--*/				   
      $('#date_start').calendar({onSetDate:function(){
  		var startDate=isnull(this.getDate('date'));
		var endDate=$('#date_ends').val();
		if(!compareTime(startDate,endDate)){
			$('#date_ends').val("");
		};
			$('#date_ends').calendar({minDate:'#date_start'});
      }
      }); 
		$('#date_ends').calendar();
		
	$(".btn_export").click(function(){
		$(".btn_export").attr("disabled","true");
		$.ajax({
			url: "../outputManage/outputBatch/exportBatchDetailHistory",
			type:"post",
		    headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    dataType:'json',
			data:JSON.stringify(params),
			success:function(result){
				window.location.href=imgFilePath+result.body;
				 setTimeout('huifu()',10000);
				
			},
			error:function(){
				alert("结果异常，导出失败！");
				 setTimeout('huifu()',10000);
			}
		});
	});
	
    
});
</script>
</head>
<body>
<div class="main_box">
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.parameter.history">历史发货查询</a> 
               <div class="btn_opera" style="width:550px;"> 
            		<input type="button" class="btn_add btn_export" value="导出查询结果" /> 
              </div>
          </h3>
          <div class="query">
                <table class="query_table" style="min-width:890px;">
                  <tr>
                      <td class="td_lf" style="min-width:60px;">发货日期</td>
						<td><input type="text" class="input_date" value="" placeholder="请选择日期" id="date_start" style="width: 72px" readonly /> - 
						<input type="text" class="input_date" value=""  placeholder="请选择日期"id="date_ends"style="width: 72px" readonly /></td>
                      <td class="td_lf" style="min-width:70px;">收货商名称</td>
                      <td style="min-width:168px;"><input type="text" class="input_code" id="receiverName" placeholder="请输入收货商名称"  maxlength="100" value="" /></td>
                       <td class="td_lf" style="min-width:60px;">产品名称</td>
                      <td style="min-width:168px;"><input type="text" class="input_code" id="materialName" placeholder="请输入产品名称"  maxlength="50" style="width:168px;" value="" /></td>
                      <td style="min-width:60px;"><input type="button" class="btn_query" value="查询" /></td>
                  </tr>
               </table>
             <p class="gray">当前的台账查询结果可能与实际台账存在1天的误差。</p> 
          </div>
            <div class="table_box" style="display: none;  height: 470px;" id="no_box">
               <div class="unit_no">
                    <i class="i_nofound"></i>
                    <p>无发货台账</p>
               </div>
          </div>
          <div class="table_box" id="table_box">
               <table class="table_list" style="min-width:890px;">
                    <thead>
                       <tr>
                           <th style="min-width:30px">序号</th>                                         
                           <th style="min-width:65px">发货日期</th>
                           <th style="min-width:50px">产品名称</th>
                           <th style="min-width:45px">规格</th>
                           <th style="min-width:108px">生产单位</th>
                           <th style="min-width:35px">数量</th>
                           <th style="min-width:65px">生产日期</th>
                           <th style="min-width:60px">批次号</th>
                           <th style="min-width:40px">保质期</th>
                           <th style="min-width:118px">收货商名称</th>
                       </tr>
                    </thead>
                    <tbody id="body">                    
                    </tbody>
                 </table>
                <p class="paging_box">
<!--                    <span  class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span> -->
                   <span class="paging_perv"><input type="button" value="<< 上一页"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>"/></span>
<!--                    <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span> -->
<!--                    <span class="num_text" id="totalPage" >共<em>1</em>页</span>   -->
<!--                    <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:30px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span> -->
<!--                    <input type="button" value="确定"  class="paging_btn" id="page_btn"> -->
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>    	
</body>
</html>