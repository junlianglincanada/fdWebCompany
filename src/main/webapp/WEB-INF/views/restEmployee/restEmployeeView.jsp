<%@page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"  import="java.util.*,java.io.*"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp"%>	
	<% 
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String queryName="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null&&null!=paramMap.get("key")){
			queryName=paramMap.get("key").toString();
		}
	}
%> 
<script src="../js/jquery.qrcode.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/restEmployee.restEmployeeView">从业人员</a> 
              <div class="btn_opera" style="width:520px"> 
              <!-- <a href="#" class="btn_export" style="width:180px;margin-left:20px">按照查询条件导出从业人员</a>   --> 
              <input type="button" class="btn_add" value="新增从业人员" onClick="window.location.href='../findView/restEmployee.restEmployeeAddView'" />
           		<input type="button" class="btn_add btn_export" value="导出查询结果" /> 
           </div>
          </h3>
          <div class="query">
               <span><em>姓名：</em><input type="text" class="query_input" placeholder="请输入从业人员姓名" value="" maxlength="50" id="name"/></span>
               <input type="button" class="btn_query" value="查询" id="queryList"/>
          </div>
         
          <div class="table_box">
               <table class="table_list">
                    <thead>
                       <tr>
                           <th style="min-width: 50x">序号</th>
                           <th style="min-width: 80px">姓名</th>
                           <th style="min-width: 50px">性别</th>
                           <th style="min-width: 110px">岗位</th>
                           <th style="min-width: 100px">手机</th>
                           <th style="min-width: 150px">健康证号</th>
                           <th style="min-width: 70px">到期日期</th>
                           <th style="min-width: 160px">操作</th>
                           <th style="min-width: 50px">二维码</th>
                       </tr>
                    </thead>
                    <tbody>
                    </tbody>
                 </table>
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
</body>
<script type="text/javascript">
   var pageSize=20;
   var totalPage;
   var params = {"newSearch":"<%=newSearch%>"};
   var num=0;//序号
   var queryName="<%=queryName%>";
   var pageNum=parseInt("<%=pageNo%>");
   var pubVisible="";
   var webStatus="";
   var com_id='<%=SecurityUtils.getCurrentUserCompanyId()%>';
function search(pageNum){
	$("#name").val(queryName);
	$(".paging_head").removeClass("disabled");
	$(".paging_head input").attr("disabled",false);
	$(".paging_perv").removeClass("disabled");
	$(".paging_perv input").attr("disabled",false);
	$(".paging_next").removeClass("disabled");
	$(".paging_next input").attr("disabled",false);
	$(".paging_trailer").removeClass("disabled");
	$(".paging_trailer input").attr("disabled",false);
	$("#loading").show();
	params.key=queryName;
	params.pubVisible=pubVisible;
	params.status=webStatus;
	$.ajax({
		url:"../restaurant/comEmployee/queryComEmployee/"+pageNum+"/"+pageSize,
		type:"post",
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    data:JSON.stringify(params),
		success:function(result){
			
			console.log(result.body);
				if(result.status==0){
					$("tbody").children().remove();
					page(result);
			     	totalPage=result.body.pageCount;
					var list=result.body.resultList;
					for(var i=0;i<list.length;i++){
						num=parseInt((pageNum-1)*pageSize)+parseInt(i+1);
						var personId=list[i].personId;
						var personName=isnull(list[i].personName);
						var sexVilue=isnull(list[i].sex);
						var jobRole=isnull(list[i].jobRole);
						var idNumber=isnull(list[i].licenceNum);
						var resignDate=isnull(list[i].licenceNumExpireDate);
						var mobilePhone=isnull(list[i].mobilePhone);
						var $tr=$('<tr id='+personId+'><td class="td_ser">'+num+'</td><td class="td_ser">'+isNullForTable(personName)+'</td><td class="td_ser">'+isNullForTable(sexVilue)+'</td><td class="td_ser">'+isNullForTable(jobRole)+'</td><td class="td_ser">'+isNullForTable(mobilePhone)+'</td><td class="td_ser">'+isNullForTable(idNumber)+'</td><td class="td_ser">'+isNullForTable(resignDate)+'</td><td class="td_ser"><a href="restEmployee.restEmployeeDetailView?id='+personId+'" class="btn_green">查看</a><a href="restEmployee.restEmployee-editer?id='+personId+'" class="btn_green" ">编辑</a><a href="javascript:void(0)" class="btn_green" rel="popup" link="restEmployee.iframe_del?id='+personId+'" title="提示">删除</a></td><td class="td_ser"><a href="javascript:void(0)" class="btn_qrcode" rel="popup_qrcode" link="'+com_id+'_'+personName+'_'+personId+'_EMP" title="查看二维码" id="qrcode_i1"><img src="../images/qrcode_small.jpg" /></td></tr>');
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
	$("#queryList").click(function(){
		params.newSearch="1";
		queryName=$("#name").val().trim();
		pageNum=1;
		search(pageNum);
	});
	
	//回车事件操作查询按钮
	document.onkeydown = function(e) {
		 var ev = (typeof event!= 'undefined') ? window.event : e;
		 if(ev.keyCode == 13 ) {
			 $("#queryList").click();
		 }
		};
		
		$(".btn_export").click(function(){
			$(".btn_export").attr("disabled","true");
			personName=$("#name").val().trim();
			
			var exportParam={};

			exportParam.key=personName;
			exportParam.pubVisible="";
			exportParam.status="";
			
			$.ajax({
				url: "../restaurant/comEmployee/queryComEmployeeExport",
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
</html>
