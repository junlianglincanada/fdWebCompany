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
          <span style="float:left;">收货商名称：</span>
          <input type="text" class="input_code" id="receiver_name" style="width:152px; float:left;margin-left:10px;" value="" onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"
          />
          <input type="button" class="btn_aq" id="query" value="查询" />
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
     			 <p class="paging_box">
                    <span class="paging_perv"><input type="button" value="<< 上一页" class="disabled" id="pre_page"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>"  id="next_page"/></span>
                 </p>
</div>
<script src="../js/jquery-ui.min.js" type="text/javascript"></script>
<script type="text/javascript">
var pageNum=1;
var totalPage;
var totalNum;
var pageSize=20;
var selectid;
var leng;
var params = {};
var sedIdList = new Array();
function search(pageNum){
	var keyWords = $("#receiver_name").val().trim();
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
   			url:"../inputManage/receiver/queryReceiversByName/"+pageNum+"/"+pageSize,
   			success: function(data) {	   	
   				page(data);
   				var resultList=data.body.resultList;
   				$("#contant").children().remove(); 
   				if(leng==0)
   						{for(var i=0;i<resultList.length;i++){
   		   					var id=resultList[i].id;
   		   					var name=resultList[i].name;
   						var $tr=$("<li><p>"+name+"</p></li>");
	   					$tr.data("id",id);
	   					$("#contant").append($tr);	
   						}
   						}else{
   							for(var i=0;i<resultList.length;i++){
   			   					var flag=0;
   			   					var id=resultList[i].id;
   			   					var name=resultList[i].name;
   								for(var k=0;k<leng;k++){	   		   						
   			   				 		if(id != sedIdList[k])
   			   						{
   			   							flag+=1;
   			   						}
   								}
   							
   					if(flag == leng){
   						var $tr=$("<li><p>"+name+"</p></li>");
   		   					$tr.data("id",id);
   		   					$("#contant").append($tr);
   					
   						}else{
   							var $tr=$("<li class='selected'><p>"+name+"</p><i class='i_sed'>已选</i></li>");
		   						$tr.data("id",id);
		   						$("#contant").append($tr);
   						}
   					};
   				};
   				$("#loading").hide();
   			},
   			error: function(data) {
   				alert("加载失败，请重试！");
   				}
		});
	 
}

$(function(){	
	//判断按钮
	var selected = $(window.parent.document).find(".send_names span");
	leng=selected.length;
	for(var i=0;i<selected.length;i++){
		var name = $(selected[i]).children("em").text();
		var id = $(selected[i]).children("p").text();
		var $tr=$("<li class='selected'><p>"+name+"</p><i class='i_sed'>已选</i></li>");
			$tr.data("id",id);
			$("#contant").append($tr);
			sedIdList[i] = id;
	};
	
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
	
	
	
	<%-- url: "../inputManage/receiver/queryReceiversByName/"+pageNum+"/"+pageSize, --%>
	//查询操作
	$("#query").click(function(){
		search(1);
<%-- 		var tourl = "../outputManage/inputManage/receiver/queryReceiversByName/"+pageNum+"/"+pageSize
		var keyWords = $("#receiver_name").val().trim();
		 var Params={'name':keyWords};
		 $.ajax({
	  	 		type:"post",
	  	 	  /*  headers: { 
	  	 	        'Accept': 'application/json',
	  	 	        'Content-Type': 'application/json', 
	  	 	    },  */
	  	 	    dataType:'json',
	   			data:JSON.stringify(Params),	
	   			url:webPath,
	   			success: function(data) {	   	
	   				page(result);
	   				var resultList=data.body.resultList;
	   				$("#contant").children().remove(); 
	   				if(leng==0)
	   						{for(var i=0;i<resultList.length;i++){
	   		   					var id=resultList[i].id;
	   		   					var name=resultList[i].name;
	   						var $tr=$("<li><p>"+name+"</p></li>");
		   					$tr.data("id",id);
		   					$("#contant").append($tr);	
	   						}
	   						}else{
	   							for(var i=0;i<resultList.length;i++){
	   			   					var flag=0;
	   			   					var id=resultList[i].id;
	   			   					var name=resultList[i].name;
	   								for(var k=0;k<leng;k++){	   		   						
	   			   				 		if(id != sedIdList[k])
	   			   						{
	   			   							flag+=1;
	   			   						}
	   								}
	   							
	   					if(flag == leng){
	   						var $tr=$("<li><p>"+name+"</p></li>");
	   		   					$tr.data("id",id);
	   		   					$("#contant").append($tr);
	   					
	   						}else{
	   							var $tr=$("<li class='selected'><p>"+name+"</p><i class='i_sed'>已选</i></li>");
			   						$tr.data("id",id);
			   						$("#contant").append($tr);
	   						}
	   					};
	   					/* <input type="button" class="btn_sel btn_sed" value="已选" disabled="disabled" /> */
	   					/* var addhtml='<li><p class="editor_into">'+name+kong+'</p><input type="button" class="btn_sel" value="选择"></input></li>'; 
	   					var $tr=$("<li><p>"+name+"</p></li>");
	   					$tr.data("id",id);
	   					$("#contant").append($tr);	*/
	   					
	   				};
	   			},
	   			error: function(data) {
	   				alert("加载失败，请重试！");
	   				}
	   		
			}); --%>
	});
	
	
	

	//操作选择
	$(".send_con li").live("click",function(){
		  var sedhtml = '<i class="i_sed">已选</i>' ;
		  if(!$(this).hasClass("selected")){
		  		/* if(!$(this).hasClass("i")){	 */						  						  
				  $(this).addClass("selected");
				  $(this).append(sedhtml);
				  var idd ;
				 /*  var selP = $(".send_con ul.unit_list li.selected p");	 
				  for(var i=0;i<selP.length;i++){ */
					  idd = $(this).data("id"); 
					 /* idd =  $(selP[i]).parent().data("id"); */
					 var selhtml = '<span class="send_checked" ><em>'+ $(this).children("p").text() +'</em><i class="i_del">X</i><p hidden>'+ idd +'</p></span>';
				  	 $(window.parent.document).find(".send_names").append(selhtml);
				  }
				/*   $(window.parent.document).find(".send_names").append(selhtml); */
				  $(window.parent.document).find(".shadow_bg").fadeOut().remove(); 
			      $(window.parent.document).find(".popup_box").fadeOut().remove();
		  
	});

	
/*-------jquery end-------*/
});	
</script>
	
</body>
</html>