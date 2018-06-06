<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
var pageNum=1;
var totalPage;
var totalNum;
var pageSize=20;
var params = {};
var outputDate;
var outputMatName;
var supplierComName;
var datas=[];
var status;
var Params={};
function isNumber(number){
	var patrn=/^\d{1,6}(?:\.\d{1,2}|\.?)$/;
	flg = patrn.test(number);
	if (flg) {
		return true;
	}
	return false;
}
//查询自动收货
function search(pageNum){
	$("#loading").show();
	$("input[name='checkall']").attr("checked", false);
	$.ajax({
	url: "../inputManage/inputBatch/queryAutoReceive/"+pageNum+"/"+pageSize,
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params),
	success:function(result) {
		if(result.status==0){
			page(result);	
			var resultList=result.body.resultList;
			$("#body").children().remove();
			//console.log(resultList);
			for(var i=0;i<resultList.length;i++){
				var id=resultList[i].id;
				var outputDate=isnull(resultList[i].outputDate).split(" ")[0];
				var outputMatId=resultList[i].outputMatId;
				var outputMatName=isnull(resultList[i].outputMatName);
				var supplierComName=isnull(resultList[i].supplierComName);
				var spec=isnull(resultList[i].spec);
				var quantity=isnull(resultList[i].quantity);
				var productionDate=isnull(resultList[i].productionDate);
				var productionBatch=isnull(resultList[i].productionBatch);
				var code=isnull(resultList[i].code);
			    var $tr=$("<tr id="+id+"><td class='td_ser'><input type='checkbox' name='check'/></td><td class='td_ser'>"+((pageNum-1)*pageSize+i+1)+"</td><td>"+outputDate+"</td><td>"+code+"</td><td>"+outputMatName+"</td><td>"+supplierComName+"</td><td>"+spec+"</td><td style='text-align:center;'><input type='text' class='input_code' style='width:100px; height:25px;' value='"+quantity+"'  maxlength='8' /></td><td>"+productionDate+"</td><td>"+productionBatch+"</td></tr>");
				$tr.data("id",id);
				$tr.data("outputMatId",outputMatId);
				if(i%2==0){
					$tr.addClass("even");
				}
				$("#totalPage em").text(totalPage);
				$("#body").append($tr);
				$("#paging_num").val(pageNum);
		    };
			$("#loading").hide();
		};
		
	 },   
	 error:function(text) {

	 }
	});
}

//手动收货
function autoReceive(){
	$("#loading").show();
	console.log(datas);
	$.ajax({
		url: "../inputManage/inputBatch/createInputBatchOnAutoReceive",
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
				datas=[];
				alert("收货成功");
				search(pageNum);
			}
			else{
				alert("收货失败");
			}
			$(".btn_save").attr("disabled",false);
		 },   
		 error:function() {
			 alert("系统异常，收货失败！");
			 $(".btn_save").attr("disabled",false);
		 }
 });
}	

//手动拒收
function autoRelationReceive(){
	$("#loading").show();
	console.log(datas);
	$.ajax({
		url: "../inputManage/inputBatch/ignoreOutputBatchOnAutoReceive",
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
				datas=[];
				alert("拒收成功");
				search(pageNum);
			}
			else{
				alert("拒收失败");
			}
			$(".btn_refuse").attr("disabled",false);
		 },   
		 error:function() {
			 alert("系统异常，收货失败！");
			 $(".btn_refuse").attr("disabled",false);
		 }
 });
}	
//自动收货
function receiveAuto(){
	//console.log(Params);
	$.ajax({
	url:"../inputManage/inputBatch/switchAutoReceive",
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(Params),
	success:function(result){
		if(result.status==0){
			switcher=Params.switcher;
			//alert(switcher);
			 if(switcher==1){
					//alert(switcher);
					$(".hidden").children().hide();
					$("#centure").show();
					$("#autoButton").addClass("auto_on").removeClass("auto_off");
					
				}else{
					//alert(switcher);
					$("#centure").hide();
					$(".hidden").children().show();
					$("#autoButton").addClass("auto_off").removeClass("auto_on");
				}
			
		}
		else{
			alert("设置开关失败，请稍后再试");
		}
	},
	error:function() {
		 alert("系统异常，设置失败！");
	 }
    
	});
}
//获取该用户是否开启自动收货
function getStatus(){
	var a = Math.random();
	$.ajax({
	url:"../inputManage/inputBatch/getAutoReceiveStatus"+"?a="+a,
	type:"get",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
	success:function(result){
		if(result.status==0){
			//console.log(result);
			if(result.body==null){
			  status=0;
			}	
			else{
				status=result.body;
			}
		}
		//console.log(status);
		var switcher=status;
		//alert(switcher);
		if(switcher==1){
			//alert(switcher);
			$(".hidden").children().hide();
			$("#centure").show();
			$("#autoButton").addClass("auto_on").removeClass("auto_off");
			
		}else{
			//switcher==0;
			$("#centure").hide();
			$(".hidden").children().show();
			$("#autoButton").addClass("auto_off").removeClass("auto_on");
		}	
		/*  Params.switcher=switcher;
		//console.log(Params);
		receiveAuto(); 
		 */
		 
	},
	 error:function() {
		 alert("系统异常，收货失败！");
	 }
 });
}
$(function(){
	getStatus();
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
	search(pageNum);
	//点击上一页查询
	$(".paging_perv").click(function(){
		if(pageNum==1){
			search(pageNum);
		}else{
			$(".paging_box a").removeClass("default");
			pageNum +=-1;
			$("#page"+pageNum).addClass("default");
			search(pageNum);
		}
	});
	//点击下一页查询
	$(".paging_next").click(function(){
		if(pageNum==totalPage){
			search(pageNum);
		}else{
			$(".paging_box a").removeClass("default");
			pageNum +=1;
			$("#page"+pageNum).addClass("default");
			search(pageNum);
		}
	});
	//点击首页查询数据
	$(".paging_head").click(function(){
		pageNum=1;
		search(pageNum);
	});
	//点击尾页查询数据
	$(".paging_trailer").click(function(){
		pageNum=totalPage;
		search(pageNum);
	});
	//点击确定查询数据
	$("#page_btn").click(function(){
		var pageNO=$("#paging_num").val().trim();
		if(isNaN(pageNO)){
			return;
		}else{
			pageNum=$("#paging_num").val().trim();
			if(pageNum==null||pageNum==""||pageNum=="null"){
				pageNum=1;
				search(pageNum);
			}else if(pageNum<1){
				pageNum=1;
				search(pageNum);
			}else  if(pageNum>totalPage){
				pageNum=totalPage;
				search(pageNum);
			}else{
				pageNum=parseInt(pageNum);
				search(pageNum);	
			}
		}
		
	});
	//点击查询按钮查询数据
	$(".btn_query").click(function(){
		outputDate=$("#date_rece").val().trim();
		//alert(outputDate);
		supplierName =$("#supplierComName").val().trim();
		//alert(supplierName);
		outputMatName =$("#outputMatName").val().trim();
		//alert(outputMatName);
		params.outputDate=outputDate;
		params.supplierName=supplierName;
		params.outputMatName=outputMatName;
		pageNum=1;
		search(pageNum);
		
	});
	//点击收货按钮进行收货
	$(".btn_save").click(function(){
		var ajaxFlag=true;
     	$("input[name='check']:checked").each(function(){
			var params2={};
			var id=$(this).parent().parent().data("id");
			var quantity=isnull($(this).parent().parent().children('td').eq(7).children('input').val().trim());
			if(quantity==""||isNumber(quantity)==false){
				alert("请输入正确的数量<最大六位数值，小数最多两位>");
				ajaxFlag=false;
				return;
			}
			if(1*quantity<=0){
				alert("请输入正确的数量<最大六位数值，小数最多两位>");
				ajaxFlag=false;
				return;
			}
			params2.id=id;
			params2.quantity=quantity;
			datas.push(params2);
			
		});
		if(ajaxFlag==false){
			return;
		}
		if(ajaxFlag==true){
			if(datas!=null&&datas.length>0){
				$(".btn_save").attr("disabled",true);
				autoReceive();
			}else{
				alert("请选择要收货的产品");
			}
		}
		
	});	
	
	//点击拒收按钮进行拒收
	$(".btn_refuse").click(function(){
     	$("input[name='check']:checked").each(function(){
			var id=$(this).parent().parent().data("id");
			datas.push(id);
		});
			if(datas!=null&&datas.length>0){
				$(".btn_refuse").attr("disabled",true);
				autoRelationReceive();
			}else{
				alert("请选择要拒收/忽略的产品");
			}
	});	
	document.onkeydown = function(e) {
		//捕捉回车事件
		 var ev = (typeof event!= 'undefined') ? window.event : e;
		 if(ev.keyCode == 13 ) {
			 $(".btn_query").click();
		 };
	};
	   /*--日历--*/				   
	 $('#date_rece').calendar();
	   /*--表格全选单选特效--*/   
	     var $dou = $("input[name='checkall']");
		// var $sin = $("input[name='check']");
		 //checkbox全选控制
		 $dou.click(function(){       
		    if(this.checked){     
		    	$("input[name='check']").attr("checked", true); 
		        //alert(11);
		    }else{      
		    	$("input[name='check']").attr("checked", false);  
		       // alert(22);
		    }       
		  });	
		 //checkbox单击选中 			   
		/*  $("input[name='check']").click(function(){
		     $dou.attr('checked',$("input[name='check']").length==$("input[name='check']").filter(':checked').length); //用filter方法筛选出选中的复选框 判断是否全选
		     alert($("input[name='check']").length);
		     if($("input[name='check']:checked").length==10){
		    	 $("input[name='checkall']").attr("checked", true);
		     }else{
		    	 $("input[name='checkall']").attr("checked", false);
		     }
		  });    */
		  $(".table_list").on("click",function(){
			 var length=$("input[name='check']:checked").length;
			 var length2=$("input[name='check']").length;
			 if(length==length2){
				 $("input[name='checkall']").attr("checked", true);
			 }else{
				 $("input[name='checkall']").attr("checked", false);
			 }
		  });
				  
		 $("#autoButton").click(function(){
			    status++;
				$("#autoButton").val(status%2);
				//alert($("#autoButton").val());
				var switcher=$("#autoButton").val();	
				Params.switcher=switcher;
				//alert(switcher);
				receiveAuto();
			});
});
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con" style="min-height: 439px ">
          <h3 class="process_title">
          <span>当前位置: </span><a href="#">自动收货</a>
              <div class="btn_opera"> 
                   <a href="replenish.receive.automatic-set" class="btn_set">设置自动收货</a>
<!--                       <input type="button" class="btn_set" value="设置自动收货" onClick="window.location.href='replenish.receive.automatic-set'" /> -->
              </div>
           </h3>
          <div class="query">
              <table class="query_table" >
                  <tr>
                      <td class="td_lf" style="min-width:55px;text-align:center;">发货日期</td>
                      <td style="min-width:168px;"><input type="text" class="input_date" id="date_rece" value="" readonly="readonly" /></td>
                      <td class="td_lf" style="min-width:65px;text-align:center;">供应商名称</td>
                      <td style="min-width:168px;"><input type="text" class="input_code" id="supplierComName" value="" style="width:168px;" maxlength="100"/></td>
                       <td class="td_lf" style="min-width:55px;text-align:center;">产品名称</td>
                      <td style="min-width:168px;"><input type="text" class="input_code" id="outputMatName" style="width:168px;" value="" maxlength="50"/></td>
                       <td><input type="button" class="btn_query" value="查询" style="margin-left:15px; width: 74px"/></td>
                  </tr>
               </table>
          </div>
          <div class="table_box">
               <table class="table_list" style="min-width:890px;">
                    <thead>
                       <tr>
                           <th style="min-width:20px;"></th>
                           <th style="min-width:30px;">序号</th>                                         
                           <th style="min-width:80px;">发货日期</th>
                           <th style="min-width:80px;">产品编号</th>
                           <th style="min-width:70px;">产品名称</th>
                           <th style="min-width:168px;">供应商名称</th>
                           <th style="min-width:40px;">规格</th>
                           <th style="width:140px;">数量</th>
                           <th style="min-width:80px;">生产日期</th>
                           <th style="min-width:90px;">批次号</th>
                       </tr>
                    </thead>
                    <tbody id="body">
                </tbody>
                 </table>
                 <label class="check_all "> <input type="checkbox" name="checkall" /> 全选 </label>
                 <p class="save_box">
                    <input type="button" class="btn_save" value="收货" />
                    <input type="button" class="btn_refuse" value="拒收 / 忽略" />
                 </p>
                   <p class="paging_box">
                   <span  class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" ></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em>1</em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <input type="button" value="确定"  class="paging_btn" id="page_btn">
                 </p>
                 <div class="clear"></div>
          </div>
         </div>
     </div>
</div>   

</body>
</html>