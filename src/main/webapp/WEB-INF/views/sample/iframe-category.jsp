<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../include.jsp" %>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
span.paging_perv input,.paging_box a{margin:0;}
ul.unit_list li{ height:auto; line-height:30px; padding-right:50px;}
.paging_box{padding:8px 0;}
</style>
<script type="text/javascript">
var id="<%=id %>";
var pageSize=20;
var pageNum=1;
var totalPage;
var params = {};
function search(pageNum){
	$("#loading").show();
	$.ajax({
		url:"../outputManage/outputMaterial/queryOutputMaterials/"+pageNum+"/"+pageSize,
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
	//产出品类型
	$.ajax({
		url:"../inputManage/inputMaterial/getAllGeneralType",
		headers: { 
           'Accept': 'application/json',
           'Content-Type': 'application/json' 
    	},
		type: "get",
		data:"json",
		success:function(text){
			$.each(text,function(id,itemList){
				if(id!="9000"){
					$("#selectqx").append("<option value='"+id+"'>"+itemList+"</option>");
				}
			});	
		}
	}); 
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
		var typeGeneral=$("#selectqx").val();
		params.typeGeneral=typeGeneral;
		var name=$("#name").val();
		params.name=name;
		search(pageNum);
	})
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
			  $(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"490px",left:pos_W +"px",top:25 +"px"});
		      $(window.parent.document).find(".popup_iframe").css({height:"442px"});
			  return false;
		});
	};
	iframe_wh(); //计算窗口宽度高度的函数
	
	//操作选择--程序开发改写
	//var samples_href = $(window.parent.document).find("#iframe_popup").attr("src");
	//var samples_name = samples_href.substring(samples_href.lastIndexOf('=')+1,samples_href.length);
	$(".unit_con li").live("click",function(){
		  var sedhtml = '<i class="i_sed">已选</i>' ;					 
		  if(!$(this).hasClass("selected")){							  						  
				 $(this).addClass("selected");
				 $(this).append(sedhtml);
				 var seltext = $(this).find("a").text();
				 $(window.parent.document).find("#"+id).val(seltext);
                 $(window.parent.document).find(".shadow_bg").fadeOut().remove(); 
			     $(window.parent.document).find(".popup_box").fadeOut().remove();
		   } else {
				 $(this).removeClass("selected");
				 $(this).children("i").remove();
		   }
	});
	
	
/*-------jquery end-------*/
});	
</script>
</head>
<body>
<div class="ifr_box" style="width:480px;padding:0;">
     <div class="assoc_query" style="height:30px;background:#dcdddd; padding:10px 15px;">
               <span style="float:left;">类型：</span>
               <div class="select_s" style="width:152px; float:left;">
                    <div class="select_is" style="width:152px;">
                        <select class="select_cs" style="width:172px; background-position:-46px -122px; color:gray;" id="selectqx">
                        <option value="">请选择产品分类</option>
                         </select>
                     </div>
               </div>
               <input type="text" class="input_code" style="width:152px; float:left;margin-left:10px;" value="" id="name"/>
               <input type="button" class="btn_aq" value="查询" />
      </div>
      <div class="assoc_con">
           <div class="unit_con">
               <ul class="unit_list">         
               </ul>
          </div>
          <p class="paging_box">
			<span class="paging_perv"><input type="button" value="<< 上一页"></span>
			<span class="paging_next"><input type="button" value="下一页 >>" /></span>
		</p>
      </div>
</div>
</body>
</html>