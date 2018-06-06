//主要岗位人员公示
var objStaff = [{
        photo: 'images/pic_1.png',
        name: '孟庆社',
        jobs: '门店经理'
    },{
        photo: 'images/pic_2.png',
        name: '何攀',
        jobs: '厨师长'
    },{
        photo: 'images/pic_3.png',
        name: '丁国庆',
        jobs: '采购负责人'
    },{
        photo: 'images/pic_4.png',
        name: '刘阳阳',
        jobs: '食品安全负责人'
}];
function staffList(id,array){
    var receiveA = "";
    var objA = eval(array);
    for(var i=0; i<objA.length; i++) { 
        var liA = '<li>'+
                     '<div class="pic"><img src="'+objA[i].photo+'"></div>'+
                     '<h4>'+objA[i].name+'</h4>'+
                     '<p>'+objA[i].jobs+'</p>'+
                   '</li>';
        receiveA += liA;
    }
    $("#"+id).empty().append(receiveA);
    return false;
}

//食材追溯
var objFood =[{
        name:'牛油果',
        text:'上海联尚实业有限公司',
        date:'2017-03-01'
    },{
        name:'薄荷叶-新鲜',
        text:'上海联尚实业有限公司',
        date:'2017-03-01'
    },{
        name:'面包',
        text:'美地食品(上海)有限公司',
        date:'2017-03-01'
    },{
        name:'大裸麦皮塔/15PCS',
        text:'美地食品(上海)有限公司',
        date:'2017-03-01'
    },{
        name:'秋葵',
        text:'上海联尚实业有限公司',
        date:'2017-03-01'
    },{
        name:'豆制品-内脂豆腐',
        text:'上海联尚实业有限公司',
        date:'2017-03-01'
    },{
        name:'迷迭香-新鲜',
        text:'上海联尚实业有限公司',
        date:'2017-03-01'
    },{
        name:'芒果-黄-大',
        text:'上海联尚实业有限公司',
        date:'2017-03-01'
}];
function traceList(id,brray){
    var receiveB = "";
    var objB = eval(brray);
    var i = 0,
        len = objB.length;
    for(; i < len; ) {
        var liB = '<li>'+
                    '<h5><span>'+objB[i].name+'</span></h5>'+
                    '<span class="gray">生产单位</span>'+
                    '<span class="text">'+objB[i].text+'</span>'+
                    '<span class="gray">进货日期</span>'+
                    '<span class="date">'+objB[i].date+'</span>'+
                 '</li>';
        receiveB += liB;
        i++;
    }
    $("#"+id).empty().append(receiveB);
    return false;
}














