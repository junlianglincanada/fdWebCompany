<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
	String certType=request.getParameter("certType");
	String certNo=request.getParameter("certNo");
	String companyName=request.getParameter("companyName");
	if(certNo!=null&&certNo!=""){
		certNo=java.net.URLDecoder.decode(certNo, "UTF-8");
	}
	if(companyName!=null&&companyName!=""){
		companyName=java.net.URLDecoder.decode(companyName, "UTF-8");
	}
	String companyBizAddress=request.getParameter("companyBizAddress");
	if(companyBizAddress!=null&&companyBizAddress!=""){
		companyBizAddress=java.net.URLDecoder.decode(companyBizAddress, "UTF-8");
	}
	String companyNameAbbrev=request.getParameter("companyNameAbbrev");
	if(companyNameAbbrev!=null&&companyNameAbbrev!=""){
		companyNameAbbrev=java.net.URLDecoder.decode(companyNameAbbrev, "UTF-8");
	}
	String companyRegAddress=request.getParameter("companyRegAddress");
	if(companyRegAddress!=null&&companyRegAddress!=""){
		companyRegAddress=java.net.URLDecoder.decode(companyRegAddress, "UTF-8");
	}
	String regionProvinceId=request.getParameter("regionProvinceId");
	String regionCityId=request.getParameter("regionCityId");
	String regionCountyId=request.getParameter("regionCountyId");
	String regionStreetId=request.getParameter("regionStreetId");
	String flag=request.getParameter("flag");
	String certData=request.getParameter("certData");
	String key=request.getParameter("key")==null?"":request.getParameter("key");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
table.info_mation td.td_lf{padding-left:10px;}
</style>
<script type="text/javascript">
var certType=isnull("<%=certType %>");
var certNo=isnull("<%=certNo %>");
var certData=isnull("<%=certData%>");
var companyName=isnull("<%=companyName%>");
var companyBizAddress=isnull("<%=companyBizAddress%>");
var companyNameAbbrev=isnull("<%=companyNameAbbrev%>");
var companyRegAddress=isnull("<%=companyRegAddress%>");
var regionProvinceId=isnull("<%=regionProvinceId%>");
var regionCityId=isnull("<%=regionCityId%>");
var regionCountyId=isnull("<%=regionCountyId%>");
var regionStreetId=isnull("<%=regionStreetId%>");
var checkUserNameFlag=true;
var checkCompanyNameFlag=true;
var companyToType=61001;
var flag=isnull("<%=flag%>");//是否匹配成功companyImport
var key=isnull("<%=key%>");//用来判断页面跳转
function isUserName(code){
	var reCode = /^[a-zA-Z0-9@_]{4,30}$/;
	return (reCode.test(code));
}
function isPwd(code){
	var reCode = /^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?![_@]+$)[a-zA-Z0-9@_]{6,20}$/;
	return (reCode.test(code));
}
function checkCertType(){
	var certType=$("#cert").find("option:selected").text();
	if(certType=="工商营业执照"){
		$("#cert").find(".input_code").attr("placeholder","15位工商注册号或18位统一信用代码");
	}else if(certType=="食品经营许可证"){
		$("#cert").find(".input_code").attr("placeholder","请输入JY加14位数字或字母的证件号码");
	}else if(certType=="餐饮服务许可证"){
		$("#cert").find(".input_code").attr("placeholder","省、自治区、直辖市简称＋餐证字+16位数字或字母的证件号码");
	}else if(certType=="食品流通许可证"){
		$("#cert").find(".input_code").attr("placeholder","请输入SP加16位数字或字母的证件号码");
	}else if(certType=="食品生产许可证"){
		$("#cert").find(".input_code").attr("placeholder","请输入QS加12位数字字母或SC加14位数字字母的证件号码");
	}else{
		$("#cert").find(".input_code").attr("placeholder","");
	}
}
function checkCert(){
	certData="";
	$(".btn_dels").show();
	$("#btn_save").hide();
	$("#cert").find(".text_ts").remove();
	var searchFlag=true;
	var searchParams={};
	var certType=$("#cert").find("option:selected").text();
	var certNo=$("#cert").find("input:text").val().trim();
	var ct="";
	if(certType=="请选择证件类型"){
		searchFlag=false;
		$("#cert").append('<span class="text_ts">请选择证件类型</span>');
	}
	if(certNo==""){
		searchFlag=false;
		$("#cert").append('<span class="text_ts">证件号码不能为空</span>');
	}
	if(certType=="餐饮服务许可证"){
		if(!cyfwNumber(certNo)){
			searchFlag=false;
			$("#cert").append('<span class="text_ts">请输入正确的证件号码</span>');
		}
		ct="CATERING_CERT";
	}
	if(certType=="食品流通许可证"){
		if(!spltNumber(certNo)){
			searchFlag=false;
			$("#cert").append('<span class="text_ts">请输入正确的证件号码</span>');
		}
		ct="FOOD_CIRCU_CERT";
	}
	if(certType=="食品生产许可证"){
		if(!spscNumber(certNo)){
			searchFlag=false;
			$("#cert").append('<span class="text_ts">请输入正确的证件号码</span>');
		}
		ct="FOOD_PROD_CERT";
	}
	if(certType=="食品经营许可证"){
		if(!spjyNumber(certNo)){
			searchFlag=false;
			$("#cert").append('<span class="text_ts">请输入正确的证件号码</span>');
		}
		ct="FOOD_BUSINESS_CERT";
	}
	if(certType=="工商营业执照"){
		if(!gszzNumber(certNo)){
			searchFlag=false;
			$("#cert").append('<span class="text_ts">请输入正确的证件号码</span>');
		}
		ct="BIZ_CERT_NUMBER";
	}
	if(!searchFlag){
		return false;
	}
	searchParams.certType=ct;
	searchParams.certNo=certNo;
	$.ajax({
		url: "../comRelationship/relationship/getCompanyByCert",
		type:"post",
		headers: { 
			'Accept': 'application/json',
			'Content-Type': 'application/json' 
		},
		dataType:'json',
		data:JSON.stringify(searchParams),
		success: function(result) {
			console.log(result);
			if(result.status==0){
				$(".btn_dels").hide();
				$("#btn_save").show();
				if(result.messageCode=="0"){
					/* $("#companyName").val("");
					$("#address").val("");
					$("#region").find("option:eq(0)").attr("selected","selected"); */
					$("#address").parent().find("span").text("");
					$("#companyName").attr("disabled",false);
					$("#address").attr("disabled",false);
					$("#region").find("select").attr("disabled",false);
				}
				if(result.message=="4"){
					certData=$("#unit-select").val();
					companyName=isnull(result.body.companyName);
					companyBizAddress=isnull(result.body.companyBizAddress);
					companyNameAbbrev=isnull(result.body.companyNameAbbrev);
					companyRegAddress=isnull(result.body.companyRegAddress);
					regionProvinceId=isnull(result.body.regionProvinceId);
					regionCityId=isnull(result.body.regionCityId);
					regionCountyId=isnull(result.body.regionCountyId);
					regionStreetId=isnull(result.body.regionStreetId);
					$("#companyName").val(companyName);
					$("#address").val(companyRegAddress);
					$("#companyName").attr("disabled",true);
					$("#address").attr("disabled",true);
					$("#region").find("select").attr("disabled",true);
					listRegions(regionProvinceId,regionCityId,regionCountyId,regionStreetId);
				}else if(result.message=="2"){
					certNo=encodeURI(encodeURI(certNo));
					var companyId=isnull(result.body.companyId);
					var type=isnull(result.body.status);
					var companyName=encodeURI(encodeURI(isnull(result.body.companyName)));
					var companyAddress=encodeURI(encodeURI(isnull(result.body.companyAddress)));
					var companyRegion=encodeURI(encodeURI(isnull(result.body.regionProvince)+isnull(result.body.regionCity)+isnull(result.body.regionCounty)+isnull(result.body.regionStreet)));
					window.location.href="chain.mainten.mainten-reg-already?key="+key+"&certType="+ct+"&certNo="+certNo+"&companyId="+companyId+"&type="+type+"&companyName="+companyName+"&companyAddress="+companyAddress+"&companyRegion="+companyRegion;
				}else if(result.message=="3"){
					certNo=encodeURI(encodeURI(certNo));
					var companyId=isnull(result.body.companyId);
					var companyName=encodeURI(encodeURI(isnull(result.body.companyName)));
					var companyAddress=encodeURI(encodeURI(isnull(result.body.companyAddress)));
					var companyRegion=encodeURI(encodeURI(isnull(result.body.regionProvince)+isnull(result.body.regionCity)+isnull(result.body.regionCounty)+isnull(result.body.regionStreet)));
					window.location.href="chain.mainten.mainten-reg-ban?key="+key+"&certType="+ct+"&certNo="+certNo+"&companyId="+companyId+"&companyName="+companyName+"&companyAddress="+companyAddress+"&companyRegion="+companyRegion;
				}
			}
		},
		error: function(data) {
			alert("加载失败，请重试！");
		}
	});
}
function checkUserName(){
	$("#username").siblings(".text_ts").remove();
	var userName=$("#username").val().trim();
	if(userName!=null&&userName!=""&&!isUserName(userName)){
		$("#username").after('<span class="text_ts">请输入正确用户名格式 </span>');
		return;
	}
	$.ajax({
		url: "../register/checkUserExists",
		type:"post",
		dataType:'json',
		data:{"userName":userName},
		success: function(result) {
			if(result.body==true){
				$("#username").siblings(".text_ts").remove();
				$("#username").after('<span class="text_ts">该用户名已存在 </span>');
				checkUserNameFlag=false;
			}else{
				checkUserNameFlag=true;
			}
		},
		error: function(data) {
			alert("加载失败，请重试！");
		}
	});
}
function listRegions(provinceId,cityId,districtId,streetId){
	$("#provinces option:gt(0)").remove();
	$("#cities option:gt(0)").remove();
	$("#districts option:gt(0)").remove();
	$("#streets option:gt(0)").remove();
	$.ajax({
		url:"../base/getAdminRegion/getByLevel/-1",
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $provinces=$("<option>"+result[i].name+"</option>");
				$provinces.data("provinces",result[i].id);
				$("#provinces").append($provinces);
			}
			$.ajax({
				url:"../base/getAdminRegion/getRegionById/"+provinceId,
				type:"get",
				success:function(result){
					var province=result.name;
					$("#provinces option:contains("+province+")").attr("selected","selected");
					$("#provinceName").text(province);
				}
			});
		}
	});
	$.ajax({
		url:"../base/getAdminRegion/"+provinceId,
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $cities=$("<option>"+result[i].name+"</option>");
				$cities.data("cities",result[i].id);
				$("#cities").append($cities);
			}
			$.ajax({
				url:"../base/getAdminRegion/getRegionById/"+cityId,
				type:"get",
				success:function(result){
					var city=result.name;
					$("#cities option:contains("+city+")").attr("selected","selected");
					$("#cityName").text(city);
				}
			});
		}
	});
	$.ajax({
		url:"../base/getAdminRegion/"+cityId,
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $districts=$("<option>"+result[i].name+"</option>");
				$districts.data("districts",result[i].id);
				$("#districts").append($districts);
			}
			$.ajax({
				url:"../base/getAdminRegion/getRegionById/"+districtId,
				type:"get",
				success:function(result){
					var district=result.name;
					$("#districts option:contains("+district+")").attr("selected","selected");
					$("#districtName").text(district);
				}
			});
		}
	});
	$.ajax({
		url:"../base/getAdminRegion/"+districtId,
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $streets=$("<option>"+result[i].name+"</option>");
				$streets.data("streets",result[i].id);
				$("#streets").append($streets);
			}
			$.ajax({
				url:"../base/getAdminRegion/getRegionById/"+streetId,
				type:"get",
				success:function(result){
					var street=result.name;
					$("#streets option:contains("+street+")").attr("selected","selected");
					$("#streetName").text(street);
				}
			});
		}
	});
}
$(function(){
	$(".input_search").click(checkCert);
	$("#unit-code").blur(checkCert);
	$("#unit-select").change(function(){
		checkCert();
		checkCertType();
	});
	if(certType=="BIZ_CERT_NUMBER"){
		$("#unit-select").val("23002");
	}
	if(certType=="FOOD_CIRCU_CERT"){
		$("#unit-select").val("23003");
	}
	if(certType=="FOOD_PROD_CERT"){
		$("#unit-select").val("23004");
	}
	if(certType=="CATERING_CERT"){
		$("#unit-select").val("23001");
	}
	if(certType=="FOOD_BUSINESS_CERT"){
		$("#unit-select").val("23005");
	}
	$("#unit-code").val(certNo);
	//checkCompanyName();
	//$("#companyName").blur(checkCompanyName);
	$("#username").blur(checkUserName);
	if(flag!=""){
		$(".btn_dels").hide();
		$("#btn_save").show();
	}
	if(flag==1){
		$("#companyName").val(companyRegAddress);
		$("#address").val(companyRegAddress);
		$("#companyName").attr("disabled",true);
		$("#address").attr("disabled",true);
		$("select").attr("disabled",true);
		listRegions(regionProvinceId,regionCityId,regionCountyId,regionStreetId);
	}
	//加载省
	$("#provinces").children().eq(0).data("provinces","");
	$("#cities").children().eq(0).data("cities","");
	$("#districts").children().eq(0).data("districts","");
    $("#streets").children().eq(0).data("street","");
	$.ajax({
		url:"../base/getAdminRegion/getByLevel/-1",
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
			url:"../base/getAdminRegion/"+province,
			type:"get",
			async:false,
			success:function(result){
				for(var i=0;i<result.length;i++){
					var $cities=$("<option>"+result[i].name+"</option>");
					$cities.data("cities",result[i].id);
					$("#cities").append($cities);
				}
			}
		});
		$("#provinceName").text("");
		$("#cityName").text("");
		$("#districtName").text("");
		$("#streetName").text("");
		if($("#provinces option:selected").text()!="请选择"){
			$("#provinceName").text($("#provinces option:selected").text());
		}
	});
	//市变更时加载区
	$("#cities").change(function(){
		var city=$("#cities option:selected").data("cities");
		$("#districts option:gt(0)").remove();
		$("#streets option:gt(0)").remove();
		$.ajax({
			url:"../base/getAdminRegion/"+city,
			type:"get",
			async:false,
			success:function(result){
				for(var i=0;i<result.length;i++){
					var $districts=$("<option>"+result[i].name+"</option>");
					$districts.data("districts",result[i].id);
					$("#districts").append($districts);
				}
			}
		});
		$("#cityName").text("");
		$("#districtName").text("");
		$("#streetName").text("");
		if($("#cities option:selected").text()!="请选择"){
			$("#cityName").text($("#cities option:selected").text());
		}
	});
	//区变更时加载街道
	$("#districts").change(function(){
		var disctrict=$("#districts option:selected").data("districts");
		$("#streets option:gt(0)").remove();
		$.ajax({
			url:"../base/getAdminRegion/"+disctrict,
			type:"get",
			async:false,
			success:function(result){
				for(var i=0;i<result.length;i++){
					var $streets=$("<option>"+result[i].name+"</option>");
					$streets.data("streets",result[i].id);
					$("#streets").append($streets);
				}
			}
		});
		$("#districtName").text("");
		$("#streetName").text("");
		if($("#districts option:selected").text()!="请选择区县"){
			$("#districtName").text($("#districts option:selected").text());
		}
	});
	$("#streets").change(function(){
		$("#streetName").text("");
		if($("#streets option:selected").text()!="请选择街道"){
			$("#streetName").text($("#streets option:selected").text());
		}
	});
	$("#back").click(function(){
		window.location.href="javascript:history.back(-1);";
	});
	//特殊字符验证
	$("body").on("blur","input[type='text']",function(){
 		$(this).siblings(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    }
	});
	$("#mobilephone").blur(function(){
		var contactPhone=$("#mobilephone").val().trim();
		$(this).siblings(".text_ts").remove();
		if(!(contactPhone==""||contactPhone==null||isMobilephone(contactPhone))){
			$("#mobilephone").after('<span class="text_ts">请输入正确手机号码 </span>');
		}
	});
	$("#password").blur(function(){
		$("#password").siblings(".text_ts").remove();
		var password=$("#password").val().trim();
		if(password!=null&&password!=""&&!isPwd(password)){
			$("#password").after('<span class="text_ts">请输入正确密码格式</span>');
			return;
		}
	});
	$("#password_confirm").blur(function(){
		$("#password_confirm").siblings(".text_ts").remove();
		if($("#password_confirm").val().trim()!=$("#password").val().trim()){
			$("#password_confirm").after('<span class="text_ts">输入密码不一致</span>');
		}
	})
	$("#btn_save").click(function(){
		var params={};
		$(".text_ts").remove();
		
		if(!checkUserNameFlag){
			$("#username").siblings(".text_ts").remove();
			$("#username").after('<span class="text_ts">该用户名已存在 </span>');
		}
		if(!checkCompanyNameFlag){
			$("#companyName").siblings(".text_ts").remove();
			$("#companyName").after('<span class="text_ts">该企业名称已存在 </span>');
		}
		var ajaxFlag=true;
		//地区判断
		var optflag=true;
		$("option:selected").each(function(){
			var opt=$(this).text();
			if(opt.indexOf("请选择")>=0){
				optflag=false;
			}
		})
		
		if(optflag==false){
			console.log(optflag);
			$("#region").find("td:eq(1)").append('<span class="text_ts">必要信息不能为空</span>');
			ajaxFlag=false;
		}
		$("tr input").each(function(){
			var input=$(this).val().trim();
			if(input==null||input==""){
				$(this).after('<span class="text_ts">必要信息不能为空 </span>');
				ajaxFlag=false;
			}
		})
		$("tr input").each(function(){
			var input=$(this).val().trim();
			if(checkSpecificKey(input)==false){
				$(this).after('<span class="text_ts">请勿输入特殊字符 </span>');
				ajaxFlag=false;
			}
		});
		var password=$("#password").val().trim();
		if(password!=null&&password!=""&&!isPwd(password)){
			$("#password").after('<span class="text_ts">请输入正确密码格式</span>');
			ajaxFlag=false;
		}
		var userName=$("#username").val().trim();
		if(userName!=null&&userName!=""&&!isUserName(userName)){
			$("#username").after('<span class="text_ts">请输入正确用户名格式 </span>');
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
		if(ajaxFlag&&checkUserNameFlag&&checkCompanyNameFlag){
			$("#btn_save").attr("disabled",true);
			var certType=$("#cert").find("option:selected").text();
			var certNo=$("#cert").find("input:text").val().trim();
			var companyName=$("#companyName").val().trim();
			var companyRegAddress=$("#provinceName").text()+$("#cityName").text()+$("#districtName").text()+$("#streetName").text()+$("#address").val().trim();
			var loginUserName=$("#username").val().trim();
			var loginUserPsw=$("#password").val().trim();
			var loginUserPersonName=$("#person").val().trim();
			var loginUserMobile=$("#mobilephone").val().trim();
			var regionProvinceId=$("#provinces").find("option:selected").data("provinces");
			var regionCityId=$("#cities").find("option:selected").data("cities");
			var regionCountyId=$("#districts").find("option:selected").data("districts");
			var regionStreetId=$("#streets").find("option:selected").data("streets");
			companyToType=$(":radio[name=type]:checked").val();
			if(certType=="工商营业执照"){
				params.bizCertNum=certNo;
			}
			if(certType=="食品流通许可证"){
				params.foodCircuCert=certNo;
			}
			if(certType=="食品生产许可证"){
				params.foodProdCert=certNo;
			}
			if(certType=="餐饮服务许可证"){
				params.cateringCert=certNo;
			}
			if(certType=="食品经营许可证"){
				params.foodBusinessCert=certNo;
			}
			params.companyName=companyName;
			params.companyRegAddress=companyRegAddress;
			params.loginUserName=loginUserName;
			params.loginUserPsw=loginUserPsw;
			params.loginUserPersonName=loginUserPersonName;
			params.loginUserMobile=loginUserMobile;
			if(companyBizAddress==""){
				companyBizAddress=companyRegAddress;
			}
			//隐藏信息
			params.companyNameAbbrev=companyNameAbbrev;
			params.companyBizAddress=companyBizAddress;
			params.regionProvinceId=regionProvinceId;
			params.regionCityId=regionCityId;
			params.regionCountyId=regionCountyId;
			params.regionStreetId=regionStreetId;
			if(certData!=""){
				params.regByOfficialCert=certData;
			}
			console.log(params);
			$.ajax({
				url: "../comRelationship/relationship/registerBranchStore",
				type:"post",
				headers: { 
					'Accept': 'application/json',
					'Content-Type': 'application/json' 
				},
				dataType:'json',
				data:JSON.stringify({"companyWithLoginAdmin":JSON.stringify(params),"companyToType":companyToType}),
				success: function(result) {
					if(result.status==0){
						if(key!=""){
							window.top.location.href="../default.do";
						}else{
							window.location.href="chain.mainten.mainten";
						}
					}else{
						alert(result.message);
						$("#btn_save").attr("disabled",false);
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
          <h3 class="process_title"><span>当前位置: </span><a href="chain.mainten.mainten<%=key%>">门店管理</a> > <a href="javascript:void(0)">门店注册</a></h3>
          <div class="info_box">
               <table class="info_mation">
                  <tr>
                       <td class="td_lf"><em class="star">*</em>企业证照</td>
                       <td id="cert">
                       	   <div class="select_s" style="width:172px; float:left;">
                            <div class="select_is" style="width:172px;">
                               <select class="select_cs" style="width:192px;background-position:-25px -122px;*+width:182px" id="unit-select">
                                      <option value="">请选择证件类型</option>
                                      <option value="23001">餐饮服务许可证</option>
                                      <option value="23003">食品流通许可证</option>
                                      <option value="23004">食品生产许可证</option>
                                      <option value="23005">食品经营许可证</option>
                                      <option value="23002">工商营业执照</option>
                               </select>
                             </div>
                           </div>
                           <input type="text" class="input_code" style="width:167px;float:left;margin-left:10px;margin-right:10px;" placeholder="请输入证件号码" value="" id="unit-code" />
                           <input type="button" class="input_search" value="查询" />
                       </td>
                  </tr>
                  <tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>单位名称</td>
                                 <td><input
                                 id="companyName" type="text" class="input_code" value=""  style="width:424px;" maxlength="30"/></td>
                            </tr>
                            <tr class="necessary" id="region">
								<td class="td_lf"><em class="star">*</em>区域</td>
								<td>
									<div class="select_s" style="width:82px; float:left;">
			                           <div class="select_is" style="width:82px;">
			                              <select class="select_cs" style="width:112px; background-position:-110px -122px; " id="provinces">
			                                     <option>请选择</option>
			                              </select>
			                            </div>
			                          </div>
			                          <div class="select_s" style="width:82px; float:left; margin-left:10px;">
			                           <div class="select_is" style="width:82px;">
			                              <select class="select_cs" style="width:122px; background-position:-110px -122px; " id="cities">
			                                     <option>请选择</option>
			                              </select>
			                            </div>
			                          </div>
			                          <div class="select_s" style="width:122px; float:left; margin-left:10px;">
			                           <div class="select_is" style="width:122px;">
			                              <select class="select_cs" style="width:152px; background-position:-70px -122px; " id="districts">
			                                     <option>请选择区县</option>
			                              </select>
			                            </div>
			                          </div>
			                          <div class="select_s" style="width:122px; float:left; margin-left:10px;">
			                           <div class="select_is" style="width:122px;">
			                              <select class="select_cs" style="width:152px; background-position:-70px -122px; " id="streets">
			                                     <option>请选择街道</option>
			                              </select>
			                            </div>
			                          </div>
								</td>
							</tr>
                            <tr>
                                 <td class="td_lf line"><em class="star">*</em>单位地址</td>
                                 <td class="line"><span id="provinceName"></span><span id="cityName"></span><span id="districtName"></span><span id="streetName"></span><input 
								 id="address" type="text" class="input_code" value=""  style="width:424px;" maxlength="50"/></td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>联系人</td>
                                 <td><input 
								 id="person" type="text" class="input_code" value=""  style="width:424px;" maxlength="10"/></td>
                            </tr>
                            <tr>
                                 <td class="td_lf line"><em class="star">*</em>手机</td>
                                 <td class="line"><input
								id="mobilephone" type="text" class="input_code" value=""  style="width:424px;" maxlength="20"/></td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>登录账号</td>
                                 <td><input 
                                 id="username" type="text" class="input_code" value=""  style="width:424px;" maxlength="30" placeholder="4-30位大小写字母或数字,以及@_"/></td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>密码</td>
                                 <td><input 
                                 id="password" type="password" class="input_code" value=""  style="width:424px;" maxlength="20" placeholder="6-20位大小写字母或数字,@_"/></td>
                            </tr>
                            <tr>
                                 <td class="td_lf line"><em class="star">*</em>密码确认</td>
                                 <td class="line"><input 
								 id="password_confirm" type="password" class="input_code" value=""  style="width:424px;" maxlength="20"/></td>
                            </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>门店类型</td>
                       <td>
                           <label style="margin-right:10px;"><input type="radio" name="type" style="position:relative;top:3px;" checked="checked" value="61001"/> 自营店/分店</label>
                           <label style="margin-right:10px;"><input type="radio" name="type" style="position:relative;top:3px;" value="61002"/> 加盟店</label>
                           <label><input type="radio" name="type" style="position:relative;top:3px;" value="61003"/> 承包方</label>
                       </td>
                   </tr>
                </table>
                <p class="text_ts" style="margin-left:78px;">提示: 添加成功后，同时将该单位设为协议收货商</p>
                <p class="save_box">
                  <input type="button" class="btn_dels" value="注册并添加" disabled="disabled" style="cursor:default"/>
                  <input type="button" class="btn_save" value="注册并添加" style="display:none" id="btn_save"/>
                  <input type="button" class="btn_save" value="返回" onClick="window.location.href='chain.mainten.mainten<%=key%>'"/>
                </p>
               <div class="clear"></div>
          </div>
     </div>
</div>    
</body>
</html>