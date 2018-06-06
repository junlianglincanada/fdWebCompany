<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.io.*" pageEncoding="UTF-8"%>
<%-- <%@ page session="false"%> --%>
<%-- <% 
	String pageNum=request.getParameter("pageNum");
	String recycleDate2;
	    if(request.getParameter("recycleDate2")!=null&&request.getParameter("recycleDate2")!="null"&&request.getParameter("recycleDate2")!=""){
	    	recycleDate2=request.getParameter("recycleDate2");
	    }else{
	    	recycleDate2="";
	    }
%> --%>
<% 
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String queryRecycleDate="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null&&null!=paramMap.get("recycleDate")){
			queryRecycleDate=paramMap.get("recycleDate").toString();
		}
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<style type="text/css">
input.btn_green{ display:inline-block;font:12px/22px 'Simsun'; color:#fff; background:#BBBEB9; border-radius:4px; padding:0 7px; margin:0 3px;border: none}
@-moz-document url-prefix(){input.btn_green{padding:0 5px;margin:1px;}}
</style>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
<%-- var recycleDate2="<%=recycleDate2%>"; --%>
var recycleDate2;
var pageSize=20;
var pageNum=parseInt("<%=pageNo%>");
var totalPage;
var params = {"newSearch":"<%=newSearch%>"};
var queryRecycleDateHistory="<%=queryRecycleDate%>";

var totalNum;
var toUrl="";
var oilCompanyName;
var materialName;
var outputMatName;
var outputDate;
var guaranteeUnitString;
var productionDate;
var productionBatch;
var recycleDate;
var oilCompanyName;
var typeValue;
var amount;
var unitValue;
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
	recycleDate2=$("#date_para").val();
	params.recycleDate=recycleDate2;
	$.ajax({
	url: "../recycle/cleanOilComMgr/queryDTOCleanOilRecycleList/"+pageNum+"/"+pageSize,
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
			console.log(result);
			page(result);
			var	totalNum=0;
			var resultList=[];
			if(result.body!=null){
				totalNum=result.body.totalRecord;
				resultList=result.body.resultList;
			}
			
			$("#body").children().remove();	
			for(var i=0;i<resultList.length;i++){
				var num=i+1;
				var id=resultList[i].id;
				var recycleDate=isNullForTable(resultList[i].recycleDate);
				var attachListSize=resultList[i].attachListSize;
				var oilCompanyName=isNullForTable(resultList[i].oilCompanyName);
				var typeValue=isNullForTable(resultList[i].typeValue);
				var type=isNullForTable(resultList[i].type);
				var amount=isNullForTable(resultList[i].amount);
				var unitValue=isNullForTable(resultList[i].unitValue);
				var recyclePerson=isNullForTable(resultList[i].recyclePerson);
				var recycleDate2=$("#date_para").val().trim();
/* 				var oilCompanyName2=$("#oiLCompanyName").val().trim(); 
 */				typeGeneral=resultList[i].oilCompanyName;	
 		//可能是控件的问题，目前先放着了...
 		var $tr=$("<tr><td>"+((pageNum-1)*pageSize+num)+"</td><td>"+recycleDate+"</td><td>"+oilCompanyName+"</td><td>"+typeValue+"</td><td>"+amount+""+(""+unitValue+"")+"</td><td>"+attachListSize+"</td><td>"+recyclePerson+"</td><td class='td_oper'><a href='../findView/recycle.oil.oil-view?id="+id+"' class='btn_green'>查看</a><a href='../findView/recycle.oil.oil-editor?id="+id+"'class='btn_green'>编辑</a><a href='javascript:void(0)' class='btn_green' rel='popup' link='recycle.oil.iframe-del?id="+id+"&pageNum="+pageNum+"&recycleDate2="+encodeURI(encodeURI(recycleDate2))+"' title='提示'>删除</a></td></tr>");
				$tr.data("id",id);
				if(recycleDate!=""){
					var startDate=calDateByDay(-32);
					var endDate=calDateByDay(10);
					if(compareTime(recycleDate,startDate)||compareTime(endDate,recycleDate)){
						$tr.find("a").remove();
						$tr.find(".td_oper").append("<a href='../findView/recycle.oil.oil-view?id="+id+"' class='btn_green'>查看</a> <input type='button' class='btn_green' value='编辑' /> <input type='button' class='btn_green' value='删除'/>");
					}
				}
				if(i%2==0){
					$tr.addClass("even");
				}
				
				$("#body").append($tr);
				
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
$(function(){
	$("#date_para").val(queryRecycleDateHistory);
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
	//点击查询按钮查询数据
	$(".btn_query").click(function(){
		recycleDate=$("#date_para").val().trim();
		params.recycleDate=recycleDate;
		pageNum=1;
		params.newSearch="1";
		search(pageNum);
		//$("#loading").hide();
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
    $('#date_para').calendar();	
    
});
</script>
</head>
<body>
<div class="main_box">
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">废弃油脂</a> 
          <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="新增台账" onClick="window.location.href='../findView/recycle.oil.oil-add'" />
          </div>
          </h3>
 		   <div class="query">
                  <span>
                      <em class="td_lf">回收日期：</em>
                      <input type="text" class="input_date" id="date_para" placeholder="请选择回收日期"readonly="readonly" /></span>
                      <input type="button" class="btn_query" value="查询" />
          </div>
          <div class="table_box">
               <table class="table_list" style="min-width:890px;">
                    <thead>
                       <tr>
                           <th style="min-width:40px">序号</th>                                         
                           <th style="min-width:110px">回收日期</th>
                           <th style="min-width:200px">回收单位</th>
                           <th style="min-width:40px">种类</th>
                           <th style="min-width:100px">数量（单位）</th>
                           <th style="min-width:60px">回收单据</th>
                           <th style="min-width:100px">回收人</th>
                           <th style="min-width:160px">操作</th>
                       </tr>
                    </thead>
                    <tbody id="body">                    
                    </tbody>
                 </table>
               <p class="paging_box">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" ></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em></em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <input type="button" class="paging_btn" value="确 定" id="page_btn"/>
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>
</body>
</html>