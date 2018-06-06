<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>

<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
span.paging_perv input,.paging_box a{margin:0;}
span.num_text{margin-left:0;}
</style>
</head>
<body>
<div class="ifr_box" style="width:480px;padding:0;">
     <div class="send_query">
          <span style="float:left;">供应商名称：</span>
          <input type="text" class="input_code" id="supplierName" style="width:152px; float:left;margin-left:10px;" value="" />
          <input type="button" class="btn_aq" id="query" value="查询" />
          <div class="clear"></div>
      </div>
      <div class="send_con">
           <div class="unit_con">
                 <ul class="unit_list" id="contant">
                     <li>
                         <a href="javascript:void(0)"></a>
                     </li>   
                 </ul>
           </div>
           <div class="clear"></div>      
      </div>
      <div class="paging_box">
           
          <span class="paging_perv"><input type="button" value="<< 上一页" class="disabled"></span>
          <span class="paging_next"><input type="button" value="下一页 >>" /></span>
          
         
     </div>
</div>
 

<script type="text/javascript">
var pageNum=1;
var totalPage;
var totalNum;
var pageSize=20;
var params={};
function search(pageNum){
	var keyWords = $("#supplierName").val().trim();
	 var Params={'name':keyWords};
	 $("#loading").show();
	 $.ajax({
  	 		type:"post",
  	 	    headers: { 
  	 	        'Accept': 'application/json',
  	 	        'Content-Type': 'application/json', 
  	 	    },  
  	 	    dataType:'json',
   			data:JSON.stringify(Params),	
   			url:"../inputManage/supplier/querySuppliersByName/"+pageNum+"/"+pageSize,
   			
   			success: function(result) {
   				$("#loading").hide();
   				if(result.status==0){	
   					console.log(resultList);
   				page(result);
   				$("#contant").children().remove(); 
   				var id=result.body.id;
   				var resultList=result.body.resultList;
   				console.log(resultList);
   				for(var i=0;i<resultList.length;i++){
	   					var id=resultList[i].id;
	   					var name=resultList[i].name;
					var $tr=$("<li><a>"+name+"</li>");
					$tr.data("id",id);
					//alert("id");
					$("#contant").append($tr);	
					$("#loading").hide();
					}
   			}
		
   			},
   			error: function(result) {
   				alert("加载失败，请重试！");
   				}
});

}
$(function(){	
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}	
	search(pageNum);
	//查询操作
$("#query").click(function(){
	var supplierName =$("#supplierName").val().trim();
	params.supplierName=supplierName;
	console.log(params);
	pageNum=1;
	search(pageNum);
});
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
	
});


$(document).ready(function(){
   //弹出窗口宽高控制					   
   function iframe_wh(){	
 
		var par_W = $(window.parent.document).width();
		var ifr_W = $(window.document).find(".ifr_box").width();
		var pos_W = (par_W - ifr_W)/2 ; 
		//alert(par_W);
		$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"540px",left:pos_W +"px",top:25 +"px"});
		$(window.parent.document).find(".popup_iframe").css({height:"492px"});
		
	    $(window).resize(function(){ //对浏览器窗口调整大小进行计数
			  var par_W = $(window.parent.document).width();
			  var ifr_W = $(window.document).find(".ifr_box").width();
			  var pos_W = (par_W - ifr_W)/2 ; 
			  //alert(par_W);
			  $(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"540px",left:pos_W +"px",top:25 +"px"});
		      $(window.parent.document).find(".popup_iframe").css({height:"492px"});

			  return false;
		});
	  
	};
	iframe_wh(); //计算窗口宽度高度的函数
	
	//操作选择
	$(".send_con li").live("click",function(){
		  var sedhtml = '<i class="i_sed">已选</i>' ;					 
		  if(!$(this).hasClass("selected")){							  						  
				 $(this).addClass("selected");
				 $(this).append(sedhtml);
				 var seltext = $(".send_con ul.unit_list li.selected a").text();
				// alert(seltext);
				var suppilerId=$(this).data("id");
				 $(window.parent.document).find("#suppilerId").val(suppilerId);
				 $(window.parent.document).find("#name").val(seltext);
		 	     $(window.parent.document).find(".shadow_bg").fadeOut().remove();
		     	 $(window.parent.document).find(".popup_box").fadeOut().remove();
		   } else {
				 $(this).removeClass("selected");
				 $(this).children("i").remove();
		  }
	});
	
	
});	
</script>
	
</body>
</html>
