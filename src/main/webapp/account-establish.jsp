<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
	String webPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	String path = request.getContextPath();
	webPath += path;
	request.setAttribute("webPath", webPath);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="<%=webPath%>/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="<%=webPath%>/js/custome.js" type="text/javascript" charset="utf-8"></script>	
<script src="<%=webPath%>/js/jquery.form.js" type="text/javascript"></script>
<script src="<%=webPath%>/js/popup.js" type="text/javascript"></script>
<script src="<%=webPath%>/js/common.js" type="text/javascript">${_csrf.parameterName}&${_csrf.token}</script>	
<script src="<%=webPath%>/js/plupload.full.min.js" type="text/javascript"></script>	
<script src="<%=webPath%>/js/bigimg.js" type="text/javascript" charset="utf-8"></script>
<link href="<%=webPath%>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=webPath%>/css/style.css" rel="stylesheet" type="text/css" />
<link rel="Stylesheet" href="<%=webPath%>/js/jquery.autocomplete.css" /> 
<script src="<%=webPath%>/js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=webPath%>/js/jquery.autocomplete.js"></script>
<script type="text/javascript">
var companyName;
var companyId=null;
var ajaxFlag=true;
function searchList(){
	var keyWords = $("#companyName").val().trim();
	var params={'companyName':keyWords};
	$.ajax({
		type:"post",
		headers: { 
			'Accept': 'application/json',
			'Content-Type': 'application/json' 
		},
		dataType:'json',
		data:JSON.stringify(params),
		url: "<%=webPath%>/register/getCompanyListByName",
		success: function(result) {
			console.log(result.body);
			$("#companyName").bind("input.autocomplete",function(){
   				$(this).trigger('keydown.autocomplete');
			});
			$("#companyName").autocomplete(result.body,{
				minChars: 3,
				width: 260,
				max:12,
				delay:1000,
				matchContains: true,
				autoFill: false,
				scroll: false,
				dataType: 'json',
				formatItem: function(row, i, max) {
					return  "<font color=green>" + row.companyName + "</font>" ;
				},
				formatMatch: function(row, i, max) {
					return row.companyName ;
				},
				formatResult: function(row) {
					return row.companyName;
				}
			}).result(function(event,data,formatted){
				console.log(data);
				$("#companyId").text("");
				companyId=data.companyId+"";
				searchById();
       		});
		},
		error: function(data) {
			alert("加载失败，请重试！");
		}
	});
}
function searchById(){
	if(companyId!=null&&companyId!=""){
		var params={'companyId':companyId};
		$.ajax({
			url: "<%=webPath%>/register/getCompanyById",
			type:"post",
			headers: { 
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			data:JSON.stringify(params),
			success: function(result) {
				view(result);
			},
			error: function(data) {
				alert("加载失败，请重试！");
			}
		})
	}
}
function searchByCode(){
	$(".text_ts").remove();
	var certType=$("#certType").find("option:selected").text();
	if(certType=="请选择许可证类别"){
		$(this).after('<span class="text_ts">证件类型不能为空 </span>');
		return;
	}
	if(certType=="食品流通许可证"){
		certType="FOOD_CIRCU_CERT";
	}
	if(certType=="食品生产许可证"){
		certType="FOOD_PROD_CERT";
	}
	if(certType=="餐饮服务许可证"){
		certType="CATERING_CERT";
	}
	var certNo=$("#certNo").val();
	if(certNo==""||certNo==null){
		$(this).after('<span class="text_ts">证件号码不能为空 </span>');
		return
	}
	var params={'certType':certType,'certNo':certNo};
	$.ajax({
		url: "<%=webPath%>/register/getCompanyByCert",
		type:"post",
		headers: { 
			'Accept': 'application/json',
			'Content-Type': 'application/json' 
		},
		dataType:'json',
		data:JSON.stringify(params),
		success:function(result){
			view(result);
		},
		error: function(data) {
			alert("加载失败，请重试！");
		}
	})
}
function view(result){
	var companyName=result.body.companyName;
	var companyNameAbbrev=result.body.companyNameAbbrev;
	var companyRegAddress=result.body.companyRegAddress;
	var companyBizAddress=result.body.companyBizAddress;
	var regionCountyId=result.body.regionCountyId;
	var regionStreetId=result.body.regionStreetId;
	var foodCircuCert=result.body.foodCircuCert;
	var foodProdCert=result.body.foodProdCert;
	var cateringCert=result.body.cateringCert;
	$("#companyName").val(companyName);
	$("#companyNameAbbrev").val(companyNameAbbrev);
	$("#companyRegAddress").val(companyRegAddress);
	$("#companyBizAddress").val(companyBizAddress);
	listRegions(regionCountyId,regionStreetId);
	var $tr=$("#cert");
	if(foodCircuCert!=null||foodProdCert!=null||cateringCert!=null){
		$("#cert").remove();
		$tr.removeClass("necessary");
		$tr.find("td:eq(0)").html("&nbsp;");
		$tr.find("input:button").remove();
		if(cateringCert!=null){
			var $cert=$tr;
			$cert.find("option:eq(3)").attr("selected","selected");
			$cert.find("input:text").val(cateringCert);
			$("tr:eq(4)").after($cert);
		}
		if(foodProdCert!=null){
			var $cert=$tr;
			$cert.find("option:eq(2)").attr("selected","selected");
			$cert.find("input:text").val(foodProdCert);
			$("tr:eq(4)").after($cert);
		}
		if(foodCircuCert!=null){
			var $cert=$tr;
			$cert.find("option:eq(1)").attr("selected","selected");
			$cert.find("input:text").val(foodCircuCert);
			$("tr:eq(4)").after($cert);
		}
		$("tr:eq(5)").addClass("necessary");
		$("tr:eq(5) td:first").html('<em class="star">*</em>许可证号');
		$("tr:eq(5)").find("input").after('&nbsp;&nbsp;&nbsp;<input type="button" class="btn_shang" value="获取">');
	} 
}
function listRegions(pid,id){
	$("#provinces option:gt(0)").remove();
	$("#cities option:gt(0)").remove();
	$("#districts option:gt(0)").remove();
	$("#streets option:gt(0)").remove();
	$.ajax({
		url:"base/getAdminRegion/getByLevel/-1",
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $provinces=$("<option>"+result[i].name+"</option>");
				$provinces.data("provinces",result[i].id);
				$("#provinces").append($provinces);
			}
			$("#provinces option:contains('上海')").attr("selected","selected");
		}
	});
	$.ajax({
		url:"base/getAdminRegion/10000",
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $cities=$("<option>"+result[i].name+"</option>");
				$cities.data("cities",result[i].id);
				$("#cities").append($cities);
			}
			$("#cities option:contains('上海')").attr("selected","selected");
		}
	});
	$.ajax({
		url:"base/getAdminRegion/1",
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $districts=$("<option>"+result[i].name+"</option>");
				$districts.data("districts",result[i].id);
				$("#districts").append($districts);
			}
			$.ajax({
				url:"base/getAdminRegion/getRegionById/"+pid,
				type:"get",
				success:function(result){
					var district=result.name;
					$("#districts option:contains("+district+")").attr("selected","selected");
				}
			});
		}
	});
	$.ajax({
		url:"base/getAdminRegion/"+pid,
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $streets=$("<option>"+result[i].name+"</option>");
				$streets.data("streets",result[i].id);
				$("#streets").append($streets);
			}
			$.ajax({
				url:"base/getAdminRegion/getRegionById/"+id,
				type:"get",
				success:function(result){
					var street=result.name;
					$("#streets option:contains("+street+")").attr("selected","selected");
				}
			});
		}
	});
}
$(function(){
	//autocomplete 查询
	$("#companyName").focus(searchList);
	//加载省
	$("#provinces").children().eq(0).data("provinces","");
	$("#cities").children().eq(0).data("cities","");
	$("#districts").children().eq(0).data("districts","");
    $("#streets").children().eq(0).data("street","");
	$.ajax({
		url:"base/getAdminRegion/getByLevel/-1",
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $provinces=$("<option>"+result[i].name+"</option>");
				$provinces.data("provinces",result[i].id);
				$("#provinces").append($provinces);
			}
		}
	});
	//省变更时加载市
	$("#provinces").change(function(){
		var province=$("#provinces option:selected").data("provinces");
		$("#cities option:gt(0)").remove();
		$("#districts option:gt(0)").remove();
		$("#streets option:gt(0)").remove();
		$.ajax({
			url:"base/getAdminRegion/"+province,
			type:"get",
			success:function(result){
				for(var i=0;i<result.length;i++){
					var $cities=$("<option>"+result[i].name+"</option>");
					$cities.data("cities",result[i].id);
					$("#cities").append($cities);
				}
			}
		});
	});
	//市加载时变更区
	$("#cities").change(function(){
		var city=$("#cities option:selected").data("cities");
		$("#districts option:gt(0)").remove();
		$("#streets option:gt(0)").remove();
		$.ajax({
			url:"base/getAdminRegion/"+city,
			type:"get",
			success:function(result){
				for(var i=0;i<result.length;i++){
					var $districts=$("<option>"+result[i].name+"</option>");
					$districts.data("districts",result[i].id);
					$("#districts").append($districts);
				}
			}
		});
	});
	//区加载时变更街道
	$("#districts").change(function(){
		var disctrict=$("#districts option:selected").data("districts");
		$("#streets option:gt(0)").remove();
		$.ajax({
			url:"base/getAdminRegion/"+disctrict,
			type:"get",
			success:function(result){
				for(var i=0;i<result.length;i++){
					var $streets=$("<option>"+result[i].name+"</option>");
					$streets.data("streets",result[i].id);
					$("#streets").append($streets);
				}
			}
		});
	});
	$(".btn_shang").click(searchByCode);
	$("table").on("click",".btn_shang",searchByCode);
	$("#saveFormSubmit").click(function(){
		var params={};
		$(".text_ts").remove();
		ajaxFlag=true;
		$(".necessary").not("tr:eq(2)").each(function(){
			var input=$(this).find("input:text").val().trim();
			if(input==null||input==""){
				$(this).find("input:last").after('<span class="text_ts">必要信息不能为空 </span>');
				ajaxFlag=false;
			}
		})
		$("input:text").each(function(){
			var input=$(this).val().trim();
			if(checkSpecificKey(input)==false){
				$(this).find("input:text").after('<span class="text_ts">请勿输入特殊字符 </span>');
				ajaxFlag=false;
			}
		});
		var optflag=true;
		$("tr:eq(2) option:selected").each(function(){
			var opt=$(this).text();
			if(opt.indexOf("请选择")>=0){
				optflag=false;
			}
		})
		if(optflag==false){
			$(".select_s:eq(3)").after('<span class="text_ts">必要信息不能为空</span>');
			ajaxFlag=false;
		}
		if ($("#password").val().trim().length <5) {
			$("#password").after('<span class="text_ts">密码不能少于6个字符</span>');
			ajaxFlag=false;
		}
		if($("#password_confirm").val().trim()!=$("#password").val().trim()){
			$("#password_confirm").after('<span class="text_ts">输入密码不一致</span>');
			ajaxFlag=false;
		}
		var mobilephone=$("#mobilephone").val().trim();
		if(mobilephone!=null&&mobilephone!=""&&!isMobilephone(mobilephone)){
			$("#mobilephone").after('<span class="text_ts">手机号码格式不正确</span>');
			ajaxFlag=false;
		}
		if(ajaxFlag){
			var companyName=$("#companyName").val().trim();
			var companyNameAbbrev=$("#companyNameAbbrev").val().trim();
			var companyRegAddress=$("#companyRegAddress").val().trim();
			var companyBizAddress=$("#companyBizAddress").val().trim();
			var regionCountyId=$("#districts").find("option:selected").data("districts");
			var regionStreetId=$("#streets").find("option:selected").data("streets");
			var loginUserName=$("#username").val().trim();
			var loginUserPsw=$("#password").val().trim();
			var loginUserPersonName=$("#person").val().trim();
			var loginUserMobile=$("#mobilephone").val().trim();
			$("option:selected").each(function(){
				var certType=$(this).text();
				if(certType=="餐饮服务许可证"){
					var cateringCert=$(this).parents("td").find("input:text").val();
					params.cateringCert=cateringCert;
				}
				if(certType=="食品生产许可证"){
					var foodProdCert=$(this).parents("td").find("input:text").val();
					params.foodProdCert=foodProdCert;
				}
				if(certType=="食品流通许可证"){
					var foodCircuCert=$(this).parents("td").find("input:text").val();
					params.foodCircuCert=foodCircuCert;
				}
			});
			params.companyName=companyName;
			params.companyNameAbbrev=companyNameAbbrev;
			params.companyRegAddress=companyRegAddress;
			params.companyBizAddress=companyBizAddress;
			params.regionCountyId=regionCountyId;
			params.regionStreetId=regionStreetId;
			params.loginUserName=loginUserName;
			params.loginUserPsw=loginUserPsw;
			params.loginUserPersonName=loginUserPersonName;
			params.loginUserMobile=loginUserMobile;
			console.log(params);
			$.ajax({
				url: "<%=webPath%>/register/createCompanyWithLoginAdmin",
				type:"post",
				headers: { 
					'Accept': 'application/json',
					'Content-Type': 'application/json' 
				},
				dataType:'json',
				data:JSON.stringify({"companyWithLoginAdmin":JSON.stringify(params)}),
				success: function(result) {
					if(result.status==0){
						alert("注册成功");
						window.location.href="<%=webPath%>";
					}else{
						alert(result.message);
					}
				},
				error: function(data) {
					alert("加载失败，请重试！");
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
				<span>当前位置: </span><a href="<%=webPath%>">首页</a> <a
					href='<%=webPath%>/findView/account.account-establish'>新增账户信息</a>
			</h3>
			<!-- <h4 class="per_title">
				<span>账户信息</span>
			</h4> -->
			<div class="per_box">
				<table class="info_mation" style=" margin: 0 auto; width:80%">
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>单位名称</td>
						<td><input
							onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')"
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"
							type="text" class="input_code" style="width: 166px;" id="companyName"
							name="name" /><span id="companyId" style="display:none"></span></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>店招</td>
						<td><input type="text" class="input_code"
							style="width: 166px;" id="companyNameAbbrev"/></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>区域</td>
						<td>
							<div class="select_s" style="width: 87px; float: left; margin-right:10px;">
								<div class="select_is" style="width: 90px;">
									<select class="select_cs" id="provinces"
										style="width: 117px; background-position: -101px -122px;">
										<option>请选择省</option>
									</select>
								</div>
							</div>
							<div class="select_s" style="width: 87px; float: left; margin-right:10px;">
								<div class="select_is" style="width: 90px;">
									<select class="select_cs" id="cities"
										style="width: 117px; background-position: -101px -122px; ">
										<option>请选择市</option>
									</select>
								</div>
							</div>
							<div class="select_s" style="width: 87px; float: left; margin-right:10px;">
								<div class="select_is" style="width: 87px;">
									<select class="select_cs" id="districts"
										style="width: 117x; background-position: -101px -122px;">
										<option>请选择区</option>
									</select>
								</div>
							</div>
							<div class="select_s" style="width: 288px; float: left;" >
								<div class="select_is" style="width: 288px;">
									<select class="select_cs" id="streets"
										style="width: 328px; background-position: 75% -122px;">
										<option>请选择街道</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>注册地址</td>
						<td><input
							onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')"
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"
							type="text" class="input_code" style="width: 166px;"
							id="companyRegAddress"/></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>经营地址</td>
						<td><input
							onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')"
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"
							type="text" class="input_code" style="width: 166px;"
							id="companyBizAddress"/></td>
					</tr>
					<tr class="necessary" id="cert">
						<td class="td_lf line"><em class="star">*</em>许可证号</td>
						<td class="line">
							<div class="select_s" style="width: 187px; float: left; margin-right:10px;">
								<div class="select_is" style="width: 187px;">
									<select class="select_cs" id="certType"
										style="width: 217px; background-position: -2px -122px;">
										<option>请选择许可证类别</option>
						                <option>食品流通许可证</option>
						                <option>食品生产许可证</option>
						                <option>餐饮服务许可证</option>
									</select>
								</div>
							</div>
							<input
							onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')"
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"
							type="text" class="input_code" style="width: 166px;"
							id="certNo"/>&nbsp;&nbsp;&nbsp;
							<input type="button" class="btn_shang" value="获取"></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>姓名</td>
						<td><input
							onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')"
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"
							type="text" class="input_code" style="width: 166px;" id="person"
							name="jobRole" /></td>
					</tr>
					<tr>
						<td class="td_lf"><em class="star">&nbsp;</em>手机号码</td>
						<td><input
							onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')"
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"
							type="text" class="input_code" style="width: 166px;" id="mobilephone"
							name="jobRole" /></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>登录名</td>
						<td><input
							onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')"
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"
							type="text" class="input_code" style="width: 166px;" id="username"
							name="jobRole" /></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>密码</td>
						<td><input
							onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')"
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"
							type="text" class="input_code" style="width: 166px;" id="password"
							name="jobRole" /></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>确认密码</td>
						<td><input
							onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')"
							onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))"
							type="text" class="input_code" style="width: 166px;" id="password_confirm"
							name="jobRole" /></td>
					</tr>
				</table>
			</div>
			<p class="save_box">
				<input id="saveFormSubmit" type="button" class="btn_save" value="保存"/>
				<input type="button" class="btn_save" value="返回"
					onClick="window.location.href='<%=webPath%>/'" />
			</p>
			<div class="clear"></div>
		</div>
	</div>
</body>
</html>