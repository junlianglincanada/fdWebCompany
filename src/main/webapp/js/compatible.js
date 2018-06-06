//兼容谷歌浏览器下flash输入法被遮挡问题				   
	var swfVersionStr = "${version_major}.${version_minor}.${version_revision}";
	var xiSwfUrlStr = "${expressInstallSwf}";             
	var flashvars = {};             
	var params = {};             
	params.quality = "high";             
	params.bgcolor = "${bgcolor}";             
	params.allowscriptaccess = "sameDomain";             
	params.allowfullscreen = "true";             
	params.wmode = "window";             
	var attributes = {};             
	attributes.id = "${application}";             
	attributes.name = "${application}";             
	attributes.align = "middle";             
	swfobject.embedSWF("${swf}.swf", "flashContent",                  
			"${width}", "${height}",                  
			swfVersionStr, xiSwfUrlStr,                  
			flashvars, params, attributes);