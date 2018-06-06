<%@page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"  import="java.util.*,java.io.*"%>
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
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp"%>	
<script src="../js/jquery.qrcode.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/distribute.goods.goods">收货商管理</a> 
              <div class="btn_opera" style="width:520px;">
			<!-- <a href="#" class="btn_export" style="width:180px;margin-left:20px">按照查询条件导出收货商</a> -->  
              <input type="button" class="btn_editor" value="维护协议单位" onClick="window.location.href='../findView/distribute.goods.goods-unit'" />
              <input type="button" class="btn_add" value="添加收货商" onClick="window.location.href='../findView/distribute.goods.goods-add2'" />
           		<input type="button" class="btn_add btn_export" value="导出查询结果" /> 
           </div>
          </h3>
          <div class="query">
               <span><em>收货商名称：</em><input type="text" class="query_input" value="" placeholder="请输入收货商名称" maxlength="50"/></span>
               <input type="button" class="btn_query" value="查询" id="btn_query"/>
          </div>
         
          <div class="table_box">
               <table class="table_list">
                    <thead>
                       <tr>
                           <th style="min-width: 30px"></th>
                           <th style="min-width: 50px">序号</th>
                           <th style="min-width: 200px">收货商名称</th>
                           <th style="min-width: 100px">收货商简称</th>
                           <th style="min-width: 80px">编号</th>
                           <th style="min-width: 80px">联系人姓名</th>
                           <th style="min-width: 100px">联系电话</th>
                           <th style="min-width: 160px">操作</th>
                           <th style="min-width: 50px">二维码</th>
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
                   <span  class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" ></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em>0</em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <input type="button" value="确定"  class="paging_btn" id="page_btn">
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>     
<script type="text/javascript">
var com_id='<%=SecurityUtils.getCurrentUserCompanyId()%>';
   
   var pageSize=20;
   var totalPage;
   var params = {"newSearch":"<%=newSearch%>"};
   var num=0;//序号
   var queryName="<%=queryName%>";
   var pageNum=parseInt("<%=pageNo%>");
//查询方法  
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
		url:"../inputManage/receiver/queryReceivers/"+pageNum+"/"+pageSize,
		type:"post",
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    data:JSON.stringify(params),
		success:function(result){
			$(".query_input").val(queryName);
				if(result.status==0){
					console.log(result);
					$(".query_input").val(queryName);
					$("tbody").children().remove();
					page(result);
			     	var	totalNum=result.body.totalRecord;
			     	totalPage=result.body.pageCount;
					var list=result.body.resultList;
					for(var i=0;i<list.length;i++){
						num=parseInt((pageNum-1)*pageSize)+parseInt(i+1);
						var id=list[i].id;
						var companyName=isnull(list[i].name);
						var contactsName=isnull(list[i].contactPerson);
						var mobilePhone=isnull(list[i].contactPhone);
						var code=isnull(list[i].code);
						var nameAbbrev=isnull(list[i].nameAbbrev);
						var linkedCompanyId=isnull(list[i].linkedCompanyId);
						var contractFlag=isnull(list[i].contractFlag);
						var flag=""
						if(linkedCompanyId!=""){
							flag='<i class="i_has"></i>';
						}else{
							flag='<i class="i_not"></i>';
						}
						if(contractFlag!=""){
							flag='<i class="i_argee"></i>';
						}
						
						var $tr=$('<tr><td class="td_ser">'+flag+'</i></td><td class="td_ser">'+num+'</td><td>'+isNullForTable(companyName)+'</td><td>'+isNullForTable(nameAbbrev)+'</td><td>'+isNullForTable(code)+'</td><td>'+isNullForTable(contactsName)+'</td><td>'+isNullForTable(mobilePhone)+'</td><td class="td_opera td_ser"><a href="distribute.goods.goods-view?id='+id+'" class="btn_green">查看</a><a href="distribute.goods.goods-editor2?id='+id+'" class="btn_green" id="'+i+'">编辑</a><a href="javascript:void(0)" class="btn_green" rel="popup" link="distribute.goods.iframe-del?id='+id+'&queryName='+encodeURI(encodeURI(queryName))+'&totalNum='+totalNum+'&pageNum='+pageNum+'" title="提示">删除</a></td><td><a href="javascript:void(0)" class="btn_qrcode" rel="popup_qrcode" link="'+com_id+'_'+companyName+'_'+id+'_RECEIVER" title="查看二维码" id="qrcode_i1"><img src="../images/qrcode_small.jpg" /></td></tr>');
						if(i%2==0){
							$tr.addClass("even");
						}
						$("tbody").append($tr);
					}
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
					$("#totalPage em").text(totalPage);
					$("#paging_num").val(pageNum);
			}
				$("#loading").hide();
		},
		error:function(){
			alert("系统异常,数据加载失败");
	    	$("#loading").hide();
		}
	});
}

//回车事件操作查询按钮
document.onkeydown = function(e) {
	 var ev = (typeof event!= 'undefined') ? window.event : e;
	 if(ev.keyCode == 13 ) {
		 $(".btn_query").click();
	 }
	}; 

</script>	

<script type="text/javascript">

function huifu(){
	$(".btn_export").removeAttr("disabled");
}

$(function(){
	//页面加载完成执行查询
	search(pageNum);
	//点击上一页查询
	$(".paging_perv").click(function(){
		params.newSearch="1";
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
		params.newSearch="1";
		if(pageNum==totalPage){
			search(pageNum);
		}else{
			$(".paging_box a").removeClass("default");
			pageNum +=1;
			$("#page"+pageNum).addClass("default");
			search(pageNum);
		}
	});
	//点击首页查询数据
	$(".paging_head").click(function(){
		params.newSearch="1";
		pageNum=1;
		search(pageNum);
	});
	//点击尾页查询数据
	$(".paging_trailer").click(function(){
		params.newSearch="1";
		pageNum=totalPage;
		search(pageNum);
	});
	//点击确定查询数据
	$("#page_btn").click(function(){
		params.newSearch="1";
		var pageNO=$("#paging_num").val().trim();
		if(isNaN(pageNO)){
			pageNum=1;
			search(pageNum);
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
	//点击查询按钮查询数据
	$("#btn_query").click(function(){
		queryName=$(".query_input").val().trim();
		pageNum=1;
		params.name=queryName;
		params.newSearch="1";
		search(pageNum);
	});
	
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
			url: "../inputManage/receiver/queryReceiverExport",
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
</body>
</html>