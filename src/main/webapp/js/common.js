//ʵ�ַ�ҳ���ܣ���Ҫ��ҳ�涨�����totalPage��totalNum��pageNum��params
function page(result) {
	if(result.body==null){
		totalPage=1;
		totalNum=0;
	}else{
		totalPage = result.body.pageCount;
		totalNum = result.body.totalRecord;
	}
	// 显示分页数字1-N
	$(".paging_box a").remove();
	if (totalPage < 6) {
		for ( var i = 0; i < totalPage; i++) {
			var pageNo = totalPage - i;
			var $a = $('<a href="#" id=page' + pageNo + '>' + pageNo + '</a>');
			$a.data("pageNo", pageNo);
			$(".paging_perv").after($a);
		}
	} else {
		if ((totalPage - pageNum) < 3) {
			for ( var i = 0; i < 5; i++) {
				var pageNo = totalPage - i;
				var $a = $('<a href="#" id=page' + pageNo + '>' + pageNo
						+ '</a>');
				$a.data("pageNo", pageNo);
				$(".paging_perv").after($a);
			}
		} else if (pageNum < 3) {
			for ( var i = 0; i < 5; i++) {
				var pageNo = 5 - i;
				var $a = $('<a href="#" id=page' + pageNo + '>' + pageNo
						+ '</a>');
				$a.data("pageNo", pageNo);
				$(".paging_perv").after($a);
			}
		} else {
			for ( var i = 0; i < 5; i++) {
				var pageNo = pageNum - i + 2;
				var $a = $('<a href="#" id=page' + pageNo + '>' + pageNo
						+ '</a>');
				$a.data("pageNo", pageNo);
				$(".paging_perv").after($a);
			}
		}
	}
	if (pageNum == 1) {
		$(".paging_box a").removeClass("default");
		$("#page1").addClass("default");
	}
	$("#page" + pageNum).addClass("default");
	// 点击页码分页查询
	$(".paging_box a").click(function() {
		$(".paging_box a").removeClass("default");
		pageNum = $(this).data("pageNo");
		params.newSearch="1";
		search(pageNum);
		$(this).addClass("default");
	});
	$(".page_record").remove();
	$(".paging_box span:eq(4)").after(
			'<span class="num_text page_record">共<em>' + totalNum
					+ '</em>条记录</span>');
}

// 判断是否为NULL显示
function isnull(object) {
	if (object == null || object == "null" || object == "") {
		return "";
	} else {
		return object;
	}
}


// 判断是否固定号码
function isPhone(code) {
	var reCode = /^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$/;
	return (reCode.test(code));
}
// 判断是否手机号码
function isMobilephone(code) {
	var reCode = /^(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9])\d{8}$/;
	return (reCode.test(code));
}
// 判断是否邮箱
function isEmail(code) {
	var reCode = /^[A-Za-z0-9]+([-_.][A-Za-z0-9]+)*@([A-Za-z0-9]+[-.])+[A-Za-z0-9]{2,5}$/;
	return (reCode.test(code));
}
// 特殊符号安全限制
function checkSpecificKey(keyCode) {
	var patrn = /[`~!#$%^&+<>?{},\;[\]]/im;
	var flg = false;
	flg = patrn.test(keyCode);
	if (flg) {
		return false;
	}
	return true;
}
// ��ȡ�ύ��ʱ�Ĳ���
$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};
function html_encode(str) {
	var s = "";
	if (str.length == 0)
		return "";
	s = str.replace(/&/g, "&gt;");
	s = s.replace(/</g, "&lt;");
	s = s.replace(/>/g, "&gt;");
	s = s.replace(/ /g, "&nbsp;");
	s = s.replace(/\'/g, "&#39;");
	s = s.replace(/\"/g, "&quot;");
	s = s.replace(/\n/g, "<br>");
	return s;
}

function html_decode(str) {
	var s = "";
	if (str.length == 0)
		return "";
	s = str.replace(/&gt;/g, "&");
	s = s.replace(/&lt;/g, "<");
	s = s.replace(/&gt;/g, ">");
	s = s.replace(/&nbsp;/g, " ");
	s = s.replace(/&#39;/g, "\'");
	s = s.replace(/&quot;/g, "\"");
	s = s.replace(/<br>/g, "\n");
	return s;
}
function getCursorPos(obj) {
	return obj.selectionStart;
}
function setCursorPos(obj, pos) {
	if (obj.setSelectionRange) {
	    var obj1 = obj.value;
		obj.setSelectionRange(pos, pos);
	} else if (obj.createTextRange) {
		var range = obj.createTextRange();
		range.collapse(true);
		range.moveEnd('character', pos);
		range.moveStart('character', pos);
		range.select();
	}
}
//只能输入数字
function onlyNum(obj) {
	 var pattern = /[^\d]/g;
	var pos = getCursorPos(obj);
	var orgValue = obj.value;
	obj.value = orgValue.replace(pattern, "");
	pos = pos - Math.ceil(orgValue.length - obj.value.length);
	setCursorPos(obj, pos);
}
//只能输入数字和小数点
function onlyQuantity(obj) {
	 var pattern = /[^\d.]/g;
	var pos = getCursorPos(obj);
	var orgValue = obj.value;
	obj.value = orgValue.replace(pattern, "");
	pos = pos - Math.ceil(orgValue.length - obj.value.length);
	setCursorPos(obj, pos);
}
//只能输入数字和-，用于电话号码
function onlyPhone(obj) {
	var pattern = /[^\d-]/g;
	var pos = getCursorPos(obj);
	var orgValue = obj.value;
	obj.value = orgValue.replace(pattern, "");
	pos = pos - Math.ceil(orgValue.length - obj.value.length);
	setCursorPos(obj, pos);
}
//只能用户用户名和密码
function onlyUserInfo(obj) {
	var pattern = /[^a-zA-Z0-9@_]/g;
	var pos = getCursorPos(obj);
	var orgValue = obj.value;
	obj.value = orgValue.replace(pattern, "");
	pos = pos - Math.ceil(orgValue.length - obj.value.length);
	setCursorPos(obj, pos);
}
//限制特殊字符输入
function replaceAndSetCursor(obj) {
	var pattern = /[`~!#$%^&*+<>?:{},\/;[\]]/im;
	var pos = getCursorPos(obj);
	var orgValue = obj.value;
	obj.value = orgValue.replace(pattern, "");
	pos = pos - Math.ceil(orgValue.length - obj.value.length);
	setCursorPos(obj, pos);
}

//日期限制
function calDateByDay(d){ 
    var now = new Date();
    var date=new Date(now.getTime()+1000*60*60*24*d);
    var year = date.getFullYear();       //年
    var month = date.getMonth() + 1;     //月
    var day = date.getDate();            //日
    var clock = year + "-";
    if(month < 10)
        clock += "0";
    clock += month + "-";
    if(day < 10)
        clock += "0";
    clock += day + " ";
    return(clock); 
}

function calDateByMonth(m){ 
    var date = new Date();
    date.setMonth(date.getMonth()+m);
    var year = date.getFullYear();       //年
    var month = date.getMonth() + 1;     //月
    var day = date.getDate();            //日
    var clock = year + "-";
    if(month < 10)
        clock += "0";
    clock += month + "-";
    if(day < 10)
        clock += "0";
    clock += day;
    return(clock); 
} 

//日期比较
function compareTime(a, b) {
    var arr = a.split("-");
    var starttime = new Date(arr[0], arr[1], arr[2]);
    var starttimes = starttime.getTime();

    var arrs = b.split("-");
    var lktime = new Date(arrs[0], arrs[1], arrs[2]);
    var lktimes = lktime.getTime();

    if (starttimes > lktimes) {
        return false;
    }
    else{
    	return true;
    }
}

//正则    : 食品经营许可证
function spjyNumber(number){
	var num=/^(JY|jy)[0-9A-Za-z]{14}$/;
	return num.test(number);
}

//正则    : 食品流通许可证
function spltNumber(number){
	var num=/^(SP|sp)[0-9A-Za-z]{16}$/;
	return num.test(number);
}

//正则 :  食品生产许可证
function spscNumber(number){
	var num=/^((QS|qs)[0-9A-Za-z]{12}$|(SC|sc)[0-9A-Za-z]{14}$)/;
	return num.test(number);
}

//正则  : 工商营业执照
function gszzNumber(number){
	var num=/^([0-9A-Za-z]{15}$|[0-9A-Za-z]{18}$)/;
	return num.test(number);
}


//正则   :  餐饮服务许可证
function cyfwNumber(number){
	var num=/^(西藏|藏|新疆|疆|桂|宁夏|宁|内蒙古|蒙|冀|晋|辽|吉|黑|苏|浙|皖|闽|赣|鲁|豫|鄂|湘|粤|琼|川|蜀|黔|贵|滇|云|陕|秦|甘|陇|青|台|港|澳|京|沪|津|渝)(餐证字)[0-9A-Za-z]{16}$/;
	return num.test(number);
}

//正则    : 食品经营许可证-摊位
function spjyBooth(number){
	var num=/^(JY|jy)[0-9A-Za-z]{14}(-[0-9A-Za-z~!@#$%^*+<>?:{},\/[\]_-]{1,10})?$/;
	return num.test(number);
}

//正则    : 食品流通许可证
function spltBooth(number){
	var num=/^(SP|sp)[0-9A-Za-z]{16}(-[0-9A-Za-z~!@#$%^*+<>?:{},\/[\]_-]{1,10})?$/;
	return num.test(number);
}

//正则 :  食品生产许可证
function spscBooth(number){
	var num=/^((QS|qs)[0-9A-Za-z]{12}(-[0-9A-Za-z~!@#$%^*+<>?:{},\/[\]_-]{1,10})?$|(SC|sc)[0-9A-Za-z]{14}(-[0-9A-Za-z~!@#$%^*+<>?:{},\/[\]_-]{1,10})?$)/;
	return num.test(number);
}

//正则  : 工商营业执照
function gszzBooth(number){
	var num=/^([0-9A-Za-z]{15}(-[0-9A-Za-z~!@#$%^*+<>?:{},\/[\]_-]{1,10})?$|[0-9A-Za-z]{18}(-[0-9A-Za-z~!@#$%^*+<>?:{},\/[\]_-]{1,10})?$)/;
	return num.test(number);
}


//正则   :  餐饮服务许可证
function cyfwBooth(number){
	var num=/^(西藏|藏|新疆|疆|桂|宁夏|宁|内蒙古|蒙|冀|晋|辽|吉|黑|苏|浙|皖|闽|赣|鲁|豫|鄂|湘|粤|琼|川|蜀|黔|贵|滇|云|陕|秦|甘|陇|青|台|港|澳|京|沪|津|渝)(餐证字)[0-9A-Za-z]{16}(-[0-9A-Za-z~!@#$%^*+<>?:{},\/[\]_-]{1,10})?$/;
	return num.test(number);
}

//正则  : 摊位号
function isBoothNo(number){
	var num=/^([0-9A-Za-z~!@#$%^*+<>?:{},\/[\]_-]{1,10}$)/;
	return num.test(number);
}

//非空判断
function nullFlag(object){
	if(object==null||object==""||object=="null"){
		return true;
	}else{
		return false;
	}
}

var tabNav = function(_this){
    var thisId="";
    var thisName="";
    var my_href=$(_this).attr("my_href");
    switch (my_href) {
	case "qyxx":
	   	thisName="企业信息";
    	thisId="0001_14_02";
		break;
	case "cyry":
	   	thisName="从业人员";
    	thisId="0001_11";
		break;
	case "cgp":
	   	thisName="采购品";
    	thisId="0001_04_01";
		break;
	case "gysgl":
	   	thisName="供应商管理";
    	thisId="0001_04_02";
		break;
	case "tzyj":
	   	thisName="台帐预警";
    	thisId="0001_13_03";
		break;
	case "ryyj":
	   	thisName="人员预警";
    	thisId="0001_13_02";
		break;
	case "zzyj":
	   	thisName="证照预警";
    	thisId="0001_13_01";
		break;
	case "tzgg":
	   	thisName="通知公告";
    	thisId="0001_02_01";
		break;
	default:
		return ;
		break;
	}
    var parent_if=$(window.parent.document);
    if($(_this).attr("rel")!="" || $(_this).attr("rel")!="null" ){
    	parent_if.find(".mrt_bar a,.mrc_tab > div.layer").removeClass("default"); 
       if(parent_if.find("#"+thisId+"_title").length>0){
    	  parent_if.find("#"+thisId+"_title").addClass("default").parent().siblings().find("a").removeClass("default");
    	  parent_if.find("#"+thisId+"_body").addClass("default").siblings().removeClass("default");
    	  parent_if.find("#"+thisId+"_body").children("iframe").attr("src",$(_this).attr("rel"));
       }else{
          var rtArray ='<a id="'+thisId+'_title" href="javascript:void(0);" rel=\"'+thisId+'\" title=\"'+thisName+'\" class="addA default"><span>'+thisName+'</span><i class="i_cross"><b></b></i></a>';
          var mainArray ='<div id="'+thisId+'_body" class="addDiv layer '+thisId+' default"><iframe src="'+$(_this).attr("rel")+'" scrolling="auto" frameborder="0" name="'+$(_this).attr("target")+'" class="main_iframe" allowtransparency="true"></iframe></div>';
          parent_if.find(".mrt_bar").append(rtArray); 
          parent_if.find(".mrc_tab").append(mainArray); 
          window.parent.div_a_rest('add');
       }
    }
}


