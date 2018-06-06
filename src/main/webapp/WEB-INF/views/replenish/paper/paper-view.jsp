<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    
    String supplierId=request.getParameter("supplierId");

%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../../include.jsp" %>
<script src="../js/compatible.js" type="text/javascript"></script>	
<script src="../js/lhgcalendar/lhgcore.lhgcalendar.min.js" type="text/javascript"></script>
<script type="text/javascript">
var fileServer = "<%=fdWebFileURL%>";
var pageNum=1;
var params = {};
var pageSize=20;
var totalPage;
var endDate;
var startDate;
var supplierId="<%=supplierId%>"
var datas=[];
var foodPath="<%=fdWebFileURL%>"
function search(pageNum){
	
	/*--日历控件--*/				   
	   $('#date_stars').calendar({minDate:'#date_stars'});
	   $('#date_ends').calendar({minDate:'#date_stars'});
	  
	  //鼠标经过图片显示编辑
	  $(".ficate_img").live({
			 mouseenter:function(){
				  $(this).find("a.paper_shadow").show();        
			 }, mouseleave:function(){
				  $(this).find("a.paper_shadow").hide(); 
			}
	  });
	  
	  
	  
	
	params.supplierId=supplierId;
	params.startDate=startDate;
	params.endDate=endDate;
		//$("#loading").show();
		$.ajax({
			url:"../inputManage/inputReceipt/queryInputReceiptBySupperlierId/"+supplierId+"/"+pageNum+"/"+pageSize,
			
			type:"post",
			headers: { 
				'X-CSRF-TOKEN': '${_csrf.token}',
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			data:JSON.stringify(params),
			success:function(result) {
				$("#loading").hide();
				if(result.status==0){
					var list=result.body.resultList;
					$(".ficate_list").children().remove();
					console.log(list);
					for(var i=0;i<list.length;i++){
						var filePath=list[i].filePath;
						 filePath=fileServer+filePath;
						var id=list[i].id;
						var inputDate=list[i].inputDate;
						var dataId={"supplierId":supplierId,"id":id}
					    var str = jQuery.param(dataId);
						var li=$('<li><div class="ficate_img"><div class="pape_pic" rel="img"><img src='+filePath+' /></div><a href="replenish.paper.paper-editor?'+str+'" class="paper_shadow"><i></i><em>编辑</em></a></div><span>'+inputDate+'</span></li>');
					$(".ficate_list").append(li);
					}
				
				}
			},   
			error:function(e) {
				console.log(e);
			}
		});
}
$(function(){
		 
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
		//点击查询按钮查询数据
		$(".btn_aq").click(function(){
			startDate=$("#date_stars").val().trim();
			endDate=$("#date_ends").val().trim();
			params.startDate=startDate;
			params.endDate=endDate;
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
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/replenish.paper.paper">票据管理</a> > <a href="#">查看票据(上海华美饮料有限公司)</a> </h3>
          <div class="info_box">
               <div class="ficate">
                    <div class="query" style="width:800px; " >
                         <table class="query_table" >
                            <tr>
                                <td class="td_lf" style="width:80px;"><em class="star">*</em>进货日期</td>
                                <td>
                                    <div style=" height:27px; position:relative;">
                                         <input type="text" class="input_date" id="date_stars" value="" readonly="readonly" /> <em class="cross">-</em>
                                         <input type="text" class="input_date" id="date_ends" value="" readonly="readonly" />
                                         
                                    </div>
                                </td>
                                <td>
                                    <div style=" height:27px; position:relative;">
                                         <input type="button" class="btn_aq" id="btn_aq" value="查询" />
                                    </div>
                                </td>
                            </tr>
                          </table>  
                    </div>
                    <div class="ficate_con" style="width:800px;" >
                         <ul class="ficate_list">
                         </ul>
                      <div class="clear"></div>
                    </div>
               </div>
                  <p class="paging_box" style="text-align:left;padding-left:5%;">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px" id="paging_head"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" id="pre_page"></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" id="next_page" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" id="paging_trailer"></span>
                   <span class="num_text" id="totalPage" >共<em></em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:30px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <span id="page_btn"><input class="paging_btn" id="page_btn" type="button" value="确定" style="padding:3px 5px" ></span> 
                 </p>
               <div class="clear"></div>
          </div>
     </div>
</div>    
 
<script type="text/javascript">
$(function(){
   /*--日历控件--*/				   
   $('#date_stars').calendar({minDate:'#date_stars'});
   $('#date_ends').calendar({minDate:'#date_stars'});
  
  //鼠标经过图片显示编辑
  $(".ficate_img").live({
		 mouseenter:function(){
			  $(this).find("a.paper_shadow").show();        
		 }, mouseleave:function(){
			  $(this).find("a.paper_shadow").hide(); 
		}
  });
  
/*----jquery end-----*/	   
});
</script> 
  	
</body>
</html>