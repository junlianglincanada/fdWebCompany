<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <%@ include file="../../include.jsp" %>
<title>万达食品安全追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
  
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.purchased.purchased?newSearch=1">采购品</a> > <a href="#">新增采购品</a> </h3>
          <div class="info_tab">
               <a href="../findView/replenish.purchased.purchased-add" class="default">基本信息</a>
               <a href="#">图片信息</a>
          </div>
          <div class="info_box">
                <form id="addForm" >
<!--                   <input id="productionBarcode" name="productionBarcode" value="" type="hidden"/> -->
                  <table class="info_mation" style="border-bottom:1px solid #dcdddd;" id="table">
                            <tr>
                       <td class="td_lf"><em class="star">*</em>名称</td>
                       <td><input  id="name" type="text" class="input_code" maxlength="50" name="name" value="" /></td>
                   </tr>
<!--                    <tr> -->
<!--                        <td class="td_lf"><em class="star">*</em>编码类型</td> -->
<!--                        <td> -->
<!--                            <label for="radio_c1"><input type="radio" id="radio_c1" name="radio_c" checked="checked" /> 商品包装条码</label> &nbsp;&nbsp;&nbsp;&nbsp; -->
<!--                            <label for="radio_c2"><input type="radio" id="radio_c2" name="radio_c"  /> 企业编码</label> -->
<!--                        </td> -->
<!--                    </tr> -->
<!--                    <tr class="tr-choose1"> -->
<!--                        <td class="td_lf"><em class="star">*</em>商品包装条码</td> -->
<%--                        <td><input id="barcode1" onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))" maxlength="13" type="text" style="color:gray;"  class="input_code" value="" placeholder="请输入13位条码"/></td> --%>
                       
<!--                    </tr> -->
<!--                    <tr class="tr-choose2"> -->
<!--                        <td class="td_lf"><em class="star">&nbsp;</em>企业编码</td> -->
<%--                        <td><input id="barcode2" onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\].]/g,''))" type="text" style="color:gray;" maxlength="13" class="input_code" value=""  placeholder="请输入内部条码"/></td> --%>

<!--                    </tr> -->
                   <tr>
                       <td  class="td_lf"><em class="star">*</em>产品分类</td>
                       <td >
		        	 
                           <div id="typeGeneral" class="select_s" style="float:left;">
            
                            <div  class="select_is">
                               <select class="select_cs" id="selectqx" name="typeGeneral">

                               </select>
                             </div>
                          </div>

                       </td>
                   </tr>
         
                   <tr>
                       <td class="td_lf"><em class="star">*</em>规格</td>
                       <td><input id="spec" type="text" class="input_code" maxlength="20" name="spec" value="" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>生产单位</td>
                       <td><input  type="text" class="input_code" maxlength="100" name="manufacture" value="" /></td>
                   </tr>
                    <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>商品包装条码</td>
                       <td><input  type="text" class="input_code" maxlength="13" id="" name="productionBarcode" value="" /></td>
                   </tr>
                      <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>企业编码</td>
                       <td><input  type="text" class="input_code" maxlength="50" id="code" name="code" value="" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>保质期</td>
                       <td>
                          <input type="text" maxlength="10" maxlength="13" class="input_code" id="guaranteeValue" name="guaranteeValue" value="" style="width:80px; margin-right:10px; float:left;"/>
                          <div class="select_s" style="width:70px; float:left;">
                            <div class="select_is" style="width:70px;">
                               <select id="selectDate" name="guaranteeUnit" class="select_cs" style="width:100px; background-position:-130px -122px;">

                               </select>
                             </div>
                          </div>
                       </td>
                   </tr>
                   <!-- <tr>  -->
                      <!-- <td class="td_lf"><em class="star" style="margin-right:10px;">&nbsp;</em>配料</td>  -->
                      <!-- <td><textarea class="textarea_code"></textarea></td>  -->
                  <!--  </tr>  -->
               </table>
               	 
               <p class="save_box">
                  <input id="addFormSubmit" type="submit" class="btn_save" value="保存" />
               </p>
                </form>
               <div class="clear"></div>
          </div>
     </div>
</div>    
 

<script type="text/javascript">
var addUrl = "../purchase/material/createMaterialInfo";
var ajaxFlag=true;
$(function(){

	//采购品类型
	$.ajax({
		url:"../inputManage/inputMaterial/getAllGeneralType",
	      headers: { 
              'Accept': 'application/json',
              'Content-Type': 'application/json' 
          },
		type: "get",
		data:"json",
		success:function(text){
			$("#selectqx").append("<option value=''>"+"选择类型"+"</option>");
			$.each(text,function(id,itemList){ 
				if(id!="9000"){
					$("#selectqx").append("<option value='"+id+"'>"+itemList+"</option>");
				}
			});		
		}
	}); 
	//日期单位
	$.ajax({
		url:"../outputManage/outputMaterial/getDateType",
	      headers: { 
              'Accept': 'application/json',
              'Content-Type': 'application/json' 
          },
		type: "post",
		data:"json",
		success:function(text){
			var data=text.body;
			$.each(data,function(id,itemList){ 
				$("#selectDate").append("<option value='"+id+"'>"+itemList+"</option>");
			});		
		}
	}); 

	//特殊字符验证
	$("body").on("blur","input[type='text']",function(){
 		$(this).siblings(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    }
	});
    $("#addFormSubmit").click(function () {
    	ajaxFlag=true;
    	$("#table").find(".text_ts").remove();
    	
//     	var productionBarcode="";
//      	var radio_c1=$('input[id="radio_c1"]:checked').val();
//      	if(null!=radio_c1){
//      		productionBarcode=$("#barcode1").val();
//      	}
//     	var radio_c2=$('input[id="radio_c2"]:checked').val();
//      	if(null!=radio_c2){
//      		productionBarcode=$("#barcode2").val();
//      	}
//     	if(productionBarcode==""||productionBarcode==null){
//     		if(document.getElementById("radio_c1").checked){
//     	  		$("#barcode1").after('<span class="text_ts">条形码不能为空 </span>')
//     			return false;
//     		}
    
//     	}
    	   var name=$("#name").val();
    	   var spec=$("#spec").val();
    	   var type=$("#selectqx").val();
    		//判断输入框是否含有特殊字符
    		$("body input[type='text']").each(function(){
		    var inputValue=	$(this).val();
		    if(checkSpecificKey(inputValue)==false){
		    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
		    	ajaxFlag=false;
		    	return false;
		    }
		});
    		//非空输入框非空验证
    		if(name==""||name==null){
    			$("#name").after('<span class="text_ts">采购品名称不能为空 </span>')
    			ajaxFlag=false;
    			return false;
    		}
    		if(spec==""||spec==null){
    			$("#spec").after('<span class="text_ts">采购品规格不能为空 </span>')
    			ajaxFlag=false;
    			return false;
    		}
    		if(type==""||type==null){
    			$("#typeGeneral").after('<span class="text_ts">产品分类不能为空 </span>')
    			ajaxFlag=false;
    			return false;
    		}
//     		$("#spec").val(html_encode(spec));
//      	$("#productionBarcode").val(productionBarcode);
    	var jdata = $("#addForm").serializeObject();//JSON.stringify($("#addForm").serializeArray());
    	jdata = JSON.stringify(jdata);
    	if(!ajaxFlag){
    		return false;
    	}
     	$("#loading").show();
        var options = {
            url: "../inputManage/inputMaterial/createInputMaterial",
            headers: { 
                'Accept': 'application/json',
                'Content-Type': 'application/json' 
            },
            type: 'post',
            dataType: 'json',
            data:jdata,
            success: function (data) {
                if (data.status == 0){
                	var id=data.body;
                console.log(id);
                location.href="../findView/replenish.purchased.purchased-add-photo?id="+id;
                }else{
                	console.log(data.message);
                	$("#loading").hide();
          			 $("#addFormSubmit").attr("disabled",false);
          			$("#name").after('<span class="text_ts">'+data.message+'</span>')
                }
                }
            ,
   		 error:function(text) {
   			 console.log("21313:"+text)
   			$("#loading").hide();
   			 $("#addFormSubmit").attr("disabled",false);
   		 }
        };
        $.ajax(options);
   	 $("#addFormSubmit").attr("disabled",true);
   	 $("#loading").show();
        return false;
    });
});


function insertTypeA(){
   var name=$("#name").val();
   var spec=$("#spec").val();
	//判断输入框是否含有特殊字符
	if(checkSpecificKey(name)==false||checkSpecificKey(spec)==false){
		alert("请勿输入特殊字符");
		return false;
	}
	//非空输入框非空验证
	if(name==""||name==null){
		$("#name").after('<span class="text_ts">采购品名称不能为空 </span>')
		ajaxFlag=false;
		return false;
	}
	if(spec==""||spec==null){
		$("#spec").after('<span class="text_ts">采购品规格不能为空 </span>')
		ajaxFlag=false;
		return false;
	}

}



</script>
	
</body>
</html>