<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String del=request.getParameter("del")==null?"":request.getParameter("del");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
.select_s{width:182px; float:left;}
.select_is{width:182px;}
select.select_cs{width:212px; background-position:-16px -122px;}
table.table_list td.td_oper{text-align:left;}
</style>
<script type="text/javascript">
var pageSize=20;
var pageNum=1;
var totalPage;
var params = {};
var companyName="";
var storeList={'61001':'自营店/分店','61002':'加盟店','61003':'承包店'};
var companyToType="";
var del=isnull("<%=del%>");
function search(pageNum){
	$(".paging_head").removeClass("disabled");
	$(".paging_head input").attr("disabled",false);
	$(".paging_perv").removeClass("disabled");
	$(".paging_perv input").attr("disabled",false);
	$(".paging_next").removeClass("disabled");
	$(".paging_next input").attr("disabled",false);
	$(".paging_trailer").removeClass("disabled");
	$(".paging_trailer input").attr("disabled",false);
	params.companyName=companyName;
	params.companyToType=companyToType;
	$("#loading").show();
	$.ajax({
		url:"../comRelationship/relationship/queryComRelationship/"+pageNum+"/"+pageSize,
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
				$("tbody").children().remove();
				var	totalNum=result.body.totalRecord;
				var stores=result.body.resultList;
				if(del!=""&&(stores==null||stores.length==0)){
					window.top.location.href="../default.do";
					return false;
				}
				for(var i=0;i<stores.length;i++){
					var id=stores[i].ID;
					var isAccepted=isnull(stores[i].isAccepted);
					var companyIdTo=stores[i].companyIdTo;
					var operation='<a href="javascript:void(0)" class="btn_green" rel="popup" link="chain.mainten.iframe-del?id='+id+'" title="提示">删除</a>'
					if(isAccepted==1){
						isAccepted='<i class="i_has"></i>';
						operation+='<a href="javascript:void(0)" class="btn_green" rel="popup" link="chain.mainten.iframe-detail?id='+companyIdTo+'" title="门店详情">详情</a>';
					}else{
						isAccepted='<i class="i_not"></i>';
					}
					var type=isnull(stores[i].type);
					type='<a href="javascript:void(0)" class="join_editor" rel="popup" link="chain.mainten.iframe-type?id='+id+'&companyType='+type+'" id="join1" title="门店类型">'+storeList[type]+'</a>';
					var companyName=isNullForTable(stores[i].companyName);
					var companyAddress=isNullForTable(stores[i].companyAddress);
					var contactPerson=isNullForTable(stores[i].contactPerson);
					var contactPhone=isNullForTable(stores[i].contactPhone);
					var username=isNullForTable(stores[i].username);
					var row=(pageNum-1)*pageSize+i+1;
					var $tr=$('<tr><td class="td_ser">'+isAccepted+'</td><td class="td_ser">'+row+'</td><td class="td_ser">'+type+'</td><td>'+companyName+'</td><td>'+companyAddress+'</td><td>'+contactPerson+'</td><td>'+contactPhone+'</td><td>'+username+'</td><td class="td_oper">'+operation+'</td></tr>');
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
$(function(){
	for(var key in storeList){
		var $option=$('<option value='+key+'>'+storeList[key]+'</option>');
		$("#companyToType").append($option);
	}
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
		companyName=$("#companyName").val().trim();
		companyToType=$("#companyToType").val();
		pageNum=1;
		search(pageNum);
	});
	//回车事件
	document.onkeydown= function(e){
		e = e ? e : event; 
		if(e.keyCode == 13){
			$(".btn_query").click();
	 	} 
	}
})
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="javascript:void(0)">门店管理</a> 
              <div class="btn_opera">    
                   <input type="button" class="btn_add" value="关联已注册门店" rel="popup" link="chain.mainten.iframe-stores" title="选择门店" />
                   <input type="button" class="btn_add" value="门店注册" onClick="window.location.href='chain.mainten.mainten-reg'" />
              </div>
          </h3>
          <div class="query">
               <span><em>门店名称：</em><input type="text" class="input_code" value="" id="companyName"/></span>
               <span><em>门店类型：</em>
                     <div class="select_s">
                       <div class="select_is">
                         <select class="select_cs" id="companyToType"> 
                                <option>全部状态</option>
                         </select>
                       </div>
                     </div>
               </span>
               <input type="button" class="btn_query" value="查询" />
          </div>
          <div class="table_box">
              <table class="table_list">
                  <thead>
                     <tr>
                         <th style="width:3%"></th>
                         <th style="width:5%">序号</th>                                         
                         <th style="width:8%">门店类型</th>
                         <th style="width:20%">门店名称</th>
                         <th style="width:25%">门店地址</th>
                         <th style="width:10%">联系人</th>
                         <th style="width:10%">联系方式</th>
                         <th style="width:10%">登录账号</th>
                         <th style="width:9%">操作</th>
                     </tr>
                  </thead>
                  <tbody id="tbody">
                  </tbody>
               </table>
               <div class="regunit">
                    <span><i class="i_has"></i><em>已加入</em></span>
                    <span><i class="i_not"></i><em>待加入</em></span>
               </div>
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
          <div class="clear"></div>
     </div>
</div>    
</body>
</html>