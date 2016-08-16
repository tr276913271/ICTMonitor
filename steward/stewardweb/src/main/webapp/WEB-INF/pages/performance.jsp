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
<title>APM 业务流性能表现</title>
<link rel="stylesheet" href="css/style.default.css" type="text/css" />
<link type="text/css" href="css/jquery.simple-dtpicker.css" rel="stylesheet" />
<script type="text/javascript" src="js/highcharts/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/highcharts/highcharts.js"></script>
<script type="text/javascript" src="js/datetimepicker/jquery.simple-dtpicker.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script>
var data_performance = {"resultTo":1462699595000,"scatter":[[1462699593649,127499,"test1001^1462699069318^5",0],[1462699380083,256162,"test1001^1462699069318^4",1],[1462699115218,3010,"test1001^1462699069318^3",1],[1462699108229,10053,"test1001^1462699069318^2",1],[1462699087343,9,"test1001^1462699069318^1",1],[1462699086690,748,"test1001^1462699069318^0",1]],"resultFrom":1462699086690,"scatterIndex":{"x":0,"y":1,"transactionId":2,"type":3}}

$(document).ready(function(){

    var json_url = "/stewardweb/getScatterData.do?application=appName&from=1459158066000&to=1459339969000&limit=5000&v=2";
    $.getJSON(json_url,function(data,status){  
        data_performance = data;
    });
    
});


/*
function getPerformanceData(data){
    var list_success = $.grep(data,function(index, item){
        return item[3]==1;
    });
};
*/
function getxAxis(data){
    var scatters = data['scatter'];
    if(scatters.length>=1){
        var tag_start = 0;
        var tag_end = parseInt(scatters.length-1);
        var time_start = parseInt(scatters[0][0]);
        var time_end = parseInt(scatters[tag_end][0]);
        var tag = parseInt(Math.abs(time_end-time_start)/5);
        var time_list = [
            Highcharts.dateFormat('%Y-%m-%d<br>%H:%M:%S', time_end),
            Highcharts.dateFormat('%Y-%m-%d<br>%H:%M:%S', time_end+tag),
            Highcharts.dateFormat('%Y-%m-%d<br>%H:%M:%S', time_end+2*tag),
            Highcharts.dateFormat('%Y-%m-%d<br>%H:%M:%S', time_end+3*tag),
            Highcharts.dateFormat('%Y-%m-%d<br>%H:%M:%S', time_end+4*tag),
            Highcharts.dateFormat('%Y-%m-%d<br>%H:%M:%S', time_end+5*tag)
        ];
    }else{
        var time_list = [];
    }
    return time_list;
}

function getSplitedTime(data){
    var scatters = data['scatter'];
    if(scatters.length>=1){
        var tag_start = 0;
        var tag_end = parseInt(scatters.length-1);
        var time_start = parseInt(scatters[0][0]);
        var time_end = parseInt(scatters[tag_end][0]);
        var tag = parseInt(Math.abs(time_end-time_start)/5);
        var xAxis_list = [time_end, time_end+tag, time_end+2*tag, time_end+3*tag, time_end+4*tag, time_start];
    }else{
        var xAxis_list = [];
    }
    return xAxis_list;
}

function getPerformanceData(data){
    var scatters = data['scatter'];
    //alert(data.length);
    // for(i=0, i<data.length, i++){
    //     alert(i);
    // }
    var list_success = [];
    var list_failed = [];
    var list_summary = [0, 0, 0, 0, 0];
    var list_load_1s = [0, 0, 0, 0, 0];
    $.each(scatters, function(index, item){
        if(item[3]==1){
            list_success.push([item[0], item[1]]);
            /* Start of Summary */
            if(item[1]<3001){
                if(item[1]<2001){
                    if(item[1]<1001){
                        list_summary[0]++;
                    }else{
                        list_summary[1]++;
                    }
                }else{
                    list_summary[2]++;
                }
            }else{
                list_summary[3]++;
            }
            /* End of Summary */
        }else{
            list_failed.push([item[0], item[1]]);
            list_summary[4]++;
        }

        
        //alert(index+'|'+item[0]+'|'+item[1]);
    });
    var list_total = [list_success, list_failed, list_summary];

    return list_total;
};



function getPerformanceData_LOAD(data){
    var data_0 = [];
    var data_1 = [];
    var data_2 = [];
    var data_3 = [];
    var data_4 = [];
    var scatters = data['scatter'];
    var tags = getSplitedTime(data_performance);
    $.each(scatters, function(index, item){
        var t = parseInt(item[0]);
        if(t>tags[1]){
            if(t>tags[2]){
                if(t>tags[3]){
                    if(t>tags[4]){
                        data_4.push(item);
                    }else{
                        data_3.push(item);
                    }
                }else{
                    data_2.push(item);
                }
            }else{
                data_1.push(item);
            }
        }else{
            data_0.push(item);
        }
    });
    s_0 = {"scatter":data_0};
    s_1 = {"scatter":data_1};
    s_2 = {"scatter":data_2};
    s_3 = {"scatter":data_3};
    s_4 = {"scatter":data_4};
    return [getPerformanceData(s_0)[2], getPerformanceData(s_1)[2], getPerformanceData(s_2)[2], getPerformanceData(s_3)[2], getPerformanceData(s_4)[2]];
    // t = [getPerformanceData(s_0)[2], getPerformanceData(s_1)[2], getPerformanceData(s_2)[2], getPerformanceData(s_3)[2], getPerformanceData(s_4)[2]];
    // alert(t);
};


$(function () {                           
    Highcharts.setOptions({                                                     
        global: {
            useUTC: false
        }                                                                       
    });
    $('#chart_sandian').highcharts({                                                             
        chart: {                                                                             
            type: 'scatter',                                                                 
            zoomType: 'xy'                                                                   
        },                                                                                   
        title: {                                                                             
            text: null
        },                                                                                  
        xAxis: {                                                                             
            title: {                                                                         
                enabled: true,                                                               
                text: null                                                          
            },                                                                               
            startOnTick: true,                                                               
            endOnTick: true,                                                                 
            showLastLabel: true,
            type: 'datetime',
            dateTimeLabelFormats: {
                 millisecond: '%H:%M:%S<br>%Y-%m'
            }
        },                                           
        yAxis: {                                                                             
            title: {                                                                         
                text: '响应时间 (ms)'                                                          
            }                                                                                
        },                                                                                   
        legend: {                                                                            
            layout: 'vertical',                                                              
            align: 'left',                                                                   
            verticalAlign: 'top',                                                            
            x: 100,                                                                          
            y: 30,                                                                           
            floating: true,                                                                  
            backgroundColor: '#FFFFFF',                                                      
            borderWidth: 1                                                                   
        },                                                                                   
        plotOptions: {                                                                       
            scatter: {                                                                       
                marker: {                                                                    
                    radius: 5,                                                               
                    states: {                                                                
                        hover: {                                                             
                            enabled: true,                                                   
                            lineColor: 'rgb(100,100,100)'                                    
                        }                                                                    
                    }                                                                        
                },                                                                           
                states: {                                                                    
                    hover: {                                                                 
                        marker: {                                                            
                            enabled: false                                                   
                        }                                                                    
                    }                                                                        
                },                                                                           
                tooltip: {                                                                   
                    headerFormat: '<b>{series.name}</b><br>',
                    //pointFormat: '{point.x} , {point.y} ms',
                    pointFormat: '{point.x} , {point.y} ms', 
                    // formatter: function() {                                             
                    //     return '<b>'+ this.series.name +'</b><br/>'+                
                    //     Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                    //     Highcharts.numberFormat(this.y, 2);                         
                    // }  
                }                                                                            
            }                                                                                
        },                                                                                   
        series: [{                                                                           
            name: '成功',                                                                  
            color: 'rgba(10, 232, 10, .5)',                                                  
            //data: [[1459166930522, 52],[1459166930528, 48],[1459166930928, 48],[1459166931028, 68]]   
            data: getPerformanceData(data_performance)[0]
                                                                                             
        }, {                                                                                 
            name: '超时',                                                                    
            color: 'rgba(223, 83, 83, .5)',                                                
            //data: [[1459166930926, 58],[1459166931121, 65],[1459166931322, 56]]                                                
            data: getPerformanceData(data_performance)[1]
        }]                                                                                   
    });    




    var colors = Highcharts.getOptions().colors,
        categories = ['1s', '2s', '3s', 'Slow', 'Error'],
        name = '响应时间',
        data = [{
                y: getPerformanceData(data_performance)[2][0],
                color: colors[0]
            }, {
                y: getPerformanceData(data_performance)[2][1],
                color: colors[1]
            }, {
                y: getPerformanceData(data_performance)[2][2],
                color: colors[2]
            }, {
                y: getPerformanceData(data_performance)[2][3],
                color: colors[3]
            }, {
                y: getPerformanceData(data_performance)[2][4],
                color: colors[4]
            }];

    var chart_response_summary = $('#chart_response_summary').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: null
        },
        xAxis: {
            categories: categories
        },
        yAxis: {
            title: {
                text: '响应数'
            }
        },
        tooltip: {
            formatter: function() {
                var point = this.point,
                    s = this.x +':include <b>'+ this.y +'</b> items.<br/>';
                return s;
            }
        },
        series: [{
            name: name,
            data: data,
            color: 'white'
        }],
        exporting: {
            enabled: false
        }
    }).highcharts(); // return chart



    /*----------- Start Of Load Chart Section -----------*/
    //getPerformanceData_LOAD(data_performance);
    $('#chart_load').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: null
        },
        xAxis: {
            title: {                                                                         
                enabled: true,                                                               
                text: null                                                          
            }, 
            type: 'datetime',
            dateTimeLabelFormats: {
                millisecond: '%H:%M:%S<br>%Y-%m'
            },
            categories: getxAxis(data_performance)
        },
        yAxis: {
            min: 0,
            title: {
                text: '响应数'
            },
            stackLabels: {
                enabled: true,
                style: {
                    fontWeight: 'bold',
                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                }
            }
        },
        legend: {
            align: 'right',
            x: -20,
            verticalAlign: 'top',
            y: 5,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
            borderColor: '#CCC',
            borderWidth: 1,
            shadow: false
        },
        tooltip: {
            formatter: function() {
                return '<b>'+ this.x +'</b><br/>'+
                    this.series.name +': '+ this.y +'<br/>'+
                    'Total: '+ this.point.stackTotal;
            }
        },
        plotOptions: {
            column: {
                stacking: 'normal',
                dataLabels: {
                    enabled: true,
                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
                }
            }
        },
        series: [{
            name: '1s',
            // data: [5, 3, 4, 7, 2]
            data: getPerformanceData_LOAD(data_performance)[0]
        }, {
            name: '2s',
            //data: [2, 2, 3, 2, 1]
            data: getPerformanceData_LOAD(data_performance)[1]
        }, {
            name: '3s',
            //data: [3, 4, 4, 2, 5]
            data: getPerformanceData_LOAD(data_performance)[2]
        }, {
            name: 'Slow',
            //data: [3, 4, 4, 2, 5]
            data: getPerformanceData_LOAD(data_performance)[3]
        }, {
            name: 'Error',
            //data: [3, 4, 4, 2, 5]
            data: getPerformanceData_LOAD(data_performance)[4]
        }]
    });
    /*----------- End Of Load Chart Section -----------*/
});



function submitSearchForm(){
    

    var time_from = $('input[name=from]').val();
    var time_to = $('input[name=to]').val();
	var appName = 'tomcat';
    stamp_from = new Date(time_from);
    stamp_to = new Date(time_to);
    sttime = stamp_from.getTime();
    endtime = stamp_to.getTime();
    //$('input[name=from]').val(stamp_from.getTime());
    //$('input[name=to]').val(stamp_to.getTime());
    //$('#searchForm').submit();
    var json_url = '/stewardweb/getScatterData.do?application='+ appName+'&from=' + stamp_from.getTime().toString() + '&to=' + stamp_to.getTime().toString() + '&limit=5000&v=2';
    $.getJSON(json_url,function(data,status){
        data_performance = data;
    });

    var chartSandian = $('#chart_sandian').highcharts();
    var chartSummary = $('#chart_response_summary').highcharts();
    var chartLoad = $('#chart_load').highcharts();

    var colors = Highcharts.getOptions().colors,
        data = [{
                y: getPerformanceData(data_performance)[2][0],
                color: colors[0]
            }, {
                y: getPerformanceData(data_performance)[2][1],
                color: colors[1]
            }, {
                y: getPerformanceData(data_performance)[2][2],
                color: colors[2]
            }, {
                y: getPerformanceData(data_performance)[2][3],
                color: colors[3]
            }, {
                y: getPerformanceData(data_performance)[2][4],
                color: colors[4]
            }];

    chartSandian.series[0].setData(getPerformanceData(data_performance)[0]);
    chartSandian.series[1].setData(getPerformanceData(data_performance)[1]);

    chartSummary.series[0].setData(data);
    // console.log(getPerformanceData_LOAD(data_performance)[0]);
    // console.log('-------------------------');
    // console.log(chartLoad.series[0].data);
    // console.log(chartLoad.series[1].data);
    // console.log(chartLoad.series[2].data);
    // console.log(chartLoad.series[3].data);
    // console.log(chartLoad.series[4].data);
    //console.log(getPerformanceData(data_performance)[0]);
    // console.log(getPerformanceData_LOAD(data_performance)[0]);
    // console.log(chartLoad.series[0]);
    // console.log(chartLoad.series[1]);

    chartLoad.series[0].setData(getPerformanceData_LOAD(data_performance)[0]);
    chartLoad.series[1].setData(getPerformanceData_LOAD(data_performance)[1]);
    chartLoad.series[2].setData(getPerformanceData_LOAD(data_performance)[2]);
    chartLoad.series[3].setData(getPerformanceData_LOAD(data_performance)[3]);
    chartLoad.series[4].setData(getPerformanceData_LOAD(data_performance)[4]);

    
};
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
                <!-- <form id="searchForm" action="getScatterData.do" method="get"> -->
                    <input type="text" id="form_from" name="from" value="" />
                    <input type="text" id="form_to" name="to" value="" />
                    <input type="hidden" id="form_limit" name="limit" value="5000" />
                    <input type="hidden" id="form_v" name="v" value="2" />                   
                    <!-- <input type="text" name="keyword" id="keyword" value="请输入" /> -->
                    <button class="submitbutton" onClick="submitSearchForm();"></button>
                <!-- </form> -->
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
            <li><a onclick='navjump(0)'><span class="icon icon-flatscreen"></span>业务流拓扑</a></li>
            <li class="current"><a onclick='navjump(1)'><span class="icon icon-pencil"></span>业务流性能表现</a></li>
            <li><a onclick='navjump(2)'><span class="icon icon-chart"></span>应用级负载</a></li>
            <li><a onclick='navjump(3)'><span class="icon icon-speech"></span>慢调用</a></li>
            <li><a onclick='navjump(4)'><span class="icon icon-message"></span>出错调用</a></li>
        </ul>
    </div><!--header-->
    
    <div class="pageheader">
    	<h1 class="pagetitle contenttitle2">业务流性能表现</h1>
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
    	
            <div class="one_half">
                <div class="contenttitle2">
                    <h3>性能概览</h3>
                </div><!--contenttitle-->
                <br />
                <div id="chart_sandian" style="height:300px;"></div>
            </div><!--one_half-->
            
            <div class="one_half last">            
                <div class="contenttitle2">
                    <h3>响应统计</h3>
                </div><!--contenttitle-->
                <br />
                <div id="chart_response_summary" style="height:300px;"></div>
            </div><!--one_half last-->
            
            <br clear="all" /><br />
            
            <div class="one_half">
                <div class="contenttitle2">
                    <h3>性能负载</h3>
                </div><!--contenttitle-->
                <br />
                <div id="chart_load" style="height:300px;"></div>
            </div><!--one_half-->
            
            <div class="one_half last" style="display:none;">
                <div class="contenttitle2">
                    <h3>监控4</h3>
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
