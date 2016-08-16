<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>APM 注册页面</title>
<link rel="stylesheet" href="css/style.default.css" type="text/css" />
   <script type="text/javascript" src="js/highcharts/jquery-1.8.3.min.js"></script>
   <script type="text/javascript" src="js/highcharts/highcharts.js"></script>
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
<script type="text/javascript">
$(document).ready(function(){
});
</script>

<body class="loginpage">
	<div class="loginbox">
    	<div class="loginboxinner">
        	
            <div class="logo">
            	<h1 class="logo">APM <span>Admin</span></h1>
				<span class="slogan">账号注册</span>
            </div><!--logo-->
            
            <br clear="all" /><br />
            
            <div class="nousername">
                <div class="loginmsg">账号不能为空.</div>
            </div><!--nousername-->
            
            <div class="nopassword">
				<div class="loginmsg">密码不能为空.</div>
            </div><!--nopassword-->
            
            
            <form id="login" action="signUp.do" method="post">
            	
                <div class="username">
                	<div class="usernameinner">
                    	<input type="text" name="username" placeholder="请输入用户名" id="username" />
                    </div>
                </div>
                
                <div class="password">
                	<div class="passwordinner">
                    	<input type="password" name="password" placeholder="请输入密码" id="password" />
                    </div>
                </div>
				
				<div class="email">
                    <div class="emailinner">
                        <input type="text" name="email"  placeholder="请输入邮箱" id="email" />
                    </div>
                </div>
                
                <button>注册</button>
                
            </form>
            
        </div><!--loginboxinner-->
    </div><!--loginbox-->


</body>
</html>




<!--
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
	<form action="login.do" method="post">
		账户：<input type="text" name="username"/>
		密码：<input type="password" name="password"/>
		<input type="submit" value="提交"> 
	</form>
	
	<a href="signUp.do">注册</a>
</body>
</html>
--> 
