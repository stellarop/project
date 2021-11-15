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
	
	// 로그인
	$('#login').click(function(){
		location.href = "login.do"
	})
	
	// 아이디 찾기
	$('#findId').click(function(){
		location.href = "findId.jsp"
	})
	
	$('#find').click(function(){
		
		// 패스워드 찾기 유효성 검사
		if($('#id').val()==''){
			alert('아이디를 입력하세요.');
			$('#id').focus();
			return false;
		}
		
		$.ajax({
			// 패스워드 찾기 경로
			url : 'findPassword.do',
			type : 'post',
			dataType : 'json',
			// 사용자가 입력한 아이디 값
			data : {'id' : $('#id').val()},
			success : function(data){
				// 조회되는 아이디 일시 
				if(data == 0){
					// 기존 페이지로 보내주고 패스워드 구문 출력
					window.location.href = "findPassword.jsp";
				// 조회되지 않은 아이디 일시
				}else if(data == 1){
					alert('등록되지 않은 아이디 입니다.');
					window.location.href = "findPassword.jsp";
				}
			}
		})
	})
});

</script>
<meta charset="UTF-8">
<title>패스워드 찾기</title>
</head>
<body>
<div class="container" role="main">
<form action="findPassword.do" method="post">
<h1>패스워드 찾기</h1>
<p>회원님의 아이디를 입력해주세요</p>
	
	<div class="mb-3">	
		<label>아이디</label>
		<input type="text"  class="form-control" name="id" id="id" placeholder="아이디를 입력해 주세요"/>
	</div>
	
	<tr>
		<div class="mb-3">	
			<button type="submit" class="btn btn-sm btn-primary" id="find">찾기</button>
		</div>
	</tr>
		<c:if test="${getPassword == true}">
			<div class="alert alert-primary">${userName }님의 패스워드는 <b>${userPassword }</b>입니다.</div>
			<button type="button" class="btn btn-sm btn-primary" id="login">로그인</button>
			<button type="button" class="btn btn-sm btn-primary" id="findId">아이디 찾기</button>
		</c:if>
</form>
</div>
</body>
</html>