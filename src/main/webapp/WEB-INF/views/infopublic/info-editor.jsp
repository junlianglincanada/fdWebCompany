<%@page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>上海市餐饮食品安全信息追溯系统</title>
<%@ include file="../include.jsp"%>
<script src="../js/jquery.mark.min.js" type="text/javascript"></script>
<style type="text/css">
#fdl_list li.error{font-size:14px;color:red;text-align:center;border-bottom:none;padding-top:20px}  
span.highlight{color:rgba(240,131,0,1);}
.per_pic div{width: 100%; height: 100%;}
</style>
</head>
<body>
<div class="main_box" style='padding: 12px 10px 0 5px'>
     <div class="main_con" >
          <h3 class="process_title"><span>当前位置: </span><a href="infopublic.info">信息公示</a> > <a href="javascript:void(0)">编辑</a> </h3>
          <div class="info_box">
               <div class="shop_for">
                    <h4 class="info_tit">店招（店名）</h4>
                    <h5 class="info_text"><%-- <%=SecurityUtils.getCurrentUserNameAbbrev()%> --%></h5>
                    <a href="javascript:void(0);" rel="findView/system.account.account-editor" my_href="qyxx"  class="btn_infoEditor">去维护</a>
               </div>
               <div class="shop_for sf_lf">
                    <h4 class="info_tit">许可证</h4>
                    <div class="info_pic">
                        <div class="pic_inner">
                             <div class="pic_tent" id="img_div">
                                  <div class="nopic" id="no_img"><i class="i_pic"></i><span>无图片</span></div>                               
                             </div>
                        </div>      
                    </div>
                    <div class="pic_text">请至系统管理-企业信息-证照图片<a href="javascript:void(0);" my_href="qyxx"  class="btn_infoEditor" id="editor-photo">去维护</a></div>
               </div>
               <div class="shop_for sf_rt">
                    <h4 class="info_tit">主要岗位人员公示</h4>
                    <div class="person">
                         <ul class="per_list">
                             <li id="user1">
                                <div class="per">
                                     <a href="javascrpt:void(0)" class="per_ck" rel="popup" link="infopublic.iframe-user?id=user1" title="选择用户" style="display:block;">
                                          <i class="i_ck"></i>
                                          <span>点击选择人员</span>
                                     </a>
                                     <div class="per_pic" style="display:none;">
                                          <div rel="img"><img src=""></div>
                                          <a href="javascript:void(0)" class="del_pic" title="删除"></a>
                                     </div>
                                </div>
                                <h4></h4>
                                <p>经理</p>
                             </li>
                             <li id="user2">
                                <div class="per">
                                     <a href="javascrpt:void(0)" class="per_ck" rel="popup" link="infopublic.iframe-user?id=user2" title="选择用户" style="display:block;">
                                          <i class="i_ck"></i>
                                          <span>点击选择人员</span>
                                     </a>
                                     <div class="per_pic" style="display:none;">
                                          <div rel="img"><img src=""></div>
                                          <a href="javascript:void(0)" class="del_pic" title="删除"></a>
                                     </div>
                                </div>
                                <h4> </h4>
                                <p>食品安全负责人</p>
                             </li>
                             <li id="user3">
                                <div class="per">
                                     <a href="javascrpt:void(0)" class="per_ck" rel="popup" link="infopublic.iframe-user?id=user3" title="选择用户" style="display:block;">
                                          <i class="i_ck"></i>
                                          <span>点击选择人员</span>
                                     </a>
                                     <div class="per_pic" style="display:none;">
                                          <div rel="img"><img src=""></div>
                                          <a href="javascript:void(0)" class="del_pic" title="删除"></a>
                                     </div>
                                </div>
                                <h4> </h4>
                                <p>厨师长</p>
                             </li>
                             <li id="user4">
                                <div class="per">
                                     <a href="javascrpt:void(0)" class="per_ck" rel="popup" link="infopublic.iframe-user?id=user4" title="选择用户" style="display:block;">
                                          <i class="i_ck"></i>
                                          <span>点击选择人员</span>
                                     </a>
                                     <div class="per_pic" style="display:none;">
                                          <div rel="img"><img src=""></div>
                                          <a href="javascript:void(0)" class="del_pic" title="删除"></a>
                                     </div>
                                </div>
                                <h4> </h4>
                                <p>采购负责人</p>
                             </li>
                         </ul>
                    </div>
                    <div class="pic_text">维护人员姓名、照片信息请到从业人员模块<a href="javascript:void(0);" rel="findView/restEmployee.restEmployeeView?newSearch=1" my_href="cyry"  class="btn_infoEditor">去维护</a></div>
               </div>
               <div class="shop_for fd_con">
                    <h4 class="info_tit">食材追溯</h4>
                    <div class="fd_tent">
                        <div class="fd_lf">
                            <div class="fdl_query">
                                <input type="text" id="input_code" class="input_code" style="width:63%;float:left;margin-left:10px;"  />
                                <input type="button" class="btn_aq" value="查询" onClick="searchList()" />
                            </div>
                            <div class="pic_text">找不到所需食材，请新增采购品<a href="javascript:void(0);" rel="findView/replenish.purchased.purchased?newSearch=1" my_href="cgp" class="btn_infoEditor">去新增</a></div>
                            <div class="fdl_con">
                                <ul class="fdl_list" id="fdl_list">
                                </ul>
                            </div>
                        </div>
                        <div class="fd_rt">
                            <!-- <div class="fdr_error">
                                <i class="i_error"></i>
                                <p class="error_text">1、未选择公示食材时，默认公示近一个月的全部进货台账。<br>2、选择后只公示已选食材的最新一笔进货台账。</p>
                            </div> -->
                            <h5 class="fdr_text">
                                <span>已选择公示食材</span><i class="i_len">0</i>
                                <a class="btn_empty" id="btn_empty">清空</a>
                            </h5>
                            <div class="fdr_con">
                                <ul class="fdr_list" id="fdr_list">
                                </ul>
                            </div>
                        </div>
                    </div>
               </div>

          </div>
                <input type="button" onclick="window.location.href='infopublic.info'" class="btn_save" style="margin: 10px 0 5px 43%; width:60px;height: 30px;font:icon;"value="查看">
     </div>     
</div>    

<script type="text/javascript">
var imageTypes=["COM_GSYYZZ","COM_SPLTXKZ","COM_SPSCXKZ","COM_CYFWXKZ","COM_SPJYXKZ"];
var options = {
        "className": "highlight"
};
//食材-查询
function searchList(){    
	$("#loading").show();
	var keyword=$("#input_code").val().trim();
	$.ajax({
		url:"../monitor/getInputMatName",
		type:"post",
		dataType:"json",
	    data:{"keyword":keyword},
		success:function(result){	
			$("#loading").hide();
 			if(result.status==0){
 				$("#fdl_list").empty();
 				var list=result.body;
 				if(list.length>0){
 	 				var i_jia="",li ="",inputMatName="";
 	 				var m_name="";
 			     for(var i = 0; i < list.length;i++ ){ //for循环
 			    	 inputMatName=isnull(list[i].inputMatName)
 			    	  i_jia="i_jia";
 			    	 if(list[i].flag==1||list[i].flag=="1") {
 			    		i_jia="i_jian";
 			    	 }
 			    	li+='<li><p>'+inputMatName+'</p><i class='+i_jia+'></i></li>';
 			     } 
 			     $("#fdl_list").append(li);
 			     if(keyword!=""){
 				     $("#fdl_list").mark(keyword, options);     	 
 			     }		
 				}
			}else{
				alert("系统异常,食材查询失败!!!");
			}	
		}
	});
}
//公示食材-查询
function getDisplayInputMat(){    
	$.ajax({
		url:"../monitor/getDisplayInputMat",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
		type:"post",
		dataType:"json",
		success:function(result){	
 			if(result.status==0){
 				$("#fdr_list").empty();
 				var list=result.body;
 				var i_jia="",li ="",inputMatName="";
 				if(list.length>0){
 				     for(var i = 0; i < list.length;i++ ){ //for循环
 				    	 inputMatName=isnull(list[i].inputMatName)
 				    	li+='<li><p>'+inputMatName+'</p><i class="i_jian" fdr='+list[i].id+'></i></li>';
 				     } 
 				     $("#fdr_list").append(li);
 				     $(".i_len").text(list.length)
 				}else{
 					$(".i_len").text(0);
 					// $("#fdr_list").empty().append("<li> style='font-size:14px;color:red;text-align:center;'>未查到相关数据！</li>"); 
 				}
	
			}else{
				alert("系统异常,食材查询失败!!!");
			}	
		}
	});
}

//公示食材删除1
$("#fdr_list").on("click","i.i_jian",function(){
	var im_id=$(this).attr("fdr");
	var obj=$(this);
	 $.ajax({
			url:"../monitor/deleteDisplayInputMaterial/"+im_id,
			type:"post",
			headers: { 
				'X-CSRF-TOKEN': '${_csrf.token}',
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			async: false,
			success:function(result) {
				if(result.status!=0){
				alert("系统异常,删除失败!!!");
				}else{
					obj.parent("li").remove();
					$(".i_len").text(parseInt($(".i_len").text())-1)
					var m_name=obj.prev("p").text();
					var fdl_list_p=$("#fdl_list").find("p");
					for(var i=0;i<fdl_list_p.length;i++){
						var p_text=$(fdl_list_p[i]).text();
						if(m_name==p_text){
							$(fdl_list_p[i]).next("i").removeClass("i_jian").addClass("i_jia");
						}
					};
				}
			}
		});
});

//批量公示食材删除
$("#btn_empty").click(function(){
	 $.ajax({
			url:"../monitor/deleteDisplayInputMaterials",
			type:"post",
			headers: { 
				'X-CSRF-TOKEN': '${_csrf.token}',
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			async: false,
			success:function(result) {
				if(result.status!=0){
				alert("系统异常,删除失败!!!");
				}else{
					$("#fdr_list").empty();
					$(".i_len").text(0);
					$("#fdl_list").find(".i_jian").removeClass("i_jian").addClass("i_jia");
				}
			}
		});
});

//公示食材删除2
$("#fdl_list").on("click","i.i_jian",function(){
	var obj=$(this);
	var im_name=$(this).prev("p").text();
	var fdr_list_p=$("#fdr_list").find("p");
	var im_id="";
	var obj_fdr_i;
	
	for(var i=0;i<fdr_list_p.length;i++){
		var p_text=$(fdr_list_p[i]).text();
		if(im_name==p_text){
			obj_fdr_i=$(fdr_list_p[i]);
			im_id=$(fdr_list_p[i]).next("i").attr("fdr");
		}
	};
	if(im_id==""){
		return;
	}
	 $.ajax({
			url:"../monitor/deleteDisplayInputMaterial/"+im_id,
			type:"post",
			headers: { 
				'X-CSRF-TOKEN': '${_csrf.token}',
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			async: false,
			success:function(result) {
				if(result.status!=0){
				alert("系统异常,删除失败!!!");
				}else{
					obj_fdr_i.parent("li").remove();
					obj.removeClass("i_jian").addClass("i_jia");
					$(".i_len").text(parseInt($(".i_len").text())-1)
				}
			}
		});
});
//公示食材添加
$("#fdl_list").on("click","i.i_jia",function(){
	var im_name=$(this).prev("p").text();
	var obj=$(this);
	 $.ajax({
			url:"../monitor/addDisplayInputMaterial",
			type:"post",
			data:JSON.stringify({"inputMatName":im_name}),
			headers: { 
				'X-CSRF-TOKEN': '${_csrf.token}',
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			async: false,
			success:function(result) {
				if(result.status!=0){
				alert("系统异常,添加失败!!!");
				}else{
					obj.removeClass("i_jia").addClass("i_jian");
			    	 $("#fdr_list").append('<li><p>'+im_name+'</p><i class="i_jian" fdr='+result.body+'></i></li>');
					$(".i_len").text(parseInt($(".i_len").text())+1);
				}
			}
		});
});


	
	//从业人员岗位查询
function search_emp(){
	$.ajax({
		url:"../monitor/queryEmpInfo",
		type:"post",
		dataType:"json",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
		success:function(result){	
 			if(result.status==0){
 				var _li=$(".per_list li");
 				var list=result.body;
 				for(var i=0;i<list.length;i++){
 	 				for(var j=0; j<_li.length;j++){
 	 					var $li=$(_li[j]);
 	 					var web_jobRole=$li.find("p").text();
 	 					if(isnull(list[i].jobRole)!=""&&isnull(list[i].jobRole)==web_jobRole){
 	 						$li.find("h4").text(isnull(list[i].personName));
 	 						$li.find(".del_pic").attr("jobRoleId",isnull(list[i].ID));
 	 						var $img=isnull(list[i].img);
 	 						if($img!=""){
 	 							$li.find("img").attr("src",fileServer+$img);
 	 						}else{
 	 						 	$li.find("img").attr("src","../images/no_user.png");	  							
 	 						} 	 					
 	 						$li.find("a.per_ck").hide();
 	 						$li.find(".per_pic").show();
 	 						break;
 	 					}
 	 				}
 				}

			}else{
				alert("系统异常,人员查询失败!!!");
			}	
		}
	});
	}

 //岗位人员删除
 $("a.del_pic").click(function(){
	 var jobRoleId=$(this).attr("jobRoleId");
	 if(jobRoleId==null){
		 return;
	 }
	 var $li=$(this).parent().parent().parent();
	 $("#loading").show();
	 $.ajax({
			url:"../monitor/deleteJobRole/"+jobRoleId,
			type:"post",
			headers: { 
				'X-CSRF-TOKEN': '${_csrf.token}',
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			success:function(result) {
				$("#loading").hide();
				if(result.status!=0){
				alert("系统异常,删除失败!!!");
				}else{
					console.log($li);
					$li.find("h4").text("");
					$li.find(".del_pic").data("jobRoleId",null);
					$li.find("img").attr("src","../images/info/pic_1.png");
					$li.find(".per_pic").hide();
					$li.find("a.per_ck").css({"display":"block"});
				}
			}
		});
 });
 

//查询企业许可图片
function display_licence(){
	$.ajax({
		url:"../company/queryCompanyImage",
		type:"post",
		headers: { 
			'X-CSRF-TOKEN': '${_csrf.token}',
			'Accept': 'application/json',
			'Content-Type': 'application/json' 
		},
		dataType:'json',
		data:JSON.stringify(imageTypes),
		success:function(result) {
			if(result.status==0){
				var img_path_="";
				if(result.body!=null){
					var comGSYYZZ=result.body.COM_GSYYZZ;
					var comSPLTXKZ=result.body.COM_SPLTXKZ;
					var comSPSCXKZ=result.body.COM_SPSCXKZ;
					var comCYFWXKZ=result.body.COM_CYFWXKZ;
					var comSPJYXKZ=result.body.COM_SPJYXKZ;
					if(comSPJYXKZ!=null&&comSPJYXKZ.length>0){
						 img_path_=imgFilePath+comSPJYXKZ[0].filePath;				
					}else
					if(comCYFWXKZ!=null&&comCYFWXKZ.length>0){
						 img_path_=imgFilePath+comCYFWXKZ[0].filePath;			
					}/*else
					if(comSPLTXKZ!=null&&comSPLTXKZ.length>0){
						 img_path_=imgFilePath+comSPLTXKZ[0].filePath;			
					} else			
					if(comSPSCXKZ!=null&&comSPSCXKZ.length>0){
						 img_path_=imgFilePath+comSPSCXKZ[0].filePath;		
					}else 
					if(comGSYYZZ!=null&&comGSYYZZ.length>0){
						 img_path_=imgFilePath+comGSYYZZ[0].filePath;
					} */
					if(img_path_!=""){
						$("#no_img").hide();
						$("#img_div").append('<div rel="img" ><img src='+img_path_+'></div>');
					}	
				}

			}
		}
	});
};

//企业信息查询
function get_company(){
	$.ajax({
		url:"../company/getCompanyInfo",
		type:"get",
		success:function(result){
			if(result.status==0){
				$(".info_text").text(isnull(result.body.companyNameAbbrev));
				$("#editor-photo").attr("rel","findView/system.account.account-editor-photo?companyName="+encodeURI(encodeURI(result.body.companyName)))
			}
		}
	});
}


$(function(){
	//企业店招名查询
	get_company();
	//许可图片  
	display_licence();
	//人员查询
	search_emp();
	
	searchList();
	getDisplayInputMat();
	
	$(".btn_infoEditor").click(function(){
		tabNav(this);
		return false;
	});
	});
</script>	
</body>
</html>