<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
    String id=request.getParameter("id");
%>   
<!DOCTYPE html >
<html>
<head>
<meta charset=utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
//判断数据库的是否为空
function isnull(object){
	if(object==null||object=="null"||object==""){
		return "";
	}else{
		return object;
	}
}

function isNumber(number){
	var patrn=/^\d{1,6}(?:\.\d{1,2}|\.?)$/;
	flg = patrn.test(number);
	if (flg) {
		return true;
	}
	return false;
}
var ajaxFlag=false;
var ajaxCig=false;
var pageNum=1;
var totalPage;
var totalNum;
var pageSize=20;
<%-- var toUrl="../inputManage/inputBatch/searchInputBatchs/"+pageNum+"/"+pageSize; --%>
var params = {};
var par3={};
var par2={};
var inputDate;
var inputMatName;
var supplierName;
var typeGeneral;
function search(pageNum){
	$("#loading").show();
	$.ajax({
	url: "../inputManage/inputBatch/searchInputBatchs/"+pageNum+"/"+pageSize,
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params),
	success:function(result) {
		$("#loading").hide();
		if(result.status==0){
			var resultList=result.body.resultList;
			$("#body").children().remove();
			for(var i=0;i<resultList.length;i++){
				var id=resultList[i].id;
				var supplierId=resultList[i].supplierId;
				var inputMatId=resultList[i].inputMatId;
				var date= new Date();
				var inputDate=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
				var typeGeneral=isnull(resultList[i].typeGeneral);
				var inputMatName=isnull(resultList[i].inputMatName);
				var spec=isnull(resultList[i].spec);
				var manufacture=isnull(resultList[i].manufacture);
				var quantity=isnull(resultList[i].quantity);
				var productionDate = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
				var productionBatch=isnull(resultList[i].productionBatch);
				var supplierName=isnull(resultList[i].supplierName);
				var traceCode=isnull(resultList[i].traceCode);
      			var $tr=$("<tr><td class='td_ser'><input type='checkbox' name='check'/><span display: none;></span></td><td class='td_ser'>"+((pageNum-1)*pageSize+i+1)+"</td><td>"+inputMatName+"</td><td>"+spec+"</td><td>"+manufacture+"</td><td>"+supplierName+"</td><td><input type='text' class='input_code1' readonly='readonly' style='width:80px; height:25px;' value='"+inputDate+"' id='inputDate' /></td><td><input type='text' class='input_code2' style='width:80px; height:25px;' value='"+productionDate+"' id='productionDate' readonly='readonly' /></td><td><input type='text' class='input_code' style='width:100px;' value='"+productionBatch+"' id='productionBatch' /></td><td><input type='text' class='input_code' style='width:60px;' value='"+traceCode+"' id='traceCode' /></td><td><input type='text' class='input_code' style='width:60px;' value='"+quantity+"' id='quantity' maxlength='8'/></td></td></tr>");
				$tr.data("id",id);
				if(i%2==1){
					$tr.addClass("even");
				}
				$tr.data("supplierId",supplierId);
				$tr.data("inputMatId",inputMatId);
				
				$("#body").append($tr);
				/*--日历--*/				   
				$(".input_code1").calendar({minDate:calDateByDay(-32), maxDate:calDateByDay(10)});
				$(".input_code2").calendar();
				
			}
			
		}
	 },   
	 error:function(text) {
		 alert("系统异常，查询失败！");
		 $("#loading").hide();
	 }
	});
	
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
			$("#selectqx").append("<option value='-1'>"+"全部"+"</option>");
			$.each(text,function(id,itemList){
				if(id!=9000){
					$("#selectqx").append("<option value='"+id+"'>"+itemList+"</option>");
				}
			});			
		}
	}); 
	

}
//保存
function allAdd(datas){
	$("#loading").show();
	console.log(datas);
	$.ajax({
		url: "../inputManage/inputBatch/createInputBatch/",
		type:"post",
	    headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
		data:JSON.stringify(datas),
		success:function(result) {	
			$("#loading").hide();
			if(result.status==0){
				//alert("保存成功");			
				window.location.href="../findView/replenish.into.into-commonly";
			}else{
				alert("服务端异常,保存失败");
			}
		 },   
		 error:function() {
			 alert("系统异常，收货失败！");
		 }
	});
}

$(function(){
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
	search(pageNum);

	//点击查询按钮查询数据
	$("#query_btn").click(function(){
		
		var typeGeneral=$("#selectqx").val().trim();
		 var inputMatName =$("#inputMatName").val().trim();
		 var supplierName =$("#supplierName").val().trim();
		
		params.typeGeneral=typeGeneral;
		params.materialName=inputMatName;
		params.supplierName=supplierName;
		console.log(params);
		pageNum=1;
		search(pageNum);
		$("#loading").hide();
	});
	document.onkeydown = function(e) {
		//捕捉回车事件
		
		 var ev = (typeof event!= 'undefined') ? window.event : e;
		 if(ev.keyCode == 13 ) {
			 $(".query_btn").click();
		 }
		};	
		
		//点击保存按钮保存数据
		$(".btn_save").click(function(){
			var datas=[];
			var ajaxFlag=true;
			$("input[name='check']:checked").each(function(){
				var params3={};
				$(this).parent().parent().children('td').eq(10).children('input[type="text"]').css({'border':'1px solid gray'});
				var id1=$(this).parent().parent().data("supplierId");
				var id2=$(this).parent().parent().data("inputMatId");
				params3.supplierId=id1;
				params3.inputMatId=id2;
				var inputDate=$(this).parent().parent().children('td').eq(6).children('input').val();
				
				var manufacture=$(this).parent().parent().children('td').eq(4).html();
				var productionDate=$(this).parent().parent().children('td').eq(7).children('input').val();
			    var inputDate=new Date(inputDate.replace("-", "/").replace("-", "/")); 
		        var productionDate=new Date(productionDate.replace("-", "/").replace("-", "/"));
				if(inputDate<productionDate){
					alert("进货日期必须大于生产日期");
					ajaxFlag=false;
					return false;
				}
					params3.inputDate=inputDate; 
					params3.productionDate=productionDate;
								
				var spec=$(this).parent().parent().children('td').eq(3).html();
				var quantity=$(this).parent().parent().children('td').eq(10).children('input').val();
				if(quantity==""||quantity==null||isNumber(quantity)==false||1*(quantity)<=0){
					$(this).parent().parent().children('td').eq(10).children('input[type="text"]').css({'border':'1px solid red'});
					ajaxFlag=false;
					return false;
	         	}
	         		params3.quantity=quantity;
	         		
				var productionBatch=$(this).parent().parent().children('td').eq(8).children('input').val();	
				var traceCode=$(this).parent().parent().children('td').eq(9).children('input').val();
				params3.manufacture=manufacture;
				params3.spec=spec;
				params3.traceCode=traceCode;
				params3.productionBatch=productionBatch;
				datas.push(params3);
		});		
			if(ajaxFlag==false){
				return;
			}
			if(datas!=null&&datas.length>0){
				allAdd(datas);
			}else{
				alert("请选择进货！");
			}
		});
		  $(".table_list").on("click",function(){
				 var length=$("input[name='check']:checked").length;
				 var length2=$("input[name='check']").length;
				 if(length==length2){
					 $("input[name='checkall']").attr("checked", true);
				 }else{
					 $("input[name='checkall']").attr("checked", false);
				 }
			  });
					


});
</script>

</head>
<body>
<div class="main_box">
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.into.into">新增进货</a> </h3>
          <div class="info_tab">
               <a href="../findView/replenish.into.into">新增进货</a>
               <a href="../findView/replenish.into.into-commonly" class="default">常用进货</a>
          </div>
          <div class="query">
               <table class="query_table" style="min-width:890px;">
                  <tr>
                      <td class="td_lf" id="typeGeneral">产品分类</td>
                      <td>
                          <div class="select_s" style="width:182px;">
                            <div class="select_is" style="width:182px;">
                               <select class="select_cs" id="selectqx" name="typeGeneral" style="width:212px; background-position:-12px -122px; color:gray;">
                                   
                               </select>
                             </div>
                           </div>
                      </td>
                      <td class="td_lf" >产品名称</td>
                      <td><input type="text" class="input_code" id="inputMatName" value="" style="width:200px;" /></td>
                       <td class="td_lf">供应商名称</td>
                      <td><input type="text" class="input_code" style="width:168px;" value="" id="supplierName"/></td>
                  </tr>
               </table>
               <p class="query_btn" id="query_btn"><input type="button" class="btn_query" value="查询" /></p>
          </div>
          <div class="table_box">
               <table class="table_list" style="min-width:890px; ">
                    <thead>
                       <tr>
                           <th></th>
                           <th style="min-width:40px">序号</th>                                         
                           <th style="min-width:90px">产品名称</th>
                           <th style="min-width:30px">规格</th>
                           <th style="min-width:90px">生产单位</th>
                           <th style="min-width:90px">供应商名称</th>
                           <th style="min-width:65px">进货日期</th>
                           <th style="min-width:65px">生产日期</th>
                           <th style="min-width:60px">批次号</th> 
                           <th style="min-width:60px">追溯码</th>
                           <th style="min-width:40px">数量</th>

                       </tr>
                    </thead>
                    <tbody id="body">
                     
                              
                    </tbody>
                 </table>
                 <label class="check_all"> <input type="checkbox" name="checkall"/> 全选 </label>
                 <p class="save_box">
                    <input type="button" class="btn_save" value="保存" />
                 </p>
                 <!--  
                 <p class="paging_box">
                   <span class="paging_perv"><input type="button" value="<< 上一页"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                 </p>
                 -->
                 <div class="clear"></div>
          </div>
     </div>
</div>    
 

<script type="text/javascript">
$(function(){
   /*--表格全选单选特效--*/   
 $dou = $("input[name='checkall']");
 $sin = $("input[name='check']");
 //checkbox全选控制
 $dou.click(function(){       
    if(this.checked){     
    	$("input[name='check']").attr("checked", true); 
    }else{           
    	$("input[name='check']").attr("checked", false);     
    }       
  });	
 //checkbox单击选中 			   
  $sin.click(function(){
     $dou.attr('checked',$("input[name='check']").length==$("input[name='check']").filter(':checked').length); //用filter方法筛选出选中的复选框 判断是否全选
  });
 
   
/*-------jquery end-------*/
});	




</script>
	
</body>
</html>