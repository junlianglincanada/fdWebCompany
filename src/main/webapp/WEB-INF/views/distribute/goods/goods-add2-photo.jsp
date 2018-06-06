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
dl.license{width:50%; margin-right:0px; }
dl.license dd ul.ficate_list li{width:126px;}
dl.license dd ul.ficate_list li .ficate_img{padding:15px 2px 5px 2px;}
</style>
<script type="text/javascript">
var imageTypes=["REC_OTHER","REC_GSYYZZ","REC_ZZJGDM","REC_SWDJZ","REC_FRSFZ","REC_GAJMLWNDTXZ","REC_TWJMLWNDTXZ","REC_SPLTXKZ","REC_SPSCXKZ","REC_CYFWXKZ","REC_SPJYXKZ"];
var restIdList=new Array;
var id=<%=id%>;
function upload(obj){
	if($.browser.msie){
		var ie=$.browser.version;
		if(ie!="11.0"&&ie!="10.0"){
			alert("上传图片,目前暂不支持IE 9及以下版本");
			return false;
		}
	}
	if (obj.files && obj.files[0]){
		var picval = parseInt(obj.files[0].size/1048576);
		if (picval >= 1){
			alert(obj.files[0].name + ",尺寸为大于1 M," + " " + "上传图片建议小于1M");
			obj.value=null;
			return;
		}
	}
	//提交表单
	var options = {
		success: function (result) {
			search(id);
		}
	};
	// ajaxForm
	$("#uploadForm").ajaxForm(options);
	$("#uploadForm").submit();
	$("#small_upload").val("");
}
function search(id){
	$("#loading").show();
	$.ajax({
		url:"../inputManage/receiver/queryReceiverImage/"+id,
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
				var supGSYYZZ=result.body.REC_GSYYZZ;
				var supZZJGDM=result.body.REC_ZZJGDM;
				var supSWDJZ=result.body.REC_SWDJZ;
				var supFRSFZ=result.body.REC_FRSFZ;
				var supGAJMLWNDTXZ=result.body.REC_GAJMLWNDTXZ;
				var supTWJMLWNDTXZ=result.body.REC_TWJMLWNDTXZ;
				var supSPLTXKZ=result.body.REC_SPLTXKZ;
				var supSPSCXKZ=result.body.REC_SPSCXKZ;
				var supCYFWXKZ=result.body.REC_CYFWXKZ;
				var supOther=result.body.REC_OTHER;
				var supSPJYXKZ=result.body.REC_SPJYXKZ;
				if(supSPJYXKZ!=null&&supSPJYXKZ.length>0){
					var path=imgFilePath+supSPJYXKZ[0].filePath;
					$("#supSPJYXKZ").find("img").attr("src",path);
					var id=supSPJYXKZ[0].id;
					$("#supSPJYXKZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#supSPJYXKZ").prev().hide();
					$("#supSPJYXKZ").show();
				}
				if(supGSYYZZ!=null&&supGSYYZZ.length>0){
					var path=imgFilePath+supGSYYZZ[0].filePath;
					$("#supGSYYZZ").find("img").attr("src",path);
					var id=supGSYYZZ[0].id;
					$("#supGSYYZZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#supGSYYZZ").prev().hide();
					$("#supGSYYZZ").show();
				}
				if(supZZJGDM!=null&&supZZJGDM.length>0){
					var path=imgFilePath+supZZJGDM[0].filePath;
					$("#supZZJGDM").find("img").attr("src",path);
					var id=supZZJGDM[0].id;
					$("#supZZJGDM").find("a").attr("onclick","deleteImage("+id+")");
					$("#supZZJGDM").prev().hide();
					$("#supZZJGDM").show();
				}
				if(supSWDJZ!=null&&supSWDJZ.length>0){
					var path=imgFilePath+supSWDJZ[0].filePath;
					$("#supSWDJZ").find("img").attr("src",path);
					var id=supSWDJZ[0].id;
					$("#supSWDJZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#supSWDJZ").prev().hide();
					$("#supSWDJZ").show();
				}
				if(supFRSFZ!=null&&supFRSFZ.length>0){
					var path=imgFilePath+supFRSFZ[0].filePath;
					$("#supFRSFZ").find("img").attr("src",path);
					var id=supFRSFZ[0].id;
					$("#supFRSFZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#supFRSFZ").prev().hide();
					$("#supFRSFZ").show();
				}
				if(supGAJMLWNDTXZ!=null&&supGAJMLWNDTXZ.length>0){
					var path=imgFilePath+supGAJMLWNDTXZ[0].filePath;
					$("#supGAJMLWNDTXZ").find("img").attr("src",path);
					var id=supGAJMLWNDTXZ[0].id;
					$("#supGAJMLWNDTXZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#supGAJMLWNDTXZ").prev().hide();
					$("#supGAJMLWNDTXZ").show();
				}
				if(supTWJMLWNDTXZ!=null&&supTWJMLWNDTXZ.length>0){
					var path=imgFilePath+supTWJMLWNDTXZ[0].filePath;
					$("#supTWJMLWNDTXZ").find("img").attr("src",path);
					var id=supTWJMLWNDTXZ[0].id;
					$("#supTWJMLWNDTXZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#supTWJMLWNDTXZ").prev().hide();
					$("#supTWJMLWNDTXZ").show();
				}
				if(supSPLTXKZ!=null&&supSPLTXKZ.length>0){
					var path=imgFilePath+supSPLTXKZ[0].filePath;
					$("#supSPLTXKZ").find("img").attr("src",path);
					var id=supSPLTXKZ[0].id;
					$("#supSPLTXKZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#supSPLTXKZ").prev().hide();
					$("#supSPLTXKZ").show();
				}
				if(supSPSCXKZ!=null&&supSPSCXKZ.length>0){
					var path=imgFilePath+supSPSCXKZ[0].filePath;
					$("#supSPSCXKZ").find("img").attr("src",path);
					var id=supSPSCXKZ[0].id;
					$("#supSPSCXKZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#supSPSCXKZ").prev().hide();
					$("#supSPSCXKZ").show();
				}
				if(supCYFWXKZ!=null&&supCYFWXKZ.length>0){
					var path=imgFilePath+supCYFWXKZ[0].filePath;
					$("#supCYFWXKZ").find("img").attr("src",path);
					var id=supCYFWXKZ[0].id;
					$("#supCYFWXKZ").find("a").attr("onclick","deleteImage("+id+")");
					$("#supCYFWXKZ").prev().hide();
					$("#supCYFWXKZ").show();
				}
				if(supOther!=null&&supOther.length>0){
					var path=imgFilePath+supOther[0].filePath;
					$("#supOther").find("img").attr("src",path);
					var id=supOther[0].id;
					$("#supOther").find("a").attr("onclick","deleteImage("+id+")");
					$("#supOther").prev().hide();
					$("#supOther").show();
				}
				$("#loading").hide();
			}
		},   
		error:function(e) {
			console.log(e);
		}
	});
}
function deleteImage(attachId){
	restIdList.push(attachId);
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
		success:function(result) {
			console.log(result.body);
			if(result.status==0){
				search(id);
			}
		},   
		error:function(text){
			return false;
		}
	});
}
$(function(){
	search(id);
	//删除上传的预览图片 
	$(".ficate_img a.del_img").live("click",function(){
		$(this).parent("div").find("img").attr("src","");
		$(this).parent("div").hide(); 
		$(this).parent().parent().find(".upload_thumib").show();
		$(this).parent().parent().find("input:file").val("");
	});
	<%-- $(".btn_save").click(function(){
		window.location.href="../findView/distribute.goods.goods";
	}); --%>
});
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="../findView/distribute.goods.goods">收货商管理</a> > <a href="#">添加收货商</a> </h3>
          <div class="info_tab">
               <a href="../findView/distribute.goods.goods-add2">基本信息</a>
               <a href="../findView/distribute.goods.goods-add2-photo?id=<%=id %>" class="default">证照<em style="font-style:normal;position:relative;top:1px;letter-spacing:1px;">图</em>片</a>
          </div>
          <form id="uploadForm" action="../inputManage/receiver/updateReceiverImage/<%=id %>" method="post" enctype="multipart/form-data"> 
          <div class="info_box">
               <div class="ficate">
                    <div class="ficate_con" style="min-width:996px;">
                         <dl class="fication">
                             <dt>— 企业三证 —</dt>
                             <dd>
                                 <ul class="ficate_list">
                                  <li>
                                <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="REC_GSYYZZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="javascript:upload(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="supGSYYZZ"><div rel="img"><img src="" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>工商营业执照</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="REC_ZZJGDM" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="javascript:upload(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="supZZJGDM"><div rel="img"><img src="" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>组织机构代码</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="REC_SWDJZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="javascript:upload(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="supSWDJZ"><div rel="img"><img src="" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>税务登记证</span>
                             </li>
                                  </ul>
                             </dd>
                         </dl>
                         <dl class="fication license">
                             <dt>— 许可证  —</dt>
                             <dd>
                                 <ul class="ficate_list"> 
                              <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="REC_SPLTXKZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="javascript:upload(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="supSPLTXKZ"><div rel="img"><img src="" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>食品流通许可证</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="REC_SPSCXKZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="javascript:upload(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="supSPSCXKZ"><div rel="img"><img src="" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>食品生产许可证</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="REC_CYFWXKZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="javascript:upload(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="supCYFWXKZ"><div rel="img"><img src="" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>餐饮服务许可证</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="REC_SPJYXKZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="javascript:upload(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="supSPJYXKZ"><div rel="img"><img src="" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
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
                                      <input name="REC_FRSFZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="javascript:upload(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="supFRSFZ"><div rel="img"><img src="" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>身份证</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="REC_GAJMLWNDTXZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="javascript:upload(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="supGAJMLWNDTXZ"><div rel="img"><img src="" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                 <span>港澳居民来往内地通行证</span>
                             </li>
                             <li>
                                 <div class="upload_thumib">
                                      <div class="photo_upload">
                                           <i class="i_upload_small"></i>
                                           <em class="upload_small_text">上传图片<br/>建议小于1M</em>
                                      </div>
                                      <input name="REC_TWJMLWNDTXZ" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="javascript:upload(this)"/>
                                 </div>
                                 <div class="ficate_img" style="display:none;" id="supTWJMLWNDTXZ"><div rel="img"><img src="" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
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
                                              <input name="REC_OTHER" accept=".jpg,.png,.gif" type="file" class="small_upload" id="small_upload" onChange="javascript:upload(this)" />
                                         </div>
                                         <div class="ficate_img" style="display:none;" id="supOther"><div rel="img"><img src="" /></div><a href="javascript:void(0)" class="del_img" title="删除"></a></div>
                                         <span>其它</span>
                                     </li>
                                  </ul>
                             </dd>
                         </dl>
                         <div class="clear"></div>
                    </div>
               </div>
               <div class="clear"></div>
              <!--  <p class="save_box">
                  <input type="button" class="btn_save" value="保存" />
               </p> -->
          </div>
          </form>
     </div>
</div>   
</body>
</html>