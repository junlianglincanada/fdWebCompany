<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>上海市餐饮食品安全信息追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="infopublic.info">信息公示</a>
              <div class="btn_opera"> 
                   <span class="opera_text">编辑公示屏中的公示信息请点击 <a href="infopublic.info-editor" class="btn_infoEditor">去维护</a> </span>
              </div> 
          </h3>
          <div class="info_box">
               <iframe src="infopublic.iframe-info" scrolling="auto" frameborder="0" name="mainFrame" class="info_iframe" allowtransparency="true"></iframe>
          </div>
     </div>
</div>
</body>
</html>