<%--
  Created by IntelliJ IDEA.
  User: 小型
  Date: 2017/8/17
  Time: 1:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="js/echarts.js"></script>
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="https://d3js.org/d3-color.v1.min.js"></script>
    <script src="https://d3js.org/d3-interpolate.v1.min.js"></script>
    <script src="https://d3js.org/d3.v4.min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=wbGR7UG37P5eR5REwQWGATK1AUwZNtit"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts-all-3.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
</head>
<body>
<div id="circle1" style="height: 360px;width: 600px;background: red;float: left"></div>
</body>
<script type="text/javascript">
    var myChart = echarts.init(document.getElementById('circle1'));
    var anglenum=8;
    var rollnum=4;
        var k=360/anglenum;
        var j=6/rollnum;
        var data="[[[1,95],[1,495],[1,0],[1,0],[1,0],[1,219],[1,138],[1,0]],[[1,336],[1,890],[1,606],[1,182],[1,316],[1,81],[1,160],[1,120]],[[1,61],[1,265],[1,63],[1,14],[1,16],[1,28],[1,14],[1,59]],[[1,23],[1,57],[1,8],[1,12],[1,0],[1,1],[1,7],[1,14]]]";
        var obj=eval(data);
        console.log(data)
        console.log(obj)
        var option={
            tooltip: {
                trigger:'item',
                formatter: function (params) {
                    return '距离：'+params.seriesIndex*j+'-'+(params.seriesIndex+1)*j+'km'+'</br>'
                        +'角度：'+params.dataIndex*k+'-'+(params.dataIndex+1)*k+'</br>'
                        +'数量：'+params.value[1];
                }
            },
            visualMap: {
                min: 1,
                max: 500,
                inRange: {
                    color: ['white','yellow', 'orange','red']
                }
            },
            series: []
        };
        for(var i=0;i<obj.length;i++){
            option.series.push( {
                name:'访问来源',
                type:'pie',
                label: {
                    normal: {
                        show: false,
                        position: 'center'
                    }
                },
                radius: [180*i/rollnum,180*(i+1)/rollnum],
                data:obj[i]
            })
        }
        myChart.setOption(option);

</script>
</html>
