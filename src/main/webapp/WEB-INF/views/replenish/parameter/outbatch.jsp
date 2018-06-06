<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%@ page session="false"%>
<%
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String importDate="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null&&null!=paramMap.get("importDate")){
			importDate=paramMap.get("importDate").toString();
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
var totalPage;
var totalNum;
var pageSize=20;
var params = {"newSearch":"<%=newSearch%>"};
var importDate="<%=importDate%>";
var pageNum=parseInt("<%=pageNo%>");
function search(pageNum){
	console.log(params);
	$("#loading").show();
	$.ajax({
	url: "../outputManage/outputBatch/queryImportFileList/"+pageNum+"/"+pageSize,
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
				var id=resultList[i].id;
				var uploadDate=resultList[i].uploadDate;
				var fileName=resultList[i].fileName;
      			var $tr=$("<tr><td class='td_ser'>"+((pageNum-1)*pageSize+i+1)+"</td><td>"+uploadDate+"</td><td>"+fileName+"</td><td class='td_opera'><a href='../findView/replenish.parameter.outParameter-detail?id="+id+"&importDate="+importDate+"&fileName="+encodeURI(encodeURI(fileName))+"' class='btn_green'>详细</a><a href='javascript:void(0)' class='btn_green' rel='popup' link='../findView/replenish.parameter.outParameter-del?id="+id+"&importDate="+importDate+"&pageNum="+pageNum+"' title='提示'>批量删除台账</a></td></tr>");
				$tr.data("id",id);
				if(i%2==0){
					$tr.addClass("even");
				}
				$("#body").append($tr);
				$("#paging_num").val(pageNum);
				$("#totalPage em").text(totalPage);
		    }
			$("#loading").hide();
		} 
	 },   
	 error:function(text) {
		// alert("系统异常，查询失败！");
	 }
	});
}
$(function(){
   /*--日历--*/				   
   $('#date_batch').calendar({ minDate:calDateByDay(-32), maxDate:calDateByDay(10)});
/*-------jquery end-------*/
   $("#date_batch").val(importDate);
    importDate=$("#date_batch").val().trim();
	if(importDate!=""&&	importDate!=null&&importDate!="null"){
		params.importDate=importDate;
	}else{
		params={};
	}
   if(pageNum==null||pageNum==""){
		pageNum=1;
	}
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
	//点击查询按钮查询数据
	$(".btn_query").click(function(){
		importDate=$("#date_batch").val().trim();
		if(importDate!=""&&	importDate!=null&&importDate!="null"){
			params.importDate=importDate;
		}else{
			params={};
		}
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
 
});	
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="replenish.parameter.outParameter?newSearch=1">近期发货维护</a> > <a href="#">按导入文件查看</a></h3>
          <div class="query">
               <span><em>导入日期：</em><input type="text" class="input_date" id="date_batch"  placeholder="请选择导入日期" value="" readonly="readonly" /></span>
               <input type="button" class="btn_query" value="查询" />
          </div>
          <p class="gray">导入文件中一个月前的台账记录，不提供查看和删除功能。</p>
          <div class="table_box">
               <table class="table_list" style="min-width:890px;">
                    <thead>
                       <tr>
                           <th>序号</th>                                         
                           <th>导入日期</th>
                           <th>导入文件名</th>
                           <th>操作</th>
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