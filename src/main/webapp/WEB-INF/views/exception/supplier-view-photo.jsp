<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
    String id=request.getParameter("id");
String linkCompanyId=request.getParameter("linkCompanyId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../include.jsp"%>
<style type="text/css">
dl.license{width:50%; margin-right:0px; }
dl.license dd ul.ficate_list li{width:126px;}
dl.license dd ul.ficate_list li .ficate_img{padding:15px 2px 5px 2px;}
</style>
<script type="text/javascript">
var imageTypes=["SUP_GSYYZZ","SUP_ZZJGDM","SUP_SWDJZ","SUP_FRSFZ","SUP_GAJMLWNDTXZ","SUP_TWJMLWNDTXZ","SUP_SPLTXKZ","SUP_SPSCXKZ","SUP_CYFWXKZ","SUP_OTHER","SUP_SPJYXKZ"];
var linkImageTypes=["COM_GSYYZZ","COM_ZZJGDM","COM_SWDJZ","COM_FRSFZ","COM_GAJMLWNDTXZ","COM_TWJMLWNDTXZ","COM_SPLTXKZ","COM_SPSCXKZ","COM_CYFWXKZ","COM_OTHER","COM_SPJYXKZ"];
var id="<%=id%>";
var linkCompanyId=isnull("<%=linkCompanyId%>");
function searchCompanyId(linkCompanyId){
	if(linkCompanyId!=""){
		$("#loading").show();
		$.ajax({
			url:"../company/queryLinkCompanyImage/"+linkCompanyId,
			type:"post",
			headers: { 
				'X-CSRF-TOKEN': '${_csrf.token}',
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			data:JSON.stringify(linkImageTypes),
			success:function(result) {
				console.log(result.body);
				if(result.status==0){
					var supGSYYZZ=result.body.COM_GSYYZZ;
					var supZZJGDM=result.body.COM_ZZJGDM;
					var supSWDJZ=result.body.COM_SWDJZ;
					var supFRSFZ=result.body.COM_FRSFZ;
					var supGAJMLWNDTXZ=result.body.COM_GAJMLWNDTXZ;
					var supTWJMLWNDTXZ=result.body.COM_TWJMLWNDTXZ;
					var supSPLTXKZ=result.body.COM_SPLTXKZ;
					var supSPSCXKZ=result.body.COM_SPSCXKZ;
					var supCYFWXKZ=result.body.COM_CYFWXKZ;
					var supOther=result.body.COM_OTHER;
					var supSPJYXKZ=result.body.COM_SPJYXKZ;
					if(supOther!=null&&supOther.length>0){
						var path=imgFilePath+supOther[0].filePath;
						var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>其他</span></li>');
						$("#img_list").prepend($li);
					}
					if(supTWJMLWNDTXZ!=null&&supTWJMLWNDTXZ.length>0){
						var path=imgFilePath+supTWJMLWNDTXZ[0].filePath;
						var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>台湾居民来往内地通行证</span></li>');
						$("#img_list").prepend($li);
					}
					if(supGAJMLWNDTXZ!=null&&supGAJMLWNDTXZ.length>0){
						var path=imgFilePath+supGAJMLWNDTXZ[0].filePath;
						var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>港澳居民来往内地通行证</span></li>');
						$("#img_list").prepend($li);
					}
					if(supFRSFZ!=null&&supFRSFZ.length>0){
						var path=imgFilePath+supFRSFZ[0].filePath;
						var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>身份证</span></li>');
						$("#img_list").prepend($li);
					}
					if(supSPJYXKZ!=null&&supSPJYXKZ.length>0){
						var path=imgFilePath+supSPJYXKZ[0].filePath;
						var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>食品经营许可证</span></li>');
						$("#img_list").prepend($li);
					}
						if(supCYFWXKZ!=null&&supCYFWXKZ.length>0){
							var path=imgFilePath+supCYFWXKZ[0].filePath;
							var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>餐饮服务许可证</span></li>');
							$("#img_list").prepend($li);
						}
						if(supSPSCXKZ!=null&&supSPSCXKZ.length>0){
							var path=imgFilePath+supSPSCXKZ[0].filePath;
							var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>食品生产许可证</span></li>');
							$("#img_list").prepend($li);
						}
						if(supSPLTXKZ!=null&&supSPLTXKZ.length>0){
							var path=imgFilePath+supSPLTXKZ[0].filePath;
							var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>食品流通许可证</span></li>');
							$("#img_list").prepend($li);
						}

						if(supSWDJZ!=null&&supSWDJZ.length>0){
							var path=imgFilePath+supSWDJZ[0].filePath;
							var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>税务登记证</span></li>');
							$("#img_list").prepend($li);
						}
						if(supZZJGDM!=null&&supZZJGDM.length>0){
							var path=imgFilePath+supZZJGDM[0].filePath;
							var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>组织机构代码</span></li>');
							$("#img_list").prepend($li);
						}
						if(supGSYYZZ!=null&&supGSYYZZ.length>0){
							var path=imgFilePath+supGSYYZZ[0].filePath;
							var $li=$('<li><div class="ficate_img" rel="img"><img src='+path+'></img></div><span>工商营业执照</span></li>');
							$("#img_list").prepend($li);
						}
					  var imglength=$("#img_list").find("li").length;
					  if(imglength==0){
						  $("#img_list").hide();
						  $("#linkCompany").hide();
					  }

					$("#loading").hide();
				}
			},
			error:function(e) {
				console.log(e);
			}
		});
	}else{
		  $("#img_list").hide();
		  $("#linkCompany").hide();
	}

}
function search(id){
	$("#loading").show();
	$.ajax({
		url:"../inputManage/supplier/querySupplierImage/"+id,
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
				var supGSYYZZ=result.body.SUP_GSYYZZ;
				var supZZJGDM=result.body.SUP_ZZJGDM;
				var supSWDJZ=result.body.SUP_SWDJZ;
				var supFRSFZ=result.body.SUP_FRSFZ;
				var supGAJMLWNDTXZ=result.body.SUP_GAJMLWNDTXZ;
				var supTWJMLWNDTXZ=result.body.SUP_TWJMLWNDTXZ;
				var supSPLTXKZ=result.body.SUP_SPLTXKZ;
				var supSPSCXKZ=result.body.SUP_SPSCXKZ;
				var supCYFWXKZ=result.body.SUP_CYFWXKZ;
				var supOther=result.body.SUP_OTHER;
				var supSPJYXKZ=result.body.SUP_SPJYXKZ;
				if(supSPJYXKZ!=null&&supSPJYXKZ.length>0){
					var path=imgFilePath+supSPJYXKZ[0].filePath;
					$("#spjy").find("div").attr("rel","img");
					$("#spjy").find("img").attr("src",path);
				}
				if(supGSYYZZ!=null&&supGSYYZZ.length>0){
					var path=imgFilePath+supGSYYZZ[0].filePath;
					$("#gs").find("div").attr("rel","img");
					$("#gs").find("img").attr("src",path);
				}
				if(supZZJGDM!=null&&supZZJGDM.length>0){
					var path=imgFilePath+supZZJGDM[0].filePath;
					$("#zuzhi").find("div").attr("rel","img");
					$("#zuzhi").find("img").attr("src",path);
				}
				if(supSWDJZ!=null&&supSWDJZ.length>0){
					var path=imgFilePath+supSWDJZ[0].filePath;
					$("#shuiwu").find("div").attr("rel","img");
					$("#shuiwu").find("img").attr("src",path);
				}
				if(supSPLTXKZ!=null&&supSPLTXKZ.length>0){
					var path=imgFilePath+supSPLTXKZ[0].filePath;
					$("#liutong").find("div").attr("rel","img");
					$("#liutong").find("img").attr("src",path);
				}
				if(supSPSCXKZ!=null&&supSPSCXKZ.length>0){
					var path=imgFilePath+supSPSCXKZ[0].filePath;
					$("#shengchan").find("div").attr("rel","img");
					$("#shengchan").find("img").attr("src",path);
				}
				if(supCYFWXKZ!=null&&supCYFWXKZ.length>0){
					var path=imgFilePath+supCYFWXKZ[0].filePath;
					$("#fuwu").find("div").attr("rel","img");
					$("#fuwu").find("img").attr("src",path);
				}
				if(supFRSFZ!=null&&supFRSFZ.length>0){
					var path=imgFilePath+supFRSFZ[0].filePath;
					$("#shenfen").find("div").attr("rel","img");
					$("#shenfen").find("img").attr("src",path);
				}
				if(supGAJMLWNDTXZ!=null&&supGAJMLWNDTXZ.length>0){
					var path=imgFilePath+supGAJMLWNDTXZ[0].filePath;
					$("#gangao").find("div").attr("rel","img");
					$("#gangao").find("img").attr("src",path);
				}
				if(supTWJMLWNDTXZ!=null&&supTWJMLWNDTXZ.length>0){
					var path=imgFilePath+supTWJMLWNDTXZ[0].filePath;
					$("#taiwan").find("div").attr("rel","img");
					$("#taiwan").find("img").attr("src",path);
				}
				if(supOther!=null&&supOther.length>0){
					var path=imgFilePath+supOther[0].filePath;
					$("#qita").find("div").attr("rel","img");
					$("#qita").find("img").attr("src",path);
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
	search(id);
	$.ajax({
		url:"../inputManage/supplier/getSupplierById/"+id,
		type:"get",
		headers:{},
		success:function(result){
			if(result.status==0){
				console.log(result.body);
				document.getElementById("name1").innerHTML = result.body.name;
			}
		},
	})
	searchCompanyId(linkCompanyId);
})
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="exception.exception-Certificate">证照预警</a> > <a href="#">查看供应商</a> > <a id="name1"></a> </h3>
          <div class="info_tab">
               <a href="exception.supplier-view?id=<%=id %>">基本信息</a>
               <a href="exception.supplier-view-photo?id=<%=id %>&linkCompanyId=<%=linkCompanyId %>" class="default">证照<em style="font-style:normal;position:relative;top:1px;letter-spacing:1px;">图</em>片</a>
          </div>
           <h4 id="linkCompany" class="import_title" style="border-bottom:1px solid #dcdcdc;text-align:center;position:relative;top:-12px;margin-top: 20px;"><span style="color:#231815;display:inline-block;font-weight:bold;padding:0 20px;background:#fff;position:relative;top:14px;">当前供应商自主上传证照</span></h4>
		   <ul class="ficate_list"  id="img_list">
			<div class="clear"></div>	 
		   </ul>
          <h4 class="import_title" id="company" style="border-bottom:1px solid #dcdcdc;text-align:center;position:relative;top:-12px;"><span style="color:#231815;display:inline-block;font-weight:bold;padding:0 20px;background:#fff;position:relative;top:14px;">当前单位上传的供应商证照</span></h4>
          <div class="info_box">
               <div class="ficate">
                 <div class="ficate_con" style="min-width:996px;" id="list_img">
                         <dl class="fication" id="img0">
                             <dt>— 企业三证 —</dt>
                             <dd style="border-bottom:none;">
                                 <ul class="ficate_list">
									<li id="gs">
										<div class="ficate_img">
											<img src="../images/img-no.jpg" />
										</div> <span>工商营业执照</span>
									</li>
									<li id="zuzhi">
										<div class="ficate_img">
											<img src="../images/img-no.jpg" />
										</div> <span>组织机构代码</span>
									</li>
									<li id="shuiwu">
										<div class="ficate_img">
											<img src="../images/img-no.jpg" />
										</div> <span>税务登记证</span>
									</li>

								</ul>
                             </dd>
                         </dl>
                         <dl class="fication license" id="img1 ">
                             <dt>— 许可证 —</dt>
                             <dd style="border-bottom:none;">
                                 <ul class="ficate_list"> 
 									<li id="liutong">
										<div class="ficate_img">
											<img src="../images/img-no.jpg" />
										</div> <span>食品流通许可证</span>
									</li>
 									<li id="shengchan">
										<div class="ficate_img">
											<img src="../images/img-no.jpg" />
										</div> <span>食品生产许可证</span>
									</li>
 									<li id="fuwu">
										<div class="ficate_img">
											<img src="../images/img-no.jpg" />
										</div> <span>餐饮服务许可证</span>
									</li>
                                  	<li id="spjy">
										<div class="ficate_img">
											<img src="../images/img-no.jpg" />
										</div> <span>食品经营许可证</span>
									</li>
                                  </ul>
                             </dd>
                         </dl>
                         <dl class="fication" id="img2">
                             <dt>— 法定代表人/负责人/业主 证件 —</dt>
                             <dd style="border-bottom:none;">
                                 <ul class="ficate_list"> 
									<li id="shenfen">
										<div class="ficate_img">
											<img src="../images/img-no.jpg" />
										</div> <span>身份证</span>
									</li>
									<li id="gangao">
										<div class="ficate_img">
											<img src="../images/img-no.jpg" />
										</div> <span>港澳居民<br/>来往内地通行证</span>
									</li>
									<li id="taiwan">
										<div class="ficate_img">
											<img src="../images/img-no.jpg" />
										</div> <span>台湾居民<br/>往来内地通行证</span>
									</li>
									
                                  </ul>
                             </dd>
                         </dl>
                         <dl class="fication license" id="img3">
                             <dt>— 其它 —</dt>
                             <dd style="border-bottom:none;">
                                 <ul class="ficate_list"> 
									<li id="qita">
										<div class="ficate_img">
											<img src="../images/img-no.jpg" />
										</div> <span>其它</span>
									</li>
                                  </ul>
                             </dd>
                         </dl>
                         <div class="clear"></div>
                    </div>
               </div>
               <div class="clear"></div>
          </div>
     </div>
</div>	
</body>
</html>