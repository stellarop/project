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
	$('#findid').click(function(){
		if($('#id').val()==''){
			alert('아이디를 입력하세요.');
			$('#id').focus();
			return false;
		}
	})
})
</script>
<meta charset="UTF-8">
<title>패스워드 찾기</title>
</head>
<body>
<div class="container" role="main">
<form action="findPassword.do" method="post">
<h1>패스워드 찾기</h1>
<p>회원님의 id를 입력해주세요</p>
	
	<div class="mb-3">	
		<label>아이디</label>
		<td><input type="text"  class="form-control" name="id" id="id" placeholder="아이디를 입력해 주세요" value="${user.id }"/></td>
	</div>
	<tr>
		<div class="mb-3">	
			<button type="submit" class="btn btn-sm btn-primary" id="findid">찾기</button>
		</div>
	</tr>
</teble>
</body>

</div>
</html>