<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>上海市餐饮食品安全信息追溯系统</title>
<%@ include file="../include.jsp"%>	
<script type="text/javascript" src="../js/display/jquery.easing.min.js"></script>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style-info.css" rel="stylesheet" type="text/css" />
 <script src="../js/display/method-jsonmmh.js" type="text/javascript" charset="utf-8"></script>  
<style type="text/css">
html,body{margin:0;padding:0;background:#fff;
   -webkit-transform:scale(0.8,0.77); -webkit-transform-origin:11% 0;
  -moz-transform:scale(0.8,0.77); -moz-transform-origin:11% 0;
  -o-transform:scale(0.8,0.77); -o-transform-origin:11% 0;
  -ms-transform:scale(0.8,0.77); -ms-transform-origin:11% 0; 
  transform:scale(0.8,0.77); transform-origin:11% 0;
}
body{overflow:hidden;}
.textFont{display:none;font:3em/2 'Microsoft YaHei';color:rgba(0,0,0,0.5);position:absolute;bottom:-15%;left:60%; z-index:9999}
</style>
</head>
<body>
<div class="wrap">
  <h1 class="titles"  id="companyName"></h1>
<!--   <div class="qrcode_box">
       <div class="qrcode"><img src="../images/info/pic_qrcode.png"></div>
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
                          <!-- <div class="tentlf_empty">暂无数据</div> -->
                       <!--    <div class="tent_img"><img src="../images/info/icon_smile_big.png"></div> -->
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
                        <div class="mlc_box" id="zzImg">
                            <div class="mlc_inner">
                                 <div class="mlc_tent">
                                     <!-- <div class="tentimg_empty">暂无数据</div> -->
                                     <img src="../images/info/pic_yyzz.png">
                                 </div>
                            </div>
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
<script src="../js/display/custommmh.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript"> 
function detail(){
	$("#FoodTrace_list").empty();
	$.ajax({
		url:"../fdWebMonitorFace/monitorFaceDetailInfo",
		type:"post",
	    headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
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
            	 traceList('FoodTrace_list',objFood);
            	 $("#FoodTrace_list").find("li:first").addClass('default').fadeIn(500).css('display','block');
            	 $("#FoodTrace_list").find("li.default > h5 > span").addClass('first');
            	//右侧效果
            	if(objFood.length>6){
            		 traceKing('FoodTrace_list', 5000);
            	}
	    	}
	    }
	});
}
function comInfo(){
	$("#zzImg").empty();
	$("#grade").empty();
	$("#staff_list").empty();
	$.ajax({
		url:"../fdWebMonitorFace/monitorFaceComInfo",
		type:"post",
	    headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
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
	var _iframeW = screen.width-205; 
	 window.onload=function(){
	    if(_iframeW <= 1366){
	       $("html,body").css({
	            "transform":"scale(0.76,0.77)",
	             "transform-origin":"0 0"
	       });
	    }
	    if(_iframeW > 1366){
	       $("html,body").css({
	            "transform":"scale(0.8,0.77)",
	            "transform-origin":"11% 0"
	       });
	    }
	 }
		comInfo();
		detail();
 		setInterval(comInfo,4*3600*1000);   
		setInterval(detail,3600*1000);   
	//左侧效果
	  switchPublic('public', 7500); 
});
</script>
</body>
</html>