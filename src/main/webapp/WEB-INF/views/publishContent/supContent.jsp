<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp"%>
<script type="text/javascript">
var pageNum=1;
var params = {};
var pageSize=20;
var totalPage;
var ids="";
String.prototype.trimcode=function() {
    return this.replace(/(^\,*)|(\,*$)/g,'');
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
		url:"../supNotification/queryNotificationList/"+pageNum+"/"+pageSize,
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
				$("tbody tr").remove();
				page(result);
				var resultList = result.body.resultList;
				for(var i=0;i<resultList.length;i++){
					var row=(pageNum-1)*pageSize+i+1;
					var id = resultList[i].id;
					var status = resultList[i].status;
					var issueDate = isNullForTable(resultList[i].issueDate);
					var contents = isNullForTable(resultList[i].content);
					if(status == 2){
						ids += id+",";
						contents += '<i class="i_new">';
					}
					var issuerName = isNullForTable(resultList[i].issuerName);
					var orgName = isNullForTable(resultList[i].orgName);
					var content='<tr>';
					content+='<td class="td_ser">'+row+'</td>';
					content+='<td class="td_ser">'+issueDate+'</td>';  
					content+='<td style="word-wrap:break-word">'+contents+'</td>';
					content+='<td>'+issuerName+'</td>';
					content+='<td>'+orgName+'</td>';
					content+='</td></tr>';
					var $tr=$(content);
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
				if(ids.length>0){
					$.ajax({
						async:false,
						url:"../supNotification/setNotificationListRead/",
						type:"post",
						data:{"ids":ids.trimcode()},
						dataType:"json",
						success:function(result){
							ids="";
							window.parent.countUnread();
						},
						error:function(e){
							console.log(e);
						}
					});
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
})
</script>
</head>
<body>
	<div class="main_box">
		<div class="main_con">
			<h3 class="process_title">
				<span>当前位置: </span><a href="#">监管提示</a>
			</h3>
			<div class="table_box">
				<div class="table_box">
					<table class="table_list" style="min-width: 800px;">
						<thead>
							<tr>
								<th style="min-width: 30px">序号</th>
								<th style="min-width: 120px">日期</th>
								<th style="min-width: 70px">内容</th>
								<th style="min-width: 68px">发布人</th>
								<th style="min-width: 70px">发布机关</th>
							</tr>
						</thead>
						<tbody>
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
	</div>
</body>
</html>