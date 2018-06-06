<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<style type="text/css">
.query{border-bottom:1px solid #dcdddd; margin-bottom:15px;}
.query span{margin-right:12px;}
.query span input.input_date{width:100px;}
.query span input.input_code{width:140px;}
</style>
<script type="text/javascript">
var pageNum=1;
var params = {};
var pageSize=1;
var totalPage;

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
	$("#span_export").hide();
	$.ajax({
	url: "../statistics/outputBatch/getStatisticOfOutputBatchByReceiver/"+pageNum+"/"+pageSize,
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params),
	success:function(result) {
		console.log(result);
		$("#loading").hide();
		$("#span_export").show();
		if(result.status==0){
			page(result);
			var resultList=result.body.resultList;
			$("#tbody").children().remove();
			console.log(resultList);
			for(var i=0;i<resultList.length;i++){
				var outputDateStart=isnull(resultList[i].outputDateStart);
				var outputDateEnd=isnull(resultList[i].outputDateEnd);
												
				var outputMaterials=isnull(resultList[i].outputMaterials);
				var tr="";
				for(var j=0;j<outputMaterials.length;j++){					
					var outputMatName=isNullForTable(outputMaterials[j].OUTPUT_MAT_NAME);
					var num=isNullForTable(outputMaterials[j].num);
					var SPEC=isNullForTable(outputMaterials[j].SPEC);
					var MANUFACTURE=isNullForTable(outputMaterials[j].MANUFACTURE);
					var OUTPUT_MAT_ID=isNullForTable(outputMaterials[j].OUTPUT_MAT_ID);
					 tr=tr+"<tr><td>"+outputMatName+"</td><td>"+MANUFACTURE+"</td><td>"+SPEC+"</td><td>"+num+"</td></tr>";
				}
				var totalNum=isnull(resultList[i].totalNum);
				var receiverId=isnull(resultList[i].receiverId);
				var receiverName=isNullForTable(resultList[i].receiverName);
 		       // var $tr=$("<tr><td>"+inputMaterials+"</td><td>"+manufacture+"</td><td>"+spec+"</td><td>"+totalNum+"</td></tr>");					
 		        var $tr=$("<tr class='name even'><td colspan='4'>"+receiverName+"</td></tr>"+tr);
 		       $("#tbody").append($tr);
				
			};
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
		};
	 },   
	 error:function(text) {
	console.log(text.message);
	 }
	});
}
function huifu(){
	$(".btn_export").removeAttr("disabled");
}


$(function(){	 
	var outputDateStart=calDateByMonth(1);
	params.outputDateStart=outputDateStart;
	$('#date_start').val(outputDateStart);
	var today=calDateByMonth(0);
	$('#date_ends').val(today);
	params.outputDateEnd=today;
	 search(pageNum);
	//点击上一页查询
		$(".paging_perv").click(function(){
			if(pageNum==1){
				search(pageNum);
			}else{
				$(".paging_box a").removeClass("default");
				pageNum +=-1;
				$("#page"+pageNum).addClass("default");
				search(pageNum);
			}
		});
		//点击下一页查询
		$(".paging_next").click(function(){
			if(pageNum==totalPage){
				search(pageNum);
			}else{
				$(".paging_box a").removeClass("default");
				pageNum +=1;
				$("#page"+pageNum).addClass("default");
				search(pageNum);
			}
		});
		//点击查询按钮查询数据
		$(".btn_query").click(function(){
			receiverName=$("#receiverName").val().trim();
			outputMatName=$("#outputMatName").val().trim();
			outputDateStart=$("#date_start").val().trim();
			outputDateEnd=$("#date_ends").val().trim();
			var endTime=outputDateEnd.split("-");
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
		    outputDateEnd=clock;
			params.receiverName=receiverName;
			params.outputMatName=outputMatName;
			params.outputDateStart=outputDateStart;
			params.outputDateEnd=outputDateEnd;
			pageNum=1;
			search(pageNum);
			//$("#loading").hide();
		});
		//点击首页查询数据
		$(".paging_head").click(function(){
			pageNum=1;
			search(pageNum);
		});
		//点击尾页查询数据
		$(".paging_trailer").click(function(){
			pageNum=totalPage;
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
					search(pageNum);
				}else if(pageNum<1){
					pageNum=1;
					search(pageNum);
				}else  if(pageNum>totalPage){
					pageNum=totalPage;
					search(pageNum);
				}else{
					pageNum=parseInt(pageNum);
					search(pageNum);	
				}
			}
			
		});
		$(".btn_export").click(function(){
			$(".btn_export").attr("disabled","true");
			var receiverName=$("#receiverName").val().trim();
			var outputMatName=$("#outputMatName").val().trim();
			/* var outputDateStart=$("#date_start").val().trim();
			var outputDateEnd=$("#date_ends").val().trim(); */
			outputDateStart=$("#date_start").val().trim();
			outputDateEnd=$("#date_ends").val().trim();
			var endTime=outputDateEnd.split("-");
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
		    outputDateEnd=clock;
			var exportParam={};
			exportParam.receiverName=receiverName;
			exportParam.outputMatName=outputMatName;
			exportParam.outputDateEnd=outputDateEnd;
			exportParam.outputDateStart=outputDateStart;
			$.ajax({
				url: "../statistics/outputBatch/exportStatisticOfOutputBatchByReceiver",
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
					alert("系统异常，导出失败！");
					setTimeout('huifu()',10000);
				}
			});
		});
});
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/datastatis.delivery.goods">发货统计</a>
              <div class="btn_opera"> 
                    <span id="span_export"><a href="#" class="btn_export">导出统计表</a></span>
              </div>
          </h3>
          <div class="query">
               <span><em>发货日期：</em><input type="text" class="input_date" value="" id="date_start" readonly="readonly"/> - <input type="text" class="input_date"  value="" id="date_ends" readonly="readonly"/></span>
               <span><em>收货商名称：</em><input type="text" class="input_code" value="" id="receiverName"/></span>
               <span><em>产出品名称：</em><input type="text" class="input_code" value="" id="outputMatName"/></span>
               <input type="button" class="btn_query" value="统计" />
          </div>
          <div class="info_tab">
               <a href="#" class="default">按收货商统计</a>
               <a href="../findView/datastatis.delivery.output">按产出品统计</a>
          </div>
          <div class="table_box">
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
                    </tbody>
                 </table>
                  <p class="paging_box">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" id="pre_page"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" id="next_page" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em></em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <span id="page_btn"><input class="paging_btn" id="page_btn" type="button" value="确定" style="padding:3px 5px" ></span> 
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>    
	
<script type="text/javascript">
$(function(){
   /*--日历--*/				   		   
   var dateStartParam={onSetDate:function(){
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
	
</body>
</html>