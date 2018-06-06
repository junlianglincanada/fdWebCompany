//主要岗位人员公示
staffList('staff_list',objStaff);

//食材追溯
 traceList('FoodTrace_list',objFood);
 $("#FoodTrace_list").find("li:first").addClass('default').fadeIn(500).css('display','block');
 $("#FoodTrace_list").find("li.default > h5 > span").addClass('first');

//左侧切换
var switchPublic = function(p,times){
        var _boxFrame = $("#"+ p);
        var _width = _boxFrame.find("> div").width(); 
        var turnSwitch = function(){
              _boxFrame.find("> div:last").clone(true).prependTo(_boxFrame);
              _boxFrame.find("> div:first").animate({opacity: 1}, 1000, function(){
                  _boxFrame.find("> div:last").remove();
                  _boxFrame.find("> div:last").animate({opacity: 0}, 500);
              });
        }
        setInterval(turnSwitch, times);
        return false;
}

//右侧动画
/*function traceKing(id,t){
    var _outUbox = $("#"+id),
        liH = _outUbox.find("li").height();
    var turnDown = function(){
          _outUbox.find("li:last").clone(true).prependTo(_outUbox);
          _outUbox.find("li:first").fadeIn(1200).addClass("default").fadeIn(500).css("display","block");
          _outUbox.find("li").eq(1).removeClass("default").css("display","list-item");
          _outUbox.css("marginTop", - liH + 6 +"px");
          _outUbox.animate({marginTop: 0 + "px"}, 1200, function(){
                _outUbox.find("li:last").remove();
          });
    }
    setInterval(turnDown, t);
    return false;
}*/

function traceKing(id,t){ 
    var _onUL =$("#"+id);
    var traceSwitch = function(){
            _onUL.find("li:first").addClass('default').fadeIn(500).css('display','block');
            _onUL.find("li").removeClass("default");
            _onUL.find("li:last").remove().prependTo(_onUL);    
        var aText = _onUL.find("li:first h5").find("span").text(),
            bText = _onUL.find("li:first").find("span.text").text(),
            cText = _onUL.find("li:first").find("span.date").text();  //console.log(aText,bText,cText)
        var htmlWrap = '<marquee direction="left" behavior="slide" loop="1" scrollamount="80" width="100%" height="86" onmouseover="this.stop()" onmouseout="this.start()"><h5><span>'+aText+'</span></h5>'+
                       '<span class="gray">生产单位</span><span class="text">'+bText+'</span>'+
                       '<span class="gray">进货日期</span><span class="date">'+cText+'</marquee></span>';
        _onUL.find("li:first").empty().append(htmlWrap).addClass("default").fadeIn(500).css('display','block');
        setTimeout(function(){
           _onUL.find("li.default h5 span").addClass('first');
        }, 1000)
    }
    setInterval(traceSwitch, t);
    return false;      
}


//禁用空格键方法
document.onkeydown= function(e){
  e = e ? e : event; 
  if(e.keyCode == 13 || e.keyCode == 32 ){
     e.returnValue = false; //IE下
     e.preventDefault(); //Firefox下
  } 
}
//在Firefox下单独禁用空格键方法
document.onkeyup = function(e){
  if(e.keyCode == 32 ){
     e.preventDefault();
  }
}