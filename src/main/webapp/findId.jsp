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
		$('#id').click(function(){
			if($('#email').val()==''){
				alert('이메일을 입력하세요.');
				$('#email').focus();
				return false;
			}
		})
	})
</script>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
<div class="container" role="main">
<h1>아이디 찾기</h1>
<p>${userName }님의 이메일을 입력해주세요</p>
<form action="findId.do" method="post">

	
	<div class="mb-3">			
		<label>이메일</label>
		<input type="email" class="form-control" name="email" id="email" placeholder="이메일를 입력해 주세요">
	</div>
	<div class="mb-3">
		<button type="submit" class="btn btn-sm btn-primary" id="id">찾기</button>		
	</div>

</form>
</div>
</body>
</html>