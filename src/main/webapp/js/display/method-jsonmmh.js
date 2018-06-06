



function traceList(id,brray){
	if(brray.length<1){
		var $zzImg=$('<div class="tent_empty">暂无数据</div>');
		$("#"+id).empty().append($zzImg);
		return false;
	}else{
	    var receiveB = "";
	    var objB = eval(brray);
	    var i = 0,
	        len = objB.length;
	    for(; i < len; ) {
	        var liB = '<li><div>'+
	                    '<h5><span>'+objB[i].name+'</span></h5>'+
	                    '<span class="gray">生产单位</span>'+
	                    '<span class="text">'+objB[i].text+'</span>'+
	                    '<span class="gray">进货日期</span>'+
	                    '<span class="date">'+objB[i].date+'</span>'+
	                 '</div></li>';
	        receiveB += liB;
	        i++;
	    }
	    $("#"+id).empty().append(receiveB);
	    return false;
	}
}














