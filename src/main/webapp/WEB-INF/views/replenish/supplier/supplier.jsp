<%@page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%@ page session="false"%>
<% 
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String queryName="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null&&null!=paramMap.get("name")){
			queryName=paramMap.get("name").toString();
		}
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<script src="../js/jquery.qrcode.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
var pageSize=20;
var pageNum=parseInt("<%=pageNo%>");
var totalPage;
var params = {"newSearch":"<%=newSearch%>"};
var queryName="<%=queryName%>";
var com_id='<%=SecurityUtils.getCurrentUserCompanyId()%>';
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
		url:"../inputManage/supplier/querySuppliers/"+pageNum+"/"+pageSize,
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
				page(result);
				$("#can").hide();
				$(".table_box").show();
				$("tbody").children().remove();
				var	totalNum=result.body.totalRecord;
				var suppliers=result.body.resultList;
				for(var i=0;i<suppliers.length;i++){
					var id=suppliers[i].id;
					var name=isNullForTable(suppliers[i].name);
					var contactAddress=isNullForTable(suppliers[i].contactAddress);
					var contactPerson=isNullForTable(suppliers[i].contactPerson);
					var contactPhone=isNullForTable(suppliers[i].contactPhone);
					var nameAbbrev=isNullForTable(suppliers[i].nameAbbrev);
					var code=isNullForTable(suppliers[i].code);
					var linkedCompanyId=isnull(suppliers[i].linkedCompanyId);
					var contractFlag=isnull(suppliers[i].contractFlag);
					var flag=""
					if(linkedCompanyId!=""){
						flag='<i class="i_has"></i>';
					}else{
						flag='<i class="i_not"></i>';
					}
					if(contractFlag!=""){
						flag='<i class="i_argee"></i>';
					}
					var row=(pageNum-1)*pageSize+i+1;
					var $tr=$('<tr><td class="td_ser">'+flag+'</td><td class="td_ser">'+row+'</td><td>'+name+'</td><td>'+nameAbbrev+'</td><td>'+code+'</td><td>'+contactPerson+'</td><td>'+contactPhone+'</td><td class="td_opera"><a href="replenish.supplier.supplier-view?id='+id+'" class="btn_green">查看</a><a href="replenish.supplier.supplier-editor2?id='+id+'" class="btn_green">编辑</a><a href="javascript:void(0)" class="btn_green" rel="popup" link="replenish.supplier.iframe-del?id='+id+'&queryName='+encodeURI(encodeURI(queryName))+'&totalNum='+totalNum+'&pageNum='+pageNum+'" title="提示">删除</a></td><td><a href="javascript:void(0)" class="btn_qrcode" rel="popup_qrcode" link="'+com_id+'_'+name+'_'+id+'_SUPPLIER" title="查看二维码" id="qrcode_i1"><img src="../images/qrcode_small.jpg" /></td></tr>');
					if(i%2==0){
						$tr.addClass("even");
					}
					$("tbody").append($tr);
				}
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
			}
			$("#loading").hide();
		},
		error:function(e){
			console.log(e);
		}
	});
}

function huifu(){
	$(".btn_export").removeAttr("disabled");
}

$(function(){
	$(".query_input").val(queryName);
	$(".table_box").hide();
	$("#can").load("../findView/replenish.supplier.init");
	//search(pageNum);
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
	$(".btn_query").click(function(){
		queryName=$(".query_input").val().trim();
		params.name=queryName;
		pageNum=1;
		params.newSearch="1";
		search(pageNum);
	});
	//回车事件
	document.onkeydown= function(e){
		e = e ? e : event; 
		if(e.keyCode == 13){
			$(".btn_query").click();
	 	} 
	}
	

	$(".btn_export").click(function(){
		$(".btn_export").attr("disabled","true");
		queryNameForExport=$(".query_input").val().trim();
	/* 	receiverName =$("#receiverName").val().trim();
		outputDate =$("#date_para").val().trim(); */
		
		var exportParam={};
		
		exportParam.name=queryNameForExport;
	/* 	exportParam.receiverName=receiverName;
		exportParam.materialName=materialName; */
		
		$.ajax({
			url: "../inputManage/supplier/querySuppliers",
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
    <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">供应商管理</a> 
              <div class="btn_opera" style="width:520px;"> 
              <!-- <a href="#" class="btn_export" style="width:180px;margin-left:20px">按照查询条件导出供应商</a>  --> 
                   <input type="button" class="btn_editor" value="维护协议单位" onClick="window.location.href='replenish.supplier.supplier-unit'" />
                   <input type="button" class="btn_add" value="添加供应商" onClick="window.location.href='replenish.supplier.supplier-add2'" />
              		<input type="button" class="btn_add btn_export" value="导出查询结果" /> 
              </div>
          </h3>
          <div class="query">
               <span><em>供应商名称：</em><input type="text" class="query_input" value=""/></span>
               <input type="button" class="btn_query" value="查询" />
          </div>
          <div id="can"></div>
          <div class="table_box">
               <table class="table_list">
                    <thead>
                       <tr>
                       	   <th></th>
                           <th style="min-width:30px">序号</th>
                           <th style="min-width:250px">供应商名称</th>
                           <th style="min-width:100px">供应商简称</th>
                           <th style="min-width:100px">供应商编号</th>
                           <th style="min-width:100px">联系人姓名</th>
                           <th style="min-width:100px">联系电话</th>
                           <!-- <th>固定电话</th>
                           <th>邮箱</th> -->
                           <th style="min-width:100px">操作</th>
                           <th style="min-width:60px">二维码</th>
                       </tr>
                    </thead>
                    <tbody>
                    </tbody>
                 </table>
                 <div class="regunit">
                      <span><i class="i_has"></i><em>已关联注册单位</em></span>
                      <span><i class="i_not"></i><em>未关联注册单位</em></span>
                      <span><i class="i_argee"></i><em>协议单位</em></span>
                 </div>
                 <p class="paging_box">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" ></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em></em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <!-- <input id="page_btn" type="button" value="确定" class="btn_query" style="float:none;float: none;width: 40px;font-size: 12px;height: 28px;line-height: 28px;"> -->
                   <input type="button" class="paging_btn" value="确 定" id="page_btn"/>
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>
</body>
</html>