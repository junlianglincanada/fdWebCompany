<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.wondersgroup.framework.util.ConfigPropertiesUtil"%>
<%@ page session="false"%>
<%
	String certType=request.getParameter("certType");
	String certNo=request.getParameter("certNo");
	String endDate=request.getParameter("endDate");
	String companyName=request.getParameter("companyName");
	if(certType!=null&&certType!=""){
		certType=java.net.URLDecoder.decode(certType, "UTF-8");
	}
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
	//System.out.println(companyRegAddress);
	String locationProvince = ConfigPropertiesUtil.getValue("location.province");
	String locationCity = ConfigPropertiesUtil.getValue("location.city");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.gray{border-bottom: 1px solid #dcdddd;color: gray;text-align: left;padding-left: 13.5%;}
</style>
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript">${_csrf.parameterName}&${_csrf.token}</script>
<script src="../js/reAlert.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/custome.js" type="text/javascript" charset="utf-8"></script>	
<script type="text/ecmascript" src="../js/base64.js"></script>
<script type="text/javascript">
var certType="<%=certType %>";
var certNo="<%=certNo %>";
var endDate="<%=endDate %>";
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
var flag=isnull("<%=flag%>");
var certData=isnull("<%=certData%>");
var locationProvince = "<%=locationProvince%>";
var locationCity = "<%=locationCity%>";
function isUserName(code){
	var reCode = /^[a-zA-Z0-9@_]{4,20}$/;
	return (reCode.test(code));
}
function isPwd(code){
	var reCode = /^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?![_@]+$)[a-zA-Z0-9@_]{6,20}$/;
	return (reCode.test(code));
}
function checkUserName(){
	$("#username").siblings(".text_ts").remove();
	var userName=$("#username").val().trim();
	if(userName!=null&&userName!=""&&!isUserName(userName)){
		$("#username").after('<span class="text_ts">账号是4-20位数字、大小写字母、@_的至少两种组合。   </span>');
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
function checkCompanyName(){
	$("#companyName").siblings(".text_ts").remove();
	var companyName=$("#companyName").val().trim();
	if(!checkSpecificKey(companyName)){
		$("#companyName").after('<span class="text_ts">请勿输入特殊字符 </span>');
		return;
	}
	if(companyName!=""&&companyName!=null&&companyName!="null"){
		$.ajax({
			url: "../register/checkCompanyExists",
			type:"post",
			dataType:'json',
			data:{"companyName":companyName},
			success: function(result) {
				if(result.body==true){
					$("#companyName").after('<span class="text_ts">该企业名称已存在 </span>');
					checkCompanyNameFlag=false;
				}else{
					checkCompanyNameFlag=true;
				}
			},
			error: function(data) {
				alert("加载失败，请重试！");
			}
		});
	}
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
					//$("#provinceName").text(province);
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
					//$("#cityName").text(city);
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
			if(districtId != ''){
				$.ajax({
					url:"../base/getAdminRegion/getRegionById/"+districtId,
					type:"get",
					success:function(result){
						var district=result.name;
						$("#districts option:contains("+district+")").attr("selected","selected");
						//$("#districtName").text(district);
					}
				});
			}
		}
	});
	if(districtId != ''){
		$.ajax({
			url:"../base/getAdminRegion/"+districtId,
			type:"get",
			success:function(result){
				for(var i=0;i<result.length;i++){
					var $streets=$("<option>"+result[i].name+"</option>");
					$streets.data("streets",result[i].id);
					$("#streets").append($streets);
				}
				if(streetId != ''){
					$.ajax({
						url:"../base/getAdminRegion/getRegionById/"+streetId,
						type:"get",
						success:function(result){
							var street=result.name;
							$("#streets option:contains("+street+")").attr("selected","selected");
							//$("#streetName").text(street);
						}
					});
				}
			}
		});
	}
}
$(function(){
	/* if(certType=="BIZ_CERT_NUMBER"){
		certType="工商营业执照";
	}
	if(certType=="FOOD_CIRCU_CERT"){
		certType="食品流通许可证";
	}
	if(certType=="FOOD_PROD_CERT"){
		certType="食品生产许可证";
	}
	if(certType=="CATERING_CERT"){
		certType="餐饮服务许可证";
	}
	if(certType=="FOOD_BUSINESS_CERT"){
		certType="食品经营许可证";
	} */
	$("#certType").text(certType);
	$("#certNo").text(certNo);
	$("#companyName").val(companyName);
	$("#address").val(companyRegAddress);
	//加载省
	$("#provinces").children().eq(0).data("provinces","");
	$("#cities").children().eq(0).data("cities","");
	$("#districts").children().eq(0).data("districts","");
    $("#streets").children().eq(0).data("street","");
	if(flag==1){
		$("#companyName").attr("disabled",true);
		if(parseInt(certData)<10){
			$("#address").attr("disabled",true);
			$("select").attr("disabled",true);
		}
		listRegions(regionProvinceId,regionCityId,regionCountyId,regionStreetId);
	}else{
		$.ajax({
			url:"../base/getAdminRegion/getByLevel/-1",
			type:"get",
			async:false,
			success:function(result){
				for(var i=0;i<result.length;i++){
					var $provinces=$("<option>"+result[i].name+"</option>");
					$provinces.data("provinces",result[i].id);
					$("#provinces").append($provinces);
				}
				$("#provinces option:contains("+locationProvince+")").attr("selected","selected");
				$("#provinceName").text(locationProvince);
			}
		});
		var province=$("#provinces option:selected").data("provinces");
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
				$("#cities option:contains("+locationCity+")").attr("selected","selected");
				$("#cityName").text(locationCity);
			}
		});
		var city=$("#cities option:selected").data("cities");
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
	}
	//checkCompanyName();
	//$("#companyName").blur(checkCompanyName);
	$("#username").blur(checkUserName);
	/* $("#companyName").focus(function(){
		var n=$("#companyName").siblings(".text_ts").length;
		if(n==0){
			$("#companyName").after('<span class="text_ts">请输入上一步所选证照上的单位名称 </span>');
		}
	})
	$("#address").focus(function(){
		var n=$("#companyName").siblings(".text_ts").length;
		if(n==0){
			$("#address").after('<span class="text_ts">请输入上一步所选证照上的注册地址 </span>');
		}
	})
	$("#address").blur(function(){
		$("#address").next(".text_ts").remove();
	}) */
	
	
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
		//if(password!=null&&password!=""&&!isPwd(password)){
			//$("#password").after('<span class="text_ts">密码是6-20位数字、大小写字母、@_的至少两种组合。 </span>');
			if(checkSpecificKey(password)==false){
	   			$("#password").after('<span class="text_ts">请勿输入特殊字符 </span>');
	   			return ;
	   		}
	   		//非空输入框非空验证
	   		if(password==""||password==null){
	   			$("#password").after('<span class="text_ts">新密码不能为空 </span>');
	   			return ;
	   		}
	   		if(password!="")
	   			{var reg = /^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?![_@]+$)[a-zA-Z0-9@_]{6,20}$/;
	   			if(!reg.test(password)){
	   		    	  $("#password").after('<span class="text_ts">密码是6-20位数字、大小写字母、@_的至少两种组合。 </span>');

	   		    	  return ;
	   			}
	   				}
			//return;
		//}
	});
	$("#password_confirm").blur(function(){
		$("#password_confirm").siblings(".text_ts").remove();
		var password=$("#password").val().trim();
		var password_confirm=$("#password_confirm").val().trim();
		//if($("#password_confirm").val().trim()!=$("#password").val().trim()){
			//$("#password_confirm").after('<span class="text_ts">您两次输入的密码不一致，请重新输入！！</span>');
		//}
		if(checkSpecificKey(password_confirm)==false){
   			$("#password_confirm").after('<span class="text_ts">请勿输入特殊字符 </span>');

   			return ;
   		}
   		//非空输入框非空验证
   		if(password_confirm==""||password_confirm==null){
   			$("#password_confirm").after('<span class="text_ts">确认密码不能为空 </span>');

   			return ;
   		}
   		if(password_confirm != password){
	    		 $("#password_confirm").after('<span class="text_ts">您两次输入的密码不一致，请重新输入！！ </span>');

	    		 return ;
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
			var certType=$("#certType").text();
			var certNo=$("#certNo").text();
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
				params.endDate=endDate;
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
				url: "../register/createCompanyWithLoginAdmin",
				type:"post",
				headers: { 
					'Accept': 'application/json',
					'Content-Type': 'application/json' 
				},
				dataType:'json',
				data:JSON.stringify({"companyWithLoginAdmin":JSON.stringify(params)}),
				success: function(result) {
					if(result.status==0){
						var company=encodeURI(encodeURI(companyName));
						var user=encodeURI(encodeURI(loginUserName));
						var password=encodeURI(encodeURI(loginUserPsw));
	         			var b = new Base64();  
						password = b.encode(password);
						
						window.parent.location.href="../reg_third.jsp?company="+company+"&user="+user+"&password="+password;
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
          <h3 class="reg_fh"><a href="reg_frame.jsp" target="_top"><i class="i_fh"></i><span>返回</span></a></h3>
          <div class="reg_tent">
               <div class="reg_title">
                    <ul class="reg_list">
                        <li><span><i>1</i><em>验证</em></span></li>
                        <li class="default"><span><i>2</i><em>注册</em></span></li>
                        <li><span><i>3</i><em>完成</em></span></li>
                    </ul>
               </div>
               <div class="reg_detail">
                    <div class="info_box" style="min-height:300px;">
                         <table class="info_mation">
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>证件类型</td>
                                 <td>
                                     <span id="certType"></span>
                                     <span id="certNo"></span>
                                 </td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>单位名称</td>
                                 <td><input
                                 id="companyName" type="text" class="input_code" style="width:266px;" value="" placeholder="请输入上一步所选证照上的单位名称 " maxlength="30"/></td>
                            </tr>
                            <tr class="necessary">
								<td class="td_lf"><em class="star">*</em>区域</td>
								<td>
									<div class="select_s" style="width:131px; float:left;">
			                           <div class="select_is" style="width:132px;">
			                              <select class="select_cs" style="width:147px; background-position:-63px -122px; " id="provinces">
			                                     <option>请选择</option>
			                              </select>
			                            </div>
			                          </div>
			                          <div class="select_s" style="width:141px; float:left; margin-left:10px;">
			                           <div class="select_is" style="width:141px;">
			                              <select class="select_cs" style="width:160px; background-position:-55px -122px; " id="cities">
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
                                 <td class="line">
                                 	<span id="provinceName"></span><span id="cityName"></span><span id="districtName"></span><span id="streetName"></span>
                                 <input id="address" type="text" class="input_code" style="width:266px;" value="" placeholder="请输入上一步所选证照上的注册地址 " maxlength="50"/></td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>联系人</td>
                                 <td><input 
								 id="person" type="text" class="input_code" style="width:266px;"  value="" maxlength="10"/></td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>手机</td>
                                 <td><input
								id="mobilephone" type="text" class="input_code" style="width:266px;"  value="" maxlength="20"/></td>
                            </tr>
                            <tr>
                                <td colspan="2" class="gray">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：登录后，可在“系统管理-个人中心”完成手机认证，手机认证后，可使用短信验证找回密码。</td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>登录账号</td>
                                 <td><input 
                                 id="username" type="text" class="input_code" style="width:266px;"  value="" maxlength="20" placeholder="4-20位数字、大小写字母、以及@_ "/></td>
                            </tr>
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>密码</td>
                                 <td><input 
                                 id="password" type="password" class="input_code" style="width:266px;"  value="" maxlength="20" placeholder="6-20位数字、大小写字母、@_的至少两种组合"/></td>
                            </tr>
                            <tr>
                                 <td class="td_lf line"><em class="star">*</em>密码确认</td>
                                 <td class="line"><input 
								 id="password_confirm" type="password" class="input_code" style="width:266px;" value="" maxlength="20"/></td>
                            </tr>
                         </table>
                         
                    </div>
                    <p class="save_box">
                       <input type="button" class="btn_save" id="back" value="上一步"/>
                       <input type="button" class="btn_save" id="btn_save" value="提交"/>
                    </p>
               </div
          ></div>
     </div>
</div>
</body>
</html>