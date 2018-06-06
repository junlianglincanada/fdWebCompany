<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
  <%@ include file="../../include.jsp" %>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/distribute.output.output?newSearch=1">产出品</a> > <a href="#">新增产出品</a> </h3>
          <div class="info_tab">
               <a href="../findView/distribute.output.output-add" class="default">基本信息</a>
               <a href="#">图片信息</a>
          </div>
          <div class="info_box">
                <input type="button" class="btn_select" value="从采购品中选择" rel="popup" link="../findView/distribute.output.iframe-rep" title="从采购品中选择" />
                <form id="addForm" >
               <table class="info_mation" id="table">
                         <tr>
                       <td class="td_lf"><em class="star">*</em>名称</td>
                       <td><input id="name" type="text" class="input_code" name="name" value="" maxlength="50"/></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>产品分类</td>
                       <td>
                           <div id="typeGeneral" class="select_s" style="float:left;">
                             <div class="select_is">
                               <select id="selectqx"  class="select_cs" name="typeGeneral" style="color:gray;">	
                 
                               </select>
                             </div>
                          </div>
                       </td>
                   </tr>
            
                   <tr>
                       <td class="td_lf"><em class="star">*</em>规格</td>
                       <td><input id="spec" type="text" class="input_code" name="spec" value="" maxlength="20" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>生产单位</td>
                       <td><input type="text" class="input_code" maxlength="100" name="manufacture" value="" maxlength="20" /></td>
                   </tr>
                      <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>商品包装条码</td>
                       <td><input  type="text"  class="input_code" maxlength="13" id="" name="productionBarcode" value="" /></td>
                   </tr>
                      <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>企业编码</td>
                       <td><input  type="text" class="input_code" maxlength="50" id="code" name="code" value="" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>保质期</td>
                       <td>
                          <input type="text" class="input_code"  id="guaranteeValue" name="guaranteeValue"  value="" style="width:80px; margin-right:10px; float:left;" maxlength="10" />
                          <div class="select_s" style="width:70px; float:left;">
                            <div class="select_is" style="width:70px;">
                               <select id="selectDate" name="guaranteeUnit" class="select_cs" style="width:100px; background-position:-130px -122px;color:gray;">
                        
                               </select>
                             </div>
                          </div>
                       </td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>设为菜肴</td>
                       <td><input type="checkbox" class="check_open" name="isCuisine" value="1" id="isCuisine"/></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star" style="margin-right:10px;">&nbsp;</em>配料</td>
                       <td>
                          <input type="button" class="btn_assoc" value="关联进货原料" rel="popup" link="../findView/distribute.output.iframe-assoc" title="关联进货原料" /><br />
                          <div class="assoc_seltext">
                      
                          </div>
<!--                           <textarea class="textarea_code"></textarea> -->
                       </td>
                   </tr>
               </table>
               </form>
               <p class="save_box">
                  <input id="addFormSubmit" type="button" class="btn_save" value="保存" />
               </p>
               <div class="clear"></div>
          </div>
     </div>
</div>    

<script type="text/javascript">
var ajaxFlag=true;
$(function(){

   //删除进货原料
   $("i.i_del").live("click",function(){
	    $(this).parent("span.send_checked").remove();
	});
   
   
/*-------jquery end-------*/

//餐饮类型
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

	 $("#table").find(".text_ts").remove();
	 ajaxFlag=true;		
	   var name=$("#name").val().trim();
	   var spec=$("#spec").val().trim();
	   var type=$("#selectqx").val();
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
			$("#name").after('<span class="text_ts">产出品名称不能为空 </span>')
			ajaxFlag=false;
			return false;
		}
		
		if(spec==""||spec==null){
			$("#spec").after('<span class="text_ts">产出品规格不能为空 </span>')
			ajaxFlag=false;
			return false;
		}
		if(type==""||type==null){
			$("#typeGeneral").after('<span class="text_ts">产品分类不能为空 </span>')
			ajaxFlag=false;
			return false;
		}
// 		$("#spec").val(html_encode(spec));
		
 	var jdata = $("#addForm").serializeObject();//JSON.stringify($("#addForm").serializeArray());
 	console.log(jdata);
 	var isCuisine=jdata.isCuisine;
 	var  inputMatIdList=jdata.inputMatIdList;
 	if(isCuisine!=null&&isCuisine==1){
 		if(inputMatIdList==null || inputMatIdList.length==0){
 			$(".btn_assoc").after('<span class="text_ts">关联的采购品不能为空 </span>');
 			ajaxFlag=false;
			return false;
 		}
 	}
 	var inputMatIdListArray=new Array();
 	if(inputMatIdList instanceof Array){
 		
 	}else{
 		if(inputMatIdList!=null){
 			inputMatIdListArray[0]=inputMatIdList;
 	 	}
 		jdata.inputMatIdList=inputMatIdListArray;
 	}
 	
 	jdata = JSON.stringify(jdata);
 	if(!ajaxFlag){
		return false;
	}

     var options = {
         url: "../outputManage/outputMaterial/createOutputMaterial",
         headers: { 
             'Accept': 'application/json',
             'Content-Type': 'application/json' 
         },
         type: 'post',
         dataType: 'json',
         data:jdata,
         success: function (data) {
             if (data.status == 0){
              	var id=data.body.id;
             	$("#loading").hide();
             console.log(id);
             location.href="../findView/distribute.output.output-add-photo?id="+id;
             }else{
             	console.log(data.message);
            	$("#loading").hide();
      			 $("#addFormSubmit").attr("disabled",false);
      			$("#name").after('<span class="text_ts">'+data.message+'</span>')
            }
             },
        	 error:function(data) {
				console.log("error:");
				console.log(data);
				 $("#addFormSubmit").attr("disabled",false);
					$("#loading").hide();
				 }
				};
    
     $.ajax(options);
	 $("#addFormSubmit").attr("disabled",true);
	 $("#loading").show();
     return false;
 });

 
/*   function immediately(){
	 var element = document.getElementById("typeGeneral");
	 if("\v"=="v") {
	 element.onpropertychange = webChange;
	 }else{
	 element.addEventListener("input",webChange,false);
	 }
	 function webChange(){
		 var select = document.getElementById("selectqx");  
			select.value = element.value; 
	 	}
	 }; */

});	
</script>

</body>
</html>