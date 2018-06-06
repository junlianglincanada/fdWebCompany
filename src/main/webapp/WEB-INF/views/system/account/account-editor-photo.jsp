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
var restIdList=new Array;
//建立一個可存取到該file的url
function getObjectURL(file) {
	var url = null ; 
	if (window.createObjectURL!=undefined) { // basic
		url = window.createObjectURL(file) ;
	} else if (window.URL!=undefined) { // mozilla(firefox)
		url = window.URL.createObjectURL(file) ;
	} else if (window.webkitURL!=undefined) { // webkit or chrome
		url = window.webkitURL.createObjectURL(file) ;
	}
	return url ;
}
function isNull(object){
	if(object==null||object==""||object=="null"){
		return true;
	}else{
		return false;
	}
}
function previewImg(obj){
	$(".text_ts").remove();
	var ie=$.browser.version;
	if($.browser.msie){
		if(ie=="11.0"||ie=="10.0"){
			if (obj.files &&obj.files[0]){
				var picval = parseInt(obj.files[0].size/1048576);
				if (picval >= 1){
					$(obj).parent().after('<span class="text_ts">'+this.files[0].name +'  大于1M, 上传图片建议小于1M </span>');;
					obj.value="";
					return ;
				}
			}
			var objUrl = getObjectURL(obj.files[0]) ;
			if (objUrl) {
				$(obj).parent().parent().find("img").attr("src", objUrl) ;
				$(obj).parent().hide();
				$(obj).parent().parent().find(".ficate_img").show(); 
			}
			
		}else{
			alert("上传图片,目前暂不支持IE 9及以下版本");
			$(obj).val("");
		}
	}else{
		if (obj.files &&obj.files[0]){
			var picval = parseInt(obj.files[0].size/1048576);
			if (picval >= 1){
				$(obj).parent().after('<span class="text_ts">'+obj.files[0].name +'  大于1M, 上传图片建议小于1M </span>');;
				obj.value="";
				return ;
			}
		}
		var objUrl = getObjectURL(obj.files[0]) ;
		if (objUrl) {
			$(obj).parent().parent().find("img").attr("src", objUrl) ;
			$(obj).parent().hide();
			$(obj).parent().parent().find(".ficate_img").show(); 
			
		}
	}
	
}
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
				var photoPath=isnull(result.body.photoPath);//图片地址
				var photoId=isnull(result.body.photoId);
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
				if(photoPath!=""){
					$("body").data("id",photoId);
					$("#upload_thumib").hide();
					$("#licen_img").show();
					$("#photoPath").attr("src","<%=fdWebFileURL%>"+photoPath);
				}
				if(comSPJYXKZ!=null&&comSPJYXKZ.length>0){
					var path=imgFilePath+comSPJYXKZ[0].filePath;
					$("#comSPJYXKZ").find("img").attr("src",path);
					var id=comSPJYXKZ[0].id;
					$("#comSPJYXKZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#comSPJYXKZ").prev().hide();
					$("#comSPJYXKZ").show();
				}
				if(comGSYYZZ!=null&&comGSYYZZ.length>0){
					var path=imgFilePath+comGSYYZZ[0].filePath;
					$("#comGSYYZZ").find("img").attr("src",path);
					var id=comGSYYZZ[0].id;
					$("#comGSYYZZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#comGSYYZZ").prev().hide();
					$("#comGSYYZZ").show();
				}
				if(comZZJGDM!=null&&comZZJGDM.length>0){
					var path=imgFilePath+comZZJGDM[0].filePath;
					$("#comZZJGDM").find("img").attr("src",path);
					var id=comZZJGDM[0].id;
					$("#comZZJGDM").find("a").attr("onclick","deleteImage("+id+")");
					$("#comZZJGDM").prev().hide();
					$("#comZZJGDM").show();
				}
				if(comSWDJZ!=null&&comSWDJZ.length>0){
					var path=imgFilePath+comSWDJZ[0].filePath;
					$("#comSWDJZ").find("img").attr("src",path);
					var id=comSWDJZ[0].id;
					$("#comSWDJZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#comSWDJZ").prev().hide();
					$("#comSWDJZ").show();
				}
				if(comFRSFZ!=null&&comFRSFZ.length>0){
					var path=imgFilePath+comFRSFZ[0].filePath;
					$("#comFRSFZ").find("img").attr("src",path);
					var id=comFRSFZ[0].id;
					$("#comFRSFZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#comFRSFZ").prev().hide();
					$("#comFRSFZ").show();
				}
				if(comGAJMLWNDTXZ!=null&&comGAJMLWNDTXZ.length>0){
					var path=imgFilePath+comGAJMLWNDTXZ[0].filePath;
					$("#comGAJMLWNDTXZ").find("img").attr("src",path);
					var id=comGAJMLWNDTXZ[0].id;
					$("#comGAJMLWNDTXZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#comGAJMLWNDTXZ").prev().hide();
					$("#comGAJMLWNDTXZ").show();
				}
				if(comTWJMLWNDTXZ!=null&&comTWJMLWNDTXZ.length>0){
					var path=imgFilePath+comTWJMLWNDTXZ[0].filePath;
					$("#comTWJMLWNDTXZ").find("img").attr("src",path);
					var id=comTWJMLWNDTXZ[0].id;
					$("#comTWJMLWNDTXZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#comTWJMLWNDTXZ").prev().hide();
					$("#comTWJMLWNDTXZ").show();
				}
				if(comSPLTXKZ!=null&&comSPLTXKZ.length>0){
					var path=imgFilePath+comSPLTXKZ[0].filePath;
					$("#comSPLTXKZ").find("img").attr("src",path);
					var id=comSPLTXKZ[0].id;
					$("#comSPLTXKZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#comSPLTXKZ").prev().hide();
					$("#comSPLTXKZ").show();
				}
				if(comSPSCXKZ!=null&&comSPSCXKZ.length>0){
					var path=imgFilePath+comSPSCXKZ[0].filePath;
					$("#comSPSCXKZ").find("img").attr("src",path);
					var id=comSPSCXKZ[0].id;
					$("#comSPSCXKZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#comSPSCXKZ").prev().hide();
					$("#comSPSCXKZ").show();
				}
				if(comCYFWXKZ!=null&&comCYFWXKZ.length>0){
					var path=imgFilePath+comCYFWXKZ[0].filePath;
					$("#comCYFWXKZ").find("img").attr("src",path);
					var id=comCYFWXKZ[0].id;
					$("#comCYFWXKZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#comCYFWXKZ").prev().hide();
					$("#comCYFWXKZ").show();
				}
				if(comOther!=null&&comOther.length>0){
					var path=imgFilePath+comOther[0].filePath;
					$("#comOther").find("img").attr("src",path);
					var id=comOther[0].id;
					$("#comOther").find("a").attr("onclick","deleteImage("+id+")");
					$("#comOther").prev().hide();
					$("#comOther").show();
				}
				$("#loading").hide();
			}
		},   
		error:function(e) {
			console.log(e);
		}
	});
}
function deleteImage(id){
	//$("#loading").show();
	restIdList.push(id);
	/* $.ajax({
		url:"../delAttachments",
		type:"post",
		headers: { 
			'X-CSRF-TOKEN': '${_csrf.token}',
			'Accept': 'application/json',
			'Content-Type': 'application/json' 
		},
		dataType:'json',
		data:JSON.stringify(restIdList),
		async : false,
		success:function(result) {
			$("#loading").hide();
		},   
		error:function(text){
			alert("系统异常,删除失败");
			return false;
		}
	}); */
}
$(function(){
	search();
	$("#save").live("click",function(){
		if($.browser.msie){
			var ie=$.browser.version;
			if(ie!="11.0"&&ie!="10.0"){
				alert("本次操作,目前暂不支持IE 9及以下版本");
				return false;
			}
		}
		//删除图片
		console.log(restIdList);
		$.ajax({
			url:"../delAttachments",
			type:"post",
			headers: { 
				'X-CSRF-TOKEN': '${_csrf.token}',
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			data:JSON.stringify(restIdList),
			async : false,
			success:function(result) {
				$("#loading").hide();
			},   
			error:function(text){
				alert("系统异常,删除失败");
				return false;
			}
		});
		// ajaxForm
		//提交表单
		var options = {
			success: function (data) {
				$(":button").attr("disabled",false);
				$("#loading").hide();
				if(data.status==0){
	     			var companyName = '<%=companyName %>';
	    			companyName=encodeURI(encodeURI(companyName))
	    			window.location.href='../findView/system.account.account-view-photo?companyName='+companyName; 
	     		}
	     	}
		};
		$("#loading").show();
		$(":button").attr("disabled",true);
		$("#uploadForm").ajaxForm(options);
		$("#uploadForm").submit();
	});
	//删除上传的预览图片 
	$(".ficate_img .del_img").live("click",function(){
		var id=isnull($("body").data("id"));
		if(id!=""){
			restIdList.push(id);
			//deleteImage(id);
			$("body").data("id","");
		}
		$(this).parent("div").find("img").attr("src","");
		$(this).parent("div").hide(); 
		$(this).parent().parent().find(".upload_thumib").show();
		$(this).parent().parent().find("input:file").val("");
	});
});
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
         <h3 class="process_title"><span>当前位置: </span><a href="system.account.account-view-photo"><%=companyName %></a> > <a href="#">编辑</a></h3>
          <div class="info_tab">
               <a href="system.account.account-view">基本信息</a>
               <a href="#" class="default">证照图片</a>
          </div>
          <form id="uploadForm" action="../company/updateCompanyImage" method="post" enctype="multipart/form-data"> 
          <div class="info_box">
               <div class="ficate">
                    <div class="ficate_con">
                    <dl class="fication">
                             <dt>— 企业三证 —</dt>
                             <dd>
                         <ul class="ficate_list"> <!--添加资质图片-->
                             <li>
                                <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="COM_GSYYZZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="previewImg(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="comGSYYZZ"><div rel="img"><img src="" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>工商营业执照</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="COM_ZZJGDM" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="previewImg(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="comZZJGDM"><div rel="img"><img src="" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>组织机构代码</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="COM_SWDJZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="previewImg(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="comSWDJZ"><div rel="img"><img src="" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>税务登记证</span>
                             </li>
                             </ul>
                             </dd>
                         </dl>
                          <dl class="fication license">
                             <dt>— 许可证 —</dt>
                             <dd>
                                 <ul class="ficate_list"> 
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="COM_SPLTXKZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="previewImg(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="comSPLTXKZ"><div rel="img"><img src="" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>食品流通许可证</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="COM_SPSCXKZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="previewImg(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="comSPSCXKZ"><div rel="img"><img src="" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>食品生产许可证</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="COM_CYFWXKZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="previewImg(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="comCYFWXKZ"><div rel="img"><img src="" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>餐饮服务许可证</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="COM_SPJYXKZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="previewImg(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="comSPJYXKZ"><div rel="img"><img src="" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>食品经营许可证</span>
                             </li>
                             </ul>
                             </dd>
                         </dl>
                         <dl class="fication">
                             <dt>— 法定代表人/负责人/业主 证件 —</dt>
                             <dd>
                                 <ul class="ficate_list"> 
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="COM_FRSFZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="previewImg(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="comFRSFZ"><div rel="img"><img src="" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>身份证</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="COM_GAJMLWNDTXZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="previewImg(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="comGAJMLWNDTXZ"><div rel="img"><img src="" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>港澳居民来往内地通行证</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="COM_TWJMLWNDTXZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="previewImg(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="comTWJMLWNDTXZ"><div rel="img"><img src="" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>台湾居民来往内地通行证</span>
                             </li>
                             </ul>
                             </dd>
                         </dl>
                         <dl class="fication license">
                             <dt>— 其它 —</dt>
                             <dd>
                                 <ul class="ficate_list"> 
                                     <li>
                                         <div class="upload_thumib">
                                              <div class="photo_upload">
                                                   <i class="i_upload_small"></i>
                                                   <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                              </div>
                                              <input name="COM_OTHER" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="previewImg(this)"/>
                                         </div>
                                         <div class="ficate_img" style="display:none;" id="comOther"><div rel="img"><img src="" id="photoPath"/></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                         <span>其它</span>
                                     </li>
                                  </ul>
                             </dd>
                         </dl>
                             <div class="clear"></div>
                         </ul>
                    </div>
               </div>
               <div class="clear"></div>
          </div>
          <p class="save_box">
             <input type="button" class="btn_save" value="保存" id="save" />
          </p>
          </form>
     </div>
</div>
</body>
</html>