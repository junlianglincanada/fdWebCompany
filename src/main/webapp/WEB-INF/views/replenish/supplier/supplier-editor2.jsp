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
var id="<%=id %>";
var params = {};
var rowNo=0;
var rn=0;
var ajaxFlag=true;

function cartTypeOne(obj,certType,certNo){
	obj.parent().find(".text_ts").remove();
	if(certType!="请选择证件"&&certNo!=""){
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
	    	param1.supplierId=id;
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

//证件类型下拉框选择和号码输入框显示
function select(rowNum,val,date){
	$('.input_date').calendar();
	if(!nullFlag(val)){
		var $tr=$('<tr name="certi-type"><td class="td_lf">&nbsp;</td><td><div class="select_s" style="width:125px; float:left;"><div class="select_is" style="width:125px;"><select class="select_cs" onchange="previewImg()" style="width:125px; background-position:-12px -122px; "><option>请选择证件类型</option><option>工商营业执照</option><option>食品流通许可证</option><option>食品生产许可证</option><option>餐饮服务许可证</option><option>食品经营许可证</option></select></div></div><input type="text" class="input_code isReceiverCert" style="width:293px; float:left;margin-left:10px;" value="" maxlength="30"/><a style="width:115px;color:#1A73C3; float:left;">&nbsp;</a><input type="text" class="input_date" style="width:93px; float:left;margin-left:10px;" value="" readonly="readonly"/><i class="i_type i_del"></i></tr>');
		$tr.find("option:eq("+(rowNum+1)+")").attr("selected",true);
		$tr.find("input").val(val);
		$tr.find(".input_date").val(date);
		$("#table4 tr:last").before($tr);
		rowNo++;
	}
}
$(function(){
	/*--日历-生产--*/				   
	$('.input_date').calendar();
	
	//页面加载时显示要修改数据信息
	$("#loading").show();
	$.ajax({
		url:"../inputManage/supplier/getSupplierById/"+id,
		type:"get",
		headers:{},
		success:function(result){
			if(result.status==0){
				console.log(result.body);
				document.getElementById("name1").innerHTML = result.body.name;
				var id=result.body.id;
				var name=isnull(result.body.name);
				var address=isnull(result.body.contactAddress);
				var person=isnull(result.body.contactPerson);
				var mobilephone=isnull(result.body.contactPhone);
				var code=isnull(result.body.code);
				var nameAbbrev=isnull(result.body.nameAbbrev);
				var bizCert=result.body.bizCertNum;
				var bizCertExpDate=result.body.bizCertExpDate;
				var cateringCert=result.body.cateringCert;
				var cateringCertExpDate=result.body.cateringCertExpDate;
				var foodCircuCert=result.body.foodCircuCert;
				var foodCircuCertExpDate=result.body.foodCircuCertExpDate;
				var foodProdCert=result.body.foodProdCert;
				var foodProdCertExpDate=result.body.foodProdCertExpDate;
				var foodBusinessCert=isnull(result.body.foodBusinessCert);
				var foodBusinessCertExpDate=isnull(result.body.foodBusinessCertExpDate);
				var linkedCompanyName=isnull(result.body.linkedCompanyName);
				var linkCompanyId=isnull(result.body.linkedCompanyId);
				if(linkCompanyId!=""){
					$("#licenecImg").attr("href","../findView/replenish.supplier.supplier-view-photo?id=<%=id%>&linkCompanyId="+linkCompanyId);
				}
				params.id=id;
				$("#name").val(name);
				$("#address").val(address);
				$("#person").val(person);
				$("#mobilephone").val(mobilephone);
				$("#code").val(code);
				$("#abbrev").val(nameAbbrev);
				$("#link_name").text(linkedCompanyName);
				select(0,bizCert,bizCertExpDate);
				select(1,foodCircuCert,foodCircuCertExpDate);
				select(2,foodProdCert,foodProdCertExpDate);
				select(3,cateringCert,cateringCertExpDate);
				select(4,foodBusinessCert,foodBusinessCertExpDate);
				if(rowNo==5){
					$("#table4 tr:last").remove();
				}
				$("option").attr("disabled",false);
    			$("select option:selected").each(function(){
    				var text=$(this).text();
    				$("#table4").find("option:contains("+text+")").attr("disabled","disabled");
    			})
    			$("#table4 tr:eq(0)").find("td").eq(0).text("");
				var $em= $('<span><em class="star">*</em>证件类型</span>');
				$("#table4 tr:eq(0)").find("td").eq(0).append($em);
				$("#table4 tr:eq(0)").find("a").eq(0).text("");
				var $em= $('<span><em class="star"></em>证件失效日期</span>');
				$("#table4 tr:eq(0)").find("a").eq(0).append($em);
				$('.input_date').calendar();
				$("#loading").hide();
			}
		},
		error:function(){
			alert("系统异常，查询失败");
		}
	});
	//特殊字符验证
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
	//点击保存按钮修改数据
	$(".btn_save").click(function(){
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
		var name=$("#name").val().trim();
		var contactAddress=$("#address").val().trim();
		var contactPerson=$("#person").val().trim();
		var contactPhone=$("#mobilephone").val().trim();
		var nameAbbrev=$("#abbrev").val().trim();
		var code=$("#code").val().trim();
		var linkedCompanyId=$("#link_id").text();
		if(nullFlag(name)){
			$("#name").after('<span class="text_ts">供应商名称不能为空 </span>')
			return;
		}
		if(nullFlag(contactAddress)){
			$("#address").after('<span class="text_ts">供应商地址不能为空 </span>')
			return;
		}
		params.name=name;
		params.contactAddress=contactAddress;
		params.contactPerson=contactPerson;
		params.nameAbbrev=nameAbbrev;
		params.code=code;
		params.linkedCompanyId=linkedCompanyId;
		//手机号码验证
		if(contactPhone==""||contactPhone==null||isMobilephone(contactPhone)||isPhone(contactPhone)){
			params.contactPhone=contactPhone;
		}else{
			$("#mobilephone").after('<span class="text_ts">请输入正确联系电话 </span>');
			return;
		}
		//遍历证件类型和证件号码
		ajaxFlag=true;
		var bizFlag=false;
		var caterFlag=false;
		var circuFlag=false;
		var prodFlag=false;
		var fdBizFlag=false;
		//判断输入框是否含有特殊字符
		$("body input[type='text']").each(function(){
		    var inputValue=	$(this).val();
		    if(checkSpecificKey(inputValue)==false){
		    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
		    	ajaxFlag=false;
		    	return;
		    }
		});
		$("#table4 tr").each(function(){
			var certType=$(this).find("option:selected").text();
			var certNo=$(this).find("input").val().trim();
			var certDate=$(this).find(".input_date").val();
			if(checkSpecificKey(certNo)==false){
				$(".text_ts").remove();
				$(this).find("input").after('<span class="text_ts">请勿入特殊字符 </span>');
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
							return false;
						}
						params.bizCertNum=certNo;
						params.bizCertExpDate=certDate;
						rn++;
						bizFlag=true;
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
					}
					if(!cyfwNumber(certNo)){
						$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
						ajaxFlag=false;
						return false;
					}
					params.cateringCert=certNo;
					params.cateringCertExpDate=certDate;
					rn++;
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
					}
					if(!spltNumber(certNo)){
						$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
						ajaxFlag=false;
						return;
					}
					params.foodCircuCert=certNo;
					params.foodCircuCertExpDate=certDate;
					rn++;
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
					rn++;
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
					rn++;
					fdBizFlag=true;
				}else{
					alert("请勿重复输入证件类型");
					ajaxFlag=false;
					return;
				}
			}
		});
		console.log(params);
		if(rn==0){
			//$("#table4").find(".text_ts").remove();
			if($("#table4 tr:eq(0)").find("option:selected").text()!="请选择证件类型"){
				/* var certNo=$("#table4 tr:eq(0)").find("input").val();
				if(certNo==""||certNo==null){
					$("#table4 tr:eq(0)").find("i").after('<span class="text_ts">请输入证件号码</span>');
				} */
			}else{
				$("#table4 tr:eq(0)").find("i").after('<span class="text_ts">证件类型最少选择一种 </span>');
			}
			ajaxFlag=false;
		}
		if(ajaxFlag==false){
			return;
		}
		$("#loading").show();
		$(":button").attr("disabled",true);
		$.ajax({
			url:"../inputManage/supplier/updateSupplier",
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
			    	window.location.href="replenish.supplier.supplier-view?id=<%=id %>";
		    	}else if(result.message=="供应商编码已存在！"){
		    		$("#code").after('<span class="text_ts">供应商编码重复 </span>');
		    	}else if(result.message=="相同名称的供应商已经存在！"){
		    		$("#name").after('<span class="text_ts">供应商名称已存在 </span>');
		    	}else  if(result.message=="证件号码已存在"){
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
		    		alert("系统异常,修改失败");
		    	}
		    },
		    error:function(){
		    	$(":button").attr("disabled",false);
		    	$("#loading").hide();
		    	alert("系统异常，修改失败！");
		    }
		})
	});
	//点击复制输入框
	var $user_type = $("tr[name^='certi-type']");
    $("#table4").on("click","i.i_add",function(){
    	if($(this).next(".text_ts").text()=="该证件号码重复"){
    		return;
    	}
    	$(this).parent().find(".text_ts").remove();
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
		var  $tr = $('<tr><td class="td_lf">&nbsp;</td><td><div class="select_s" style="width:125px;float:left;"><div class="select_is" style="width:125px;"><select id="certType"  onchange="previewImg()" class="select_cs" style="width:125px;background-position:-12px -122px;width:125px"><option value="0">请选择证件类型</option><option value="gs">工商营业执照</option><option value="jy">食品经营许可证</option><option value="sc">食品生产许可证</option><option value="lt">食品流通许可证</option><option value="cy">餐饮服务许可证</option></select></select></div></div><input type="text" class="input_code isReceiverCert" style="width:293px;float:left;margin-left:10px;" value="" maxlength="30"/><input class="icon_alert" rel="popup" link="replenish.supplier.iframe-select?id=img_ts" title="填写提示" value="提示" disabled="disabled" /><span class="blue" style="font-weight:400;width:86px;display:inline-block;float:left;">&nbsp;</span><input type="text" class="input_date" placeholder="" maxlength="30" value="" style="width:93px;float:left;margin-left: 10px;" readonly="readonly"/><i class="i_type i_add"></i></td></tr>'); 
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
		var $em= $('<span><em class="star">&nbsp;</em>证件类型</span>');
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
          <h3 class="process_title"><span>当前位置: </span><a href="replenish.supplier.supplier">供应商管理</a> > <a href="#">编辑供应商</a> > <a id="name1"></a>
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="删除供应商" rel="popup" link="replenish.supplier.iframe-del?id=<%=id %>" title="提示"/>
              </div>
          </h3>
          <div class="info_tab">
               <a href="replenish.supplier.supplier-editor2?id=<%=id %>" class="default">基本信息</a>
               <a id="licenecImg" href="replenish.supplier.supplier-view-photo?id=<%=id %>">证照<em style="font-style:normal;position:relative;top:1px;letter-spacing:1px;">图</em>片</a><span style="display:none" id="link_id"></span>
          </div>
          <div class="info_box">
          		<!-- <div class="assoc_unit">关联单位
                   <span class="lf_blue">已关联注册单位</span>
                   <span class="assoc_name" id="link_name"></span>
                   <a href="javascript:void()" class="assoc_blue" rel="popup" link="replenish.supplier.iframe-register" title="关联注册单位">更改</a>
               </div> -->
               <table class="info_mation" id="table4">
               <tr name="certi-type">
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
                           <input class="icon_alert" rel="popup" link="replenish.supplier.iframe-select?id=img_ts" title="证号填写提示" value="" disabled="disabled" />
                           <span class="blue" style="font-weight:400;width:86px;display:inline-block;float:left;">&nbsp</span>
                           <input type="text" class="input_date" value="" readonly="readonly" style="width:93px;float:left;;margin-left:10px;"/>
							<!--  <input type="text" class="input_code isReceiverCert" style="width: 293px; float:left; margin-left:10px;" maxlength="30"id="certNo"/>
							<a style="width:100px;color:#1A73C3; float:left;">&nbsp;</a>
                           <input type="text" class="input_date" style="width:293px; float:left;margin-left:10px;" value="" readonly="readonly" />-->
							<i class="i_type i_add"></i></td>
					</tr>
                <!--  <tr name="certi-type">
                       <td class="td_lf"><em class="star">&nbsp;</em></td>
                       <td>
                           <div class="select_s" style="width:125px; float:left;">
                            <div class="select_is" style="width:125px;">
                               <select class="select_cs" id="certType" onchange="previewImg()" style="width:125px; background-position:-12px -122px;">
                                      	<option value="0">请选择证件类型</option>
										<option value="gs">工商营业执照</option>
										<option value="lt">食品流通许可证</option>
						                <option value="sc">食品生产许可证</option>
						                <option value="cy">餐饮服务许可证</option>
						                <option value="jy ">食品经营许可证</option>
                               </select>
                             </div>
                           </div>
                            <input type="text" class="input_code isReceiverCert" style="width:293px; float:left;margin-left:10px;" value="" maxlength="30" />
                           <a style="width:100px;color:#1A73C3; float:left;">&nbsp;</a>
                           <input type="text" class="input_date" style="width:132px; float:left;margin-left:10px;" value="" readonly="readonly" />
                           <i class="i_type i_add"></i>
                       </td>
                  </tr>-->
                </table>
               <table class="info_mation" style="border-bottom:1px solid #dcdddd;" id="table1">
                  <tr>
                       <td class="td_lf"><em class="star">*</em>供应商名称</td>
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="name" maxlength="20"/></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>单位地址</td>
                       <td><input type="text" class="input_code" style="width:346px;" onchange="previewImg()" value="" id="address" maxlength="50"/></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star"></em>已关联注册单位</td>
                       <td><span class="assoc_name" id="link_name"></span>
                   <a href="javascript:void()" class="assoc_blue" rel="popup" link="replenish.supplier.iframe-register" title="已注册单位选择">更改</a></td>
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
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="person" maxlength="10"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>联系电话</td>
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="mobilephone" maxlength="20"></td>
                   </tr>
                </table>
                <p class="save_box">
                  <input type="button" class="btn_save" value="保存" />
                </p>
               <div class="clear"></div>
          </div>
     </div>
</div>
</body>
</html>