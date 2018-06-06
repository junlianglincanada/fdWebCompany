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
<title>万达食品安全追溯系统</title>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/distribute.output.output">产出品</a> > <a href="#">编辑产出品</a> >   <a id="name1"></a>
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="删除产出品" rel="popup" link="../findView/distribute.output.iframe-del?id=<%=id %>" title="提示" />
              </div>
          </h3>
          <div class="info_tab">
               <a href="../findView/distribute.output.output-editor?id=<%=id %>" class="default">基本信息</a>
               <a href="../findView/distribute.output.output-editor-photo?id=<%=id %>">图片信息</a>
          </div>
          <div class="info_box">
              <form id="saveForm" >
               <table class="info_mation">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>名称</td>
                       <td><input type="text" class="input_code" style="color:gray;" value="" id="name" name="name" maxlength="50"/></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>产品分类</td>
                       <td>
                           <div class="select_s" style="float:left;">
                            <div class="select_is">
                               <select id="selectqx"  name="typeGeneral" class="select_cs" style="color:gray;">
                        
                               </select>
                             </div>
                          </div>
<!--                           <div class="select_s" style="float:left;margin-left:10px;"> -->
<!--                             <div class="select_is"> -->
<!--                                <select class="select_cs" style="color:gray;"> -->
<!--                                       <option>小类1</option> -->
<!--                                       <option>小类2</option> -->
<!--                                       <option>小类3</option> -->
                                      
<!--                                </select> -->
<!--                              </div> -->
<!--                           </div> -->
                       </td>
                   </tr>
           
                   <tr>
                       <td class="td_lf"><em class="star">*</em>规格</td>
                       <td><input type="text" class="input_code" style="color:gray;" value="" id="spec" name="spec" maxlength="20" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>生产单位</td>
                       <td><input type="text" class="input_code" style="color:gray;" value="" id="manufacture" name="manufacture" maxlength="50"/></td>
                   </tr>
                                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>商品包装条码</td>
                       <td><input  type="text" class="input_code" maxlength="13" id="productionBarcode" name="productionBarcode" value="" /></td>
                   </tr>
                      <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>企业编码</td>
                       <td><input  type="text" class="input_code" maxlength="50" id="code" name="code" value="" /></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>保质期</td>
                       <td>
                          <input type="text" class="input_code" value=""  id="guaranteeValue" name="guaranteeValue" style="width:80px; margin-right:10px; float:left;color:gray" maxlength="10"/>
                          <div class="select_s" style="width:70px; float:left;">
                            <div class="select_is" style="width:70px;">
                               <select id="selectDate" name="guaranteeUnit"   class="select_cs" style="width:100px; background-position:-130px -122px;color:gray">
                                  
                               </select>
                             </div>
                          </div>
                       </td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>设为菜肴</td>
                       <td><input type="checkbox" class="check_open" value="1" name="isCuisine" id="isCuisine"/></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star" style="margin-right:10px;">&nbsp;</em>配料</td>
                       <td>
                          <input type="button" class="btn_assoc" value="关联进货原料" rel="popup" link="" title="关联进货原料" /><br />
                          <div class="assoc_seltext">
                          </div>
<!--                         
             <textarea class="textarea_code"></textarea> -->
                       </td>
                   </tr>
               </table>
               <p class="save_box">
                  <input id="id" name="id" value="" type="hidden"/>
                  <input id="saveFormSubmit" type="button" class="btn_save" value="保存" />
               </p>
                 </form>
               <div class="clear"></div>
          </div>
     </div>
</div>    
	<script type="text/javascript">
var id="<%=id %>";
var ajaxFlag=true;
$(document).ready(function () {
	$(".btn_assoc").click(function(){
		var ids="";
		$("input[name='inputMatIdList']").each(function(){
			ids+=$(this).val()+",";
		});
		$(".btn_assoc").attr("link","../findView/distribute.output.iframe-assoc?ids="+ids);
	})
	
	   //删除进货原料
	   $("i.i_del").live("click",function(){
		    $(this).parent("span.send_checked").remove();
		});
	   
	search(id);
	//特殊字符验证
	$("body").on("blur","input[type='text']",function(){
 		$(this).siblings(".text_ts").remove();
		var inputValue=	$(this).val();
	    if(checkSpecificKey(inputValue)==false){
	    	$(this).after('<span class="text_ts">请勿入特殊字符 </span>');
	    }
	});
	    $("#saveFormSubmit").click(function () {
	    	ajaxFlag=true;
	    	
	   	 $(".text_ts").remove();

		   var name=$("#name").val();
		   var spec=$("#spec").val();
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
				$("#name").after('<span class="text_ts">产出品名称不能为空 </span>')
				ajaxFlag=false;
				return false;
			}
			
			if(spec==""||spec==null){
				$("#spec").after('<span class="text_ts">产出品规格不能为空 </span>')
				ajaxFlag=false;
				return false;
			}
// 			$("#spec").val(html_encode(spec));
			
			
	    	var jdata = $("#saveForm").serializeObject();//JSON.stringify($("#addForm").serializeArray());
	     	var  inputMatIdList=jdata.inputMatIdList;
	     	var isCuisine=jdata.isCuisine;
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
	    	$("#loading").show();
	        var options = {
	            url: "../outputManage/outputMaterial/updateOutputMaterial",
	            headers: {                         
	                'Accept': 'application/json',
	                'Content-Type': 'application/json' 
	            },
	            type: 'post',
	            dataType: 'json',
	            data:jdata,
	            success: function (data) {
	                if (data.status == 0){
	                	$("#loading").hide();
	                location.href="../findView/distribute.output.output";
	                }else{
	                 	console.log(data.message);
	                	$("#loading").hide();
	          			 $("#saveFormSubmit").attr("disabled",false);
	          			$("#name").after('<span class="text_ts">'+data.message+'</span>')
	                }
	                }
	                	
	        };
	        $.ajax(options);
	        return false;
	    });




});

function search(id){
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
              test=text.body.typeGeneral;
              
          }
	 },   
	 error:function(text) {
	 }
	});
}

function show(text){
	var inputMaterialInfo=text.body;
	var guaranteeUnit="";
	if(null!=inputMaterialInfo.guaranteeUnit){
				if(inputMaterialInfo.guaranteeUnit==39003)
				guaranteeUnit="日";
				if(inputMaterialInfo.guaranteeUnit==39002)
			    guaranteeUnit="月";
			    if(inputMaterialInfo.guaranteeUnit==39001)
			    guaranteeUnit="年";
	}
	var guarantee=inputMaterialInfo.guaranteeValue+guaranteeUnit;

	$("#productionBarcode").val(inputMaterialInfo.productionBarcode);
	$("#code").val(inputMaterialInfo.code);
	$("#name").val(inputMaterialInfo.name);
	$("#spec").val(inputMaterialInfo.spec);
	$("#manufacture").val(inputMaterialInfo.manufacture);
	$("#guaranteeValue").val(inputMaterialInfo.guaranteeValue);
	$("#id").val(inputMaterialInfo.id);
	$("#typeGeneral").val(inputMaterialInfo.typeGeneral);
	var isCuisine= isnull(inputMaterialInfo.isCuisine);
	if(isCuisine==1){
		$("#isCuisine").attr("checked",true);
	}
	
	document.getElementById("name1").innerHTML = inputMaterialInfo.name;
	typeGeneral=inputMaterialInfo.typeGeneral;
	guaranteeUnit=inputMaterialInfo.guaranteeUnit;
	selectTypeGeneral(typeGeneral);
	selectDateUnit(guaranteeUnit);
	console.log(inputMaterialInfo);
	var inputMaterialList=inputMaterialInfo.inputMaterialList;
     if(null!=inputMaterialList&&inputMaterialList.length>0){
	  for(var i=0;i<inputMaterialList.length;i++){
//			  console.log("22":+$(selP[i]).text());
		  var selhtml = '<span class="send_checked" ><em>'+ inputMaterialList[i].name +'</em><input name="inputMatIdList" value="'+inputMaterialList[i].id+'" type="hidden" /><i class="i_del">X</i></span>';

		  $(document).find(".assoc_seltext").append(selhtml);		
	  }
}
	  }

//删除
function deleteInputMeaterial(id){
		if(id!=null){
			$.ajax({
				url:"../inputManage/inputMaterial/deleteInputMaterial/"+id,
				type:"get",
			    headers: { 
			        'Accept': 'application/json',
			        'Content-Type': 'application/json' 
			    },
			    dataType:'json',
				data:null,
				success:function(text) {
					if(text.status==0){
						  location.href="../findView/replenish.purchased.purchased";
					}
			       
				 },   
				 error:function(text) {
//			 		 setTimeout(function(){
//			 			 loading.hide();//隐藏遮罩
//			 		 },100);
					$("#table_jg").html("数据加载失败！！");	
				 }
				});
		}
	}
	
	function selectTypeGeneral(typeGeneral){
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
				$.each(text,function(id,itemList){
					if(id!="9000"){
					    console.log(typeGeneral);
						if(typeGeneral==id){
							$("#selectqx").append('<option selected="selected" value='+id+'>'+itemList+'</option>');
						}else{
							$("#selectqx").append("<option value='"+id+"'>"+itemList+"</option>");
						}
					}
				});		
			}
		}); 
	}
	
	function selectDateUnit(guaranteeUnit){
		//餐饮类型
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
				    console.log(guaranteeUnit);
				    console.log(data);
					if(guaranteeUnit==id){
						$("#selectDate").append('<option selected="selected" value='+id+'>'+itemList+'</option>');
					}else{
						$("#selectDate").append("<option value='"+id+"'>"+itemList+"</option>");
					}
					
				});		
			}
		}); 
	}
</script>
</body>
</html>