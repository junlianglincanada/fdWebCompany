<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../include.jsp" %>
<script type="text/javascript">
var ajaxFlag=true;
var pageSize=5;
var pageNum=1;
var totalPage;
var params={};
var searchParam={};
function search(pageNum){
	$(".paging_head").removeClass("disabled");
	$(".paging_head input").attr("disabled",false);
	$(".paging_perv").removeClass("disabled");
	$(".paging_perv input").attr("disabled",false);
	$(".paging_next").removeClass("disabled");
	$(".paging_next input").attr("disabled",false);
	$(".paging_trailer").removeClass("disabled");
	$(".paging_trailer input").attr("disabled",false);
	$("#loading").show();
	$.ajax({
		url: "../question/queryQuestion/"+pageNum+"/"+pageSize,
		type:"post",
		headers: { 
			'Accept': 'application/json',
			'Content-Type': 'application/json',
			'X-CSRF-TOKEN': '${_csrf.token}'
		},
		dataType:'json',
		data:JSON.stringify(searchParam),
		success:function(result){
			console.log(result.body);
			if(result.status==0){
				page(result);
				$(".consult_list").children().remove();
				var	totalNum=result.body.totalRecord;
				var list=result.body.resultList;
				for(var i=0;i<list.length;i++){
					var id=isnull(list[i].id);
					var questionContent=isnull(list[i].questionContent);
					var questionUserName=isnull(list[i].questionUserName);
					var createDate=isnull(list[i].createDate);
					var isTop=isnull(list[i].isTop);
					var answerContent=isnull(list[i].answerContent);
					var lastAnswerDate=isnull(list[i].lastAnswerDate);
					var $dt=$('<dt><span>'+questionContent+'</span><em>（'+questionUserName+'&nbsp;'+createDate+'）</em></dt>');
					if(isTop==1){
						$dt.append('<i class="i_top">置顶</i>');
					}
					if(answerContent!=""){
						var $dd=$('<dd><span>'+answerContent+'</span><em>（回复时间：'+lastAnswerDate+'）</em></dd>');
						$(".consult_list").append($dt);
						$(".consult_list").append($dd);
					}
				}
				$("#totalPage em").text(totalPage);
				$("#paging_num").val(pageNum);
				if(pageNum==1){
					$(".paging_head").addClass("disabled");
					$(".paging_head input").attr("disabled",true);
					$(".paging_perv").addClass("disabled");
					$(".paging_perv input").attr("disabled",true);
				}
				if(pageNum==totalPage){
					$(".paging_next").addClass("disabled");
					$(".paging_next input").attr("disabled",true);
					$(".paging_trailer").addClass("disabled");
					$(".paging_trailer input").attr("disabled",true);
				}
			}
			$("#loading").hide();
		}
	});
}
//特殊符号安全限制
function checkSpecificCode(keyCode) {
	var patrn=/[&<>{}\/;[\]]/im;
	var flg = false;
	flg = patrn.test(keyCode);
	if (flg) {
		return false;
	}
	return true;
}
$(function(){
	//页面加载获取Q&A信息
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
		var pageNo=$("#paging_num").val().trim();
		if(isNaN(pageNo)||pageNo==null||pageNo==""){
			return;
		}else{
			pageNum=parseInt($("#paging_num").val().trim());
			if(pageNum<1){
				pageNum=1;
				search(pageNum);
			}else  if(pageNum>totalPage){
				pageNum=totalPage;
				search(pageNum);
			}else{
				search(pageNum);
			}
		}
	});
	$(".btn_query").click(function(){
		var keyword=$(".query_input").val().trim();
		if(keyword=="输入关键字查询"){
			keyword="";
		}
		searchParam.keyword=keyword;
		search(pageNum);
	})
	//输入框优化
	$(".query_input").click(function(){
		if($(".query_input").val().trim()=="输入关键字查询"){
			$(this).val("");
		};
	});
	$(".query_input").blur(function(){
		var userName=$(".query_input").val().trim();
		if(userName==null||userName==""||userName=="输入关键字查询"){
	        $(this).val("输入关键字查询").css("color","gray");
		}else{
			$(this).css("color","gray");
		}
	});
	/* $("#userName").click(function(){
		if($("#userName").val().trim()=="昵称"){
			$(this).val("");
		};
	});
	$("#userName").blur(function(){
		var userName=$("#userName").val().trim();
		if(userName==null||userName==""||userName=="昵称"){
	        $(this).val("昵称").css("color","gray");
		}else{
			$(this).css("color","gray");
		}
	}); */
	$("#content").click(function(){
		if($("#content").val().trim()=="限200字内"){
			$(this).val("");
		};
	});
	$("#content").blur(function(){
		var userName=$("#content").val().trim();
		if(userName==null||userName==""||userName=="限200字内"){
	        $(this).val("限200字内").css("color","gray");
		}else{
			$(this).css("color","gray");
		}
	});
	//获取登录用户信息
	$.ajax({
		url: "../security/systemUser/getUser",
		type:"get",
		headers: { 
			'Accept': 'application/json',
			'Content-Type': 'application/json',
			'X-CSRF-TOKEN': '${_csrf.token}'
		},
		success: function(result) {
			if(result.status==0){
				var userName=isnull(result.body.userName);
				var mobilePhone=isnull(result.body.mobilePhone);
				var phone=isnull(result.body.phone);
				var email=isnull(result.body.email);
				var companyId=isnull(result.body.companyId);
				params.companyId=companyId;
				$("#userName").text(userName);
				if(mobilePhone!=""){
					$("#phone").val(mobilePhone);
				}else{
					$("#phone").val(phone);
				}
				$("#email").val(email);
			}
		}
	});
	//点击提交按钮上传问题信息
	$(".btn_save").click(function(){
		$("#error1").hide();
		$("#error2").hide();
		$(".text_ts").empty();
		ajaxFlag=true;
		var questionUserName=$("#userName").text();
		var questionUserContact=$("#phone").val().trim();
		var questionUserEmail=$("#email").val().trim();
		var questionType=$("#questionType").val();
		var questionContent=$("#content").val().trim()
		/* if(questionUserName==""||questionUserName==null||questionUserName=="昵称"){
			$("#error_user").text("用户名不能为空");
			ajaxFlag=false;
		} */
		/* if(checkSpecificCode(questionUserName)==false){
			$("#error_user").text("请勿输入特殊字符");
		} */
		if(checkSpecificCode(questionUserContact)==false){
			$("#error_phone").text("请勿输入特殊字符");
			ajaxFlag=false;
		}
		if(checkSpecificCode(questionUserEmail)==false){
			$("#error_email").text("请勿输入特殊字符");
			ajaxFlag=false;
		}
		if(questionUserContact!=null&&questionUserContact!=""&&!isMobilephone(questionUserContact)&&!isPhone(questionUserContact)){
			$("#error_phone").text("请输入正确联系电话");
			ajaxFlag=false;
		}
		if(questionUserEmail!=null&&questionUserEmail!=""&&!isEmail(questionUserEmail)){
			$("#error_email").text("请输入正确电子邮箱");
			ajaxFlag=false;
		}
		if(questionContent.length <10) {
			$("#error1").show();
			ajaxFlag=false;
		}
		if(checkSpecificCode(questionContent)==false){
			$("#error2").show();
			ajaxFlag=false;
		}
		params.questionUserName=questionUserName;
		params.questionUserContact=questionUserContact;
		params.questionUserEmail=questionUserEmail;
		params.questionType=questionType;
		params.questionContent=questionContent;
		params.questionFrom=1;
		if(ajaxFlag){
			$.ajax({
				url: "../question/createQuestion",
				type:"post",
				headers: { 
					'Accept': 'application/json',
					'Content-Type': 'application/json',
					'X-CSRF-TOKEN': '${_csrf.token}'
				},
				dataType:'json',
				data:JSON.stringify(params),
				success:function(result){
					window.location.href="../findView/consult.consult";
				}
			});
		}
	})
})
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#" title="互动交流">咨询帮助</a> </h3>
          <div class="query">
               <span><input type="text" class="query_input" value="输入关键字查询" style="width:208px;font-size:13px;color:gray;" /></span>
               <input type="button" class="btn_query" value="查询" />
          </div>
          <div class="table_box">
               <dl class="consult_list">
               </dl>
               <div class="clear"></div>
               <p class="paging_box">
                   <span class="paging_head"><input type="button" value="首页" style="padding:3px 5px"></span>
                   <span class="paging_perv"><input type="button" value="<< 上一页" ></span>
                   <span class="paging_next"><input type="button" value="下一页 >>" /></span>
                   <span class="paging_trailer"><input type="button" value="尾页" style="padding:3px 5px" ></span>
                   <span class="num_text" id="totalPage" >共<em></em>页</span>  
                   <span class="num_text">跳转 <input type="text"  id="paging_num" value=""  style="width:20px;height: 20px;" onkeyup="javascript:this.value=this.value.replace(/\D/g,'')" maxlength="6" /></span>
                   <!-- <input id="page_btn" type="button" value="确定" class="btn_query" style="float:none;float: none;width: 40px;font-size: 12px;height: 28px;line-height: 28px;"> -->
                   <input type="button" class="paging_btn" value="确 定" id="page_btn"/>
                 </p>
               <br />
               <div class="clear"></div>
                <div class="consult_box">
                      <h4 class="consult_title"><i class="i_sult"></i><span>我要提问</span></h4>
                      <table class="info_mation">
                           <tr>
                               <td class="td_lf" style="width:70px;padding-left:0;color:#221815;"><em class="star">*</em>提问者</td>
                               <td style="width:200px;"><label id="userName"></label>
                               <%-- <input 
                               onkeyup="value=value.replace(/[`~!@#$%^&*()_+<>?:{},.\/;[\]]/g,'')"
							   onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[`~!@#$%^&*+<>?:{},.\/;[\].]/g,''))"
                               type="text" class="input_code" value="昵称" style="color:gray; width:160px;" id="userName" maxlength="30"/><br/><span class="text_ts" style="margin-left: 0px;" id="error_user"></span> --%></td>
                               <td class="td_lf" style="width:60px;padding-left:0;text-align:center;color:#221815;">联系电话</td>
                               <td><input 
                               type="text" class="input_code" value="" style="color:gray;width:160px;" id="phone" maxlength="20"/><br/><span class="text_ts" style="margin-left: 0px;" id="error_phone"></span></td>
                               <td class="td_lf" style="width:60px;padding-left:0;text-align:center;color:#221815;">邮箱</td>
                               <td><input 
                               type="text" class="input_code" value="" style="color:gray;width:160px;" id="email" maxlength="50"/><br/><span class="text_ts" style="margin-left: 0px;" id="error_email"></span></td>
                           </tr>
                           <tr>
                               <td class="td_lf" style="width:70px;padding-left:0;color:#221815;"><em class="star">*</em>问题类型</td>
                               <td colspan="5">
                                   <div class="select_s" style="width:180px; float:left;">
                                    <div class="select_is" style="width:180px;">
                                       <select class="select_cs" style="width:210px; background-position:-16px -122px; " id="questionType"> 
                                              <option value="1">业务咨询</option>
                                              <option value="2">技术咨询</option>
                                              <option value="3">法规咨询</option>
                                       </select>
                                     </div>
                                   </div>
                               </td>
                           </tr>
                           <tr>
                               <td class="td_lf" style="width:70px;padding-left:0;color:#221815;"><em class="star">*</em>内容</td>
                               <td colspan="5"><textarea 
                               class="textarea_code" style="width:90%;color:gray;" id="content" maxlength="200">限200字内</textarea>
                               <br/><span style="color:#ff6600; margin-left: 0px; display:none" id="error1">内容不能少于10个字符</span>
                               <span style="color:#ff6600; margin-left: 5px; display:none" id="error2">请勿输入特殊字符</span></td>
                           </tr>
                      </table>                   
                      <p class="save_box">
                         <input type="button" class="btn_save" value="提交" />
                      </p>
                 </div>  
          </div>
     </div>
</div>    
</body>
</html>