<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ page import="com.wondersgroup.operation.util.security.SecurityUtils"%>
<%@page import="com.wondersgroup.framework.util.ConfigPropertiesUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta name="renderer" content="webkit" />
<title>上海市餐饮食品安全信息追溯系统-明厨亮灶公示屏</title>
<link href="../images/display/favicon.ico" rel="shortcut icon" type="image/x-icon" />
<link href="../css/display/base.css" rel="stylesheet" type="text/css" />
<link href="../css/display/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
<%
String fdWebFileURL = ConfigPropertiesUtil.getValue("fdWebFileURL");
String code=request.getParameter("code");
String time=request.getParameter("time");


%>
</script>
<script type="text/javascript" src="../js/display/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/display/jquery.easing.min.js"></script>
<script type="text/javascript" src="../js/display/method-jsonmmh.js" charset="utf-8"></script>
</head>
<body>
<div class="wrap">
    <h1 class="titles" id="companyName"></h1>
<!--     <div class="qrcode_box">
         <div class="qrcode"></div>
         <h2 class="qrcode_text">扫描查看详细信息</h2>
    </div> -->
    <div class="mainbody">
         <div class="main_left">
            <div class="mlf_con" id="public">
              <div class="mlc b1">
                <div class="con_box">
                    <div class="con_title">
                        <i class="i_tit1"></i>
                        <h3>食品安全监督公示</h3>
                    </div>
                    <div class="con_tent">
                        <div class="tent_lf" id="grade">
                            <p>检查时间：<span id="gradeDate"></span></p>
                        </div>
                        <div class="tent_rt">
                            <ul>
                                <li class="i_smile">良 好</li>
                                <li class="i_ping">一 般</li>
                                <li class="i_cry">较 差</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="con_box" style="margin-top:70px;">
                    <div class="con_title">
                        <i class="i_tit2"></i>
                        <h3>主要岗位人员公示</h3>
                    </div>
                    <div class="con_tent" id="empimg">
                        <ul class="pic_list" id="staff_list">

                        </ul>
                    </div>
                </div>
              </div>
              <div class="mlc b2">
                  <div class="con_box">
                      <div class="con_title">
                          <i class="i_tit1"></i>
                          <h3>许可证</h3>
                      </div>
                      <div class="con_tent" style="height:741px;">
                       <div class="mlc_box"  id="zzImg">
                       </div>
                      </div>
                  </div>
              </div>
            </div>
         </div>
         <div class="main_right">
         	  <div class="con_box">
                <div class="con_title">
                    <i class="i_tit3"></i>
                    <h3>食材追溯</h3>
                </div>
                <div class="con_tent" style="height:741px;">
                    <div class="mrc_box">
                        <!-- <div class="tent_empty">暂无数据</div> -->
                        <div class="mrc_tent">
                             <ul class="mrc_list" id="FoodTrace_list">
                                
                             </ul>
                        </div>
                    </div>
                </div>
            </div>
         </div>
         <div class="clearfix"></div>
  	</div>
    <div class="footer">
        <div class="footer_lf">投诉举报电话：12331</div>
        <div class="footer_rt">万达信息股份有限公司&nbsp;&nbsp;&nbsp;&nbsp;技术支持</div>
    </div>  
</div>
<script type="text/javascript" src="../js/display/custommmh.js" charset="utf-8"></script>
<script type="text/javascript">
var imgFilePath="<%=ConfigPropertiesUtil.getValue("fdWebFileURL")%>";
var Ohno={};
var code="<%=code %>";
var time="<%=time %>";
var appID;
var key;
var webdeviceId;
var deviceId;
/* 
http://localhost:8080/fdWebCompany/accredit/display?code=202011e5a56aD027881F8951HC2010310105070046
for(var i=0;i<webdeviceId.length-1;i++){
	deviceId += webdeviceId[i];
	 if(i%2==1){
		 deviceId+="-";
	 } 
} */
var zzType;
var zzNumber;
function detail(){
 	Ohno.zzType =zzType;
	Ohno.zzNumber=zzNumber;
	Ohno.appID =appID;
	Ohno.key = key;
	Ohno.deviceId =deviceId; 
	$("#FoodTrace_list").empty();
	$.ajax({
		url:"../monitorFace/monitorFaceDetailInfo",
		type:"post",
	    headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
	    data:JSON.stringify(Ohno),
	    success:function(data){
	    	if(data.status == 0){
            	var resultList=data.body;
            	var objFood = new Array();
            	for(m=0;m<resultList.length;m++){
            		var food={};
            		var manufacture=resultList[m].manufacture==""?"----":resultList[m].manufacture;
            		var inputName=resultList[m].inputName==""?"无":resultList[m].inputName;
            		var inputDate=resultList[m].inputDate;
            		food.text=manufacture;
            		food.name=inputName;
            		food.date=inputDate;
            		objFood.push(food);
            	}
            	//食材追溯
            	//食材追溯
 traceList('FoodTrace_list',objFood);
 $("#FoodTrace_list").find("li:first").addClass('default').fadeIn(500).css('display','block');
 $("#FoodTrace_list").find("li.default h5 span").addClass('first');
            	//右侧效果
            	if(objFood.length>6){
            		 traceKing('FoodTrace_list', 5000);
            	}
/*         		var i=6;
            	function aa(){
                	setTimeout(function(){
                		//$("#online tr:last").remove().prependTo("#online");
                		var xx=result_list[i].x;
                		$("").append(xx);
                		i++;
                		if(i<result_list.length){
                			aa();	
                		}else if(i>=result_list.length){
                			i=0;
                			aa();
                		}
                	},1000);
            	} */
	    	}/* else if(data.status==1&&data.message=="平台未在本系统内授权"){
	    		$(".wrap").empty().append($('<div class="error_box"><div class="error_tent"><h6 class="i_error">异常页面提示</h6><p class="error_text">访问失败！参数异常或未通过安全认证。</p></div></div>'));
	    	}else if(data.status==1&&data.message=="设备未登记"){
	    		$(".wrap").empty().append($('<div class="error_box"><div class="error_tent"><h6 class="i_error">异常页面提示</h6><p class="error_text">访问失败！参数异常或未通过安全认证。</p></div></div>'));
	    	}else if(data.status==1&&data.message=="公示单位未注册"){
	    		$(".wrap").empty().append($('<div class="error_box"><div class="error_tent"><h6 class="i_error">异常页面提示</h6><p class="error_text">公示单位未注册！请到上海市餐饮食品安全信息追溯系统（网址：ent.safe517.com）进行注册并维护公示信息。客服电话:021-54644607。</p></div></div>'));
	    	} */
	    }
	});
}
function comInfo(){
 	Ohno.zzType =zzType;
	Ohno.zzNumber=zzNumber;
	Ohno.appID =appID;
	Ohno.key = key;
	Ohno.deviceId =deviceId; 
	$("#zzImg").empty();
	$("#grade").empty();
	$("#staff_list").empty();
	$.ajax({
		url:"../monitorFace/monitorFaceComInfo",
		type:"post",
	    headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
	    data:JSON.stringify(Ohno),
	    success:function(data){
	    	if(data.status == 0){
	    		var $imgEmpty=$('<div class="tentlf_empty">暂无数据</div>');
	    		var result=data.body;
	    		var comImg=result.comImg;
 	    		if(comImg!=null){
	    			var path=imgFilePath+comImg.filePath;
	    			var $zzImg=$('<div class="mlc_box" ><img style="width:100%;height:100%" src='+path+'></img></div>');
					$("#zzImg").prepend($zzImg);
	    		}else{
	    			var $zzImg=$('<div class="tentimg_empty">暂无数据</div>');
					$("#zzImg").prepend($zzImg);
	    		}
	    		var nameAbbrev=result.nameAbbrev;
	    		var companyName=result.companyName;
	    		if(nameAbbrev==""||nameAbbrev==null){
	    			$("#companyName").text(companyName);
	    		}else{
	    			$("#companyName").text(nameAbbrev);
	    		}
	    		var grade=result.grade;
	    		var gradeDate=result.gradeDate==null?"无":result.gradeDate;
	    		if(grade==null||grade==""){
	    			$("#grade").prepend($('<div class="tentlf_empty">暂无数据</div>'));
	    			$("#gradeDate").text("无");
	    		}else if(grade=="良好"){
	    			$("#grade").prepend($('<div class="tent_img"><img src="../images/display/icon_smile_big.png"></div> <p>检查时间：<span id="gradeDate"></span></p>'));
	    			$("#gradeDate").text(gradeDate);
	    		}else if(grade=="一般"){
	    			$("#grade").prepend($('<div class="tent_img"><img src="../images/display/icon_ping_big.png"></div> <p>检查时间：<span id="gradeDate"></span></p>'));
	    			$("#gradeDate").text(gradeDate);
	    		}else if(grade=="较差"){
	    			$("#grade").prepend($('<div class="tent_img"><img src="../images/display/icon_cry_big.png"></div> <p>检查时间：<span id="gradeDate"></span></p>'));
	    			$("#gradeDate").text(gradeDate);
	    		}
	    		var empList=result.empDtoList;
	    		var jingli={};
	    		var shipin={};
	    		var chushi={};
	    		var caigou={};
	    		for(var n=0;n<empList.length;n++){
	    			if(empList[n].jobRole=="经理"){
	    				jingli.photo=(empList[n].img==null?"":imgFilePath+empList[n].img.filePath);
	    				jingli.name=empList[n].personName;
	    				jingli.jobs=empList[n].jobRole;
	    			}else if(empList[n].jobRole=="食品安全负责人"){
	    				shipin.photo=(empList[n].img==null?"":imgFilePath+empList[n].img.filePath);
	    				shipin.name=empList[n].personName;
	    				shipin.jobs=empList[n].jobRole;
	    			}else if(empList[n].jobRole=="厨师长"){
	    				chushi.photo=(empList[n].img==null?"":imgFilePath+empList[n].img.filePath);
	    				chushi.name=empList[n].personName;
	    				chushi.jobs=empList[n].jobRole;
	    			}else if(empList[n].jobRole=="采购负责人"){
	    				caigou.photo=(empList[n].img==null?"":imgFilePath+empList[n].img.filePath);
	    				caigou.name=empList[n].personName;
	    				caigou.jobs=empList[n].jobRole;
	    			}
	    		}
	    		var objStaff = new Array();
	    		if(jingli.name!=null){
	    			objStaff.push(jingli);
	    		}
	    		if(shipin.name!=null){
	    			objStaff.push(shipin);
	    		}
				if(chushi.name!=null){
	    			objStaff.push(chushi);
	    		}
				if(caigou.name!=null){
	    			objStaff.push(caigou);
	    		}
	    		//主要岗位人员公示
	    		staffList('staff_list',objStaff);
	    	}
	    }
	});
}
function staffList(id,array){
	if(array.length<1){
		var $zzImg=$('<div style ="margin:10% 30%"class="tentlf_empty">暂无数据</div>');
		$("#empimg").empty().append($zzImg);
		return false;
	}else{
    var receiveA = "";
    var objA = eval(array);
    for(var i=0; i<objA.length; i++) { 
        var liA = '<li>'+
                     '<div class="pic"><img src="'+objA[i].photo+'"></div>'+
                     '<h4>'+objA[i].name+'</h4>'+
                     '<p>'+objA[i].jobs+'</p>'+
                   '</li>';
        receiveA += liA;
    }
     if(array.length==3){
    	$("#staff_list").css({position:"absolute",left:"12.5%"});
    }else if(array.length==2){
    	$("#staff_list").css({position:"absolute",left:"25%"});
    }else if(array.length==1){
    	$("#staff_list").css({position:"absolute",left:"37.5%"});
    }
    $("#"+id).empty().append(receiveA);
    return false;}
}
$(function(){
/* 	if((code.length!=40&&code.length!=42)||(code.length==40&&code.substring(24,26)!="JY")||(code.length==42&&code.substring(24,26)!="HC")){
		$(".wrap").empty().append($('<div class="error_box"><div class="error_tent"><h6 class="i_error">异常页面提示</h6><p class="error_text">访问失败！参数异常或未通过安全认证。</p></div></div>'));
	}else{ */
		appID= code.substring(0,4);
		key= code.substring(4,12);
		webdeviceId= code.substring(12,24);
		deviceId=webdeviceId.substring(0,2)+"-"+webdeviceId.substring(2,4)+"-"+webdeviceId.substring(4,6)+"-"+webdeviceId.substring(6,8)+"-"+webdeviceId.substring(8,10)+"-"+webdeviceId.substring(10,12);
		/*  
		http://localhost:8080/fdWebCompany/accredit/display?code=202011e5a56aD027881F8951HC2010310105070046
		for(var i=0;i<webdeviceId.length-1;i++){
			deviceId += webdeviceId[i];
			 if(i%2==1){
				 deviceId+="-";
			 } 
		} */
		zzType= code.substring(24,26);
		zzNumber;
		if(zzType=="HC"){
			zzType=1;
			zzNumber="沪餐证字"+code.substring(26,42);
		}else if(zzType=="JY"){
			zzType=0;
			zzNumber="JY"+code.substring(26,40);
		}
		comInfo();
		detail();
		setInterval(comInfo,4*3600*1000);   
		setInterval(detail,3600*1000);   
	//左侧效果
	  switchPublic('public', 7500);
});
/*------jquery end------*/        
</script>		   
</body>
</html>