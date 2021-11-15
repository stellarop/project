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
		
		// 패스워드 찾기
		$('#findPwn').click(function(){
			location.href = "findPassword.jsp"
		})
		
		$('#id').click(function(){
		
			// 아이디 찾기 유효성 검사
			if($('#email').val()==''){
				alert('이메일을 입력하세요.');
				$('#email').focus();
				return false;
			}
			
			$.ajax({
				// 아이디 찾기 경로 
				url : 'findId.do',
				type : 'post',
				dataType : 'json',
				// 사용자가 입력한 이메일 값
				data : {'email' : $('#email').val()},
				success : function(data){
					// 조회 되는 이메일 일시
					if(data == 0){
						// 기존 페이지로 보내주고 아이디 구문을 나타내준다
						window.location.href = "findId.jsp";
					// 없는 이메일 이면 기존 페이지로
					}else if(data == 1){
						alert('사용자의 이메일로 등록된 아이디가 없습니다.');
						window.location.href = "findId.jsp";
					}
				}
			})	
		})	
	});
</script>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
<div class="container" role="main">
<h1>아이디 찾기</h1>
<p>회원님의 이메일을 입력해주세요</p>
<form action="findId.do" method="post">

	<div class="mb-3">			
		<label>이메일</label>
		<input type="email" class="form-control" name="email" id="email" placeholder="이메일를 입력해 주세요">
	</div>
	
	<tr>
		<div class="mb-3">	
			<button type="submit" class="btn btn-sm btn-primary" id="id">찾기</button>	
		</div>
	</tr>	
	
		<c:if test="${getId == true}">
			<div class="alert alert-primary">${userName }님의 아이디는 <b>${userId }</b>입니다.</div>
			<button type="button" class="btn btn-sm btn-primary" id="login">로그인</button>
			<button type="button" class="btn btn-sm btn-primary" id="findPwn">패스워드 찾기</button>
		</c:if>
	
</form>
</div>
</body>
</html>