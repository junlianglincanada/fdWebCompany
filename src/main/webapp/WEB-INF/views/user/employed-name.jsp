<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp"%>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
.paging_box{padding:8px 0;}
</style>
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="ifr_box" style="width:480px;padding:0;">
      <div class="send_query">
          <span style="float:left;">姓名：</span>
          <input type="text" class="input_code" placeholder="请输入从业人员姓名" style="width:152px; float:left;margin-left:10px;" value="" maxlength="50" id="name" />
          <input type="button" class="btn_aq" value="查询" id="queryList" />
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
      <span  class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
         <span class="paging_perv"><input type="button" value="<< 上一页" ></span>
         <span class="paging_next"><input type="button" value="下一页 >>" /></span>
         <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
      </p>
</div>
 

<script type="text/javascript">
var pageSize=20;
var totalPage;
var params = {};
var num=0;//序号
var pageNum=1;
var queryName="";
var pubVisible="";
var webStatus="";
function search(pageNum){
	//params.personName=personName; controller里面没有根据name查询的参数传递，这里传的是一个map，iframe-name中有参数传递！！！
	// queryName=personName;
	$(".paging_head").removeClass("disabled");
	$(".paging_head input").attr("disabled",false);
	$(".paging_perv").removeClass("disabled");
	$(".paging_perv input").attr("disabled",false);
	$(".paging_next").removeClass("disabled");
	$(".paging_next input").attr("disabled",false);
	$(".paging_trailer").removeClass("disabled");
	$(".paging_trailer input").attr("disabled",false);
	$("#loading").show();
	params.name=queryName;
	//params.pubVisible=pubVisible;
	//params.status=webStatus;
	$.ajax({
		url:"../system/userMgr/queryComEmployee/"+pageNum+"/"+pageSize,	
		type:"post",
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    data:JSON.stringify(params),
		success:function(result){
			console.log(result.body);
				if(result.status==0){
					$(".unit_list").children().remove();
					page(result);
			     	totalPage=result.body.pageCount;
					var list=result.body.resultList;
					for(var i=0;i<list.length;i++){	
						var company=list[i];
						var personName=isnull(list[i].personName);	
						var $li=$(' <li><a href="javascript:void(0)">'+personName+'</a></li>');
						$li.data("company",company);
						$(".unit_list").append($li);  
					
					}
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
					$("#totalPage em").text(totalPage);
					$("#paging_num").val(pageNum);
			}
				$("#loading").hide();
		},
		error:function(){
			alert("系统异常,数据加载失败");
	    	$("#loading").hide();
		}
	});
}


$(function(){
	//页面加载完成执行查询
	search(pageNum);
	//点击查询按钮查询数据
	$("#queryList").click(function(){
		//这里更改了click的ID和name；
		queryName=$("#name").val().trim();
		pageNum=1;
		search(pageNum);
	});
	//点击上一页查询
	$(".paging_perv").click(function(){
		if(pageNum==1){
			search(pageNum);
		}else{
			$(".paging_box a").removeClass("default");
			pageNum--;
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
			pageNum++;
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
});
</script>
<script type="text/javascript">
$(document).ready(function(){
   //弹出窗口宽高控制					   
   function iframe_wh(){	
		var par_W = $(window.parent.document).width();
		var ifr_W = $(window.document).find(".ifr_box").width();
		var pos_W = (par_W - ifr_W)/2 ; 
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
	
	//点击公司列表操作选择,且把数据赋值给已选择的选项
	$(".send_con li").live("click",function(){
		  var sedhtml = '<i class="i_sed">已选</i>' ;					 
		  if(!$(this).hasClass("selected")){
			  $(this).addClass("selected");
				 $(this).append(sedhtml);
				 $(window.parent.document).find("#table5 tr:gt(0)").remove();
				 var company=$(this).data("company");
				 //$("#name").val(company.personName);
				 //var companyId=company.companyId;
				 //var personName=isnull(company.personName) ;	
				 // $(".input_code").val(company.personName);
		         //var contactAddress= isnull(company.contactAddress);
				 //var bizCertNumber= isnull(company.bizCertNumber);
				 //var cateringCert=isnull(company.cateringCert) ;
				 var mobilePhone=isnull(company.mobilePhone) ;
				 var jobRole=isnull(company.jobRole) ;
				 var personName=isnull(company.personName) ;
				 var email=isnull(company.email) ;
				 var personId=isnull(company.personId) ;
				 $(window.parent.document).find("#add").hide();
				 $(window.parent.document).find("#selectAdd").show();
				 $(window.parent.document).find("#add_company").hide();
				 $(window.parent.document).find("#update_company").show();
				 //$("#username").val(text.body.username);

				 $(window.parent.document).find("#mobilePhone").text(mobilePhone);
				 $(window.parent.document).find("#jobRole").text(jobRole);				
				 $(window.parent.document).find("#personName").text(personName);
				 $(window.parent.document).find("#email").text(email);
				 $(window.parent.document).find("#personId").text(personId);
				 
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