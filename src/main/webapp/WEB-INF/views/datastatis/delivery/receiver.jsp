<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<style type="text/css">
.query{border-bottom:1px solid #dcdddd; margin-bottom:15px;}
.query span{margin-right:12px;}
.query span input.input_date{width:100px;}
.query span input.input_code{width:140px;}
</style>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" /> 
<script type="text/javascript">
var pageNum=1;
var params = {};
var pageSize=5;
var totalPage;
var receiverParams={};
var startDate=calDateByMonth(-1);
var endDate=calDateByDay(1);
params.inputDateStart=startDate;
params.inputDateEnd=endDate;
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
		url:"../statistics/outputBatch/getStatisticOfOBDByReceiver/"+pageNum+"/"+pageSize,
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
				var resultList=result.body.resultList;
				$("#main_box").show();
				if(resultList==null||resultList.length==0){
					$("#can").load("../findView/datastatis.replenish.replenish-no");
					$("#can").show();
					$("#main_box").hide();
				}else{
					$("#can").hide();
					$("#main_box").show();
					$("#tbody tr:gt(0)").remove();
					page(result);
					for(var i=0;i<resultList.length;i++){
						var matName = isNullForTable(resultList[i].matName);
						var count = isNullForTable(resultList[i].count);
						var manufacture = isNullForTable(resultList[i].manufacture);
						var spec = isNullForTable(resultList[i].spec);
						$("#companyName").text($("#receiverName").val().trim());
						var $tr=$("<tr><td>"+matName+"</td><td>"+manufacture+"</td><td>"+spec+"</td><td>"+count+"</td></tr>");
						if(i%2==0){
							$tr.addClass("even");
						}
						$("#tbody").append($tr);
					}
					$("#totalPage em").text(totalPage);
					$("#paging_num").val(pageNum);
					totalNum = result.body.totalRecord;
					$("#totalMat").text(totalNum);
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
			$("#loading").hide();
		},
		error:function(e){
			console.log(e);
		}
	});
}
function restore(){
	$(".btn_export").removeAttr("disabled");
}
$(function(){
	$("#date_start").val(calDateByMonth(-1));
	$("#date_ends").val(calDateByDay(0));
	$("#main_box").hide();
	$("#can").load("../findView/datastatis.delivery.init");
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
	//回车事件
	document.onkeydown= function(e){
		e = e ? e : event; 
		if(e.keyCode == 13){
			$(".btn_query").click();
	 	} 
	}
	$("#receiverName").focus(function(){
		receiverParams.type="RECEIVER";
		$.ajax({
			type:"post",
			headers: { 
		 		'Accept': 'application/json',
		 	 	'Content-Type': 'application/json' 
			},
			dataType:'json',
			data:JSON.stringify(receiverParams),
			url: "../inputManage/supplier/intCompanyByTime/"+pageNum+"/"+pageSize,
			success: function(data){
				$('#receiverName').bind("input.autocomplete", function(){
					$(this).trigger('keydown.autocomplete');
			   	});
				$("#receiverName").autocomplete(data.body.resultList,{
					minChars:0,
					width:208,
					max:10,
					cacheLength:1000,
					matchSubset:true,
					matchContains:true,
					autoFill:false,
					scroll:false,
					dataType:'json',
					
					formatItem:function(row, i, max){
						return row[1];
					},
					formatMatch: function(row, i, max){
						return row[1];
					},
					formatResult: function(row) {
						return row[1];
					}
				}).result(function(event,data,formatted){
					var receiverId=data.id;
					if(receiverId!=null&&receiverId!=""){
						$("#receiverId").text(receiverId);
						modelId=receiverId;
						receiverName=$("#receiverName").val().trim();
					}
				});
			},
			error: function(data) {
				alert("加载失败，请重试！");
			}
		});
		
	});
	$("#receiverName").on("keyup", function(){
		var keyWords = $("#receiverName").val().trim(); 
		receiverParams={'name':keyWords};
		$.ajax({
			type:"post",
			headers: { 
		 		'Accept': 'application/json',
		 	 	'Content-Type': 'application/json' 
			},
			dataType:'json',
			data:JSON.stringify(receiverParams),
			url: "../inputManage/receiver/queryReceiversByName/"+pageNum+"/"+pageSize,
			success: function(data){
				$('#receiverName').bind("input.autocomplete", function(){
					$(this).trigger('keydown.autocomplete');
			   	});
				$("#receiverName").autocomplete(data.body.resultList,{
					minChars:1,
					width:208,
					max:10,
					delay:0,
					cacheLength:1000,
					matchSubset:true,
					matchContains:true,
					autoFill:false,
					scroll:false,
					dataType:'json',
					
					formatItem:function(row, i, max){
						return row.name;
					},
					formatMatch: function(row, i, max){
						return row.name ;
					},
					formatResult: function(row) {
						return row.name;
					}
				}).result(function(event,data,formatted){
					var receiverId=data.id;
					if(receiverId!=null&&receiverId!=""){
						$("#receiverId").text(receiverId);
						modelId=receiverId;
						receiverName=$("#receiverName").val().trim();
					}
				});
			},
			error: function(data) {
				alert("加载失败，请重试！");
			}
		});
		
	});
	$(".btn_query").click(function(){
		var receiverId=isnull($("#receiverId").text());
		var receiverName=$("#receiverName").val().trim();
		var startDate=$('#date_start').val().trim();
		var endDate=$('#date_ends').val().trim();
		var outputMatName=$("#matName").val().trim();
		var endTime=endDate.split("-");
		var endYear=endTime[0];
		var endMonth=endTime[1];
		var endDay=endTime[2];
		var outputDateEndDetail=new Date(endYear,endMonth,endDay);
		outputDateEnd=new Date(outputDateEndDetail.getTime()+1000*3600*24);
		var year = outputDateEnd.getFullYear();       //年
	    var month = outputDateEnd.getMonth();     //月
	    var day = outputDateEnd.getDate();            //日
	    var clock = year + "-";
	    if(month < 10)
	        clock += "0";
	    clock += month + "-";
	    if(day < 10)
	        clock += "0";
	    clock += day;
	    endDate=clock;
		if(receiverId == ""){
			alert("请选择收货商！");
			return false;
		}
		params.receiverName=receiverName;
		params.outputMatName=outputMatName;
		params.outputDateStart=startDate;
		params.outputDateEnd=endDate;
		pageNum=1;
		search(pageNum);
	});
	$(".btn_export").click(function(){
		$(".btn_export").attr("disabled","true");
		var receiverId=isnull($("#receiverId").text());
		var receiverName=$("#receiverName").val().trim();
		var startDate=$('#date_start').val();
		var endDate=$('#date_ends').val();
		var outputMatName=$("#matName").val().trim();
		var endTime=endDate.split("-");
		var endYear=endTime[0];
		var endMonth=endTime[1];
		var endDay=endTime[2];
		var outputDateEndDetail=new Date(endYear,endMonth,endDay);
		outputDateEnd=new Date(outputDateEndDetail.getTime()+1000*3600*24);
		var year = outputDateEnd.getFullYear();       //年
	    var month = outputDateEnd.getMonth();     //月
	    var day = outputDateEnd.getDate();            //日
	    var clock = year + "-";
	    if(month < 10)
	        clock += "0";
	    clock += month + "-";
	    if(day < 10)
	        clock += "0";
	    clock += day;
	    endDate=clock;
		if(receiverId == ""){
			alert("请选择收货商！");
			return false;
		}
		var exportParams={};
		exportParams.receiverName=receiverName;
		exportParams.outputMatName=outputMatName;
		exportParams.outputDateStart=startDate;
		exportParams.outputDateEnd=endDate;
		$.ajax({
			url: "../statistics/outputBatch/exportStatisticOfOBDByReceiver",
			type:"post",
		    headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    dataType:'json',
			data:JSON.stringify(exportParams),
			success:function(result){
				window.location.href=imgFilePath+result.body;
				setTimeout('restore()',10000);
			},
			error:function(){
				alert("系统异常，导出失败！");
				setTimeout('restore()',10000);
			}
		});
	});
	/*--日历--*/				   		   
	var dateStartParam={btnBar:false,onSetDate:function(){
		$('#date_ends').calendar({minDate:'#date_start'});
		var startDate=this.getDate('date');
		var endDate=$('#date_ends').val();
		if(!compareTime(startDate,endDate)){
			$('#date_ends').val("");
		};
		var endTime=startDate.split("-");
		var year=parseInt(endTime[0])+1;
		var month=endTime[1];
		var day=endTime[2];
		var clock = year + "-";
	    if(month < 10)
	        clock += "0";
	    clock += month + "-";
	    if(day < 10)
	        clock += "0";
	    clock += day;
		$('#date_ends').calendar({minDate:'#date_start',maxDate:clock,btnBar:false});
	}};
	$('#date_start').calendar(dateStartParam);
	$('#date_ends').calendar({minDate:'#date_start',maxDate:calDateByDay(335),btnBar:false});

/*-------jquery end-------*/
});	
</script>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">发货对账</a>
              <div class="btn_opera"> 
                   <a href="#" class="btn_export">导出统计表</a>
              </div>
          </h3>
          <div class="query">
               <span><em>发货日期：</em><input type="text" class="input_date" value="" id="date_start" readonly="readonly"/> - <input type="text" class="input_date"  value="" id="date_ends" readonly="readonly"/></span>
               <span><em>收货商名称：</em><input type="text" class="input_code" value="" id="receiverName"/></span><span id="receiverId" style="display:none"></span>
               <span><em>产出品名称：</em><input type="text" class="input_code" value="" id="matName"/></span>
               <input type="button" class="btn_query" value="统计" />
          </div>
          <p class="gray">统计结果可能与实际台账存在1天的误差。</p>
          <div id="can"></div>
          <div class="table_box" id="main_box">
               <table class="table_list">
                    <thead>
                       <tr>                                     
                           <th>产出品名称</th>
                           <th>生产企业</th>
                           <th>规格</th>
                           <th>发货数量</th>
                       </tr>
                    </thead>
                    <tbody id="tbody">
                       <tr class="name">
                           <td colspan="4" id="companyName"></td>
                       </tr>                  
                    </tbody>
                 </table>
                 <p>共<span id="totalMat">0</span>种产出品</p>
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