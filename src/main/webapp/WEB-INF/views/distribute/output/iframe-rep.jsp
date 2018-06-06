<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
 <%@ include file="../../include.jsp" %>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
.paging_box{padding:8px 0 0 0;}
</style>
</head>
<body>
<div class="ifr_box" style="width:480px;padding:0;">
     <div class="assoc_query" style="height:32px;background:#dcdddd; padding:15px;">
               <span style="float:left;">类型：</span>
               <div class="select_s" style="width:152px; float:left;">
                    <div class="select_is" style="width:152px;">
                        <select id="selectqx" name="typeGeneral" class="select_cs" style="width:182px; background-position:-46px -122px; color:gray;">
                         </select>
                     </div>
               </div>
               <input type="text" id="materialName" name="materialName" class="input_code" style="width:152px; float:left;margin-left:10px;" value="" />
               <input id="btn_aq_seach" type="button" class="btn_aq" value="查询" />
      </div>
      <div class="assoc_con">
           <div class="unit_con">
               <ul id="unit_list_input" class="unit_list">
<!--                    <li> -->
<!--                        <h5><span name="rep-name">薄荷</span> <span name="rep-specific">50KG/包</span></h5> -->
<!--                        <p name="rep-unit">上海耀剑农产品有限公司</p> -->
<!--                    </li> -->
                                   
               </ul>
          </div>
          <p class="paging_box">
             <span class="paging_perv"><input type="button" value="<< 上一页" class="disabled"></span>
             <span class="paging_next"><input type="button" value="下一页 >>" /></span>
          </p> 
      </div>
</div>
 

<script type="text/javascript">
var params = {};
var pageNum=1;
var totalPage;
var totalNum;
var pageSize=20;
$(document).ready(function(){
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
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
	$(".unit_con li").live("click",function(){
		  var sedhtml = '<i class="i_sed">已选</i>' ;					 
		  if(!$(this).hasClass("i")){							  						  
				 $(this).addClass("selected");
				 $(this).append(sedhtml);
				 var selname = $(".unit_con li.selected span[name^='name']").text(),
				     selspec = $(".unit_con li.selected span[name^='spec']").text(),
					 selmanufacture = $(".unit_con li.selected p[name^='manufacture']").text();
			     	 seltypeGeneral = $(".unit_con li.selected span[name^='typeGeneral']").text(),
				     selproductionBarcode = $(".unit_con li.selected span[name^='productionBarcode']").text(),
				     selguaranteeValue = $(".unit_con li.selected span[name^='guaranteeValue']").text(),
				     selguaranteeUnit = $(".unit_con li.selected span[name^='guaranteeUnit']").text(),
				     selcode = $(".unit_con li.selected span[name^='code']").text(),
// 				 window.parent.alert(selname+selspec+selmanufacture+seltypeGeneral+selproductionBarcode);
				 $(window.parent.document).find("input[name^='name']").val(selname);
				 $(window.parent.document).find("input[name^='spec']").val(selspec);
				 $(window.parent.document).find("input[name^='manufacture']").val(selmanufacture);
				 $(window.parent.document).find("select[name^='typeGeneral']").val(seltypeGeneral);
				 $(window.parent.document).find("input[name^='productionBarcode']").val(selproductionBarcode);
				 $(window.parent.document).find("input[name^='code']").val(selcode);
				 $(window.parent.document).find("input[name^='guaranteeValue']").val(selguaranteeValue);
				 $(window.parent.document).find("input[name^='guaranteeUnit']").val(selguaranteeUnit);
				 
// 				 var select=$(window.parent.document).find(".select_cs ").val();
// 				 var select2=$(window.parent.document).find(".select_cs option").value();
// 				 console.log("111")
// 				 console.log(select2);
// 				 console.log(select);
	
                 $(window.parent.document).find(".shadow_bg").fadeOut().remove(); 
			     $(window.parent.document).find(".popup_box").fadeOut().remove();
		   } else {
				 $(this).removeClass("selected");
				 $(this).children("i").remove();
		  }
	});
	
	search(pageNum);
/*-------jquery end-------*/
	//采购品类型
	$.ajax({
		url:"../inputManage/inputMaterial/getAllGeneralType",
	      headers: { 
              'Accept': 'application/json',
              'Content-Type': 'application/json' 
          },
		type: "get",
		data:"json",
		success:function(text){
				$("#selectqx").append("<option value='-1'>"+"全部"+"</option>");
			$.each(text,function(id,itemList){ 
				$("#selectqx").append("<option value='"+id+"'>"+itemList+"</option>");
			});		
		
		}
	}); 
	
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
		//
		$(".paging_next").click(function(){
			 if(pageNum<totalPage){
					$(".paging_box a").removeClass("default");
					pageNum +=1;
					$("#page"+pageNum).addClass("default");
					search(pageNum) 
			 }else if(pageNum==totalPage){
				search(pageNum);
			
			}
		});
		
		//查询
		$("#btn_aq_seach").click(function(){
		    $("#unit_list_input").children().remove();
		    pageNum=1;
			search(pageNum);
		});

});	

function search(pageNum){
	$("#loading").show();
	var toUrl="../inputManage/inputMaterial/queryInputMaterialForCreateOutputBatch/"+pageNum+"/"+pageSize;
	var typeGeneral =$("#selectqx").val();
	var materialName=$("#materialName").val();
// 	if(typeGeneral==9000){
// 		typeGeneral=null;
// 	}
	console.log(typeGeneral);
	console.log(materialName);
	params.generalType=typeGeneral;
	params.materialName=materialName;
	$.ajax({
	url:toUrl,
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params),
	success:function(text) {
		if(text.status==0){
			console.log("1111:");
			console.log(text);
	          pageContentReset(text);
	          page(text);

	       	$("#loading").hide();
		}
	
	 },   
	 error:function(text) {
			console.log(text);
	 }
	});
}

function pageContentReset(result){
	console.log("11");
	console.log(result);
	if(result!=null&&result.body.resultList.length>0){
		var resultList=result.body.resultList;
	    $("#unit_list_input").children().remove();
		for(var i=0;i<resultList.length;i++){
			console.log(resultList[i].productionBarcode);
			var num=(pageNum-1)*pageSize+i+1;
			var id=resultList[i].id;
			var name=isnull(resultList[i].name);
			var spec=isnull(resultList[i].spec);
			var manufacture=isnull(resultList[i].manufacture);
			var ltypeGeneral=isnull(resultList[i].typeGeneral);
// 			var lproductionBarcode=resultList[i].productionBarcode==null?"":resultList[i].productionBarcode;
			var lproductionBarcode=isnull(resultList[i].productionBarcode);
			var lguaranteeValue=isnull(resultList[i].guaranteeValue);
			var lguaranteeUnit=isnull(resultList[i].guaranteeUnit);
			var lcode=isnull(resultList[i].code);
// 		     <li>
//              <h5><span name="rep-name">薄荷</span> <span name="rep-specific">50KG/包</span></h5>
//              <p name="rep-unit">上海耀剑农产品有限公司</p>
//          </li>
			var $tr=$('<li><h5><span name="name">'+name+'</span><span name="spec">'+spec+'</span><span name="productionBarcode" style="display:none">'+lproductionBarcode+'</span><span name="code" style="display:none">'+lcode+'</span><span name="typeGeneral" style="display:none">'+ltypeGeneral+'</span><span name="guaranteeValue" style="display:none">'+lguaranteeValue+'</span><span name="guaranteeUnit" style="display:none">'+lguaranteeUnit+'</span></h5><p name="manufacture">'+manufacture+'</p></li>') ;
			$("#unit_list_input").append($tr);
		}
	}
}
</script>
	
</body>
</html>