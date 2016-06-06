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
<title>APM 出错调用</title>
<link rel="stylesheet" href="css/style.default.css" type="text/css" />
<script type="text/javascript" src="js/plugins/jquery-1.7.min.js"></script>
<script type="text/javascript" src="js/plugins/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript" src="js/plugins/jquery.cookie.js"></script>
<script type="text/javascript" src="js/plugins/jquery.flot.min.js"></script>
<script type="text/javascript" src="js/plugins/jquery.flot.pie.js"></script>
<script type="text/javascript" src="js/plugins/jquery.flot.resize.min.js"></script>
<script type="text/javascript" src="js/custom/general.js"></script>
<script type="text/javascript" src="js/custom/charts.js"></script>
<script type="text/javascript" src="js/highcharts/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/highcharts/highcharts.js"></script>
<script type="text/javascript">
var data_slow_call = [{"version":0,"agentId":"test1001","applicationId":"appName","agentStartTime":1462699069318,"traceAgentId":"test1001","traceAgentStartTime":1462699069318,"traceTransactionSequence":5,"spanId":-8244457100962795228,"parentSpanId":-1,"startTime":1462699466130,"elapsed":127499,"rpc":"/httpclient4/getTwitterUrlCount.pinpoint","serviceType":"TOMCAT","endPoint":"180.153.44.108:8090","apiId":-1,"annotationBoList":null,"flag":0,"errCode":1,"spanEventBoList":null,"collectorAcceptTime":1462699593649,"exceptionId":0,"exceptionMessage":null,"exceptionClass":null,"remoteAddr":"159.226.43.45","root":true,"transactionId":"test1001^1462699069318^5"},{"version":0,"agentId":"test1001","applicationId":"appName","agentStartTime":1462699069318,"traceAgentId":"test1001","traceAgentStartTime":1462699069318,"traceTransactionSequence":4,"spanId":-167382249182572870,"parentSpanId":-1,"startTime":1462699123898,"elapsed":256162,"rpc":"/httpclient4/getGeoCode.pinpoint","serviceType":"TOMCAT","endPoint":"180.153.44.108:8090","apiId":-1,"annotationBoList":null,"flag":0,"errCode":0,"spanEventBoList":null,"collectorAcceptTime":1462699380083,"exceptionId":0,"exceptionMessage":null,"exceptionClass":null,"remoteAddr":"159.226.43.45","root":true,"transactionId":"test1001^1462699069318^4"},{"version":0,"agentId":"test1001","applicationId":"appName","agentStartTime":1462699069318,"traceAgentId":"test1001","traceAgentStartTime":1462699069318,"traceTransactionSequence":3,"spanId":1022438039493983549,"parentSpanId":-1,"startTime":1462699112204,"elapsed":3010,"rpc":"/sleep3.pinpoint","serviceType":"TOMCAT","endPoint":"180.153.44.108:8090","apiId":-1,"annotationBoList":null,"flag":0,"errCode":0,"spanEventBoList":null,"collectorAcceptTime":1462699115218,"exceptionId":0,"exceptionMessage":null,"exceptionClass":null,"remoteAddr":"159.226.43.45","root":true,"transactionId":"test1001^1462699069318^3"},{"version":0,"agentId":"test1001","applicationId":"appName","agentStartTime":1462699069318,"traceAgentId":"test1001","traceAgentStartTime":1462699069318,"traceTransactionSequence":2,"spanId":-5728347098437728309,"parentSpanId":-1,"startTime":1462699098174,"elapsed":10053,"rpc":"/consumeCpu.pinpoint","serviceType":"TOMCAT","endPoint":"180.153.44.108:8090","apiId":-1,"annotationBoList":null,"flag":0,"errCode":0,"spanEventBoList":null,"collectorAcceptTime":1462699108229,"exceptionId":0,"exceptionMessage":null,"exceptionClass":null,"remoteAddr":"159.226.43.45","root":true,"transactionId":"test1001^1462699069318^2"},{"version":0,"agentId":"test1001","applicationId":"appName","agentStartTime":1462699069318,"traceAgentId":"test1001","traceAgentStartTime":1462699069318,"traceTransactionSequence":0,"spanId":1394612279845866822,"parentSpanId":-1,"startTime":1462699085667,"elapsed":748,"rpc":"/","serviceType":"TOMCAT","endPoint":"180.153.44.108:8090","apiId":-1,"annotationBoList":null,"flag":0,"errCode":0,"spanEventBoList":null,"collectorAcceptTime":1462699086690,"exceptionId":0,"exceptionMessage":null,"exceptionClass":null,"remoteAddr":"159.226.43.45","root":true,"transactionId":"test1001^1462699069318^0"}];

var data_slow_call_detail = {
    "applicationName": "/sleep3.pinpoint",
    "transactionId": "agent1001^1463212891434^0",
    "agentId": "agent1001",
    "applicationId": "agent",
    "callStackStart": 1463212905599,
    "callStackEnd": 3592,
    "completeState": "Complete",
    "callStackIndex": {
        "depth": 0,
        "begin": 1,
        "end": 2,
        "excludeFromTimeline": 3,
        "applicationName": 4,
        "tab": 5,
        "id": 6,
        "parentId": 7,
        "isMethod": 8,
        "hasChild": 9,
        "title": 10,
        "arguments": 11,
        "executeTime": 12,
        "gap": 13,
        "elapsedTime": 14,
        "barWidth": 15,
        "simpleClassName": 16,
        "apiType": 17,
        "agent": 18,
        "isFocused": 19,
        "hasException": 20
    },
    "callStack": [
        ["", 1463212905599, 1463212909191, false, "agent", 0, "1", "", true, true, "invoke(Request request, Response response)", "\/sleep3.pinpoint", "16:01:45 599", "0", "3,592", "1", "StandardHostValve", "TOMCAT", "agent1001", true, false],
        ["", 0, 0, true, "", 1, "2", "1", false, false, "REMOTE_ADDRESS", "192.168.25.1", "", "", "", "", "", "", "", false, false],
        ["", 1463212905861, 1463212909190, false, "agent", 1, "3", "1", true, false, "doGet(HttpServletRequest request, HttpServletResponse response)", "", "16:01:45 861", "262", "3,329", "1", "FrameworkServlet", "SPRING", "agent1001", false, false],
        ["", 1463212905904, 1463212908906, false, "agent", 2, "4", "3", true, false, "sleep3()", "", "16:01:45 904", "43", "3,002", "1", "SimpleController", "SPRING_BEAN", "agent1001", false, false]
    ],
    "applicationMapData": {
        "nodeDataArray": [{
            "key": "agent^USER",
            "applicationName": "USER",
            "category": "USER",
            "serviceType": "USER",
            "serviceTypeCode": "2",
            "isWas": false,
            "histogram": {
                "1s": 0,
                "3s": 0,
                "5s": 1,
                "Slow": 0,
                "Error": 0
            },
            "totalCount": 1,
            "errorCount": 0,
            "slowCount": 1,
            "hasAlert": false,
            "agentHistogram": {},
            "timeSeriesHistogram": [{
                "key": "1s",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }, {
                "key": "3s",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }, {
                "key": "5s",
                "values": [
                    [0, 0],
                    [1463212860000, 1]
                ]
            }, {
                "key": "Slow",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }, {
                "key": "Error",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }],
            "agentTimeSeriesHistogram": {},
            "serverList": {},
            "instanceCount": 0
        }, {
            "key": "agent^TOMCAT",
            "applicationName": "agent",
            "category": "TOMCAT",
            "serviceType": "TOMCAT",
            "serviceTypeCode": "1010",
            "isWas": true,
            "histogram": {
                "1s": 0,
                "3s": 0,
                "5s": 1,
                "Slow": 0,
                "Error": 0
            },
            "totalCount": 1,
            "errorCount": 0,
            "slowCount": 1,
            "hasAlert": false,
            "agentHistogram": {
                "agent1001": {
                    "1s": 0,
                    "3s": 0,
                    "5s": 1,
                    "Slow": 0,
                    "Error": 0
                }
            },
            "timeSeriesHistogram": [{
                "key": "1s",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }, {
                "key": "3s",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }, {
                "key": "5s",
                "values": [
                    [0, 0],
                    [1463212860000, 1]
                ]
            }, {
                "key": "Slow",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }, {
                "key": "Error",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }],
            "agentTimeSeriesHistogram": {
                "agent1001": [{
                    "key": "1s",
                    "values": [
                        [0, 0],
                        [1463212860000, 0]
                    ]
                }, {
                    "key": "3s",
                    "values": [
                        [0, 0],
                        [1463212860000, 0]
                    ]
                }, {
                    "key": "5s",
                    "values": [
                        [0, 0],
                        [1463212860000, 1]
                    ]
                }, {
                    "key": "Slow",
                    "values": [
                        [0, 0],
                        [1463212860000, 0]
                    ]
                }, {
                    "key": "Error",
                    "values": [
                        [0, 0],
                        [1463212860000, 0]
                    ]
                }]
            },
            "serverList": {},
            "instanceCount": 0
        }],
        "linkDataArray": [{
            "key": "agent^USER~agent^TOMCAT",
            "from": "agent^USER",
            "to": "agent^TOMCAT",
            "toAgent": [],
            "sourceInfo": {
                "applicationName": "agent",
                "serviceType": "USER",
                "serviceTypeCode": 2,
                "isWas": false
            },
            "targetInfo": {
                "applicationName": "agent",
                "serviceType": "TOMCAT",
                "serviceTypeCode": 1010,
                "isWas": true
            },
            "filterApplicationName": "agent",
            "filterApplicationServiceTypeCode": 1010,
            "filterApplicationServiceTypeName": "TOMCAT",
            "totalCount": 1,
            "errorCount": 0,
            "slowCount": 1,
            "histogram": {
                "1s": 0,
                "3s": 0,
                "5s": 1,
                "Slow": 0,
                "Error": 0
            },
            "sourceHistogram": {
                "agent1001": {
                    "1s": 0,
                    "3s": 0,
                    "5s": 1,
                    "Slow": 0,
                    "Error": 0
                }
            },
            "targetHistogram": {
                "agent1001": {
                    "1s": 0,
                    "3s": 0,
                    "5s": 1,
                    "Slow": 0,
                    "Error": 0
                }
            },
            "timeSeriesHistogram": [{
                "key": "1s",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }, {
                "key": "3s",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }, {
                "key": "5s",
                "values": [
                    [0, 0],
                    [1463212860000, 1]
                ]
            }, {
                "key": "Slow",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }, {
                "key": "Error",
                "values": [
                    [0, 0],
                    [1463212860000, 0]
                ]
            }],
            "sourceTimeSeriesHistogram": {
                "agent1001": [{
                    "key": "1s",
                    "values": [
                        [0, 0],
                        [1463212860000, 0]
                    ]
                }, {
                    "key": "3s",
                    "values": [
                        [0, 0],
                        [1463212860000, 0]
                    ]
                }, {
                    "key": "5s",
                    "values": [
                        [0, 0],
                        [1463212860000, 1]
                    ]
                }, {
                    "key": "Slow",
                    "values": [
                        [0, 0],
                        [1463212860000, 0]
                    ]
                }, {
                    "key": "Error",
                    "values": [
                        [0, 0],
                        [1463212860000, 0]
                    ]
                }]
            },
            "hasAlert": false
        }]
    }
};

function getSlowCallDetailData(traceID, timeStamp, data){
    var callstack = data["callStack"];
    //var callstack_length = callstack.length;
    var code_item_detail = "<tr class='item_detail'><td colspan='8'><div class='poplayer'><table cellpadding='0' cellspacing='0' border='0' class='stdtable'><colgroup><col class='con0' /><col class='con1' /><col class='con0' /><col class='con1' /><col class='con0' /><col class='con1' /><col class='con0' /><col class='con1' /><col class='con0' /><col class='con1' /></colgroup><thead><tr><th class='head0'>Method</th><th class='head1'>Arguments</th><th class='head0'>Exec Time</th><th class='head1'>Gap(ms)</th><th class='head0'>Time(ms)</th><th class='head1'>Time(%)</th><th class='head0'>Class</th><th class='head1'>Api Type</th><th class='head0'>Agent</th><th class='head1'>App Name</th></tr></thead><tbody>";
    $.each(callstack, function(index, item){
        var row = {"time_begin":item[1], "time_end":item[2], "appName":item[4], "tag":item[5], "id":item[6], "parentId":item[7], "title":item[10], "args":item[11], "formatTime":item[12], "gap":item[13], "execTime":item[14], "simpleClassName":item[16], "serviceType":item[17], "agent":item[18], "hasChild":item[19], "hasException":item[20]};
        //code_row = "<tr class='item_detail'><td colspan='8'><div class='poplayer'>"+row['time_begin']+"</div></td></tr>";
        var code_row = "<tr><td>"+row['title']+"</td><td>"+row['args']+"</td><td>"+row['formatTime']+"</td><td>"+row['gap']+"</td><td>"+row['execTime']+"</td><td>100%</td><td>"+row['simpleClassName']+"</td><td>"+row['serviceType']+"</td><td>"+row['agent']+"</td><td>"+row['appName']+"</td></tr>"
        code_item_detail += code_row;
    });
    code_item_detail += "</tbody></table></div></td></tr>";
    return code_item_detail;
    //alert(callstack);
};

function getSlowCallData(data){
    var list_items = [];
    var code_items = "";
    $.each(data, function(index, item){
        // var item = {'Time':item.agentStartTime, 'Application':item.rpc}
        // list_items.push(item);
        code_item = "<tr class='item'><td>"+(index+1)+"</td><td>"+Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', item.agentStartTime)+"</td><td>"+item.rpc+"</td><td>"+100+"</td><td> </td><td>"+item.agentId+"</td><td>"+item.remoteAddr+"</td><td>"+item.transactionId+"</td></tr>";
        //code_item_detail = "<tr class='item_detail'><td colspan='8'><div class='poplayer'>阿斯蒂芬</div></td></tr>";
        code_item_detail = getSlowCallDetailData(1,2,data_slow_call_detail);
        code_item += code_item_detail;
        $('#table_slow_call').append(code_item);
        //alert(index);
    });
};



$(document).ready(function(){
    getSlowCallData(data_slow_call);
    $('#table_slow_call>.item').mouseover(function(){
        $(this).css({
            'background':'#ccc',
            'cursor':'pointer'
        });
    }).click(function(){
        $('.item_detail').css({
            'display':'none'
        });
        $(this).next().fadeIn();
    });
    $('#table_slow_call>.item').mouseout(function(){
        $(this).css({
            'background':'transparent'
        });
    });

    //getSlowCallDetailData(data_slow_call_detail);
    //var code_slow_call = getSlowCallData(data_slow_call);


    // $.each(slow_calls, function(index, item){
    //     $('.item > td').innerHTML(item['Time']);
    // });
    // $('tr').onclick(function(){
    //     alert('Hello');
    // });
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
            <li><a href="host_load.html"><span class="icon icon-chart"></span>主机负载监控</a></li>
            <li><a href="slow_call.html"><span class="icon icon-speech"></span>慢调用</a></li>
            <li class="current"><a href="wrong_call.html"><span class="icon icon-message"></span>出错调用</a></li>
        </ul>
    </div><!--header-->
    
    <div class="pageheader">
    	<h1 class="pagetitle contenttitle2">出错调用</h1>
        <!--
        <span class="pagedesc">An example of graphs &amp; charts. A page without left menu.</span>
        
        <ul class="hornav">
        	<li class="current"><a href="#charts">Charts</a></li>
            <li><a href="#statistics">Statistics</a></li>
        </ul>
        --> 
    </div><!--pageheader-->
    
    <div class="contentwrapper">
    
        <table cellpadding="0" cellspacing="0" border="0" class="stdtable">
            <colgroup>
                <col class="con0" />
                <col class="con1" />
                <col class="con0" />
                <col class="con1" />
                <col class="con0" />
                <col class="con1" />
                <col class="con0" />
                <col class="con1" />
            </colgroup>
            <thead>
                <tr>
                    <th class="head0">#</th>
                    <th class="head1">Time</th>
                    <th class="head0">Application</th>
                    <th class="head1">Res.(ms)</th>
                    <th class="head0">Exception</th>
                    <th class="head1">Agent ID</th>
                    <th class="head0">Client IP</th>
                    <th class="head1">Transaction ID</th>
                </tr>
            </thead>
            <tbody id="table_slow_call">
<!--                 <tr class="item">
                    <td>1</td>
                    <td>2016-03-28 10:00:00</td>
                    <td>/host/manager/</td>
                    <td>625</td>
                    <td> </td>
                    <td>test1001</td>
                    <td>127.0.0.1</td>
                    <td class="center">test1001^1234567890^0</td>
                </tr>
                <tr class="item_detail">
                    <td colspan="8">
                        <div class="poplayer">
                            adfdf
                        </div>
                    </td>
                </tr>
                <tr class="item">
                    <td>2</td>
                    <td>2016-03-28 10:00:00</td>
                    <td>/host/manager/</td>
                    <td>625</td>
                    <td> </td>
                    <td>test1001</td>
                    <td>127.0.0.1</td>
                    <td class="center">test1001^1234567890^0</td>
                </tr>
                <tr class="item">
                    <td>3</td>
                    <td>2016-03-28 10:00:00</td>
                    <td>/host/manager/</td>
                    <td>625</td>
                    <td> </td>
                    <td>test1001</td>
                    <td>127.0.0.1</td>
                    <td class="center">test1001^1234567890^0</td>
                </tr>
                <tr class="item">
                    <td>4</td>
                    <td>2016-03-28 10:00:00</td>
                    <td>/host/manager/</td>
                    <td>625</td>
                    <td> </td>
                    <td>test1001</td>
                    <td>127.0.0.1</td>
                    <td class="center">test1001^1234567890^0</td>
                </tr> -->
            </tbody>
        </table>

        <br /><br />


        
    </div><!--contentwrapper-->
    
    
</div><!--bodywrapper-->

</body>
</html>
