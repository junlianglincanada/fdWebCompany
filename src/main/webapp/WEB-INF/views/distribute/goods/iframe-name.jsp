<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp"%>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
.paging_box{padding:8px 0;}
</style>
<script type="text/javascript">
var pageSize=20;
var pageNum=1;
var totalPage;
var companyName=null;
var params = {};
//查询方法
function search(pageNum){
	queryName=companyName;
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
		url:"../inputManage/receiver/queryLinkCompany/"+pageNum+"/"+pageSize,
		type:"post",
		dataType:"json",
	    data:{"companyName":queryName},
		success:function(result){
			if(result.status==0){
	    		console.log(result.body);
	    		page(result);
	    		$(".assoc_list dd").remove();
	    		var resultList=result.body.resultList;
	    		for(var i=0;i<resultList.length;i++){
					var companyName = isNullForTable(resultList[i].companyName);
					var companyAddress = isNullForTable(resultList[i].contactAddress);
					var nameAbbrev = isNullForTable(resultList[i].nameAbbrev);
					var cert="";
					var bizCertNumber=isnull(resultList[i].bizCertNumber);
					var cateringCert=isnull(resultList[i].cateringCert);
					var foodBusinessCert=isnull(resultList[i].foodBusinessCert);
					var foodCircuCert=isnull(resultList[i].foodCircuCert);
					var foodProdCert=isnull(resultList[i].foodProdCert);
					if(bizCertNumber!=""){
						cert="工商证："+bizCertNumber;
					}else if(foodProdCert!=""){
						cert="生产证："+foodProdCert;
					}else if(foodCircuCert!=""){
						cert="流通证："+foodCircuCert;
					}else if(foodBusinessCert!=""){
						cert="经营证："+foodBusinessCert;
					}else if(cateringCert!=""){
						cert="餐饮证："+cateringCert;
					}else{
						cert="&nbsp;";
					}
					var content='<dd>';
					content+='<span class="aq_td1">'+companyName+'</span>';
					content+='<span class="aq_td2">'+nameAbbrev+'</span>';
					content+='<span class="aq_td3">'+cert+'</span>';
					content+='<span class="aq_td4">'+companyAddress+'</span>';
					content+='</dd>';
					var $tr=$(content);
					$tr.data("company",resultList[i]);
					if(i%2==0){
						$tr.addClass("even");
					}
					$(".assoc_list").append($tr);
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
			$("#loading").hide();
			alert("系统异常,数据加载失败");
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
	$(".btn_aq").click(function(){
		companyName=$(".input_code").val().trim();
		pageNum=1;
		search(pageNum);
	});
	//弹出窗口宽高控制					   
	function iframe_wh(){	
		var par_W = $(window.parent.document).width();
		var ifr_W = $(window.document).find(".ifr_box").width();
		var pos_W = (par_W - ifr_W)/2 ; 
		//alert(par_W);
		$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"480px",left:pos_W +"px",top:20 +"px"});
		$(window.parent.document).find(".popup_iframe").css({height:"432px"});
	    $(window).resize(function(){ //对浏览器窗口调整大小进行计数
			  var par_W = $(window.parent.document).width();
			  var ifr_W = $(window.document).find(".ifr_box").width();
			  var pos_W = (par_W - ifr_W)/2; 
			  //alert(par_W);
			  $(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"480px",left:pos_W +"px",top:20 +"px"});
		      $(window.parent.document).find(".popup_iframe").css({height:"432px"});
			  return false;
		});
	};
	iframe_wh(); //计算窗口宽度高度的函数	
	
	//点击公司列表操作选择
	$(".assoc_list dd").live("click",function(){
		var company=$(this).data("company");
		var companyId=company.companyId;
		var companyName=isnull(company.companyName) ;	
        var contactAddress= isnull(company.contactAddress);
		var cateringCert= isnull(company.cateringCert);
		var bizCertNumber= isnull(company.bizCertNumber);
		var foodCircuCert=isnull(company.foodCircuCert);
		var foodProdCert=isnull(company.foodProdCert);
		var foodBusinessCert = isnull(company.foodBusinessCert);
		$(window.parent.document).find("#table5 tr:gt(0)").remove();
		$(window.parent.document).find(".text_ts").remove();
		$(window.parent.document).find("#add").hide();
		$(window.parent.document).find("#selectAdd").show();
		$(window.parent.document).find("#add_company").hide();
		$(window.parent.document).find("#update_company").show();
		$(window.parent.document).find("#companyId").text(companyId);
		$(window.parent.document).find("#companyName").text(companyName);
		$(window.parent.document).find("#companyAddress").text(contactAddress);
		if(cateringCert!=""||bizCertNumber!=""||foodCircuCert!=""||foodProdCert!=""||foodBusinessCert!=""){
			if(foodBusinessCert!=""){
				var certType="食品经营许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span>'+certType+'</span><span style="margin-left:10px;">'+foodBusinessCert+'</span></td></tr>');
				$(window.parent.document).find("#table5").append($tr);
			}
			if(foodProdCert!=""){
				var certType="食品生产许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span>'+certType+'</span><span style="margin-left:10px;">'+foodProdCert+'</span></td></tr>');
				$(window.parent.document).find("#table5").append($tr);
			}
			if(foodCircuCert!=""){
				var certType="食品流通许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span>'+certType+'</span><span style="margin-left:10px;">'+foodCircuCert+'</span></td></tr>');
				$(window.parent.document).find("#table5").append($tr);
			}
			if(cateringCert!=""){
				var certType="餐饮服务许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span>'+certType+'</span><span style="margin-left:10px;">'+cateringCert+'</span></td></tr>');
				$(window.parent.document).find("#table5").append($tr);
			}
			if(bizCertNumber!=""){
				var certType="工商营业执照";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span>'+certType+'</span><span style="margin-left:10px;">'+bizCertNumber+'</span></td></tr>');
				$(window.parent.document).find("#table5").append($tr);
		    }
			$(window.parent.document).find("#table5 tr:eq(1) td:eq(0)").html('<em class="star">*</em>证件类型');
		}else{
			var $tr=$('<tr><td class="td_lf"><em class="star">*</em>证件类型</td><td><span></span><span style="margin-left:10px;"></span></td></tr>');
			$(window.parent.document).find("#table5").append($tr);
		}
    	$(window.parent.document).find(".shadow_bg").fadeOut().remove();
		$(window.parent.document).find(".popup_box").fadeOut().remove();  
	});
});	
</script>
</head>
<body>
<div class="ifr_box" style="width:1000px;padding:0;">
     <div class="assoc_query">
          <div class="aq_search">
               <span>单位名称或店招名：</span>
               <input type="text" class="input_code" value="" id="companyName"/>
               <input type="button" class="btn_aq" value="查询" />
          </div>
      </div>
      <div class="assoc_con">
           <dl class="assoc_list">
               <dt>
                   <span class="aq_th1">单位名称</span>
                   <span class="aq_th2">店招名</span>
                   <span class="aq_th3">证件号码</span>
                   <span class="aq_th4">单位地址</span>
               </dt>
           </dl>   
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
</body>
</html>