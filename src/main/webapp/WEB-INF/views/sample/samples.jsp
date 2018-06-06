<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%@ page session="false"%>
<% 
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String keyword="";
	String sampleMealType="";
	String sampleType="";
	String startDate="";
	String endDate="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null){
			if(null!=paramMap.get("keyword")){
				keyword=paramMap.get("keyword").toString();
			}
			if(null!=paramMap.get("sampleMealType")){
				sampleMealType=paramMap.get("sampleMealType").toString();
			}
			if(null!=paramMap.get("sampleType")){
				sampleType=paramMap.get("sampleType").toString();
			}
			if(null!=paramMap.get("startDate")){
				startDate=paramMap.get("startDate").toString();
			}
			if(null!=paramMap.get("endDate")){
				endDate=paramMap.get("endDate").toString();
			}
		}
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../include.jsp" %>
<style type="text/css">
.query span{margin-right:12px;}
.query span input.input_code{width:100px;}
.query span input.input_date{width:80px;}
.select_s{float:left;}
input.btn_green{ display:inline-block;font:12px/22px 'Simsun'; color:#fff; background:#BBBEB9; border-radius:4px; padding:0 7px; margin:0 3px;border: none;}
@-moz-document url-prefix(){input.btn_green{padding:0 5px;margin:1px;}}
</style>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
var pageSize=20;
var pageNum=parseInt("<%=pageNo%>");
var totalPage;
var params = {"newSearch":"<%=newSearch%>"};
var queryName="<%=keyword%>";
var sampleMealType="<%=sampleMealType%>";
var sampleType="<%=sampleType%>";
var startDate="<%=startDate%>";
var endDate="<%=endDate%>";
var sampleMeals={"":"","52001":"早餐","52002":"中餐","52003":"晚餐","52004":"其他"};
var sampleTypes={"":"","53001":"食堂","53002":"集体配送","53003":"重大活动","53004":"餐饮服务"};

String.prototype.trimcode=function() { return this.replace(/(^,*)|(,*$)/g, ""); }
function calDateByMonth(m){ 
    var now = new Date();
    var date=new Date(now.getTime()-1000*60*60*24*30*m);
    var year = date.getFullYear();       //年
    var month = date.getMonth() + 1;     //月
    var day = date.getDate();            //日
    var clock = year + "-";
    if(month < 10)
        clock += "0";
    clock += month + "-";
    if(day < 10)
        clock += "0";
    clock += day;
    return(clock); 
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
function search(pageNum){
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
		url:"../retentionSample/querySamples/"+pageNum+"/"+pageSize,
		type:"post",
		data:JSON.stringify(params),
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
		success:function(result){
			if(result.status==0){
				console.log(result.body);
				page(result);
				$("#mainTable").children().remove();
				var	totalNum=result.body.totalRecord;
				var samples=result.body.resultList;
				for(var i=0;i<samples.length;i++){
					var id=samples[i].id;
					var row=(pageNum-1)*pageSize+i+1;
					var sampleDate=isNullForTable(samples[i].sampleDate);
					var sampleMeal=sampleMeals[isnull(samples[i].sampleMeal)];
					var sampleType=sampleTypes[isnull(samples[i].sampleType)];
					var sampleNameList=samples[i].sampleNameList;
					var sampleName="";
					for(var j=0;j<sampleNameList.length;j++){
						sampleName=sampleName+sampleNameList[j]+",";
					}
					sampleName=sampleName.trimcode();
					var sampleDescription=isNullForTable(samples[i].sampleDescription);
					var content='<tr>';
					content+='<td class="td_ser">'+row+'</td>';
					content+='<td>'+sampleDate+'</td>';  
					content+='<td>'+sampleMeal+'</td>';
					content+='<td>'+sampleType+'</td>';
					content+='<td>'+sampleName+'</td>';
					content+='<td style="word-wrap:break-word">'+sampleDescription+'</td>';
					content+='<td class="td_opera">';
					content+='<a href="sample.samples-view?id='+id+'" class="btn_green">查看</a>';
					content+='<a href="sample.samples-editor?id='+id+'" class="btn_green">编辑</a>';
					content+='<a href="javascript:void(0)" class="btn_green" rel="popup" link="sample.iframe-del?id='+id+'" title="提示">删除</a>';
					content+='</td></tr>';
					var $tr=$(content);
					if(sampleDate!=""){
						var startDate=calDateByDay(-32);
						var endDate=calDateByDay(10);
						if(compareTime(sampleDate.substring(0,10),startDate)||compareTime(endDate,sampleDate.substring(0,10))){
							$tr.find("a").remove();
							$tr.find(".td_opera").append("<a href='sample.samples-view?id="+id+"'  class='btn_green'>查看</a> <input type='button' class='btn_green' value='编辑' /> <input type='button' class='btn_green' value='删除'/>");
						}
					}
					if(i%2==0){
						$tr.addClass("even");
					}
					$("#mainTable").append($tr);
				}
				$("#totalPage em").text(totalPage);
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
			$("#loading").hide();
		},
		error:function(e){
			console.log(e);
		}
	});
}
function huifu(){
	$(".btn_export").removeAttr("disabled");
}
$(function(){
	$("#queryName").val(queryName);
	$("#date_start").val(startDate);
	$("#date_ends").val(endDate);
	$("#sampleMealType").val(sampleMealType);
	$("#sampleType").val(sampleType);
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
		var pageNo=$("#paging_num").val().trim();
		if(isNaN(pageNo)||pageNo==null||pageNo==""){
			return;
		}else{
			pageNum=parseInt($("#paging_num").val().trim());
			if(pageNum<1){
				pageNum=1;
				params.newSearch="1";
				search(pageNum);
			}else  if(pageNum>totalPage){
				pageNum=totalPage;
				params.newSearch="1";
				search(pageNum);
			}else{
				params.newSearch="1";
				search(pageNum);
			}
		}
	});
	//点击查询按钮查询数据
	$(".btn_query").click(function(){
		queryName=$("#queryName").val().trim();
		startDate=$("#date_start").val();
		endDate=$("#date_ends").val();
		sampleMealType=$("#sampleMealType").val();
		sampleType=$("#sampleType").val();
		params.keyword=queryName;
		params.sampleMealType=sampleMealType;
		params.sampleType=sampleType;
		params.startDate=startDate;
		params.endDate=endDate;
		pageNum=1;
		params.newSearch="1";
		search(pageNum);
	});
	$(".btn_export").click(function(){
		$(".btn_export").attr("disabled","true");
		var exportParam={};
		queryName=$("#queryName").val().trim();
		startDate=$("#date_start").val();
		endDate=$("#date_ends").val();
		sampleMealType=$("#sampleMealType").val();
		sampleType=$("#sampleType").val();
		exportParam.keyword=queryName;
		exportParam.sampleMealType=sampleMealType;
		exportParam.sampleType=sampleType;
		exportParam.startDate=startDate;
		exportParam.endDate=endDate;
		$.ajax({
			url: "../retentionSample/queryRetentionSamplesForExport",
			type:"post",
		    headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    dataType:'json',
			data:JSON.stringify(exportParam),
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
	//回车事件
	document.onkeydown= function(e){
		e = e ? e : event; 
		if(e.keyCode == 13){
			$(".btn_query").click();
	 	} 
	}
	/*--日历--*/				   		   
	var limitDate=calDateByMonth(6);
	var dateStartParam={minDate:limitDate,onSetDate:function(){
		$('#date_ends').calendar({minDate:'#date_start'});
		var startDate=this.getDate('date');
		var endDate=$('#date_ends').val();
		if(!compareTime(startDate,endDate)){
			$('#date_ends').val("");
		};
	}};
	$('#date_start').calendar(dateStartParam);
	$('#date_ends').calendar({minDate:'#date_start'});

/*-------jquery end-------*/
});	
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">留样登记</a>
              <div class="btn_opera"> 
                      <input type="button" class="btn_add" value="新增留样登记" onClick="window.location.href='../findView/sample.samples-add'" />
                      <input type="button" class="btn_add btn_export" value="导出查询结果" /> 
              </div>
          </h3>
          <div class="query">
               <span><em>留样样品名称：</em><input type="text" class="input_code" value="" id="queryName"/></span>
               <span><em>留样日期：</em><input type="text" class="input_date" value="" id="date_start" readonly="readonly"/> - <input type="text" class="input_date"  value="" id="date_ends" readonly="readonly"/></span>
               <span><em>留样类型：</em>
                     <div class="select_s" style="width:90px;">
                       <div class="select_is" style="width:90px;">
                         <select class="select_cs" style="width:110px; background-position:-108px -122px;" id="sampleType"> 
                                <option value="">全部</option>
                                <option value="53001">食堂</option>
                                <option value="53002">集体配送</option>
                                <option value="53003">重大活动</option>
                                <option value="53004">餐饮服务</option>
                         </select>
                       </div>
                     </div>
               </span>
               <span><em>留样餐次：</em>
                     <div class="select_s" style="width:80px;">
                       <div class="select_is" style="width:80px;">
                         <select class="select_cs" style="width:100px; background-position:-118px -122px;" id="sampleMealType"> 
                                <option value="">全部</option>
                                <option value="52001">早餐</option>
                                <option value="52002">中餐</option>
                                <option value="52003">晚餐</option>
                                <option value="52004">其他</option>
                         </select>
                       </div>
                     </div>
               </span>
               <input type="button" class="btn_query" value="查询" />
          </div>
          <div class="table_box">
               <table class="table_list" style="table-layout:fixed;">
                    <thead>
                       <tr>
                           <th style="width:4%">序号</th>                                         
                           <th style="width:10%">留样时间</th>
                           <th style="width:10%">留样餐次</th>
                           <th style="width:10%">留样类型</th>
                           <th style="width:10%">留样样品</th>
                           <th style="width:25%">留样说明</th>
                           <th style="width:11%">操作</th>
                       </tr>
                    </thead>
                    <tbody id="mainTable">
                    </tbody>
                 </table>
                 <p class="paging_box">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" ></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em></em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <!-- <input id="page_btn" type="button" value="确定" class="btn_query" style="float:none;float: none;width: 40px;font-size: 12px;height: 28px;line-height: 28px;"> -->
                   <input type="button" class="paging_btn" value="确 定" id="page_btn"/>
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>    
</body>
</html>