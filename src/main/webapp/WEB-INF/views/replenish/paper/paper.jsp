<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
 <script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
 <link rel="Stylesheet" href="../js/jquery.autocomplete.css" />
 <script type="text/javascript">
 var pageNum=1;
 var params = {};
 var pageSize=20;
 var totalPage;
 var num;

 function search(pageNum){
		$("#loading").show();
		$.ajax({
		url: "../inputManage/inputReceipt/queryInputReceipt/"+pageNum+"/"+pageSize,
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
				page(result);
				var resultList=result.body.resultList;
				$("tbody").children().remove();
				console.log(resultList);
				for(var i=0;i<resultList.length;i++){
					var num=(pageNum-1)*pageSize+i+1;
					var id=resultList[i].id;
					var name=isNullForTable(resultList[i].name);
					var supplierId=isNullForTable(resultList[i].supplierId);
					var inputDate=isNullForTable(resultList[i].inputDate);
					var receiptCount=isNullForTable(resultList[i].receiptCount);									
	 		        var $tr=$("<tr><td class='td_ser'>"+num+"</td><td>"+name+"</td><td>"+receiptCount+"</td><td>"+inputDate+"</td><td class='td_ope'><a href='../findView/replenish.paper.paper-view?supplierId="+supplierId+"' class='btn_green'>查看</a></td></tr>");
					$tr.data("id",id);
 					if(i%2==0){
					$tr.addClass("even");
					}
 					$("#totalPage em").text(totalPage);
					$("tbody").append($tr);
					$("#paging_num").val(pageNum);
				};
			};
		 },   
		 error:function(text) {
		console.log(text.message);
		 }
		});
 }
	 $(function(){
		 		 		 
		 if(pageNum==null||pageNum==""){
				pageNum=1;
			}
		 search(pageNum);
		 
		 
		//使用autocomplete控件快速查询供应商
		 search(1);
			$("#supplierName").on("keyup", function(){
				var keyWords = $("#supplierName").val().trim(); 
				var Params={'name':keyWords};
					 $.ajax({
					  	 type:"post",
					  	  headers: { 
					  	 	        'Accept': 'application/json',
					  	 	        'Content-Type': 'application/json' 
					  	 	    },
					  	 	    dataType:'json',
					   			data:JSON.stringify(Params),
					   			url: "../inputManage/supplier/querySuppliersByName/"+pageNum+"/"+pageSize,
					   			success: function(data) {
					   				
					   				$('#supplierName').bind("input.autocomplete", function () {
			               							 $(this).trigger('keydown.autocomplete');
			           					 });
					   				$("#supplierName").autocomplete(data.body.resultList,{
					   					minChars: 0,
					   					width: 208,
					   					max:12,
					   					matchContains: true,
					   					autoFill: false,
					   					scroll: false,
					   					dataType: 'json',
					   					
					   					formatItem: function(row, i, max) {
					   						return  "<font color=green>" + row.name + "</font>" ;
					   					},
					   					formatMatch: function(row, i, max) {
					   						return row.name ;
					   					},
					   					formatResult: function(row) {
					   						return row.name;
					   					}
					   				}).result(function(event,data,formatted){
					   					
					   					//var supplierId=data.id;
					  					//if(supplierId!=null&&supplierId!=""){
					  					//	$("#supplierId").val(supplierId);
					  					//	modelId=supplierId;
					  					//	supplierName=$("#supplierName").val().trim();
					   					supplierId=data.id;
					   					$("#supplierId").val(supplierId);
					   		            //alert(data);
					  					//}
					   		        });
					   			},
					   			error: function(data) {
					   				alert("加载失败，请重试！");
					   				}
					   			});
					 });
		 
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
			//点击查询按钮查询数据
			$(".btn_query").click(function(){
				name2=$("#supplierName").val().trim();
				params.name=name2;
				pageNum=1;
				search(pageNum);
				//$("#loading").hide();
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
	 });
	 
 
 </script> 
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.paper.paper">票据管理</a> 
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="新增票据" onClick="window.location.href='../findView/replenish.paper.paper-add'" />
              </div>
          </h3>
          <div class="query">
               <span><em>供应商名称：</em>
               <input type="text" class="query_input" placeholder="请输入关键字选择供货商"  autocomplete="" id="supplierName" />
             
               </span>
               <input type="button" class="btn_query" value="查询" />
          </div>
          <div class="table_box">
               <table class="table_list">
                    <thead>
                       <tr>
                           <th>序号</th>
                           <th>供应商名称</th>
                           <th>票据数</th>
                           <th>最后一次进货</th>
                           <th>操作</th>
                       </tr>
                    </thead>
                    <tbody>
                    </tbody>
                 </table>
                  <p class="paging_box">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" id="pre_page"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" id="next_page" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em></em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <span id="page_btn"><input class="paging_btn" id="page_btn" type="button" value="确定" style="padding:3px 5px" ></span> 
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>    
 <script type="text/javascript">
$(function(){ 
   /*--输入搜索关键词控制--*/				   
    var availableTags = [
						 "上海华美饮料有限公司", 
						 "上海力华营销有限公司",
						 "上海耀剑农产品有限公司",
						 "上海新华农业信用合作社"
						 ];

    $("#supplier_name").autocomplete({
        source: availableTags
    });	
   
/*-------jquery end-------*/
});	
</script>	
</body>
</html>