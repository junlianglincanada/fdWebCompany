<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%-- <%@ page session="false"%> --%>
<% 
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String recycleDate="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null&&null!=paramMap.get("recycleDate")){
			recycleDate=paramMap.get("recycleDate").toString();
		}
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<title>万达食品安全追溯系统</title>
<style type="text/css">
input.btn_green{ display:inline-block;font:12px/22px 'Simsun'; color:#fff; background:#BBBEB9; border-radius:4px; padding:0 7px; margin:0 3px;border: none;}
@-moz-document url-prefix(){input.btn_green{padding:0 5px;margin:1px;}}
</style>
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>

<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/recycle.kitchen.kitchen">餐厨垃圾</a>  
          
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="新增台账" onClick="window.location.href='../findView/recycle.kitchen.kitchen-add'" />   
              </div>
          </h3>
         <div class="query">
                  <span>
                      <em class="td_lf">回收日期：</em>
                      <input type="text" class="input_date" id=recycleDate placeholder="请选择回收日期" readonly="readonly" /></span>
                      <input type="button" class="btn_query" value="查询" />
 
          </div>
          <div class="table_box">
               <table class="table_list" >
                    <thead>
                       <tr>
                           <th>序号</th>                
                           <th>回收日期</th>
                           <th>回收单位</th>
                          <!--  <th>种类</th>   -->                        
                           <th>数量（单位）</th>                          
						   <th>回收单据</th>
						   <th>回收人</th>
						   <th >操作</th>
                       </tr>
                    </thead>
                    <tbody  id="aa">

                    </tbody>
                 </table>
                 <p class="paging_box">
                    <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                    <span class="paging_perv"><input type="button" value="<< 上一页" id="pre_page"></span>
                    <span class="paging_next"><input type="button" value="下一页 >>" id="next_page" /></span>
                    <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                    <span class="num_text" id="totalPage" >共<em></em>页</span>  
                    <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                    <span id="page_btn"><input type="button" class="paging_btn" value="确定"  ></span> 
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>    
 
<script type="text/javascript">
var companyWasteRecycleId;
var totalPage;
var totalNum;
var pageSize=20;
var params = {"newSearch":"<%=newSearch%>"};
var pageNum=parseInt("<%=pageNo%>");
var recycleDateHistory="<%=recycleDate%>";
var num;
var inputDate;
$('#recycleDate').calendar();
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
	//这里是查询的参数赋值
	var recycleDate=$("#recycleDate").val();
    params.recycleDate=recycleDate;
	$.ajax({
	url: "../restaurant/cleanWasteComMgr/listWasteRecycleRecord/"+pageNum+"/"+pageSize,
	
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params),
	success:function(result) {
		$("#loading").hide();
			page(result);
			var resultList=[];
			if(result.body!=null){
				totalNum=result.body.totalRecord;
				resultList=result.body.resultList;
			}
			$("#aa").children().remove();
			//console.log(resultList);
			for(var i=0;i<resultList.length;i++){
				var num=i+1;
				var id=resultList[i].id;
				var recycleDate=isNullForTable(resultList[i].recycleDate);
				var recycleCompanyName=isNullForTable(resultList[i].recycleCompanyName);
				var amount=isNullForTable(resultList[i].amount);
				var unitValue=isNullForTable(resultList[i].unitValue);
				//var unit=isnull(resultList[i].unit);
				var attachListSize=resultList[i].attachListSize;
				//var department=isnull(resultList[i].department);
				var recyclePerson=isNullForTable(resultList[i].recyclePerson);
				var s=amount+unitValue;
				var $tr=$('<tr><td>'+((pageNum-1)*pageSize+num)+'</td><td>'+recycleDate+'</td><td>'+recycleCompanyName+'</td><td>'+s+'</td><td>'+attachListSize+'</td><td>'+recyclePerson+'</td><td class="td_opera"><a href="../findView/recycle.kitchen.kitchen-view?id='+id+'" class="btn_green">查看</a><a href="../findView/recycle.kitchen.kitchen-editor?id='+id+'" class="btn_green">编辑</a><a href="javascript:void(0)" class="btn_green" rel="popup" link="../findView/recycle.kitchen.kitchen-del?id='+id+'" title="提示">删除</a></td></tr>');
				if(i%2==0){
					$tr.addClass("even");
				}
				if(recycleDate!=""){
					var startDate=calDateByDay(-32);
					var endDate=calDateByDay(10);
					if(compareTime(recycleDate.substring(0,10),startDate)||compareTime(endDate,recycleDate.substring(0,10))){
						$tr.find("a").remove();
						$tr.find(".td_opera").append("<a href='../findView/recycle.kitchen.kitchen-view?id="+id+"' class='btn_green'>查看</a><input type='button' class='btn_green' value='编辑' /> <input type='button' class='btn_green' value='删除'/>");
					}
				}
				$("#totalPage em").text(totalPage);
				$("#aa").append($tr);
				
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
	 },                               
	 error:function(text) {
		 alert("系统异常，查询失败！");
	 }
	});
}
$(function(){
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
	$("#recycleDate").val(recycleDateHistory);
	search(pageNum);
	
	//上一页
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
	//下一页
	$(".paging_next").click(function(){
		
		 console.log(pageNum+":test1");
		 console.log(totalPage+":test2");
		 if(pageNum<totalPage){
				$(".paging_box a").removeClass("default");
				pageNum +=1;
				$("#page"+pageNum).addClass("default");
				params.newSearch="1";
				search(pageNum); 
		 }else if(pageNum==totalPage){
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
			var pageNO=$("#paging_num").val().trim();
			if(isNaN(pageNO)){
				return;
			}else{
				pageNum=$("#paging_num").val().trim();
				if(pageNum==null||pageNum==""||pageNum=="null"){
					pageNum=1;
					params.newSearch="1";
					search(pageNum);
				}else if(pageNum<1){
					pageNum=1;
					params.newSearch="1";
					search(pageNum);
				}else  if(pageNum>totalPage){
					pageNum=totalPage;
					params.newSearch="1";
					search(pageNum);
				}else{
					pageNum=parseInt(pageNum);
					params.newSearch="1";
					search(pageNum);	
				}
			}
			
		});
		//查询
		$(".btn_query").click(function(){
			$("#aa").children().remove();
			
			pageNum=1;
			params.newSearch="1";
			search(pageNum);
		});
	});
	
	function deleteLoginUser(id){
		if(username!=null){
			$.ajax({
				url:"../restaurant/cleanWasteComMgr/deleteWasteRecycleRecord/"+id,
				type:"get",
			    headers: { 
			        'Accept': 'application/json',
			        'Content-Type': 'application/json' 
			    },
			    dataType:'json',
				data:null,
				success:function(text) {
					
					if(text.status==0){
						  location.href="../findView/recycle.kitchen.kitchen";
					}
			       
				 },   
				 error:function(text) {
//			 		 setTimeout(function(){
//			 			 loading.hide();//隐藏遮罩
//			 		 },100);
					$("#table_jg").html("数据加载失败！！");	
				 }
				});
		} 
}
	



</script>

</body>
</html>