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
<title>APM 主机负载监控</title>
<link rel="stylesheet" href="css/style.default.css" type="text/css" />
   <script type="text/javascript" src="js/highcharts/jquery-1.8.3.min.js"></script>
   <script type="text/javascript" src="js/highcharts/highcharts.js"></script>
   <script type="text/javascript" src="js/sockjs-1.0.3.min.js"></script>


<script type="text/javascript">

    var socket;
    function setConnected(connected) {
        document.getElementById('connect').disabled = connected;
        document.getElementById('disconnect').disabled = !connected;
        document.getElementById('response').innerHTML = '';
    }

    function connect() {
        if ('WebSocket' in window) {
            console.log('Websocket supported');
            socket = new WebSocket('ws://localhost:8080/stewardweb/websocket.do?agentid=fa3fa039-fb1a-4cde-8c58-368f7da17edf');
            console.log('Connection attempted');
            socket.onopen = function() {
                console.log('Connection open!');
                setConnected(true);
            }
            socket.onclose = function() {
                console.log('Disconnecting connection');
            }
            socket.onmessage = function(evt) {
                var received_msg = evt.data;
                //alert(received_msg);
                console.log(received_msg);
                console.log('message received!');
                //showMessage(received_msg);
                MessageToChart(received_msg);
            }
        } else {
            console.log('Websocket not supported');
        }
    }

    function disconnect() {
        setConnected(false);
        console.log("Disconnected");
        socket.close();
    }

    function sendName() {
        var message = document.getElementById('message').value;
        socket.send(JSON.stringify({
            'message' : message
        }));
    }

    function showMessage(message) {
        var response = document.getElementById('response');
        var p = document.createElement('p');
        p.style.wordWrap = 'break-word';
        p.appendChild(document.createTextNode(message));
        response.appendChild(p);
    }

    function MessageToChart(message){
        //alert(typeof(message));
        // var messages = $.parseJSON(message);
        // //alert(messages);
        // //alert(messages.length);
        // $('#statistics').html(message);
        // $.each(messages, function(index, item){
        //     alert(item);
        // });
        
    }
</script>

<script type="text/javascript">
$(document).ready(function() {
	connect();

    Highcharts.setOptions({
        global: {                                                               
            useUTC: false                                                       
        }                                                                       
    });                                                                         
    /*---------- Start Of CPU Chart --------------*/
    var chart;                                                                  
    $('#chart_cpu').highcharts({                                                
        chart: {                                                                
            type: 'area',                                                     
            animation: Highcharts.svg, // don't animate in old IE
            marginRight: 10,                                                    
            events: {
                load: function() {                                              
                    // set up the updating of the chart each second             
                    var series = this.series[0];                                
                    setInterval(function() {                                    
                        var x = (new Date()).getTime(), // current time         
                            y = Math.random();                                  
                        series.addPoint([x, y], true, true);                    
                    }, 1000);                                                   
                }                                                               
            }                                                                   
        },                                                                      
        title: {                                                                
            text: null
        },                                                                      
        xAxis: {                                                                
            type: 'datetime',                                                   
            tickPixelInterval: 150                                              
        },                                                                      
        yAxis: {                                                                
            title: {                                                            
                text: 'Value'                                                   
            },                                                                  
            plotLines: [{                                                       
                value: 0,                                                       
                width: 1,                                                       
                color: '#808080'                                                
            }]                                                                  
        },                                                                      
        tooltip: {                                                              
            formatter: function() {                                             
                    return '<b>'+ this.series.name +'</b><br/>'+                
                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                    Highcharts.numberFormat(this.y, 2);                         
            }                                                                   
        },                                                                      
        legend: {                                                               
            enabled: false                                                      
        },                                                                      
        exporting: {                                                            
            enabled: false                                                      
        },                                                                      
        series: [{                                                              
            name: 'Random data',                                                
            data: (function() {                                                 
                // generate an array of random data                             
                var data = [],                                                  
                    time = (new Date()).getTime(),                              
                    i;                                                          
                                                                                
                for (i = -19; i <= 0; i++) {                                    
                    data.push({                                                 
                        x: time + i * 1000,                                     
                        y: Math.random()                                        
                    });                                                         
                }                                                               
                return data;                                                    
            })()                                                                
        }]                                                                      
    });                          
    /*---------- End Of CPU Chart --------------*/  

    /*---------- Start Of Memory Chart --------------*/                                                    
    $('#chart_memory').highcharts({                                                
        chart: {                                                                
            type: 'spline',                                                     
            animation: Highcharts.svg, // don't animate in old IE               
            marginRight: 10,                                                    
            events: {                                                           
                load: function() {                                              
                                                                                
                    // set up the updating of the chart each second             
                    var series = this.series[0];                                
                    setInterval(function() {                                    
                        var x = (new Date()).getTime(), // current time         
                            y = Math.random();                                  
                        series.addPoint([x, y], true, true);                    
                    }, 1000);                                                   
                }                                                               
            }                                                                   
        },                                                                      
        title: {                                                                
            text: null
        },                                                                      
        xAxis: {                                                                
            type: 'datetime',                                                   
            tickPixelInterval: 150                                              
        },                                                                      
        yAxis: {                                                                
            title: {                                                            
                text: 'Value'                                                   
            },                                                                  
            plotLines: [{                                                       
                value: 0,                                                       
                width: 1,                                                       
                color: '#808080'                                                
            }]                                                                  
        },                                                                      
        tooltip: {                                                              
            formatter: function() {                                             
                    return '<b>'+ this.series.name +'</b><br/>'+                
                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                    Highcharts.numberFormat(this.y, 2);                         
            }                                                                   
        },                                                                      
        legend: {                                                               
            enabled: false                                                      
        },                                                                      
        exporting: {                                                            
            enabled: false                                                      
        },                                                                      
        series: [{                                                              
            name: 'Random data',                                                
            data: (function() {                                                 
                // generate an array of random data                             
                var data = [],                                                  
                    time = (new Date()).getTime(),                              
                    i;                                                          
                                                                                
                for (i = -19; i <= 0; i++) {                                    
                    data.push({                                                 
                        x: time + i * 1000,                                     
                        y: Math.random()                                        
                    });                                                         
                }                                                               
                return data;                                                    
            })()                                                                
        }]                                                                      
    });                          
    /*---------- End Of Memory Chart --------------*/

    /*---------- Start Of Swap Chart --------------*/                                                    
    $('#chart_swap').highcharts({                                                
        chart: {                                                                
            type: 'spline',                                                     
            animation: Highcharts.svg, // don't animate in old IE               
            marginRight: 10,                                                    
            events: {                                                           
                load: function() {                                              
                                                                                
                    // set up the updating of the chart each second             
                    var series = this.series[0];                                
                    setInterval(function() {                                    
                        var x = (new Date()).getTime(), // current time         
                            y = Math.random();                                  
                        series.addPoint([x, y], true, true);                    
                    }, 1000);                                                   
                }                                                               
            }                                                                   
        },                                                                      
        title: {                                                                
            text: null
        },                                                                      
        xAxis: {                                                                
            type: 'datetime',                                                   
            tickPixelInterval: 150                                              
        },                                                                      
        yAxis: {                                                                
            title: {                                                            
                text: 'Value'                                                   
            },                                                                  
            plotLines: [{                                                       
                value: 0,                                                       
                width: 1,                                                       
                color: '#808080'                                                
            }]                                                                  
        },                                                                      
        tooltip: {                                                              
            formatter: function() {                                             
                    return '<b>'+ this.series.name +'</b><br/>'+                
                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                    Highcharts.numberFormat(this.y, 2);                         
            }                                                                   
        },                                                                      
        legend: {                                                               
            enabled: false                                                      
        },                                                                      
        exporting: {                                                            
            enabled: false                                                      
        },                                                                      
        series: [{                                                              
            name: 'Random data',                                                
            data: (function() {                                                 
                // generate an array of random data                             
                var data = [],                                                  
                    time = (new Date()).getTime(),                              
                    i;                                                          
                                                                                
                for (i = -19; i <= 0; i++) {                                    
                    data.push({                                                 
                        x: time + i * 1000,                                     
                        y: Math.random()                                        
                    });                                                         
                }                                                               
                return data;                                                    
            })()                                                                
        }]                                                                      
    });                          
    /*---------- End Of Swap Chart --------------*/
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
            <li><a href="app_load.html"><span class="icon icon-chart"></span>应用级负载均衡</a></li>
            <li class="current"><a href="host_load.html"><span class="icon icon-chart"></span>主机负载监控</a></li>
            <li><a href="slow_call.html"><span class="icon icon-speech"></span>慢调用</a></li>
            <li><a href="wrong_call.html"><span class="icon icon-message"></span>出错调用</a></li>
        </ul>
    </div><!--header-->
    
    <div class="pageheader">
    	<h1 class="pagetitle contenttitle2">主机负载监控</h1>
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
    	
            <div class="one_fourth">
                <div class="contenttitle2">
                    <h3>CPU使用率</h3>
                </div><!--contenttitle-->
                <br />
                <div id="chart_cpu" style="height:300px;"></div>
            </div><!--one_fourth-->
            
            <div class="one_fourth">
                <div class="contenttitle2">
                    <h3>内存使用情况</h3>
                </div><!--contenttitle-->
                <br />
                <div id="chart_memory" style="height:300px;"></div>
            </div><!--one_fourth-->

            <div class="one_fourth">
                <div class="contenttitle2">
                    <h3>交换区使用情况</h3>
                </div><!--contenttitle-->
                <br />
                <div id="chart_swap" style="height:300px;"></div>
            </div><!--one_fourth-->

            <div class="one_fourth last">            
                <div class="contenttitle2">
                    <h3>磁盘使用情况</h3>
                </div><!--contenttitle-->
                <br />
                <div id="bargraph" style="height:300px;"></div>
            </div><!--one_fourth last-->
            
            <br clear="all" /><br />
            
            <div class="one_half">
                <div class="contenttitle2">
                    <h3>实时监控1</h3>
                </div><!--contenttitle-->
                <br />
                <div id="realtime" style="height:300px;"></div>
                <br />
                <small>You can update a chart periodically to get a real-time effect by using a timer to insert the new data in the plot and redraw it.</small>
            </div><!--one_half-->
            
            <div class="one_half last">
                <div class="contenttitle2">
                    <h3>监控3</h3>
                </div><!--contenttitle-->
                <br />
                <div id="piechart" style="height: 300px;"></div>
            </div><!--one_half last-->
        
        <br clear="all" />
        
        </div><!--#charts-->
        
        <div id="statistics" class="subcontent">
        	&nbsp;
        </div><!--#statistics-->
        
    </div><!--contentwrapper-->
    











</div><!--bodywrapper-->

</body>
</html>
