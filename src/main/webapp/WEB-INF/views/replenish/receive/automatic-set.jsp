<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%@ page session="false"%>
<% 
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String queryName="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null&&null!=paramMap.get("name")){
			queryName=paramMap.get("name").toString();
		}
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
var pageNum=parseInt("<%=pageNo%>");
var totalPage;
var totalNum;
var pageSize=20;
var params = {"newSearch":"<%=newSearch%>"};
var supplierComName;
var datas=[];
var status;
var Params={};

//查询为关联关系的供应商
function search(pageNum){
	console.log(pageNum);
	$("#loading").show();
	$("input[name='checkall']").attr("checked", false);
	$.ajax({
	url: "../inputManage/supplier/queryRelationSuppliers/"+pageNum+"/"+pageSize,
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params),
	success:function(result) {
		console.log(result);
		if(result.status==0){
			page(result);	
			var resultList=result.body.resultList;
			$("#body").children().remove();
			//console.log(resultList);
			for(var i=0;i<resultList.length;i++){
				var id=resultList[i].id;
				var name=resultList[i].name;
				var nameAbbrev=isnull(resultList[i].nameAbbrev);
				var contactAddress=isnull(resultList[i].contactAddress);
				var isAutoRecv=isnull(resultList[i].isAutoRecv);
				var autoId=id+"auto";
				   var $tr;
		         if(isAutoRecv==1){
		         	 $tr=$("<tr id="+id+"><td class='td_ser'>"+((pageNum-1)*pageSize+i+1)+"</td><td>"+name+"</td><td>"+nameAbbrev+"</td><td>"+contactAddress+"</td><td class='td_opera'> <input id="+autoId+" type='button' class='auto auto_on' value='开关' /></td></tr>");	
		         }else{
		        	 $tr=$("<tr id="+id+"><td class='td_ser'>"+((pageNum-1)*pageSize+i+1)+"</td><td>"+name+"</td><td>"+nameAbbrev+"</td><td>"+contactAddress+"</td><td class='td_opera'> <input id="+autoId+" type='button' class='auto auto_off' value='开关' /></td></tr>");
		         }
				$tr.data("id",id);
				if(i%2==0){
					$tr.addClass("even");
				}
				$("#totalPage em").text(totalPage);
				$("#body").append($tr);
				$("#paging_num").val(pageNum);
		    };
			$("#loading").hide();
			
			 $(".auto").click(function(){
					$("#loading").show();
					var id=$(this).parent().parent().data("id");
					if($(this).hasClass('auto_on')){
						Params.switcher=0;
					}else if($(this).hasClass('auto_off')){
						Params.switcher=1
					}
					Params.intCompanyId=id;
					var autoId=id+"auto";
					console.log(Params);
					receiveAuto(autoId);
				});
		};
		
	 },   
	 error:function(text) {

	 }
	});
}

$(function(){
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
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
	//点击查询按钮查询数据
	$(".btn_query").click(function(){
		//alert(outputDate);
		supplierName =$("#supplierComName").val().trim();
		//alert(supplierName);
		//alert(outputMatName);
		params.name=supplierName;
		pageNum=1;
		params.newSearch="1";
		search(pageNum);
		
	});
	
	document.onkeydown = function(e) {
		//捕捉回车事件
		 var ev = (typeof event!= 'undefined') ? window.event : e;
		 if(ev.keyCode == 13 ) {
			 $(".btn_query").click();
		 };
	};
	
// 	 $(".auto").click(function(){
// 			var id=$(this).parent().parent().data("id");
// 			if($(this).hasClass('auto_on')){
// 				Params.switcher=0;
// 			}else if($(this).hasClass('auto_off')){
// 				Params.switcher=1
// 			}
// 			Params.switcher=1;
// 			Params.intCompanyId=id;
// 			receiveAuto();
// 		});
});

function receiveAuto(autoId){
	//console.log(Params);
	$.ajax({
	url:"../inputManage/inputBatch/switchRelationAutoReceive",
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(Params),
	success:function(result){
		$("#loading").hide();
		if(result.status==0){
			var switcher=Params.switcher;
			 if(switcher==1){
					//alert(switcher);
					$("#"+autoId+"").addClass("auto_on").removeClass("auto_off");
				}else{
					$("#"+autoId+"").addClass("auto_off").removeClass("auto_on");
				}
		}
		else{
			alert("设置开关失败，请稍后再试");
		}
	},
	error:function() {
		 alert("系统异常，设置失败！");
	 }
    
	});
}
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="replenish.receive.receive">自动收货</a> > <a href="javascript:void(null)">设置自动收货</a></h3>
          <div class="query">
               <span><em>供应商名称：</em><input type="text" class="input_code" id="supplierComName" value="" /></span>
               <input type="button" class="btn_query" value="查询" />
          </div>
<!--           <div class="allgoods_operat"> -->
<!--                <div class="receive_btn"> -->
<!--                     <span>全部自动收货</span><input type="button" class="auto_off" value="开关" /> -->
<!--                </div> -->
<!--           </div> -->
          <div class="table_box">
               <table class="table_list" style="min-width:900px;">
                    <thead>
                       <tr>
                           <th>序号</th>                                         
                           <th>供应商名称</th>
                           <th>店招名</th>
                           <th>单位地址</th>
                           <th>自动收货（开关）</th>
                       </tr>
                    </thead>
                    <tbody id="body">
                                    
                    </tbody>
                 </table>
                 <div class="paging_box">
                      <span class="paging_head "><input type="button" class="" value="首页" /></span> 
                      <span class="paging_perv"><input type="button" value="<< 上一页" class="disabled"></span>
                      <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                      <span class="paging_trailer"><input type="button" class="" value="尾页" /></span>
                      <span class="num_text" id="totalPage">共<em>1</em>页</span>  
                      <span class="num_text">跳转 
                            <input type="text" id="paging_num" class="paging_num" value="" onKeyUp="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="5" />
                      </span>
                      <input type="button" class="paging_btn" value="确 定" id="page_btn"/>
                 </div>
                 <div class="clear"></div>
          </div>
     </div>
</div>    
 
<script src="../../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../../js/custome.js" type="text/javascript" charset="utf-8"></script>	
<script type="text/javascript">
$(function(){
   /*--自动收货-开关--*/   
   var _All = $(".receive_btn input[type^='button']");
       _Single = $(".td_opera input[type^='button']");
  //全部
  _All.on("click",function(){   
  	   if(!$(this).hasClass("auto_on")){												   
			 $(this).addClass("auto_on").removeClass("auto_off");
			 _Single.addClass("auto_on").removeClass("auto_off");
	    } else {
			 $(this).removeClass("auto_on").addClass("auto_off");
			 _Single.removeClass("auto_on").addClass("auto_off");
	   }    
  });	
  //单个	
  _Single.on("click",function(){
		if(!$(this).hasClass("auto_on")){												   
			  $(this).addClass("auto_on").removeClass("auto_off"); 
	    } else {
			  $(this).removeClass("auto_on").addClass("auto_off");
	    }				 
	   // if($(this).parent().parent().parent().find(_Single).length == $(this).parent().parent().parent().find(_Single).filter(".auto_on").length){//用filter方法筛选出选中的
		if(_Single.length == _Single.filter(".auto_on").length){//用filter方法筛选出选中的
		      _All.addClass("auto_on").removeClass("auto_off");//console.log(1);
		} else {
		      _All.removeClass("auto_on").addClass("auto_off");//console.log(2);
		}
	  
  });
  
/*-------jquery end-------*/
});	
</script>
	
</body>
</html>