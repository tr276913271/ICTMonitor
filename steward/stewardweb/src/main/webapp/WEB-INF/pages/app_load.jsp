<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>APM 应用负载监控</title>
<link rel="stylesheet" href="css/style.default.css" type="text/css" />
   <script type="text/javascript" src="js/highcharts/jquery-1.8.3.min.js"></script>
   <script type="text/javascript" src="js/highcharts/highcharts.js"></script>
<script type="text/javascript">
var data_performance = {"resultTo":1462699595000,"scatter":[[1462699593649,127499,"test1001^1462699069318^5",0],[1462699380083,256162,"test1001^1462699069318^4",1],[1462699115218,3010,"test1001^1462699069318^3",1],[1462699108229,10053,"test1001^1462699069318^2",1],[1462699087343,9,"test1001^1462699069318^1",1],[1462699086690,748,"test1001^1462699069318^0",1]],"resultFrom":1462699086690,"scatterIndex":{"x":0,"y":1,"transactionId":2,"type":3}}

function getAppLoadData(data){
    var scatters = data['scatter'];
    var tag = 1000;
    var tag_end = parseInt(scatters.length-1);
    var time_end = parseInt(scatters[0][0]);
    var time_start = parseInt(scatters[tag_end][0]);
    var n = parseInt(Math.abs(time_end-time_start)/tag);
    var data_list = [];
    for(i=0;i<=n;i++){
        data_list.push(0);
    }
    $.each(scatters, function(index,item){
        tmp = parseInt(Math.abs(item[0]-time_start)/tag);
        data_list[tmp]++;
    });

    return data_list;
}

function getPointStart(data){
    var scatters = data['scatter'];
    var tag_end = parseInt(scatters.length-1);
    var time_start = parseInt(scatters[tag_end][0]);
    return time_start;
}

$(document).ready(function() {
    var json_url = "/stewardweb/getScatterData.do?application=appName&from=1459158066000&to=1459339969000&limit=5000&v=2";
    $.getJSON(json_url,function(data,status){
        data_performance = data;
    });

    Highcharts.setOptions({
        global: {
            useUTC: false
        }
    }); 

    $('#chart_app_load').highcharts({
        chart: {
            zoomType: 'x',
            spacingRight: 20
        },
        title: {
            text: null
        },
        // xAxis: {
        //     type: 'datetime',
        //     maxZoom: 7 * 24 * 3600000, // fourteen days
        //     title: {
        //         text: null
        //     }
        // },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: {
                 millisecond: '%H:%M:%S<br>%Y-%m'
            },
            // maxZoom: 24 * 3600 *1000, // one day
            // title: {
            //     text: 'Time Line'
            // }
        },
        yAxis: {
            title: {
                text: 'TPS'
            }
        },
        tooltip: {
            shared: true
        },
        legend: {
            enabled: false
        },
        plotOptions: {
            area: {
                fillColor: {
                    linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
                    stops: [
                        [0, Highcharts.getOptions().colors[0]],
                        [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                    ]
                },
                lineWidth: 1,
                marker: {
                    enabled: false
                },
                shadow: false,
                states: {
                    hover: {
                        lineWidth: 1
                    }
                },
                threshold: null
            }
        },

        series: [{                                                                           
            type: 'area',
            name: 'Transactions',
            //data: [[1459166930522, 52],[1459166930528, 48],[1459166930928, 48],[1459166931028, 68]]   
            //data: getPerformanceData(data_performance)[0]
            pointStart: getPointStart(data_performance),
            pointInterval: 1000,
            data: getAppLoadData(data_performance)
                                                                                             
        }]   
        // series: [{
        //     type: 'area',
        //     name: 'Transactions:',
        //     pointInterval: 1 * 3600 * 1000,
        //     pointStart: Date.UTC(2016, 01, 01),
        //     //pointStart: Date.UTC(2006, 0, 01),
        //     //data: [[1459166930522, 52],[1459166930528, 48],[1459166930928, 48],[1459166931028, 68]]
        //     data: [
        //         0.8446, 0.8445, 0.8444, 0.8451,    0.8418, 0.8264,    0.8258, 0.8232,    0.8233, 0.8258,
        //         0.8283, 0.8278, 0.8256, 0.8292,    0.8239, 0.8239,    0.8245, 0.8265,    0.8261, 0.8269
        //     ]
        // }]
    });








});

</script>
<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="js/plugins/excanvas.min.js"></script><![endif]-->
<!--[if IE 9]>
    <link rel="stylesheet" media="screen" href="css/style.ie9.css"/>
<![endif]-->
<!--[if IE 8]>
    <link rel="stylesheet" media="screen" href="css/style.ie8.css"/>
<![endif]-->
<!--[if lt IE 9]>
	<script src="js/plugins/css3-mediaqueries.js"></script>
<![endif]-->
</head>

<body>
<div class="bodywrapper">
    <div class="topheader">
        <div class="left">
            <h1 class="logo">APM <span>Admin</span></h1>
            <span class="slogan">后台管理系统</span>
            
            <div class="search">
                <form action="" method="post">
                    <input type="datetime-local" name="time_start" />
                    <input type="datetime-local" name="time_end" />
                    <!-- <input type="text" name="keyword" id="keyword" value="请输入" /> -->
                    <button class="submitbutton"></button>
                </form>
            </div><!--search-->
            
            <br clear="all" />
            
        </div><!--left-->
        
        <div class="right">
        	<!--<div class="notification">
                <a class="count" href="notifications.html"><span>9</span></a>
        	</div>
			-->
        	<div class="userinfo">
                <img src="images/thumbs/avatar.png" alt="" />
                <span>管理员</span>
            </div><!--userinfo-->
            
            <div class="userinfodrop">
                <div class="userdata">
                    <h4>管理员</h4>
                    <span class="email">youremail@yourdomain.com</span>
                    <ul>
                        <li><a href="index.html">退出</a></li>
                    </ul>
                </div><!--userdata-->
            </div><!--userinfodrop-->
        </div><!--right-->
    </div><!--topheader-->
    
    
    <div class="header">
    	<ul class="headermenu">
            <li><a href="topo.html"><span class="icon icon-flatscreen"></span>业务流拓扑</a></li>
            <li><a href="performance.html"><span class="icon icon-pencil"></span>业务流性能表现</a></li>
            <li class="current"><a href="app_load.html"><span class="icon icon-chart"></span>应用级负载均衡</a></li>
            <li><a href="host_load.html"><span class="icon icon-chart"></span>主机负载监控</a></li>
            <li><a href="slow_call.html"><span class="icon icon-speech"></span>慢调用</a></li>
            <li><a href="wrong_call.html"><span class="icon icon-message"></span>出错调用</a></li>
        </ul>
    </div><!--header-->
    
    <div class="pageheader">
    	<h1 class="pagetitle contenttitle2">应用级负载均衡</h1>
        <!--
        <span class="pagedesc">An example of graphs &amp; charts. A page without left menu.</span>
        
        <ul class="hornav">
        	<li class="current"><a href="#charts">Charts</a></li>
            <li><a href="#statistics">Statistics</a></li>
        </ul>
        --> 
    </div><!--pageheader-->
    
    <div class="contentwrapper">
    
    	<div id="charts" class="subcontent">
    	
            <div class="one_tatal last">
                <div class="contenttitle2">
                    <h3>Transactions Per Second</h3>
                </div><!--contenttitle-->
                <br />
                <div id="chart_app_load" style="height:300px;"></div>
            </div><!--one_half-->
        <br clear="all" />
        
        </div><!--#charts-->
        
        <div id="statistics" class="subcontent">
        </div><!--#statistics-->
        
    </div><!--contentwrapper-->
    
    
</div><!--bodywrapper-->

</body>
</html>
