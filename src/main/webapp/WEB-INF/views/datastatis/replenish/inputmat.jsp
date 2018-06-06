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
<script type="text/javascript">
var pageNum=1;
var params = {};
var pageSize=5;
var totalPage;
var startDate=calDateByMonth(-1);
var endDate=calDateByDay(0);
params.inputDateStart=startDate;
params.inputDateEnd=endDate;
function search(pageNum){
	$("#loading").show();
	$.ajax({
		url:"../statistics/inputBatch/getStatisticOfIBDByInputMaterial/"+pageNum+"/"+pageSize,
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
				var resultList=result.body.body;
				$("#tbody").children().remove();
				var totalRow=0;
				for(var i=0;i<resultList.length;i++){
					var matName = isNullForTable(resultList[i].matName);
					var count = isNullForTable(resultList[i].count);
					var manufacture = isNullForTable(resultList[i].manufacture);
					var spec = isNullForTable(resultList[i].spec);
					var intCompanyInfoList = isnull(resultList[i].intCompanyInfoList);
					var rows = intCompanyInfoList.length;
					totalRow+=rows;
					var $tr=$("<tr><td rowspan="+rows+">"+matName+"</td><td rowspan="+rows+">"+manufacture+"</td><td rowspan="+rows+">"+spec+"</td><td rowspan="+rows+">"+count+"</td><td>"+intCompanyInfoList[0].supplierName+"</td><td>"+intCompanyInfoList[0].quantity+"</td></tr>");
					if(i%2==0){
						$tr.addClass("even");
					}
					$("#tbody").append($tr);
					for(var j=1;j<intCompanyInfoList.length;j++){
						var suppliername=isNullForTable(intCompanyInfoList[j].supplierName);
						var quantity=isNullForTable(intCompanyInfoList[j].quantity);
						var $tr1=$("<tr><td>"+suppliername+"</td><td>"+quantity+"</td></tr>");
						if(j%2==0){
							$tr1.addClass("even");
						}
						$("#tbody").append($tr1);
					}
				}
				$("#totalMat").text(resultList.length);
				$("#totalRow").text(result.body.supCount);
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
	search(pageNum);
	$(".btn_query").click(function(){
		var startDate=$('#date_start').val().trim();
		var endDate=$('#date_ends').val().trim();
		var supplierName=$("#supplierName").val().trim();
		var inputMatName=$("#matName").val().trim();
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
		params.inputDateStart=startDate;
		params.inputDateEnd=endDate;
		params.supplierName=supplierName;
		params.inputMatName=inputMatName;
		pageNum=1;
		search(pageNum);
	});
	$(".btn_export").click(function(){
		$(".btn_export").attr("disabled","true");
		var startDate=$('#date_start').val();
		var endDate=$('#date_ends').val();
		var supplierName=$("#supplierName").val().trim();
		var inputMatName=$("#matName").val().trim();
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
	    var exportParams={};
	    exportParams.inputDateStart=startDate;
	    exportParams.inputDateEnd=endDate;
	    exportParams.supplierName=supplierName;
	    exportParams.inputMatName=inputMatName;
		$.ajax({
			url: "../statistics/inputBatch/exportStatisticOfIBDByInputMaterial",
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
	})
	
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
          <h3 class="process_title"><span>当前位置: </span><a href="#">进货统计</a>
              <div class="btn_opera"> 
                   <a href="#" class="btn_export">导出统计表</a>
              </div>
          </h3>
          <div class="query">
               <span><em>进货日期：</em><input type="text" class="input_date" value="" id="date_start" readonly="readonly" /> - <input type="text" class="input_date"  value="" id="date_ends" readonly="readonly" /></span>
               <span><em>供应商名称：</em><input type="text" class="input_code" value="" id="supplierName"/></span>
               <span><em>采购品名称：</em><input type="text" class="input_code" value="" id="matName"/></span>
               <input type="button" class="btn_query" value="统计" />
          </div>
          <p class="gray">统计结果可能与实际台账存在1天的误差。</p>
          <p>共<span id="totalRow">0</span>家供应商,共<span id="totalMat">0</span>种采购品</p>
          <div class="table_box">
               <table class="table_list">
                    <thead>
                       <tr>
                           <th>采购品名称</th>                                         
                           <th>生产企业</th>
                           <th>规格</th>
                           <th>进货总数</th>
                           <th>供应商</th>
                           <th>进货数</th>
                       </tr>
                    </thead>
                    <tbody id="tbody">
                              
                    </tbody>
                 </table>
                 <div class="clear"></div>
          </div>
     </div>
</div>
</body>
</html>