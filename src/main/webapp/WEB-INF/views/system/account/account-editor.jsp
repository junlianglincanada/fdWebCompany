<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" />
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	//日期选择
    $(".input_date").calendar();
	
	
  //select提示
  $(document).on("change",".select_cs",function(){
      var this_v = $(this).find("option:selected").val();
      var text_v = $(this).find("option:selected").text();
      if(0 != this_v){ //方法1 if()
          $(this).parent().parent().parent().find(".icon_alert").removeAttr("disabled");
          $(this).parent().parent().parent().find(".icon_alert").attr({"title":text_v+"填写提示","link":"system.account.iframe-select?id="+this_v,"rel":"popup"});
      }else{
          $(this).parent().parent().parent().find(".icon_alert").attr({"title":"证号填写提示","disabled":"disabled"});
          $(this).parent().parent().parent().find(".icon_alert").removeAttr("rel");
      }
   }); 
});
var companyName;
var companyId=null;
var ajaxFlag=true;
var rowNo=0;
var regByOfficialCert=0;
var editId;
function cartTypeOne(obj,certType,certNo){
	obj.parent().find(".text_ts").remove();
	if(certType!="请选择证件"&&certNo!=""){
	    	if (certType == "工商营业执照") {
			if (gszzBooth(certNo)==false) {
				console.log(obj.parent().find("i"));
				obj.parent().find("i").after("<span class='text_ts'>请输入正确的证件号码</span>");
				return false;
			}
		} else if (certType == "餐饮服务许可证") {
			if (cyfwBooth(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
		} else if (certType == "食品流通许可证") {
			if (spltBooth(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
		} else if (certType == "食品生产许可证") {
			if (spscBooth(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
		} else if (certType == "食品经营许可证") {
			if (spjyBooth(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
		} 
	}
  
}

function lincelsOne(obj,certType,certNo){
	if(certNo==""||certNo==null){
		return;
	}
	obj.parent().find(".text_ts").remove();
	console.log(obj,certType,certNo);
	var certTypeWeb="";
	if(certType!="请选择证件类型"&&certNo!=""){
	    	if (certType == "工商营业执照") {
			if (gszzBooth(certNo)==false) {
				obj.parent().find("i").after("<span class='text_ts'>请输入正确的证件号码</span>");
				return false;
			}
		} else if (certType == "餐饮服务许可证") {
			if (cyfwBooth(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
			certTypeWeb='cateringCert';
		} else if (certType == "食品流通许可证") {
			if (spltBooth(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
			certTypeWeb='foodCircuCert';
		} else if (certType == "食品生产许可证") {
			if (spscBooth(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
			certTypeWeb='foodProdCert';
		} else if (certType == "食品经营许可证") {
			if (spjyBooth(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
			certTypeWeb="foodBusinessCert";
		}
	    if(certTypeWeb!=""){
	    	var param1={};
	    	param1.certNo=certNo;
	    	param1.certType=certTypeWeb;
	    	$(":button").attr("disabled",true);
	    	$.ajax({
	    		url:"../company/isCertExist",
	    		type:"post",
	    		data:JSON.stringify(param1),
	    		dataType:"json",
	    		async: false,
	    		headers: { 
	    	        'Accept': 'application/json',
	    	        'Content-Type': 'application/json' 
	    	    },
	    	    success:function(result){
	    	    	$(":button").attr("disabled",false);
	    	    	if(result.body==true){
	    				obj.parent().find("i").after('<span class="text_ts">该证件号码已经被注册</span>');
	    				return false;
	    	    	}
	    	    }
	    	});
	    }	
	}
}


function previewImg(){
	var certTyp=$("#table1 tr").find("#certType").find("option:selected").text();
	if(certTyp=="工商营业执照"){
		$("#table1 tr").find("#certNo").attr("placeholder","15位工商注册号或18位统一信用代码");
	}else if(certTyp=="食品经营许可证"){
		$("#table1 tr").find("#certNo").attr("placeholder","JY加14位数字或字母的证件号码");
	}else if(certTyp=="食品流通许可证"){
		$("#table1 tr").find("#certNo").attr("placeholder","SP加16位数字或字母的证件号码");
	}else if(certTyp=="食品生产许可证"){
		$("#table1 tr").find("#certNo").attr("placeholder","QS加12位数字字母或SC加14位数字字母的证件号码");
	}else if(certTyp=="餐饮服务许可证"){
		$("#table1 tr").find("#certNo").attr("placeholder","如：沪餐证字+16位数字或字母");
	}else{
		$("#table1 tr").find("#certNo").attr("placeholder","");
		certTyp = null;
	}
}


function checkSpecificKeyOnlythis(keyCode) {
	var patrn = /[`~!#$%^&+<>?{}\;[\]]/im;
	var flg = false;
	flg = patrn.test(keyCode);
	if (flg) {
		return false;
	}
	return true;
}

//autocomplete查询列表
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
		url: "../register/getCompanyListByName",
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
				companyId=data.companyId+"";
				searchById();
       		});
		},
		error: function(data) {
			alert("加载失败，请重试！");
		}
	});
}
//根据autocomplete获取的id显示页面数据
function searchById(){
	if(companyId!=null&&companyId!=""){
		$("#loading").show();
		var params={'companyId':companyId};
		$.ajax({
			url: "../register/getCompanyById",
			type:"post",
			headers: { 
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			data:JSON.stringify(params),
			success: function(result) {
				console.log(result);
				view(result);
				$("#loading").hide();
			},
			error: function(data) {
				alert("加载失败，请重试！");
				$("#loading").hide();
			}
		})
	}
}
//页面数据显示
function view(result){
	var companyName=result.body.companyName;
	var companyNameAbbrev=result.body.companyNameAbbrev;
	var companyRegAddress=result.body.companyRegAddress;
	var companyBizAddress=result.body.companyBizAddress;
	var regionProvinceId=result.body.regionProvinceId;
	var regionCityId=result.body.regionCityId;
	var regionCountyId=result.body.regionCountyId;
	var regionStreetId=result.body.regionStreetId;
	var bizCertNum=result.body.bizCertNum;
	var foodCircuCert=result.body.foodCircuCert;
	var foodProdCert=result.body.foodProdCert;
	var cateringCert=result.body.cateringCert;
	var foodBusinessCert=result.body.foodBusinessCert;
	var bizCertExpDate=isnull(result.body.bizCertExpDate);
	var cateringCertExpDate=isnull(result.body.cateringCertExpDate);
	var foodProdCertExpDate=isnull(result.body.foodProdCertExpDate);
	var foodCircuCertExpDate=isnull(result.body.foodCircuCertExpDate);
	var foodBusinessCertExpDate=isnull(result.body.foodBusinessCertExpDate);
	$(".process_title a").text(companyName);
	$("#companyName").val(companyName);
	$("#companyNameAbbrev").val(companyNameAbbrev);
	$("#companyRegAddress").val(companyRegAddress);
	$("#companyBizAddress").val(companyBizAddress);
	listRegions(regionProvinceId,regionCityId,regionCountyId,regionStreetId);
	$("#table1 tr:gt(4)").remove();
	var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><div class="select_s" style="width:125px; float:left;"><div class="select_is" style="width:125px;"><select class="select_cs" id="certType"  onchange="previewImg()" style="width:125px; background-position:-12px -122px;"><option value="全部">请选择证件类型</option><option value="工商">工商营业执照</option><option value="流通">食品流通许可证</option><option value="生产">食品生产许可证</option><option value="餐饮">餐饮服务许可证</option><option value="经营">食品经营许可证</option></select></div></div><input type="text" id="certNo" class="input_code" style="width: 152px; float:left; margin-left:10px;" value="" maxlength="30"/><i class="i_type i_add"></i></td></tr>');		
	$("#table1").append($tr);
	rowNo=0;
	select(0,bizCertNum,bizCertExpDate);
	select(1,foodCircuCert,foodCircuCertExpDate);
	select(2,foodProdCert,foodProdCertExpDate);
	select(3,cateringCert,cateringCertExpDate);
	select(4,foodBusinessCert,foodBusinessCertExpDate);
	if($("#table1 select").length==9){
		$("#table1 tr:last").find("i").addClass("i_del").removeClass("i_add").end();
	}
	if(rowNo==5){
		$("#table1 tr:last").remove();
	}
	$("option").attr("disabled",false);
	$("#table1 tr:gt(4) select option:selected").each(function(){
		var text=$(this).text();
		if(text=="工商营业执照"){
			$(this).parents("td").find("input:text").attr("maxlength","29");
		}else if(text=="食品经营许可证"){
			$(this).parents("td").find("input:text").attr("maxlength","27");
		}else{
			$(this).parents("td").find("input:text").attr("maxlength","30");
		}
		$("#table1").find("option:contains("+text+")").attr("disabled","disabled");
	})
	$("#table1 tr:eq(5)").find("td").eq(0).text("");
	var $em= $('<span><em class="star">*</em>证件类型</span>');
	$("#table1 tr:eq(5)").find("td").eq(0).append($em);
	$('.input_date').calendar();
}
//地区下拉框数据
function listRegions(province,city,county,street){
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
				url:"../base/getAdminRegion/getRegionById/"+province,
				type:"get",
				success:function(result){
					var district=result.name;
					$("#provinces option:contains("+district+")").attr("selected","selected");
				}
			});
		}
	});
	$.ajax({
		url:"../base/getAdminRegion/"+province,
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $cities=$("<option>"+result[i].name+"</option>");
				$cities.data("cities",result[i].id);
				$("#cities").append($cities);
			}
			$.ajax({
				url:"../base/getAdminRegion/getRegionById/"+city,
				type:"get",
				success:function(result){
					var district=result.name;
					$("#cities option:contains("+district+")").attr("selected","selected");
				}
			});
		}
	});
	$.ajax({
		url:"../base/getAdminRegion/"+city,
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $districts=$("<option>"+result[i].name+"</option>");
				$districts.data("districts",result[i].id);
				$("#districts").append($districts);
			}
			$.ajax({
				url:"../base/getAdminRegion/getRegionById/"+county,
				type:"get",
				success:function(result){
					var district=result.name;
					$("#districts option:contains("+district+")").attr("selected","selected");
				}
			});
		}
	});
	$.ajax({
		url:"../base/getAdminRegion/"+county,
		type:"get",
		success:function(result){
			for(var i=0;i<result.length;i++){
				var $streets=$("<option>"+result[i].name+"</option>");
				$streets.data("streets",result[i].id);
				$("#streets").append($streets);
			}
			$.ajax({
				url:"../base/getAdminRegion/getRegionById/"+street,
				type:"get",
				success:function(result){
					var street=result.name;
					$("#streets option:contains("+street+")").attr("selected","selected");
				}
			});
		}
	});
}
//商圈查询
function searchCenter(parentId,commercialCenter){
	$.ajax({
		url:"../system/dataDicMgr/queryDataDictDetailByParentId/"+parentId,
		type:"post",
		data:{"name":null},
		dataType:"json",
		headers: { 
			'Accept': 'application/json',
			'Content-Type': 'application/json',
			'X-CSRF-TOKEN': '${_csrf.token}'
		},
		success:function(result){
			var centers=result.body;
			if(centers!=null){
				for(var i=0;i<centers.length;i++){
					var $center=$("<option value="+centers[i].id+">"+centers[i].value+"</option>");
					$("#commercialCenter").append($center);
				}
				$("#commercialCenter").val(commercialCenter);
			}
		}
	});
}
//证件类型下拉框选择和号码输入框显示
function select(rowNum,val,date){
	$('.input_date').calendar();
	if(!nullFlag(val)){
		var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><div class="select_s" style="width:125px; float:left;"><div class="select_is" style="width:125px;"><select class="select_cs" id="certType"  onchange="previewImg()" style="width:125px; background-position:-12px -122px; "><option>请选择证件类型</option><option>工商营业执照</option><option>食品流通许可证</option><option>食品生产许可证</option><option>餐饮服务许可证</option><option>食品经营许可证</option></select></div></div><input type="text" class="input_code isReceiverCert" style="width:293px; float:left;margin-left:10px;" value="" maxlength="30"/><a style="width:115px;color:#1A73C3; float:left;">&nbsp;</a><input type="text" class="input_date" style="width:93px; float:left;margin-left:10px;" value="" readonly="readonly"/><i class="i_type i_del"></i></td></tr>');
		$tr.find("option:eq("+(rowNum+1)+")").attr("selected",true);
		$tr.find("input").val(val);
		$tr.find(".input_date").val(date);
		if(rowNum==0){
			$tr.find("input:text").attr("maxlength","29");
		}else if(rowNum==4){
			$tr.find("input:text").attr("maxlength","27");
		}
		$("#table1 tr:last").before($tr);
		rowNo++;
		$('.input_date').calendar();
	}
}
$(function(){
	/*--日历-生产--*/				   
	$('.input_date').calendar();
	
	//特殊字符验证
	$("body").on("blur","input[type='text']",function(){
 		$(this).siblings(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKeyOnlythis(inputValue)==false){
	    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    }
	});
	$("#contactPhone").blur(function(){
		var contactPhone=$("#contactPhone").val().trim();
		$(this).siblings(".text_ts").remove();
		if(!(contactPhone==""||contactPhone==null||isMobilephone(contactPhone))){
			$("#contactPhone").after('<span class="text_ts">请输入正确手机号码 </span>');
		}
	});
	//页面加载查询数据
	$("#loading").show();
	$.ajax({
		url:"../company/getCompanyInfo",
		type:"get",
		async:false,
		success:function(result){
			console.log(result.body);
			id=result.body.companyId;
			var companyName=isnull(result.body.companyName);
			var companyNameAbbrev=isnull(result.body.companyNameAbbrev);
			var companyRegAddress=isnull(result.body.companyRegAddress);
			var companyBizAddress=isnull(result.body.companyBizAddress);
			var regionProvinceId=isnull(result.body.regionProvinceId);
			var regionCityId=isnull(result.body.regionCityId);
			var regionCountyId=isnull(result.body.regionCountyId);
			var regionStreetId=isnull(result.body.regionStreetId);
			var cateringCert=isnull(result.body.cateringCert);
			var bizCertExpDate=isnull(result.body.bizCertExpDate);
			var cateringCertExpDate=isnull(result.body.cateringCertExpDate);
			var foodProdCertExpDate=isnull(result.body.foodProdCertExpDate);
			var foodCircuCertExpDate=isnull(result.body.foodCircuCertExpDate);
			var foodBusinessCert=isnull(result.body.foodBusinessCert);
			var foodBusinessCertExpDate=isnull(result.body.foodBusinessCertExpDate);
			var foodProdCert=isnull(result.body.foodProdCert);
			var foodCircuCert=isnull(result.body.foodCircuCert);
			var bizCertNumber=isnull(result.body.bizCertNumber);
			var foodSaftyRating=isnull(result.body.foodSaftyRating);
			var restCuisineType=isnull(result.body.restCuisineType);
			var restAtmosphere=isnull(result.body.restAtmosphere);
			var averageComsumption=isnull(result.body.averageComsumption);
			var commercialCenter=isnull(result.body.commercialCenter)
			var contactPerson=isnull(result.body.contactPerson);
			var contactPhone=isnull(result.body.contactPhone);
			regByOfficialCert=result.body.regByOfficialCert;
			$(".process_title a:eq(0)").text(companyName);
			$(".info_tab a:eq(1)").attr("href","system.account.account-view-photo?companyName="+encodeURI(encodeURI(companyName)));
			$("#companyName").val(companyName);
			$("#companyNameAbbrev").val(companyNameAbbrev);
			$("#companyRegAddress").val(companyRegAddress);
			$("#companyBizAddress").val(companyBizAddress);
			//if(regionProvinceId!=-1&&regionProvinceId!=""&&regionCityId!=-1&&regionCityId!=""&&regionCountyId!=-1&&regionCountyId!=""&&regionStreetId!=-1&&regionStreetId!=""){
				listRegions(regionProvinceId,regionCityId,regionCountyId,regionStreetId);
			//}
			select(0,bizCertNumber,bizCertExpDate);
			select(1,foodCircuCert,foodCircuCertExpDate);
			select(2,foodProdCert,foodProdCertExpDate);
			select(3,cateringCert,cateringCertExpDate);
			select(4,foodBusinessCert,foodBusinessCertExpDate);
			if($("#table1 select").length==9){
				$("#table1 tr:last").find("i").addClass("i_del").removeClass("i_add").end();
			}
			if(rowNo==5){
				$("#table1 tr:last").remove();
			}
			$("option").attr("disabled",false);
			$("#table1 tr:gt(4) select option:selected").each(function(){
				var text=$(this).text();
				if(text=="工商营业执照"){
					$(this).parents("td").find("input:text").attr("maxlength","29");
				}else{
					$(this).parents("td").find("input:text").attr("maxlength","30");
				}
				$("#table1").find("option:contains("+text+")").attr("disabled","disabled");
			})
			$("#table1 tr:eq(5)").find("td").eq(0).text("");
			var $em= $('<span><em class="star">*</em>证件类型</span>');
			$("#table1 tr:eq(5)").find("td").eq(0).append($em);
			$("#table1 tr:eq(5)").find("a").eq(0).text("");
			var $em= $('<span><em class="star"></em>证件失效日期</span>');
			$("#table1 tr:eq(5)").find("a").eq(0).append($em);
			var cuisine=restCuisineType.split(",");
			for(var i=0;i<cuisine.length;i++){
				$("#restCuisineType").find("input:checkbox[value="+cuisine[i]+"]").attr("checked",true);
			}
			var atmosphere=restAtmosphere.split(",");
			for(var i=0;i<atmosphere.length;i++){
				$("#restAtmosphere").find("input:checkbox[value="+atmosphere[i]+"]").attr("checked",true);
			}
			$("#averageComsumption").val(averageComsumption);
			//加载商圈
			var parentId=-1;
			$.ajax({
				url:"../system/dataDicMgr/queryDataDictDetail/2",
				type:"post",
				data:{"name":null},
				dataType:"json",
				headers: { 
					'Accept': 'application/json',
					'Content-Type': 'application/json',
					'X-CSRF-TOKEN': '${_csrf.token}'
				},
				success:function(result){
					var centers=result.body;
					for(var i=0;i<centers.length;i++){
						if(centers[i].parentId==null||centers[i].parentId==""){
							var $center=$("<option value="+centers[i].id+">"+centers[i].value+"</option>");
							$("#commercialCenterDistrict").append($center);
						}
						if(centers[i].id==commercialCenter){
							parentId=centers[i].parentId;
						}
					}
					$("#commercialCenterDistrict").val(parentId);
					searchCenter(parentId,commercialCenter);
				}
			});
			$("#contactPerson").val(contactPerson);
			$("#contactPhone").val(contactPhone);
			$("#loading").hide();
		}
	});
	//2016.4.28新增 通过企业库验证，匹配到的单位名称、地址、许可证号 在单位基本信息中不能修改。
	console.log(regByOfficialCert);
	if(regByOfficialCert!=0&&regByOfficialCert!=null){
		$("#companyName").attr("disabled",true);
		if(regByOfficialCert<10){
			$("#companyRegAddress").attr("disabled",true);
			$("#region").find("select").attr("disabled",true);
		}
		if(regByOfficialCert==5||regByOfficialCert==15){
			$("#table1 tr:gt(4)").each(function(){
				var certType=$(this).find("option:selected").text();
				if(certType=="工商营业执照"){
					$(this).find("select").attr("disabled",true);
					$(this).find("input").attr("disabled",true);
					$(this).find("i").removeClass("i_del").end();
				}
			})
		}
		if(regByOfficialCert==1||regByOfficialCert==11){
			$("#table1 tr:gt(4)").each(function(){
				var certType=$(this).find("option:selected").text();
				if(certType=="餐饮服务许可证"){
					$(this).find("select").attr("disabled",true);
					$(this).find("input").attr("disabled",true);
					$(this).find("i").removeClass("i_del").end();
				}
			})
		}
		if(regByOfficialCert==4||regByOfficialCert==14){
			$("#table1 tr:gt(4)").each(function(){
				var certType=$(this).find("option:selected").text();
				if(certType=="食品流通许可证"){
					$(this).find("select").attr("disabled",true);
					$(this).find("input").attr("disabled",true);
					$(this).find("i").removeClass("i_del").end();
				}
			})
		}
		if(regByOfficialCert==3||regByOfficialCert==13){
			$("#table1 tr:gt(4)").each(function(){
				var certType=$(this).find("option:selected").text();
				if(certType=="食品生产许可证"){
					$(this).find("select").attr("disabled",true);
					$(this).find("input").attr("disabled",true);
					$(this).find("i").removeClass("i_del").end();
				}
			})
		}
		if(regByOfficialCert==2||regByOfficialCert==12){
			$("#table1 tr:gt(4)").each(function(){
				var certType=$(this).find("option:selected").text();
				if(certType=="食品经营许可证"){
					$(this).find("select").attr("disabled",true);
					$(this).find("input").attr("disabled",true);
					$(this).find("i").removeClass("i_del").end();
				}
			})
		}
	}
	//autocomplete 查询
	//$("#companyName").focus(searchList);
	//加载省
	$("#provinces").children().eq(0).data("provinces","");
	$("#cities").children().eq(0).data("cities","");
	$("#districts").children().eq(0).data("districts","");
    $("#streets").children().eq(0).data("street","");
	/* $.ajax({
		url:"../base/getAdminRegion/getByLevel/-1",
		type:"get",
		success:function(result){
			$("#provinces option:gt(0)").remove();
			for(var i=0;i<result.length;i++){
				var $provinces=$("<option>"+result[i].name+"</option>");
				$provinces.data("provinces",result[i].id);
				$("#provinces").append($provinces);
			}
		}
	}); */
	//省变更时加载市
	$("#provinces").change(function(){
		var province=$("#provinces option:selected").data("provinces");
		$("#cities option:gt(0)").remove();
		$("#districts option:gt(0)").remove();
		$("#streets option:gt(0)").remove();
		$.ajax({
			url:"../base/getAdminRegion/"+province,
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
	//市变更时加载区
	$("#cities").change(function(){
		var city=$("#cities option:selected").data("cities");
		$("#districts option:gt(0)").remove();
		$("#streets option:gt(0)").remove();
		$.ajax({
			url:"../base/getAdminRegion/"+city,
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
	//区变更时加载街道
	$("#districts").change(function(){
		var disctrict=$("#districts option:selected").data("districts");
		$("#streets option:gt(0)").remove();
		$.ajax({
			url:"../base/getAdminRegion/"+disctrict,
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
	//商圈所在区变更时加载商圈
	$("#commercialCenterDistrict").change(function(){
		var disctrict=$("#commercialCenterDistrict option:selected").val();
		$("#commercialCenter option:gt(0)").remove();
		searchCenter(disctrict,"");
	});
	//点击重置按钮重置
	$("#reset").click(function(){
		$(".text_ts").remove();
		$("input:text").val("");
		$("input:checkbox").attr("checked",false);
		$("select").val("");
		$("#table1 tr:gt(5)").remove();
		$("option").attr("disabled",false);
		$("#table1 tr:eq(5) select option:eq(0)").attr("selected","selected");
		$("#table1").find("i:eq(0)").addClass("i_add").removeClass("i_del").end();
	})
	//点击保存按钮执行修改
	$("#saveFormSubmit").click(function(){
		ajaxFlag=true;
		$("body .text_ts").each(function(){
		    var spanText=$(this).text();
		    if(spanText=='该证件号码已经被注册'){
		    	ajaxFlag=false;
		    	return false;
		    }
		});
		if(ajaxFlag==false){
			return;
		}
		$("#loading").show();
		var params={};
		$(".text_ts").remove();
		ajaxFlag=true;
		//非空判断
		$(".necessary input:text").not("tr:eq(2)").not("tr:gt(5)").each(function(){
			var input=$(this).val().trim();
			if(input==null||input==""){
				$(this).after('<span class="text_ts">必要信息不能为空 </span>');
				ajaxFlag=false;
			}
		})
		//特殊字符判断
		$("input:text").each(function(i){
			var input=$(this).val().trim();
			if(checkSpecificKeyOnlythis(input)==false){
				$(this).after('<span class="text_ts">请勿输入特殊字符 </span>');
				ajaxFlag=false;
			}
		});
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
		//电话号码号码验证
		var contactPhone=$("#contactPhone").val().trim();
		if(!(contactPhone==""||contactPhone==null||isMobilephone(contactPhone))){
			$("#contactPhone").after('<span class="text_ts">请输入正确手机号码</span>');
			ajaxFlag=false;
		}
		//证件类型判断
		$("#table1 tr:gt(4)").each(function(){
			var certType=$(this).find("option:selected").text();
			var certNo=$(this).find("input").val();
			var certDate=$(this).find(".input_date").val();
			if($("#table1 select").length==5){
				if(certType=="请选择证件类型"){
					$(this).find("i").after('<span class="text_ts">必要信息不能为空</span>');
					ajaxFlag=false;
				}
			}
			if(certType=="食品经营许可证"){
				if(certNo==""||certNo==null){
					$(this).find("i").after('<span class="text_ts">请输入证件号码</span>');
					ajaxFlag=false;
				}else if(!spjyBooth(certNo)){
					$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
					ajaxFlag=false;
				}
				
				params.foodBusinessCert=certNo;
				params.foodBusinessCertExpDate=certDate;
			}
			if(certType=="餐饮服务许可证"){
				if(certNo==""||certNo==null){
					$(this).find("i").after('<span class="text_ts">请输入证件号码</span>');
					ajaxFlag=false;
				}else if(!cyfwBooth(certNo)){
					$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
					ajaxFlag=false;
				}
				params.cateringCert=certNo;
				params.cateringCertExpDate=certDate;
			}
			if(certType=="食品生产许可证"){
				if(certNo==""||certNo==null){
					$(this).find("i").after('<span class="text_ts">请输入证件号码</span>');
					ajaxFlag=false;
				}else if(!spscBooth(certNo)){
					$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
					ajaxFlag=false;
				}
				params.foodProdCert=certNo;
				params.foodProdCertExpDate=certDate;
			}
			if(certType=="食品流通许可证"){
				if(certNo==""||certNo==null){
					$(this).find("i").after('<span class="text_ts">请输入证件号码</span>');
					ajaxFlag=false;
				}else if(!spltBooth(certNo)){
					$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
					ajaxFlag=false;
				}
				params.foodCircuCert=certNo;
				params.foodCircuCertExpDate=certDate;
			}
			if(certType=="工商营业执照"){
				if(certNo==""||certNo==null){
					$(this).find("i").after('<span class="text_ts">请输入证件号码</span>');
					ajaxFlag=false;
				}else if(!gszzBooth(certNo)){
					$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
					ajaxFlag=false;
				}
				params.bizCertNumber=certNo;
				params.bizCertExpDate=certDate;
			}
		})
		//判断验证正确执行修改请求
		if(ajaxFlag){
			var companyName=$("#companyName").val().trim();
			var companyNameAbbrev=$("#companyNameAbbrev").val().trim();
			var companyRegAddress=$("#companyRegAddress").val().trim();
			var companyBizAddress=$("#companyBizAddress").val().trim();
			var regionProvinceId=$("#provinces").find("option:selected").data("provinces");
			var regionCityId=$("#cities").find("option:selected").data("cities");
			var regionCountyId=$("#districts").find("option:selected").data("districts");
			var regionStreetId=$("#streets").find("option:selected").data("streets");
			
			var restCuisineType="";
			$("#restCuisineType input:checkbox:checked").each(function(){
				restCuisineType+=$(this).val()+",";
			});
			var restAtmosphere="";
			$("#restAtmosphere input:checkbox:checked").each(function(){
				restAtmosphere+=$(this).val()+",";
			});
			var averageComsumption=$("#averageComsumption option:selected").val();
			var commercialCenter=$("#commercialCenter option:selected").val();
			var contactPerson=$("#contactPerson").val().trim();
			var contactPhone=$("#contactPhone").val().trim();
			params.companyId=id;
			params.companyName=companyName;
			params.companyNameAbbrev=companyNameAbbrev;
			params.companyRegAddress=companyRegAddress;
			params.companyBizAddress=companyBizAddress;
			params.regionProvinceId=regionProvinceId;
			params.regionCityId=regionCityId;
			params.regionCountyId=regionCountyId;
			params.regionStreetId=regionStreetId;
			params.restCuisineType=restCuisineType;
			params.restAtmosphere=restAtmosphere;
			params.averageComsumption=averageComsumption;
			params.commercialCenter=commercialCenter;
			params.contactPerson=contactPerson;
			params.contactPhone=contactPhone;
			console.log(params);
			$.ajax({
				url: "../company/updateCompanyInfo",
				type:"post",
				headers: { 
					'Accept': 'application/json',
					'Content-Type': 'application/json',
					'X-CSRF-TOKEN': '${_csrf.token}'
				},
				dataType:'json',
				data:JSON.stringify({"companyInfo":JSON.stringify(params)}),
				success: function(result) {
					if(result.status==0){
						window.location.href="system.account.account-view?companyName="+encodeURI(encodeURI(companyName));
					}else if(result.message=="证件号码已存在"){
			    		var certMap=result.body;
			    		var webCert="";
			    		if(certMap.cateringCert==true){
			    			webCert +="餐饮服务许可证"+"、";
			    		}
			    		if(certMap.foodCircuCert==true){
			    			webCert +="食品流通许可证"+"、";
			    		}
			    		if(certMap.foodProdCert==true){
			    			webCert +="食品生产许可证"+"、";
			    		}
			    		if(certMap.foodBusinessCert==true){
			    			webCert +="食品经营许可证"+"、";
			    		}
			    		alert(webCert+"已被注册");
			    	}else{
						alert(result.message);
					}
				},
				error: function(data) {
					alert("加载失败，请重试！");
				}
			});
		}
		$("#loading").hide();
	});
	//点击复制输入框
    $("#table1").on("click","i.i_add",function(){
    	if($(this).next(".text_ts").text()=="该证件号码已经被注册"){
    		return;
    	}
    	$(".text_ts").remove();
    	var certType=$(this).parent().find("option:selected").text();
    	var certNo=$(this).parent().find("input").val().trim();
    	if(certType=="请选择证件类型"||certNo==""||certNo==null){
    		$(this).after('<span class="text_ts">证件类型不能为空!</span>');
    		return;
    	}
    	if(checkSpecificKeyOnlythis(certNo)==false){
	    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    	return;
	    }
		var caertStatus=cartTypeOne($(this),certType,certNo);
		if(caertStatus==false){
			return;
		}
		var  $tr = $('<tr><td class="td_lf">&nbsp;</td><td><div class="select_s" style="width:125px;float:left;"><div class="select_is" style="width:125px;"><select id="certType"  onchange="previewImg()" class="select_cs" style="width:125px;background-position:-12px -122px;*+width:125px"><option value="0">请选择证件类型</option><option value="gs">工商营业执照</option><option value="jy">食品经营许可证</option><option value="sc">食品生产许可证</option><option value="lt">食品流通许可证</option><option value="cy">餐饮服务许可证</option></select></select></div></div><input type="text" class="input_code isReceiverCert" style="width:293px;float:left;margin-left:10px;" value="" maxlength="30"/><input class="icon_alert" rel="popup" link="system.account.iframe-select?id=img_ts" title="填写提示" value="提示" disabled="disabled" /><span class="blue" style="font-weight:400;width:86px;display:inline-block;float:left;">&nbsp;</span><input type="text" class="input_date" placeholder="" maxlength="30" value="" style="width:93px;float:left;margin-left: 10px;" readonly="readonly"/><i class="i_type i_add"></i></td></tr>'); 
		  //add
    	$("#table1 tr:gt(4) select option:selected").each(function(){
			var text=$(this).text();
			if(text=="工商营业执照"){
				$(this).parents("td").find("input:text").attr("maxlength","29");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","15位工商注册号或18位同一信用代码");
			}else if(text=="食品经营许可证"){
				$(this).parents("td").find("input:text").attr("maxlength","27");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","JY加14位数字或字母的证件号码");
			}else{
				$(this).parents("td").find("input:text").attr("maxlength","30");
				$(this).parents("td").find("input:text").attr("placeholder","");
			}
			$(this).parent().find("option:eq(0)").attr("disabled","disabled");
			$tr.find("option:contains("+text+")").attr("disabled","disabled");
		});
		$(this).addClass("i_del").removeClass("i_add").end();
		var n=$("#table1 select").length;
		if(n==8){
			$tr.find("i").addClass("i_del").removeClass("i_add").end();
		}
		$("#table1").append($tr);
		$('.input_date').calendar();
		return false;
	});
	//点击删除输入框
    $("i.i_del").live("click",function(){
    	$(this).parent().parent().remove();
		var n=$("#table1 select").length;
		if(n<9){
			$("#table1 tr:last").find("i").addClass("i_add").removeClass("i_del").end();
		}
		$("#table1 tr:eq(5)").find("td").eq(0).text("");
		var $em= $('<span><em class="star">*</em>证件类型</span>');
		$("#table1 tr:eq(5)").find("td").eq(0).append($em);
		$("#table1 tr:eq(5)").find("a").eq(0).text("");
		// var $em2= $('<span><em class="star"></em>证件失效日期</span>');
		$("#table1 tr:eq(5) td:eq(1)").find("span").eq(0).text("证件失效日期");
		//$("#table1 tr:eq(5)").addClass("necessary");
		$("option").attr("disabled",false);
		$("#table1 tr:gt(4) select option:selected").each(function(){
    		var text=$(this).text();
    		if(text=="工商营业执照"){
				$(this).parents("td").find("input:text").attr("maxlength","29");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","15位工商注册号或18位同一信用代码");
			}else if(text=="食品经营许可证"){
				$(this).parents("td").find("input:text").attr("maxlength","27");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","JY加14位数字或字母的证件号码");
			}else{
				$(this).parents("td").find("input:text").attr("maxlength","30");
				$(this).parents("td").find("input:text").attr("placeholder","");
			}
    		$(this).parent().find("option:eq(0)").attr("disabled","disabled");
    		$("#table1 tr:gt(4)").find("option:contains("+text+")").attr("disabled","disabled");
    	});
		$("#table1 tr:last").find("option:eq(0)").attr("disabled",false);
		return false;
    });
	//已输入证件无法选择验证
    $("#table1").on("change","select",function(){
    	$("option").attr("disabled",false);
		var certType=$(this).parent().parent().parent().find(".isReceiverCert");
		var certNo=certType.val().trim();
    	$("#table1 tr:gt(4) select option:selected").each(function(){
    		var text=$(this).text();
    		if(text=="工商营业执照"){
				$(this).parents("td").find("input:text").attr("maxlength","29");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","15位工商注册号或18位统一信用代码");
				lincelsOne(certType,text,certNo);
			}else if(text=="食品经营许可证"){
				$(this).parents("td").find("input:text").attr("maxlength","27");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","JY加14位数字或字母的证件号码");
				lincelsOne(certType,text,certNo);
			}else if(text=="食品流通许可证"){
				$(this).parents("td").find("input:text").attr("maxlength","29");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","SP加16位数字或字母的证件号码");
				lincelsOne(certType,text,certNo);
			}else if(text=="食品生产许可证"){
				$(this).parents("td").find("input:text").attr("maxlength","27");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","QS加12位数字字母或SC加14位数字字母的证件号码");
				lincelsOne(certType,text,certNo);
			}else if(text=="餐饮服务许可证"){
				$(this).parents("td").find("input:text").attr("maxlength","30");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","如：沪餐证字+16位数字或字母");
				lincelsOne(certType,text,certNo);
			}else{
				$(this).parents("td").find(".text_ts").remove();
				$(this).parents("td").find("input:text").attr("maxlength","30");
				$(this).parents("td").find("input:text").attr("placeholder","");
			}
    		$(this).parent().find("option:eq(0)").attr("disabled","disabled");
    		$("#table1 tr:gt(4)").find("option:contains("+text+")").attr("disabled","disabled");
    	});
    	$("#table1 tr:last").find("option:eq(0)").attr("disabled",false);
    });
	
	$("body").on("blur",".isReceiverCert",function(){
    	var certType=$(this).parent().find("option:selected").text();
    	var certNo=$(this).val().trim();
    	if(certType!="请选择证件类型"){
    		lincelsOne($(this),certType,certNo);
    	}
	});
})
</script>
</head>
<body>
	<div class="main_box">
		<div class="main_con">
			<h3 class="process_title"><span>当前位置: </span><a href="system.account.account-view"></a> > <a href="#">编辑</a></h3>
			<div class="info_tab">
				<a href="#" class="default">基本信息</a>
				<a href="../findView/system.account.account-view-photo">证照图片</a>
			</div>
			<div class="per_box">
				<table class="info_mation" style="border-bottom:1px solid #dcdddd;" id="table1">
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>单位名称</td>
						<td><input
							type="text" class="input_code" style="width: 346px;" id="companyName" maxlength="30"
							name="name" /><span id="companyId" style="display:none"></span></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>店招或单位简称</td>
						<td><input 
							type="text" class="input_code" maxlength="20"
							style="width: 346px;" id="companyNameAbbrev"/></td>
					</tr>
					<tr class="necessary" id="region">
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
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>注册地址</td>
						<td><input
							type="text" class="input_code" style="width: 346px;" maxlength="50"
							id="companyRegAddress"/></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>经营地址</td>
						<td><input
							type="text" class="input_code" style="width: 346px;" maxlength="50"
							id="companyBizAddress"/></td>
					</tr>
					<tr>
						<td class="td_lf">&nbsp;</td>
						<td>
							<div class="select_s" style="width: 125px; float: left;">
								<div class="select_is" style="width: 125px;">
									<select class="select_cs" id="certType" onchange="previewImg()"
										style="width: 125px; background-position: -12px -122px;">
										<option value="0">请选择证件类型</option>
										<option value="gs">工商营业执照</option>
										<option value="lt">食品流通许可证</option>
						                <option value="sc">食品生产许可证</option>
						                <option value="cy">餐饮服务许可证</option>
						                <option value="jy ">食品经营许可证</option>
									</select>
								</div>
							</div>
							<input type="text" class="input_code isReceiverCert" style="width:293px;float:left;margin-left:10px;" maxlength="30"id="certNo"/>
                           <input class="icon_alert" rel="popup" link="system.account.iframe-select?id=img_ts" title="证号填写提示" value="" disabled="disabled" />
                           <span class="blue" style="font-weight:400;width:86px;display:inline-block;float:left;">&nbsp;</span>
                           <input type="text" class="input_date" value="" readonly="readonly" style="width:93px;float:left;;margin-left:10px;"/>
							<!--  <input type="text" class="input_code isReceiverCert" style="width: 152px; float:left; margin-left:10px;" maxlength="30"id="certNo"/>
							<a style="width:100px;color:#1A73C3; float:left;">&nbsp;</a>
                           <input type="text" class="input_date" style="width:152px; float:left;margin-left:10px;" value="" readonly="readonly" />-->
							<i class="i_type i_add"></i></td>
					</tr>
				</table>
				<table class="info_mation" style="border-bottom:1px solid #dcdddd;">
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>联系人</td>
						<td><input
							type="text" class="input_code" style="width: 166px;" maxlength="10"
							id="contactPerson"/></td>
					</tr>
					<tr class="necessary">
						<td class="td_lf"><em class="star">*</em>手机</td>
						<td><input
						type="text" class="input_code" style="width: 166px;" maxlength="20"
						id="contactPhone"/></td>
					</tr>
				</table>
				<table class="info_mation" style="border-bottom:1px solid #dcdddd;">
					<tr>
						<td class="td_lf"><em class="star">&nbsp;</em>餐馆菜系</td>
						<td id="restCuisineType">
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="4041"/>自助餐</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5001"/>东南亚菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5002"/>韩国料理</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5003"/>日本</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5004"/>小吃快餐</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5006"/>东北菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5007"/>贵州菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5008"/>台湾菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5009"/>清真菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5010"/>新疆菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5011"/>西北菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5012"/>素菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5013"/>火锅</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5014"/>西餐</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5015"/>面包甜点</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5016"/>本帮菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5017"/>徽菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5018"/>湘菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5019"/>浙菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5020"/>闽菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5021"/>苏菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5022"/>粤菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5023"/>川菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5024"/>鲁菜</label>
							<label style="margin-right:10px"><input type='checkbox' name='restCuisineType' style="position:relative;top:3px;" value="5025"/>其他</label>
						</td>
					</tr>
					<tr>
						<td class="td_lf"><em class="star">&nbsp;</em>餐馆氛围</td>
						<td id="restAtmosphere">
							<label style="margin-right:10px"><input type='checkbox' name='restAtmosphere' style="position:relative;top:3px;" value="6001"/>情侣约会</label>
							<label style="margin-right:10px"><input type='checkbox' name='restAtmosphere' style="position:relative;top:3px;" value="6002"/>朋友聚餐</label>
							<label style="margin-right:10px"><input type='checkbox' name='restAtmosphere' style="position:relative;top:3px;" value="6003"/>家庭聚会</label>
							<label style="margin-right:10px"><input type='checkbox' name='restAtmosphere' style="position:relative;top:3px;" value="6004"/>商务宴请</label>
							<label style="margin-right:10px"><input type='checkbox' name='restAtmosphere' style="position:relative;top:3px;" value="6005"/>休闲小憩</label>
							<label style="margin-right:10px"><input type='checkbox' name='restAtmosphere' style="position:relative;top:3px;" value="6006"/>随便吃吃</label>
						</td>
					</tr>
					<tr>
						<td class="td_lf"><em class="star">&nbsp;</em>人均消费</td>
						<td>
							<div class="select_s" style="width: 187px; float: left; margin-right:10px;">
								<div class="select_is" style="width: 187px;">
									<select class="select_cs" id="averageComsumption"
										style="width: 217px; background-position: -7px -122px;">
										<option value="">请选择人均消费</option>
										<option value="20005">小于50</option>
						                <option value="20004">50-100</option>
						                <option value="20003">100-150</option>
						                <option value="20001">150-200</option>
						                <option value="20002">200-250</option>
						                <option value="20006">250-300</option>
						                <option value="20007">大于300</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="td_lf"><em class="star">&nbsp;</em>所属商圈</td>
						<td>
							<div class="select_s" style="width: 187px; float: left; margin-right:10px;">
								<div class="select_is" style="width: 187px;">
									<select class="select_cs" id="commercialCenterDistrict"
										style="width: 217px; background-position: -7px -122px;">
										<option value="-1">请选择区</option>
									</select>
								</div>
							</div>
							<div class="select_s" style="width: 187px; float: left; margin-right:10px;">
								<div class="select_is" style="width: 187px;">
									<select class="select_cs" id="commercialCenter"
										style="width: 217px; background-position: -7px -122px;">
										<option value="">请选择所属商圈</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<p class="save_box">
				<input id="saveFormSubmit" type="button" class="btn_save" value="保存"/>
				<input id="reset" type="button" class="btn_save" value="重置"/>
			</p>
			<div class="clear"></div>
		</div>
	</div>
</body>
</html>