<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
	String companyName=request.getParameter("companyName");
	companyName=java.net.URLDecoder.decode(companyName, "UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
dl.license{width:50%; margin-right:0px; }
dl.license dd ul.ficate_list li{width:126px;}
dl.license dd ul.ficate_list li .ficate_img{padding:15px 2px 5px 2px;}
</style>
<script type="text/javascript">
var imageTypes=["COM_GSYYZZ","COM_ZZJGDM","COM_SWDJZ","COM_FRSFZ","COM_GAJMLWNDTXZ","COM_TWJMLWNDTXZ","COM_SPLTXKZ","COM_SPSCXKZ","COM_CYFWXKZ","COM_OTHER","COM_SPJYXKZ"];
function search(){
	$("#loading").show();
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
			console.log(result.body);
			if(result.status==0){
				var comGSYYZZ=result.body.COM_GSYYZZ;
				var comZZJGDM=result.body.COM_ZZJGDM;
				var comSWDJZ=result.body.COM_SWDJZ;
				var comFRSFZ=result.body.COM_FRSFZ;
				var comGAJMLWNDTXZ=result.body.COM_GAJMLWNDTXZ;
				var comTWJMLWNDTXZ=result.body.COM_TWJMLWNDTXZ;
				var comSPLTXKZ=result.body.COM_SPLTXKZ;
				var comSPSCXKZ=result.body.COM_SPSCXKZ;
				var comCYFWXKZ=result.body.COM_CYFWXKZ;
				var comOther=result.body.COM_OTHER;
				var comSPJYXKZ=result.body.COM_SPJYXKZ;
				if(comOther!=null&&comOther.length>0){
					var path=imgFilePath+comOther[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>其他</span></li>');
					$(".ficate_list:eq(3)").prepend($li);
				}
				if(comSPJYXKZ!=null&&comSPJYXKZ.length>0){
					var path=imgFilePath+comSPJYXKZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>食品经营许可证</span></li>');
					$(".ficate_list:eq(1)").prepend($li);
				}
				if(comCYFWXKZ!=null&&comCYFWXKZ.length>0){
					var path=imgFilePath+comCYFWXKZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>餐饮服务许可证</span></li>');
					$(".ficate_list:eq(1)").prepend($li);
				}
				if(comSPSCXKZ!=null&&comSPSCXKZ.length>0){
					var path=imgFilePath+comSPSCXKZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>食品生产许可证</span></li>');
					$(".ficate_list:eq(1)").prepend($li);
				}
				if(comSPLTXKZ!=null&&comSPLTXKZ.length>0){
					var path=imgFilePath+comSPLTXKZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>食品流通许可证</span></li>');
					$(".ficate_list:eq(1)").prepend($li);
				}
				if(comTWJMLWNDTXZ!=null&&comTWJMLWNDTXZ.length>0){
					var path=imgFilePath+comTWJMLWNDTXZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>台湾居民来往内地通行证</span></li>');
					$(".ficate_list:eq(2)").prepend($li);
				}
				if(comGAJMLWNDTXZ!=null&&comGAJMLWNDTXZ.length>0){
					var path=imgFilePath+comGAJMLWNDTXZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>港澳居民来往内地通行证</span></li>');
					$(".ficate_list:eq(2)").prepend($li);
				}
				if(comFRSFZ!=null&&comFRSFZ.length>0){
					var path=imgFilePath+comFRSFZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>身份证</span></li>');
					$(".ficate_list:eq(2)").prepend($li);
				}
				if(comSWDJZ!=null&&comSWDJZ.length>0){
					var path=imgFilePath+comSWDJZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>税务登记证</span></li>');
					$(".ficate_list:eq(0)").prepend($li);
				}
				if(comZZJGDM!=null&&comZZJGDM.length>0){
					var path=imgFilePath+comZZJGDM[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>组织机构代码</span></li>');
					$(".ficate_list:eq(0)").prepend($li);
				}
				if(comGSYYZZ!=null&&comGSYYZZ.length>0){
					var path=imgFilePath+comGSYYZZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>工商营业执照</span></li>');
					$(".ficate_list:eq(0)").prepend($li);
				}
				$("#loading").hide();
			}
		},
		error:function(e) {
			console.log(e);
		}
	});
}

$(function(){
	search();
	$(".btn_editor").click(function(){
		var companyName = '<%=companyName %>';
		companyName=encodeURI(encodeURI(companyName))
		window.location.href='../findView/system.account.account-editor-photo?companyName='+companyName;
	})
})
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#"><%=companyName %></a>
          <div class="btn_opera"> 
                   <input type="button" class="btn_editor" value="编辑"/>
              </div>
          </h3>
          <div class="info_tab">
               <a href="system.account.account-view">基本信息</a>
               <a href="#" class="default">证照图片</a>
          </div>
          <div class="info_box">
               <div class="ficate">
                    <div class="ficate_con" style="min-width:996px;">
                         <dl class="fication">
                             <dt>— 企业三证 —</dt>
                             <dd>
                                 <ul class="ficate_list"> <!--添加资质图片-->
                                 </ul>
                             </dd>
                         </dl>
                         <dl class="fication license">
                             <dt>— 许可证 —</dt>
                             <dd>
                                 <ul class="ficate_list">
                                 </ul>
                             </dd>
                         </dl>
                         <dl class="fication">
                             <dt>— 法定代表人/负责人/业主 证件 —</dt>
                             <dd>
                                 <ul class="ficate_list"> 
                                 </ul>
                             </dd>
                         </dl>
                         <dl class="fication license">
                             <dt>— 其它 —</dt>
                             <dd>
                                 <ul class="ficate_list"> 
                                 </ul>
                             </dd>
                         </dl>
                    </div>
               </div>
               <div class="clear"></div>
          </div>
     </div>
</div>
</body>
</html>