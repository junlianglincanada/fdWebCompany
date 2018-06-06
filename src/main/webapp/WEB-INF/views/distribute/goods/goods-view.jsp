<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp"%>	
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/distribute.goods.goods">收货商管理</a> > <a href="#">查看收货商</a> > <a id="name1"></a>
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="编辑收货商"  onClick="window.location.href='../findView/distribute.goods.goods-editor2?id=<%=id %>'" id="updateCompany"/>
              </div>
          </h3>
          <div class="info_tab">
               <a href="../findView/distribute.goods.goods-view?id=<%=id %>" class="default">基本信息</a>
               <a href="../findView/distribute.goods.goods-view-photo?id=<%=id %>" id="licensesImg">证照<em style="font-style:normal;position:relative;top:1px;letter-spacing:1px;">图</em>片</a>
          </div>
          <div class="info_box">
             <!-- <div class="assoc_unit">关联单位
                   <span class="lf_blue">已关联注册单位</span>
                   <span class="assoc_name" id="assoc_name"></span>
               </div> -->
               <table class="info_mation">
               	   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>已关联注册单位</td>
                       <td id="assoc_name"></td>
                   </tr>
               </table>
               <table class="info_mation" id="table2"></table>
				<table class="info_mation" id="table1" >
                   <tr>
                       <td class="td_lf"><em class="star">*</em>收货商名称</td>
                       <td id="companyName"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>单位地址</td>
                       <td id="companyAddress"></td>
                   </tr>
                    <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>收货商简称</td>
                       <td id="companyAbbreviation"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>编号</td>
                       <td id="number"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>联系人姓名</td>
                       <td id="name"></td>
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
<script type="text/javascript">
var id="<%=id %>";
//查询方法
function queryCompany(id){
	$("#loading").show();
	$.ajax({
		url:"../inputManage/receiver/getReceiverById/"+id,
		type:"get",
		success:function(result){
			console.log(result);
			if(result.status==0){
				document.getElementById("name1").innerHTML = result.body.name;
				var companyName=isnull(result.body.name);
				var address=isnull(result.body.contactAddress);
				var name=isnull(result.body.contactPerson);
			    var companyAbbreviation=isnull(result.body.nameAbbrev);
				var number=isnull(result.body.code); 
				var mobilephone=isnull(result.body.contactPhone);
				var bizCert=isnull(result.body.bizCertNum);
				var cateringCert=isnull(result.body.cateringCert);
				var foodCircuCert=isnull(result.body.foodCircuCert);
				var foodProdCert=isnull(result.body.foodProdCert);
				var assoc_name=isnull(result.body.linkedCompanyName);
				var linkCompanyId=isnull(result.body.linkedCompanyId);
				var foodBusinessCert=isnull(result.body.foodBusinessCert);
				if(linkCompanyId!=null){
					$("#licensesImg").attr("href","../findView/distribute.goods.goods-view-photo?id=<%=id%>&linkCompanyId="+linkCompanyId);
				}
				$("#assoc_name").text(assoc_name);
				$("#companyName").text(companyName);
				$("#companyAddress").text(address);
				$("#companyAbbreviation").text(companyAbbreviation);
				$("#number").text(number);
				$("#name").text(name);
				$("#mobilephone").text(mobilephone);
				if(bizCert!=""||cateringCert!=""||foodCircuCert!=""||foodProdCert!=""||foodBusinessCert!=""){
					if(foodProdCert!=""){
						var certType="食品生产许可证";
						var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span>'+certType+'</span><span style="margin-left:10px;">'+foodProdCert+'</span></td></tr>');
						$("#table2").append($tr);
					}
					if(foodCircuCert!=""){
						var certType="食品流通许可证";
						var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span>'+certType+'</span><span style="margin-left:10px;">'+foodCircuCert+'</span></td></tr>');
						$("#table2").append($tr);
					}
					if(cateringCert!=""){
						var certType="餐饮服务许可证";
						var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span>'+certType+'</span><span style="margin-left:10px;">'+cateringCert+'</span></td></tr>');
						$("#table2").append($tr);
					}
					if(bizCert!=""){
						var certType="工商营业执照";
						var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span>'+certType+'</span><span style="margin-left:10px;">'+bizCert+'</span></td></tr>');
						$("#table2").append($tr);
				    }
					if(foodBusinessCert!=""){
						var certType="食品经营许可证";
						var $tr=$('<tr><td class="td_lf">&nbsp;</td><td><span>'+certType+'</span><span style="margin-left:10px;">'+foodBusinessCert+'</span></td></tr>');
						$("#table2").append($tr);
					}
					$("#table2 tr:eq(0) td:eq(0)").html('<em class="star">&nbsp;</em>证件类型');
				}else{
					var $tr=$('<tr><td class="td_lf"><em class="star">&nbsp;</em>证件类型</td><td><span></span><span style="margin-left:10px;"></span></td></tr>');
					$("#table2").append($tr);
				}
				$("#table1 tr:eq(1) td:eq(0)").addClass("td_lf line");
				$("#table1 tr:eq(1) td:eq(1)").addClass("line");
					$("#loading").hide();
			}
		},
		error:function(){
			alert("系统异常,数据加载失败");
	    	$("#loading").hide();
		}
	});
}
$(function(){
	//页面加载完成执行查询
	queryCompany(id);
}); 
</script>	
</body>
</html>