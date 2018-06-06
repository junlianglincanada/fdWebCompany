<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/custome.js" type="text/javascript" charset="utf-8"></script>	
<script src="../js/jquery.form.js" type="text/javascript"></script>
<script src="../js/popup.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript">${_csrf.parameterName}&${_csrf.token}</script>	
<script src="../js/plupload.full.min.js" type="text/javascript"></script>	
<script src="../js/bigimg.js" type="text/javascript" charset="utf-8"></script>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" /> 
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<script type="text/javascript">

var ajaxFlag=true;

var params={};

$(function(){
	
	
	//点击保存按钮执行修改
	$("#saveFormSubmit").click(function(){
		var params={};
		$(".text_ts").remove();
		ajaxFlag=true;
		
		

		if(ajaxFlag){

			var name=$("#name").val();
			
			var mobilePhone=$("#mobilePhone").val();
			
			var email=$("#email").val();
			var type=$("#type").val();
			var description=$("#description").val();
			var status=$("#status").val();
			params.name=name;
			params.mobilePhone=mobilePhone;
			params.email=email;
			params.type=type;
			params.description=description;
			params.status=status;
			
			$.ajax({
				url: "../question/createQuestion",
				type:"post",
				headers: { 
					'Accept': 'application/json',
					'Content-Type': 'application/json',
					'X-CSRF-TOKEN': '${_csrf.token}'
				},
				dataType:'json',
				data:JSON.stringify(params),
				success: function(result) {
					if(result.status==0){
						alert("保存成功");
						window.top.location.href="../default.do";
					}else{
						alert(result.message);
					}
				},
				error: function(data) {
					alert("保存失败，请重试！");
				}
			});
		}
	});
})
</script>
</head>
<body>
	<div class="main_box">
		<div class="main_con">
			<h3 class="process_title">
				<span>当前位置: </span>
				<a href='../findView/account.account-editor'>互动信息</a>
			</h3>
			<div class="per_box">
				<table class="info_mation" style=" margin: 0 auto; width:80%">
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>姓名</td>
						<td><input
							type="text" class="input_code" style="width: 166px;" id="name"
							name="name" value="<%=SecurityUtils.getCurrentUserRealName() %>"/></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>联系电话</td>
						<td><input type="text" class="input_code"
							style="width: 166px;" id="mobilePhone"/></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>邮件地址</td>
						<td>
							<input type="text" class="input_code"
							style="width: 166px;" id="email"/>
						</td>
					</tr>
					
					<tr class="necessary" id="cert">
						<td class="td_lf"><em class="star">*</em>问题类型</td>
						<td>
							<div class="select_s" style="width: 187px; float: left; margin-right:10px;">
								<div class="select_is" style="width: 187px;">
									<select class="select_cs" id="type"
										style="width: 217px; background-position: -2px -122px;">
										<option value="bus">业务咨询</option>
										<option value="tec">技术咨询</option>
						                <option value="rule">法规咨询</option>
									</select>
								</div>
							</div>
							</td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>问题描述</td>
						<td>
							<textarea class="textarea_code" id="description"></textarea>
						</td>
					</tr>
					
					<input type="hidden" class="input_code" style="width: 166px;" id="status" value="add"/>

						
				</table>
			</div>
			<p class="save_box">
				<input id="saveFormSubmit" type="button" class="btn_save" value="保存"/>
				<input type="button" class="btn_save" value="返回"
					onClick="window.parent.location.href='../default.do'" />
			</p>
			<div class="clear"></div>
		</div>
	</div>
</body>
</html>