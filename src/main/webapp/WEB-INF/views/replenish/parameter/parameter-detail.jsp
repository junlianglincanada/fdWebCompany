<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%@ page session="false"%>
<%
String pageNum=request.getParameter("pageNum");
String fileName;
if(request.getParameter("fileName")!=null&&request.getParameter("fileName")!="null"&&request.getParameter("fileName")!=""){
	fileName=java.net.URLDecoder.decode(request.getParameter("fileName"), "UTF-8");
}else{
	fileName="";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
if("<%=pageNum%>"!=null&&"<%=pageNum%>"!=""&&"<%=pageNum%>"!="null"){
	   var pageNum=parseInt("<%=pageNum%>");
}else{
	   var pageNum=1;
}
var fileName="<%=fileName%>";
var totalPage;
var totalNum;
var pageSize=20;
var params = {};
var inputDateStart="";
var inputDateEnd="";
var materialName="";
var supplierName="";
function search(pageNum){
	$("#loading").show();
	params.fileName=fileName;
	params.inputDateStart=inputDateStart;
	params.inputDateEnd=inputDateEnd;
	params.materialName=materialName;
	params.supplierName=supplierName;
	$.ajax({
	url: "../inputManage/inputBatch/queryImportInputBatchDetail/"+pageNum+"/"+pageSize,
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
      			var $tr=$("<tr id="+id+"><td class='td_ser'>"+((pageNum-1)*pageSize+i+1)+"</td><td>"+inputDate+"</td><td >"+inputMatName+"</td><td>"+spec+"</td><td>"+manufacture+"</td><td>"+quantity+"</td><td>"+productionDate+"</td><td>"+productionBatch+"</td><td class='date'>"+guarantee+"</td><td>"+traceCode+"</td><td>"+supplierName+"</td></tr>");
				$tr.data("id",id);
				if(i%2==0){
					$tr.addClass("even");
				}
				$("#totalPage em").text(totalPage);
				$("#body").append($tr);
				$("#paging_num").val(pageNum);
		    }
			
		}
		else{
			alert("系统异常，查询失败！");
			$("#loading").hide();
		}
	 },   
	 error:function(text) {
		// alert("系统异常，查询失败！");
	 }
	});
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
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
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
		inputDateStart=$("#date_start").val().trim();
		inputDateEnd=$("#date_ends").val().trim();
		materialName =$("#materialName").val().trim();
		supplierName =$("#supplierName").val().trim();
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
	document.onkeydown = function(e) {
		//捕捉回车事件
		 var ev = (typeof event!= 'undefined') ? window.event : e;
		 if(ev.keyCode == 13 ) {
			 $(".btn_query").click(); 
		 }
		};
	    /*--日历--*/				   
	      $('#date_start').calendar({ minDate:calDateByDay(-32),maxDate:calDateByDay(10),onSetDate:function(){
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
});
</script>
</head>
<body>
<div class="main_box">
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="replenish.parameter.parameter">近期进货维护</a> > <a href="replenish.parameter.batch">按导入文件查看</a> > <a href="#"><%=fileName%></a></h3>
          <div class="query">
                <table class="query_table" style="min-width:890px;">
                  <tr>
                      <td class="td_lf">进货日期</td>
                      <td><input type="text" class="input_date" value="" placeholder="请选择日期" id="date_start" style="width: 72px" readonly /> - 
					  <input type="text" class="input_date" value=""  placeholder="请选择日期"id="date_ends"style="width: 72px" readonly /></td>
                      <td class="td_lf">供应商名称</td>
                      <td><input type="text" class="input_code" id="supplierName" placeholder="请输入供应商名称" maxlength="100" value="" /></td>
                       <td class="td_lf">产品名称</td>
                      <td><input type="text" class="input_code" id="materialName"style="width:168px;" placeholder="请输入产品名称" maxlength="50"  value="" /></td>
                 		<td><input type="button" class="btn_query" value="查询" style="margin-left:15px;width:100px;" /></td>
                  </tr>
               </table>
               <!-- <p class="query_btn"><input type="button" class="btn_query" value="查询" /></p> -->
          </div>
		<p class="gray">导入文件中一个月前的台账记录，不提供查看和删除功能。</p>
          <div class="table_box">
               <table class="table_list" style="min-width:890px;">
                    <thead>
                       <tr>
                           <th style="min-width:30px">序号</th>                                         
                           <th style="min-width:65px">进货日期</th>
                           <th style="min-width:70px">产品名称</th>
                           <th style="min-width:45px">规格</th>
                           <th style="min-width:148px">生产单位</th>
                           <th style="min-width:35px">数量</th>
                           <th style="min-width:65px">生产日期</th>
                           <th style="min-width:60px">批次号</th>
                           <th style="min-width:50px">保质期</th>
                           <th style="min-width:50px">追溯码</th>
                           <th style="min-width:148px">供应商名称</th>
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