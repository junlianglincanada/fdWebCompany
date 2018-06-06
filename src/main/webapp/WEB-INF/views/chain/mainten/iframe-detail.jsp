<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
table.info_mation td{padding:5px 10px;}
table.info_mation td.td_lf{padding-left:0;}
</style>
<script type="text/javascript">
var id="<%=id %>";
function searchRegion(id,span){
	$.ajax({
		url:"../base/getAdminRegion/getRegionById/"+id,
		type:"get",
		success:function(result){
			$("#"+span).text(result.name);
		}
	});
}
$(function(){
	$("#loading").show();
	$.ajax({
		url:"../company/getCompanyInfo/"+id,
		type:"get",
		success:function(result){
			console.log(result.body);
			var companyName=isnull(result.body.companyName);
			var companyNameAbbrev=isnull(result.body.companyNameAbbrev);
			var companyRegAddress=isnull(result.body.companyRegAddress);
			var companyBizAddress=isnull(result.body.companyBizAddress);
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
			/* $(".process_title a").text(companyName);
			$(".info_tab a:eq(1)").attr("href","system.account.account-view-photo?companyName="+encodeURI(encodeURI(companyName))); */
			$("#companyName").text(companyName);
			$("#companyNameAbbrev").text(companyNameAbbrev);
			$("#companyRegAddress").text(companyRegAddress);
			$("#companyBizAddress").text(companyBizAddress);
			searchRegion(regionCountyId,"district");
			searchRegion(regionStreetId,"street");
			if(foodBusinessCert!=""){
				var certType="食品经营许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style=" width:252px;margin-left:10px; float:left;">'+foodBusinessCert+'</span><a style="width:100px;color:#1A73C3;margin-left:15px; float:left;">&nbsp;</a><span style="margin-left:10px; float:left;">'+foodBusinessCertExpDate+'</span></td></tr>');
				$("#table1 tr:eq(4)").after($tr);
			}
			if(cateringCert!=""){
				var certType="餐饮服务许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style=" width:252px;margin-left:10px; float:left;">'+cateringCert+'</span><a style="width:100px;color:#1A73C3;margin-left:15px; float:left;">&nbsp;</a><span style="margin-left:10px; float:left;">'+cateringCertExpDate+'</span></td></tr>');
				$("#table1 tr:eq(4)").after($tr);
			}
			if(foodProdCert!=""){
				var certType="食品生产许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style=" width:252px;margin-left:10px; float:left;">'+foodProdCert+'</span><a style="width:100px;color:#1A73C3;margin-left:15px; float:left;">&nbsp;</a><span style="margin-left:10px; float:left;">'+foodProdCertExpDate+'</span></td></tr>');
				$("#table1 tr:eq(4)").after($tr);
			}
			if(foodCircuCert!=""){
				var certType="食品流通许可证";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style=" width:252px;margin-left:10px; float:left;">'+foodCircuCert+'</span><a style="width:100px;color:#1A73C3;margin-left:15px; float:left;">&nbsp;</a><span style="margin-left:10px; float:left;">'+foodCircuCertExpDate+'</span></td></tr>');
				$("#table1 tr:eq(4)").after($tr);
			}
			if(bizCertNumber!=""){
				var certType="工商营业执照";
				var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style="  width:252px;float:left; margin-left:10px;">'+bizCertNumber+'</span><a style="width:100px;color:#1A73C3;margin-left:15px; float:left;">&nbsp;</a><span style="margin-left:10px; float:left;">'+bizCertExpDate+'</span></td></tr>');
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
	function iframe_wh(){//计算窗口宽度高度的函数
		var par_W = $(window.parent.document).width();
		var ifr_W = $(window.document).find(".ifr_box").width();
		var pos_W = (par_W - ifr_W)/2 ; 
		//alert(par_W);
		$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"480px",left:pos_W +"px",top:20 +"px"});
		$(window.parent.document).find(".popup_iframe").css({height:"432px"});
	    $(window).resize(function(){ //对浏览器窗口调整大小进行计数
			  var par_W = $(window.parent.document).width();
			  var ifr_W = $(window.document).find(".ifr_box").width();
			  var pos_W = (par_W - ifr_W)/2; 
			  //alert(par_W);
			  $(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"480px",left:pos_W +"px",top:20 +"px"});
		      $(window.parent.document).find(".popup_iframe").css({height:"432px"});
			  return false;
		});
	}
	iframe_wh(); 		   
});
</script>
</head>
<body>
<div class="ifr_box" style="width:800px;padding-top:20px;">
      <div class="info_tab">
           <a href="#" class="default">基本信息</a>
           <a href="chain.mainten.iframe-detail-photo?id=<%=id %>">证照图片</a>
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
                   <td id="region">上海市<span id="district"></span><span id="street"></span></td>
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
           <!-- <div class="qrcode" style="top:30px;"> -->
           <div class="clear"></div>
      </div>
</div>    
</body>
</html>