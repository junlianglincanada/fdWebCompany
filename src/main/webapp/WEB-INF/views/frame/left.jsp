<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<%
	String webPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	String path = request.getContextPath();
	webPath += path;
	request.setAttribute("webPath", webPath);
	String error = request.getParameter("login_error");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />

<style type="text/css">
html{overflow-x:hidden;overflow-y:auto;}
dl.lf_navs dd a {
    padding: 3px 10px;
</style>
</head>
<body>
<div class="main_lf">
     <dl class="lf_navs">
     </dl>  
</div>
<div class="clear"></div>
  
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/custome.js" type="text/javascript"></script>
<script type="text/javascript">
$.ajaxSetup({
	  async: false
	  });
function navLeft(){
	$.ajax({
		url:"../menu/getMainMenu",
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
				for(var i=0;i<objNav.length;i++){
			    	var navL ='<dt id="'+ objNav[i].menuId +'"><a href="'+ objNav[i].linkPath +'" target="mainFrame"><i class="'+ objNav[i].menuIcon +'"></i><span>'+ objNav[i].menuName +'</span></a></dt><dd  id="'+objNav[i].menuId+'_dd"></dd>';//一级菜单	  
					   //console.log(JSON.stringify(objNav[i].pid));
					   if(objNav[i].parentId != 'null' && objNav[i].parentId != null && objNav[i].parentId != "" && $("#"+objNav[i].parentId).length > 0){ 	   
					    	var subL ='<a class="default" href="'+ objNav[i].linkPath +'" target="mainFrame"><i class="i_arrow"></i><span>'+ objNav[i].menuName +'</span></a>';//二级菜单
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
	
$(function(){
 	navLeft();
 	$('.lf_navs > dt:first').find('a').addClass("default");
	$.ajax({
		url:"../company/getComRelations",
		type:"get",
		success:function(result){
			var flag=result.body;
			if(flag==0){
				$("#0001_0701").hide();
				$("#0001_0702").show();
				$("#0001_0703").hide();
			}
			if(flag==1){
				$("#0001_0701").show();
				$("#0001_0702").hide();
				$("#0001_0703").hide();
			}
			if(flag==2){
				$("#0001_0701").hide();
				$("#0001_0702").hide();
				$("#0001_0703").show();
			}
		}
	});
	var hasMonitor = <%=SecurityUtils.getHasMonitor() %>;
	if(!hasMonitor){
		$("#0001_15").hide();
	}
/*-------jquery end-------*/
});	
</script>	   
</body>
</html>