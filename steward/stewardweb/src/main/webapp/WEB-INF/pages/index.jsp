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
<title>APM 控制台页面</title>
<link rel="stylesheet" href="css/style.default.css" type="text/css" />
<script type="text/javascript" src="js/highcharts/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/plugins/jquery-ui-1.8.16.custom.min.js"></script>
<script type="text/javascript" src="js/plugins/jtopo-0.4.8-min.js"></script>
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
    <div class="topheader orangeborderbottom5">
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
                <span>${sessionScope.userInfo.username}</span>
            </div><!--userinfo-->
            
            <div class="userinfodrop">
                <div class="userdata">
                    <h4>${sessionScope.userInfo.username}</h4>
                    <span class="email">youremail@yourdomain.com</span>
                    <ul>
                        <li><a href="logout.do">退出</a></li>
                    </ul>
                </div><!--userdata-->
            </div><!--userinfodrop-->
        </div><!--right-->
    </div><!--topheader-->
    
    
    <div class="header" style="display:none;">
    	<ul class="headermenu">
            <li><a href="index.html"><span class="icon icon-flatscreen"></span>业务流拓扑</a></li>
            <li><a href="performance.html"><span class="icon icon-pencil"></span>业务流性能表现</a></li>
            <li><a href="app_load.html"><span class="icon icon-chart"></span>应用级负载均衡</a></li>
            <li><a href="host_load.html"><span class="icon icon-chart"></span>主机负载监控</a></li>
            <li><a href="slow_call.html"><span class="icon icon-speech"></span>慢调用</a></li>
            <li><a href="wrong_call.html"><span class="icon icon-message"></span>出错调用</a></li>
        </ul>
    </div><!--header-->
    
    <div class="contentwrapper">
        <div id="updates" class="subcontent" style="width:800px; margin:0 auto; position:relative;">
			<!--
			<div id="agentRegister" style="width:100%; height:30px; clear:both;">
				<input type="text" id="agentID" name="agentID" placeholder="填写欲注册的ID值" />
				<input type="button" value="注册"/>
			</div>
			-->
        	<ul class="shortcuts" style="width:350px; float:left;">
                <div class="title" style="border-bottom:2px solid #FB9337;padding-bottom:5px; margin-bottom:20px;margin-top:50px;"><h3>App 应用列表</h3></div>
                <c:forEach items="${agents}" var="agent">
<!-- 				<c:if test="${agent.type==1}">
					<li><a href="hostLoad.do?agentID=<c:out value="${agent.agentID}"/>" class="tomcat"><span>主机</span></a>
				</c:if> -->
				<c:if test="${agent.type==2}">
					<li><a href="topo.do?agentID=<c:out value="${agent.agentID}"/>"  class="tomcat"><span>服务器</span></a>
				</c:if>
				</c:forEach>
            </ul>
            <ul class="shortcuts" style="width:350px; float:left; padding-left:60px;">
                <div class="title" style="border-bottom:2px solid #FB9337;padding-bottom:5px; margin-bottom:20px;margin-top:50px;"><h3>主机列表</h3></div>
                <c:forEach items="${agents}" var="agent">
                <c:if test="${agent.type==1}">
                    <li><a href="hostLoad.do?agentID=<c:out value="${agent.agentID}"/>" class="host"><span>主机</span></a>
                </c:if>
                </c:forEach>
            </ul>
        </div>
        
    </div><!--contentwrapper-->
    
    
</div><!--bodywrapper-->

</body>
</html>
