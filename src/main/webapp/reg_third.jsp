<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%
	String company=request.getParameter("company");
	company=java.net.URLDecoder.decode(company, "UTF-8");
	String user=request.getParameter("user");
	user=java.net.URLDecoder.decode(user, "UTF-8");
	String password=request.getParameter("password");
	password=java.net.URLDecoder.decode(password, "UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="renderer" content="webkit">
<meta charset="utf-8"/>

<link href="./css/common.css" rel="stylesheet" type="text/css" />
<link href="./css/style.css" rel="stylesheet" type="text/css" />
<script src="./js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="./js/reAlert.js" type="text/javascript" charset="utf-8"></script>	
<script src="./js/custome.js" type="text/javascript" charset="utf-8"></script>	
<script type="text/ecmascript" src="./js/base64.js"></script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="reg_fh"><a href=".." target="_top"><i class="i_fh"></i><span>返回</span></a></h3>
          <div class="reg_tent">
               <div class="reg_title">
                    <ul class="reg_list">
                        <li><span><i>1</i><em>验证</em></span></li>
                        <li><span><i>2</i><em>注册</em></span></li>
                        <li class="default"><span><i>3</i><em>完成</em></span></li>
                    </ul>
               </div>
               <div class="reg_detail">
                    <div class="info_box">
                         <div class="reg_succed">
                              <i class="i_aucced"></i>
                              <p><span><%=company %></span><span><%=user %></span>用户</p>
                              <p class="blue">您已成功注册餐饮食品安全信息追溯系统</p>
                              <dl class="guide">
                                  <dt><i>第1步</i><span>企业信息维护</span></dt>
                                  <dd>
                                      <img src="./images/guide_1.jpg" align="left" />
                                      <span>1、维护单位名称、地址、餐饮证号，名称和地址必须和餐饮证上的一致；</span>
                                      <span>2、补充本单位的证照图片信息。</span>
                                  </dd>
                                  <dt><i>第2步</i><span>做台帐前先做基础数据维护</span></dt>
                                  <dd>
                                      <img src="./images/guide_2.jpg" align="left" />
                                      <span>方式一：从数据导入模块下载对应的模板，添加数据后导回到系统；</span>
                                      <span>方式二：直接到对应的模块中手工逐条添加数据。</span>
                                      <span class="blue">注意：所有单位都要做供应商和采购品，没有配送就不要做收货商和产出品。</span>
                                  </dd>
                                  <dt style="margin-top:20px;"><i>第3步</i><span>做进货台帐和配送台帐</span></dt>
                                  <dd>
                                      <img src="./images/guide_3.jpg" align="left" />
                                      <span>方式一：从数据导入模块下载“导入进货台账模板”，添加数据后导回到系统；</span>
                                      <span>方式二：直接“新增进货”模块中手工逐条添加数据。</span>
                                      <span class="blue">注意：所有单位都要做进货台账！</span>
                                      <span style="margin-top:15px;">方式一：从数据导入模块下载“导入发货台帐模板”，添加数据后导回到系统；</span>
                                      <span>方式二：直接到“新增发货”模块中手工逐条添加数据。</span>
                                      <span class="blue">注意：只有配送中心、集体供餐单位、中央厨房等有配送业务的才要做发货台账！</span>
                                  </dd>
                              </dl>
                              <p class="guide_ts"><em>特别提醒：</em>
                                 <span>做进货台帐之前，一定要把台帐中对应的采购品供应商维护进系统；</span>
                                 <span>如果本单位的供应商也使用这个系统，该供应商对应的采购品可以不用维护，使用系统的自动发货功能，生成台账；</span>
                                 <span>系统中其它模块的功能，具体可以按照单位所在地监管部门的要求进行登记。</span>
                                 <span>登录后，可在“系统管理-个人中心”完成手机认证，手机认证后，可使用短信验证找回密码。</span>
                              </p>
                         </div>
                    </div>
                 <form action="./j_spring_security_check" method="post" id="springForm" onsubmit="return false;" autocomplete="off" type="hidden">
			        <ul>
                            <li><input type="hidden" id="j_username" name="j_username" type="text" class="text_login" value="<%=user%>" placeholder="用户名" style="color:gray"/></li>
                            <li><input type="hidden" id="j_password" name="j_password" type="password" class="text_login" value="<%=password%>" placeholder="密  码" style="color:gray"/></li>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</ul>
				</form>
                    <p class="save_box">
                       <input type="button" class="btn_save" value="知道了，我要进入系统" style="height:45px;line-height:45px;padding:0 30px;" onClick="onLoginClick()"/>
                    </p>
               </div
          ></div>
     </div>
</div>    
<script type="text/javascript">
var password='<%=password%>';
var b = new Base64();  
password = b.decode(password);  
$(function(){
  $("#j_password").val(password);

	/*-------jquery end-------*/
	});	

	function onLoginClick() {
		console.log(password);
       	document.getElementById("springForm").submit();
//        	return false;
    }
	

</script>	
</body>
</html>