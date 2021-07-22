<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="echarts/echarts.min.js"></script>
<script type="text/javascript">

	$(function(){
		
		var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
        option = {
		    title: {
		        text: '漏斗图',
		        subtext: '纯属虚构'
		    },
		    tooltip: {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c}%"
		    },
		    toolbox: {
		        feature: {
		            dataView: {readOnly: false},
		            restore: {},
		            saveAsImage: {}
		        }
		    },
		    legend: {
		        data: ['展现','点击','访问','咨询','订单']
		    },
		    calculable: true,
		    series: [
		        {
		            name:'漏斗图',
		            type:'funnel',
		            left: '10%',
		            top: 60,
		            //x2: 80,
		            bottom: 60,
		            width: '80%',
		            // height: {totalHeight} - y - y2,
		            min: 0,
		            max: 100,
		            minSize: '0%',
		            maxSize: '100%',
		            sort: 'descending',
		            gap: 2,
		            label: {
		                normal: {
		                    show: true,
		                    position: 'inside'
		                },
		                emphasis: {
		                    textStyle: {
		                        fontSize: 20
		                    }
		                }
		            },
		            labelLine: {
		                normal: {
		                    length: 10,
		                    lineStyle: {
		                        width: 1,
		                        type: 'solid'
		                    }
		                }
		            },
		            itemStyle: {
		                normal: {
		                    borderColor: '#fff',
		                    borderWidth: 1
		                }
		            },
		            data: [
		                {value: 60, name: '访问'},
		                {value: 40, name: '咨询'},
		                {value: 20, name: '订单'},
		                {value: 80, name: '点击'},
		                {value: 100, name: '展现'}
		            ]
		        }
		    ]
		};

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
	
	})

</script>
</head>
<body>
	<div id="main" style="width: 600px;height:400px;"></div>
</body>
</html>