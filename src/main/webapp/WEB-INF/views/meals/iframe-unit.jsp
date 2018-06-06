<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../include.jsp" %>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
span.paging_perv input,.paging_box a{margin:0;}
span.num_text{margin-left:0;}
.paging_box{padding:8px 0;}
</style>
<script type="text/javascript">
var pageSize=20;
var pageNum=1;
var totalPage;
var params = {};
function search(pageNum){
	$("#loading").show();
	$.ajax({
		url:"../inputManage/receiver/queryReceiversByName/"+pageNum+"/"+pageSize,
		type:"post",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    data:JSON.stringify(params),
		dataType:"json",
	    success:function(result){
	    	if(result.status==0){
	    		console.log(result.body);
	    		page(result);
	    		$(".unit_list").children().remove();
	    		var companyId=result.body.companyId;
	    		var list=result.body.resultList;
	    		for(var i=0;i<list.length;i++){
	    			var name=list[i].name;
	    			var $li=$('<li><a href="javascript:void(0)">'+name+'</a></li>');
	    			$li.data("info",list[i]);
	    			$(".unit_list").append($li);
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
	$(".btn_aq").click(function(){
		var name=$("#input_name").val().trim();
		params.name=name;
		pageNum=1;
		search(pageNum);
	})
	
	//弹出窗口宽高控制
	function iframe_wh(){	
		 
		var par_W = $(window.parent.document).width();
		var ifr_W = $(window.document).find(".ifr_box").width();
		var pos_W = (par_W - ifr_W)/2 ; 
		//alert(par_W);
		$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"490px",left:pos_W +"px",top:25 +"px"});
		$(window.parent.document).find(".popup_iframe").css({height:"442px"});
		
	    $(window).resize(function(){ //对浏览器窗口调整大小进行计数
			  var par_W = $(window.parent.document).width();
			  var ifr_W = $(window.document).find(".ifr_box").width();
			  var pos_W = (par_W - ifr_W)/2 ; 
			  //alert(par_W);
			  $(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"490px",left:pos_W +"px",top:25 +"px"});
		      $(window.parent.document).find(".popup_iframe").css({height:"442px"});

			  return false;
		});
	  
	};
	iframe_wh(); //计算窗口宽度高度的函数
	
	//操作选择
	$(".send_con li").live("click",function(){
		  var sedhtml = '<i class="i_sed">已选择</i>' ;					 
		  if(!$(this).hasClass("selected")){							  						  
				$(this).addClass("selected");
				$(this).append(sedhtml);
				var seltext = $(".send_con ul.unit_list li.selected a").text();
				// alert(seltext);
				console.log($(this).data("info"));
				var id=$(this).data("info").id;
				var contactAddress=$(this).data("info").contactAddress;
				var contactPerson=$(this).data("info").contactPerson;
				var contactPhone=$(this).data("info").contactPhone;
				$(window.parent.document).find("#diningCompanyId").text(id);
				$(window.parent.document).find("#diningCompanyName").val(seltext);
				$(window.parent.document).find("#diningCompanyAddress").val(contactAddress);
				$(window.parent.document).find("#diningCompanyContactPerson").val(contactPerson);
				$(window.parent.document).find("#diningCompanyContactPhone").val(contactPhone);
				$(window.parent.document).find(".shadow_bg").fadeOut().remove(); 
				$(window.parent.document).find(".popup_box").fadeOut().remove(); 
		   } else {
				 $(this).removeClass("selected");
				 $(this).children("i").remove();
		  }
	});
});
</script>
</head>
<body>
<div class="ifr_box" style="width:480px;padding:0;">
     <div class="send_query">
          <span style="float:left;">单位名称：</span>
          <input type="text" class="input_code" style="width:152px; float:left;margin-left:10px;" value="" id="input_name" />
          <input type="button" class="btn_aq" value="查询" />
          <div class="clear"></div>
      </div>
      <div class="send_con">
           <div class="unit_con">
                 <ul class="unit_list">                     
                 </ul>
           </div>
           <div class="clear"></div>      
      </div>
      <p class="paging_box">
			<span class="paging_perv"><input type="button" value="<< 上一页"></span>
			<span class="paging_next"><input type="button" value="下一页 >>" /></span>
		</p>
</div>

</body>

</html>