<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>

<% 
String id=request.getParameter("id");
	
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String startDate="";
	String endDate="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null&&null!=paramMap.get("endDate")){
			endDate=paramMap.get("endDate").toString();
		}
		if(paramMap!=null&&null!=paramMap.get("startDate")){
			startDate=paramMap.get("startDate").toString();
		}
	}


%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp" %>
<style type="text/css">
input.btn_green{ display:inline-block;font:12px/22px 'Simsun'; color:#fff; background:#BBBEB9; border-radius:4px; padding:0 7px; margin:0 3px;border: none;}
@-moz-document url-prefix(){input.btn_green{padding:0 5px;margin:1px;}}
</style>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">

var pageNum=parseInt("<%=pageNo%>");
var totalPage;
var totalNum;
var pageSize=20;
var toUrl="";

var params = {"newSearch":"<%=newSearch%>"};

var partyMealDate;
var partyMealSeq;
var partyMealName;
var diningCount;
var partyMealType;
var remark;
var sampleMeals={"":"","65001":"早餐","65002":"中餐","65003":"晚餐","65004":"其他"};
var sampleTypes={"":"","66001":"圆桌","66002":"自助餐","66003":"每人每"};
var startDateHistory="<%=startDate%>";
var endDateHistory="<%=endDate%>";
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
	url: "../meal/partyMeal/queryPartyMeal/"+pageNum+"/"+pageSize,

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
			$("#body").children().remove();
			
			console.log(resultList);
			for(var i=0;i<resultList.length;i++){
				//var num=i+1;
				var id=resultList[i].id;
				var partyMealDate=isNullForTable(resultList[i].partyMealDate);
				var partyType=sampleTypes[isNullForTable(resultList[i].partyMealType)];
				var partySeq=sampleMeals[isNullForTable(resultList[i].partyMealSeq)];
				var partyMealName=isNullForTable(resultList[i].partyMealName);
				var diningCount=isNullForTable(resultList[i].diningCount);
				//var partyMealType=isNullForTable(resultList[i].partyMealType);
				var remark=isNullForTable(resultList[i].remark);
				var $tr=$("<tr><td class='td_ser'>"+((pageNum-1)*pageSize+i+1)+"</td><td>"+partyMealDate+"</td><td>"+partySeq+"</td><td style='word-wrap:break-word'>"+partyMealName+"</td><td>"+diningCount+"</td><td>"+partyType+"</td><td style='word-wrap:break-word'>"+remark+"</td><td class='td_oper'><a href='../findView/partyMeal.partyMeal-view?id="+id+"' class='btn_green'>查看</a><a  href='../findView/partyMeal.partyMeal-edit?id="+id+"' class='btn_green'>编辑</a>	<a href='javascript:void(0)' class='btn_green' rel='popup' link='partyMeal.iframe-del?id="+id+"' title='提示'>删除</a></td></tr>");
				$tr.data("id",id);
				if(partyMealDate!=""){
					var startDate=calDateByDay(-32);
					var endDate=calDateByDay(10);
					if(compareTime(partyMealDate.substring(0,10),startDate)||compareTime(endDate,partyMealDate.substring(0,10))){
						$tr.find("a").remove();
						$tr.find(".td_oper").append("<a href='partyMeal.partyMeal-view?id="+id+"'  class='btn_green'>查看</a> <input type='button' class='btn_green' value='编辑' /> <input type='button' class='btn_green' value='删除'/>");
					}
				}
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
$(function(){
 /*--日历--*/
	$("#date_start").val(startDateHistory);
		$("#date_ends").val(endDateHistory);
	var dateStartParam={onSetDate:function(){
		$("#date_ends").calendar({minDate:"#date_start"});
		var startDate=this.getDate("date");
		var endDate=$('#date_ends').val();
		if(!compareTime(startDate,endDate)){
			$("#date_ends").val("");
		};
	}};
	$("#date_start").calendar(dateStartParam);
	$("#date_ends").calendar({minDate:"#date_start"});
	
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
	params.startDate=startDateHistory;
	params.endDate=endDateHistory;
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
		
	//点击查询按钮查询数据
	$(".btn_query").click(function(){
	
		partyMealDate =$("#partyMealDate").val().trim();
		
		var startDate=$("#date_start").val();
		var endDate=$("#date_ends").val();
		params.startDate=startDate;
		params.endDate=endDate;
		pageNum=1;
		params.newSearch="1";

		search(pageNum);
	});
	$(".btn_export").click(function(){
		$(".btn_export").attr("disabled","true");
		var exportParam={};
		var startDate=$("#date_start").val();
		var endDate=$("#date_ends").val();
		exportParam.startDate=startDate;
		exportParam.endDate=endDate;
		$.ajax({
			url: "../meal/partyMeal/queryPartyMealForExport",
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
	$(function(){
		document.onkeydown = function(e){ 
		    var ev = document.all ? window.event : e;
		    if(ev.keyCode==13) {

		    	$(".btn_query").click();
		    	
		     };
		};
		});
});





</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">大型宴会申报</a> 
          
        
       <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="新增大型宴会申报" onClick="window.location.href='../findView/partyMeal.partyMeal-add'" />
                   <input type="button" class="btn_add btn_export" value="导出查询结果" /> 
              </div>
          </h3>
          
          <div class="query">

               <table class="query_table" style="min-width:230px;">
                  <tr>
                  
				 
               <span><em>宴会日期：</em><input type="text" class="input_date" placeholder="请选择宴会日期" id="date_start" readonly="readonly"/> - <input type="text" class="input_date"  placeholder="请选择宴会日期" id="date_ends" readonly="readonly"/></span>             
              <input type="button" class="btn_query" value="查询" />
               <input type="text" class="input_date" value="" id="partyMealDate" readonly="readonly" style="display:none;"/>
          
                  </tr>
               
               </table>  
          </div>
          <div class="table_box">
               <table class="table_list" style="table-layout:fixed;">
                    <thead>
				
						<tr>
                           <th style="width:8%">序号</th>
                           <th style="width:10%">宴会日期</th>
                           <th style="width:10%">餐次</th>
                           <th style="width:10%">宴会名称</th>
                           <th style="width:10%">就餐人数</th>
                           <th style="width:10%">供餐方式</th>
                           <th style="width:21%">备注</th>
                           <th style="width:21%">操作</th>
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