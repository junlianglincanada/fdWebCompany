<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"  import="java.util.*,java.io.*"%>
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
	String zjType="";
	String zjStatus="";
	String queryName="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null&&null!=paramMap.get("zjType")){
			zjType=paramMap.get("zjType").toString();
		}
		if(paramMap!=null&&null!=paramMap.get("zjStatus")){
			zjStatus=paramMap.get("zjStatus").toString();
		}
		if(paramMap!=null&&null!=paramMap.get("companyName")){
			queryName=paramMap.get("companyName").toString();
		}
	}
%> 
<style type="text/css">
.select_s{width:182px; float:left;}
.select_is{width:182px;}
select.select_cs{width:202px; background-position:-16px -122px;}
</style>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/exception.exception-Certificate">证照预警</a> 
          </h3>
          <h4 class="licenses" style="margin-bottom:10px;" id="company">
          </h4>
          <div class="query">
               <span><em>供应商名称：</em><input type="text" class="query_input" value="" placeholder="请输入供应商名称" maxlength="50"/></span>
                <span><em>证件类型：</em>
					<div class="select_s" style="width: 182px; float: left;">
						<div class="select_is" style="width: 182px;">
							<select class="select_cs"
								style="width: 202px; background-position: -16px -122px;" id="zjType">
								<option value="">请选择证件类型</option>
								<option value="1">工商营业执照</option>
								<option value="4">食品流通许可证</option>
								<option value="3">食品生产许可证</option>
								<option value="2">餐饮服务许可证</option>
								<option value="5">食品经营许可证</option>
							</select>
						</div>
					</div> 
				</span>
				 <span><em>证件状态：</em>
					<div class="select_s" style="width: 182px; float: left;">
						<div class="select_is" style="width: 182px;">
							<select class="select_cs"
								style="width: 202px; background-position: -16px -122px;" id="zjStatus">
								<option value="">全部</option>
								<option value="0">已过期</option>
								<option value="1">快过期</option>
							</select>
						</div>
					</div> 
				</span>
                
               <input type="button" class="btn_query" value="查询" id="btn_query"/>
          </div>
         
          <div class="table_box">
               <table class="table_list">
                    <thead>
                       <tr>
                           <th >序号</th>
                           <th style="min-width: 250px">供应商名称</th>
                           <th style="min-width: 100px">证件类型</th>
                           <th style="min-width: 80px">证件号码</th>
                           <th style="min-width: 80px">到期日期</th>
                           <th style="min-width: 100px">证件状态</th>
                           <th >操作</th>
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
<script type="text/javascript">
   var pageSize=20;
   var totalPage;
   var num=0;//序号
   var totalPage;
   var params = {"newSearch":"<%=newSearch%>"};
   var num=0;//序号
   var zjType=isnull("<%=zjType%>");
   var zjStatus=isnull("<%=zjStatus%>");
   var queryName=isnull("<%=queryName%>");
   var pageNum=parseInt("<%=pageNo%>");
   if(zjType!=""){
	   $("#zjType").val(zjType);
   }
   if(zjStatus!=""){
	   $("#zjStatus").val(zjStatus);
   }
   
   function compareTime(a,b,c) {
		var arr = a.split("-");//证照过期日期
		var starttime = new Date(arr[0], arr[1], arr[2]);
		var starttimes = starttime.getTime();

		var arrs = b.split("-");//b当前时间
		var lktime = new Date(arrs[0], arrs[1], arrs[2]);
		var lktimes = lktime.getTime();
		
		var arrsc = c.split("-");//c当前时间一个月后的时间
		var lktimec = new Date(arrsc[0], arrsc[1], arrsc[2]);
		var lktimesc = lktimec.getTime();


		if (starttimes < lktimes) {
			var status="已过期";
			return status ;
		}
		if (lktimes <= starttimes&&starttimes< lktimesc) {
			var status="快过期";
			return status;
		}
			return false;
	}
   $(function(){
		$("#loading").show();
		$.ajax({
			url:"../certificate/getCertificateById",
			type:"get",
			dataType:'json',
			success:function(result){
				$(".query_input").val(queryName);
				$("#company").children().remove();
				console.log(result);
				var company=result.body.restaurant;
				var date=result.body.date;
				var date1=result.body.date1;
/* 				var companyName=isnull(company.companyName);
				var cateringCert=isnull(company.cateringCert);
				var foodProdCert=isnull(company.foodProdCert);
				var foodCircuCert=isnull(company.foodCircuCert);
				var bizCertNumber=isnull(company.bizCertNumber);
				 */
				var bizCertExpDate=isnull(company.bizCertExpDate);
				var cateringCertExpDate=isnull(company.cateringCertExpDate);
				var foodProdCertExpDate=isnull(company.foodProdCertExpDate);
				var foodCircuCertExpDate=isnull(company.foodCircuCertExpDate);
				var foodBusinessCertExpDate=isnull(company.foodBusinessCertExpDate);
				var status="";
				
				if(bizCertExpDate!=""){
					if(compareTime(bizCertExpDate,date,date1)!=false){
						status=compareTime(bizCertExpDate,date,date1);
						$("#company").append('本单位,<span>工商营业执照</span><span class="red">&nbsp;&nbsp;'+status+'</span><span>（到期日期'+bizCertExpDate+'）</span><a href="javascript:(0)" class="green"> 查看详情</a></br>');
					}
				}
				if(cateringCertExpDate!=""){
					if(compareTime( cateringCertExpDate,date,date1)!=false){
						status=compareTime(cateringCertExpDate,date,date1);
						$("#company").append('本单位,<span>餐饮服务许可证</span><span class="red">'+status+'</span><span>（到期日期'+cateringCertExpDate+'）</span><a href="javascript:(0)" class="green"> 查看详情</a></br>');
					}
				}
				if(foodProdCertExpDate!=""){
					if(compareTime( foodProdCertExpDate,date,date1)!=false){
						status=compareTime(foodProdCertExpDate,date,date1);
						$("#company").append('本单位,<span>食品生产许可证</span><span class="red">'+status+'</span><span>（到期日期'+foodProdCertExpDate+'）</span><a href="javascript:(0)" class="green"> 查看详情</a></br>');
					}
				}
				if(foodCircuCertExpDate!=""){
					if(compareTime(foodCircuCertExpDate,date,date1)!=false){
						status=compareTime(foodCircuCertExpDate,date,date1);
						$("#company").append('本单位,<span>食品流通许可证</span><span class="red">'+status+'</span><span>（到期日期'+foodCircuCertExpDate+'）</span><a href="javascript:(0)" class="green"> 查看详情</a></br>');
					}
				}
				if(foodBusinessCertExpDate!=""){
					if(compareTime(foodBusinessCertExpDate,date,date1)!=false){
						status=compareTime(foodBusinessCertExpDate,date,date1);
						$("#company").append('本单位,<span>食品经营许可证</span><span class="red">'+status+'</span><span>（到期日期'+foodBusinessCertExpDate+'）</span><a href="javascript:(0)" class="green"> 查看详情</a></br>');
					}
				}
				$("#company a").attr("rel","findView/system.account.account-view");
				$("#company a").attr("my_href","qyxx");
				
				$("#loading").hide();
			}
		});
	})  ;
   
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
	params.companyName=queryName;
	$.ajax({
		url:"../certificate/getCertificateWarningById/"+pageNum+"/"+pageSize,
		type:"post",
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    data:JSON.stringify(params),
		success:function(result){
			console.log(result);
			$("#loading").hide();
				if(result.status==0){
					$("tbody").children().remove();
					page(result);
			     	var	totalNum=result.body.totalRecord;
			     	totalPage=result.body.pageCount;
					var list=result.body.resultList;
					for(var i=0;i<list.length;i++){
						var tr="";
						var n=0;
						num=parseInt((pageNum-1)*pageSize)+parseInt(i+1);
						  var companyName=isnull(list[i].companyName);
						  var id=list[i].id;
						  var bizCert=isnull(list[i].bizCert);
					 	  var bizCertExpDate=isnull(list[i].bizCertExpDate);
					 	  var bizStatus=isnull(list[i].bizStatus);
					 	  
					 	  var cateringCert=isnull(list[i].cateringCert);
						  var cateringCertExpDate=isnull(list[i].cateringCertExpDate);
						  var cateringStatus=isnull(list[i].cateringStatus);
						  
						  var foodCircuCert=isnull(list[i].foodCircuCert);
						  var foodCircuCertExpDate=isnull(list[i].foodCircuCertExpDate);
						  var foodCircuCertStatus=isnull(list[i].foodCircuCertStatus);
						  
						  var foodProdCert=isnull(list[i].foodProdCert);
						  var foodProdCertExpDate=isnull(list[i].foodProdCertExpDate);
						  var foodProdStatus=isnull(list[i].foodProdStatus);
						  
						  var foodBusinessCert=isnull(list[i].foodBusinessCert);
						  var foodBusinessCertExpDate=isnull(list[i].foodBusinessCertExpDate);
						  var foodBusinessStatus=isnull(list[i].foodBusinessStatus);						  
						  
						  
						  var typeWeb="";
						  var numberWeb="";
						  var dateWeb="";
						  var statusWeb="";
						  if(bizCertExpDate!=""){
							  typeWeb="工商营业执照";
							  numberWeb=bizCert;
							  dateWeb=bizCertExpDate;
							  statusWeb=bizStatus;
							  n++;
						  }
						 
						  if(cateringCertExpDate!=""){
							  if(n==0){
								  typeWeb="餐饮服务许可证";
								  numberWeb=cateringCert;
								  dateWeb=cateringCertExpDate;
								  statusWeb=cateringStatus;
							  }else{
								  tr = tr+"<tr><td>餐饮服务许可证</td><td>"+isNullForTable(cateringCert)+"</td><td>"+isNullForTable(cateringCertExpDate)+"</td><td class='td_ser'>"+isNullForTable(cateringStatus)+"</td></tr>";
								  
							  }
							  n++;
						  }
						 
						  if(foodCircuCertExpDate!=""){
							  if(n==0){
								  typeWeb="食品流通许可证";
								  numberWeb=foodCircuCert;
								  dateWeb=foodCircuCertExpDate;
								  statusWeb=foodCircuCertStatus;
							  }else{
								  tr = tr+"<tr><td>食品流通许可证</td><td>"+isNullForTable(foodCircuCert)+"</td><td>"+isNullForTable(foodCircuCertExpDate)+"</td><td class='td_ser'>"+isNullForTable(foodCircuCertStatus)+"</td></tr>";
							  }
							  n++;
							 
						  }
						  
						  if(foodProdCertExpDate!=""){
							  if(n==0){
								  typeWeb="食品生产许可证";
								  numberWeb=foodProdCert;
								  dateWeb=foodProdCertExpDate;
								  statusWeb=foodProdStatus;
							  }else{
								  tr =tr+"<tr><td>食品生产许可证</td><td>"+isNullForTable(foodProdCert)+"</td><td>"+isNullForTable(foodProdCertExpDate)+"</td><td class='td_ser'>"+isNullForTable(foodProdStatus)+"</td></tr>";
							  }
							  n++;
						
						  }
						  
						  if(foodBusinessCertExpDate!=""){
							  if(n==0){
								  typeWeb="食品经营许可证";
								  numberWeb=foodBusinessCert;
								  dateWeb=foodBusinessCertExpDate;
								  statusWeb=foodBusinessStatus;
							  }else{
								  tr =tr+"<tr><td>食品经营许可证</td><td>"+isNullForTable(foodBusinessCert)+"</td><td>"+isNullForTable(foodBusinessCertExpDate)+"</td><td class='td_ser'>"+isNullForTable(foodBusinessStatus)+"</td></tr>";
							  }
							  n++;
						
						  }
						 var trData =$("<tr><td class='td_ser screm' rowspan="+n+">"+num+"</td><td class='td_ser screm' rowspan="+n+">"+isNullForTable(companyName)+"</td><td>"+isNullForTable(typeWeb)+"</td><td>"+isNullForTable(numberWeb)+"</td><td>"+isNullForTable(dateWeb)+"</td><td class='td_ser'>"+isNullForTable(statusWeb)+"</td>"+
						 "<td class='td_opera screm' rowspan="+n+" syle='vertical-align: middle;'><a href='javascript:(0);' my_href='gysgl' rel='findView/replenish.supplier.supplier-view?id="+id+"' class='btn_green'>查看</a></td></tr>");
						 var $tr=$(tr);
						 
						if(i%2==0){
							trData.addClass("even");
							$tr.addClass("even");
						}
						$("tbody").append(trData);
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
		params.newSearch="1";
		queryName=$(".query_input").val().trim();
		zjType=$("#zjType").val();
		zjStatus=$("#zjStatus").val();
		pageNum=1;
		params.companyName=queryName;
		params.zjType=zjType;
		params.zjStatus=zjStatus;
		search(pageNum);
	});
	
	$("tbody").on("click",".btn_green",function(){
		tabNav(this);
		return false;
	})
	
	$("#company").on("click","a",function(){
		tabNav(this);
		return false;
	});
});
</script> 
</body>
</html>