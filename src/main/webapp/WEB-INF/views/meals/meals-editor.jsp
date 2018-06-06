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
<style>
.sysel input.btn_shang {
    width: 260px;
    float: left;
}
</style>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
var params={};
var ajaxFlag=true;
var id="<%=id %>";
String.prototype.trimcode=function() { return this.replace(/(^,*)|(,*$)/g, ""); }
function search(){
	$("#loading").show();
	$.ajax({
		url:"../meal/groupMeal/getGroupMealById/"+id,
		type:"get",
		headers:{},
		success:function(result){
			if(result.status==0){
				console.log(result.body);
				var diningCompanyId=isnull(result.body.diningCompanyId);
				var diningCompanyName=isnull(result.body.diningCompanyName);
				var diningCompanyAddress=isnull(result.body.diningCompanyAddress);
				var diningCompanyContactPerson=isnull(result.body.diningCompanyContactPerson);
				var diningCompanyContactPhone=isnull(result.body.diningCompanyContactPhone);
				var groupMealDate=isnull(result.body.groupMealDate);
				var groupMealSeq=isnull(result.body.groupMealSeq);
				var diningCount=isnull(result.body.diningCount);
				var groupMealType=isnull(result.body.groupMealType);
				var foodSafeStaff=isnull(result.body.foodSafeStaff);
				var foodSafeStaffPhone=isnull(result.body.foodSafeStaffPhone);
				var outputCategory=isnull(result.body.outputCategory);
				var groupMealTypeDesc=isnull(result.body.groupMealTypeDesc);
				var outputCategoryDesc=isnull(result.body.outputCategoryDesc);
				$("#diningCompanyId").text(diningCompanyId);
				$("#diningCompanyName").val(diningCompanyName);
				$("#diningCompanyAddress").val(diningCompanyAddress);
				$("#diningCompanyContactPerson").val(diningCompanyContactPerson);
				$("#diningCompanyContactPhone").val(diningCompanyContactPhone);
				$("#date_meals").val(groupMealDate);
				$("input[name='radio_a'][value="+groupMealSeq+"]").attr("checked",true);
				$("input[name='radio_b'][value="+groupMealType+"]").attr("checked",true);
				$("#diningCount").val(diningCount);
				$("#foodSafeStaff").val(foodSafeStaff);
				$("#foodSafeStaffPhone").val(foodSafeStaffPhone);
				$("#groupMealTypeDesc").val(groupMealTypeDesc);
				$("#outputCategoryDesc").val(outputCategoryDesc);
				if(outputCategory!=""){
					var str=outputCategory.split(",");
					for(var i=0;i<str.length;i++){
						$("input[name='checkbox_c'][value="+str[i]+"]").attr("checked",true);
					}
				}
				$("#loading").hide();
			}
		},
		error:function(){
			alert("系统异常，查询失败");
		}
	});
}
$(function(){
	search();
	$(".btn_save").click(function(){
		ajaxFlag = true;
		params={};
		$(".text_ts").remove();
		var diningCompanyId=$("#diningCompanyId").text();
		var diningCompanyName=$("#diningCompanyName").val();
		var diningCompanyAddress=$("#diningCompanyAddress").val().trim();
		var diningCompanyContactPerson=$("#diningCompanyContactPerson").val().trim();
		var diningCompanyContactPhone=$("#diningCompanyContactPhone").val().trim();
		var groupMealDate=$("#date_meals").val();
		var groupMealSeq=$("#groupMealSeq").find("input:radio:checked").val();
		var diningCount=$("#diningCount").val().trim();
		var groupMealType=$("#groupMealType").find("input:radio:checked").val();
		var groupMealTypeDesc=$("#groupMealTypeDesc").val().trim();
		var outputCategory=$("#outputCategory").val();
		var outputCategoryDesc=$("#outputCategoryDesc").val().trim();
		var foodSafeStaff=$("#foodSafeStaff").val().trim();
		var foodSafeStaffPhone=$("#foodSafeStaffPhone").val().trim();
		if(diningCompanyName=="从收货商中选择单位"){
			$("#diningCompanyName").after('<span class="text_ts">必要信息不能为空</span>');
			ajaxFlag=false;
		}
		if(diningCount==0){
			$("#diningCount").parent().children().last().after('<span class="text_ts">用餐人数不能为0</span>');
			ajaxFlag=false;
		}
		$(".necessary").each(function(){
			var inputValue=$(this).val().trim();
			if(inputValue==""||inputValue==null){
				$(this).parent().find(".text_ts").remove();
				$(this).parent().children().last().after('<span class="text_ts">必要信息不能为空</span>');
				ajaxFlag=false;
			}
		});
		if(diningCompanyContactPhone!=""&&diningCompanyContactPhone!=null&&isMobilephone(diningCompanyContactPhone)==false&&isPhone(diningCompanyContactPhone)==false){
			$("#diningCompanyContactPhone").after('<span class="text_ts">请输入正确联系电话</span>');
			ajaxFlag=false;
		}
		if(foodSafeStaffPhone!=""&&foodSafeStaffPhone!=null&&isMobilephone(foodSafeStaffPhone)==false){
			$("#foodSafeStaffPhone").after('<span class="text_ts">请输入正确手机号码</span>');
			ajaxFlag=false;
		}
		$("input:text").each(function(){
			var inputValue=$(this).val();
			if(checkSpecificKey(inputValue)==false){
				$(this).parent().find(".text_ts").remove();
		    	$(this).parent().children().last().after('<span class="text_ts">请勿入特殊字符 </span>');
		    	ajaxFlag=false;
		    }
		})
		if(groupMealType=="63005"){
			if(groupMealTypeDesc==""){
				$("#groupMealTypeDesc").after('<span class="text_ts">其他信息不能为空</span>');
				ajaxFlag=false;
			}else{
				params.groupMealTypeDesc=groupMealTypeDesc;
			}
		}
		if($("input:checkbox:checked").length==0){
			$("#outputCategoryDesc").after('<span class="text_ts">必要信息不能为空</span>');
			ajaxFlag=false;
		}
		if($("input[name='checkbox_c'][value='64006']").is(":checked")){
			if(outputCategoryDesc==""){
				$("#outputCategoryDesc").after('<span class="text_ts">其他信息不能为空</span>');
				ajaxFlag=false;
			}else{
				params.outputCategoryDesc=outputCategoryDesc;
			}
		}
		var output="";
		$("#outputCategory").find("input:checkbox:checked").each(function(){
			var v=$(this).val();
			output+=v+",";
		});
		output=output.trimcode();
		params.id=id;
		params.diningCompanyId=diningCompanyId;
		params.diningCompanyName=diningCompanyName;
		params.diningCompanyAddress=diningCompanyAddress;
		params.diningCompanyContactPerson=diningCompanyContactPerson;
		params.diningCompanyContactPhone=diningCompanyContactPhone;
		params.groupMealDate=groupMealDate;
		params.groupMealSeq=groupMealSeq;
		params.diningCount=diningCount;
		params.groupMealType=groupMealType;
		params.outputCategory=output;
		params.foodSafeStaff=foodSafeStaff;
		params.foodSafeStaffPhone=foodSafeStaffPhone;
		console.log(params);
		if(!ajaxFlag){
			return false;
		}
		$("#loading").show();
		$(":button").attr("disabled",true);
		$.ajax({
			url:"../meal/groupMeal/updateGroupMeal",
			type:"post",
			data:JSON.stringify(params),
			dataType:"json",
			headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    success:function(result){
		    	$(":button").attr("disabled",false);
		    	if(result.status==0){
		    		$("#loading").hide();
			    	window.location.href="meals.meals";
		    	}else{
		    		alert(result.message);
		    		$("#loading").hide();
		    	}
		    },
		    error:function(){
		    	$(":button").attr("disabled",false);
		    	$("#loading").hide();
		    	alert("系统异常，保存失败！");
		    }
		})
	})
	/*--日历--*/				   		   
	$('#date_meals').calendar({format:'yyyy-MM-dd HH:mm',minDate:calDateByDay(-32), maxDate:calDateByDay(10)});
	$('.lcui_time').css({'display':'block'});
   
/*-------jquery end-------*/
});	
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title">
          <span>当前位置: </span><a href="meals.meals">团膳外卖登记</a> > <a href="javascript:void(0)">编辑团膳外卖登记</a>
	          <div class="btn_opera"> 
	          	<input type="button" class="btn_add" value="删除" rel="popup" link="meals.iframe-del?id=<%=id %>" title="提示" />
	          </div>
          </h3>
          <h4 class="per_title"><span>团膳用餐单位信息</span></h4>
          <div class="per_box">
               <table class="info_mation" style="width:auto;">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>名称<span id="diningCompanyId" style="display:none;"></span></td>
                       <td>
                           <div class="sysel">
                                <span class="text_sysel" style="display:none;"></span>
                                <input type="button" class="btn_shang" value="从收货商中选择单位" rel="popup" link="meals.iframe-unit" title="选择用餐单位" id="diningCompanyName"/>
                           </div>
                       </td>
                   </tr><tr>
                       <td class="td_lf"><em class="star">*</em>地址</td>
                       <td><input type="text" class="input_code necessary" value="" style="margin-right:10px;float:left;background-color:gray" id="diningCompanyAddress" maxlength="50"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>联系人</td>
                       <td><input type="text" class="input_code" value="" style="width:168px;margin-right:10px;float:left;background-color:gray" id="diningCompanyContactPerson" maxlength="10"></td>
                       </tr><tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>联系电话</td>
                       <td><input type="text" class="input_code" value="" style="width:168px;margin-right:10px;float:left;background-color:gray" id="diningCompanyContactPhone" maxlength="20" onkeyup="javascript:this.value=this.value.replace(/\D-/g,'')"></td>
                   </tr>
               </table>
          </div>
          <h4 class="per_title"><span>供餐点信息</span></h4>
          <div class="per_box">
               <table class="info_mation" style="width:auto;">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>供餐日期</td>
                       <td colspan="3"><input type="text" class="input_date necessary" id="date_meals" value="" readonly="readonly"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>餐次</td>
                       <td id="groupMealSeq">
                           <label><input type="radio" name="radio_a" checked="checked" value="62001"/> 早餐</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_a" value="62002"/> 中餐</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_a" value="62003"/> 晚餐</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_a" value="62004"/> 其它</label>
                       </td>
                       </tr><tr>
                       <td class="td_lf"><em class="star">*</em>用餐人数</td>
                       <td>
                           <input type="text" class="input_code necessary" value="" style="width:80px;margin-right:10px;float:left;" id="diningCount" maxlength="6" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')">
                           <span class="blues">人</span>
                       </td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>供餐方式</td>
                       <td colspan="3" id="groupMealType">
                           <label><input type="radio" name="radio_b" checked="checked" value="63001"/> 自助餐</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_b" value="63002"/> 桌餐</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_b" value="63003"/> 简单餐</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_b" value="63004"/> 每人份餐</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_b" value="63005"/> 其它</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <input type="text" class="input_code" value="" style="width:168px;" id="groupMealTypeDesc" maxlength="20">
                       </td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>配送品种</td>
                       <td colspan="3" id="outputCategory">
                           <label><input type="checkbox" name="checkbox_c" value="64001"/> 净菜</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="checkbox" name="checkbox_c" value="64002"/> 调理半成品</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="checkbox" name="checkbox_c" value="64003"/> 即食冷膳食</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="checkbox" name="checkbox_c" value="64004"/> 即食热膳食</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="checkbox" name="checkbox_c" value="64005"/> 即食果蔬</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="checkbox" name="checkbox_c" value="64006"/> 其它</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <input type="text" class="input_code" value="" style="width:168px;" id="outputCategoryDesc" maxlength="20">
                       </td> 
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>食品安全管理人员</td>
                       <td><input type="text" class="input_code necessary" value="" style="width:168px;" id="foodSafeStaff" maxlength="10"></td>
                       </tr><tr> 
                       <td class="td_lf"><em class="star">*</em>手机号</td>
                       <td><input type="text" class="input_code necessary" value="" style="width:168px;" id="foodSafeStaffPhone" maxlength="11" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')"></td>
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