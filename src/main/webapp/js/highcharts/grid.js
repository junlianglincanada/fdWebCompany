/*
 * Grid theme for Highcharts JS
 * @author bowencon
 */

Highcharts.theme = {
	colors: ['#ff0209', '#000000', '#f6a000' ,'#95c61f' ,'#eb5f9e' ,'#7c52ba'],
	chart: {
		backgroundColor:'#f2f2f2',
		borderColor:'#bababa',
		borderWidth:1,
		borderRadius:'0',
		plotBackgroundColor: '#fff', //绘图区域背景颜色
		plotBorderColor: '#fff',  //绘图区域边框颜色 
		plotBorderWidth: 1,      //绘图区域边框宽度
		plotShadow: false
	},
	title: {
		style: {
			color: '#888888',
			font: 'bold 16px "microsoft YaHei", Verdana, sans-serif'
		},
		align: 'left'
	},
	subtitle: {
		style: {
			color: '#666666',
			font: 'bold 12px "microsoft YaHei", Verdana, sans-serif'
		}
	},
	xAxis: {
		gridLineColor: '#a8a8a8',//设置纵向标尺颜色  
		gridLineWidth: 1,        //设置纵向标尺宽度  
		lineColor: '#808080',    //设置X轴线颜色
		lineWidth: 2,            //设置X轴线宽度
		tickColor: '#838383',
		tickWidth: 0,            //设置X轴坐标点是否出现占位及其宽度 
		labels: {
			style: {
				color: '#000',
				font: '12px microsoft YaHei, Verdana, sans-serif'
			}
		},
		title: {
			style: {
				color: '#333',
				fontWeight: '400',
				fontSize: '12px',
				fontFamily: 'microsoft YaHei, Verdana, sans-serif'
			}
		}
	},
	yAxis: {
		minorTickInterval: 'auto',//设置是否出现横向小标尺
		minorGridLineWidth: 0,    
		gridLineColor: '#a8a8a8', //设置横向标尺颜色 
		gridLineWidth: 1,
		lineColor: '#808080',     //设置Y轴线颜色
		lineWidth: 2,             
		tickColor: '#e1e1e1',
		tickWidth: 0, 
		labels: {
			style: {
				color: '#000',
				font: '12px microsoft YaHei, Verdana, sans-serif'
			}
		},
		title: {
			style: {
				color: '#333',
				fontWeight: '400',
				fontSize: '12px',
				fontFamily: 'microsoft YaHei, Verdana, sans-serif'
			}
		}
	},
	legend: {
		itemStyle: {
			font: '9pt microsoft YaHei, Verdana, sans-serif',
			color: 'black'

		},
		itemHoverStyle: {
			color: '#039'
		},
		itemHiddenStyle: {
			color: 'gray'
		},
		x: 0,
		y: 0,
		align: 'center',
		verticalAlign: 'bottom',
		backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
		borderColor: '#CCC',
		borderWidth: 1,
		floating: false, //当图例是浮动的，绘图区将会忽略它，且绘图区会放在图例的后边
		shadow: false, //是否显示阴影
		enabled: false  //是否显示图例
	},
	labels: {
		style: {
			color: '#99b'
		}
	},
	exporting:{ 
            enabled:false //设置是否显示‘打印’,'导出'等功能按钮，不设置时默认为显示 
    },
	credits: {
			enabled: false // 去掉图表上那个官网标识链接
	}
};

// Apply the theme
var highchartsOptions = Highcharts.setOptions(Highcharts.theme);

// Apply the exporting
Highcharts.wrap(Highcharts.Chart.prototype, 'getSVG', function (proceed) {
	 		 		 	    return proceed.call(this)
	 		 		 	        .replace(
	 		 		 	            /(fill|stroke)="rgba\(([ 0-9]+,[ 0-9]+,[ 0-9]+),([ 0-9\.]+)\)"/g, 
	 		 		 	            '$1="rgb($2)" $1-opacity="$3"'
	 		 		 	        );
});
