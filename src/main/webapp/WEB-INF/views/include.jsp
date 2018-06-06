<%@page import="com.wondersgroup.framework.util.ConfigPropertiesUtil"%>
<%@page import="com.wondersgroup.framework.util.FileUploadUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	
	String fdWebFileURL = ConfigPropertiesUtil.getValue("fdWebFileURL");
%>

<%-- <%@ taglib uri="/WEB-INF/lib/scriptLoader.tld" prefix="tag"%> --%>

<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/custome.js" type="text/javascript" charset="utf-8"></script>	
<script src="../js/jquery.form.js" type="text/javascript"></script>
<script src="../js/popup.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript">${_csrf.parameterName}&${_csrf.token}</script>	
<script src="../js/common1.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/plupload.full.min.js" type="text/javascript"></script>	
<script src="../js/reAlert.js" type="text/javascript"></script>	
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<!-- 图片查看 -->
<script src="../js/foximg/jquery-rotate-2.3.min.js" type="text/javascript"></script>
<script src="../js/foximg/jquery.ui.js" type="text/javascript"></script>
<link href="../js/foximg/foximg.css" rel="stylesheet" type="text/css" />
<script src="../js/foximg/foximg.js" type="text/javascript" charset="utf-8"></script>
<!-- <script src="../js/bigimg.js" type="text/javascript" charset="utf-8"></script> -->

<script type="text/javascript">
	var fileServer = "<%=fdWebFileURL%>";
	var imgFilePath="<%=ConfigPropertiesUtil.getValue("fdWebFileURL")%>";
	/* $('input').bind('input propertychange', function() {
		alert("111");
		$(this).val($(this).val().replace(/([';])+|(--)+/g,"").replace(/<[^>]+>/g,""));
	}); */
	
    //gloabal ajax
    $(document).ajaxComplete(function( event,request, settings ) {
    	if( request.status === 302  || request.status===403){
    		window.location = "..";
    	}
    });
	  //点击查看大图
   $(function(){
	   $('div[rel="img"]').foximg(); 
   })  
	var oldajax = $.ajax;
	$.ajax = function(options){
		if(!(options.headers)){
			options.headers={};
		}
		options.headers['X-CSRF-TOKEN'] = '${_csrf.token}';
		return oldajax(options);
	};

	
	
	
	
</script>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
   