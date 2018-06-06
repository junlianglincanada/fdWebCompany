<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
String linkCompanyId=request.getParameter("linkCompanyId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
  <%@ include file="../../include.jsp" %>
<title>万达食品安全追溯系统</title>
</head>
<body>
<div class="main_box">
         <div class="main_con">
			<h3 class="process_title"><span>当前位置: </span><a href="replenish.supplier.supplier">供应商管理</a> > <a href="#">采购品</a> > <a id="name1"></a></h3>
          <div class="info_tab">
          <a href="replenish.supplier.supplier-view?id=<%=id %>">基本信息</a>
          <a href="replenish.supplier.supplier-view-photo?id=<%=id %>&linkCompanyId=<%=linkCompanyId %>">证照<em style="font-style:normal;position:relative;top:1px;letter-spacing:1px;">图</em>片</a>
           <a href="replenish.supplier.supplier-view-into?id=<%=id %>&linkCompanyId=<%=linkCompanyId %>" class="default">关联的采购品<em style="font-style:normal;position:relative;top:1px;letter-spacing:1px;"></em></a>
               </div>
               <table class="table_list" >
                    <thead>
                       <tr>
                           <th style="min-width:40px">序号</th>                 
                           <th style="min-width:100px">采购品名称</th>
                           <th style="min-width:100px">规格</th>
                           <th style="min-width:250px">生产单位</th>
                       </tr>
                    </thead>
                    <tbody >
                    </tbody>
                 </table>
                 <p class="paging_box">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" id="pre_page"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" id="next_page" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em></em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <span id="page_btn"><input class="paging_btn" id="page_btn" type="button" value="确定" /></span> 
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
   
 
<script type="text/javascript">
var id="<%=id %>";
var params = {};
var pageNum=1;
var totalPage;
var totalNum;
var pageSize=20;
function search(pageNum){
	$("#loading").show();
	$.ajax({
		url:"../inputManage/supplier/getSupplierById/"+id,
		type:"get",
		headers:{},
		success:function(result){
			if(result.status==0){
				console.log(result.body);
				document.getElementById("name1").innerHTML = result.body.name;
			}
		},
	})
	var toUrl="../inputManage/inputMaterial/queryInputMaterial/"+pageNum+"/"+pageSize;
	var companyId =id;
	console.log(companyId);
	params.companyId=companyId;
	$.ajax({
	url:toUrl,
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params),
	success:function(text) {
		if(text.status==0){
	         pageContentReset(text);
	          page(text);
	  		$("#totalPage em").text(totalPage);
			$("#paging_num").val(pageNum);
				$("#loading").hide();
		}

	 },   
	 error:function(text) {
     console.log(text.message);
  
	 }
	});
}


function pageContentReset(result){
	if(result!=null&&result.body.resultList.length>0){
		var resultList=result.body.resultList;
		console.log(resultList.lenght);
		console.log(resultList);
	    $("tbody").children().remove();
		for(var i=0;i<resultList.length;i++){
			var num=(pageNum-1)*pageSize+i+1;
			var id=resultList[i].id;
			var name=isNullForTable(resultList[i].name);
			var spec=isNullForTable(resultList[i].spec);
			var manufacture=isNullForTable(resultList[i].manufacture);
			var $tr=$('<tr><td>'+num+'</td><td>'+name+'</td><td>'+spec+'</td><td>'+manufacture+'</td></td></tr>');
			if(i%2==0){
				$tr.addClass("even");
			}
			$("tbody").append($tr);
		}

	}
}

	$(function(){
		if(pageNum==null||pageNum==""){
			pageNum=1;
		}
	    search(pageNum);
		 console.log(pageNum+":test");
	//上一页
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
	//下一页
	$(".paging_next").click(function(){
		
		 console.log(pageNum+":test1");
		 console.log(totalPage+":test2");
		 if(pageNum<totalPage){
				$(".paging_box a").removeClass("default");
				pageNum +=1;
				$("#page"+pageNum).addClass("default");
				search(pageNum) 
		 }else if(pageNum==totalPage){
			search(pageNum);
		}
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
		var pageNo=$("#paging_num").val().trim();
		if(isNaN(pageNo)||pageNo==null||pageNo==""){
			return;
		}else{
		pageNum=$("#paging_num").val().trim();
		if(pageNum<1){
			pageNum=1;
			search(pageNum);
		}else  if(pageNum>totalPage){
			pageNum=totalPage;
			search(pageNum);
		}else{
			search(pageNum);
		}
		}
	});
		
		//查询
		$(".btn_query").click(function(){
			$("tbody").children().remove();
			pageNum=1;
			search(pageNum);
		});
	});
	
	function html_encode(str)   
	{   
	  var s = "";   
	  if (str.length == 0) return "";   
	  s = str.replace(/&/g, "&gt;");   
	  s = s.replace(/</g, "&lt;");   
	  s = s.replace(/>/g, "&gt;");   
	  s = s.replace(/ /g, "&nbsp;");   
	  s = s.replace(/\'/g, "&#39;");   
	  s = s.replace(/\"/g, "&quot;");   
	  s = s.replace(/\n/g, "<br>");   
	  return s;   
	}   

	  
	  function html_decode(str)   
	  {   
	    var s = "";   
	    if (str.length == 0) return "";   
	    s = str.replace(/&gt;/g, "&");   
	    s = s.replace(/&lt;/g, "<");   
	    s = s.replace(/&gt;/g, ">");   
	    s = s.replace(/&nbsp;/g, " ");   
	    s = s.replace(/&#39;/g, "\'");   
	    s = s.replace(/&quot;/g, "\"");   
	    s = s.replace(/<br>/g, "\n");   
	    return s;   
	  }
</script>
	
</body>
</html>