<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%
String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp"%>
<link rel="Stylesheet" href="../js/jquery.autocomplete.css" /> 
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>	
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="distribute.goods.goods">收货商管理</a> > <a href="#">编辑收货商</a> > <a id="name1"></a>
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="删除收货商" rel="popup" link="../findView/distribute.goods.iframe-del?id=<%=id%>" title="提示"/>
              </div>
          </h3>
          <div class="info_tab">
               <a href="../findView/distribute.goods.goods-editor2?id=<%=id %>" class="default">基本信息</a>
               <a id="licensesImg" href="../findView/distribute.goods.goods-view-photo?id=<%=id %>">证照<em style="font-style:normal;position:relative;top:1px;letter-spacing:1px;">图</em>片</a>
          </div>
          <div class="info_box">
           <table id="table2" class="info_mation">
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
                           <input class="icon_alert" rel="popup" link="distribute.goods.iframe-select?id=img_ts" title="证号填写提示" value="" disabled="disabled" />
                           <!-- <span class="blue" style="font-weight:400;width:86px;display:inline-block;float:left;"></span>
                            <input type="text" class="input_date" value="" readonly="readonly" style="width:93px;float:left;;margin-left:10px;"/>-->
							<i class="i_type i_add"></i></td>
                       <!-- <td class="td_lf"><em class="star">&nbsp;</em>证件类型</td>
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
                           <input type="text" class="input_code isReceiverCert" style="width:293px;float:left;margin-left:10px;color:gray;" value="" maxlength="30"/>
                                <input class="icon_alert" rel="popup" link="replenish.supplier.iframe-select?id=img_ts" title="证号填写提示" value="" disabled="disabled" />
                       		</td>
                       		<td class="td_lf" style="width:50px;padding-left:5px;text-align:center;">到期日期</td>
                      		 <td>
                           <input type="text" class="input_date" value="" readonly style="float:left;"/>
                           <i class="i_type i_add"></i>
                       		</td>
                            <input type="text" class="input_code isReceiverCert" style="width:293px; float:left;margin-left:10px;" value="" maxlength="20" />
                           <i class="i_type i_add"></i>
                       </td>-->
                  </tr>
          </table>
               <table class="info_mation" style="border-bottom:1px solid #dcdddd;" id="table1">
                  <tr>
                       <td class="td_lf"><em class="star">*</em>收货商名称</td>
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="name" maxlength="50" /></td>
                  </tr>
                  <tr>
                       <td class="td_lf"><em class="star">*</em>单位地址</td>
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="address" maxlength="50" /></td>
                  </tr>
					<tr>
						<td class="td_lf"><em class="star">&nbsp;</em>
						<span id="linkedCompanyId" style="display: none;"></span>
						 已关联注册单位
						</td>
						<td><span class="assoc_name" id="assoc_name"></span>
						<a href="javascript:void()" class="assoc_blue" rel="popup" link="distribute.goods.iframe-register" title="已注册单位选择"  id="assoc_name_select">请选择</a>
						</td>
					</tr>
				</table>
                <table class="info_mation" id="table3">
                <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>收货商简称</td>
                       <td><input type="text" class="input_code" style="width:346px;c" value="" id="companyAbbreviation" maxlength="25" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>编号</td>
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="number" maxlength="25" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>联系人姓名</td>
                       <td><input type="text" class="input_code" style="width:346px;c" value="" id="person" maxlength="25" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>联系电话</td>
                       <td><input type="text" class="input_code" style="width:346px;" value="" id="mobilephone" maxlength="20" /></td>
                   </tr>
                </table>
                <p class="save_box">
                  <input type="button" class="btn_save" value="保存" />
                </p>
               <div class="clear"></div>
          </div>
     </div>
</div>    


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
	          $(this).parent().parent().parent().find(".icon_alert").attr({"title":text_v+"填写提示","link":"distribute.goods.iframe-select?id="+this_v,"rel":"popup"});
	      }else{
	          $(this).parent().parent().parent().find(".icon_alert").attr({"title":"证号填写提示","disabled":"disabled"});
	          $(this).parent().parent().parent().find(".icon_alert").removeAttr("rel");
	      }
	   });
});	
var id="<%=id%>";
var params = {};
var params1={};
var isButton=true;
//查询方法
function queryCompany(id){
	$("#loading").show();
	$.ajax({
		url:"../inputManage/receiver/getReceiverById/"+id,
		type:"get",
		success:function(result){
			if(result.status==0){
				var name=isnull(result.body.name);
				var address=isnull(result.body.contactAddress);	
			    var companyAbbreviation=isnull(result.body.nameAbbrev);
				var number=isnull(result.body.code); 
				var person=isnull(result.body.contactPerson);
				var mobilephone=isnull(result.body.contactPhone);
				var bizCert=isnull(result.body.bizCertNum);
				var cateringCert=isnull(result.body.cateringCert);
				var foodCircuCert=isnull(result.body.foodCircuCert);
				var foodProdCert=isnull(result.body.foodProdCert);
				var assoc_name=isnull(result.body.linkedCompanyName);
				var foodBusinessCert=isnull(result.body.foodBusinessCert);
				document.getElementById("name1").innerHTML = result.body.name;
				var linkCompanyId=isnull(result.body.linkedCompanyId);
				if(linkCompanyId!=""){
					$("#licensesImg").attr("href","../findView/distribute.goods.goods-view-photo?id=<%=id%>&linkCompanyId="+linkCompanyId);
				}
			
				if(assoc_name!=""){
					$("#assoc_name_select").text("更改");
					$("#assoc_name").text(assoc_name);
				}
				$("#name").val(name);
				$("#address").val(address);
				$("#companyAbbreviation").val(companyAbbreviation);
				$("#number").val(number);
				$("#person").val(person);
				$("#mobilephone").val(mobilephone);
				$("#table2 tr:eq(0)").find("td").eq(0).html("");
				if(bizCert!=""){
					var $tr=$('<tr name="certi-type"><td class="td_lf"></td><td><div class="select_s" style="width:125px; float:left;"><div class="select_is" style="width:125px;"><select class="select_cs"  style="width:125px; background-position:-12px -122px; "><option>请选择证件类型</option><option selected = "selected">工商营业执照</option><option>食品流通许可证</option><option>食品生产许可证</option><option>餐饮服务许可证</option><option >食品经营许可证</option></select></div></div><input type="text" class="input_code isReceiverCert" style="width:293px; float:left;margin-left:10px;" value="'+bizCert+'" maxlength="20" onkeyup="" onbeforepaste=""/><i class="i_type i_del" style="margin-left:40px;"></i></td></tr>');
					$("#table2").prepend($tr);
				}
				if(cateringCert!=""){
					var $tr=$('<tr name="certi-type"><td class="td_lf"></td><td><div class="select_s" style="width:125px; float:left;"><div class="select_is" style="width:125px;"><select class="select_cs"  style="width:125px; background-position:-12px -122px; "><option>请选择证件类型</option><option >工商营业执照</option><option>食品流通许可证</option><option>食品生产许可证</option><option selected = "selected">餐饮服务许可证</option><option >食品经营许可证</option></select></div></div><input type="text" class="input_code isReceiverCert" style="width:293px; float:left;margin-left:10px;" value="'+cateringCert+'" maxlength="20" onkeyup="" onbeforepaste=""/><i class="i_type i_del" style="margin-left:40px;"></i></td></tr>');
					$("#table2").prepend($tr);
				}
				if(foodCircuCert!=""){
					var $tr=$('<tr name="certi-type"><td class="td_lf"></td><td><div class="select_s" style="width:125px; float:left;"><div class="select_is" style="width:125px;"><select class="select_cs"  style="width:125px; background-position:-12px -122px;"><option>请选择证件类型</option><option >工商营业执照</option><option selected = "selected">食品流通许可证</option><option>食品生产许可证</option><option >餐饮服务许可证</option><option >食品经营许可证</option></select></div></div><input type="text" class="input_code isReceiverCert" style="width:293px; float:left;margin-left:10px;" value="'+foodCircuCert+'" maxlength="20" onkeyup="" onbeforepaste=""/><i class="i_type i_del" style="margin-left:40px;"></i></td></tr>');
					$("#table2").prepend($tr);
				}
				if(foodProdCert!=""){
					var $tr=$('<tr name="certi-type"><td class="td_lf"></td><td><div class="select_s" style="width:125px; float:left;"><div class="select_is" style="width:125px;"><select class="select_cs"  style="width:125px; background-position:-12px -122px;"><option>请选择证件类型</option><option >工商营业执照</option><option>食品流通许可证</option><option selected = "selected">食品生产许可证</option><option>餐饮服务许可证</option><option>食品经营许可证</option></select></div></div><input type="text" class="input_code isReceiverCert" style="width:293px; float:left;margin-left:10px;" value="'+foodProdCert+'" maxlength="20" onkeyup="" onbeforepaste=""/><i class="i_type i_del" style="margin-left:40px;"></i></td></tr>');
					$("#table2").prepend($tr);
				}
				if(foodBusinessCert!=""){
					var $tr=$('<tr name="certi-type"><td class="td_lf"></td><td><div class="select_s" style="width:125px; float:left;"><div class="select_is" style="width:125px;"><select class="select_cs"  style="width:125px; background-position:-12px -122px;"><option>请选择证件类型</option><option >工商营业执照</option><option>食品流通许可证</option><option>餐饮服务许可证</option><option selected = "selected">食品经营许可证</option></select></div></div><input type="text" class="input_code isReceiverCert" style="width:293px ; float:left;margin-left:10px;" value="'+foodBusinessCert+'" maxlength="20" onkeyup="" onbeforepaste=""/><i class="i_type i_del" style="margin-left:40px;"></i></td></tr>');
					$("#table2").prepend($tr);
				}
			    var i=$("#table2 select").length;
			    if(i>=5){
			    	$("#table2 tr:gt(4)").remove();
			    	$("#table2 tr:last").find("i").addClass("i_del").removeClass("i_add").end();
			    } 
				var $em= $('<span><em class="star">&nbsp;</em>证件类型</span>');
				$("#table2 tr:eq(0)").find("td").eq(0).append($em);
    			 $("select option:selected").each(function(){
    				var text=$(this).text();
    				$("#table2").find("option:contains("+text+")").attr("disabled","disabled");
    			}) ;
    			 
			}
			$("#loading").hide();
		},
		error:function(){
			alert("系统异常,数据加载失败");
	    	$("#loading").hide();
		}
		
	});
}
//修改方法
function updateCompany(params){
	$(":button").attr("disabled",true);
	$("#loading").show();
	$.ajax({
		url:"../inputManage/receiver/updateReceiver",
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
	    		 window.location.href="distribute.goods.goods-view?id="+id;
	    	}else if(result.message=="收货商编码已存在！"){
	    		$("#number").after('<span class="text_ts">收货商编码重复</span>');
	    	}else if(result.message=="相同名称的供应商已经存在！"){
	    		$("#name").after('<span class="text_ts">收货商名称已存在</span>');
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
	    	alert("系统异常,修改失败");
	    	$("#loading").hide();
	    }
	});
}
function cartTypeOne(obj,certType,certNo){
	obj.parent().find(".text_ts").remove();
	console.log(obj,certType,certNo);
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
	    	param1.receiverId=id;
	    	$(":button").attr("disabled",true);
	    	$.ajax({
	    		url:"../inputManage/receiver/isReceiverCertExist",
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

$(function(){
	//页面加载完成执行查询
	queryCompany(id);
	$("body").on("blur","input[type='text']",function(){
 		$(this).next(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    }
	});
	//点击保存按钮
	$(".btn_save").click(function(){
		var ajaxFlag=true;
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
		$("body").find(".text_ts").remove();
		$("body input[type='text']").each(function(){
		    var inputValue=	$(this).val();
		    if(checkSpecificKey(inputValue)==false){
		    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
		    	ajaxFlag=false;
		    	return false;
		    }
		});

		if(ajaxFlag==false){
			return;
		}
		params.bizCertNum="";
		params.cateringCert="";
		params.foodCircuCert="";
		params.foodProdCert="";
		params.foodBusinessCert="";
		params.id=id;
		var linkedCompanyName=isnull($("#assoc_name").text());
		var linkedCompanyId=isnull($("#linkedCompanyId").text());
		if(linkedCompanyId!=""&&linkedCompanyName!=""){
			params.linkedCompanyId=linkedCompanyId;
		}else{
			params.linkedCompanyId="";
		}
	    var name=$("#name").val().trim();
	    var contactAddress=$("#address").val().trim();
	    var companyAbbreviation=$("#companyAbbreviation").val().trim();
		var number=$("#number").val().trim();
		var contactPerson=$("#person").val().trim();
		var contactPhone=$("#mobilephone").val().trim();
		
		//遍历证件类型和证件号码
		$("#table2 tr").each(function(i){
			var certType=$(this).find("option:selected").text();
			var certNo=$(this).find("input").val().trim();
			
			if(certType=="工商营业执照"){
					if(certNo!=""&&certNo!=null){
							if(gszzNumber(certNo)){
								params.bizCertNum=certNo;
							}else{
								$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
								ajaxFlag=false;
								return false;
							}
					}
			}else if(certType=="餐饮服务许可证"){
					 if(certNo!=""&&certNo!=null){
							if(cyfwNumber(certNo)){
								params.cateringCert=certNo;
							}else{
								$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
								ajaxFlag=false;
								return false;
							}
					}
					
			}else if(certType=="食品流通许可证"){
					if(certNo!=""&&certNo!=null){
						if(spltNumber(certNo)){
							params.foodCircuCert=certNo;
						}else{
							$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
							ajaxFlag=false;
							return false;
						}
					}
					
			}else if(certType=="食品生产许可证"){
					if(certNo!=""&&certNo!=null){
							if(spscNumber(certNo)){
								params.foodProdCert=certNo;
							}else{
								$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
								ajaxFlag=false;
								return false;
							}
					}
			}else if(certType=="食品经营许可证"){
					if(certNo!=""&&certNo!=null){
						if(spjyNumber(certNo)){
							params.foodBusinessCert=certNo;
						}else{
							$(this).find("i").after('<span class="text_ts">请输入正确的证件号码</span>');
							ajaxFlag=false;
							return false;
						}
				}
			}
		});
		console.log(params);
		if(ajaxFlag==false){
			return;
		}
		
		if(nullFlag(name)){
			$("#name").after('<span class="text_ts">收货商名称不能为空 </span>');
			return;
		}
		if(nullFlag(contactAddress)){
			$("#address").after('<span class="text_ts">收货商地址不能为空 </span>');
			return;
		}
		params.nameAbbrev=companyAbbreviation;
		params.code=number ;
		params.contactAddress=contactAddress;
		params.name=name;
		params.contactPerson=contactPerson;

		//手机号码验证
		if(contactPhone==""||contactPhone==null||isMobilephone(contactPhone)||isPhone(contactPhone)){
			params.contactPhone=contactPhone;
		}else{
			$("#mobilephone").after('<span class="text_ts">请输入正确的联系电话</span>');
			return;
		}
	//执行修改
	updateCompany(params); 
	});
	
	var $user_type = $("tr[name^='certi-type']");
	
	//点击(+)按钮复制下拉框
    $("#table2").on("click","i.i_add",function(){
    	if($(this).next(".text_ts").text()=="该证件号码重复"){
    		return;
    	}
    	$(this).parent().find(".text_ts").remove();
    	var certType=$(this).parent().find("option:selected").text();
    	var certNo=$(this).parent().find("input").val().trim();
    	if(certType=="请选择证件类型"){
    		$(this).after('<span class="text_ts">请选择证件类型</span>');
    		return;
    	}
    	if(nullFlag(certNo)){
    		$(this).after('<span class="text_ts">请输入证件号码</span>');
    		return;
    	}
    	var certStatus=cartTypeOne($(this),certType,certNo);
    	if(certStatus==false){
    		return;
    	}
    	var  $tr = $('<tr><td class="td_lf">&nbsp;</td><td><div class="select_s" style="width:125px;float:left;"><div class="select_is" style="width:125px;"><select id="certType"  onchange="previewImg()" class="select_cs" style="width:125px;background-position:-12px -122px;width:125px"><option value="0">请选择证件类型</option><option value="gs">工商营业执照</option><option value="jy">食品经营许可证</option><option value="sc">食品生产许可证</option><option value="lt">食品流通许可证</option><option value="cy">餐饮服务许可证</option></select></select></div></div><input type="text" class="input_code isReceiverCert" style="width:293px;float:left;margin-left:10px;" value="" maxlength="30"/><input class="icon_alert" rel="popup" link="distribute.goods.iframe-select?id=img_ts" title="填写提示" value="提示" disabled="disabled" /><i class="i_type i_add"></i></td></tr>'); 
    	  
    $("#table2").append($tr);
    	var n=$("#table2 select").length;
          if(n==5){
       	   $tr.find("i").addClass("i_del").removeClass("i_add").end();
          }
          $("select option:selected").each(function(){
      		var text=$(this).text();
      		$("#table2").find("option:contains("+text+")").attr("disabled","disabled");
      	});
    	$(this).addClass("i_del").removeClass("i_add").end();
		return false;
    });
    
    //点击x按钮 删除下拉框 
    $("i.i_del").live("click",function(){
    	$(this).parent().parent($user_type).remove();
		var n=$("#table2 select").length;
	 	if(n<5){
			$("#table2 tr:last").find("i").addClass("i_add").removeClass("i_del").end();
		}
	 	$("#table2 tr:eq(0)").find("td").eq(0).text("");
    	var $em= $('<span><em class="star">&nbsp;</em>证件类型</span>');
		$("#table2 tr:eq(0)").find("td").eq(0).append($em);
		$("option").attr("disabled",false);
		$("select option:selected").each(function(){
    		var text=$(this).text();
    		$("#table2").find("option:contains("+text+")").attr("disabled","disabled");
    	});
		return false;
    });
  
    $("#table2").on("change","select",function(){
    	$("option").attr("disabled",false);
    	$("select option:selected").each(function(){
    		var text=$(this).text();
    		$("#table2").find("option:contains("+text+")").attr("disabled","disabled");
    	});
    });
	$("#table2").on("change", "select", function() {
		var certTyp = $(this).find("option:selected");
		var certType=$(this).parent().parent().parent().find(".isReceiverCert");
		var certNo=certType.val().trim();
			if (certTyp.text() == "工商营业执照") {
				certTyp.parent().parent().parent().next("input").attr("placeholder", "15位工商注册号或18位统一信用代码");
				lincelsOne(certType,certTyp.text(),certNo);
			} else if (certTyp.text() == "食品经营许可证") {
				certTyp.parent().parent().parent().next("input").attr("placeholder", "JY加14位数字或字母的证件号码");
				lincelsOne(certType,certTyp.text(),certNo);
			} else if (certTyp.text() == "食品生产许可证") {
				certTyp.parent().parent().parent().next("input").attr("placeholder", "QS加12位数字字母或SC加14位数字字母的证件号码");
				lincelsOne(certType,certTyp.text(),certNo);
			} else if (certTyp.text() == "食品流通许可证") {
				certTyp.parent().parent().parent().next("input").attr("placeholder", "SP加16位数字或字母的证件号码");
				lincelsOne(certType,certTyp.text(),certNo);
			} else if (certTyp.text() == "餐饮服务许可证") {
				certTyp.parent().parent().parent().next("input").attr("placeholder", "如：沪餐证字+16位数字或字母");
				lincelsOne(certType,certTyp.text(),certNo);
			} else {
				$(this).parent().parent().parent().find(".text_ts").remove();
				certTyp.parent().parent().parent().next("input").attr("placeholder", "");
			}
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
</body>
</html>