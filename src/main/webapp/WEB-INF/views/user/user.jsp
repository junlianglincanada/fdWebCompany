<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%-- <%@ page session="false"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  --%>
  <% 
	String newSearch=request.getParameter("newSearch")==null?"":request.getParameter("newSearch");
	HttpSession Session = request.getSession();
	Object pageNo=1;
	Map<String, Object> paramMap=null;
	String personName="";
	if(newSearch.equals("")){
		pageNo=Session.getAttribute("pageNo")==null?"1":Session.getAttribute("pageNo");
		paramMap=Session.getAttribute("paramMap")==null?null:(Map<String, Object>)Session.getAttribute("paramMap");
		if(paramMap!=null&&null!=paramMap.get("personName")){
			personName=paramMap.get("personName").toString();
		}
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
  <%@ include file="../include.jsp" %>

  
<title>万达食品安全追溯系统</title>
</head>
<body>
<div id="loading"  style="position:absolute; top:50%; left:50%; margin:0 auto; height:300px; z-index: 888; display:none;"><img src="../img/loading.gif" ></div>

<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/user.user">用户管理</a>  
              <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="新增用户" onClick="window.location.href='../findView/user.user-add'" />   
              </div>
          </h3>
          <div class="query">
                                         
               <span><em>姓名：</em><input type="text" class="query_input" value="" name="personName" id="personName"  maxlength="20" placeholder="请输入姓名"/></span>
               <input type="button" class="btn_query" value="查询" />
          </div>
          <div class="table_box">
               <table class="table_list" >
                    <thead>
                       <tr>
                           <th style="width:40px">序号</th>                
                           <th style="width:60px">用户名</th>
                           <th style="width:40px">姓名</th>
                           <th style="width:40px">手机</th>
                          <!--  <th style="width:40px">电话</th> -->
                           <th style="width:40px">邮箱</th>
                          
						   <th style="width:40px">岗位</th>
						   <th>操作</th>
                       </tr>
                    </thead>
                    <tbody  id="aa">

                    </tbody>
                 </table>
                 <p class="paging_box">
                    <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                    <span class="paging_perv"><input type="button" value="<< 上一页" id="pre_page"></span>
                    <span class="paging_next"><input type="button" value="下一页 >>" id="next_page" /></span>
                    <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                    <span class="num_text" id="totalPage" >共<em></em>页</span>  
                    <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                    <span id="page_btn"><input type="button" class="paging_btn" value="确定"  ></span> 
                 </p>
                 <div class="clear"></div>
          </div>
     </div>
</div>    
 
<script type="text/javascript">
var totalPage;
var totalNum;
var pageSize=20;
var params = {"newSearch":"<%=newSearch%>"};
var pageNum=parseInt("<%=pageNo%>");
var personNameHistory="<%=personName%>";
var num;
var inputDate;

function search(pageNum){
	//$("#loading").show();
	var personNameCurrent =$("#personName").val();        //这里是查询的参数赋值
    params.personName=personNameCurrent;
	$.ajax({
	url: "../system/userMgr/queryLoginUser/"+pageNum+"/"+pageSize,
	
	type:"post",
    headers: { 
        'Accept': 'application/json',
        'Content-Type': 'application/json' 
    },
    dataType:'json',
	data:JSON.stringify(params),
	success:function(result) {
		
			page(result);
			var resultList=result.body.resultList;
			$("#aa").children().remove();
			//console.log(resultList);
			for(var i=0;i<resultList.length;i++){
				var num=(pageNum-1)*pageSize+i+1;
				var id=resultList[i].id;
				var username=isNullForTable(resultList[i].username);
				var personName=isNullForTable(resultList[i].personName);
				var mobilePhone=isNullForTable(resultList[i].mobilePhone);
				var phone=isNullForTable(resultList[i].phone);
				var email=isNullForTable(resultList[i].email);
				//var department=isnull(resultList[i].department);
				var jobRole=isNullForTable(resultList[i].jobRole);
				
				var $tr=$('<tr><td class="td_ser">'+num+'</td><td>'+username+'</td><td>'+personName+'</td><td>'+mobilePhone+'</td><td>'+email+'</td><td>'+jobRole+'</td><td class="td_opera"><a href="../findView/user.user-view?id='+id+'" class="btn_green">查看</a><a href="../findView/user.user-editor?id='+id+'" class="btn_green">编辑</a><a href="javascript:void(0)" class="btn_green" rel="popup" link="../findView/user.user-del?id='+id+'" title="提示">删除</a></td></tr>');
				if(i%2==0){
					$tr.addClass("even");
				}
				$("#totalPage em").text(totalPage);
				$("tbody").append($tr);
		    }
			
			$("#loading").hide();
		
	 },                               
	 error:function(text) {
		 alert("系统异常，查询失败！");
	 }
	});
}
$(function(){
	if(pageNum==null||pageNum==""){
		pageNum=1;
	}
	//document.getElementById("personName").value = personNameHistory;
 	//$(".query_input").val(personNameHistory);
	$("#personName").val(personNameHistory);
	search(pageNum);
	
	//上一页
	 $(".paging_perv").click(function(){
		if(pageNum==1){
			params.newSearch="1";
			search(pageNum);
		}else{
			$(".paging_box a").removeClass("default");
			pageNum +=-1;
			$("#page"+pageNum).addClass("default");
			params.newSearch="1";
			search(pageNum);
		}
	});
	//下一页
	$(".paging_next").click(function(){
		
		 console.log(pageNum+":test1");
		 console.log(totalPage+":test2");
		 if(pageNum<totalPage){
				$(".paging_box a").removeClass("default");
				pageNum +=1;
				$("#page"+pageNum).addClass("default");
				params.newSearch="1";
				search(pageNum); 
		 }else if(pageNum==totalPage){
			 params.newSearch="1";
			search(pageNum);
		}
	});
	    //点击首页查询数据
	    $(".paging_head").click(function(){
		    pageNum=1;
		    params.newSearch="1";
		    search(pageNum);
	    });
	   //点击尾页查询数据
		$(".paging_trailer").click(function(){
			pageNum=totalPage;
			params.newSearch="1";
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
					params.newSearch="1";
					search(pageNum);
				}else if(pageNum<1){
					pageNum=1;
					params.newSearch="1";
					search(pageNum);
				}else  if(pageNum>totalPage){
					pageNum=totalPage;
					params.newSearch="1";
					search(pageNum);
				}else{
					pageNum=parseInt(pageNum);
					params.newSearch="1";
					search(pageNum);	
				}
			}
			
		});
		//查询
		$(".btn_query").click(function(){
			$("tbody").children().remove();
			
			pageNum=1;
			params.newSearch="1";
			search(pageNum);
		});
	});
	
	function deleteLoginUser(id){
		if(username!=null){
			$.ajax({
				url:"../system/userMgr/deleteLoginUser/"+id,
				type:"get",
			    headers: { 
			        'Accept': 'application/json',
			        'Content-Type': 'application/json' 
			    },
			    dataType:'json',
				data:null,
				success:function(text) {
					
					if(text.status==0){
						  location.href="../findView/user.user";
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



</script>
	
</body>
</html>