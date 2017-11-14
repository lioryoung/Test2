<%@ page import="com.google.gson.Gson" %><%--
  Created by IntelliJ IDEA.
  User: 小型
  Date: 2017/6/30
  Time: 10:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<br>
<head>
    <title>Title</title>
    <script src="js/echarts.js"></script>
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="https://d3js.org/d3-color.v1.min.js"></script>
    <script src="https://d3js.org/d3-interpolate.v1.min.js"></script>
    <script src="https://d3js.org/d3.v4.min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=wbGR7UG37P5eR5REwQWGATK1AUwZNtit"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/CurveLine/1.5/src/CurveLine.min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts-all-3.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
</head>

<body>


<div id="title" style="width: 100%;height: 50px;background: red">
    <a id="button1" style="width: 50%;height: 50px;background: blue;float: left;text-align: center" onclick="showcontent1()">
        借还总体情况
    </a>
    <a id="button2" style="width: 50%;height: 50px;background: green;float: right;text-align: center" onclick="showcontent2()">
        单个站点情况
    </a>
</div>
<div id="content1" style="display:block">
日期：<input type="date" id="mintime" value="2014-04-01"/>到<input type="date" id="maxtime" Value="2014-04-21"/><input type="button" value="查询直方图" onclick="make()"></br>
借还车时间间隔：<input type="number" id="interval1"/>到<input type="number"  id="interval2"/></br>
站点距离：<input type="number" id="stadistance1"/>到<input type="number" id="stadistance2"/><br>
借还车时间段（小时）：<input type="number" id="lrhour1"/>到<input type="number" id="lrhour2"/><br>
<input type="button" id="countrange" value="显示此时间段借还车次数范围" onclick="searchrang()"/>min:<input type="number" id="mincount"/>max:<input type="number" id="maxcount"/><input type="button" value="查询线" onclick="searchline()">
    <input type="button" value="清空" onclick="reset()">
<br>
<div id="map" style="height: 800px;width: 100%"></div></br>

    <div style="position: absolute;margin-top: -170px;margin-left: 90%">
        <div style="width: 20px;height: 120px;background: yellow;float: left">
            <svg width="20px" height="120px" viewBox="0 0 20 120"
                 xmlns="http://www.w3.org/2000/svg">
                <defs>
                    <linearGradient id="myGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                        <stop offset="0%" stop-color='red' />
                        <stop offset="50%" stop-color='yellow' />
                        <stop offset="100%" stop-color='green' />
                    </linearGradient>
                </defs>
                <rect fill="url(#myGradient)"
                      width="20" height="120"/>
            </svg>
        </div>
        <div style="width: 50px;height: 120px;background: rgba(0,0,0,0);float: right">
            <p id="max" style="margin-top: 0">300</p>
            <p style="margin-top: 80px">0</p>
        </div>
    </div>
<div id="chart1" style="width: 50%;height: 300px;background: red;display: inline-block;float: left;margin-top: 20px"></div></br>
<div id="chart2" style="width: 50%;height: 300px;background: green;display: inline-block;float: right"></div>
<div id="chart3" style="width: 50%;height: 300px;background: grey;display: inline-block;float: left"></div>
<div id="chart4" style="width: 50%;height: 300px;background: red;display: inline-block;float: right"></div>
</div>
<div id="content2" style="display: none">

    <div id="map2" style="height: 600px;width: 100%;bfloat: left"></div>
    日期：<input type="date" id="time1" value="2014-04-01"/>到<input type="date" id="time2" Value="2014-04-30"/>
    环数：<input type="number" id="rollnum" value="6" style="width: 50px"/>
    角度块:<input type="number" id="anglenum" value="12" style="width: 50px"/>站点名:<input type="text" id="stationname" />
    <input type="button" id="showtopten" value="前十借还流量" onclick="showtopten()"/><br>
    借还车时间段（小时）：<input type="number" id="lrhour3" />到<input type="number" id="lrhour4" />
    <input type="button" id="search" value="按小时检索6km" onclick="search(0)"/>
    <input type="button" id="search2" value="按时间段检索6km" onclick="search(1)"/>
    <input type="button" id="search3" value="按时间段检索11km" onclick="search(3)"/>
    <input type="button" id="search4" value="按小时检索11km" onclick="search(4)"/>
    <input type="button" id="showall" style="margin-left: 50px" value="显示全部站点" onclick="showall()"/></br>
    <div id="circle1" style="height: 295px;width:355px;float: left;display: inline-block;border: 2px"></div>
    <div id="circle2" style="height: 295px;width: 355px;display: inline-block;margin-left: 20px"></div></br>
    <div id="zhifang1" style="height: 200px;width: 350px;background: green;float: left;display: inline-block;margin-top: -40px"></div>
    <div id="zhifang2" style="height: 200px;width: 350px;background: green;display: inline-block;margin-top: -40px;margin-left: 20px"></div>
</div>
</body>

</html>
<script type="text/javascript">
    function showcontent1()
    {
        document.getElementById("content1").style.display="block";
        document.getElementById("content2").style.display="none";
    }
    var stationId;
    var limitjson;
    var map1;
    var poi;
    var zoom=2;
    var flag=0;
    var chartflag=0;
    var disflag=6;
    var toptenstring;
    var stationname;
    function showcontent2()
    {
        document.getElementById("content2").style.display="block";
        document.getElementById("content1").style.display="none";
        map1 = new BMap.Map("map2");
        map1.centerAndZoom(new BMap.Point(120.170828,30.260416), 13);
        var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
        var top_left_navigation = new BMap.NavigationControl();
        map1.addControl(top_left_control);
        map1.addControl(top_left_navigation);
        var  mapStyle ={
            features: ["road", "building","water","land"],//隐藏地图上的poi
            style : "grayscale"  //设置地图风格为高端黑
        }
        map1.setMapStyle(mapStyle);
        addSubWay();
        map1.addEventListener("zoomend", function() {
            if(flag==1) {
                map1.clearOverlays();
                addSubWay()
                var options = {
                    size: BMAP_POINT_SIZE_BIG,
                    shape: BMAP_POINT_SHAPE_STAR,
                    color: '#d340c3'
                }
                var points = [];
                points.push(poi)
                var pointCollection = new BMap.PointCollection(points, options);
                map1.addOverlay(pointCollection);
                zoom = Math.pow(1 / 2, map1.getZoom() - 14);
                var s = limitjson.split("|");
                var obj = eval(s[0]);
                if (chartflag == 0) {
                    var i1 = d3.interpolate('#eac736', '#d94e5d');
                    for (var i = 0; i < obj.length; i++) {
                        makecircle(obj[i].baidux, obj[i].baiduy, obj[i].stationid, obj[i].stationname, obj[i].count, i1(Number(obj[i].count) / Number(s[1])))
                    }
                }
                if(chartflag==1){
                    var i1 = d3.interpolate('#36D1C4','#413691');
                    for (var i = 0; i < obj.length; i++) {
                        makecircle(obj[i].baidux,obj[i].baiduy,obj[i].stationid,obj[i].stationname,obj[i].count,i1(Number(obj[i].count)/Number(s[1])))
                    }
                }
            }
            if(flag==2){

            }

        })

        $.post("/GetStationServlet",{},function (result) {
                var obj=eval(result);
                if (document.createElement('canvas').getContext) {  // 判断当前浏览器是否支持绘制海量点
                    var points = [];  // 添加海量点数据
                    for (var i = 0; i < obj.length; i++) {
                        var p = new BMap.Point(obj[i].baidux,obj[i].baiduy);
                        p.data = obj[i].stationid+"|"+obj[i].stationname;
                        points.push(p);
                    }
                    var options = {
                        size: BMAP_POINT_SIZE_NORMAL,
                        shape: BMAP_POINT_SHAPE_CIRCLE,
                        color: '#d340c3'
                    }
                    var pointCollection = new BMap.PointCollection(points, options);  // 初始化PointCollection
                    pointCollection.addEventListener('click', function (e) {
                        var da=e.point.data;
                        var s=da.split("|");
                        $("#stationname").attr("value",s[1]);
                        var opts = {
                            width : 200,     // 信息窗口宽度
                            height: 100,     // 信息窗口高度
                            title : "" , // 信息窗口标题
                            enableMessage:true,//设置允许信息窗发送短息
                            message:""
                        }
                        var infoWindow = new BMap.InfoWindow("站点:"+s[1]+"</br>id："+s[0], opts);  // 创建信息窗口对象
                        map1.openInfoWindow(infoWindow,e.point);
                        stationId=s[1];
                    });
                    map1.addOverlay(pointCollection);  // 添加Overlay
                } else {
                    alert('请在chrome、safari、IE8+以上浏览器查看本示例');
                }
            }
        );

    }

    function makecircle(sx,sy,id,name,count,colo) {
        var innerCicle = new BMap.Circle(new BMap.Point(sx,sy), 100*zoom , {
            fillColor: colo,//'#87CEFA'
            fillOpacity: 1,
            strokeColor: colo,//'#87CEFA'
            strokeStyle: 'solid',
            strokeWeight: '1px'
        });
        innerCicle.addEventListener("click",attribute);
        /*innerCicle.addEventListener('click', function () {
            var opts = {
             width: 200,     // 信息窗口宽度
             height: 100,     // 信息窗口高度var marker = new BMap.Marker(new BMap.Point(116.404, 39.915));
             title: "", // 信息窗口标题
             enableMessage: true,//设置允许信息窗发送短息
             message: ""
             }
             var infoWindow = new BMap.InfoWindow("站点:"+name+"</br>id："+id+"</br>流量："+count, opts);  // 创建信息窗口对象
             map1.openInfoWindow(infoWindow, new BMap.Point(sx, sy)); //开启信息窗口
            console.log(name);
        }, false);*/
        function attribute(){
            //获取marker的位置
            alert("marker的位置是");
        }
        map1.addOverlay(innerCicle);
    }
    function makecircle2(sx,sy,id,name,count,colo) {
        var innerCicle = new BMap.Circle(new BMap.Point(sx,sy), 200 , {
            fillColor: colo,//'#87CEFA'
            fillOpacity: 1,
            strokeColor: colo,//'#87CEFA'
            strokeStyle: 'solid',
            strokeWeight: '1px',
            enableClicking: true
        });
        innerCicle.addEventListener('click', function () {
            var opts = {
                width: 200,     // 信息窗口宽度
                height: 100,     // 信息窗口高度
                title: "", // 信息窗口标题
                enableMessage: true,//设置允许信息窗发送短息
                message: ""
            }
            var infoWindow = new BMap.InfoWindow("站点:"+name+"</br>id："+id+"</br>流量："+count, opts);  // 创建信息窗口对象
            map1.openInfoWindow(infoWindow, new BMap.Point(sx, sy)); //开启信息窗口

            console.log(name);
        }, false);
        map1.addOverlay(innerCicle);
    }
    //点击显示所有站点
    function showall() {
        map1.clearOverlays();
        $.post("/GetStationServlet",{},function (result) {
                var obj=eval(result);
                if (document.createElement('canvas').getContext) {  // 判断当前浏览器是否支持绘制海量点
                    var points = [];  // 添加海量点数据
                    for (var i = 0; i < obj.length; i++) {
                        var p = new BMap.Point(obj[i].baidux,obj[i].baiduy);
                        p.data = obj[i].stationid+"|"+obj[i].stationname;
                        points.push(p);
                    }
                    var options = {
                        size: BMAP_POINT_SIZE_NORMAL,
                        shape: BMAP_POINT_SHAPE_CIRCLE,
                        color: '#d340c3'
                    }
                    var pointCollection = new BMap.PointCollection(points, options);  // 初始化PointCollection
                    pointCollection.addEventListener('click', function (e) {
                        var da=e.point.data;
                        var s=da.split("|");
                        $("#stationname").attr("value",s[1]);
                        var opts = {
                            width : 200,     // 信息窗口宽度
                            height: 100,     // 信息窗口高度
                            title : "" , // 信息窗口标题
                            enableMessage:true,//设置允许信息窗发送短息
                            message:""
                        }
                        var infoWindow = new BMap.InfoWindow("站点:"+s[0]+"</br>id："+s[1], opts);  // 创建信息窗口对象
                        map1.openInfoWindow(infoWindow,e.point);
                        console.log(s[1]);
                        stationId=s[0];
                    });
                    map1.addOverlay(pointCollection);  // 添加Overlay
                } else {
                    alert('请在chrome、safari、IE8+以上浏览器查看本示例');
                }
            }
        );
        flag=0;
    }
    
    //加载热力图
    function search(setype) {
        myChart.clear();
        myChartshanxing.clear();
        var rollnum=$("#rollnum").val();
        var anglenum=$("#anglenum").val();
        var time1=$("#time1").val();
        var time2=$("#time2").val();
        var lrhour3=$("#lrhour3").val();
        var lrhour4=$("#lrhour4").val();
        stationId=$("#stationname").val();
        if(setype==1&&setype==4){
            lrhour3="";
            lrhour4="";
        }
        console.log(stationId);
        console.log(rollnum);
        if(setype!=3&&setype!=4) {
            disflag=6;
            $.post("/GetHeatServlet", {
                "stationId": stationId,
                "rollnum": rollnum,
                "anglenum": anglenum,
                "time1": time1,
                "time2": time2,
                "lrhour3": lrhour3,
                "lrhour4": lrhour4
            }, function (result) {
                searchheat(result, anglenum, rollnum);
            });
            $.post("/ReturnHeatServlet", {
                "stationId": stationId,
                "rollnum": rollnum,
                "anglenum": anglenum,
                "time1": time1,
                "time2": time2,
                "lrhour3": lrhour3,
                "lrhour4": lrhour4
            }, function (result) {
                searchheat2(result, anglenum, rollnum);
            });
            $.post("/ServletOneStation", {"stationId": stationId}, function (result) {
                //console.log(result)
                var obj = eval("(" + result + ")");
                poi = new BMap.Point(obj.baidu_x, obj.baidu_y)
                console.log(poi)
            });
        }
        else{
            rollnum=11;
            disflag=11;
            $("#rollnum").attr("value",11);
            $.post("/GetHeatServletFor11", {
                "stationId": stationId,
                "rollnum": rollnum,
                "anglenum": anglenum,
                "time1": time1,
                "time2": time2,
                "lrhour3": lrhour3,
                "lrhour4": lrhour4
            }, function (result) {
                searchheat(result, anglenum, rollnum);
            });
            $.post("/ReturnHeatServletFor11", {
                "stationId": stationId,
                "rollnum": rollnum,
                "anglenum": anglenum,
                "time1": time1,
                "time2": time2,
                "lrhour3": lrhour3,
                "lrhour4": lrhour4
            }, function (result) {
                searchheat2(result, anglenum, rollnum);
            });
            $.post("/ServletOneStation", {"stationId": stationId}, function (result) {
                //console.log(result)
                var obj = eval("(" + result + ")");
                poi = new BMap.Point(obj.baidu_x, obj.baidu_y)
                console.log(poi)
            });
        }
    }
    var myChart = echarts.init(document.getElementById('circle1'));
    //扇形图1点击事件
    myChart.on('click', function (params) {
        // 控制台打印数据的名称
/////////////////////////////////////////////////
        map1.clearOverlays();
        var rollnum=$("#rollnum").val();
        var anglenum=$("#anglenum").val();
        var time1=$("#time1").val();
        var time2=$("#time2").val();
        var angle1=params.dataIndex*360/anglenum;
        var angle2=angle1+360/anglenum;
        var dis1=params.seriesIndex*disflag/rollnum;
        var dis2=dis1+disflag/rollnum;
        $.post("/GetRankServlet",{"stationId":stationId,"dis1":dis1,"dis2":dis2,"angle1":angle1,"angle2":angle2,"time1":time1,"time2":time2},function (result) {
            obj=eval("("+result+")");
            console.log(obj.name);
            myChart0.setOption({
                yAxis: {
                    type: 'category',
                    data: obj.name
                },
                series: [{
                    name: '2016年占比',
                    type: 'bar',
                    data: obj.count
                }]
            })
        });
        var options = {
            size: BMAP_POINT_SIZE_BIG,
            shape: BMAP_POINT_SHAPE_STAR,
            color: '#d340c3'
        }
        var points=[];
        points.push(poi)
        var pointCollection = new BMap.PointCollection(points, options);
        map1.addOverlay(pointCollection);
        $.post("/GetLimitStaServlet",{"stationId":stationId,"dis1":dis1,"dis2":dis2,"angle1":angle1,"angle2":angle2,"time1":time1,"time2":time2},function (result) {

            //console.log(result)
            limitjson=result;
            var s=result.split("|");
            var obj=eval(s[0]);
            var i1 = d3.interpolate( '#eac736','#d94e5d');
            zoom = Math.pow(1 / 2, map1.getZoom() - 14);
            for (var i = 0; i < obj.length; i++) {
                makecircle(obj[i].baidux,obj[i].baiduy,obj[i].stationid,obj[i].stationname,obj[i].count,i1(Number(obj[i].count)/Number(s[1])))
                // makecircle2(obj[i].baidux,obj[i].baiduy,obj[i].stationid,obj[i].stationname,obj[i].count,i1(Number(obj[i].count)/Number(s[1])))
            }
        });
        flag=1;
        chartflag=0;

    });
    var myChart0 = echarts.init(document.getElementById('zhifang1'));
    myChart0.setOption({
        color: ['#d94e5d'],
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            },
            formatter: "{b} : {c}"
        },
        legend: {
            data: ['2016年']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '1%',
            containLabel: true
        },
        xAxis: {
            type: 'value',
            boundaryGap: [0, 0.01],
            "axisLabel": {
                "interval": 0,
            }
        },
        yAxis: {
            type: 'category',
            data: []
        },
        series: [{
            name: '2016年占比',
            type: 'bar',
            data: []
        }]
    })


    //蓝色扇形
    var myChartshanxing = echarts.init(document.getElementById('circle2'));
    var myChartzhifang = echarts.init(document.getElementById('zhifang2'));
    myChartzhifang.setOption({
        color: ['#413691'],
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            },
            formatter: "{b} : {c}"
        },
        legend: {
            data: ['2016年']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '1%',
            containLabel: true
        },
        xAxis: {
            type: 'value',
            boundaryGap: [0, 0.01],
            "axisLabel": {
                "interval": 0,
            }
        },
        yAxis: {
            type: 'category',
            data: []
        },
        series: [{
            name: '2016年占比',
            type: 'bar',
            data: []
        }]
    })
    myChartshanxing.on('click', function (params) {
        // 控制台打印数据的名称
/////////////////////////////////////////////////
        map1.clearOverlays();
        var rollnum=$("#rollnum").val();
        var anglenum=$("#anglenum").val();
        var time1=$("#time1").val();
        var time2=$("#time2").val();
        var angle1=params.dataIndex*360/anglenum;
        var angle2=angle1+360/anglenum;
        var dis1=params.seriesIndex*disflag/rollnum;
        var dis2=dis1+disflag/rollnum;
        $.post("/GetReturnRankServlet",{"stationId":stationId,"dis1":dis1,"dis2":dis2,"angle1":angle1,"angle2":angle2,"time1":time1,"time2":time2},function (result) {
            obj=eval("("+result+")");
            console.log(obj.name);
            myChartzhifang.setOption({
                yAxis: {
                    type: 'category',
                    data: obj.name
                },
                series: [{
                    name: '2016年占比',
                    type: 'bar',
                    data: obj.count
                }]
            })
        });

        var options = {
            size: BMAP_POINT_SIZE_BIG,
            shape: BMAP_POINT_SHAPE_STAR,
            color: '#d340c3'
        }
        var points=[];
        points.push(poi)
        var pointCollection = new BMap.PointCollection(points, options);
        map1.addOverlay(pointCollection);
        $.post("/GetLimitSta2Servlet",{"stationId":stationId,"dis1":dis1,"dis2":dis2,"angle1":angle1,"angle2":angle2,"time1":time1,"time2":time2},function (result) {

            //console.log(result)
            limitjson=result;
            var s=result.split("|");
            var obj=eval(s[0]);
            if (document.createElement('canvas').getContext) {  // 判断当前浏览器是否支持绘制海量点
                var points = [];  // 添加海量点数据
                /*for (var i = 0; i < obj.length; i++) {
                    var p = new BMap.Point(obj[i].baidux,obj[i].baiduy);
                    p.data = obj[i].stationname+"|"+obj[i].stationid+"|"+obj[i].count;
                    points.push(p);
                }*/
                var i1 = d3.interpolate('#36D1C4','#413691');
                zoom = Math.pow(1 / 2, map1.getZoom() - 14);
                for (var i = 0; i < obj.length; i++) {
                    makecircle(obj[i].baidux,obj[i].baiduy,obj[i].stationid,obj[i].stationname,obj[i].count,i1(Number(obj[i].count)/Number(s[1])))
                }
                /*var options = {
                    size: BMAP_POINT_SIZE_NORMAL,
                    shape: BMAP_POINT_SHAPE_CIRCLE,
                    color: '#0000FF'
                }
                var pointCollection = new BMap.PointCollection(points, options);  // 初始化PointCollection
                pointCollection.addEventListener('click', function (e) {
                    var da=e.point.data;
                    var s=da.split("|");
                    var opts = {
                        width : 200,     // 信息窗口宽度
                        height: 100,     // 信息窗口高度
                        title : "" , // 信息窗口标题
                        enableMessage:true,//设置允许信息窗发送短息
                        message:""
                    }
                    var infoWindow = new BMap.InfoWindow("站点"+s[0]+"</br>id："+s[1]+"</br>流量："+s[2], opts);  // 创建信息窗口对象
                    map1.openInfoWindow(infoWindow,e.point);
                });
                map1.addOverlay(pointCollection); */ // 添加Overlay
            } else {
                alert('请在chrome、safari、IE8+以上浏览器查看本示例');
            }

        });
        flag=1;
        chartflag=1;

    });

    function searchheat(data,anglenum,rollnum) {
        var k=360/anglenum;
        var j=disflag/rollnum;
        console.log(data)
        var obj=eval("("+data+")");
        var itemStyle = {
            normal: {
                //opacity: 0.7,
                // color: {
                //     image: piePatternImg,
                //    repeat: 'repeat'
                // },
                borderWidth: 1,
                borderColor: '#eac736'
            }
        };
        var option={
            title: {
                text: 'RENT FROM CENTER STATION',
                left:20
            },
            tooltip: {
                trigger:'item',
                formatter: function (params) {
                    return '距离：'+params.seriesIndex*j+'-'+(params.seriesIndex+1)*j+'km'+'</br>'
                        +'角度：'+params.dataIndex*k+'-'+(params.dataIndex+1)*k+'</br>'
                        +'数量：'+params.value[1];
                }
            },
            visualMap: {
                min: 0,
                max:obj.max,
                calculable : true,
                inRange: {
                    color: ['white', '#eac736','#d94e5d']
                },
                itemHeight:50,
                bottom:10
            },
            series: []
        };
        console.log(obj)
        for(var i=0;i<obj.json.length;i++){
            option.series.push( {
                name:'访问来源',
                type:'pie',
                label: {
                    normal: {
                        show: false,
                        position: 'center'
                    }
                },
                radius: [120*i/rollnum,120*(i+1)/rollnum],
                data:obj.json[i],
                itemStyle: itemStyle
            })
        }
        myChart.setOption(option);
    }
    function searchheat2(data,anglenum,rollnum) {
        var k=360/anglenum;
        var j=disflag/rollnum;
        var obj=eval("("+data+")");
        console.log(data)
        console.log(obj)
        var itemStyle = {
            normal: {
                //opacity: 0.7,
                // color: {
                //     image: piePatternImg,
                //    repeat: 'repeat'
                // },
                borderWidth: 1,
                borderColor: '#235894'
            }
        };
        var option={
            title: {
                text: 'RETURN TO CENTER STATION',
                left:20
            },
            tooltip: {
                trigger:'item',
                formatter: function (params) {
                    return '距离：'+params.seriesIndex*j+'-'+(params.seriesIndex+1)*j+'km'+'</br>'
                        +'角度：'+params.dataIndex*k+'-'+(params.dataIndex+1)*k+'</br>'
                        +'数量：'+params.value[1];
                }
            },
            visualMap: {
                min: 0,
                max: obj.max,
                calculable : true,
                inRange: {
                    color: ['white','#36D1C4','#413691']
                },
                itemHeight:50,
                bottom:10
            },
            series: []
        };
        for(var i=0;i<obj.json.length;i++){
            option.series.push( {
                name:'访问来源',
                type:'pie',
                label: {
                    normal: {
                        show: false,
                        position: 'center'
                    }
                },
                radius: [120*i/rollnum,120*(i+1)/rollnum],
                data:obj.json[i],
                itemStyle: itemStyle
            })
        }
        myChartshanxing.setOption(option);
    }
    function addSubWay() {
        let points = [
            [[120.354264,30.316329],
                [120.341868,30.315456]],
            [[120.341221,30.315425],
                [120.332328,30.315347]],
            [[120.331735,30.315362],
                [120.319284,30.31569]],
            [[120.318745,30.315721],
                [120.285185,30.31689]],
            [[120.284897,30.31689],
                [120.282094,30.31664],
                [120.274549,30.313835],
                [120.273183,30.313772]],
            [[120.273183,30.313772],
                [120.268117,30.313866],
                [120.261541,30.31293],
                [120.259026,30.312026]],
            [[120.258595,30.311777],
                [120.247815,30.30657]],
            [[120.247384,30.306344],
                [120.234161,30.301332],
                [120.23028,30.300396]],
            [[120.229633,30.300241],
                [120.221225,30.298183],
                [120.214398,30.294441],
                [120.199342,30.290324]],
            [[120.198678,30.290106],
                [120.197708,30.289794],
                [120.194761,30.28967],
                [120.187323,30.29101],
                [120.18373,30.290886]],
            [[120.183155,30.290886],
                [120.178879,30.290168],
                [120.175897,30.289171],
                [120.173238,30.287705],
                [120.172268,30.287011],
                [120.172268,30.286075]],
            [[120.172268,30.285576],
                [120.172375,30.281335],
                [120.170112,30.276563],
                [120.17004,30.275752],
                [120.170255,30.26861]],
            [[120.170291,30.268111],
                [120.170507,30.26078]],
            [[120.170579,30.26025],
                [120.170902,30.254978],
                [120.172232,30.25267],
                [120.173489,30.251765],
                [120.174064,30.251703]],
            [[120.174567,30.251671],
                [120.183766,30.251297],
                [120.186497,30.250767],
                [120.187323,30.250268]],
            [[120.18779,30.249987],
                [120.197205,30.242905]],
            [[120.1976,30.242499],
                [120.203672,30.237164]],
            [[120.204139,30.236727],
                [120.213087,30.227444],
                [120.222824,30.216163],
                [120.222896,30.215726]],
            [[120.223004,30.215188],
                [120.223974,30.206074]],
            [[120.224046,30.205513],
                [120.225447,30.195243],
                [120.226489,30.193745],
                [120.226956,30.193464]],
            [[120.227388,30.193183],
                [120.228034,30.192746],
                [120.235652,30.191029],
                [120.237017,30.19003]],
            [[120.237449,30.189718],
                [120.241006,30.186222],
                [120.24,30.182101],
                [120.240718,30.174226]]
        ];
        points.forEach(item => {
            let pointsArr = item.map(point => new BMap.Point(point[0], point[1]));
        let polyline = new BMap.Polyline(pointsArr, {
            strokeColor: '#DC0000', strokeWeight: 2, strokeOpacity: 1
        });
        map1.addOverlay(polyline);
    });
    }
    function showtopten() {
        map1.clearOverlays();
        var time1=$("#time1").val();
        var time2=$("#time2").val();
        stationname=$("#stationname").val();
        $.post("/ServletShowTopTen",{"time1":time1,"time2":time2,"stationname":stationname},function (result) {
            var obj1=eval("("+result+")");
            toptenstring=result;
            var obj=obj1.json;
            for(var i=0;i<obj.length;i++){
                makelien2(obj[i].leasestationx,obj[i].leasestationy,obj[i].returnstationx,obj[i].returnstationy,obj[i].count,obj1.max,1,obj[i].leasestationname,obj[i].returnstationname,zoom,obj[i].leasestation,obj[i].returnstation,obj[i].usercount);
            }
        })
        $.post("/ServletOneStation", {"stationId": stationname}, function (result) {
            //console.log(result)
            var obj = eval("(" + result + ")");
            poi = new BMap.Point(obj.baidu_x, obj.baidu_y)
            var options = {
                size: BMAP_POINT_SIZE_BIG,
                shape: BMAP_POINT_SHAPE_STAR,
                color: '#d340c3'
            }
            var points=[];
            points.push(poi)
            var pointCollection = new BMap.PointCollection(points, options);
            map1.addOverlay(pointCollection);
        });
    }
    function makelien2(sx,sy,ex,ey,count,maxnum,minnum,sname,ename,zoom,leasestation,returnstation,usercount) {
        var i1 = d3.interpolate('green', 'yellow');
        var i2 = d3.interpolate('yellow', 'red');
        var opacity=1;
        opacity=count/maxnum;
        if(count==0){
            opacity=0.1;
        }
        var color;
        if(opacity>0.5){
            color=i2(opacity*2-1);
        }else{
            color=i1(opacity*2);
        }


            var beijingPosition = new BMap.Point(sx, sy),
                hangzhouPosition = new BMap.Point(ex, ey);
        if(sname!=stationname) {
            var marker2 = new BMap.Circle(beijingPosition, 50 * zoom, {
                fillColor: "blue",//'#87CEFA'
                fillOpacity: 1,
                strokeColor: "blue",//'#87CEFA'
                strokeStyle: 'solid',
                strokeWeight: '1px',
                enableClicking: true
            });
            map1.addOverlay(marker2);
            marker2.addEventListener('click', function () {
                var opts = {
                    width : 200,     // 信息窗口宽度
                    height: 100,     // 信息窗口高度
                    title : "" , // 信息窗口标题
                    enableMessage:true,//设置允许信息窗发送短息
                    message:""
                }
                console.log(count)
                var infoWindow = new BMap.InfoWindow("起点"+leasestation+"："+sname+"</br>终点"+returnstation+"："+ename+"</br>流量："+count, opts);  // 创建信息窗口对象
                map1.openInfoWindow(infoWindow,beijingPosition); //开启信息窗口

            });

        }
        if(ename!=stationname) {
            var marker3 = new BMap.Circle(hangzhouPosition, 50 * zoom, {
                fillColor: "blue",//'#87CEFA'
                fillOpacity: 1,
                strokeColor: "blue",//'#87CEFA'
                strokeStyle: 'solid',
                strokeWeight: '1px',
                enableClicking: true
            });
            map1.addOverlay(marker3);
            marker3.addEventListener('click', function () {
                var opts = {
                    width : 200,     // 信息窗口宽度
                    height: 100,     // 信息窗口高度
                    title : "" , // 信息窗口标题
                    enableMessage:true,//设置允许信息窗发送短息
                    message:""
                }
                console.log(count)
                var infoWindow = new BMap.InfoWindow("起点"+leasestation+"："+sname+"</br>终点"+returnstation+"："+ename+"</br>流量："+count, opts);  // 创建信息窗口对象
                map1.openInfoWindow(infoWindow,hangzhouPosition); //开启信息窗口

            }, false);

        }
            var points = [beijingPosition, hangzhouPosition];

            /*if(maxnum!=minnum){
             opacity=(count-minnum)/(maxnum-minnum);
             }
             if(count==minnum&&count!=maxnum){
             opacity=0.1;
             }
             if(opacity<0.1){
             opacity=0.1;
             }*/

            var line_style = {strokeColor: color, strokeWeight: opacity * 10, strokeOpacity: 1};
            var curve = new BMapLib.CurveLine(points, line_style); //创建弧线对象
            curve.addEventListener('click', function () {
                var opts = {
                    width : 200,     // 信息窗口宽度
                    height: 100,     // 信息窗口高度
                    title : "" , // 信息窗口标题
                    enableMessage:true,//设置允许信息窗发送短息
                    message:""
                }
                console.log(count)
                var infoWindow = new BMap.InfoWindow("起点"+leasestation+"："+sname+"</br>终点"+returnstation+"："+ename+"</br>流量："+count, opts);  // 创建信息窗口对象
                map1.openInfoWindow(infoWindow,beijingPosition); //开启信息窗口

            }, false);
            map1.addOverlay(curve); //添加到地图中
            addArrow2(curve, line_style);

        //arrow
        function addArrow2(lines, line_style) {
            var length = 10;
            var angleValue = Math.PI / 7;
            var linePoint = lines.getPath();
            var arrowCount = linePoint.length;
            var middle = arrowCount / 2;
            var pixelStart = map.pointToPixel(linePoint[Math.floor(middle)]);
            var pixelEnd = map.pointToPixel(linePoint[Math.ceil(middle)]);
            var angle = angleValue;
            var r = length;
            var delta = 0;
            var param = 0;
            var pixelTemX, pixelTemY;
            var pixelX, pixelY, pixelX1, pixelY1;
            if (pixelEnd.x - pixelStart.x == 0) {
                pixelTemX = pixelEnd.x;
                if (pixelEnd.y > pixelStart.y) {
                    pixelTemY = pixelEnd.y - r;
                } else {
                    pixelTemY = pixelEnd.y + r;
                }
                pixelX = pixelTemX - r * Math.tan(angle);
                pixelX1 = pixelTemX + r * Math.tan(angle);
                pixelY = pixelY1 = pixelTemY;
            } else {
                delta = (pixelEnd.y - pixelStart.y) / (pixelEnd.x - pixelStart.x);
                param = Math.sqrt(delta * delta + 1);
                if ((pixelEnd.x - pixelStart.x) < 0) {
                    pixelTemX = pixelEnd.x + r / param;
                    pixelTemY = pixelEnd.y + delta * r / param;
                } else {
                    pixelTemX = pixelEnd.x - r / param;
                    pixelTemY = pixelEnd.y - delta * r / param;
                }
                pixelX = pixelTemX + Math.tan(angle) * r * delta / param;
                pixelY = pixelTemY - Math.tan(angle) * r / param;
                pixelX1 = pixelTemX - Math.tan(angle) * r * delta / param;
                pixelY1 = pixelTemY + Math.tan(angle) * r / param;
            }
            var pointArrow = map.pixelToPoint(new BMap.Pixel(pixelX, pixelY));
            var pointArrow1 = map.pixelToPoint(new BMap.Pixel(pixelX1, pixelY1));
            var Arrow = new BMap.Polyline([pointArrow, linePoint[Math.ceil(middle)], pointArrow1], line_style);
            map1.addOverlay(Arrow);
        }
    }
</script>


<script type="text/javascript">
    //chart1

    var myChart1 = echarts.init(document.getElementById('chart1'));
    // 显示标题，图例和空的坐标轴
    myChart1.setOption({
        title: {
            text: 'date',
            textStyle:{
                fontSize:15
            },
            padding:[35,20,0,50]
        },
        tooltip: {},
        legend: {

        },
        xAxis: {
            data: [],
            name:' '
        },
        yAxis: {},
        series: [{
            name: '数量',
            type: 'bar',
            data: [],
            color:['#42a5f5']
        }]
    });



    //chart2

    var myChart2 = echarts.init(document.getElementById('chart2'));
    myChart2.setOption({
        title: {
            text: 'distance',
            textStyle:{
                fontSize:15
            },
            padding:[35,20,0,50]
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            },
            formatter: "距离：{b}</br>数量 : {c}"
        },
        legend: {

        },
        xAxis: {
            data: [],
            name:'km'
        },
        yAxis: {},
        series: [{
            name: '数量',
            type: 'bar',
            data: [],
            color:['#42a5f5']
        }]
    });

    //chart3

    var myChart3 = echarts.init(document.getElementById('chart3'));
    myChart3.setOption({
        title: {
            text: 'duration',
            textStyle:{
                fontSize:15
            },
            padding:[35,20,0,50]
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            },
            formatter: "时间间隔：{b}</br>数量 : {c}"
        },
        legend: {

        },
        xAxis: {
            data: [],
            name:'min'
        },
        yAxis: {},
        series: [{
            name: '数量',
            type: 'bar',
            data: [],
            color:['#42a5f5']
        }]
    });

    //chart4

    var myChart4 = echarts.init(document.getElementById('chart4'));

    myChart4.setOption({
        title: {
            text: 'hour',
            textStyle:{
                fontSize:15
            },
            padding:[35,20,0,50]
        },
        tooltip: {            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            },
            formatter: "时间：{b}</br>数量 : {c}"},
        legend: {

        },
        xAxis: {
            data: [],
            name:'h'
        },
        yAxis: {},
        series: [{
            name: '数量',
            type: 'bar',
            data: [],
            color:['#42a5f5']
        }]
    });
    function make() {
        var maxtime=$("#maxtime").val();
        var mintime=$("#mintime").val();
       /* */
        $.post("/Servlet1",{"maxtime":maxtime,"mintime":mintime},function (result) {
            var obj=eval("("+result+")")
            //document.write(result)
            myChart1.setOption({
                xAxis: {
                    data: obj.chart1date
                },
                series: [{
                    // 根据名字对应到相应的系列
                    name: '数量',
                    data: obj.chart1data
                }]
            });
            myChart2.setOption({
                xAxis: {
                    data: obj.chart2distance
                },
                series: [{
                    // 根据名字对应到相应的系列
                    name: '数量',
                    data: obj.chart2sum
                }]
            })
            myChart3.setOption({
                xAxis: {
                    data: obj.chart3duration
                },
                series: [{
                    // 根据名字对应到相应的系列
                    name: '数量',
                    data: obj.chart3sum
                }]
            })
            myChart4.setOption({
                xAxis: {
                    data: obj.chart4hour
                },
                series: [{
                    // 根据名字对应到相应的系列
                    name: '数量',
                    data: obj.chart4sum
                }]
            })
        })

    }
    var map = new BMap.Map("map");
    var jsonstring;

    map.centerAndZoom(new BMap.Point(120.170828,30.260416), 14);

    var zoom=1;
    var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
    var top_left_navigation = new BMap.NavigationControl();
    map.addControl(top_left_control);
    map.addControl(top_left_navigation);
    var  mapStyle ={
        features: ["road", "building","water","land"],//隐藏地图上的poi
        style : "grayscale"  //设置地图风格为高端黑
    }
    map.setMapStyle(mapStyle);
    addSubWay2()
    map.addEventListener("zoomend", function(){
        map.clearOverlays();
        addSubWay2()
        zoom=Math.pow(1/2,map.getZoom()-14);
        var maxnow=$("#maxcount").val();
        var minnow=$("#mincount").val();
        console.log(maxnow)
        var obj=eval("("+jsonstring+")");
        for(var i=0;i<obj.length;i++){
            makelien(obj[i].leasestationx,obj[i].leasestationy,obj[i].returnstationx,obj[i].returnstationy,obj[i].count,maxnow,minnow,obj[i].leasestationname,obj[i].returnstationname,zoom,obj[i].leasestation,obj[i].returnstation,obj[i].usercount);
        }
    });
    function makelien(sx,sy,ex,ey,count,maxnum,minnum,sname,ename,zoom,leasestation,returnstation,usercount) {
        var i1 = d3.interpolate('green', 'yellow');
        var i2 = d3.interpolate('yellow', 'red');
        var opacity=1;
        opacity=count/maxnum;
        if(count==0){
            opacity=0.1;
        }
        var color;
        if(opacity>0.5){
            color=i2(opacity*2-1);
        }else{
            color=i1(opacity*2);
        }
        if(sx==ex&&sy==ey){
            var outCicle = new BMap.Circle(new BMap.Point(sx,sy), (50+count/maxnum*100)*zoom, {
                fillColor : color,//'#87CEFA'
                fillOpacity : 1,
                strokeColor : "color",//'#87CEFA'
                strokeStyle : 'solid',
                strokeWeight : '1px',
                enableClicking : true
            });
            var innerCicle = new BMap.Circle(new BMap.Point(sx,sy), 50*zoom, {
                fillColor : "blue",//'#87CEFA'
                fillOpacity : 1,
                strokeColor : "blue",//'#87CEFA'
                strokeStyle : 'solid',
                strokeWeight : '1px',
                enableClicking : true
            });
            innerCicle.addEventListener('click', function () {
                var opts = {
                    width : 200,     // 信息窗口宽度
                    height: 100,     // 信息窗口高度
                    title : "" , // 信息窗口标题
                    enableMessage:true,//设置允许信息窗发送短息
                    message:""
                }
                var infoWindow = new BMap.InfoWindow("站点"+leasestation+"："+sname+"</br>流量："+count+"</br>用户数："+usercount, opts);  // 创建信息窗口对象
                map.openInfoWindow(infoWindow,new BMap.Point(sx,sy)); //开启信息窗口

            }, false);
            map.addOverlay(outCicle);
            map.addOverlay(innerCicle);
        }
        else {
            var beijingPosition = new BMap.Point(sx, sy),
                hangzhouPosition = new BMap.Point(ex, ey);
            var marker2 =  new BMap.Circle(beijingPosition, 50*zoom, {
                fillColor : "blue",//'#87CEFA'
                fillOpacity : 1,
                strokeColor : "blue",//'#87CEFA'
                strokeStyle : 'solid',
                strokeWeight : '1px',
                enableClicking : true
            });
            var marker3 =  new BMap.Circle( hangzhouPosition, 50*zoom, {
                fillColor : "blue",//'#87CEFA'
                fillOpacity : 1,
                strokeColor : "blue",//'#87CEFA'
                strokeStyle : 'solid',
                strokeWeight : '1px',
                enableClicking : true
            });
            map.addOverlay(marker2);
            map.addOverlay(marker3);

            var points = [beijingPosition, hangzhouPosition];

            /*if(maxnum!=minnum){
                opacity=(count-minnum)/(maxnum-minnum);
            }
            if(count==minnum&&count!=maxnum){
                opacity=0.1;
            }
            if(opacity<0.1){
                opacity=0.1;
            }*/

            var line_style = {strokeColor: color, strokeWeight: opacity * 10, strokeOpacity: 1};
            var curve = new BMapLib.CurveLine(points, line_style); //创建弧线对象
            curve.addEventListener('click', function () {
                var opts = {
                    width : 200,     // 信息窗口宽度
                    height: 100,     // 信息窗口高度
                    title : "" , // 信息窗口标题
                    enableMessage:true,//设置允许信息窗发送短息
                    message:""
                }
                console.log(count)
                var infoWindow = new BMap.InfoWindow("起点"+leasestation+"："+sname+"</br>终点"+returnstation+"："+ename+"</br>流量："+count, opts);  // 创建信息窗口对象
                map.openInfoWindow(infoWindow,beijingPosition); //开启信息窗口

            }, false);
            map.addOverlay(curve); //添加到地图中
            addArrow(curve, line_style);
        }
        //arrow
        function addArrow(lines, line_style) {
            var length = 10;
            var angleValue = Math.PI / 7;
            var linePoint = lines.getPath();
            var arrowCount = linePoint.length;
            var middle = arrowCount / 2;
            var pixelStart = map.pointToPixel(linePoint[Math.floor(middle)]);
            var pixelEnd = map.pointToPixel(linePoint[Math.ceil(middle)]);
            var angle = angleValue;
            var r = length;
            var delta = 0;
            var param = 0;
            var pixelTemX, pixelTemY;
            var pixelX, pixelY, pixelX1, pixelY1;
            if (pixelEnd.x - pixelStart.x == 0) {
                pixelTemX = pixelEnd.x;
                if (pixelEnd.y > pixelStart.y) {
                    pixelTemY = pixelEnd.y - r;
                } else {
                    pixelTemY = pixelEnd.y + r;
                }
                pixelX = pixelTemX - r * Math.tan(angle);
                pixelX1 = pixelTemX + r * Math.tan(angle);
                pixelY = pixelY1 = pixelTemY;
            } else {
                delta = (pixelEnd.y - pixelStart.y) / (pixelEnd.x - pixelStart.x);
                param = Math.sqrt(delta * delta + 1);
                if ((pixelEnd.x - pixelStart.x) < 0) {
                    pixelTemX = pixelEnd.x + r / param;
                    pixelTemY = pixelEnd.y + delta * r / param;
                } else {
                    pixelTemX = pixelEnd.x - r / param;
                    pixelTemY = pixelEnd.y - delta * r / param;
                }
                pixelX = pixelTemX + Math.tan(angle) * r * delta / param;
                pixelY = pixelTemY - Math.tan(angle) * r / param;
                pixelX1 = pixelTemX - Math.tan(angle) * r * delta / param;
                pixelY1 = pixelTemY + Math.tan(angle) * r / param;
            }
            var pointArrow = map.pixelToPoint(new BMap.Pixel(pixelX, pixelY));
            var pointArrow1 = map.pixelToPoint(new BMap.Pixel(pixelX1, pixelY1));
            var Arrow = new BMap.Polyline([pointArrow, linePoint[Math.ceil(middle)], pointArrow1], line_style);
            map.addOverlay(Arrow);
        }
    }
    function searchrang() {
        var maxtime=$("#maxtime").val();
        var mintime=$("#mintime").val();
        var interval=$("#interval1").val();
        var interva2=$("#interval2").val();
        var stadistance1=$("#stadistance1").val();
        var stadistance2=$("#stadistance2").val();
        var lrhour1=$("#lrhour1").val();
        var lrhour2=$("#lrhour2").val();
        $.post("/RangServlet",{"maxtime":maxtime,"mintime":mintime,"interval1":interval,"interval2":interva2,"stadistance1":stadistance1,"stadistance2":stadistance2,"lrhour1":lrhour1,"lrhour2":lrhour2},function (result) {
            var obj=eval("("+result+")");
           /* $("#mincount").attr("value",obj.mincount);
            $("#maxcount").attr("value",obj.maxcount);*/
            document.getElementById("mincount").value=obj.mincount
            document.getElementById("maxcount").value=obj.maxcount
        })
    }
    function searchline() {
        var maxtime=$("#maxtime").val();
        var mintime=$("#mintime").val();
        var interval=$("#interval1").val();
        var interva2=$("#interval2").val();
        var stadistance1=$("#stadistance1").val();
        var stadistance2=$("#stadistance2").val();
        var lrhour1=$("#lrhour1").val();
        var lrhour2=$("#lrhour2").val();
        var maxcount=$("#maxcount").val();
        var mincount=$("#mincount").val();
        map.clearOverlays();
        document.getElementById('max').innerHTML=maxcount;
        //alert(stadistance2);
       //makelien(120.09918,30.30402,120.10001,30.309789,10,10,"你好","你不好");
        $.post("/SearchLineServlet",{"maxtime":maxtime,"mintime":mintime,"interval1":interval,"interval2":interva2,"stadistance1":stadistance1,"stadistance2":stadistance2,"lrhour1":lrhour1,"lrhour2":lrhour2,"maxcount":maxcount,"mincount":mincount},function (result) {
            var obj=eval("("+result+")");
            jsonstring=result;
           //document.write(result);

            for(var i=0;i<obj.length;i++){
                makelien(obj[i].leasestationx,obj[i].leasestationy,obj[i].returnstationx,obj[i].returnstationy,obj[i].count,maxcount,mincount,obj[i].leasestationname,obj[i].returnstationname,zoom,obj[i].leasestation,obj[i].returnstation,obj[i].usercount);
            }
        })
    }
    function reset() {
        document.getElementById("mincount").value=null
        document.getElementById("maxcount").value=null
        document.getElementById("interval1").value=null
        document.getElementById("interval2").value=null
        document.getElementById("stadistance1").value=null
        document.getElementById("stadistance2").value=null
        document.getElementById("lrhour1").value=null
        document.getElementById("lrhour1").value=null
        console.log(hello)
    }
    function addSubWay2() {
        let points = [
            [[120.354264,30.316329],
                [120.341868,30.315456]],
            [[120.341221,30.315425],
                [120.332328,30.315347]],
            [[120.331735,30.315362],
                [120.319284,30.31569]],
            [[120.318745,30.315721],
                [120.285185,30.31689]],
            [[120.284897,30.31689],
                [120.282094,30.31664],
                [120.274549,30.313835],
                [120.273183,30.313772]],
            [[120.273183,30.313772],
                [120.268117,30.313866],
                [120.261541,30.31293],
                [120.259026,30.312026]],
            [[120.258595,30.311777],
                [120.247815,30.30657]],
            [[120.247384,30.306344],
                [120.234161,30.301332],
                [120.23028,30.300396]],
            [[120.229633,30.300241],
                [120.221225,30.298183],
                [120.214398,30.294441],
                [120.199342,30.290324]],
            [[120.198678,30.290106],
                [120.197708,30.289794],
                [120.194761,30.28967],
                [120.187323,30.29101],
                [120.18373,30.290886]],
            [[120.183155,30.290886],
                [120.178879,30.290168],
                [120.175897,30.289171],
                [120.173238,30.287705],
                [120.172268,30.287011],
                [120.172268,30.286075]],
            [[120.172268,30.285576],
                [120.172375,30.281335],
                [120.170112,30.276563],
                [120.17004,30.275752],
                [120.170255,30.26861]],
            [[120.170291,30.268111],
                [120.170507,30.26078]],
            [[120.170579,30.26025],
                [120.170902,30.254978],
                [120.172232,30.25267],
                [120.173489,30.251765],
                [120.174064,30.251703]],
            [[120.174567,30.251671],
                [120.183766,30.251297],
                [120.186497,30.250767],
                [120.187323,30.250268]],
            [[120.18779,30.249987],
                [120.197205,30.242905]],
            [[120.1976,30.242499],
                [120.203672,30.237164]],
            [[120.204139,30.236727],
                [120.213087,30.227444],
                [120.222824,30.216163],
                [120.222896,30.215726]],
            [[120.223004,30.215188],
                [120.223974,30.206074]],
            [[120.224046,30.205513],
                [120.225447,30.195243],
                [120.226489,30.193745],
                [120.226956,30.193464]],
            [[120.227388,30.193183],
                [120.228034,30.192746],
                [120.235652,30.191029],
                [120.237017,30.19003]],
            [[120.237449,30.189718],
                [120.241006,30.186222],
                [120.24,30.182101],
                [120.240718,30.174226]]
        ];
        points.forEach(item => {
            let pointsArr = item.map(point => new BMap.Point(point[0], point[1]));
            let polyline = new BMap.Polyline(pointsArr, {
                strokeColor: '#DC0000', strokeWeight: 2, strokeOpacity: 1
            });
            map.addOverlay(polyline);
        });
    }
</script>