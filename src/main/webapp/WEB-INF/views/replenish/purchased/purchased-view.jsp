<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<% 
 String id=request.getParameter("id"); 
%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="../../include.jsp" %>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.purchased.purchased?id=<%=id %>">采购品</a> > <a href="#">查看采购品</a> > <a id="name1"></a> 
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="编辑采购品" onClick="window.location.href='../findView/replenish.purchased.purchased-editor?id=<%=id %>'" />
              </div>
          </h3>
          <div class="info_tab">
               <a href="../findView/replenish.purchased.purchased-view?id=<%=id %>" class="default">基本信息</a>
                <a href="../findView/replenish.purchased.purchased-view-photo?id=<%=id %>">图片信息</a>
               <a href="../findView/replenish.purchased.purchased-view-supplier?id=<%=id %>">供过货的供应商</a>
          </div>
          <div class="info_box">
               <table class="info_mation">
         
                          <tr>
                       <td class="td_lf"><em class="star">*</em>名称</td>
						<td id="name"></td>
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
                       <td class="td_lf"><em class="star">&nbsp;</em>生产单位</td>
                       <td id="manufacture"></td>
                   </tr>
             
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>商品包装条码</td>
                       <td id="productionBarcode"></td>
                   </tr>
                     <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>企业编码</td>
                       <td id="code">商品包装条码</td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>保质期</td>
                       <td id="guarantee"></td>
                   </tr>
<!--                    <tr> -->
<!--                        <td class="td_lf"><em class="star" style="margin-right:10px;">&nbsp;</em>配料</td> -->
<!--                        <td>薄荷</td> -->
<!--                    </tr> -->
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
	url:"../inputManage/inputMaterial/getInputMaterialById/"+id,
	type:"get",
    headers: { 
    	  'X-CSRF-TOKEN': '${_csrf.token}',
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
	var inputMaterialInfo=text.body;
	var guaranteeUnit="";
	var guaranteeValue="";
	if(null!=inputMaterialInfo.guaranteeValue){
		guaranteeValue=inputMaterialInfo.guaranteeValue;
		guaranteeUnit=inputMaterialInfo.guaranteeUnitString;

	}
	var guarantee=guaranteeValue+guaranteeUnit;
	console.log(guarantee);
	document.getElementById("productionBarcode").innerHTML = inputMaterialInfo.productionBarcode;
	document.getElementById("typeGeneralValue").innerHTML = inputMaterialInfo.typeGeneralValue;
	document.getElementById("name").innerHTML = inputMaterialInfo.name;
	document.getElementById("spec").innerHTML = inputMaterialInfo.spec;
	document.getElementById("manufacture").innerHTML = inputMaterialInfo.manufacture;
	document.getElementById("code").innerHTML = inputMaterialInfo.code;
	document.getElementById("guarantee").innerHTML = guarantee;
	document.getElementById("name1").innerHTML = inputMaterialInfo.name;

}
</script>
	
</body>
</html>