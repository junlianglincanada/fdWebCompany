﻿<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>

<%

	  String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	    HttpSession Session = request.getSession();
	    Object pageNo=1;
	    Map<String, Object> paramMap=null;
	    
	    String inputDateEnd="";
	    String inputDateStart="";
	    String materialName="";
	    String supplierName="";
	    
	    if(newSearch.equals("")){
	    	pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
	    	paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
	    	if(null!=paramMap.get("inputDateStart")){
	    		inputDateStart=paramMap.get("inputDateStart").toString();
			}
	    	if(null!=paramMap.get("inputDateEnd")){
	    		inputDateEnd=paramMap.get("inputDateEnd").toString();
			}
	    	if(null!=paramMap.get("materialName")){
	    		materialName=paramMap.get("materialName").toString();
			}
	    	if(null!=paramMap.get("supplierName")){
	    		supplierName=paramMap.get("supplierName").toString();
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
#no_box{border-top:1px solid #dcdddd;}
</style>
<script type="text/javascript">

var totalPage;
var totalNum;
var pageSize=20;
var params = {};
var pageNum=parseInt("<%=pageNo%>");
var params = {"limitDate":"1","newSearch":"<%=newSearch%>"};

var inputDateStart="<%=inputDateStart%>";
var inputDateEnd="<%=inputDateEnd%>";
var inputDateStart=calDateByDay(-32);
params.inputDateStart=inputDateStart;
var materialName="<%=materialName%>";
var supplierName="<%=supplierName%>";
function search(pageNum){
	params.inputDateStart=inputDateStart;
	params.inputDateEnd=inputDateEnd;
	params.materialName=materialName;
	params.supplierName=supplierName;
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
	url: "../inputManage/inputBatch/queryInputBatchs/"+pageNum+"/"+pageSize,
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params),
	success:function(result) {
		$("#loading").hide();
		if(result.status==0){
			page(result);
			var resultList=result.body.resultList;
			if(resultList==null||resultList.length==0){
				$("#table_box").hide();
				$("#no_box").show();
			}else{
				$("#table_box").show();
				$("#no_box").hide();
			}
			$("#body").children().remove();
			for(var i=0;i<resultList.length;i++){
				var id=resultList[i].id;
				var inputDate=isNullForTable(resultList[i].inputDate);
				var inputMatName=isNullForTable(resultList[i].inputMatName);
				var spec=isNullForTable(resultList[i].spec);
				var manufacture=isNullForTable(resultList[i].manufacture);
				var quantity=isNullForTable(resultList[i].quantity);
				var productionDate=isNullForTable(resultList[i].productionDate);
				var productionBatch=isNullForTable(resultList[i].productionBatch);
				var guarantee=isNullForTable(resultList[i].guaranteeValue)+""+isNullForTable(resultList[i].guaranteeUnitString);
				var supplierName=isNullForTable(resultList[i].supplierName);
				var traceCode=isNullForTable(resultList[i].traceCode);
      			var $tr=$("<tr id="+id+"><td class='td_ser'>"+((pageNum-1)*pageSize+i+1)+"</td><td>"+inputDate+"</td><td >"+inputMatName+"</td><td>"+spec+"</td><td>"+manufacture+"</td><td>"+quantity+"</td><td>"+productionDate+"</td><td>"+productionBatch+"</td><td class='date'>"+guarantee+"</td><td>"+traceCode+"</td><td>"+supplierName+"</td><td class='td_opera'><a href='../findView/replenish.parameter.parameter-editor?id="+id+"&pageNum="+pageNum+"' class='btn_green'>编辑</a><a href='javascript:void(0)' class='btn_green' rel='popup' link='replenish.parameter.iframe-del?id="+id+"' title='提示'>删除</a></td></tr>");
				$tr.data("id",id);
				if(i%2==0){
					$tr.addClass("even");
				}
				$("#totalPage em").text(totalPage);
				$("#body").append($tr);
				$("#paging_num").val(pageNum);
				if(pageNum==1){
					$(".paging_head").addClass("disabled");
					$(".paging_head input").attr("disabled",true);
					$(".paging_perv").addClass("disabled");
					$(".paging_perv input").attr("disabled",true);
				}
				if(pageNum==totalPage){
					$(".paging_next").addClass("disabled");
					$(".paging_next input").attr("disabled",true);
					$(".paging_trailer").addClass("disabled");
					$(".paging_trailer input").attr("disabled",true);
				}
		    }
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
	$("#date_start").val(inputDateStart);
	$("#date_ends").val(inputDateEnd);
	$("#materialName").val(materialName);
	$("#supplierName").val(supplierName);
	
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
	
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
		if(pageNum==totalPage){
			params.newSearch="1";
			search(pageNum);
		}else{
			$(".paging_box a").removeClass("default");
			pageNum +=1;
			$("#page"+pageNum).addClass("default");
			params.newSearch="1";
			search(pageNum);
		}
	});
	$("#date_start").val(calDateByDay(-32));
	//点击查询按钮查询数据
	$(".btn_query").click(function(){
		inputDateStart=$("#date_start").val().trim();
		inputDateEnd=$("#date_ends").val().trim();
		materialName =$("#materialName").val().trim();
		supplierName =$("#supplierName").val().trim();
		pageNum=1;
		params.newSearch="1";
		search(pageNum);
	});
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
		
	});
	document.onkeydown = function(e) {
		//捕捉回车事件
		 var ev = (typeof event!= 'undefined') ? window.event : e;
		 if(ev.keyCode == 13 ) {
			 $(".btn_query").click(); 
		 }
		};
    /*--日历--*/				   
      $('#date_start').calendar({ minDate:calDateByDay(-33),maxDate:calDateByDay(10),onSetDate:function(){
  		var startDate=isnull(this.getDate('date'));
		var endDate=$('#date_ends').val();
		if(!compareTime(startDate,endDate)){
			$('#date_ends').val("");
		};
		if(startDate!=""){
			$('#date_ends').calendar({maxDate:calDateByDay(10),minDate:calDateByDay(-32), minDate:'#date_start'});
		}else{
			$('#date_ends').calendar({maxDate:calDateByDay(10),minDate:calDateByDay(-32)});
		}
    	
      }
      }); 
		$('#date_ends').calendar({ minDate:'#date_start',minDate:calDateByDay(-32),maxDate:calDateByDay(10) });
  	
    
	$(".btn_export").click(function(){
		$(".btn_export").attr("disabled","true");
		$.ajax({
			url: "../inputManage/inputBatch/queryInputBatchsExport",
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
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.parameter.parameter?newSearch=1">近期进货维护</a> 
               <div class="btn_opera" style="width:550px;"> 
               <!--  <a  href="javascript:void(0)" class="btn_export" style="width:180px;margin-left:20px">按照查询条件导出历史进货</a>  -->
                	
                   <input type="button" class="btn_batch" value="按导入文件查看" onClick="window.location.href='../findView/replenish.parameter.batch?newSearch=1'" />
            		<input type="button" class="btn_add btn_export" value="导出查询结果" /> 
              </div>
          </h3>
          <div class="query">
                <table class="query_table" style="min-width:890px;">
                  <tr>
                      <td class="td_lf" style="min-width:60px;">进货日期</td>
						<td><input type="text" class="input_date" value="" placeholder="请选择日期" id="date_start" style="width: 72px" readonly /> - 
						<input type="text" class="input_date" value=""  placeholder="请选择日期"id="date_ends"style="width: 72px" readonly /></td>
                      <td class="td_lf" style="min-width:70px;">供应商名称</td>
                      <td style="min-width:168px;"><input type="text" class="input_code" id="supplierName" placeholder="请输入供应商名称"  maxlength="100" value="" /></td>
                       <td class="td_lf" style="min-width:60px;">产品名称</td>
                      <td style="min-width:168px;"><input type="text" class="input_code" id="materialName" placeholder="请输入产品名称"  maxlength="50" style="width:168px;" value="" /></td>
                      <td style="min-width:60px;"><input type="button" class="btn_query" value="查询" /></td>
                  </tr>
               </table>
              
          </div>
            <div class="table_box" style="display: none;  height: 470px;" id="no_box">
               <div class="unit_no">
                    <i class="i_nofound"></i>
                    <p>近期内无进货台账，可进入“<a href="replenish.parameter.history?newSearch=1">历史进货查询</a>”查看更多</p>
               </div>
          </div>
          <div class="table_box" id="table_box">
               <table class="table_list" style="min-width:890px;">
                    <thead>
                       <tr>
                           <th style="min-width:30px">序号</th>                                         
                           <th style="min-width:65px">进货日期</th>
                           <th style="min-width:50px">产品名称</th>
                           <th style="min-width:45px">规格</th>
                           <th style="min-width:108px">生产单位</th>
                           <th style="min-width:35px">数量</th>
                           <th style="min-width:65px">生产日期</th>
                           <th style="min-width:60px">批次号</th>
                           <th style="min-width:40px">保质期</th>
                           <th style="min-width:50px">追溯码</th>
                           <th style="min-width:118px">供应商名称</th>
                           <th style="min-width:75px">操作</th>
                       </tr>
                    </thead>
                    <tbody id="body">                    
                    </tbody>
                 </table>
                <p class="paging_box">
                   <span  class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" ></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em>1</em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:30px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <input type="button" value="确定"  class="paging_btn" id="page_btn">
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>    	
</body>
</html>