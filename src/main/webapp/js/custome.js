$(function(){
	//清空输入框默认值
	$("input.text_login,input.input_code,textarea.textarea_code,select.select_cs,input.input_date,input.query_input").focus(function(){
	        $(this).css("color","#000");
	});		
	
	 //左侧二级导航菜单点击(修改)
	 $("dl.lf_navs dt a").live("click",function(){
				$("dl.lf_navs dt a,dl.lf_navs dd a").removeClass("default");
				$(this).addClass("default");
		        $(this).parent("dt").next("dd").show().siblings("dd").hide();
                $(this).next("dd").addClass("default"); 
				$(this).parent("dt").next("dd").children("a").eq(0).addClass("default");
	 }).eq(0).addClass("default");
	 $("dl.lf_navs dd a").live("click",function(){
				$("dl.lf_navs dt a").removeClass("default");
				$(this).parent("dd").prev("dt").find("a").addClass("default");
				$("dl.lf_navs dd a").removeClass("default");
		        $(this).addClass("default").siblings().removeClass("default");									 								 
	 });
	  
	  //table隔行背景换色：
	  var List = $("table.table_list tbody tr");		  
		  for(var i=0;i<=List.length;i++){
			  if (0 == i % 2) {
				  $(List[i]).addClass("even");
			  }
		  };
	
	//条码选择条件控制
	$("#radio_c1").click(function(){
	     $("tr.tr-choose1").show();
		 $("tr.tr-choose2").hide();
	});
	$("#radio_c2").click(function(){
	     $("tr.tr-choose2").show();
		 $("tr.tr-choose1").hide();
	});
  
   //输入字数监控
	$(".reply_box textarea.textarea_code").focus(function(){
			  $(this).empty().css({"color":"#000"});						  					  
    });	
	$(".reply_box textarea.textarea_code").keyup(function(){	
		      var text = $(this).val(); //获取文本域的值
			  var len = text.length*2;
			  var numk = 250-len;
			  var numc = -numk;
			  $(".trol_num").empty().html(numk);
			  if(len >= 250){
				  $(".control_text b").text("已超出");
				  $(".trol_num").css({"color":"red"});
				  $(".trol_num").empty().html(numc);
			  }else{
				  $(".control_text b").text("还可以输入");
				  $(".trol_num").css({"color":"#a5a5a5"});
				  $(".trol_num").empty().html(numk);
			  }
    });

/*-------jquery end-------*/
});	
//tab点击切换
function setTab(name,cursel,n){
 for(var i=1;i<=n;i++){
  var menu=document.getElementById(name+i);
  var con=document.getElementById("con_"+name+"_"+i);
  if(menu != null){
	  menu.className=i==cursel?"default":" ";
  }
  con.style.display=i==cursel?"block":"none";
 }
}
/*----------js end----------*/