<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta name="renderer" content="webkit" />

 <link href="images/favicon.ico" rel="shortcut icon" type="image/x-icon" /> 
<link href="demo-css/base.css" rel="stylesheet" type="text/css" />
<link href="demo-css/demo.css" rel="stylesheet" type="text/css" />
<link href="js/dist/sweetalert2.min.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.8.3.min.js" type="text/javascript"></script>
<style type="text/css">
html,body{overflow:hidden;}
</style>
</head>
<body>
<div class="wrap">
     <div class="header_box">
          <div class="header">
		      <div class="head_lf">
		          <h1 class="head_logo" ><a href="javascript:void(0)"></a></h1>
		          <p class="hlf_text">
		             <span><a href="findView/system.account.account-view" id="hlf_0001_14_02" target="hlf_0001_14_02"><%=SecurityUtils.getCurrentUserCompanyName() %></a></span>
		             <span><a href="findView/personal.personal" id="hlf_0001_14_03" target="hlf_0001_14_03"><%=SecurityUtils.getCurrentUserRealName() %></a></span>
		          </p>
		      </div>
		      <div class="head_rt">
		          <a href="javascript:void(0);" onclick="popup('450','230','退出登录','findView/frame.iframe-exit');">
		             <i class="i_exit"></i>
		             <span>退出登录</span>
		          </a>
		          <a href="findView/consult.consult" id="hrt_02" target="hrt_02">
		             <i class="i_consult"></i>
		             <span>咨询帮助</span>
		          </a>
		          <a href="javascript:void(0);" onclick="popup('450','230','消息提示','findView/publishContent.iframe-message');">
		             <i class="i_msg"></i>
		             <span>消息</span>
		             <em class="i_num">0</em>
		          </a>
		      </div>
		  </div>
     </div>
     <div class="mainbody">
          <div class="main_left">
               <div class="mlf_inner">
                    <dl class="lf_navs">
                    </dl>  
               </div>
          </div>
          <div class="main_right">
               <div class="mrt_top">
                    <div class="mrt_inner">
                         <div class="mrt_bar">
                         <a id="0001_01_title" href="javascript:void(0);" rel="0001_01" style="width:100px;" title="首页" class="default"><span>首页</span></a></div>
                    </div> 
               </div>
               <div class="mrc_con">
                    <div class="mrc_tab">
                    	<div id="0001_01_body" class="layer 0001_01 default"><iframe src="findView/home.home_index" scrolling="auto" frameborder="0" name="0001_01" class="main_iframe" allowtransparency="true"></iframe></div>
                    </div>
               </div>
   		    </div>
          <div class="clear"></div>
     </div>
<!--      <div class="footer_box">
          <div class="footer">
               <p class="foot_text">版权所有&nbsp;&nbsp;万达信息股份有限公司&nbsp;&nbsp;&nbsp;&nbsp;备案号&nbsp;&nbsp;沪ICP备12026857号<span class="login_tel">客服电话:<b>021-54644607</b></span></p>
          </div> 
      </div> -->
</div>
<script type="text/javascript" src="js/demo.js" charset="utf-8"></script>
<script type="text/javascript" src="js/pop/popupParent.js" charset="utf-8"></script>
<script type="text/javascript" src="js/dist/sweetalert2.min.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
	//左侧菜单栏
 	navLeft();
	//企业消息
 	countUnread();
 	$('.lf_navs > dt:first').find('a').addClass("default");
	$.ajax({
		url:"company/getComRelations",
		type:"get",
		success:function(result){
			var flag=result.body;
			if(flag==0){
				$("#0001_0701_dt").hide();
				$("#0001_0702_dt").show();
				$("#0001_0703_dt").hide();
			}
			if(flag==1){
				$("#0001_0701_dt").show();
				$("#0001_0702_dt").hide();
				$("#0001_0703_dt").hide();
			}
			if(flag==2){
				$("#0001_0701_dt").hide();
				$("#0001_0702_dt").hide();
				$("#0001_0703_dt").show();
			}
		}
	});
	var hasMonitor = <%=SecurityUtils.getHasMonitor() %>;
	if(!hasMonitor){
		$("#0001_15_dt").hide();
	}
/*--顶部链接点击--*/
$(".head_lf p span a").click(function(event){
		event.preventDefault();
		var obj=this;
		CloseLfState();
		var thisId=$(obj).attr("id");
    tabNav(obj);
});
$("#hrt_02").click(function(event){
		event.preventDefault();
		CloseLfState();
		var thisId=$(this).attr("id");
    tabNav(this);
});
	
$("dl.lf_navs dt a").on("click",function(){//左侧菜单
      if(!$(this).hasClass("default")){
          $(this).addClass("default").parent("dt").siblings().find("a").removeClass("default");
          $(this).parent().next("dd").show().addClass("default").siblings("dd").hide().removeClass("default");
          $("dl.lf_navs dd a").removeClass("default");
          $(this).parent("dt").next("dd").children("a").eq(0).addClass("default");
      }else{
          $(this).removeClass("default");
          $(this).parent().next("dd").removeClass("default").slideUp();
      }
});
$("dl.lf_navs dd a").on("click",function(){//左侧二级菜单
      $("dl.lf_navs dt a").removeClass("default");
      $(this).parent("dd").prev("dt").find("a").addClass("default");
      $(this).addClass("default").siblings().removeClass("default");                                   
});

//左右联动菜单
$(document).on("click","dl.lf_navs dt > a",function(event){//点击左侧菜单→右侧添加页签与iframe
    event.preventDefault();
    if($(this).parent().next("dd").find("a").length <=0){
       var thisId=$(this).attr("id");
       tabNav(this);
    }else{
       var thisParent = $(this).parent("dt").next("dd").children("a").eq(0);
       var thisId= thisParent.attr("id");
       tabNav(thisParent);
    }
           
});

$(document).on("click","dl.lf_navs dd > a",function(event){//点击左侧二级→右侧添加页签与iframe
      event.preventDefault();
      var thisId=$(this).attr("id");
      tabNav(this);         
});

/*--右侧tab页签切换--*/
$(document).on("click",".mrt_bar a",function(){
    $(this).addClass("default").siblings().removeClass("default");               
    var yy = $(this).attr("rel");
    $(this).closest(".main_right").find(".layer."+ yy).addClass("default").siblings("div").removeClass("default"); 
}); 

//点击删除右侧页签
 $(document).on("click","i.i_cross",function(event){
      event.stopPropagation();
      CloseLfState();
      var this_parent_id = $(this).parent().attr("id");
      var left_this_id=this_parent_id.substring(0,this_parent_id.lastIndexOf("_"));
      var parent_a=$(this).parent().prev("a");
      if( parent_a ){
         $(parent_a).click();
      }
      $(this).parent().remove();           
      $("#"+left_this_id+"_body").remove();  
      div_a_rest();
 });

$(window).on('resize',function(){
    setTimeout(div_a_rest, 500); 
});

});
var tabNav = function(_this){
        var thisId=$(_this).attr("id");
        var thisName=$(_this).text();
        if(thisId=='hlf_0001_14_02'){
        	thisName="企业信息";
		thisId="0001_14_02";
		}else if(thisId=='hlf_0001_14_03'){
	      	thisName="个人中心";
			thisId="0001_14_03";
	}
        if($(_this).attr("href")!="" || $(_this).attr("href")!="null" || $(_this).attr("href")!="javascript:void(0)"){
           $(".mrt_bar a,.mrc_tab > div.layer").removeClass("default"); 
           if($("#"+thisId+"_title").length>0){
              $("#"+thisId+"_title").addClass("default").parent().siblings().find("a").removeClass("default");
              $("#"+thisId+"_body").addClass("default").siblings().removeClass("default");
              $("#"+thisId+"_body").children("iframe").attr("src",$(_this).attr("href"));
           }else{
              var rtArray ='<a id="'+thisId+'_title" href="javascript:void(0);" rel=\"'+thisId+'\" title=\"'+thisName+'\" class="addA default"><span>'+thisName+'</span><i class="i_cross"><b></b></i></a>';
              var mainArray ='<div id="'+thisId+'_body" class="addDiv layer '+thisId+' default"><iframe src="'+$(_this).attr("href")+'" scrolling="auto" frameborder="0" name="'+$(_this).attr("target")+'" class="main_iframe" allowtransparency="true"></iframe></div>';
              $(".mrt_bar").append(rtArray); 
              $(".mrc_tab").append(mainArray); 
              div_a_rest('add');
           }
        }
}

function countUnread(){
	$.ajax({
		url: "publishContent/countUnreadContent",
		type:"get",
		success:function(result){
			if(result.status==0){
				$(".i_num").show();
				var publishment = result.body.publishment;
				var notification = result.body.notification;
				var total = parseInt(publishment)+parseInt(notification);
				$(".i_num").text(total);
				if(total == 0){
					$(".i_num").hide();
				}
			}
		}
	});
}
function navLeft(){
	$.ajax({
		url:"menu/getMainMenu",
		async: false,
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
	    success: function(result) {
	    	if(result.status == 0){
	    		var data=result.body;
				var objNav=eval(data);
				   $('.lf_navs').empty();
				   for(var i = 0;i< objNav.length; i++){
					   var linkPath=objNav[i].linkPath.substring(3,objNav[i].linkPath.length);
				     var navL ='<dt id="'+ objNav[i].menuId +'_dt"><a href="'+ linkPath +'" target="'+ objNav[i].menuId +'" id="'+ objNav[i].menuId +'"><i class="'+ objNav[i].menuIcon +'"></i><span>'+ objNav[i].menuName +'</span></a></dt><dd  id="'+objNav[i].menuId+'_dd"></dd>';//一级菜单   
				     if(objNav[i].parentId != 'null' && objNav[i].parentId != null && objNav[i].parentId != "" && $("#"+objNav[i].parentId).length > 0){     
				        var subL ='<a id="'+ objNav[i].menuId +'" href="'+ linkPath +'" title="'+objNav[i].menuName+'" target="'+objNav[i].menuId+'"><i class="i_arrow"></i><span>'+ objNav[i].menuName +'</span></a>';//二级菜单
				            if($('#'+objNav[i].parentId+'_dd').length > 0){
				               $('#'+objNav[i].parentId+'_dd').append(subL);//添加二级(json数组二级id匹配一级的pid)
				            }         
				       }else{
				         $('.lf_navs').append(navL);//添加一级
				     }
				   }
	    	}
	    },
	    error:function(e){
			console.log(e);
		}
	});
	   return false;
	}

function CloseLfState(){
	$("dl.lf_navs dt a, dl.lf_navs dd a").removeClass("default");
    $("dl.lf_navs dd").removeClass("default").slideUp();
}
function div_a_rest(obj){
    var barW = $(".mrt_bar").width(),
        aLen = $(".mrt_bar a").length;
    if(aLen>=1){
        var a_size=parseInt((barW-((aLen+2)*4))/aLen);
        $(".mrt_bar a").width(a_size);
         if((aLen==10||aLen==15||aLen==20||aLen==25||aLen==30||aLen==35||aLen==40||aLen==45)&&obj=='add'){ 
            swal({ 
         	   	  title: "",
           	      text: "页面打开太多缓存严重，请关闭一些不需要的页面！", 
            	  type: "warning",
            	  showCancelButton: true,
            	  confirmButtonColor: "#1f78c8",
            	  showConfirmButton:true,
            	  cancelButtonText: "取消",
            	  confirmButtonText: "确定",
            	  closeOnConfirm: false,
            	}).then(
            	function(isConfirm){
            	  if (isConfirm) {
            		  setTimeout(function(){
                    	  $(".mrt_bar>a.default").siblings(".addA").remove();  
                    	  $(".mrc_tab>div.default").siblings(".addDiv").remove(); 		  
            		  },200);
            	  }
            	});
        }
    }
}
</script>	
</body>
</html>