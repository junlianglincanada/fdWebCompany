<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
	String certType=request.getParameter("certType");
	String companyId=request.getParameter("companyId");
	String certNo=request.getParameter("certNo");
	if(certNo!=null&&certNo!=""){
		certNo=java.net.URLDecoder.decode(certNo, "UTF-8");
	}
	String companyName=request.getParameter("companyName");
	if(companyName!=null&&companyName!=""){
		companyName=java.net.URLDecoder.decode(companyName, "UTF-8");
	}
	String companyAddress=request.getParameter("companyAddress");
	if(companyAddress!=null&&companyAddress!=""){
		companyAddress=java.net.URLDecoder.decode(companyAddress, "UTF-8");
	}
	String companyRegion=request.getParameter("companyRegion");
	if(companyRegion!=null&&companyRegion!=""){
		companyRegion=java.net.URLDecoder.decode(companyRegion, "UTF-8");
	}
	String key=request.getParameter("key")==null?"":request.getParameter("key");
	String type=request.getParameter("type")==null?"":request.getParameter("type");
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
var certType="<%=certType %>";
var certNo="<%=certNo %>";
var companyId="<%=companyId %>";
var companyName=isnull("<%=companyName%>");
var companyAddress=isnull("<%=companyAddress%>");
var companyRegion=isnull("<%=companyRegion%>");
var certData="";
var type=isnull("<%=type%>");
var key=isnull("<%=key%>");//用来判断页面跳转
function checkCertType(){
	var certType=$("#cert").find("option:selected").text();
	if(certType=="工商营业执照"){
		$("#cert").find(".input_code").attr("placeholder","15位工商注册号或18位统一信用代码");
	}else if(certType=="食品经营许可证"){
		$("#cert").find(".input_code").attr("placeholder","请输入JY加14位数字或字母的证件号码");
	}else if(certType=="餐饮服务许可证"){
		$("#cert").find(".input_code").attr("placeholder","请输入16位数字或字母的证件号码");
	}else if(certType=="食品流通许可证"){
		$("#cert").find(".input_code").attr("placeholder","请输入SP加16位数字或字母的证件号码");
	}else if(certType=="食品生产许可证"){
		$("#cert").find(".input_code").attr("placeholder","请输入QS加12位数字字母或SC加14位数字字母的证件号码");
	}else{
		$("#cert").find(".input_code").attr("placeholder","");
	}
}
function checkCert(){
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
				if(result.messageCode=="0"){
					certNo=encodeURI(encodeURI(certNo));
					window.location.href="chain.mainten.mainten-reg?key="+key+"&flag=0&certType="+ct+"&certNo="+certNo;
				}
				if(result.message=="4"){
					certNo=encodeURI(encodeURI(certNo));
					certData=$("#unit-select").val();
					companyName=encodeURI(encodeURI(isnull(result.body.companyName)));
					companyBizAddress=encodeURI(encodeURI(isnull(result.body.companyBizAddress)));
					companyNameAbbrev=encodeURI(encodeURI(isnull(result.body.companyNameAbbrev)));
					companyRegAddress=encodeURI(encodeURI(isnull(result.body.companyRegAddress)));
					regionProvinceId=isnull(result.body.regionProvinceId);
					regionCityId=isnull(result.body.regionCityId);
					regionCountyId=isnull(result.body.regionCountyId);
					regionStreetId=isnull(result.body.regionStreetId);
					window.location.href="chain.mainten.mainten-reg?key="+key+"&flag=1&certType="+ct+"&certNo="+certNo+"&certData="+certData+"&companyName="+companyName+"&companyBizAddress="+companyBizAddress+"&companyNameAbbrev="+companyNameAbbrev+"&companyRegAddress="+companyRegAddress+"&regionProvinceId="+regionProvinceId+"&regionCityId="+regionCityId+"&regionCountyId="+regionCountyId+"&regionStreetId="+regionStreetId;
				}else if(result.message=="2"){
					$("#btn_save").show();
					$("#apply_msg").hide();
					$(":radio").attr("disabled",false);
					companyId=isnull(result.body.companyId);
					type=isnull(result.body.status);
					if(type!=""){
						$("#btn_save").hide();
						$("#apply_msg").show();
						$(":radio[name=type][value="+type+"]").attr("checked",true);
						$(":radio").attr("disabled",true);
					}
					companyName=isnull(result.body.companyName);
					companyAddress=isnull(result.body.companyAddress);
					companyRegion=isnull(result.body.regionProvince)+isnull(result.body.regionCity)+isnull(result.body.regionCounty)+isnull(result.body.regionStreet);
					$("#companyName").text(companyName);
					$("#companyRegion").text(companyRegion);
					$("#companyAddress").text(companyAddress);
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
$(function(){
	$("#btn_save").show();
	$("#apply_msg").hide();
	$(":radio").attr("disabled",false);
	$("#unit-select").change(checkCertType);
	$(".input_search").click(checkCert);
	if(certType=="BIZ_CERT_NUMBER"){
		$("#unit-select").val("23002");
		$("#cert").find(".input_code").attr("placeholder","15位工商注册号或18位统一信用代码");
	}
	if(certType=="FOOD_CIRCU_CERT"){
		$("#unit-select").val("23003");
		$("#cert").find(".input_code").attr("placeholder","请输入SP加16位数字或字母的证件号码");
	}
	if(certType=="FOOD_PROD_CERT"){
		$("#unit-select").val("23004");
		$("#cert").find(".input_code").attr("placeholder","请输入QS加12位数字字母或SC加14位数字字母的证件号码");
	}
	if(certType=="CATERING_CERT"){
		$("#unit-select").val("23001");
		$("#cert").find(".input_code").attr("placeholder","请输入16位数字或字母的证件号码");
	}
	if(certType=="FOOD_BUSINESS_CERT"){
		$("#unit-select").val("23005");
		$("#cert").find(".input_code").attr("placeholder","请输入JY加14位数字或字母的证件号码");
	}
	$("#unit-code").val(certNo);
	$("#companyName").text(companyName);
	$("#companyRegion").text(companyRegion);
	$("#companyAddress").text(companyAddress);
	if(type!=""){
		$("#btn_save").hide();
		$("#apply_msg").show();
		$(":radio[name=type][value="+type+"]").attr("checked",true);
		$(":radio").attr("disabled",true);
	}
	$("#btn_save").click(function(){
		var params={};
		var companyToType=$(":radio[name=type]:checked").val();
		params.companyToId=companyId;
		params.companyToType=companyToType;
		$.ajax({
			url:"../comRelationship/relationship/createBranchStore/",
			type:"post",
			data:JSON.stringify(params),
			dataType:"json",
			headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    success: function(){
		    	if(key!=""){
		    		window.top.location.href="../default.do";
				}else{
					window.location.href="chain.mainten.mainten";
				}
		    }
		});
	})
/*-------jquery end-------*/
});	
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="chain.mainten.mainten<%=key%>">门店管理</a> > <a href="javascript:void(0)">门店注册</a></h3>
          <div class="info_box">
               <table class="info_mation">
                  <tr id="cert">
                       <td class="td_lf"><em class="star">*</em>企业证照</td>
                       <td>
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
                       <td class="td_lf"><em class="star">*</em>单位名称</td>
                       <td>
                       	   <span id="companyName"></span>
                           <span class="text_ts">本企业已注册！</span>
                       </td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>所在地区</td>
                       <td><span id="companyRegion"></span></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>详情地址</td>
                       <td><span id="companyAddress"></span></td>
                  </tr>
                </table>
                <table class="info_mation" style="border-top:1px solid #dcdddd;">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>门店类型</td>
                       <td>
                           <label style="margin-right:10px;"><input type="radio" name="type" checked="checked" style="position:relative;top:3px;" value="61001"/> 自营店/分店</label>
                           <label style="margin-right:10px;"><input type="radio" name="type" style="position:relative;top:3px;" value="61002"/> 加盟店</label>
                           <label><input type="radio" name="type" style="position:relative;top:3px;" value="61003"/> 承包方</label><span class="text_ts" style="display:none" id="apply_msg">已申请添加该企业为门店</span>
                       </td>
                   </tr>
                </table>
                <p class="text_ts" style="margin-left:78px;">提示: 添加成功后，同时将该单位设为协议收货商</p>
                <p class="save_box">
                  <input type="button" class="btn_dels" value="添加到门店" disabled="disabled" style="cursor:default;display:none"/>
                  <input type="button" class="btn_save" value="添加到门店" id="btn_save"/>
                  <input type="button" class="btn_save" value="返回" onClick="window.location.href='chain.mainten.mainten<%=key%>'"/>
                </p>
               <div class="clear"></div>
          </div>
     </div>
</div>   
</body>
</html>