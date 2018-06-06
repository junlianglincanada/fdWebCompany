<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp"%>
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" />

<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
var id="<%=id%>";


function isNumber(number){
	var patrn=/^\d{1,6}(?:\.\d{1,2}|\.?)$/;
	flg = patrn.test(number);
	if (flg) {
		return true;
	}
	return false;
}
function search(){
	$("#loading").show();
	$.ajax({
		url: "../publishContent/getPublicContentById/" + id,
			type : "get",
			headers : {
				'Accept' : 'application/json',
				'Content-Type' : 'application/json'
			},
			dataType : 'json',
			success : function(result) {
				console.log(result);
				if (result.status == 0) {
					var resultList = result.body.resultList[0];
					$("#body").children().remove();
					$("#title").text(isnull(resultList.title));
					$("#companyName").text(isnull(resultList.companyName));
					$("#publishDate").text(isnull(resultList.publishDate));
					//$("#keyWord").text(isnull(resultList.keyWord));
					//$("#dradtPersonName").text(isnull(resultList.draftPersonName));
					$("#content").html(isnull(resultList.content));
					//window.parent.frames["topFrame"].location.reload();
					window.parent.countUnread();
					$("#loading").hide();
				};
			},
			error : function(text) {
				console.log(text.message);
			}
		});
	}

	$(function() {

		search();

	});
</script>
</head>
<body>

	<div class="main_box">
		<div id="loading"
			style="position: absolute; top: 50%; left: 50%; margin: 0 auto; height: 300px; z-index: 888; display: none;">
			<img src="../img/loading.gif">
		</div>

		<div class="main_con">
			<h3 class="process_title">
				<span>当前位置: </span><a
					href="../findView/publishContent.publishContent">通知公告></a> <a
					href="#">查看详情</a>
			</h3>
			<table class="info_mation" style="width: 80%; margin: 0 auto;">

				<div class="table_box">
					<div class="notice_tent">

						<h4 class="notice" align="center">
							<span id="title"></span>
						</h4>
						<h5 class="notice" align="center">
							<span id="companyName"></span>&nbsp;&nbsp;&nbsp;(<span id="publishDate"></span>)<!--  &nbsp;&nbsp;&nbsp;<span id="dradtPersonName" class="blue"></span>-->
						</h5>
						<!--  <h6 class="notice">
							<em>关键字：</em>&nbsp;&nbsp;&nbsp;<span id="keyWord"></span>
						</h6>-->
						<p class="notice" id="content"></p>
					</div>
					<div class="clear"></div>

				</div>
				</div>
				</div>
</body>
</html>