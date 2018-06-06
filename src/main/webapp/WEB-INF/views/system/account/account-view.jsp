<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<script src="../js/jquery.qrcode.min.js" type="text/javascript" charset="utf-8"></script> 
<script type="text/javascript">
function searchRegion(id,span){
	if(id!=""){
		$.ajax({
			url:"../base/getAdminRegion/getRegionById/"+id,
			type:"get",
			success:function(result){
				$("#"+span).text(result.name);
			}
		});
	}
}
$(function(){
	$("#loading").show();
	$.ajax({
		url:"../company/getCompanyInfo",
		type:"get",
		success:function(result){
			console.log(result.body);
			var companyName=isnull(result.body.companyName);
			var companyNameAbbrev=isnull(result.body.companyNameAbbrev);
			var companyRegAddress=isnull(result.body.companyRegAddress);
			var companyBizAddress=isnull(result.body.companyBizAddress);
			var regionProvinceId=isnull(result.body.regionProvinceId);
			var regionCityId=isnull(result.body.regionCityId);
			var regionCountyId=isnull(result.body.regionCountyId);
			var regionStreetId=isnull(result.body.regionStreetId);
			var foodBusinessCert=isnull(result.body.foodBusinessCert);
			var cateringCert=isnull(result.body.cateringCert);
			var foodProdCert=isnull(result.body.foodProdCert);
			var foodCircuCert=isnull(result.body.foodCircuCert);
			var bizCertNumber=isnull(result.body.bizCertNumber);
			var bizCertExpDate=isnull(result.body.bizCertExpDate);
			var foodBusinessCertExpDate=isnull(result.body.foodBusinessCertExpDate);
			var cateringCertExpDate=isnull(result.body.cateringCertExpDate);
			var foodProdCertExpDate=isnull(result.body.foodProdCertExpDate);
			var foodCircuCertExpDate=isnull(result.body.foodCircuCertExpDate);
			var contactPerson=isnull(result.body.contactPerson);
			var contactPhone=isnull(result.body.contactPhone);
			var restCuisineType=isnull(result.body.restCuisineTypeValue);
			restCuisineType=restCuisineType.substring(0,restCuisineType.length-1);
			var restAtmosphere=isnull(result.body.restAtmosphereValue);
			restAtmosphere=restAtmosphere.substring(0,restAtmosphere.length-1);
			var averageComsumption=isnull(result.body.averageComsumptionValue);
			var commercialCenter=isnull(result.body.commercialCenterValue);
			$(".process_title a").text(companyName);
			$(".info_tab a:eq(1)").attr("href","system.account.account-view-photo?companyName="+encodeURI(encodeURI(companyName)));
			$("#companyName").text(companyName);
			$("#companyNameAbbrev").text(companyNameAbbrev);
			$("#companyRegAddress").text(companyRegAddress);
			$("#companyBizAddress").text(companyBizAddress);
			searchRegion(regionProvinceId,"province");
			searchRegion(regionCityId,"city");
			searchRegion(regionCountyId,"district");
			searchRegion(regionStreetId,"street");
			if(foodBusinessCert!=""){
				var certType="食品经营许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style=" width:252px;margin-left:10px; float:left;">'+foodBusinessCert+'</span><a style="width:100px;color:#1A73C3;margin-left:50px; float:left;">&nbsp;</a><span style="margin-left:10px; float:left;">'+foodBusinessCertExpDate+'</span></td></tr>');
				$("#table1 tr:eq(4)").after($tr);
			}
			if(cateringCert!=""){
				var certType="餐饮服务许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style=" width:252px;margin-left:10px; float:left;">'+cateringCert+'</span><a style="width:100px;color:#1A73C3;margin-left:50px; float:left;">&nbsp;</a><span style="margin-left:10px; float:left;">'+cateringCertExpDate+'</span></td></tr>');
				$("#table1 tr:eq(4)").after($tr);
			}
			if(foodProdCert!=""){
				var certType="食品生产许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style=" width:252px;margin-left:10px; float:left;">'+foodProdCert+'</span><a style="width:100px;color:#1A73C3;margin-left:50px; float:left;">&nbsp;</a><span style="margin-left:10px; float:left;">'+foodProdCertExpDate+'</span></td></tr>');
				$("#table1 tr:eq(4)").after($tr);
			}
			if(foodCircuCert!=""){
				var certType="食品流通许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style=" width:252px;margin-left:10px; float:left;">'+foodCircuCert+'</span><a style="width:100px;color:#1A73C3;margin-left:50px; float:left;">&nbsp;</a><span style="margin-left:10px; float:left;">'+foodCircuCertExpDate+'</span></td></tr>');
				$("#table1 tr:eq(4)").after($tr);
			}
			if(bizCertNumber!=""){
				var certType="工商营业执照";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style="  width:252px;float:left; margin-left:10px;">'+bizCertNumber+'</span><a style="width:100px;color:#1A73C3;margin-left:50px; float:left;">&nbsp;</a><span style="margin-left:10px; float:left;">'+bizCertExpDate+'</span></td></tr>');
				$("#table1 tr:eq(4)").after($tr);
			}
			$("#table1 tr:eq(5) td:eq(0)").html('<em class="star">*</em>证件类型');
			$("#table1 tr:eq(5) a:eq(0)").html('<em class="star"></em>证件失效日期');
			$("#contactPerson").text(contactPerson);
			$("#contactPhone").text(contactPhone);
			$("#restCuisineType").text(restCuisineType);
			$("#restAtmosphere").text(restAtmosphere);
			$("#averageComsumption").text(averageComsumption);
			$("#commercialCenter").text(commercialCenter);
			$("#loading").hide();
		}
	
	});
	//二维码生成
	$('#qrcode_i1').qrcode({
		render:"canvas", //设置渲染方式 canvas或table 
		width:120,     //设置宽度  
		height:120,    //设置高度   
		background:"#ffffff", //背景颜色  
		foreground:"#000000", //前景颜色
		text:JSON.stringify({"companyId":<%=SecurityUtils.getCurrentUserCompanyId()%>,"type":"COMPANY"}) //二维码内容 
   	});
})
</script>
</head>
<body>
	<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#"></a>
              <div class="btn_opera"> 
                   <input type="button" class="btn_editor" value="编辑" onClick="window.location.href='../findView/system.account.account-editor'" />
              </div>
          </h3>
          <div class="info_tab">
               <a href="../findView/system.account.account-view" class="default">基本信息</a>
               <a href="../findView/system.account.account-view-photo">证照图片</a>
          </div>
          <div class="info_box">
               <table class="info_mation" style="border-bottom:1px solid #dcdddd" id="table1">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>单位名称</td>
                       <td id="companyName"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>店招或单位简称</td>
                       <td id="companyNameAbbrev"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>区域</td>
                       <td id="region"><span id="province"></span><span id="city"></span><span id="district"></span><span id="street"></span></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>注册地址</td>
                       <td id="companyRegAddress"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>经营地址</td>
                       <td id="companyBizAddress"></td>
                   </tr>
                </table>
                <table class="info_mation" style="border-bottom:1px solid #dcdddd" id="table2"> 
                   <tr>
                       <td class="td_lf"><em class="star">*</em>联系人姓名</td>
                       <td id="contactPerson"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>手机</td>
                       <td id="contactPhone"></td>
                   </tr>
               </table>
               <table class="info_mation" id="table3"> 
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>餐馆菜系</td>
                       <td id="restCuisineType"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>餐馆氛围</td>
                       <td id="restAtmosphere"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>人均消费</td>
                       <td id="averageComsumption"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>所属商圈</td>
                       <td id="commercialCenter"></td>
                   </tr>
               </table>
               <div class="qrcode" style="top:30px; left:720px;" id="qrcode_i1"><!--<img src="../../images/qrcode_big.jpg" />--></div>
               
               <div class="clear"></div>
          </div>
     </div>
</div>    
</body>
</html>
<%-- <script src="../js/jquery.qrcode.min.js" type="text/javascript" charset="utf-8"></script> --%>