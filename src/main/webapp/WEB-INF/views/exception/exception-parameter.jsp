<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"  import="java.util.*,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp"%>	
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/exception.exception-parameter">台帐预警</a> 
          </h3>
          <div class="table_box">
               <table class="table_list">
                    <thead>
                       <tr>
                           <th >序号</th>
                           <th style="min-width: 250px">台帐类型</th>
                           <th style="min-width: 100px">超过天数未录入</th>
                           <th style="min-width: 80px">最近录入日期</th>
                       </tr>
                    </thead>
                    <tbody>
                    </tbody>
                 </table>
             
                 <div class="clear"></div>
          </div>
     </div>
</div>     
<script type="text/javascript">
   var num=0;//序号
//查询方法  
function search(){
	$("#loading").show();
	$.ajax({
		url:"../exception/searchAccountWarning",
		type:"post",
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
		success:function(result){
			console.log(result);
			$("#loading").hide();
		 		if(result.status==0){
					$("tbody").children().remove();
					var list=result.body;
					for(var i=0;i<list.length;i++){
						num=parseInt(i+1);
						 var accountName=isnull(list[i].accountName);
						 var recordDay=isnull(list[i].recordDay);
						 if(recordDay==""){
							 recordDay="未录入";
						 }
						 var lastRecordDate=isnull(list[i].lastRecordDate);
						var $tr=$('<tr><td class="td_ser">'+num+'</td><td class="td_ser">'+isNullForTable(accountName)+'</td><td class="td_ser">'+isNullForTable(recordDay)+'</td><td class="td_ser">'+isNullForTable(lastRecordDate)+'</td></tr>');
						if(i%2==0){
							$tr.addClass("even");
						}
						$("tbody").append($tr);
					}
			}
		},
		error:function(){
			alert("系统异常,数据加载失败");
	    	$("#loading").hide();
		}
	});
}

$(function(){
	search();
});

function isnull(object){
	if(object==null||object==""||object=="null"){
		return "";
		
	}else{
		return object;
	}
}
</script>	

</body>
</html>