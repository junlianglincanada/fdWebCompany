<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../include.jsp" %>
<script type="text/javascript">
$(function(){
    //点击按钮关闭弹窗并传值
	$("input[name^='btn_replay']").click(function(){
		   var reg= /[\n]/g;//匹配全部换行 [正则表达式]
		   var cysm = $(".reply_box textarea.textarea_code").val();//获取文本域的值
		   var resultText = cysm.replace(reg,"<br />");
		   var cay_text = '<dd>' + resultText + '</dd>';
		   alert(resultText);		  
		   $("dl.consult_list").append(cay_text);
           
		   return false;

	});
   
});	
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="consult.html">咨询帮助</a> > <a href="#">问题</a> </h3>
          <div class="table_box">
               <dl class="consult_list">
                   <dt><span>追溯码是什么</span><em>（admin  2015-10-12）</em><i class="i_top">置顶</i></dt>
                   <dd><span>产品的追溯码一般以二维码或者是一串数字的方式呈现，标示有“追溯码”三个字，位于产品外包装条形码的上方或者 是外包装的底部</span><em>（回复时间：2015-10-13）</em></dd>
                   <dt><span>十三位条码一般印在哪里，是纯数字吗？</span><em>（(Eric  2015-9-28)）</em><i class="i_top">置顶</i></dt>
                   <dd><span>一般印于外包装底部，是纯数字组成。</span><em>（回复时间：2015-9-28）</em></dd>
                   <dt><span>批次号有空隔也要输入吗？</span><em>（(Eric  2015-8-28)）</em></dt>
                   <dd><span>一般印于外包装底部，是纯数字组成。</span><em>（回复时间：2015-8-28）</em></dd>
               
               </dl>
               <div class="clear"></div>
               <div class="reply_box">
                    <textarea class="textarea_code"></textarea>
                    <span class="control_text"><b>还可以输入</b><em class="trol_num">250</em>个字</span>
               </div>
               <p class="save_box">
                  <input type="button" class="btn_save" value="回复" name="btn_replay" />
                  <input type="button" class="btn_save" value="返回" />
               </p>
          </div>
     </div>
</div>
</body>
</html>
</html>