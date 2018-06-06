<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%@ page session="false"%>
<% 
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String queryname="";
	String productionBarcode="";
	String code="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null){
			if(null!=paramMap.get("name")){
				queryname=paramMap.get("name").toString();
			}
			if(null!=paramMap.get("productionBarcode")){
				productionBarcode=paramMap.get("productionBarcode").toString();
			}
			if(null!=paramMap.get("code")){
				code=paramMap.get("code").toString();
			}
		}
	}
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
          <h3 class="process_title"><span>当前位置: </span><a href="#">采购品</a> 
              <div class="btn_opera" style="width:420px;"> 
              <!-- <a href="#" class="btn_export" style="width:180px;margin-left:20px">按照查询条件导出采购品</a>   -->
                   <input type="button" class="btn_add" value="新增采购品" onClick="window.location.href='../findView/replenish.purchased.purchased-add'" />
<%--                    <input type="button" class="btn_add" value="批量导入采购品" onClick="window.location.href='../findView/replenish.purchased.purchased-add'" /> --%>
             		<input type="button" class="btn_add btn_export" value="导出查询结果" /> 
              </div>
          </h3>
          <div class="query"  style="min-width:960px">
                         <span><em>产品名称：</em><input type="text" class="query_input" placeholder="请输入产品名称" value="" name="name3" id="name1"/></span>
               <span><em>商品包装条码：</em><input type="text" class="query_input" placeholder="请输入商品包装条码" value="" name="productionBarcode" id="productionBarcode"/></span>
               <span><em>企业编码：</em><input type="text" class="query_input"  placeholder="请输入企业编码" value="" name="code" id="code"/></span>

               <input type="button" class="btn_query" value="查询" />
          </div>
          <div class="table_box">
               <table class="table_list" >
                    <thead>
                       <tr>
                           <th style="min-width:40px">序号</th>                 
                           <th style="min-width:150px">产品名称</th>
                           <th style="min-width:40px">规格</th>
                           <th style="min-width:200px">生产单位 </th>
                           <th style="min-width:100px">产品分类</th>
                           <th style="min-width:80px">商品包装条码</th>
                           <th style="min-width:80px">企业编码</th>
                           <th style="min-width:120px">操作</th>
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
</div>    
 
<script type="text/javascript">
var params = {"newSearch":"<%=newSearch%>"};
var pageNum=parseInt("<%=pageNo%>");
var totalPage;
var totalNum;
var pageSize=20;
var queryname="<%=queryname%>";
var productionBarcode="<%=productionBarcode%>";
var code="<%=code%>";
function search(pageNum){
	$("#loading").show();
	var toUrl="../inputManage/inputMaterial/queryInputMaterials/"+pageNum+"/"+pageSize;
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
			var name2=isNullForTable(resultList[i].name);
			var productionBarcode=isNullForTable(resultList[i].productionBarcode);
			var code=isNullForTable(resultList[i].code);
			var spec=isNullForTable(resultList[i].spec);
			var manufacture=isNullForTable(resultList[i].manufacture);
			var typeGeneralValue=isNullForTable(resultList[i].typeGeneralValue);
			var $tr=$('<tr><td class="td_ser">'+num+'</td><td>'+name2+'</td><td>'+spec+'</td><td>'+manufacture+'</td><td>'+typeGeneralValue+'</td><td>'+productionBarcode+'</td><td>'+code+'</td><td class="td_opera"><a href="../findView/replenish.purchased.purchased-view?id='+id+'" class="btn_green">查看</a><a href="../findView/replenish.purchased.purchased-editor?id='+id+'" class="btn_green">编辑</a><a href="javascript:void(0)" class="btn_green" rel="popup" link="../findView/replenish.purchased.iframe-del?id='+id+'" title="提示">删除</a></td></tr>');
			if(i%2==0){
				$tr.addClass("even");
			}
			$("tbody").append($tr);
		}

	}
}

function huifu(){
	$(".btn_export").removeAttr("disabled");
}

	$(function(){
		$("#name1").val(queryname);
		$("#productionBarcode").val(productionBarcode);
		$("#code").val(code);
		if(pageNum==null||pageNum==""){
			pageNum=1;
		}
	    search(pageNum);
		 console.log(pageNum+":test");
	//上一页
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
	//下一页
	$(".paging_next").click(function(){
		
		 console.log(pageNum+":test1");
		 console.log(totalPage+":test2");
		 if(pageNum<totalPage){
				$(".paging_box a").removeClass("default");
				pageNum +=1;
				$("#page"+pageNum).addClass("default");
				params.newSearch="1";
				search(pageNum) 
		 }else if(pageNum==totalPage){
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
		pageNum=$("#paging_num").val().trim();
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
		
		//查询
		$(".btn_query").click(function(){
			$("tbody").children().remove();
			queryname =$("#name1").val().trim();
			productionBarcode=$("#productionBarcode").val().trim();
			code=$("#code").val().trim();
			params.name=queryname;
			params.productionBarcode=productionBarcode;
			params.code=code;
			pageNum=1;
			params.newSearch="1";
			search(pageNum);
		});
		
		$(".btn_export").click(function(){
			$(".btn_export").attr("disabled","true");
			materialName=$("#name1").val().trim();
			barcode =$("#productionBarcode").val().trim();
			queryCode =$("#code").val().trim();
			
			var exportParam={};

			exportParam.name3=materialName;
			exportParam.productionBarcode=barcode;
			exportParam.code=queryCode;
			
			$.ajax({
				url: "../inputManage/inputMaterial/queryInputMaterialsExport",
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