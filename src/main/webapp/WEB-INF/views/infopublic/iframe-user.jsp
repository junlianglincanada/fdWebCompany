<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>上海市餐饮食品安全信息追溯系统</title>
<%@ include file="../include.jsp"%>	
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
span.paging_perv input,.paging_box a{margin:0;}
span.num_text{margin-left:0;}
</style>
</head>
<body>
<div class="ifr_box" style="width:480px;padding:0;">
     <div class="send_query">
          <span style="float:left;">姓名：</span>
          <input type="text" class="input_code" placeholder="请输入从业人员姓名" style="width:300px;float:left;margin-left:10px;" value="" id="query_value"/>
          <input type="button" class="btn_aq" value="查询" id="query_button"/>
          <div class="clear"></div>
      </div>
      <div class="send_con">
           <div class="unit_con">
                 <ul class="info_list" id="tbody">                    
                 </ul>
           </div>
           <div class="clear"></div>      
      </div>
      <div class="paging_box" style="padding:10px 0;">
          <span class="paging_head "><input type="button" class="" value="首页" /></span> 
          <span class="paging_perv"><input type="button" value="<< 上一页" ></span>
          <span class="paging_next"><input type="button" value="下一页 >>" /></span>
          <span class="paging_trailer"><input type="button" class="" value="尾页" /></span>
     </div>
</div>
 
<script type="text/javascript">

var pageNum=1;
var pageSize=20;
var totalPage=0;
var queryName="";
var params={"newSearch":"1"};
function search(pageNum){
	$("#loading").show();
 	$(".paging_head").removeClass("disabled");
	$(".paging_head input").attr("disabled",false);
	$(".paging_perv").removeClass("disabled");
	$(".paging_perv input").attr("disabled",false);
	$(".paging_next").removeClass("disabled");
	$(".paging_next input").attr("disabled",false);
	$(".paging_trailer").removeClass("disabled");
	$(".paging_trailer input").attr("disabled",false); 
	params.keyword=queryName;
	$.ajax({
		url:"../monitor/getEmpInfoLists/"+pageNum+"/"+pageSize,
		type:"post",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
		dataType:"json",
	    data:JSON.stringify(params),
		success:function(result){			
			$("#loading").hide();
				if(result.status==0){
					$("#tbody").children().remove();
					page(result);
			     	totalPage=result.body.pageCount;
					var list=result.body.resultList;
					var $li="";
					for(var i=0;i<list.length;i++){
						var personId=list[i].personId;
						var personName=isnull(list[i].personName);						
						var img_path=isnull(list[i].img);
						if(img_path!=""){
							img_path=fileServer+img_path;
						}else{
						 	img_path="../images/no_user.png";	 
						}
						var jobRole=isnull(list[i].jobRole);		
						$li+= '<li id='+personId+'><img src='+img_path+'><h4>'+personName+'</h4> <p>'+jobRole+'</p></li>';			
					}
					$("#tbody").append($li);
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
			}else{
				alert("系统异常,数据加载失败!!!");
			}
				
		},
		error:function(){
	    	$("#loading").hide();
		}
	});
}


$(function(){
iframe_wh(); //计算窗口宽度高度的函数
 var _name='${id}'
	var jobRole='';
	switch(_name)
	{
	case 'user1':
	  jobRole='经理';
	  break;
	case 'user2':
	  jobRole='食品安全负责人';
	  break;
	case 'user3':
	  jobRole='厨师长';
	  break;
	case 'user4':
	  jobRole='采购负责人';
	  break; 
	} 
	//从业人员点击
 	$("#tbody ").on("click","li",function(){
	var personId_c=$(this).attr("id");
	var obj_=$(this);
	$("#loading").show();
	$.ajax({
		url:"../monitor/addEmpInfo",
		type:"post",
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    async: false,
	    data:JSON.stringify({"empId":personId_c,"jobRole":jobRole}),
		success:function(result){			
			$("#loading").hide();
			var _li=$(window.parent.document).find("#"+_name);
			if(result.status==0){
				_li.find("img").attr("src",obj_.find("img").attr("src"));
				_li.find("h4").text(obj_.find("h4").text());
				_li.find("a.del_pic").attr("jobRoleId",result.body);
				_li.find("a.per_ck").hide();
				_li.find(".per_pic").show();
              $(window.parent.document).find(".shadow_bg").fadeOut().remove(); 
              $(window.parent.document).find(".popup_box").fadeOut().remove();
			}else{
				alert("系统异常,岗位修改失败!!!");
			}	
		},
		error:function(){
	    	$("#loading").hide();
		}
	});
	}); 

 	$("#query_button ").click(function(){
		queryName=isnull($("#query_value").val().trim());
		search(1);
	});
	 
	//页面加载完成执行查询
	search(pageNum);
	 //点击上一页查询
	$(".paging_perv").click(function(){
		if(pageNum==1){
			search(pageNum);
		}else{
			pageNum --;
			search(pageNum);
		}
	});
	//点击下一页查询
	$(".paging_next").click(function(){
		if(pageNum==totalPage){
			search(pageNum);
		}else{
			pageNum ++;
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

</script>
	
</body>
</html>