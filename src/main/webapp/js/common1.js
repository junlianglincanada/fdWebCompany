 //判断将要填充的数据是否为null，是则返回&nbsp
 // 修改的原因是 返回到表中的为null的时候，会使表格变形
 // author 江正鹏
function isNullForTable(object) {
	if (object == null || object == "null" || object == "") {
		return "&nbsp;";

	} else {
		return object;
	}
}
