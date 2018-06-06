<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
.query span{margin-right:16px;}
.select_s{width:122px; float:left;}
.select_is{width:122px;}
select.select_cs{width:142px; background-position:-80px -122px;}
input.input_date{width:120px;}
</style>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
var pageSize=20;
var pageNum=1;
var totalPage;
var params = {"inputType":"-1"};
var storeList={'61001':'自营店','61002':'加盟店','61003':'承包店'};
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
	console.log(params);
	$.ajax({
		url:"../comRelationship/relationship/queryComRelationshipLedger/"+pageNum+"/"+pageSize,
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
				var input=result.body.mapCount.input;
				var notInput=result.body.mapCount.notInput;
				$("#input").text(input);
				$("#notInput").text(notInput);
				page(result);
				$("#main_table").children().remove();
				var	totalNum=result.body.totalRecord;
				var stores=result.body.resultList;
				
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
				if(stores==null||stores==""){
					$("#loading").hide();
					return;
				}
				for(var i=0;i<stores.length;i++){
					var companyId=isNullForTable(stores[i].companyId);
					var companyType=isnull(stores[i].companyType);
					companyType=storeList[companyType];
					var companyName=isNullForTable(stores[i].companyName);
					var inputCount=isNullForTable(stores[i].inputCount);
					var inputDate=isNullForTable(stores[i].inputDate);
					var recycleCount=stores[i].recycleCount;
					var recyleInputDate=isNullForTable(stores[i].recyleInputDate);
					var row=(pageNum-1)*pageSize+i+1;
					var $tr=$('<tr><td class="td_ser">'+row+'</td><td>'+companyType+'</td><td>'+companyName+'</td><td>'+inputCount+'</td><td>'+inputDate+'</td><td>'+recycleCount+'</td><td>'+recyleInputDate+'</td></tr>');
					if(i%2==0){
						$tr.addClass("even");
					}
					$("#main_table").append($tr);
				}
			}
			$("#loading").hide();
		},
		error:function(e){
			console.log(e);
		}
	});
}
$(function(){
	for(var key in storeList){
		var $option=$('<option value='+key+'>'+storeList[key]+'</option>');
		$("#companyToType").append($option);
	}
	var startDate=calDateByMonth(-1);
	params.startDate=startDate;
	$('#date_start').val(startDate);
	var today=calDateByMonth(0);
	$('#date_ends').val(today);
	params.endDate=today;
	search(pageNum);
	//点击上一页查询
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
	//点击下一页查询
	$(".paging_next").click(function(){
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
			pageNum=parseInt($("#paging_num").val().trim());
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
	//点击查询按钮查询数据
	$(".btn_query").click(function(){
		var companyName=$("#companyName").val().trim()
		params.companyName=companyName;
		params.inputType="1";
		pageNum=1;
		var startDate=$('#date_start').val();
		params.startDate=startDate;
		var endDate=$('#date_ends').val();
		params.endDate=endDate;
		var companyToType=$("#companyToType").val();
		params.companyToType=companyToType;
		search(pageNum);
	});
	$("#input").click(function(){
		params.inputType="1";
		search(pageNum);
	})
	$("#notInput").click(function(){
		params.inputType="0";
		search(pageNum);
	})
	//回车事件
	document.onkeydown= function(e){
		e = e ? e : event; 
		if(e.keyCode == 13){
			$(".btn_query").click();
	 	} 
	}
	/*--日历--*/
	var limitDate=calDateByMonth(-1);
	var dateStartParam={minDate:limitDate,maxDate:calDateByDay(0),btnBar:false,onSetDate:function(){
		$('#date_ends').calendar({minDate:'#date_start',maxDate:calDateByDay(0),btnBar:false});
		var startDate=this.getDate('date');
		var endDate=$('#date_ends').val();
		if(!compareTime(startDate,endDate)){
			$('#date_ends').val("");
		};
	}};
	$('#date_start').calendar(dateStartParam);
	$('#date_ends').calendar({minDate:'#date_start',maxDate:calDateByDay(0),btnBar:false});
	

/*-------jquery end-------*/
});	
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">门店台账录入统计</a></h3>
          <div class="query" style="min-width:890px;">
               <span><em>单位名称：</em><input type="text" class="input_code" value="" id="companyName"/></span>
               <span><em>门店类型：</em>
                     <div class="select_s">
                       <div class="select_is">
                         <select class="select_cs" id="companyToType"> 
                                <option>全部</option>
                         </select>
                       </div>
                     </div>
               </span>
               <span><em>查询日期：</em><input type="text" class="input_date" value="" id="date_start" readonly="readonly" /> - <input type="text" class="input_date"  value="" id="date_ends" readonly="readonly" /></span>
               <input type="button" class="btn_query" value="查询" />
          </div>
          <div class="combined">合计：录入进货台账的门店有<span class="green" ><a href="javascript:void(0)" id="input"></a></span>家，未录入进货台账的门店有<span class="green" ><a href="javascript:void(0)" id="notInput"></a></span>家</div>
          <div class="table_box">
               <table class="table_list" style="min-width:890px;">
                    <thead>
                       <tr>
                           <th style="min-width:30px">序号</th>                                         
                           <th style="min-width:50px">门店类型</th>
                           <th style="min-width:280px">门店名称</th>
                           <th style="min-width:100px">进货台账录入天数</th>
                           <th style="min-width:130px">最近进货台账录入日期</th>
                           <th style="min-width:110px">废弃油台账录入天数</th>
                           <th style="min-width:140px">最近废弃油台账录入日期</th>
                       </tr>
                    </thead>
                    <tbody id="main_table">
                    </tbody>
                 </table>
                 <p class="paging_box">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" ></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em></em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <input type="button" class="paging_btn" value="确 定" id="page_btn"/>
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>
</body>
</html>