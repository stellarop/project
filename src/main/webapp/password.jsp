<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" 
integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<script src="<c:url value="/vendor/jquery/jquery.min.js"/>"></script>
<script>
$(function(){
	$('#login').click(function(){
		location.href = "login.do"
	})
})	
</script>
<meta charset="UTF-8">
<title>패스워드 찾기</title>
</head>
<div class="container" role="main">
<body>
<p>${userName }님의 패스워드는 ${userPassword} 입니다.</p>
<button type="button"  class="btn btn-sm btn-primary" id="login">로그인</button>
</body>
</div>
</html>