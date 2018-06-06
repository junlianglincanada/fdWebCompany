<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>

<% 
String id=request.getParameter("id");
	String pageNum=request.getParameter("pageNum");
	String outputDate2;
	    if(request.getParameter("outputDate2")!=null&&request.getParameter("outputDate2")!="null"&&request.getParameter("outputDate2")!=""){
	    	outputDate2=request.getParameter("outputDate2");
	    }else{
	    	outputDate2="";
	    }
	String materialName2;
	    if(request.getParameter("materialName2")!=null&&request.getParameter("materialName2")!="null"&&request.getParameter("materialName2")!=""){
	  	  materialName2=java.net.URLDecoder.decode(request.getParameter("materialName2"), "UTF-8");
	    }else{
			materialName2="";
	    }
	String receiverName2;
	    if(request.getParameter("receiverName2")!=null&&request.getParameter("receiverName2")!="null"&&request.getParameter("receiverName2")!=""){
	    	receiverName2=java.net.URLDecoder.decode(request.getParameter("receiverName2"), "UTF-8");
	    }else{		
	    	receiverName2="";
	    }	

	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	    HttpSession Session = request.getSession();
	    Object pageNo=1;
	    Map<String, Object> paramMap=null;
	    String outDateStart="";
	    String outDateEnd="";
	    String outputDate="";
	    String materialName="";
	    String receiverName="";
	    
	    if(newSearch.equals("")){
	    	pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
	    	paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
	    	if(null!=paramMap.get("outDateStart")){
	    		outDateStart=paramMap.get("outDateStart").toString();
			}
	    	if(null!=paramMap.get("outDateEnd")){
	    		outDateEnd=paramMap.get("outDateEnd").toString();
			}
	    	if(null!=paramMap.get("outputDate")){
	    		outputDate=paramMap.get("outputDate").toString();
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
<script type="text/javascript">
if(pageNum=<%=pageNum%>!=null){
	var pageNum=<%=pageNum%>;
}else{
	var pageNum=1;
}
if(pageNum=<%=pageNum%>!=null){
	var pageNum=<%=pageNum%>;
}else{
	var pageNum=1;
}
var outputDate2;
var materialName2;
var receiverName2;
var pageNum=parseInt("<%=pageNo%>");
var totalPage;
var totalNum;
var pageSize=20;
var toUrl="";
var params = {"limitDate":"1","newSearch":"<%=newSearch%>"};

var outputMatName;

var guaranteeUnitString;
var productionDate;
var productionBatch;
var outputDateHistory="<%=outputDate%>";
var materialNameHistory="<%=materialName%>";
var receiverNameHistory="<%=receiverName%>";
var outDateStart="<%=outDateStart%>";
var outDateEnd="<%=outDateEnd%>";
var outDateStart=calDateByDay(-32);
params.outDateStart=outDateStart;
function search(pageNum){
/* 	params.outDateStart=outDateStart;
	params.outDateEnd=outDateEnd; */
/* 	outputDate=$("#date_para").val();
	params.outputDate=outputDate2; */
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
	url: "../outputManage/outputBatch/queryOutputBatchs/"+pageNum+"/"+pageSize,
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params),
	success:function(result) {
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
			
			console.log(resultList);
			for(var i=0;i<resultList.length;i++){
				var num=i+1;
				var id=resultList[i].id;
				var outputDate=isNullForTable(resultList[i].outputDate);
				var outputMatName=isNullForTable(resultList[i].outputMatName);
				var spec=isNullForTable(resultList[i].spec);
				var quantity=isNullForTable(resultList[i].quantity);
				var manufacture=isNullForTable(resultList[i].manufacture);
				var guaranteeValue=isNullForTable(resultList[i].guaranteeValue);
				var guaranteeUnitString=isNullForTable(resultList[i].guaranteeUnitString);
			/* //	var newBatchId=isNullForTable(resultList[i].newBatchId);
			//	var guaranteeUnit=isNullForTable(resultList[i].guaranteeUnit); */
				var productionDate=isNullForTable(resultList[i].productionDate);
				var productionBatch=isNullForTable(resultList[i].productionBatch);
				var outputDate=isNullForTable(resultList[i].outputDate);
				var traceCode=isNullForTable(resultList[i].traceCode);
				/* var outputDate=$("#date_para").val().trim(); */
				var materialName2=$("#materialName").val().trim();
				var receiverName2=$("#receiverName").val().trim();

				var receiverName=isNullForTable(resultList[i].receiverName);
	
 		//可能是控件的问题，目前先放着了...
 		    var $tr=$("<tr><td>"+((pageNum-1)*pageSize+num)+"</td><td>"+outputDate+"</td><td>"+outputMatName+"</td><td>"+spec+"</td><td>"+quantity+"</td><td>"+manufacture+"</td><td>"+guaranteeValue+guaranteeUnitString+"</td><td>"+productionDate+"</td><td>"+productionBatch+"</td><td>"+traceCode+"</td><td>"+receiverName+"</td><td class='td_oper'><a href='../findView/replenish.parameter.outParameter-editor?id="+id+"' class='btn_green'>编辑</a><a href='javascript:void(0)' class='btn_green' rel='popup' link='replenish.parameter.out-iframe-del?id="+id+"&pageNum="+pageNum+"&outputDate2="+encodeURI(encodeURI(outputDate2))+"&materialName2="+encodeURI(encodeURI(materialName2))+"&receiverName2="+encodeURI(encodeURI(receiverName2))+"' title='提示'>删除</a></td></tr>");

 	
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
			};
			$("#loading").hide();
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
	/* $("#date_start").val(outDateStart);
	$("#date_ends").val(outDateEnd);
	
    $('#date_para').calendar({ minDate:calDateByDay(-32), maxDate:calDateByDay(10)});
	$("#date_para").val(outputDateHistory); */
	$("#materialName").val(materialNameHistory);
	$("#receiverName").val(receiverNameHistory);
	
	params.materialName=materialName2;
	params.receiverName=receiverName2;          
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
	$("#date_start").val(calDateByDay(-32));	
	//点击查询按钮查询数据
	$(".btn_query").click(function(){
		outDateStart=$("#date_start").val().trim();
		outDateEnd=$("#date_ends").val().trim();
		materialName=$("#materialName").val().trim();
		receiverName =$("#receiverName").val().trim();
		/* outputDate =$("#date_para").val().trim(); */
		/* params.outputDate=outputDate; */
		params.outDateStart=outDateStart;
		params.outDateEnd=outDateEnd;
		
		
		
		
		params.receiverName=receiverName;
		params.materialName=materialName;
		pageNum=1;
		params.newSearch="1";

		search(pageNum);

	});
	//回车事件
	$(function(){
		document.onkeydown = function(e){ 
		    var ev = document.all ? window.event : e;
		    if(ev.keyCode==13) {

		    	$(".btn_query").click();
		    	
		     };
		};
		});
	
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
		materialName=$("#materialName").val().trim();
		receiverName =$("#receiverName").val().trim();
		/* outputDate =$("#date_para").val().trim(); */
		outDateStart=$("#date_start").val().trim();
		outDateEnd=$("#date_ends").val().trim();
		var exportParam={};
		
		/* exportParam.outputDate=outputDate; */
		exportParam.receiverName=receiverName;
		exportParam.materialName=materialName;
		exportParam.outDateStart=outDateStart;
		exportParam.outDateEnd=outDateEnd;
		$.ajax({
			url: "../outputManage/outputBatch/exportBatchDetail",
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
	
});





</script>
</head>
<body>
<div class="main_box">
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.parameter.outParameter">近期发货维护</a>
                   <div class="btn_opera" style="width:420px;"> 
                   <!-- <a href="#" class="btn_export" style="width:180px;margin-left:20px">按照查询条件导出历史发货</a>   --> 
                     
                   <input type="button" class="btn_batch" value="按导入文件查看" onClick="window.location.href='../findView/replenish.parameter.outbatch?newSearch=1'" />
           			 <input type="button" class="btn_add btn_export" value="导出查询结果" />  
           </div> 
           
          </h3>

          <div class="query">

               <table class="query_table" style="min-width:890px;">
                  <tr>
                  
                      <td class="td_lf" style="min-width:60px;">发货日期</td>
                      <td><input type="text" class="input_date" value="" placeholder="请选择日期" id="date_start" style="width: 72px" readonly /> - 
						
						<input type="text" class="input_date" value=""  placeholder="请选择日期"id="date_ends"style="width: 72px" readonly /></td>
                     
                      <!-- <td style="min-width:168px;"><input type="text" class="input_date" id="date_para" placeholder="请选择发货日期" readonly="readonly"  /></td> -->
                      <td class="td_lf" style="min-width:60px;">收货商名称</td>
                      <td style="min-width:168px;"><input type="text" class="input_code" id="receiverName"  placeholder="请输入收货商名称"   /></td>
                       <td class="td_lf" style="min-width:60px;">产品名称</td>
                      <td style="min-width:168px;"><input type="text" class="input_code" id="materialName"  placeholder="请输入产品名称"  /></td>
                 <td style="width:60px;"><input type="button" class="btn_query" value="查询" /></td>
                  </tr>
               </table>
              
          </div>
          <div class="table_box" style="display: none;" id="no_box">
               <div class="unit_no">
                    <i class="i_nofound"></i>
                    <p>近期内无发货台账，可进入“<a href="replenish.parameter.outParameter-history?newSearch=1">历史发货查询</a>”查看更多</p>
               </div>
          </div>
          <div class="table_box" id="table_box">
               <table class="table_list" style="min-width:800px;">
                    <thead>
                       <tr>
                           <th style="min-width:30px">序号</th>
                           <th style="min-width:70px">发货日期</th>
                           <th style="min-width:70px">产品名称</th>
                           <th style="min-width:50px">规格</th>
                           <th style="min-width:30px">数量</th>
                           <th style="min-width:68px">生产单位</th>
                           <th style="min-width:50px">保质期</th>
                           <th style="min-width:70px">生产日期</th>
                           <th style="min-width:60px">批次号</th>
                           <th style="min-width:50px">追溯码</th>
                           <th style="min-width:68px">收货商名称</th>
                           <th style="min-width:80px">操作</th>
                          </tr>
                    </thead>
                    <tbody id="body">                    
                    </tbody>
                 </table>
               <p class="paging_box">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" id="pre_page"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" id="next_page" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em>1</em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <span id="page_btn"><input class="paging_btn" id="page_btn" type="button" value="确定"  ></span> 
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>    


	
</body>
</html>