<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" +
            request.getServerPort() + request.getContextPath() + "/";

        /*

            根据交易表中的不同阶段的数量进行一个统计，最终形成一个漏斗图
            最少的在下面 最高的在上面

         */

%>



<html lang="en">
<head>
    <base href="<%=basePath%>" />
    <title >统计图表</title>
    <script  src="ECharts/echarts.min.js" ></script>
    <script src="jquery/jquery-1.11.1-min.js" ></script>

    <script type="text/javascript">

        $(function () {

            getCharts();

        });

        function getCharts() {

            $.ajax({
                url:"workbench/transaction/getCharts.do",
                type:"get",
                dataType:"json",
                success:function (data) {

                    var myChart = echarts.init(document.getElementById("main"));

                    option = {
                        title: {
                            text: '交易漏斗图',
                            subtext: '统计交易阶段数量'
                        },

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
                                max: data.totalSize,
                                minSize: '0%',
                                maxSize: '100%',
                                sort: 'descending',
                                gap: 2,
                                label: {
                                    show: true,
                                    position: 'inside'
                                },
                                labelLine: {
                                    length: 10,
                                    lineStyle: {
                                        width: 1,
                                        type: 'solid'
                                    }
                                },
                                itemStyle: {
                                    borderColor: '#fff',
                                    borderWidth: 1
                                },
                                emphasis: {
                                    label: {
                                        fontSize: 20
                                    }
                                },
                                data: data.dataList
                            }
                        ]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                }
            });
        }


    </script>


</head>
<body>
    <div id="main" style="width: 600px;height:400px;"></div>
</body>
</html>