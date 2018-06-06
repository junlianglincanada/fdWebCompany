<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%@ page session="false"%>
<%@ page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<% 
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String queryName="";
	String startDate="";
	String endDate="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null&&null!=paramMap.get("name")){
			queryName=paramMap.get("name").toString();
		}
		if(paramMap!=null&&null!=paramMap.get("startDate")){
			startDate=paramMap.get("startDate").toString();
		}
		if(paramMap!=null&&null!=paramMap.get("endDate")){
			endDate=paramMap.get("endDate").toString();
		}
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<script src="../js/jquery.qrcode.min.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
 <script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
 <link rel="Stylesheet" href="../js/jquery.autocomplete.css" />
 <script type="text/javascript">
 //var pageNum=1;
 var pageSize=5;
 var totalPage;
 var num;
 var fileServer = "<%=fdWebFileURL%>";
 var endDate;
 var startDate;
 var datas=[];
 var foodPath="<%=fdWebFileURL%>";
 var params = {"newSearch":"<%=newSearch%>"};
 var queryName="<%=queryName%>";
 var pageNum=parseInt("<%=pageNo%>");
 var startDate="<%=startDate%>";
 var endDate="<%=endDate%>";
 
 
 
	 function calDateByMonth(d){ 
	    var now = new Date();
	    var date=new Date(now.getTime()-1000*60*60*24*d);
	    var year = date.getFullYear();       //年
	    var month = date.getMonth() + 1;     //月
	    var day = date.getDate();            //日
	    var clock = year + "-";
	    if(month < 10)
	        clock += "0";
	    clock += month + "-";
	    if(day < 10)
	        clock += "0";
	    clock += day;
	    return(clock); 
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
 


//鼠标经过图片显示编辑
$(".ficate_img").live({
		 mouseenter:function(){
			  $(this).find("a.paper_shadow").show();        
		 }, mouseleave:function(){
			  $(this).find("a.paper_shadow").hide(); 
		}
});


 function search(pageNum){
	 $(".paging_head").removeClass("disabled");
		$(".paging_head input").attr("disabled",false);
		$(".paging_perv").removeClass("disabled");
		$(".paging_perv input").attr("disabled",false);
		$(".paging_next").removeClass("disabled");
		$(".paging_next input").attr("disabled",false);
		$(".paging_trailer").removeClass("disabled");
		$(".paging_trailer input").attr("disabled",false);
		//params.startDate=startDate;
		//params.endDate=endDate;
		$("#loading").show();
		$.ajax({
		url: "../inputManage/inputReceipt/queryInputReceipt/"+pageNum+"/"+pageSize,
		type:"post",
	    headers: { 
	    	'X-CSRF-TOKEN': '${_csrf.token}',
			'Accept': 'application/json',
			'Content-Type': 'application/json'  
	    },
	    dataType:'json',
		data:JSON.stringify(params),
		success:function(result) {
			console.log(result);
			$("#loading").hide();
			if(result.status==0){
				page(result);
				var resultList=result.body.resultList;
				$("#table_box").children().remove();
				for(var i=0;i<resultList.length;i++){					
					var inputDate=isnull(resultList[i].inputDate);
					var name=isnull(resultList[i].name);
					var $div=$('<div class="ficate_con" style="width:800px;"><h4 class="ficate_title"><span>'+inputDate+'</span><span>'+name+'</span></h4><ul class="ficate_list"></ul><div class="clear"></div></div>');
					var attachmentList=isnull(resultList[i].attachmentList);
					
					var inputReceiptId=isnull(resultList[i].inputReceiptId);
					//alert(inputReceiptId);
					//var receiptCount=isnull(resultList[i].receiptCount);														 
					//$tr.data("id",id);
					for(var j=0;j<attachmentList.length;j++){					
						var id=attachmentList[j].id;
						//alert(id);
						
						var filePath=attachmentList[j].filePath;
						filePath=fileServer+filePath;
						//var suppilerId=inputReceiptId;
						//var suppilerId=attachmentList[j].suppilerId;	
						//alert(suppilerId);
						var dataId={"inputReceiptId":inputReceiptId,"id":id}
					    var str = jQuery.param(dataId);
						
						var $li=$('<li><div class="ficate_img"><div class="pape_pic" rel="img"><img src='+filePath+' /></div><a href="replenish.paper.paper-editor?'+str+'" class="paper_shadow"><i></i><em>编辑</em></a></div></li>');
					$div.find("ul").append($li)
					$("#table_box").append($div);
					}
					//var id=resultList[i].id;		
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
		 }
		});
		//二维码生成
		$('#qrcode_i1').qrcode({
			render:"canvas", //设置渲染方式 canvas或table 
			width:80,     //设置宽度  
			height:80,    //设置高度   
			background:"#ffffff", //背景颜色  
			foreground:"#000000", //前景颜色
			text:JSON.stringify({"companyId":<%=SecurityUtils.getCurrentUserCompanyId()%>,"type":"RECEIPT"}) //二维码内容 
			});
		
 }
	 $(function(){
		 
			startDate=calDateByMonth(7);
			params.startDate=startDate;
			console.log(params);
			$('#date_start').val(startDate);
			var today=calDateByMonth(0);
			$('#date_ends').val(today);
			params.endDate=today;
		 $("#supplierName").val(queryName);	
		 /* $("##date_start").val(startDate);	
		 $("#date_ends").val(endDate); */	
		 search(pageNum);
		 
		 
		//使用autocomplete控件快速查询供应商
		 //search(1);
			$("#supplierName").on("keyup", function(){
				var keyWords = $("#supplierName").val().trim(); 
				var Params={'name':keyWords};
					 $.ajax({
					  	 type:"post",
					  	  headers: { 
					  	 	        'Accept': 'application/json',
					  	 	        'Content-Type': 'application/json' 
					  	 	    },
					  	 	    dataType:'json',
					   			data:JSON.stringify(Params),
					   			url: "../inputManage/supplier/querySuppliersByName/"+pageNum+"/"+pageSize,
					   			success: function(data) {
					   				
					   				$('#supplierName').bind("input.autocomplete", function () {
			               							 $(this).trigger('keydown.autocomplete');
			           					 });
					   				$("#supplierName").autocomplete(data.body.resultList,{
					   					minChars: 0,
					   					width: 208,
					   					max:12,
					   					matchContains: true,
					   					autoFill: false,
					   					scroll: false,
					   					dataType: 'json',
					   					
					   					formatItem: function(row, i, max) {
					   						return  "<font color=green>" + row.name + "</font>" ;
					   					},
					   					formatMatch: function(row, i, max) {
					   						return row.name ;
					   					},
					   					formatResult: function(row) {
					   						return row.name;
					   					}
					   				}).result(function(event,data,formatted){
					   					
					   					//var supplierId=data.id;
					  					//if(supplierId!=null&&supplierId!=""){
					  					//	$("#supplierId").val(supplierId);
					  					//	modelId=supplierId;
					  					//	supplierName=$("#supplierName").val().trim();
					   					supplierId=data.id;
					   					$("#supplierId").val(supplierId);
					   		            //alert(data);
					  					//}
					   		        });
					   			},
					   			error: function(data) {
					   				alert("加载失败，请重试！");
					   				}
					   			});
					 });
		 
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
			//点击查询按钮查询数据
			$(".btn_query").click(function(){
				params.newSearch="1";
				queryName=$("#supplierName").val().trim();
				startDate=$("#date_start").val().trim();
				endDate=$("#date_ends").val().trim();
				params.name=queryName;
				params.startDate=startDate;
				console.log(startDate);
				params.endDate=endDate;
				console.log(params);
				pageNum=1;
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
				params.newSearch="1";
				var pageNO=$("#paging_num").val().trim();
				if(isNaN(pageNO)){
					return;
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
	 });
	 
 
 
 </script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">票据管理</a> 
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="新增票据" style="margin-right: 100px;
                  " onClick="window.location.href='../findView/replenish.paper.paper-add'" />
              </div>
          </h3>
          <div class="scanning_qrcode">
               <div class="scanning_img" id="qrcode_i1"><!-- <img src="../images/qrcode_big.jpg" /> --></div>
               <span>扫描上传票据</span>
          </div>
          <div class="query">
               <span><em>供应商名称：</em> <input type="text" class="query_input" placeholder="请输入关键字选择供货商"  autocomplete="" id="supplierName" value=""/></span>
               <span><em>进货日期：</em><input type="text" class="input_date" value="" id="date_start" readonly="readonly" /> - <input type="text" class="input_date"  value="" id="date_ends" readonly="readonly" /></span>
               <input type="button" class="btn_query" value="查询" />
          </div>
          <div class="table_box">
              <div id="table_box"></div>
               <p class="paging_box">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" id="pre_page"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" id="next_page" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em></em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <span id="page_btn"><input class="paging_btn" id="page_btn" type="button" value="确定" style="padding:3px 5px" ></span> 
                 </p>
               <div class="clear"></div>
          </div>
     </div>
</div>    	
<script type="text/javascript">
$(function(){
 /*--日历--*/
	
	var dateStartParam={onSetDate:function(){
		$('#date_ends').calendar({minDate:'#date_start'});
		var startDate=this.getDate('date');
		var endDate=$('#date_ends').val();
		if(!compareTime(startDate,endDate)){
			$('#date_ends').val("");
		};
	}};
	$('#date_start').calendar(dateStartParam);
	$('#date_ends').calendar({minDate:'#date_start'});
	
  
  //鼠标经过图片显示编辑
  $(".ficate_img").live({
		   mouseenter:function(){
			  $(this).find("a.paper_shadow").show();        
		 },mouseleave:function(){
			  $(this).find("a.paper_shadow").hide(); 
		}
  });
  
/*----jquery end-----*/	   
});
</script> 
	
</body>
</html>