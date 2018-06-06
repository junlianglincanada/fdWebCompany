<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
table.info_mation{width:834px;}
input.checks{position:relative;top:3px;}
.checks_text {margin-left:10px;cursor:pointer;}
.checks_content{display:none;margin-left:24px;}
.checks_content b{font:normal;color:#1a73c3;}
.checks_content input.input_code{color:gray;margin-left:10px}
tr.double_checkbox td{ height:27px;padding:0 10px;}
</style>
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript" charset="utf-8"></script>	
<script src="../js/reAlert.js" type="text/javascript" charset="utf-8"></script>
<script src="../js/custome.js" type="text/javascript" charset="utf-8"></script>	

<script type="text/javascript">
var isBooth = false;
$(function(){
	//选择摊位
	$("#checks").on('change',function(){
		if(this.checked){
			isBooth=true;
			$(this).attr("checked",true);
			$(".checks_content").show();
		}else{
			isBooth=false;
			$(this).attr("checked",false);
			$(".checks_content").hide();
		}
	});
	/* $("#certNo").click(function(){
		if($("#certNo").val().trim()=="请输入证件号码"){
			$(this).val("");
		};
	}); */
	 var selData = [{
         value: "1",
         text: "餐饮服务许可证",
       }, {
         value: "2",
         text: "食品经营许可证"
       }, {
         value: "3",
         text: "食品生产许可证"
       }, {
         value: "4",
         text: "食品流通许可证"
       }, {
         value: "5",
         text: "工商营业执照"
       }];
	var result="";
	for(var i=0; i < selData.length; i++){// for循环
	    //console.log(selData[i].value);
	    result += "<option value="+selData[i].value+">" + selData[i].text + "</option>";
	}
	$("#certType").append(result);
	
	$("#certType").on('change',function(){
	   var this_v = $(this).find("option:selected").val();
	   //console.log(this_v);
	   /*if(this_v == 1){ //方法1 if()
	       $(".info_tr").hide();
	       $("#info_m1").show();
	   } else if(this_v == 2){
	       $(".info_tr").hide();
	       $("#info_m2").show();
	   } else{
	       $(".info_tr").hide();
	   }*/
	   switch(this_v){//方法2 switch()
	     case "1":
	         $(".info_tr").hide();
	         $("#info_m1").show();
	         break;
	     case "2":
	         $(".info_tr").hide();
	         $("#info_m2").show();
	         break;
	     case "3":
	         $(".info_tr").hide();
	         $("#info_m3").show();
	         break;
	     case "4":
	         $(".info_tr").hide();
	         $("#info_m4").show();
	         break;
	     case "5":
	         $(".info_tr").hide();
	         $("#info_m5").show();
	         break;
	     default:
	         $(".info_tr").hide();
	         $("#info_m5").show();
	   }
	   
	}); 
	$("#booth").blur(function(){
		$("#boothMsg").text('');
		var boothNo=$("#booth").val().trim();
		if(!isBoothNo(boothNo)){
			$("#boothMsg").text('摊位号最多输入10个数字、字母或字符');
		}
	})
	$("#certNo").blur(function(){
		$("#certMsg").text('');
		var certType=$("#certType").find("option:selected").text();
		var certNo=$("#certNo").val().trim();
		if(!checkSpecificKey(certNo)){
			$("#certMsg").text('请勿输入特殊字符');
		}
		/* if(certNo==null||certNo==""||certNo=="请输入证件号码"){
	        $(this).val("请输入证件号码").css("color","gray");
		}else{
			$(this).css("color","gray");
		} */
		if(certType=="工商营业执照"){
			if(!gszzNumber(certNo)){
				$("#certMsg").text('请输入正确证件号码');
			}
		}
		if(certType=="食品经营许可证"){
			if(!spjyNumber(certNo)){
				$("#certMsg").text('请输入正确证件号码');
			}
		}
		if(certType=="食品流通许可证"){
			if(!spltNumber(certNo)){
				$("#certMsg").text('请输入正确证件号码');
			}
		}
		if(certType=="食品生产许可证"){
			if(!spscNumber(certNo)){
				$("#certMsg").text('请输入正确证件号码');
			}
		}
		if(certType=="餐饮服务许可证"){
			if(!cyfwNumber(certNo)){
				$("#certMsg").text('请输入正确证件号码');
			}
		}
	});
	
 	/* $("#certType").change(function(){
		var certType=$("#certType").find("option:selected").text();
		if(certType=="工商营业执照"){
			$("#certNo").attr("maxlength","18");
		}
		if(certType=="食品经营许可证"){
			$("#certNo").attr("maxlength","16");
		}
		if(certType=="食品流通许可证"){
			$("#certNo").attr("maxlength","18");
		}
		if(certType=="食品生产许可证"){
			$("#certNo").attr("maxlength","14");
		}
	})  */
	$(".btn_save").click(function(){
		$("#certMsg").empty();
		$("#boothMsg").empty();
		var certType=$("#certType").find("option:selected").text();
		var certNo=$("#certNo").val();
		var certData=$("#certType").val();
		var ct="";
		var certflag=true;
		if(certType=="工商营业执照"){
			//certType="BIZ_CERT_NUMBER";
			if(!gszzNumber(certNo)){
				certflag=false;
			}
		}
		if(certType=="食品流通许可证"){
			//certType="FOOD_CIRCU_CERT";
			ct="foodCircuCert";
			if(!spltNumber(certNo)){
				certflag=false;
			}
		}
		if(certType=="食品生产许可证"){
			//certType="FOOD_PROD_CERT";
			ct="foodProdCert";
			if(!spscNumber(certNo)){
				certflag=false;
			}
		}
		if(certType=="餐饮服务许可证"){
			//certType="CATERING_CERT";
			ct="cateringCert";
			if(!cyfwNumber(certNo)){
				certflag=false;
			}
		}
		if(certType=="食品经营许可证"){
			//certType="FOOD_BUSINESS_CERT";
			ct="foodBusinessCert";
			if(!spjyNumber(certNo)){
				certflag=false;
			}
		}
		if(certNo==""||certNo==null||certNo=="请输入证件号码"){
			$("#certMsg").text('证件号码不能为空');
			return;
		}
		if(!checkSpecificKey(certNo)){
			$("#certMsg").text('请勿输入特殊字符');
			return;
		}
		console.log(certflag);
		if(!certflag){
			$("#certMsg").text('请输入正确证件号码');
			return;
		}
		if(isBooth){
			var boothNo=$("#booth").val().trim();
			if(!isBoothNo(boothNo)){
				$("#boothMsg").text('摊位号最多输入10个数字、字母或字符');
				return;
			}else{
				certNo+="-"+boothNo;
			}
		}
		var params={'certType':certType,'certNo':certNo};
		var certParams={'certType':ct,'certNo':certNo};
		var flag=true;
		$.ajax({
			url: "../register/isCertExist",
			type:"post",
			headers: { 
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			data:JSON.stringify(certParams),
			async:false,
			success:function(result){
				flag=result.body;
			}
		});
		if(flag==true){
			$("#certMsg").text('该证件号码已被注册');
			return;
		}
		$.ajax({
			url: "../register/getCompanyByCert",
			type:"post",
			headers: { 
				'Accept': 'application/json',
				'Content-Type': 'application/json' 
			},
			dataType:'json',
			data:JSON.stringify(params),
			success:function(result){
				console.log(result);
				if(result.body!=null){
					var companyName=encodeURI(encodeURI(result.body.companyName));
					var companyBizAddress=encodeURI(encodeURI(isnull(result.body.companyBizAddress)));
					var companyNameAbbrev=encodeURI(encodeURI(isnull(result.body.companyNameAbbrev)));
					var companyRegAddress=encodeURI(encodeURI(isnull(result.body.companyRegAddress)));
					certType=encodeURI(encodeURI(certType));
					certNo=encodeURI(encodeURI(certNo));
					var endDate=result.body.endDate;
					var regionProvinceId=result.body.regionProvinceId;
					var regionCityId=result.body.regionCityId;
					var regionCountyId=result.body.regionCountyId;
					var regionStreetId=result.body.regionStreetId;
					if(regionStreetId == null || regionCountyId == null || isnull(result.body.companyRegAddress) == '' || regionCityId == null || regionProvinceId == null){
						certData = parseInt(certData) + 10;
					}
					window.location.href="reg_second.jsp?flag=1&certData="+certData+"&certType="+certType+"&certNo="+certNo+"&endDate="+endDate+"&companyName="+companyName+"&companyBizAddress="+companyBizAddress+"&companyNameAbbrev="+companyNameAbbrev+"&companyRegAddress="+companyRegAddress+"&regionProvinceId="+regionProvinceId+"&regionCityId="+regionCityId+"&regionCountyId="+regionCountyId+"&regionStreetId="+regionStreetId;
				}else{
					certNo=encodeURI(encodeURI(certNo));
					window.location.href="reg_second.jsp?certType="+certType+"&certNo="+certNo;
				}
			},
			error: function(data) {
				console.log("加载失败，请重试！");
			}
		});
	});
})

</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="reg_fh"><a href=".." target="_top"><i class="i_fh"></i><span>返回</span></a></h3>
          <div class="reg_tent">
               <div class="reg_title">
                    <ul class="reg_list">
                        <li class="default"><span><i>1</i><em>验证</em></span></li>
                        <li><span><i>2</i><em>注册</em></span></li>
                        <li><span><i>3</i><em>完成</em></span></li>
                    </ul>
               </div>
               <div class="reg_detail">
                     <div class="info_box" style="min-height:200px;">
                         <table class="info_mation" style="width:847px;">
                            <tr>
                                 <td class="td_lf"><em class="star">*</em>证件类型</td>
                                 <td>
                                     <div class="select_s" style="width:182px; float:left;">
                                      <div class="select_is" style="width:182px;">
                                         <select class="select_cs" style="width:212px; background-position:-12px -122px;" id="certType">
                                              <!--   <option value="1"></option>-->
                                         </select>
                                       </div>
                                     </div>
                                     <input type="text" class="input_code" style="float:left;margin-left:10px; color:gray;" placeholder="请输入证件号码" id="certNo" maxlength="30"/>
                                  <span class="text_ts" id="certMsg"></span>
                                 </td>
                            </tr>
                            <tr class="double_checkbox">
                                 <td class="td_lf"></td>
                                 <td>
                                    <input type="checkbox" class="checks" id="checks" />
                                    <label for="checks" class="checks_text">卖场内的摊位</label>
                                    <span class="checks_content"><em class="star">*</em><b>摊位号</b><input type="text" class="input_code" maxlength="10" placeholder="请输入摊位编号" value="" id="booth"/><span class="text_ts" id="boothMsg"></span></span>
                                 </td>
                            </tr> 
                            <tr>
                                <td colspan="2" class="gray">注：企业注册请选择餐饮许可证或经营许可证，如没有许可证请使用工商营业执照注册；<br/>
                                &nbsp;&nbsp;无许可证的卖场摊位业主，需使用大卖场的许可证，填写摊位号进行注册；有许可证的业主，可直接注册，不要填写摊位号。</td>
                            </tr>
                            <tr class="info_tr" id="info_m1" style="display:table-row">
                                <td colspan="2" class="left" style="padding-left:20%;">
                                    <img src="../images/reg_f5.jpg"/>
                                    <p>餐饮服务许可证 请填写此字段</p>
                                </td>
                            </tr>
                            <tr class="info_tr" id="info_m2">
                                <td colspan="2" class="left" style="padding-left:20%;">
                                    <img src="../images/reg_f2.jpg">
                                    <p>食品经营许可证 请填写此字段</p>
                                </td>
                            </tr>
                            <tr class="info_tr" id="info_m3">
                                <td colspan="2" class="left" style="padding-left:20%;">
                                    <img src="../images/reg_f3.jpg">
                                    <p>食品生产许可证 请填写此字段</p>
                                </td>
                            </tr>
                            <tr class="info_tr" id="info_m4">
                                <td colspan="2" class="left" style="padding-left:20%;">
                                    <img src="../images/reg_f4.jpg"/>
                                    <p>食品流通许可证 请填写此字段</p>
                                    
                                </td>
                            </tr>
                             <tr class="info_tr" id="info_m5">
                                <td colspan="2" class="left" style="padding-left:10%;">
                                    <img src="../images/reg_f11.jpg"/>
                                    <p>工商营业执照 （旧版15位）， 请填写此字段</p>
                                    <img src="../images/reg_f12.jpg"/>
                                    <p>工商营业执照 （新版18位）， 请填写此字段</p>
                                </td>
                            </tr>
                            
                          </table>
                    </div>
                    <p class="save_box">
                       <input type="button" class="btn_save" value="下一步"/>
                    </p>
               </div>
         	</div>
     </div>
</div>
</body>
</html>