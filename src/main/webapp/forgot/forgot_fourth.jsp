<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>上海市餐饮食品安全信息追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.reg_tent{width:90%;}
ul.reg_list li{width:22.5%;}
ul.reg_list li span{padding-left:20%;}
.info_box{min-height:160px;width:80%;margin:20px auto;}
span.blue{font-size:16px;font-weight:400;}
</style>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="reg_fh"><a href="../login.jsp" target="_top"><i class="i_fh"></i><span>返回</span></a></h3>
          <div class="reg_tent">
               <div class="reg_title">
                    <ul class="reg_list">
                        <li><span><i>1</i><em>验证用户名</em></span></li>
                        <li><span><i>2</i><em>验证手机号</em></span></li>
                        <li><span><i>3</i><em>设置新密码</em></span></li>
                        <li class="default"><span><i>4</i><em>完成</em></span></li>
                    </ul>
               </div>
               <div class="reg_detail">
                    <div class="info_box">
                         <div class="reg_succed">
                              <i class="i_aucced"></i>
                              <p><span class="blue">新密码重置成功!<br/></span>请牢记您新设置的密码</p>                            
                         </div>
                    </div>
                    <p class="save_box">
                       <input type="button" class="btn_save" value="马上登录" onClick="window.parent.location.href='../login.jsp'"/>
                    </p>
               </div
          ></div>
     </div>
</div>    
 
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/reAlert.js" type="text/javascript" charset="utf-8"></script>	
<script src="../js/custome.js" type="text/javascript" charset="utf-8"></script>	
	
</body>
</html>