<!DOCTYPE html>
<html>
<head>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<% 
 String id=request.getParameter("id"); 
%>
<meta charset="utf-8">
  <%@ include file="../../include.jsp" %>
<title>万达食品安全追溯系统</title>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/distribute.output.output">产出品</a> > <a href="#">查看产出品</a> > <a id="name1"></a> 
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="编辑产出品" onClick="window.location.href='../findView/distribute.output.output-editor?id=<%=id %>'" />
              </div>
          </h3>
          <div class="info_tab">
               <a href="../findView/distribute.output.output-view?id=<%=id %>" class="default">基本信息</a>
               <a href="../findView/distribute.output.output-view-photo?id=<%=id %>">图片信息</a>
          </div>
          <div class="info_box">
               <table class="info_mation">
          
                    <tr>
                       <td class="td_lf"><em class="star">*</em>名称</td>
                       <td  id="name"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>产品分类</td>
                       <td id="typeGeneralValue"></td>
                   </tr>
        
                   <tr>
                       <td class="td_lf"><em class="star">*</em>规格</td>
                       <td id="spec"></td>
                   </tr>
                   <tr>
                       <td class="td_lf">生产单位</td>
                       <td id="manufacture"></td>
                   </tr>
                  
                   <tr>
                       <td class="td_lf">商品包装条码</td>
                       <td id="productionBarcode"></td>
                   </tr>
                    <tr>
                       <td class="td_lf">企业编码</td>
                       <td id="code"></td>
                   </tr>
                   <tr>
                       <td class="td_lf">保质期</td>
                       <td id="guarantee"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>设为菜肴</td>
                       <td><input type="checkbox" class="check_open" value="1" id="isCuisine" disabled="disabled"/></td>
                   </tr>
                   <tr> 
                       <td class="td_lf">配料</td>  <!-- <em class="star" style="margin-right:10px;">&nbsp;</em> -->
                		<td ><div class="assoc_seltext"></div></td> 
                  </tr>
               </table>
              
               <div class="clear"></div>
          </div>
     </div>
</div>    
 
<script type="text/javascript">

var id="<%=id %>";

console.log(id);

$(document).ready(function () {

	search(id);
});

function search(id){
 	$("#loading").show();
	$.ajax({
	url:"../outputManage/outputMaterial/getOutputMaterialById/"+id,
	type:"get",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:null,
	success:function(text) {
          console.log(text.body);
          if(text.status==0){
              show(text);
          	$("#loading").hide();
          }
	 },   
	 error:function(text) {
	 }
	});
}

function show(text){
	var MaterialInfo=text.body;
	var guaranteeUnit="";
	var guaranteeValue="";
	if(null!=MaterialInfo.guaranteeValue){
		guaranteeValue=MaterialInfo.guaranteeValue;
		guaranteeUnit=MaterialInfo.guaranteeUnitString;
	}
	var guarantee=guaranteeValue+guaranteeUnit;

	document.getElementById("productionBarcode").innerHTML = MaterialInfo.productionBarcode;
	document.getElementById("typeGeneralValue").innerHTML = MaterialInfo.typeGeneralValue;
	document.getElementById("name").innerHTML = MaterialInfo.name;
	document.getElementById("spec").innerHTML = MaterialInfo.spec;
	document.getElementById("manufacture").innerHTML = MaterialInfo.manufacture;
	document.getElementById("code").innerHTML = MaterialInfo.code;
	document.getElementById("guarantee").innerHTML = guarantee;
	document.getElementById("name1").innerHTML = MaterialInfo.name;
	var isCuisine= isnull(MaterialInfo.isCuisine);
	if(isCuisine==1){
		$("#isCuisine").attr("checked",true);
	}
	if(MaterialInfo.inputMaterialList != null){
		for(var i=0;i<MaterialInfo.inputMaterialList.length;i++)
		{
			var selhtml = '<span class="send_checked" ><em>'+MaterialInfo.inputMaterialList[i].name+'</em></span>';

		  $(document).find(".assoc_seltext").append(selhtml);	
		}
	};
}
</script>
	
</body>
</html>