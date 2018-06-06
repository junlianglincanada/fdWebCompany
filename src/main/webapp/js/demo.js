//初始变量声明-默认
var topH = $(".header_box").height(),
    lfW = $(".main_left").width(),
    mrt = $(".mrt_top").height(),
    btmH =$(".footer_box").height();

//默认时, 显示中间左侧、主体区域
var resizeTimer = null;
if (resizeTimer) {
    clearTimeout(resizeTimer)
}
function windowSet(){
    var winW = $(window).width(),
        winH = $(window).height(),
        mainH = winH-topH-btmH; 
        mainW = winW-lfW; 
    $(".mainbody,.main_left,.main_right").css({"height":mainH+'px'});
    $(".mrc_con").css({height:mainH - mrt +'px'});
}
resizeTimer = setTimeout(function(){
        windowSet();
}, 500);
      
$(window).on('resize',function(){//对浏览器窗口大小进行调整
      if (resizeTimer) {
          clearTimeout(resizeTimer)
      }
      resizeTimer = setTimeout(function(){
           windowSet();              
      }, 400);
});



