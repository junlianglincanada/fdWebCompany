<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
html,body{ background:#fff; overflow-x:hidden;}
table.info_mation td{padding:5px 10px;}
dl.fication{width:82%;margin-left:40px;float:none;}
dl.fication dd{margin:5px 0;}
dl.fication dd ul.ficate_list li{margin:0 30px;}
dl.license dd ul.ficate_list li{width:126px; margin:0 16px;}
dl.license dd ul.ficate_list li .ficate_img,dl.license dd ul.ficate_list li .upload_thumib{padding:15px 2px 5px 2px;}
</style>
<script type="text/javascript">
var id="<%=id %>";
var imageTypes=["COM_GSYYZZ","COM_ZZJGDM","COM_SWDJZ","COM_FRSFZ","COM_GAJMLWNDTXZ","COM_TWJMLWNDTXZ","COM_SPLTXKZ","COM_SPSCXKZ","COM_CYFWXKZ","COM_OTHER","COM_SPJYXKZ"];
function search(){
	$("#loading").show();
	$.ajax({
		url:"../company/queryLinkCompanyImage/"+id,
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
					$(".ficate_list:eq(2)").prepend($li);
				}
				if(comCYFWXKZ!=null&&comCYFWXKZ.length>0){
					var path=imgFilePath+comCYFWXKZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>餐饮服务许可证</span></li>');
					$(".ficate_list:eq(2)").prepend($li);
				}
				if(comSPSCXKZ!=null&&comSPSCXKZ.length>0){
					var path=imgFilePath+comSPSCXKZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>食品生产许可证</span></li>');
					$(".ficate_list:eq(2)").prepend($li);
				}
				if(comSPLTXKZ!=null&&comSPLTXKZ.length>0){
					var path=imgFilePath+comSPLTXKZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>食品流通许可证</span></li>');
					$(".ficate_list:eq(2)").prepend($li);
				}
				if(comTWJMLWNDTXZ!=null&&comTWJMLWNDTXZ.length>0){
					var path=imgFilePath+comTWJMLWNDTXZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>台湾居民来往内地通行证</span></li>');
					$(".ficate_list:eq(1)").prepend($li);
				}
				if(comGAJMLWNDTXZ!=null&&comGAJMLWNDTXZ.length>0){
					var path=imgFilePath+comGAJMLWNDTXZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>港澳居民来往内地通行证</span></li>');
					$(".ficate_list:eq(1)").prepend($li);
				}
				if(comFRSFZ!=null&&comFRSFZ.length>0){
					var path=imgFilePath+comFRSFZ[0].filePath;
					var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>身份证</span></li>');
					$(".ficate_list:eq(1)").prepend($li);
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
    function iframe_wh(){	//计算窗口宽度高度的函数
		var par_W = $(window.parent.document).width();
		var ifr_W = $(window.document).find(".ifr_box").width();
		var pos_W = (par_W - ifr_W)/2 ; 
		//alert(par_W);
		$(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"480px",left:pos_W +"px",top:20 +"px"});
		$(window.parent.document).find(".popup_iframe").css({height:"432px"});
	    $(window).resize(function(){ //对浏览器窗口调整大小进行计数
			  var par_W = $(window.parent.document).width();
			  var ifr_W = $(window.document).find(".ifr_box").width();
			  var pos_W = (par_W - ifr_W)/2; 
			  //alert(par_W);
			  $(window.parent.document).find(".popup_box").css({width:ifr_W +"px",height:"480px",left:pos_W +"px",top:20 +"px"});
		      $(window.parent.document).find(".popup_iframe").css({height:"432px"});
			  return false;
		});
	}
	iframe_wh(); 
});
</script>
</head>
<body>
<div class="ifr_box" style="width:800px;padding-top:20px;">
      <div class="info_tab">
           <a href="chain.mainten.iframe-detail?id=<%=id %>">基本信息</a>
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
                     <dl class="fication">
                         <dt>— 法定代表人/负责人/业主 证件 —</dt>
                         <dd>
                             <ul class="ficate_list"> 
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
</body>
</html>