<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ page import="com.wondersgroup.operation.util.security.SecurityUtils"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>万达食品安全追溯系统</title>
<%@ include file="../include.jsp" %>
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?bd3f1ac578ad9b2cdbde2938f245197a";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
<style type="text/css">
.red1 {
	color: #e60012;
	margin: 0 0px;
	display: inline-block;
	width: 40px;
	text-align: center;
}
.business_sel{ width:86px; height:74px; padding:10px 22px 20px 1px; overflow:hidden; background:url(../images/i_arrow.png) -92px -520px no-repeat;    position: absolute;
    top: -2px;
    right: 60.4%;
    z-index: 588;}
.business_sel span{ color:#a08100;font:12px/30px 'Microsoft YaHei'; display:block; text-align:center;}
.business_sel span.bs_title{font-size:12px;}
.business_sel span.bs_text{font-size:19px;font-weight:bold;margin-top:3px;text-shadow:0 0 0 #000;cursor:pointer;}
.filp{-webkit-animation:flipY 0.5s 0.2s ease both;animation:flipY 0.5s 0.2s ease both;}
@-webkit-keyframes flipY{
     0% {-webkit-transform:perspective(36px) rotateY(0deg); opacity:0;}
     40%{-webkit-transform:perspective(36px) rotateY(-10deg);opacity:.4;}
     70%{-webkit-transform:perspective(36px) rotateY(10deg); opacity:.7;}
     100%{-webkit-transform:perspective(36px) rotateY(0deg); opacity:1;}
}
@keyframes flipY{
     0% {-webkit-transform:perspective(36px) rotateY(0deg); opacity:0;}
     40%{-webkit-transform:perspective(36px) rotateY(-10deg);opacity:.4;}
     70%{-webkit-transform:perspective(36px) rotateY(10deg); opacity:.7;}
     100%{-webkit-transform:perspective(36px) rotateY(0deg); opacity:1}
 }
 .bs_s1,.bs_s2{width:86px;height:63px;oveflow:hidden;}
.bs_s1{display:block;}
.bs_s2{display:none;padding-top:2px;}
.bs_s2 a{display:block;height:16px;padding:5px 0 2px 5px;}
.bs_s2 a em{font:14px/16px 'Microsoft YaHei'; color:#a08100;float:left;margin-left:2px;}
.bs_s2 a:hover em{color:#8b7103;}
i.i_sel{display:inline-block;width:16px;height:16px;overflow:hidden;background:url(../images/icon_select.png) 50% 100% no-repeat;float:left;margin-top:1px;}
.bs_s2 a.default i.i_sel{background-position:50% 0;}
</style>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="#">首页</a></h3>
                <div class="gap_box">
           <div class="business_sel">
               <div class="bs_s1" title="点击更改营业状态">
                    <span class="bs_title">营业状态</span>
                    <span class="bs_text" id="businessstatus">营业中</span>
               </div>
               <form id="addForm">
               <div class="bs_s2">
                    <a href="javascript:void(0)"><i class="i_sel"></i><em>继续营业</em></a>
                    <a href="javascript:void(0)"><i class="i_sel"></i><em>暂时停业</em></a>
                    <a href="javascript:void(0)"><i class="i_sel"></i><em>永久停业</em></a>
               </div>
               </form>
          </div>
          <div class="check" style="display:none">
               <!-- <span class="check_blue">最近检查：</span> -->
               
               <!-- <i class="i_c1">笑</i> --><!--<i class="i_c2">平</i><i class="i_c1">哭</i>-->
               <!-- <span class="check_text" id="gradeText">良好</span> -->
               <span class="check_date" id="evalDate"></span>
          </div>
            <div class="integral"><span class="integral_text">当前积分</span><span class="integral_num" id="jf">0</span></div>
               </div>
           <div class="notice">
               <h4 class="title">最新通知公告</h4>
               <ul class="notice_link" id="notice_link">
                 <!--   <li>
                       <span ></span>
                       <a href="" id="titleNotice">查看详情</a>
                   </li> -->
               </ul>
               <div class="clear"></div>
          </div>
          <div class="warning">
               <h4 class="title">预警提示</h4>
               <ul class="warning_link">
	              
                   <li>
                       <a class="my_href"  href="javascript:(0);"  my_href="tzyj" rel="findView/exception.exception-parameter?newSearch=1" style="height:158px;">
                          <i class="i_w3"></i>
                          <h5>台账预警</h5>
                          <p>进货台账：超过<span id="jh" class="red">0</span>天未录入</p>
                          <p>配送台账：超过<span id="ps" class="red">0</span>天未录入</p>
                          <p>留样台账：超过<span id="ly" class="red">0</span>天未录入</p>
                          <p>废弃油脂台账：超过<span id="fq" class="red">0</span>天未录入</p>
                          <p>餐厨垃圾回收台账：超过<span id="lj" class="red">0</span>天未录入</p>
                       </a>
                   </li>
                   <li>
                       <a class="my_href"  href="javascript:(0);"  my_href="zzyj" rel="findView/exception.exception-Certificate?newSearch=1" style="height:158px;">
                          <i class="i_w4"></i>
                          <h5>证照预警</h5>
                          <p>工商营业执照：<span style="margin-left:13px;">已过期</span><span class="red" id="gs">0</span>家 <span style="margin-left:15px;">快过期</span><span class="red" id="gsk">0</span>家</p>
                          <p>餐饮服务许可证：已过期<span class="red" id="cy">0</span>家 <span style="margin-left:15px;">快过期</span><span class="red" id="cyk">0</span>家</p>
                          <p>食品生产许可证：已过期<span class="red" id="sc">0</span>家 <span style="margin-left:15px;">快过期</span><span class="red" id="spk">0</span>家</p>
                          <p>食品流通许可证：已过期<span class="red" id="lt">0</span>家 <span style="margin-left:15px;">快过期</span><span class="red" id="ltk">0</span>家</p>
                          <p>食品经营许可证：已过期<span class="red" id="jy">0</span>家 <span style="margin-left:15px;">快过期</span><span class="red" id="jyk">0</span>家</p>

					   </a>
                   </li>
                    <li>
                       <a class="my_href"  href="javascript:(0);" my_href="ryyj" rel="findView/exception.exception-warn?newSearch=1">
                          <i class="i_w1"></i>
                          <h5>人员预警</h5>
                          <p>健康证：已过期<span class="red" id="jk">0</span>人 <span style="margin-left:25px;">快过期</span><span class="red" id="jkk">0</span>人</p>
                          <p>培训证：已过期<span class="red" id="px">0</span>人 <span style="margin-left:25px;">快过期</span><span class="red" id="pxk">0</span>人</p>
                       </a>
                   </li>
               </ul>
               <div class="clear"></div>
          </div>
         <%--  <div class="entrance">
               <h4 class="title">便捷入口</h4>
               <ul class="entrance_link">
                   <li>
                       <a href="<%=webPath %>/findView/replenish.purchased.purchased-add">
                          <i class="i_e1"></i>
                          <span>新增采购品</span>
                       </a>
                   </li>
                   <li>
                       <a href="<%=webPath %>/findView/replenish.into.into">
                          <i class="i_e2"></i>
                          <span>新增进货</span>
                       </a>
                   </li>
                   <li>
                       <a href="<%=webPath %>/findView/distribute.output.output-add">
                          <i class="i_e3"></i>
                          <span>新增产出品</span>
                       </a>
                   </li>
                   <li>
                       <a href="<%=webPath %>/findView/replenish.send.output-add" target="mainFrame">
                          <i class="i_e4"></i>
                          <span>新增发货</span>
                       </a>
                   </li>
               </ul>
               <div class="clear"></div>
          </div>  --%>
          <div class="statis">
               <h4 class="title">统计</h4>
               <div class="statis_con">
                    <div class="statis_charts" id="purchased"></div>
                    <div class="statis_charts" id="goods"></div>
                    <div class="statis_charts" id="supplier"></div>
                    <div class="statis_charts" id="customer"></div>
               </div>
               <div class="clear"></div>
          </div> 
                    <div class="mobile">
               <h4 class="title">下载移动端</h4>
               <ul class="download_list">
                   <li>
                        <h6 class="text_f"><i class="icon_f icon_f1"></i> <span>iPhone客户端</span></h6>
                        <a href="https://www.pgyer.com/El86" class="btn_download" target="_blank"><i class="icon_d"></i> <span>App store下载</span></a>
                        <div class="download_qrcode" id="qrcode_ios"><!--<img src="../images/ios.jpg" />--></div>
                   </li>
                   <li class="last">
                        <h6 class="text_f"><i class="icon_f icon_f2"></i> <span>Android客户端</span></h6>
                        <a href="https://www.pgyer.com/4bQb" class="btn_download" target="_blank"><i class="icon_d"></i> <span>本地下载</span></a>

                        <div class="download_qrcode" id="qrcode_android"><!--<img src="../images/android.jpg" />--></div>
                   </li>
                </ul>
               <div class="clear"></div>
          </div>  
     </div>
</div>
  
<script src="../js/highcharts/highcharts.js" charset="utf-8"></script>
<script src="../js/highcharts/highcharts-more.js" charset="utf-8"></script>
<script src="../js/highcharts/solid-gauge.js" charset="utf-8"></script>
<script src="../js/jquery.qrcode.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
var countInputMaterial=[];
var countOutputMaterial=[];
var countReceivers=[];
var countSuppliers=[];
var maxcount;

String.prototype.trimcode=function() {
    return this.replace(/(^\"*)|(\"*$)/g,'');
};
function is0(Object){
	if(Object==""||Object==null||Object=="null"){
		return 0;
	}
	return Object;
}
var params={};
params.sortBy="";
params.sortDirection="";

//查询预警信息
function searchWarn(){
	 $.ajax({
			url: "../getHomeExceptionController",
			type:"post",
		    headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    dataType:'json',
			success:function(result) {
			if(result.status==0){
				var dataResult=isnull(result.body);
				if(dataResult!=""){
					$("#gs").text(is0(dataResult.gs));
					$("#gsk").text(is0(dataResult.gsk));
					$("#cy").text(is0(dataResult.cy));
					$("#cyk").text(is0(dataResult.cyk));
					$("#sc").text(is0(dataResult.sc));
					$("#sck").text(is0(dataResult.sck));
					$("#lt").text(is0(dataResult.lt));
					$("#ltk").text(is0(dataResult.ltk));
					$("#jy").text(is0(dataResult.jy));
					$("#jyk").text(is0(dataResult.jyk));
					
					$("#jk").text(is0(dataResult.jk));
					$("#jkk").text(is0(dataResult.jkk));
					$("#px").text(is0(dataResult.px));
					$("#pxk").text(is0(dataResult.pxk));
					
					if(dataResult.jhtz==-1||dataResult.jhtz=="-1"){
						$("#jh").parent().html('进货台账：<span id="jh" class="red1">未录入</span>');
					}else{
						$("#jh").text(is0(dataResult.jhtz));
					}
					if(dataResult.pstz==-1||dataResult.pstz=="-1"){
						$("#ps").parent().html('配送台账：<span id="ps" class="red1">未录入</span>');
					}else{
						$("#ps").text(is0(dataResult.pstz));
						
					}					
					if(dataResult.yztz==-1||dataResult.yztz=="-1"){
						$("#fq").parent().html('废弃油脂回收台账：<span id="fq" class="red1">未录入</span>');
					}else{
						$("#fq").text(is0(dataResult.yztz));
					
					}					
					if(dataResult.ljtz==-1||dataResult.ljtz=="-1"){
						$("#lj").parent().html('餐厨垃圾回收台账：<span id="lj" class="red1">未录入</span>');
					}else{
						$("#lj").text(is0(dataResult.ljtz));
					}					
					if(dataResult.lytz==-1||dataResult.lytz=="-1"){
						$("#ly").parent().html('留样台账：<span id="ly" class="red1">未录入</span>');
					}else{
						$("#ly").text(is0(dataResult.lytz));
					}
					
				}
			}
			},
			 error:function(text) {
				 console.log(text);
			 }
			
		}); 
}

//查询通知公告 和积分
function searchNotice(){
 	 $.ajax({
 		url: "../getHomeIntegralController",
 		type:"post",
 	    headers: { 
 	        'Accept': 'application/json',
 	        'Content-Type': 'application/json' 
 	    },
 	    dataType:'json',
 		success:function(data) {
 		if(data.status==0){
 			$("#notice_link").children().remove();
 			var result=isnull(data.body);
 			if(result!=""){
 				var resultList=result.notice;
 				if(resultList!=null){
 					for(var i=0;i<resultList.length;i++){
 						var idNotice=resultList[i].ID;
 						var title=isnull(resultList[i].TITLE);
 						var li=$('<li><span>'+title+'</span><a class="my_href" my_href="tzgg" href="javascript:(0);" rel="findView/publishContent.publishContentDetail?id='+idNotice+'" id="titleNotice">查看详情</a></li>');
 						$("#notice_link").append(li);
 					}
 				}
 					$("#jf").text(is0(result.jf));
 					var grade=isnull(result.grade);
 					if(grade==""){
 						$(".gap_box").css({width:230});
 						$(".business_sel").css({right:"43.5%"}); 
 					}else{
 	 					if(grade=="良好"){
 	 						$(".check").show();
 	 						/* $(".business_sel").css({right:"19.5%"}); */
 	 						$("#evalDate").after('<i class="i_c1"></i>');
 	 						//$("#gradeText").text("良好");
 	 					}
 	 					if(grade=="一般"){
 	 						$(".check").show();
 	 						/* $(".business_sel").css({right:"19.5%"}); */
 	 						$("#evalDate").after('<i class="i_c2"></i>');
 	 						//$("#gradeText").text("一般");
 	 					}
 	 					if(grade=="较差"){
 	 						$(".check").show();
 	 					/* 	$(".business_sel").css({right:"19.5%"}); */
 	 						$("#evalDate").after('<i class="i_c3"></i>');
 	 						//$("#gradeText").text("较差");
 	 					}
 					}

 					var time = isnull(result.evalDate);
 					time = time.substr(0,10);
 					$("#evalDate").text(time);
 			}
 		}
 		},
 		 error:function(text) {
 			 console.log(text);
 		 }
 		
 	});
}

setInterval("searchWarn()",600000);
function getStatus(){
	$.ajax({
		url:"../company/getBusinessStatus",
		type:"post",
	    headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
	    success:function(data){
	    	if(data.status == 0){
	    		var result=isnull(data.body);
	    		if(result!=null){
	    			if(result.targetStatus == "NORMAL"){
	    				$("#businessstatus").text("营业中");
	    			}else if(result.targetStatus == "TEMP_CLOSED"){
	    				$("#businessstatus").text("暂停营业");
	    			}else if(result.targetStatus == "PERM_CLOSED"){
	    				$("#businessstatus").text("永久停业");
	    			}
	    		}
	    	}
	    }
	});
}
$(function(){
	getStatus();
	Mouse();
	Mouse2();
	searchNotice();
	searchWarn();
	selCss();
	$.ajax({
		url:"../getStatistics",
		type:"get",
	    headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
	    dataType:'json',
		success:function(text) {
			if(text.status==0){
				var body=text.body;
				countInputMaterial.push(body.countInputMaterial);
				countOutputMaterial.push(body.countOutputMaterial);
				countReceivers.push(body.countReceivers);
				countSuppliers.push(body.countSuppliers);
				var	tmp=new Array(body.countInputMaterial,body.countOutputMaterial,body.countReceivers,body.countSuppliers);
				maxcount=tmp[0];
				for(var i=1;i<tmp.length;i++){ 
					  if(maxcount<tmp[i])maxcount=tmp[i];}
				show();
			}
		 
		 },   
		 error:function(text) {
         
		 }
		});
   show();
	$("body").on("click",".my_href",function(){
		tabNav(this);
		return false;
	})
});	

function selCss(){ 
	   $(".bs_s1").click(function(){
	        if($(".bs_s2").is(":hidden")){
	         	  $(".bs_s1").removeClass("filp").stop().hide();
	              $(".bs_s2").addClass("filp").stop().show();
	        }
	   });
	   $(".bs_s2 a").click(function(){
		    ajaxFlag=true;
		    var params2 = {};
		    if($(this).hasClass("default")){
		    	$(this).removeClass("default");
		    }
	        if(!$(this).hasClass("default")){
	            $(this).addClass("default").siblings().removeClass("default");
	            var _text = $(this).find("em").text();
	            var targetStatus;
	            if(_text =="继续营业"){
	            	$(".bs_text").text("营业中");
	            	 targetStatus="NORMAL";
	            }else if(_text =="暂时停业"){
	            	$(".bs_text").text($(this).find("em").text());
	            	 targetStatus="TEMP_CLOSED";
	            }else if(_text =="永久停业"){
	            	$(".bs_text").text($(this).find("em").text());
	            	 targetStatus="PERM_CLOSED";
	            }
	            //alert(targetStatus);
	            //params2.targetStatus=targetStatus;
	            $.ajax({
						url: "../company/setBusinessStatus",
						type:"post",
						dataType:'json',
						data:{"targetStatus":targetStatus},
			            success: function (result) {
			                if (result.status == 0){
			                }else{
			                	alert("系统异常,切换失败！");
			                }
			            },
			   		 error:function(text) {
			   			alert("系统异常，切换失败！");
			   		 }
	            });
	            window.setTimeout(function(){
	            	$(".bs_s2").removeClass("filp").stop().hide();
	            	$(".bs_s1").addClass("filp").stop().show();
	            },100);
	        }
	   });
	  
	//filp
	var turnfilp = function(target,time){
			target.stop().animate({'width':0},time,function(){
				target.removeClass("filp").hide();
			});
	}
}

function  show(){
/*-统计-图表-*/
var gaugeOptions = {
    chart: {
        type: 'solidgauge'  // 图表类型为半圆仪表盘
    },
    title: null,
    pane: { //仪表盘半圆设置
        center: ['50%', '85%'],//圆盘位置
        size: '100%',
        startAngle: -90,
        endAngle: 90,
        background: {
            backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || '#EEE',
            innerRadius: '60%',
            outerRadius: '100%',
            shape: 'arc'
        }
    },
    tooltip: {
        enabled: false //鼠标经过提示关闭
    },
    // the value axis
    yAxis: {
        /*stops: [
            [0.25, '#f6a000'], 
            [0.25, '#95c61f'] 
			[0.25, '#eb5f9e'], 
            [0.25, '#7c52ba'] 

        ],*/
        lineWidth: 0,
        minorTickInterval: null,//仪表盘刻度
        tickPixelInterval: 360,
        tickWidth: 0,
        title: {
            y: -70 //标题垂直位置
        },
        labels: {
            y: 16,
			style: {
				color: '#464646',
				font: '12px Simsun, microsoft YaHei, Verdana, sans-serif',
				display: 'none' //设置是否显示y轴数值
			}
        }
    },
    plotOptions: {
        solidgauge: {
            dataLabels: {
                y: 10,
                borderWidth: 0,
                useHTML: true
            }
        }
    }
};

// 所有采购品种数
$('#purchased').highcharts(Highcharts.merge(gaugeOptions, {
    yAxis: {
       min: 0,
       max: maxcount,
        title: {
            text: '<span style="font:13px/1 Simsun;color:#363f45;">所有采购品种数</span>'
        },
		stops: [
		    [0.25, '#f6a000'] // yellow
        ]
    },
    credits: {
        enabled: false 
    },
    series: [{
        name: '所有采购品种数',
        data: countInputMaterial,  //数据
        dataLabels: {
            format: '<div style="text-align:center;"><span style="font-size:2.6em;font-family:arial;color:#363f45;">{y}</span>' +
                    '</div>'
        },
        tooltip: {
            valueSuffix: '' //提示信息为空
        }
    }]
}));

// 所有产品品种数
$('#goods').highcharts(Highcharts.merge(gaugeOptions, {
    yAxis: {
       min: 0,
       max: maxcount,
        title: {
            text: '<span style="font:13px/1 Simsun; color:#363f45;">所有产出品种数</span>'
        },
	    stops: [
		    [0.25, '#95c61f'] // green
        ]
    },
    credits: {
        enabled: false  //去掉图表上那个官网标识链接
    },
    series: [{
        name: '所有产出品种数',
        data: countOutputMaterial,
        dataLabels: {
            format: '<div style="text-align:center;"><span style="font-size:2.6em;font-family:arial;color:#363f45;">{y}</span>' +
                    '</div>'
        },
        tooltip: {
            valueSuffix: ''
        }
    }]
}));

// 所有供应商
$('#supplier').highcharts(Highcharts.merge(gaugeOptions, {
    yAxis: {
       min: 0,
       max: maxcount,
        title: {
            text: '<span style="font:13px/1 Simsun; color:#363f45;">所有供应商</span>'
        },
	    stops: [
		    [0.25, '#eb5f9e'] // green
        ]
    },
    credits: {
        enabled: false  //去掉图表上那个官网标识链接
    },
    series: [{
        name: '所有供应商',
        data: countSuppliers,
        dataLabels: {
            format: '<div style="text-align:center;"><span style="font-size:2.6em;font-family:arial;color:#363f45;">{y}</span>' +
                    '</div>'
        },
        tooltip: {
            valueSuffix: ''
        }
    }]
}));

// 所有客户
$('#customer').highcharts(Highcharts.merge(gaugeOptions, {
    yAxis: {
        min: 0,
        max: maxcount,
        title: {
            text: '<span style="font:13px/1 Simsun; color:#363f45;">所有客户</span>'
        },
	    stops: [
		    [0.25, '#7c52ba'] // green
        ]
    },
    credits: {
        enabled: false  //去掉图表上那个官网标识链接
    },
    series: [{
        name: '所有客户',
        data: countReceivers,
        dataLabels: {
            format: '<div style="text-align:center;"><span style="font-size:2.6em;font-family:arial;color:#363f45;">{y}</span>' +
                    '</div>'
        },
        tooltip: {
            valueSuffix: ''
        }
    }]
}));
}

this.Mouse = function(){ 
	  //设定鼠标偏移值
	   xOffset = 10;
	   yOffset = -10; 
	   var Thumb = $(".integral"); 
	   var Html = '<div class="prompt">'+
	               '<table class="prompt_list">'+
	                  '<thead>'+
	                      '<tr>'+
	                          '<th>计分项</th>'+
	                          '<th>每日计分规则</th>'+
	                      '</tr>'+
	                  '</thead>'+
	                  '<tbody>'+
	                      '<tr>'+
	                          '<td>系统登录</td>'+
	                          '<td>该单位每登录一次记1分 (此项仅限通过终端或网站，手机管理端另计)</td>'+
	                      '</tr>'+
	                      '<tr>'+
	                          '<td>手机管理端登录</td>'+
	                          '<td>每个用户每日登录一次记1分，同一帐号重复登录不计分；每天封顶2分</td>'+
	                      '</tr>'+
	                      '<tr>'+
	                          '<td>进货、配送台帐录入</td>'+
	                          '<td>每1-20条台帐记1分，每天封顶5分</td>'+
	                      '</tr>'+
	                      '<tr>'+
	                          '<td>废弃油台帐、餐厨台帐</td>'+
	                          '<td>每日有台账记录，记1分</td>'+
	                      '</tr>'+
	                      '<tr>'+
	                          '<td>留样登记、团膳外卖登记或大型宴会申报</td>'+
	                          '<td>每日有台账记录，记1分</td>'+
	                      '</tr>'+
	                      '<tr>'+
	                          '<td>进货票据</td>'+
	                          '<td>每日新增一张证照图片，记1分；每天封顶5分</td>'+
	                      '</tr>'+
	                  '</tbody>'+
	               '</table>'+
				   '</div>';   
	  //事件运行  
	  Thumb.mouseenter(function(e){	
				$(this).css({"cursor":"pointer"});				
	            $("body").append(Html);
	            $(".prompt").css({"top":(e.pageY - yOffset) + "px" ,"left": (e.pageX - xOffset - $(".prompt").width() - 20  ) + "px"}).fadeIn("fast"); //显示向左
	  }).mouseleave(function(){
			    $(this).css({"cursor":"default"});   
	            $(".prompt").remove();
	  }); 
	  Thumb.mousemove(function(e){					   
	            $(".prompt").css({"top":(e.pageY - yOffset) + "px" ,"left": (e.pageX - xOffset - $(".prompt").width() - 20 ) + "px"}); //向左
	  }); 
	 
	 };

	 this.Mouse2 = function(){ 
		   /*-当前积分提示-*/
		   xOffset = 10;//设定鼠标偏移值
		   yOffset = -10; 
		   var Thumb = $(".check"); 
		   var Html = '<div class="tip">'+
		               '<table class="tip_list">'+
		                  '<thead>'+
		                      '<tr>'+
		                          '<th colspan="3">最新检查结果图示</th>'+
		                      '</tr>'+
		                  '</thead>'+
		                  '<tbody>'+
		                      '<tr>'+
		                          '<td><img src="../images/i_smile.png" /></td>'+
								  '<td><img src="../images/i_general.png" /></td>'+
								  '<td><img src="../images/i_cry.png" /></td>'+
		                      '</tr>'+
		                      '<tr>'+
		                          '<td>良好</td>'+
		                          '<td>一般</td>'+
								  '<td>较差</td>'+
		                      '</tr>'+
		                  '</tbody>'+
		               '</table>'+
					   '</div>';    
		  Thumb.mouseenter(function(e){	
				  $(this).css({"cursor":"pointer"});				
				  $("body").append(Html);
				  $(".tip").css({"top":(e.pageY - yOffset) + "px" ,"left": (e.pageX - xOffset - $(".tip").width() - 20 ) + "px"}).fadeIn("fast"); //显示向左
		  }).mouseleave(function(){
				  $(this).css({"cursor":"default"});   
				  $(".tip").remove();
		  }); 
		  Thumb.mousemove(function(e){					   
				  $(".tip").css({"top":(e.pageY - yOffset) + "px" ,"left": (e.pageX - xOffset - $(".tip").width() - 20 ) + "px"}); //向左
		  }); 
		};
	 
		/*---二维码生成---*/ 
	   $("#qrcode_ios").qrcode({
			render:"canvas", //设置渲染方式 canvas或table 
			width:75,     //设置宽度  
			height:75,    //设置高度   
			background:"#ffffff", //背景颜色  
			foreground:"#000000", //前景颜色
			text:utf16to8("https://www.pgyer.com/El86") //二维码内容 
		});
		$("#qrcode_android").qrcode({
			render:"canvas", //设置渲染方式 canvas或table 
			width:75,     //设置宽度  
			height:75,    //设置高度   
			background:"#ffffff", //背景颜色  
			foreground:"#000000", //前景颜色
			text:utf16to8("https://www.pgyer.com/4bQb") //二维码内容 
		});
				
		function utf16to8(str) {  //二维码编码前把字符串转换成UTF-8,兼容中文
	        var out, i, len, c;  
	        out = "";  
	        len = str.length;  
	        for(i = 0; i < len; i++) {  
	        c = str.charCodeAt(i);  
	        if ((c >= 0x0001) && (c <= 0x007F)) {  
	            out += str.charAt(i);  
	        } else if (c > 0x07FF) {  
	            out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));  
	            out += String.fromCharCode(0x80 | ((c >>  6) & 0x3F));  
	            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));  
	        } else {  
	            out += String.fromCharCode(0xC0 | ((c >>  6) & 0x1F));  
	            out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));  
	        }  
	        }  
	        return out;  
	    } 
</script>	
</body>
</html>