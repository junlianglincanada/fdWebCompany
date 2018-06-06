<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../../include.jsp" %>
<style type="text/css">
.select_s{width:182px; float:left;}
.select_is{width:182px;}
select.select_cs{width:212px; background-position:-16px -122px;}
table.table_list td.td_oper{text-align:left;}
a.new_closed{ display:block; width:30px; height:30px; font:22px/30px arial; color:#fff; text-align:center; text-indent:-999px;overflow:hidden; background:url(../images/closed.png) 0 0 no-repeat; position:absolute; top:6px; right:6px;-webkit-transition:background .5s ease-out;-moz-transition:background .5s ease-out;-o-transition:background .5s ease-out;-ms-transition:background .5s ease-out;transition:background .5s ease-out;}
a.new_closed:hover{ color:#cc3333;background:url(../images/closed.png) 0 100% no-repeat}
</style>
<script type="text/javascript">
function search(){
	$("#loading").show();
	$.ajax({
		url:"../comRelationship/relationship/queryCompanyListForAttachTrunk/",
		type:"post",
		headers: { 
	        'Accept': 'application/json',
	        'Content-Type': 'application/json' 
	    },
		success:function(result){
			if(result.status==0){
				$("tbody").children().remove();
				console.log(result.body);
				var resultList=result.body;
				for(var i=0;i<resultList.length;i++){
					var companyId=resultList[i].companyId;
					var companyName=resultList[i].companyName;
					var companyAddress=resultList[i].companyAddress;
					var content='<tr>';
					content+='<td class="td_ser"><input type="radio" name="assoc" value="'+companyId+'"/></td>';
					content+='<td class="td_ser">'+(i+1)+'</td>';
					content+='<td>'+companyName+'</td>';
					content+='<td>'+companyAddress+'</td>';
					content+='</tr>';
					var $tr=$(content);
					$("tbody").append($tr);
				}
			}
			$("#loading").hide();
		},
		error:function(e){
			console.log(e);
		}
	});
}
$(function(){
	search();
	$(".btn_save").click(function(){
		var companyIdFrom=$(":radio:checked").val();
		$.ajax({
			url:"../comRelationship/relationship/createLinkToTrunk/"+companyIdFrom,
			type:"post",
			headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
		    success: function(){
		    	window.top.location.href="../default.do";
		    }
		});
	})
});
</script>
</head>
<body>
<div class="main_box">
     <div class="main_con">
          <h3 class="process_title"><span>当前位置: </span><a href="javascript:void(0)">门店管理</a> 
              <div class="btn_opera">    
                   <input type="button" class="btn_add" value="关联已注册门店" rel="popup" link="chain.mainten.iframe-stores-init" title="选择门店" />
                   <input type="button" class="btn_add" value="门店注册" onClick="window.location.href='chain.mainten.mainten-reg?key=-start'" />
              </div>
          </h3>
          <div class="start_text">
               <i class="i_assoc"></i>
               <p>如果本单位是连锁总店，请点击右上角“<span>关联已注册门店</span>”从系统中选择已注册的门店单位，或点击“<span>门店注册</span>”注册新的门店，其它单位请勿操作！<br />关联已注册添加的门店，需要门店单位的手工确认操作，确认后，才成功建立连锁关系；帮助门店注册的，不需要门店单位的确认，直接建立连锁关系。</p>
          </div>
          <div class="table_box">
               <p class="gray" style="color:#221815;">以下单位将你加为门店，请选择一家</p>
              <table class="table_list">
                  <thead>
                     <tr>
                         <th style="width:5%"></th>
                         <th style="width:5%">序号</th>                                         
                         <th style="width:35%">总店名称</th>
                         <th style="width:55%">总店地址</th>
                     </tr>
                  </thead>
                  <tbody>             
                  </tbody>
               </table>
               <div class="clear"></div>
               <p class="save_box">
                  <input type="button" class="btn_save" value="建立连锁关系" />
                </p>
          </div>
          <div class="clear"></div>
     </div>
</div>
</body>
</html>