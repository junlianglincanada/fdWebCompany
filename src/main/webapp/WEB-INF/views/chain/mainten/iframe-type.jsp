<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
	String companyType=request.getParameter("companyType");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
.ifr_text label{margin-right:10px;}
.ifr_text label input{margin-right:5px;position:relative;top:3px;}
</style>
<script type="text/javascript">
var id="<%=id %>";
var companyType="<%=companyType %>";
var params={};
$(function(){
	$(":radio[name=type][value="+companyType+"]").attr("checked",true);
	$("input.btn_blue").click(function(){
		var companyToType=$(":radio[name=type]:checked").val();
		params.id=id;
		params.companyToType=companyToType;
		$.ajax({
			url:"../comRelationship/relationship/updateComRelationship/",
			type:"post",
			data:JSON.stringify(params),
			dataType:"json",
			headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    success: function(){
		    	window.parent.location.href="chain.mainten.mainten";
		    }
		});
	})
	//点击按钮关闭(Chrome上iframe内的按钮关闭必须在服务器上运行 根据需求可注释掉)
    var Href = $(window.parent.document).find("#iframe_popup").attr("src");
	var Name_id = Href.substring(Href.lastIndexOf('=')+1,Href.length);
	// console.log(Name_id);
	 
	$(".ifr_text input[type='radio']").live("change",function(){						  
		$("input.btn_blue").attr("data-rel",$(this).parent().find("span").text());
	});
	
	//关闭弹窗
	$("input.btn_gray").live("click",function(){	
		var data = $(this).attr("data-rel");   console.log(data);
		$(window.parent.document).find("#"+Name_id).text(data);									  
		$(window.parent.document).find(".shadow_bg").fadeOut().remove();
		$(window.parent.document).find(".popup_box").fadeOut().remove();
		return false;
	});
/*-------jquery end-------*/
});	
</script>
</head>
<body>
<div class="ifr_box">
     <p class="ifr_text">
        <label><input type="radio" name="type" value="61001"><span>自营店/分店</span></label>
        <label><input type="radio" name="type" value="61002"><span>加盟店</span></label>
        <label><input type="radio" name="type" value="61003"><span>承包方</span></label>
     </p>
     <div class="ifr_btn">
          <input type="button" class="btn_blue" value="确定" />
          <input type="button" class="btn_gray" value="取消" />
     </div>
</div></body>
</html>