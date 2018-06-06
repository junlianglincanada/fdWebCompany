//重写alert()方法
window.alert = function(txt){
	var urlAddress = window.location.pathname;
	//var urlAddress = window.location.host;
	var shadow = document.createElement("DIV");
	shadow.id = "shadow";
	shadow.style.position = "fixed";
	shadow.style.left = "0px";
	shadow.style.top = "0px";
	shadow.style.width = "100%";
	shadow.style.height = "100%";
	shadow.style.background = "#000";
	shadow.style.zIndex = "9999";
	shadow.style.opacity = ".5";
	shadow.style.filter = "alpha(opacity=50)";
	var alertFram = document.createElement("DIV");
	alertFram.id="alertFram";
	alertFram.style.position = "fixed";
	alertFram.style.left = "50%";
	alertFram.style.top = "30%";
	alertFram.style.marginLeft = "-225px";
	alertFram.style.marginTop = "-75px";
	alertFram.style.width = "360px";
	alertFram.style.height = "188px";
	alertFram.style.background = "transparent";
	alertFram.style.borderRadius = "6px";
	alertFram.style.zIndex = "10000";
	strHtml = "<ul style=\"list-style:none;display:block;margin:0px;padding:0px;width:100%;\">\n";
	strHtml += " <li style=\"display:block;height:30px;font:12px/30px 'Simsun';color:#fff;background:#459ee0;border-left:1px solid #459ee0;border-right:1px solid #459ee0;border-radius:6px 6px 0 0;text-align:left;padding:5px 40px 5px 10px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap; overflow:hidden;position:relative;\"><span style=\"display:block;font-size:14px;font-weight:bold;text-align:center;padding-left:30px;\">提示</span><a href=\"javascript:doAlert()\" style=\"display:block;width:30px;height:30px;font:22px/30px arial;color:#fff;text-align:center;text-indent:-999px;overflow:hidden;background:url(../../images/closed.png) 0 0 no-repeat;position:absolute;top:5px;right:4px;\">删除</a></li>\n";
	strHtml += " <li style=\"height:60px;line-height:25px;font-size:14px;text-align:center;padding:28px 20px 10px 20px;background:#fff;border-left:1px solid #459ee0;border-right:1px solid #459ee0;overflow:hidden;\">"+txt+"</li>\n";
	strHtml += " <li style=\"height:32px;padding:10px;text-align:center;background:#fff;border-left:1px solid #459ee0;border-right:1px solid #459ee0;border-bottom:1px solid #459ee0;border-radius:0 0 6px 6px;\"><input type=\"button\" value=\"确定\" class=\"btn_blue\" style=\"width:80px;height:32px;font:12px/32px 'Simsun';color:#fff;background:#459ee0; border:none; border-radius:4px; box-shadow:0 0 1px #b2c5d9; cursor:pointer;\" onclick=\"doAlert()\" /></li>\n";
	strHtml += "</ul>\n";
	alertFram.innerHTML = strHtml;
	document.body.appendChild(alertFram);
	document.body.appendChild(shadow);
	var c = 0;
	this.doAlpha = function(){
		if (c++ > 20){clearInterval(ad);return 0;}
		shadow.style.filter = "alpha(opacity="+c+");";
	}
	var ad = setInterval("doAlpha()",5);
	this.doAlert = function(){
		alertFram.style.display = "none";
		shadow.style.display = "none";
		document.body.removeChild(alertFram);
	    document.body.removeChild(shadow);
	}
	alertFram.focus();
	document.body.onselectstart = function(){return false;};
}