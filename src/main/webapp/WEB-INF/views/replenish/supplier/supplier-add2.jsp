<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" /> 
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>	
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
	          $(this).parent().parent().parent().find(".icon_alert").attr({"title":text_v+"填写提示","link":"replenish.supplier.iframe-select?id="+this_v,"rel":"popup"});
	      }else{
	          $(this).parent().parent().parent().find(".icon_alert").attr({"title":"证号填写提示","disabled":"disabled"});
	          $(this).parent().parent().parent().find(".icon_alert").removeAttr("rel");
	      }
	   });
});
var params = {};
var params1 = {};
var rowNo=0;
var ajaxFlag=true;
function cartTypeOne(obj,certType,certNo){
	obj.parent().find(".text_ts").remove();
	if(certType!="请选择证件"&&certNo!=""){
	    	if (certType == "工商营业执照") {
			if (gszzNumber(certNo)==false) {
				console.log(obj.parent().find("i"));
				obj.parent().find("i").after("<span class='text_ts'>请输入正确的证件号码</span>");
				return false;
			}
		} else if (certType == "餐饮服务许可证") {
			if (cyfwNumber(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
		} else if (certType == "食品流通许可证") {
			if (spltNumber(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
		} else if (certType == "食品生产许可证") {
			if (spscNumber(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
		} else if (certType == "食品经营许可证") {
			if (spjyNumber(certNo)==false) {
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
			if (gszzNumber(certNo)==false) {
				obj.parent().find("i").after("<span class='text_ts'>请输入正确的证件号码</span>");
				return false;
			}
		} else if (certType == "餐饮服务许可证") {
			if (cyfwNumber(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
			certTypeWeb='cateringCert';
		} else if (certType == "食品流通许可证") {
			if (spltNumber(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
			certTypeWeb='foodCircuCert';
		} else if (certType == "食品生产许可证") {
			if (spscNumber(certNo)==false) {
				obj.parent().find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
				return false;
			}
			certTypeWeb='foodProdCert';
		} else if (certType == "食品经营许可证") {
			if (spjyNumber(certNo)==false) {
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
	    		url:"../inputManage/supplier/isSupplierCertExist",
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
	    				obj.parent().find("i").after('<span class="text_ts">该证件号码重复</span>');
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
function insertTypeA(){
	$(".text_ts").remove();
	//遍历证件类型和证件号码
	var bizFlag=false;
	var caterFlag=false;
	var circuFlag=false;
	var prodFlag=false;
	var fdBizFlag=false;
	rowNo=0;
	$("#table4 tr").each(function(i){
		var certType=$(this).find("option:selected").text();
		var certNo=$(this).find("input").val().trim();
		var certDate=$(this).find(".input_date").val();
		if(checkSpecificKey(certNo)==false){
			$(this).find("i").after('<span class="text_ts">请勿入特殊字符</span>');
			ajaxFlag=false;
			return;
		}
		if(certType=="工商营业执照"){
			if(bizFlag==false){
				if(certNo==""||certNo==null){
					$(this).find("i").after('<span class="text_ts">请输入证件号码</span>');
					ajaxFlag=false;
					return;
				}else{
					if(!gszzNumber(certNo)){
						$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
						ajaxFlag=false;	
						return;
					}else{
						params.bizCertNum=certNo;
						params.bizCertExpDate=certDate;
						rowNo++;
						bizFlag=true;
					}
				}
			}else{
				alert("请勿重复输入证件类型");
				ajaxFlag=false;
				return;
			}
		}else if(certType=="餐饮服务许可证"){
			if(caterFlag==false){
				if(certNo==""||certNo==null){
					$(this).find("i").after('<span class="text_ts">请输入证件号码</span>');
					ajaxFlag=false;
					return;
				}else
				if(!cyfwNumber(certNo)){
					$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
					ajaxFlag=false;
					return;
				}
				params.cateringCert=certNo;
				params.cateringCertExpDate=certDate;
				rowNo++;
				caterFlag=true;
			}else{
				alert("请勿重复输入证件类型");
				ajaxFlag=false;
				return;
			}
		}else if(certType=="食品流通许可证"){
			if(circuFlag==false){
				if(certNo==""||certNo==null){
					$(this).find("i").after('<span class="text_ts">请输入证件号码</span>');
					ajaxFlag=false;
					return;
				}else
				if(!spltNumber(certNo)){
					$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
					ajaxFlag=false;
					return;
				}
				params.foodCircuCert=certNo;
				params.foodCircuCertExpDate=certDate;
				rowNo++;
				circuFlag=true;
			}else{
				alert("请勿重复输入证件类型");
				ajaxFlag=false;
				return;
			}
		}else if(certType=="食品生产许可证"){
			if(prodFlag==false){
				if(certNo==""||certNo==null){
					$(this).find("i").after('<span class="text_ts">请输入证件号码</span>');
					ajaxFlag=false;
					return;
				}
				if(!spscNumber(certNo)){
					$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
					ajaxFlag=false;
					return;
				}
				params.foodProdCert=certNo;
				params.foodProdCertExpDate=certDate;
				rowNo++;
				prodFlag=true;
			}else{
				alert("请勿重复输入证件类型");
				ajaxFlag=false;
				return;
			}
		}else if(certType=="食品经营许可证"){
			if(fdBizFlag==false){
				if(certNo==""||certNo==null){
					$(this).find("i").after('<span class="text_ts">请输入证件号码</span>');
					ajaxFlag=false;
					return;
				}
				if(!spjyNumber(certNo)){
					$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
					ajaxFlag=false;
					return;
				}
				params.foodBusinessCert=certNo;
				params.foodBusinessCertExpDate=certDate;
				rowNo++;
				fdBizFlag=true;
			}else{
				alert("请勿重复输入证件类型");
				ajaxFlag=false;
				return;
			}
		}
	});
	if(rowNo==0){
		/* $(".text_ts").remove(); */
		if($("#table4 tr:eq(0)").find("option:selected").text()!="请选择证件类型"){
	/* 		var certNo=$("#table4 tr:eq(0)").find("input").val().trim();
			if(certNo==""||certNo==null){
				$("#table4 tr:eq(0)").find("i").after('<span class="text_ts">请输入证件号码 </span>');
			} */
		}else{
			$("#table4 tr:eq(0)").find("i").after('<span class="text_ts">证件类型最少选择一种 </span>');
		}
		ajaxFlag=false;
		return false;
	}
	var name=$("#name").val().trim();
	var contactAddress=$("#address").val().trim();
	//非空输入框非空验证
	if(name==""||name==null){
		$("#name").after('<span class="text_ts">供应商名称不能为空 </span>')
		ajaxFlag=false;
		return;
	}else{
		params.name=name;
	}
	if(contactAddress==""||contactAddress==null){
		$("#address").after('<span class="text_ts">供应商地址不能为空 </span>')
		ajaxFlag=false;
		return;
	}else{
		params.contactAddress=contactAddress;
	}
	console.log(params);
}
function insertTypeB(){
	var name=$("#link_name").text();
	var contactAddress=$("#link_address").text();
	var certDate=null;
	params.name=name;
	params.contactAddress=contactAddress;
	//遍历证件类型和证件号码
	$("#table5 tr:gt(0)").each(function(){
		var certType=$(this).find("span:eq(0)").text();
		var certNo=$(this).find("span:eq(1)").text();
		if(certType=="工商营业执照"){
			params.bizCertNum=certNo;
			params.bizCertExpDate=certDate;
		}
		if(certType=="餐饮服务许可证"){
			params.cateringCert=certNo;
			params.cateringCertExpDate=certDate;
		}
		if(certType=="食品流通许可证"){
			params.foodCircuCert=certNo;
			params.foodCircuCertExpDate=certDate;
		}
		if(certType=="食品生产许可证"){
			params.foodProdCert=certNo;
			params.foodProdCertExpDate=certDate;
		}
		if(certType=="食品经营许可证"){
			params.foodBusinessCert=certNo;
			params.foodBusinessCertExpDate=certDate;
		}
	})
}
$(function(){
	
	/*--日历-生产--*/				   
	$('.input_date').calendar();
	
	$("body").on("blur","input[type='text']",function(){
 		$(this).next(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    }
	});
	$("#mobilephone").blur(function(){
		var contactPhone=$("#mobilephone").val().trim();
		$(this).siblings(".text_ts").remove();
		if(!(contactPhone==""||contactPhone==null||isMobilephone(contactPhone)||isPhone(contactPhone))){
			$("#mobilephone").after('<span class="text_ts">请输入正确联系电话 </span>');
		}
	});
	//点击保存按钮执行添加方法
	$("#btn_save").click(function(){
		ajaxFlag = true;
		params={};
		$("body .text_ts").each(function(){
		    var spanText=$(this).text();
		    if(spanText=='该证件号码重复'){
		    	ajaxFlag=false;
		    	return false;
		    }
		});
		
		if(ajaxFlag==false){
			return;
		}
		$(".text_ts").remove();
		var linkedCompanyId=$("#link_id").text();
		if(linkedCompanyId==null||linkedCompanyId==""||linkedCompanyId=="null"){
			insertTypeA();
		}else{
			params.linkedCompanyId=linkedCompanyId;
			insertTypeB();
		}
		var contactPerson=$("#person").val().trim();
		var contactPhone=$("#mobilephone").val().trim();
		var nameAbbrev=$("#abbrev").val().trim();
		var code=$("#code").val().trim();
		//判断输入框是否含有特殊字符
		$("body input[type='text']").each(function(){
		    var inputValue=	$(this).val();
		    if(checkSpecificKey(inputValue)==false){
		    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
		    	ajaxFlag=false;
		    	return;
		    }
		});
		params.contactPerson=contactPerson;
		params.nameAbbrev=nameAbbrev;
		params.code=code;
		//手机号码验证
		if(contactPhone==""||contactPhone==null||isMobilephone(contactPhone)||isPhone(contactPhone)){
			params.contactPhone=contactPhone;
		}else{
			$("#mobilephone").after('<span class="text_ts">请输入正确联系电话 </span>');
			return;
		}
		if(ajaxFlag==false){
			return;
		}
		$("#loading").show();
		$(":button").attr("disabled",true);
		$.ajax({
			url:"../inputManage/supplier/createSupplier",
			type:"post",
			data:JSON.stringify(params),
			dataType:"json",
			headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    success:function(result){
		    	$(":button").attr("disabled",false);
		    	$("#loading").hide();
		    	if(result.status==0){
		    		var id=result.body.id;
		    		//alert("保存成功！");
			    	window.location.href="replenish.supplier.supplier-add2-photo?id="+id;
		    	}else if(result.message=="供应商编码已存在！"){
		    		$("#code").after('<span class="text_ts">供应商编码重复 </span>');
		    	}else if(result.message=="使用相同名称的记录已经存在"){
		    		$("#link_name").after('<span class="text_ts">供应商名称已存在 </span>');
		    		$("#name").after('<span class="text_ts">供应商名称已存在 </span>');
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
		    		alert(webCert+"重复");
		    	}else{
		    		alert("系统异常,添加失败");
		    	}
		    },
		    error:function(){
		    	$(":button").attr("disabled",false);
		    	$("#loading").hide();
		    	alert("系统异常，保存失败！");
		    }
		})
	});
	$("#btn_reset").click(function(){
		$("#link_id").text("");
		$("#table1").show();
		$("#table4").show();
		$("#table5 tr:gt(0)").remove();
		$("#table2").hide();
		$("option").attr("disabled",false);
		$("#table4 select option:eq(0)").attr("selected","selected");
		$("#table4 tr:gt(0)").remove();
		$("#table4").find("i:eq(0)").addClass("i_add").removeClass("i_del").end();
		$(":text").val("");
	});
	//点击复制输入框
	var $user_type = $("tr[name^='certi-type']");
    $("#table4").on("click","i.i_add",function(){
    	if($(this).next(".text_ts").text()=="该证件号码重复"){
    		return;
    	}
    	$("#table4").find(".text_ts").remove();
    	var certType=$(this).parent().find("option:selected").text();
    	var certNo=$(this).parent().find("input").val().trim();
    	if(certType=="请选择证件类型"||certNo==""||certNo==null){
    		$(this).after('<span class="text_ts">' + certType+ '不能为空!' + '</span>');
    		return;
    	}
    	
		var caertStatus=cartTypeOne($(this),certType,certNo);
		if(caertStatus==false){
			return;
		}
    	if(checkSpecificKey(certNo)==false){
	    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    	return;
	    }
		//var $tr=$('<tr name="certi-type"><td class="td_lf">&nbsp;</td><td><div class="select_s" style="width:125px; float:left;"><div class="select_is" style="width:125px;"><select class="select_cs" onchange="previewImg()" style="width:212px; background-position:-12px -122px;"><option>请选择证件类型</option><option>工商营业执照</option><option>食品流通许可证</option><option>食品生产许可证</option><option>餐饮服务许可证</option><option>食品经营许可证</option></select></div></div><input type="text" class="input_code isReceiverCert" style="width:152px; float:left;margin-left:10px;" value="" maxlength="30" /><a style="width:90px;color:#1A73C3; float:left;margin-left:10px;">&nbsp;</a><input type="text" class="input_date" style="width:152px; float:left;margin-left:10px;" value="" readonly="readonly" /><i class="i_type i_add"></i></td></tr>');
		var  $tr = $('<tr><td class="td_lf">&nbsp;</td><td><div class="select_s" style="width:125px;float:left;"><div class="select_is" style="width:125px;"><select id="certType"  onchange="previewImg()" class="select_cs" style="width:212px;background-position:-12px -122px;width:125px"><option value="0">请选择证件类型</option><option value="gs">工商营业执照</option><option value="jy">食品经营许可证</option><option value="sc">食品生产许可证</option><option value="lt">食品流通许可证</option><option value="cy">餐饮服务许可证</option></select></select></div></div><input type="text" class="input_code isReceiverCert" style="width:293px;float:left;margin-left:10px;" value="" maxlength="30"/><input class="icon_alert" rel="popup" link="replenish.supplier.iframe-select?id=img_ts" title="填写提示" value="提示" disabled="disabled" /><span class="blue" style="font-weight:400;width:86px;display:inline-block;float:left;">&nbsp;</span><input type="text" class="input_date" placeholder="" maxlength="30" value="" style="width:93px;float:left;margin-left: 10px;" readonly="readonly"/><i class="i_type i_add"></i></td></tr>'); 
  //add
		$("select option:selected").each(function(){
			var text=$(this).text();
			$(this).parent().find("option:eq(0)").attr("disabled","disabled");
			$tr.find("option:contains("+text+")").attr("disabled","disabled");
		});
		$(this).addClass("i_del").removeClass("i_add").end();
		var n=$("#table4 select").length;
		if(n==4){
			$tr.find("i").addClass("i_del").removeClass("i_add").end();
		}

		$("#table4").append($tr);
		$('.input_date').calendar();
		return false;
	});
    $("i.i_del").live("click",function(){
    	$(this).parent().parent($user_type).remove();
		var n=$("#table4 select").length;
		if(n<5){
			$("#table4 tr:last").find("i").addClass("i_add").removeClass("i_del").end();
		}
		$("#table4 tr:eq(0)").find("td").eq(0).text("");
		var $em= $('<span><em class="star">*</em>证件类型</span>');
		$("#table4 tr:eq(0)").find("td").eq(0).append($em);
		$("#table4 tr:eq(0)").find("a").eq(0).text("");
		var $em2= $('<span><em class="star"></em>证件失效日期</span>');
		$("#table4 tr:eq(0)").find("a").eq(0).append($em2);
		$("option").attr("disabled",false);
		$("select option:selected").each(function(){
    		var text=$(this).text();
    		$(this).parent().find("option:eq(0)").attr("disabled","disabled");
    		$("#table4").find("option:contains("+text+")").attr("disabled","disabled");
    	});
		$("#table4 tr:last").find("option:eq(0)").attr("disabled",false);
		return false;
    });
    
    $("#table4").on("change","select",function(){
    	$("option").attr("disabled",false);
		var certType=$(this).parent().parent().parent().find(".isReceiverCert");
		var certNo=certType.val().trim();
    	$("select option:selected").each(function(){
    		var text=$(this).text();
    		if(text=="工商营业执照"){
				$(this).parents("td").find("input:text").attr("maxlength","18");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","15位工商注册号或18位统一信用代码");
				lincelsOne(certType,text,certNo);
			}else if(text=="食品经营许可证"){
				$(this).parents("td").find("input:text").attr("maxlength","16");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","JY加14位数字或字母的证件号码");
				lincelsOne(certType,text,certNo);
			}else if(text=="食品流通许可证"){
				$(this).parents("td").find("input:text").attr("maxlength","30");
				$(this).parents("td").find("input:text:eq(0)").attr("placeholder","SP加16位数字或字母的证件号码");
				lincelsOne(certType,text,certNo);
			}else if(text=="食品生产许可证"){
				$(this).parents("td").find("input:text").attr("maxlength","30");
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
    		$("#table4").find("option:contains("+text+")").attr("disabled","disabled");
    	});
    	$("#table4 tr:last").find("option:eq(0)").attr("disabled",false);
    });
    
	$("body").on("blur",".isReceiverCert",function(){
    	var certType=$(this).parent().find("option:selected").text();
    	var certNo=$(this).val().trim();
    	if(certType!="请选择证件类型"){
    		lincelsOne($(this),certType,certNo);
    	}
	});
			
		
});
</script>	
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="replenish.supplier.supplier">供应商管理</a> > <a href="#">添加供应商</a> </h3>
          <div class="info_tab">
               <a href="replenish.supplier.supplier-add2" class="default">基本信息</a>
               <a href="#">证照<em style="font-style:normal;position:relative;top:1px;letter-spacing:1px;">图</em>片</a><span style="display:none" id="link_id"></span>
          </div>
          <div class="info_box">
          		<table class="info_mation" id="table5">
                       <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>选择单位</td>
                       <td>
                       <div class="sysel">
                                <span class="text_sysel" style="display:none;"></span>
                                <input type="button" class="btn_shang" value="从系统中选择" rel="popup" link="replenish.supplier.iframe-name" title="已注册单位选择" />
                                <span class="text_gray">请优先从系统中选择单位添加，如果未找到，再手工添加。 选择系统中的单位可以实现自动收发货。</span>
                           </div>
						</td>
                  </tr>
                </table>
                <table class="info_mation" id="table4">
                <tr>
						<td class="td_lf"><em class="star">*</em>证件类型</td>
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
                           <input class="icon_alert" rel="popup" link="replenish.supplier.iframe-select?id=img_ts" title="证号填写提示" value="" disabled="disabled" />
                           <span class="blue" style="font-weight:400;width:86px;display:inline-block;float:left;">证件失效日期</span>
                           <input type="text" class="input_date" value="" readonly="readonly" style="width:93px;float:left;;margin-left:10px;"/>
							<!--  <input type="text" class="input_code isReceiverCert" style="width: 152px; float:left; margin-left:10px;" maxlength="30"id="certNo"/>
							<a style="width:100px;color:#1A73C3; float:left;">&nbsp;</a>
                           <input type="text" class="input_date" style="width:152px; float:left;margin-left:10px;" value="" readonly="readonly" />-->
							<i class="i_type i_add"></i></td>
					</tr>
                </table>
               <table class="info_mation" style="border-bottom:1px solid #dcdddd;" id="table1">
                  <tr>
                       <td class="td_lf"><em class="star">*</em>供应商名称</td>
                       <td>
                           <div style=" height:27px; position:relative;">
                                 <input type="text" class="input_code" style="width:346px;" value="" name="supply" id="name" maxlength="20"/>
                           </div>
                       </td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>单位地址</td>
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="address" maxlength="50"/></td>
                  </tr>
                </table>
                <table class="info_mation" id="table2" style="display:none; border-bottom:1px solid #dcdddd;">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>供应商名称</td>
                       <td>
	                       <div style=" height:27px; position:relative;">
		                       <span id="link_name"  ></span>
	                       </div>
                       </td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>单位地址</td>
                       <td id="link_address"></td>
                   </tr>
               </table>
                <table class="info_mation" id="table3">
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>供应商简称</td>
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="abbrev" maxlength="20"/></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>编号</td>
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="code" maxlength="10"/></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>联系人姓名</td>
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="person" maxlength="10"/></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>联系电话</td>
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="mobilephone" maxlength="20"/></td>
                   </tr>
                </table>
                <p class="save_box">
                  <input type="button" class="btn_save" value="保存" id="btn_save"/>
                  <input type="button" class="btn_save" value="重置" id="btn_reset"/>
                </p>
                <div class="clear"></div>
          </div>
     </div>
</div>			
</body>
</html>