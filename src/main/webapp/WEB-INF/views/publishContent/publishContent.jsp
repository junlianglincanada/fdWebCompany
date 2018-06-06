<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%
	String id = request.getParameter("id");
	String pageNum = request.getParameter("pageNum");
	
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
    HttpSession Session = request.getSession();
    Object pageNo=1;
    Map<String, Object> paramMap=null;
    
    String companyName="";
    String publishDate="";
    String title="";
  
    
    if(newSearch.equals("")){
    	pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
    	paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
    	if(paramMap!=null&&null!=paramMap.get("orgName")){
    		companyName=paramMap.get("orgName").toString();
		}
    	if(paramMap!=null&&null!=paramMap.get("publishDate")){
    		publishDate=paramMap.get("publishDate").toString();
		}
    	if(paramMap!=null&&null!=paramMap.get("title")){
    		title=paramMap.get("title").toString();
		}
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp"%>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
var totalPage;
var totalNum;
var pageSize=20;
var titleHistory="<%=title%>";
var companyNameHistory="<%=companyName%>";
var publishDateHistory="<%=publishDate%>";
var params = {"newSearch":"<%=newSearch%>"};
var pageNum=parseInt("<%=pageNo%>");

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
	url: "../publishContent/queryPublishContent/"+pageNum+"/"+pageSize,
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
				var num=i+1;
				var id=resultList[i].id;
				var title=isNullForTable(resultList[i].title);
				var companyName=isNullForTable(resultList[i].companyName);
				var publishDate=isNullForTable(resultList[i].publishDate);
                var isRead=resultList[i].isRead;
                if(nullFlag(isRead)){
                	title += '<i class="i_new">';
                	isRead = '<span class="red">未读</span>';
                }else{
                	isRead = '<span>已读</span>';
                }
                var $tr=$("<tr><td class='td_ser'>"+((pageNum-1)*pageSize+num)+"</td><td>"+title+"</td><td>"+companyName+"</td><td>"+publishDate+"</td><td class='td_ser'>"+isRead+"</td><td class='td_oper'><a href='../findView/publishContent.publishContentDetail?id="+ id+ "' class='btn_green'>查看</a></td>/tr>");

				$tr.data("id", id);
				if (i % 2 == 0) {
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
			$("#loading").hide();
		};
	},
	error : function(text) {
		console.log(text.message);
	}
});
	}
	$(function() {
		$('#publishDate').calendar();
		$("#companyName").val(companyNameHistory);
		$("#publishDate").val(publishDateHistory);
		$("#title").val(titleHistory);
		params.orgName=companyNameHistory;
		params.publishDate=publishDateHistory;  
		params.title=titleHistory;
		
		search(pageNum);

		//点击上一页查询
		$(".paging_perv").click(function() {
			if (pageNum == 1) {
				params.newSearch="1";
				search(pageNum);
			} else {
				$(".paging_box a").removeClass("default");
				pageNum += -1;
				$("#page" + pageNum).addClass("default");
				params.newSearch="1";

				search(pageNum);
			}
		});
		//点击下一页查询
		$(".paging_next").click(function() {
			if (pageNum == totalPage) {
				params.newSearch="1";
				
				search(pageNum);
			} else {
				$(".paging_box a").removeClass("default");
				pageNum += 1;
				$("#page" + pageNum).addClass("default");
				params.newSearch="1";
				search(pageNum);
			}
		});
		//点击首页查询数据
		$(".paging_head").click(function() {
			pageNum = 1;
			params.newSearch="1";
			search(pageNum);
		});
		//点击尾页查询数据
		$(".paging_trailer").click(function() {
			pageNum = totalPage;
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
		$(".btn_query").click(function() {
			var companyName2 = $("#companyName").val().trim();
			var publishDate2 = $("#publishDate").val().trim();
			var title2 = $("#title").val().trim();
			params.publishDate = publishDate2;
			params.orgName = companyName2;
			params.title = title2;
			pageNum = 1;
			params.newSearch="1";
			search(pageNum);

		});
		//回车事件
		$(function() {
			document.onkeydown = function(e) {
				var ev = document.all ? window.event : e;
				if (ev.keyCode == 13) {

					$(".btn_query").click();

				};
			};
		});
	});
</script>
</head>
<body>
	<div class="main_box">
		<div id="loading"
			style="position: absolute; top: 50%; left: 50%; margin: 0 auto; height: 300px; z-index: 888; display: none;">
			<img src="../img/loading.gif">
		</div>
		<div class="main_con">
			<h3 class="process_title">
				<span>当前位置: </span><a href="#">通知公告</a>
			</h3>
			<div class="query">
				<span><em>标题：</em><input type="text" class="query_input"
					id="title" value="" placeholder="请输入标题"/></span>
				<span><em>发布日期：</em><input type="text" class="input_date"
					id="publishDate" value="" placeholder="请选择发布日期" readonly="readonly" /></span>
				<span><em>发布单位：</em><input type="text" class="query_input"
					id="companyName" value="" placeholder="请输入发布单位" /></span> <input
					type="button" class="btn_query" value="查询" />
			</div>
			<div class="table_box">
				<div class="table_box">
					<table class="table_list" style="min-width: 800px;">
						<thead>
							<tr>
								<th style="min-width: 30px">序号</th>
								<th style="min-width: 400px">通知公告标题</th>
								<th style="min-width: 250px">发布单位</th>
								<th style="min-width: 150px">发布日期</th>
								<th style="min-width: 40px">状态</th>
								<th style="min-width: 40px">操作</th>
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
						</span> <span class="num_text">跳转 <input type="text" id="paging_num" value="" style="width: 20px; height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span> <span id="page_btn">
							<input class="paging_btn" id="page_btn" type="button" value="确定"></span>
					</p>
					<div class="clear"></div>
				</div>
			</div>
		</div>
</body>
</html>