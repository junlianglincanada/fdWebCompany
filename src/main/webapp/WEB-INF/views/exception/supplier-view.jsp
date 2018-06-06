<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../include.jsp" %>
<script type="text/javascript">
var id="<%=id %>";
function isnull(object){
	if(object==null||object=="null"||object==""){
		return "";
	}else{
		return object;
	}
}
$(function(){
	$("#loading").show();
	$.ajax({
		url:"../inputManage/supplier/getSupplierById/"+id,
		type:"get",
		headers:{},
		success:function(result){
			if(result.status==0){
				console.log(result.body);
				document.getElementById("name1").innerHTML = result.body.name;
				var linkedCompanyName=isnull(result.body.linkedCompanyName);
				var name=isnull(result.body.name);
				var address=isnull(result.body.contactAddress);
				var person=isnull(result.body.contactPerson);
				var mobilephone=isnull(result.body.contactPhone);
				var code=isnull(result.body.code);
				var nameAbbrev=isnull(result.body.nameAbbrev);
				var bizCert=isnull(result.body.bizCertNum);
				var bizCertExpDate=isnull(result.body.bizCertExpDate);
				var cateringCertExpDate=isnull(result.body.cateringCertExpDate);
				var cateringCert=isnull(result.body.cateringCert);
				var foodCircuCert=isnull(result.body.foodCircuCert);
				var foodCircuCertExpDate=isnull(result.body.foodCircuCertExpDate);
				var foodProdCert=isnull(result.body.foodProdCert);
				var foodProdCertExpDate=isnull(result.body.foodProdCertExpDate);
				var foodBusinessCert=isnull(result.body.foodBusinessCert);
				var foodBusinessCertExpDate=isnull(result.body.foodBusinessCertExpDate);
				var linkCompanyId=isnull(result.body.linkedCompanyId);
				if(linkCompanyId!=""){
					$("#licenecImg").attr("href","exception.supplier-view-photo?id=<%=id%>&linkCompanyId="+linkCompanyId);
				}
				$("#linkedCompanyName").text(linkedCompanyName);
				$("#name").text(name);
				$("#address").text(address);
				$("#abbrev").text(nameAbbrev);
				$("#code").text(code);
				$("#person").text(person);
				$("#mobilephone").text(mobilephone);
				if(foodBusinessCert!=""){
					var certType="食品经营许可证";
					var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span  style="width:152px; float:left;">'+certType+'</span><span style=" width:252px; float:left; margin-left:10px;">'+foodBusinessCert+'</span><a style="width:100px;color:#1A73C3; float:left;margin-left:50px;">&nbsp;</a><span style="margin-left:10px; float:left;">'+foodBusinessCertExpDate+'</span></td></tr>');
					$("#table1").prepend($tr);
				}
				if(foodProdCert!=""){
					var certType="食品生产许可证";
					var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span  style="width:152px; float:left;">'+certType+'</span><span style=" width:252px; float:left; margin-left:10px;">'+foodProdCert+'</span><a style="width:100px;color:#1A73C3; float:left;margin-left:50px;">&nbsp;</a><span style="margin-left:10px; float:left;">'+foodProdCertExpDate+'</span></td></tr>');
					$("#table1").prepend($tr);
				}
				if(foodCircuCert!=""){
					var certType="食品流通许可证";
					var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style="margin-left:10px;width:252px; float:left;">'+foodCircuCert+'</span><a style="width:100px;color:#1A73C3; float:left;margin-left:50px;">&nbsp;</a><span style="margin-left:10px; float:left;">'+foodCircuCertExpDate+'</span></td></tr>');
					$("#table1").prepend($tr);
				}
				if(cateringCert!=""){
					var certType="餐饮服务许可证";
					var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style="margin-left:10px;width:252px; float:left;">'+cateringCert+'</span><a style="width:100px;color:#1A73C3; float:left;margin-left:50px;">&nbsp;</a><span style="margin-left:10px; float:left;">'+cateringCertExpDate+'</span></td></tr>');
					$("#table1").prepend($tr);
				}
				if(bizCert!=""){
					var certType="工商营业执照";
					var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span style="width:152px; float:left;">'+certType+'</span><span style="margin-left:10px;width:252px; float:left;">'+bizCert+'</span><a style="width:100px;color:#1A73C3; float:left;margin-left:50px;">&nbsp;</a><span style="margin-left:10px; float:left;">'+bizCertExpDate+'</span></td></tr>');
					$("#table1").prepend($tr);
				}
				if(foodProdCert==""&&foodCircuCert==""&&cateringCert==""&&bizCert==""){
					var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span></span><span style="margin-left:10px;"></span></td></tr>');
					$("#table1").prepend($tr);
				}
				$("#table1 tr:eq(0) td:eq(0)").html('<em class="star">*</em>证件类型');
				$("#table1 tr:eq(0) a:eq(0)").html('<em class="star"></em>证件失效日期');
/* 				var $em= $('<span><em class="star"></em>证件失效日期</span>');
				$("#table4 tr:eq(0)").find("a").eq(0).append($em);
				$("#table1 tr:eq(0) td:eq(2)").html('<em class="star"></em>证件失效日期'); */
				$("#loading").hide();
			}
		},
		error:function(){
			alert("系统异常，查询失败");
		}
	});
}); 
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="exception.exception-Certificate">证照预警</a> > <a href="#">查看供应商</a> > <a id="name1"></a> 
          </h3>
          <div class="info_tab">
               <a href="exception.supplier-view?id=<%=id %>" class="default">基本信息</a>
               <a href="exception.supplier-view-photo?id=<%=id%>" id="licenecImg">证照<em style="font-style:normal;position:relative;top:1px;letter-spacing:1px;">图</em>片</a>
         </div>
          <div class="info_box">
          		<!-- <div class="assoc_unit">关联单位
                   <span class="lf_blue">已关联注册单位</span>
                   <span class="assoc_name" id="linkedCompanyName"></span>
               </div> -->
               <table class="info_mation">
               	   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>已关联注册单位</td>
                       <td id="linkedCompanyName"></td>
                   </tr>
               </table>
               <table class="info_mation" id="table1" style="border-bottom:1px solid #dcdddd">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>供应商名称</td>
                       <td id="name"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>单位地址</td>
                       <td id="address"></td>
                   </tr>
               </table>
               <table class="info_mation">
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>供应商简称</td>
                       <td id="abbrev"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>编号</td>
                       <td id="code"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>联系人姓名</td>
                       <td id="person"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>联系电话</td>
                       <td id="mobilephone"></td>
                   </tr>
               </table>
              
               <div class="clear"></div>
          </div>
     </div>
</div>
</body>
</html>