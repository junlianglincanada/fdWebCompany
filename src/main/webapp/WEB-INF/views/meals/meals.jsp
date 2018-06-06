<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%@ page session="false"%>
<% 
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String diningCompanyName="";
	String groupMealSeq="";
	String startDate="";
	String endDate="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null){
			if(null!=paramMap.get("diningCompanyName")){
				diningCompanyName=paramMap.get("diningCompanyName").toString();
			}
			if(null!=paramMap.get("groupMealSeq")){
				groupMealSeq=paramMap.get("groupMealSeq").toString();
			}
			if(null!=paramMap.get("startDate")){
				startDate=paramMap.get("startDate").toString();
			}
			if(null!=paramMap.get("endDate")){
				endDate=paramMap.get("endDate").toString();
			}
		}
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../include.jsp" %>
<style type="text/css">
.query span{margin-right:12px;}
.query span input.input_code{width:100px;}
.query span input.input_date{width:80px;}
.select_s{float:left;}
input.btn_green{ display:inline-block;font:12px/22px 'Simsun'; color:#fff; background:#BBBEB9; border-radius:4px; padding:0 7px; margin:0 3px;border: none;}
@-moz-document url-prefix(){input.btn_green{padding:0 5px;margin:1px;}}
</style>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
var pageSize=20;
var pageNum=parseInt("<%=pageNo%>");
var totalPage;
var params = {"newSearch":"<%=newSearch%>"};
var diningCompanyName="<%=diningCompanyName%>";
var groupMealSeq="<%=groupMealSeq%>";
var startDate="<%=startDate%>";
var endDate="<%=endDate%>";
var groupMealSeqs={"":"","62001":"早餐","62002":"中餐","62003":"晚餐","62004":"其他"};
var groupMealTypes={"":"","63001":"自助餐","63002":"桌餐","63003":"简单餐","63004":"每人份餐","63005":"其他"};

function calDateByMonth(m){ 
    var now = new Date();
    var date=new Date(now.getTime()-1000*60*60*24*30*m);
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
		url:"../meal/groupMeal/queryGroupMeals/"+pageNum+"/"+pageSize,
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
				$("#mainTable").children().remove();
				var	totalNum=result.body.totalRecord;
				var meals=result.body.resultList;
				for(var i=0;i<meals.length;i++){
					var id=meals[i].id;
					var row=(pageNum-1)*pageSize+i+1;
					var groupMealDate=isNullForTable(meals[i].groupMealDate);
					var groupMealSeq=groupMealSeqs[isnull(meals[i].groupMealSeq)];
					var diningCompanyName=isNullForTable(meals[i].diningCompanyName);
					var diningCompanyAddress=isNullForTable(meals[i].diningCompanyAddress);
					var diningCount=isNullForTable(meals[i].diningCount);
					var groupMealType=groupMealTypes[isnull(meals[i].groupMealType)];
					var groupMealTypeDesc=isNullForTable(meals[i].groupMealTypeDesc);
					if(groupMealType=="其他"){
						groupMealType=groupMealTypeDesc;
					}
					var content='<tr>';
					content+='<td class="td_ser">'+row+'</td>';
					content+='<td class="td_ser">'+groupMealDate+'</td>';
					content+='<td class="td_ser">'+groupMealSeq+'</td>';
					content+='<td class="td_ser">'+diningCompanyName+'</td>';
					content+='<td class="td_ser">'+diningCompanyAddress+'</td>';
					content+='<td class="td_ser">'+diningCount+'</td>';
					content+='<td class="td_ser">'+groupMealType+'</td>';
					content+='<td class="td_opera">';
					content+='<a href="meals.meals-view?id='+id+'" class="btn_green">查看</a>';
					content+='<a href="meals.meals-editor?id='+id+'" class="btn_green">编辑</a>';
					content+='<a href="javascript:void(0)" class="btn_green" rel="popup" link="meals.iframe-del?id='+id+'" title="提示">删除</a>';
					content+='</td></tr>';
					var $tr=$(content);
					if(groupMealDate!=""){
						var startDate=calDateByDay(-32);
						var endDate=calDateByDay(10);
						if(compareTime(groupMealDate.substring(0,10),startDate)||compareTime(endDate,groupMealDate.substring(0,10))){
							$tr.find("a").remove();
							$tr.find(".td_opera").append("<a href='meals.meals-view?id="+id+"'  class='btn_green'>查看</a> <input type='button' class='btn_green' value='编辑' /> <input type='button' class='btn_green' value='删除'/>");
						}
					}
					if(i%2==0){
						$tr.addClass("even");
					}
					$("#mainTable").append($tr);
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
	$("#date_start").val(startDate);
	$("#date_ends").val(endDate);
	$("#groupMealSeq").val(groupMealSeq);
	$("#diningCompanyName").val(diningCompanyName);
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
		startDate=$("#date_start").val();
		endDate=$("#date_ends").val();
		groupMealSeq=$("#groupMealSeq").val();
		diningCompanyName=$("#diningCompanyName").val();
		params.groupMealSeq=groupMealSeq;
		params.diningCompanyName=diningCompanyName;
		params.startDate=startDate;
		params.endDate=endDate;
		pageNum=1;
		params.newSearch="1";
		search(pageNum);
	});
	$(".btn_export").click(function(){
		$(".btn_export").attr("disabled","true");
		var exportParam={};
		startDate=$("#date_start").val();
		endDate=$("#date_ends").val();
		groupMealSeq=$("#groupMealSeq").val();
		diningCompanyName=$("#diningCompanyName").val();
		exportParam.groupMealSeq=groupMealSeq;
		exportParam.diningCompanyName=diningCompanyName;
		exportParam.startDate=startDate;
		exportParam.endDate=endDate;
		$.ajax({
			url: "../meal/groupMeal/queryGroupMealForExport",
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
	//回车事件
	document.onkeydown= function(e){
		e = e ? e : event; 
		if(e.keyCode == 13){
			$(".btn_query").click();
	 	} 
	}
	/*--日历--*/				   		   
	var limitDate=calDateByMonth(6);
	var dateStartParam={minDate:limitDate,onSetDate:function(){
		$('#date_ends').calendar({minDate:'#date_start'});
		var startDate=this.getDate('date');
		var endDate=$('#date_ends').val();
		if(!compareTime(startDate,endDate)){
			$('#date_ends').val("");
		};
	}};
	$('#date_start').calendar(dateStartParam);
	$('#date_ends').calendar({minDate:'#date_start'});


/*-------jquery end-------*/
});	
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="javascript:void(0)">团膳外卖登记</a>
              <div class="btn_opera"> 
                    <input type="button" class="btn_add" value="新增团膳外卖登记" onClick="window.location.href='../findView/meals.meals-add'" />
                    <input type="button" class="btn_add btn_export" value="导出查询结果" /> 
              </div>
          </h3>
          <div class="query">
               <span><em>供餐日期：</em><input type="text" class="input_date" value="" id="date_start" readonly="readonly"/> - <input type="text" class="input_date"  value="" id="date_ends" readonly="readonly"/></span>
               <span><em>用餐单位：</em><input type="text" class="input_code" value=""/ id="diningCompanyName"></span>
               <span><em>餐次：</em>
                     <div class="select_s" style="width:80px;">
                       <div class="select_is" style="width:80px;">
                         <select class="select_cs" style="width:100px; background-position:-118px -122px;" id="groupMealSeq"> 
                                <option value="">全部</option>
                                <option value="62001">早餐</option>
                                <option value="62002">中餐</option>
                                <option value="62003">晚餐</option>
                                <option value="62004">其他</option>
                         </select>
                       </div>
                     </div>
               </span>
               <input type="button" class="btn_query" value="查询" style="margin-left:30px;" />
          </div>
          <div class="table_box">
               <table class="table_list">
                    <thead>
                       <tr>
                           <th style="width:5%">序号</th>                                         
                           <th style="width:12%">供餐时间</th>
                           <th style="width:5%">餐次</th>
                           <th style="width:20%">用餐单位</th>
                           <th style="width:15%">供餐地点</th>
                           <th style="width:10%">用餐人数</th>
                           <th style="width:10%">供餐方式</th>
                           <th style="width:18%">操作</th>
                       </tr>
                    </thead>
                    <tbody id="mainTable">
                    </tbody>
                 </table>
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