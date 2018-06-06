<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>上海市餐饮食品安全信息追溯系统</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="../js/reAlert.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
function onLoginClick(){
	var flag=true;
	$("input").each(function(){
		var v=$(this).val().trim();
		if(v==""){
			$("#msg").show();
			flag=false;
		}
	})
	if(flag==true){
		document.getElementById("springForm").submit();
	}
}
</script>
</head>
<body>
<div class="main_box" style="padding:0;">
     <div class="main_con">
          <div class="acc_box">
           	   <div>
           	   	<form action="../webservice/companyAuthority" method="get" id="springForm" onsubmit="return false;" autocomplete="off">
                    <ul>                      
                        <li><i class="icon_user">appID</i><input type="text" class="text_login" name="appID" value="" style="color:gray" placeholder="appID"/></li>
                        <li><i class="icon_pwd">key</i><input type="text" class="text_login" name="key" value="" style="color:gray" placeholder="key"/></li>
                        <li><i class="icon_user">PFMCompanyID</i><input type="text" class="text_login" name="PFMCompanyID" value="" style="color:gray" placeholder="PFMCompanyID"/></li>
                        <li><i class="icon_pwd">callbackURL</i><input type="text" class="text_login" name="callbackURL" value="" style="color:gray" placeholder="callbackURL"/></li>
                        <li><span style="display:none;" id="msg">必要信息不能为空</span></li>
                    </ul>
                </form>
                    <p class="acc_btn"><input type="button" class="btn_acc" value="授 权" onclick="onLoginClick()"/></p> 
               </div>
          </div>
     </div>
</div>    
</body>
</html>