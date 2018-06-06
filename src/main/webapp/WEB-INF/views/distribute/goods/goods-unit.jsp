<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<script type="text/javascript">
var pageSize=20;
var pageNum=1;
var totalPage;
var companyName="";
var ids=new Array;
function search(pageNum){
	$("#loading").show();
	$(".paging_head").removeClass("disabled");
	$(".paging_head input").attr("disabled",false);
	$(".paging_perv").removeClass("disabled");
	$(".paging_perv input").attr("disabled",false);
	$(".paging_next").removeClass("disabled");
	$(".paging_next input").attr("disabled",false);
	$(".paging_trailer").removeClass("disabled");
	$(".paging_trailer input").attr("disabled",false);
	$.ajax({
		url:"../inputManage/receiver/querySupplierButNotReceiver/"+pageNum+"/"+pageSize,
		type:"post",
		data:{"companyName":companyName},
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
		success:function(result){
			if(result.status==0){
				page(result);
				$(".unit_list").children().remove();
				 var list=result.body.resultList; 
				if(list==""||list==null){
					window.location.href="distribute.goods.goods-nounit";
				}
				for(var i=0;i<list.length;i++){
					var id=list[i].ID;
					var name=list[i].NAME;
					var $li=$('<li><a href="javascript:void(0)">'+name+'</a></li>');
					$li.data("id",id);
					$(".unit_list").append($li);
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
		error:function(){
			alert("系统异常，查询失败");
		}
	});
}
function addCompany(){
	$(":button").attr("disabled",true);
	$("#loading").show();
	$.ajax({
		url:"../inputManage/receiver/addReceiversBySuppliersIds",
		type:"post",
		data:JSON.stringify(ids),
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    success:function(result){
	    	$(":button").attr("disabled",false);
	    	$("#loading").hide();
	    	if(result.status==0){
	    		alert("添加成功");
		    	search(pageNum);
	    	}else{
	    		alert(result.message);
	    	}
	    },
	    error:function(){
	    	$(":button").attr("disabled",false);
	    	$("#loading").hide();
	    	alert("系统异常，保存失败！");
	    }
	})
}
$(function(){
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
	//回车事件
	document.onkeydown= function(e){
		e = e ? e : event; 
		if(e.keyCode == 13){
			$("#page_btn").click();
	 	} 
	}
	//操作选择
	var addremove ='<span class="green">+添加</span>';
	$(".table_box ul.unit_list li").live({
		mouseenter:function() {
		      $(this).append(addremove);     
		},mouseleave:function() {
			  $("span.green").remove();
		}
	});
	
	$(".table_box ul.unit_list li").live("click",function(){
		ids=[];
		if(!$(this).hasClass("selected")){							  						  
			$(this).addClass("selected");
			var id=$(this).data("id");
			ids.push(id);
			addCompany();
		}
	});
	
	$(".btn_query").click(function(){
		$("#loading").show();
		//设置全部参数IDS
		$.ajax({
			url:"../inputManage/receiver/querySupplierButNotReceiver/1/-1",
			type:"post",
			data:{"companyName":companyName},
			dataType:"json",
			async: false,
			headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
			success:function(result){
				if(result.status==0){
					ids=[];
					var list=result.body.resultList;
					for(var i=0;i<list.length;i++){
						var id=list[i].ID;
						ids.push(id);
					}
				}
			},
			error:function(){
				alert("系统异常，查询失败");
			}
		});
		addCompany();
	});
		
		
});	
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="distribute.goods.goods">收货商管理</a> > <a href="#">维护协议单位</a> </h3>
          <div class="table_box" >
               <h4 class="unit_title">以下单位将本企业设为<span class="blue">供应商</span>，是否将其添加为设为<span class="blue">收货商</span> </h4>
               <ul class="unit_list">                       
               </ul>
               <p class="paging_box">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" ></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em></em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <input type="button" class="paging_btn" value="确 定" id="page_btn"/>
                 </p>
               <p class="query_btn" style="margin-top:-10px;">
                  <input type="button" class="btn_query" value="全部添加" />
               </p>
          </div>
     </div>
</div>
</body>
</html>