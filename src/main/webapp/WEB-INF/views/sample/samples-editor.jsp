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
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
var id="<%=id %>";
var params={};
var ajaxFlag=true;
var i=1;

String.prototype.trimcode=function() { return this.replace(/(^,*)|(,*$)/g, ""); }
function check(obj){
	var v = $(obj).val();
	v= v.replace(/\D/g,'');
	$(obj).val(v);
}
function calDateByMonth(m){ 
    var now = new Date();
    var date=new Date(now.getTime()-1000*60*60*24*30*m);
    var year = date.getFullYear();       //年
    var month = date.getMonth() + 1;     //月
    var day = date.getDate();            //日
    var hour = date.getHours();
    var minutes = date.getMinutes();
    var clock = year + "-";
    if(month < 10)
        clock += "0";
    clock += month + "-";
    if(day < 10)
        clock += "0";
    clock += day + " ";
    if(hour < 10)
    	clock += "0";
    clock += hour + ":"
    if(minutes < 10)
    	clock += "0";
    clock += minutes;
    return(clock); 
} 
function changeType(){
	$("#indexTable tr:eq(3)").find(".text_ts").remove();
	var sampleType=$("#sampleType").find("input:radio:checked").val();
	if(sampleType=="53001"){
		$("#hide1").show();
		$(".blues").show();
		$("#count_text").html('<em class="star">&nbsp;</em>就餐人数');
		$("#hide2").hide();
		$("#way_text").html('&nbsp;');
	}else if(sampleType=="53002"){
		$("#hide1").show();
		$("#count_text").html('<em class="star">&nbsp;</em>配送数量');
		$("#hide2").hide();
		$("#way_text").html('&nbsp;');
		$(".blues").hide();
	}else if(sampleType=="53003"){
		$("#hide1").show();
		$(".blues").show();
		$("#count_text").html('<em class="star">&nbsp;</em>就餐人数');
		$("#way_input").show();
		$("#hide2").show();
		$("#way_text").html('<em class="star">&nbsp;</em>供餐方式');
	}else if(sampleType=="53004"){
		$("#count_text").html('&nbsp;');
		$("#hide1").hide();
		$("#hide2").hide();
		$("#way_text").html('&nbsp;');
	}
}
function search(){
	$("#loading").show();
	$.ajax({
		url:"../retentionSample/getSampleById/"+id,
		type:"get",
		headers:{},
		success:function(result){
			if(result.status==0){
				console.log(result.body);
				var sampleDate=isnull(result.body.sampleDate);
				var sampleMeal=isnull(result.body.sampleMeal);
				var sampleType=isnull(result.body.sampleType);
				var diningCount=isnull(result.body.diningCount);
				var cateringWay=isnull(result.body.cateringWay);
				var sampleDescription=isnull(result.body.sampleDescription);
				$("#date_samples").val(sampleDate);
				$("#diningCount").val(diningCount);
				$("#cateringWay").val(cateringWay);
				$("#sampleDescription").val(sampleDescription);
				$("input[name='radio_a'][value="+sampleMeal+"]").attr("checked",true);
				$("input[name='radio_b'][value="+sampleType+"]").attr("checked",true);
				if(sampleType=="53001"){
					$("#count_input").show();
					$(".blues").show();
					$("#count_text").html('<em class="star">&nbsp;</em>就餐人数');
					$("#way_input").hide();
					$("#way_text").html('&nbsp;');
				}else if(sampleType=="53002"){
					$("#count_input").show();
					$("#count_text").html('<em class="star">&nbsp;</em>配送数量');
					$("#way_input").hide();
					$("#way_text").html('&nbsp;');
					$(".blues").hide();
				}else if(sampleType=="53003"){
					$("#count_input").show();
					$(".blues").show();
					$("#count_text").html('<em class="star">&nbsp;</em>就餐人数');
					$("#way_input").show();
					$("#way_text").html('<em class="star">&nbsp;</em>供餐方式');
				}else if(sampleType=="53004"){
					$("#count_text").html('&nbsp;');
					$("#count_input").hide();
					$("#way_input").hide();
					$("#way_text").html('&nbsp;');
				}
				var samples=result.body.sampleDetailList;
				if(samples.length!=0){
					$("#detailTable").children().remove();
					for(var j=0;j<samples.length;j++){
						var sampleName=isnull(samples[j].sampleName);
						var sampleQty=isnull(samples[j].sampleQty);
						var sampleUnit=isnull(samples[j].sampleUnit);
						var $tr = $('<tr><td class="td_lf"><em class="star">&nbsp;</em>样品名称</td><td><div class="sele_box"><input type="text" class="input_sele" value="" id="category'+i+'" maxlength="20"><a href="javascript:void(0)" class="btn_sele" rel="popup" link="sample.iframe-category?id=category'+i+'" title="从产出品中选择">从产出品中选择</a></div></td> <td class="td_lf"><em class="star">&nbsp;</em>样品数量</td><td><input type="text" class="input_code" value="" style="width:40px; margin-right:10px; float:left;" maxlength="6" /><div class="select_s" style="width:50px; float:left;"><div class="select_is" style="width:50px;"><select class="select_cs" style="width:70px;background-position:-150px -122px;"><option value="50001">g</option><option value="50002">份</option></select></div></div><i class="i_type i_del" style="float:left;"></i></td></tr>');	
						$tr.find("input.input_sele").val(sampleName);
						$tr.find("input.input_code").val(sampleQty);
						$tr.find("select").val(sampleUnit);
						$tr.find("input.input_code").attr("onkeyup","check(this)");
						if(j==samples.length-1){
							$tr.find("i").removeClass("i_del").addClass("i_add");
						}
						i++;
						$("#detailTable").append($tr);
					}
				}
				$("#detailTable tr:eq(0) td:eq(0) em").text("*");
				$("#loading").hide();
			}
		},
		error:function(){
			alert("系统异常，查询失败");
		}
	});
}
$(function(){
	var today=calDateByMonth(0);
	$("#date_samples").val(today);
	search();
	$(".btn_save").click(function(){
		ajaxFlag = true;
		params={};
		$(".text_ts").remove();
		$(".necessary").each(function(){
			var inputValue=$(this).val().trim();
			if(inputValue==""||inputValue==null){
				$(this).parent().children().last().after('<span class="text_ts">必要信息不能为空</span>');
				ajaxFlag=false;
			}
		});
		if($("#diningCount").val().trim()=='0'){
			$("#count_input").after('<span class="text_ts">数量不能为0</span>');
			ajaxFlag=false;
		}
		var sampleDate=$("#date_samples").val();
		var sampleMeal=$("#sampleMeal").find("input:radio:checked").val();
		var sampleType=$("#sampleType").find("input:radio:checked").val();
		var diningCount=$("#diningCount").val().trim();
		var cateringWay=$("#cateringWay").val().trim();
		var sampleDescription=$("#sampleDescription").val().trim();
		params.id=id;
		params.sampleDate=sampleDate;
		params.sampleMeal=sampleMeal;
		params.sampleType=sampleType;
		params.sampleDescription=sampleDescription;
		var listInfo="";
		var n=0;
		var error="";
		$("#detailTable tr").each(function(){
			var qty=$(this).find("input.input_code").val().trim();
			var name=$(this).find("input.input_sele").val().trim();
			if(name!=""&&(qty==""||qty==0)){
				$(this).find(".text_ts").remove();
				error='样品数量不能为空或0';
				$(this).find("i").after('<span class="text_ts">' + error + '</span>');
				ajaxFlag=false;
			}
			if(name==""&&qty!=""&&qty!=0){
				$(this).find(".text_ts").remove();
				error='样品名称不能为空';
				$(this).find("i").after('<span class="text_ts">' + error + '</span>');
				ajaxFlag=false;
			}
			if(checkSpecificKey(qty)==false||checkSpecificKey(name)==false){
				$(this).find(".text_ts").remove();
				error='请勿输入特殊字符';
				$(this).find("i").after('<span class="text_ts">' + error + '</span>');
				ajaxFlag=false;
			}
			var unit=$(this).find("select").val();
			if(name!=""&&qty!=""&&qty!=0){
				n++;
				listInfo+=name+","+qty+","+unit+",";
			}
		});
		if(n==0){
			$("#detailTable tr:eq(0)").find(".text_ts").remove();
			if(error!=""){
				if($("#detailTable tr").length==1){
					$("#detailTable tr:eq(0)").find("i").after('<span class="text_ts">' + error + '</span>');
				}
			}else{
				$("#detailTable tr:eq(0)").find("i").after('<span class="text_ts">' + '请输入至少一个样品信息' + '</span>');
			}
			ajaxFlag=false;
		}
		if(checkSpecificKey(diningCount)==false){
			$("#diningCount").parent().children().last().after('<span class="text_ts">请勿输入特殊字符</span>');
			ajaxFlag=false;
		}
		params.diningCount=diningCount;
		if(checkSpecificKey(cateringWay)==false){
			$("#cateringWay").after('<span class="text_ts">请勿输入特殊字符</span>');
			ajaxFlag=false;
		}
		params.cateringWay=cateringWay;
		if(checkSpecificKey(sampleDescription)==false){
			$("#sampleDescription").parent().children().last().after('<span class="text_ts" style="margin-left:0px;">请勿输入特殊字符</span>');
			ajaxFlag=false;
		}
		listInfo=listInfo.trimcode();
		params.listInfo=listInfo;
		console.log(params);
		if(!ajaxFlag){
			return false;
		}
		$("#loading").show();
		$(":button").attr("disabled",true);
		$.ajax({
			url:"../retentionSample/updateSample",
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
			    	window.location.href="sample.samples";
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
   $('#date_samples').calendar({format:'yyyy-MM-dd HH:mm',minDate:calDateByDay(-32), maxDate:calDateByDay(10)});
   
	//点击复制输入框并操作
	$("i.i_add").live("click",function(){	
		var $tr = $('<tr><td class="td_lf"><em class="star">&nbsp;</em>样品名称</td><td><div class="sele_box"><input type="text" class="input_sele" value="" id="category'+i+'" maxlength="20"><a href="javascript:void(0)" class="btn_sele" rel="popup" link="sample.iframe-category?id=category'+i+'" title="从产出品中选择">从产出品中选择</a></div></td> <td class="td_lf"><em class="star">&nbsp;</em>样品数量</td><td><input type="text" class="input_code" value="" style="width:40px; margin-right:10px; float:left;" maxlength="6" /><div class="select_s" style="width:50px; float:left;"><div class="select_is" style="width:50px;"><select class="select_cs" style="width:70px;background-position:-150px -122px;"><option value="50001">g</option><option value="50002">份</option></select></div></div><i class="i_type i_add" style="float:left;"></i></td></tr>');	
		i++;
		$tr.find("input.input_code").attr("onkeyup","check(this)");
		var input_v1 = $(this).parent().parent().find("input.input_sele").val().trim();
		var input_v2 = $(this).parent().parent().find("input.input_code").val().trim();
		if(input_v1 == ""){
			$(this).siblings(".text_ts").remove();
			$(this).after('<span class="text_ts">' + '样品名称不能为空' + '</span>');
	    }else if(input_v2 == ""||input_v2 == 0){
	    	$(this).siblings(".text_ts").remove();
			$(this).after('<span class="text_ts">' + '样品数量不能为空或0' + '</span>');
	    }else {	
			$(this).removeClass("i_add").addClass("i_del");
			$(this).parent().parent('tr').after($tr.clone());
			$(".text_ts").remove();
		}  
	    return false;
    });
	
	$("i.i_del").live("click",function(){
	   $(this).parent().parent("tr").remove();
	   $("#detailTable tr:eq(0) td:eq(0) em").text("*");
       return false;
    });
/*-------jquery end-------*/
});	
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="sample.samples">留样登记</a> > <a href="javascript:void(0)">编辑留样登记</a> 
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="删除" rel="popup" link="sample.iframe-del?id=<%=id %>" title="提示" />
              </div>
          </h3>
          <h4 class="per_title"><span>基本信息</span></h4>
          <div class="per_box">
               <table class="info_mation" style="width:auto;" id="indexTable">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>留样日期</td>
                       <td><input type="text" class="input_date necessary" id="date_samples" value="" readonly="readonly"></td>
                       <td class="td_lf">&nbsp;</td>
                       <td>&nbsp;</td>
                   </tr>
                   <tr>
                   	   <td class="td_lf"><em class="star">*</em>留样餐次</td>
                       <td id="sampleMeal">
                           <label><input type="radio" name="radio_a" checked="checked" value="52001"> 早餐</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_a" value="52002"> 中餐</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_a" value="52003"> 晚餐</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_a" value="52004"> 其他</label>
                       </td>
                       <td class="td_lf">&nbsp;</td>
                       <td>&nbsp;</td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>留样类型</td>
                       <td id="sampleType">
                           <label><input type="radio" name="radio_b" checked="checked" value="53001" onchange="changeType()"> 食堂</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_b" value="53002" onchange="changeType()"> 集体配送</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_b" value="53003" onchange="changeType()"> 重大活动</label>&nbsp;&nbsp;&nbsp;&nbsp;
                           <label><input type="radio" name="radio_b" value="53004" onchange="changeType()"> 餐饮服务</label>
                       </td>
                       <td class="td_lf">&nbsp;</td>
                       <td>&nbsp;</td>
                   </tr>
                   <tr id="hide1">
                       <td class="td_lf"><span id="count_text"><em class="star">&nbsp;</em>就餐人数</span></td>
                       <td>
                           <span id="count_input"><input type="text" class="input_code" value="" style="width:80px;margin-right:10px;float:left;" id="diningCount" maxlength="6" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')">
                           <span class="blues">人</span></span>
                       </td>
                   </tr>
                   <tr id="hide2" style="display:none"> <td class="td_lf"><span id="way_text"></span></td>
                       <td><span id="way_input" style="display:none"><input type="text" class="input_code" value="" style="width:230px;margin-right:10px;float:left;" id="cateringWay" maxlength="50"">
                           </span></td></tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>留样说明</td>
                       <td colspan="3"><textarea class="textarea_code" id="sampleDescription" maxlength="200"></textarea><br/></td>
                   </tr>
               </table>
          </div>
          <h4 class="per_title"><span>样品信息</span></h4>
          <div class="per_box">
               <table class="info_mation" style="width:auto;" id="detailTable">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>样品名称</td>
                       <td>
                           <div class="sele_box">
                                <input type="text" class="input_sele" value="" id="category0" maxlength="20">
                                <a href="javascript:void(0)" class="btn_sele" rel="popup" link="sample.iframe-category?id=category0" title="选择产出品">从产出品中选择</a>
                           </div>
                       </td> 
                       <td class="td_lf"><em class="star">&nbsp;</em>样品数量</td>
                       <td>
                           <input type="text" class="input_code" value="" style="width:40px; margin-right:10px; float:left;" maxlength="6" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')"/>
                           <div class="select_s" style="width:50px; float:left;">
                            <div class="select_is" style="width:50px;">
                               <select class="select_cs" style="width:70px;background-position:-150px -122px;">
                                      <option value="50001">g</option>
                                      <option value="50002">份</option>
                               </select>
                             </div>
                           </div>
                           <i class="i_type i_add" style="float:left;"></i>
                       </td>
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