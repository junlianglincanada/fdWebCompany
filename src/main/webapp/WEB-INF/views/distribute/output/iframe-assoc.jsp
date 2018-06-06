<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String ids=request.getParameter("ids");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
 <%@ include file="../../include.jsp" %>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
ul.unit_list li p,ul.unit_list li h5{padding-right:10%;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;}
</style>
</head>
<body>
<div class="ifr_box" style="width:800px;padding:0;">
     <div class="assoc_query">
          <div class="aq_lf">
               <span style="float:left;">类型：</span>
               <div class="select_s" style="width:152px; float:left;">
                    <div class="select_is" style="width:152px;">
                        <select  id="selectqx" name="typeGeneral"  class="select_cs" style="width:182px; background-position:-40px -122px; color:gray;">
            
                         </select>
                     </div>
               </div>
               <input type="text" id="materialName" name="materialName"  class="input_code" style="width:152px; float:left;margin-left:10px;" value="" />
               <input  id="btn_aq_seach" type="button" class="btn_aq" value="查询" />
          </div>
          <div class="aq_rt">
               <h4 class="rt_tit">已选原料</h4>
               <input id="btn_aq_clear" type="button" class="btn_aq" style="float:right; margin:15px 20px 0 0" value="清空" />
          </div>
          <div class="clear"></div>
      </div>
      <div class="assoc_con">
           <div class="assoc_lf">
                <div class="unit_con">
                     <ul id="unit_list_input" class="unit_list">
<!--                          <li> -->
<!--                              <h5><span>薄荷</span> <span>50KG/包</span></h5> -->
<!--                              <p>上海耀剑农产品有限公司</p> -->
<!--                              <input type="button" class="btn_unit" value="添加" /> -->
<!--                          </li> -->
                                 
                     </ul>
                </div>
                <p class="paging_box" style="padding:8px 0 0 0;">
                   <span class="paging_perv"><input type="button" value="<< 上一页" class="disabled"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                </p>
           </div>
           <div class="assoc_rt">
                <i class="double"></i>
                <div class="unit_con">
                     <ul class="unit_list">
                         <!--<li>
                             <h5><span>薄荷</span> <span>50KG/包</span></h5>
                             <p>上海耀剑农产品有限公司</p>
                             <input type="button" class="btn_del" value="" />
                         </li>-->
                                                 
                     </ul>         
                </div>
                <p class="ifr_btn" style="height:38px;margin-top:2px;padding:0;">
                   <input type="button" class="btn_save" value="确定" />
                </p> 
           </div>
           <div class="clear"></div>      
      </div>
      
</div>

<script type="text/javascript">
var params = {};
var pageNum=1;
var totalPage;
var totalNum;
var pageSize=20;
var ids=isnull("<%=ids %>");
params.ids=ids;
$(document).ready(function(){
	console.log(ids);
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
   //弹出窗口宽高控制					   
   function iframe_wh(){	
		var par_W = $(window.parent.document).width();
		var ifr_W = $(window.document).find(".ifr_box").width();
		var pos_W = (par_W - ifr_W)/2 ; 
		//alert(par_W);
		$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"500px",left:pos_W +"px",top:20 +"px"});
		$(window.parent.document).find(".popup_iframe").css({height:"452px"});
		
	    $(window).resize(function(){ //对浏览器窗口调整大小进行计数
			  var par_W = $(window.parent.document).width();
			  var ifr_W = $(window.document).find(".ifr_box").width();
			  var pos_W = (par_W - ifr_W)/2; 
			  //alert(par_W);
			  $(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"500px",left:pos_W +"px",top:20 +"px"});
		      $(window.parent.document).find(".popup_iframe").css({height:"452px"});

			  return false;
		});
	  
	};
	iframe_wh(); //计算窗口宽度高度的函数
	
	//鼠标经过显示条件按钮
	$(".assoc_lf .unit_list li").live({
		    mouseenter:function(){
			$(this).find("input.btn_unit").show();        
        }, mouseleave:function(){
        	$(this).find("input.btn_unit").hide(); 
        }
	});
	
	$("input.btn_unit").live("click",function(){
		
		 var Lhtm =$(this).parent("li").clone();
		 $(this).removeClass("btn_unit").addClass("add_gray").attr({"disabeld":"disabeld"}).val("已添加");
		 $(this).parent("li").addClass("selected");
	     $(".assoc_rt .unit_list").append(Lhtm).find("input[type^='button']").removeClass("btn_unit").addClass("btn_del").val("");
		 return false;
	});
	$("input.btn_del").live("click",function(){
		$(this).parent("li").remove();	
		 var Lfhtm =$(".assoc_lf .unit_list li.selected h5");
		 for(i=0;i<=Lfhtm.length;i++){
		      if($(Lfhtm[i]).text() == $(this).parent().find("h5").text()){
				 $(Lfhtm[i]).parent("li").removeClass("selected");
				 $(Lfhtm[i]).parent().find("input").removeClass("add_gray").addClass("btn_unit").removeAttr("disabeld").val("添加").hide();
			  }
		 }								  
		 return false;
	});
	//点击按钮关闭(Chrome上iframe内的按钮关闭必须在服务器上运行 测试用后台开发可注释掉) 
	$("input.btn_save").live("click",function(){
		var selP = $('.assoc_rt ul.unit_list li h5 span[name^="assoc-name"]');		
			  console.log(selP);
			  for(var i=0;i<selP.length;i++){
// 				  console.log("22":+$(selP[i]).text());
				  var selhtml = '<span class="send_checked" ><em>'+ $(selP[i]).text() +'</em><input name="inputMatIdList" value="'+$(selP[i]).next("span").text()+'" type="hidden" /><i class="i_del">X</i></span>';
	
				  $(window.parent.document).find(".assoc_seltext").append(selhtml);		
			  }
						  
											  
			  $(window.parent.document).find(".shadow_bg").fadeOut().remove(); 
			  $(window.parent.document).find(".popup_box").fadeOut().remove();
			  //return alert("添加成功");
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
	//清空
	$("#btn_aq_clear").click(function(){
	    $(".assoc_rt .unit_list").children().remove();
		 $(".assoc_lf .unit_list li input").removeClass("add_gray").addClass("btn_unit").removeAttr("disabeld").val("添加").hide();
		 $(".assoc_lf .unit_list li").removeClass("selected");
	});
});	


function search(pageNum){
	$("#loading").show();
	var toUrl="../inputManage/inputMaterial/queryInputMaterialForCreateOutputBatch/"+pageNum+"/"+pageSize;
	var typeGeneral =$("#selectqx").val();
	var materialName=$("#materialName").val();
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
	if(result!=null&&result.body.resultList.length>0){
		var resultList=result.body.resultList;
	    $("#unit_list_input").children().remove();
		for(var i=0;i<resultList.length;i++){
			var num=(pageNum-1)*pageSize+i+1;
			var id=resultList[i].id;
			var name=isnull(resultList[i].name);
			var spec=isnull(resultList[i].spec);
			var manufacture=isnull(resultList[i].manufacture);
			var typeGeneral=isnull(resultList[i].typeGeneral);

			var $tr=$('<li><h5><span name="assoc-name">'+name+'</span><span style="display:none">'+id+'</span><span>'+spec+'</span></h5><p title="'+manufacture+'">'+manufacture+'</p><input type="button" class="btn_unit" value="添加" ></input></li>') ;
			$("#unit_list_input").append($tr);
		}
	}
}
</script>
	
</body>
</html>