<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*,java.io.*"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp"%>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/restEmployee.restEmployeeView">从业人员</a> > <a href="#">查看从业人员</a>
          <div class="btn_opera"> 
                   <input type="button" class="btn_add" value="编辑从业人员"   onClick="window.location.href='../findView/restEmployee.restEmployee-editer?id=<%=id%>'" />
              </div>
           </h3>
          <div class="info_tab">
               <a href="../findView/restEmployee.restEmployeeDetailView?id=<%=id %>" class="default">基本信息</a>
               <a href="../findView/restEmployee.restEmployeeDetailView-photo?id=<%=id %>">证件信息</a>
          </div>
          <div class="info_box">
               <table class="info_mation" style="border-bottom:1px solid #dcdddd;">
                   <tr>
                       <td class="td_lf"><em class="star">*</em>姓名</td>
                       <td id="personName"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>性别</td>
                       <td id="sexValue"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>证件类型</td>
                       <td id="idTypeValue"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">*</em>手机</td>
                       <td><span id="mobilePhone"></span><i class="cert" id="verified" style="display:none">已认证</i></td>
                       
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>电话</td>
                       <td id="phone"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>邮箱</td>
                       <td id="email"></td>
                   </tr>
                   <tr>
                       <td class="td_lf"><em class="star">&nbsp;</em>岗位</td>
                       <td id="jobRole"></td>
                   </tr>
               </table>  
               <div class="photo_report" style="margin:0;position:absolute;top:0px; left:620px; z-index:200;">
                     <div class="licen_img">
                          <div id="pathPhoto" rel="img" style="border:1px dotted #ddd;"><img src="../images/i_user.jpg" id="photoPath"></a></div>
                     </div>
               </div>
          </div>
          <p class="save_box">
             <input type="button" class="btn_save" value="返回" onClick="window.location.href='../findView/restEmployee.restEmployeeView'"/>
          </p>
     </div>
</div>    
<script type="text/javascript">
var id="<%=id %>";
//查询方法
function queryCompany(id){
	$("#loading").show();
	$.ajax({
		url:"../restaurant/comEmployee/getComEmployee/"+id,
		type:"post",
		dataType:"json",
		success:function(result){
			console.log(result.body);
			if(result.status==0){
				var employee=result.body.employee;
				var personName=isnull(employee.personName);//人员名称
				var jobRole=isnull(employee.jobRole);//岗位
				var sexValue=isnull(employee.sexValue);//性别
				var idTypeValue=isnull(employee.idTypeValue);//证件类型
				var mobilePhone=isnull(employee.mobilePhone);//手机号码
				var phone=isnull(employee.phone);//电话号码
				var idNumber=isnull(employee.idNumber);//证件号码
				var email=isnull(employee.email);//邮箱
				var photoPath=isnull(employee.photoPath);//图片地址
				var isPhoneReg = employee.isPhoneReg;
				if(isPhoneReg==1){
					$("#verified").show();
				}
				if(photoPath!=""){
					$("#photoPath").attr("src","<%=fdWebFileURL%>"+photoPath);
					$("#pathPhoto").find("a").attr("href","<%=fdWebFileURL%>"+photoPath);
				}
				
				$("#personName").text(personName);
				$("#jobRole").text(jobRole);
				$("#sexValue").text(sexValue);
				if(idTypeValue!=""){
					$("#idTypeValue").text(idTypeValue+"：   "+idNumber);	
				}
				$("#mobilePhone").text(mobilePhone);
				$("#phone").text(phone);
				$("#email").text(email);
				
					}
			$("#loading").hide();
				},
				error : function() {
					alert("系统异常,数据加载失败");
					$("#loading").hide();
				}
			});
		}
/* function iframeBox() {
	$(".fancybox")
			.fancybox(
					{
						prevEffect : 'none',
						nextEffect : 'none',
						closeBtn : true, // Close button
						arrows : true, //  button left & button right
						tpl : {
							image : '<img class="fancybox-image" src="{href}" alt="" />'
						},
						helpers : {
							title : {
								type : 'inside'
							},//图片提示内容
							buttons : {
								position : 'bottom',
								//这是按钮的模板，参见jquery.fancybox-buttons.js文件,
								tpl : '<div id="fancybox-buttons"><ul><li><a class="btnPrev" title="上一个" href="javascript:;"></a></li><li><a class="btnNext" title="下一个" href="javascript:;"></a></li><li><a class="btnToggle" title="切换大小" href="javascript:;"></a></li>'
										+
										// 添加左转右转按钮
										'<li><a class="btnLeft" title="左转" href="javascript:;"></a></li><li><a class="btnRight" title="右转 " href="javascript:;"></a></li><li></ul></div>'
							}
						}

					});
	//切换大小
	$('body').on('click', '.btnToggle', function() {
		$(".fancybox-image").draggable({
			cursor : "move"
		});
	});
	//增加左转单击事件
	$('body').on('click', '.btnLeft', function() {
		rotateLeft();
	});
	//增加右转单击事件
	$('body').on('click', '.btnRight', function() {
		rotateRight();
	});

	var rad = 0;
	function rotateLeft() {
		rad = rad - 90;
		if (rad == -360) {
			rad = 0;
		}
		$(".fancybox-image").rotate(rad);
	}
	function rotateRight() {
		rad = rad + 90;
		if (rad == 360) {
			rad = 0;
		}
		$(".fancybox-image").rotate(rad);
	}
}	 */
$(function(){
	queryCompany(id);
});	
</script>
</body>
</html>