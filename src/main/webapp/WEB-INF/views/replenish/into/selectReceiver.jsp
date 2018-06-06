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
</style>
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="ifr_box" style="width:480px;padding:0;">
     <div class="send_query" >
          <div class="clear"></div>
      </div>
       
        <div class="send_con" >
           <div class="unit_con">
                 <ul class="unit_list" id="contant">
<!-- 
                     <li class="selected">
                    	<p>上海耀剑农产品有限公司4</p></td>
         
                      </li>  
                      <li><p>上海耀剑农产品有限公司</p></li>        -->             
                 </ul>
             </div>
          
           <div class="clear"></div>      
      </div>
<%--      			 <p class="paging_box">
                    <span class="paging_perv"><input type="button" value="<< 上一页" class="disabled" id="pre_page"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>"  id="next_page"/></span>
                 </p> --%>
</div>
<script src="../js/jquery-ui.min.js" type="text/javascript"></script>
<script type="text/javascript">
var pageNum=1;
var totalPage;
var totalNum;
var pageSize=20;
var selectid;
var id;
var name;
var leng;
var sedIdList = new Array();
var params = {};
function search(pageNum){
	 var Params={};
	 $("#loading").show();
		$.ajax({
		  	 type:"post",
		  	  headers: {
		  	 	        'Accept': 'application/json',
		  	 	        'Content-Type': 'application/json' 
		  	 	    },
		  	 	    dataType:'json',
		   			data:JSON.stringify(Params),
		   			url: "../inputManage/supplier/querySuppli/"+pageNum+"/"+pageSize,
		   			success: function(data) {
		   				console.log(data);
		   				//alert(resultList[0].1);
		   				page(data);
		   				var resultList=data.body;
		   				$("#contant").children().remove();
		   				for(var i=0;i<resultList.length;i++){
   		   					var id=resultList[i][0];
   		   					var name=resultList[i][1];
   						var $tr=$("<li><p>"+name+"</p></li>");
	   					$tr.data("id",id);
	   					$tr.data("name",name);
	   					$("#contant").append($tr);	
   						}
		   				$("#loading").hide();
		   			},
		   			error: function(data) {
		   				alert("加载失败，请重试！");
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
	
});

$(document).ready(function(){
   //弹出窗口宽高控制			
   
   function iframe_wh(){	
 
		var par_W = $(window.parent.document).width();
		var ifr_W = $(window.document).find(".ifr_box").width();
		var pos_W = (par_W - ifr_W)/2 ; 
		//alert(par_W);
		$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"500px",left:pos_W +"px",top:25 +"px"});
		$(window.parent.document).find(".popup_iframe").css({height:"492px"});
		
	    $(window).resize(function(){ //对浏览器窗口调整大小进行计数
			  var par_W = $(window.parent.document).width();
			  var ifr_W = $(window.document).find(".ifr_box").width();
			  var pos_W = (par_W - ifr_W)/2 ; 
			  //alert(par_W);
			  $(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"500px",left:pos_W +"px",top:25 +"px"});
		      $(window.parent.document).find(".popup_iframe").css({height:"442px"});

			  return false;
		});
	  
	};
	iframe_wh(); //计算窗口宽度高度的函数
	
	

	//查询操作
	$("#query").click(function(){
		search(1);

	});
	//操作选择
	$(".send_con li").live("click",function(){
		  var sedhtml = '<i class="i_sed">已选</i>' ;
		  if(!$(this).hasClass("selected")){
		  		/* if(!$(this).hasClass("i")){	 */
				  $(this).addClass("selected");
				  $(this).append(sedhtml);
				   var idd = $(this).data("id"); 
				   var nameM = $(this).data("name"); 
/* 				   var selhtml = '<span class="send_checked" ><em>'+ $(this).children("p").text() +'</p></span>';
				   var selidhtml = '</em><i class="i_del">X</i><p hidden>'+ idd +'</p></span>'; */
				  	 $(window.parent.document).find("#supplierName").val(nameM);
				  	$(window.parent.document).find("#supplierId").val(idd);
				  }
				  $(window.parent.document).find(".shadow_bg").fadeOut().remove(); 
			      $(window.parent.document).find(".popup_box").fadeOut().remove();
		  
	});

	
});	
</script>
	
</body>
</html>