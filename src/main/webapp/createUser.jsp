<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	// 빈값 검사
	$('#uses').click(function(){
		
		if($('#id').val()==''){
			alert('아이디를 입력하세요.');
			$('#id').focus();
			return false;
		}
		
		if($('#password').val()==''){
			alert('패스워드를 입력하세요.');
			$('#password').focus();
			return false;
		}
		
		if($('#name').val()==''){
			alert('이름을 입력하세요.');
			$('#name').focus();
			return false;
		} 
		
		if($('#email').val()==''){
			alert('이메일을 입력하세요.');
			$('#email').focus();
			return false;
		}
		alert('회원가입이 완료되었습니다.');
	});
	
	// 이메일  받기
	$('#select').change(function() {
        if ($('#select').val() == 'directly') {
            $('#email').attr('disabled', false);
            $('#email').val('');
            $('#email').focus();
        } else {
            $('#email').val($('#select').val());
        }
    });	
})

	// 아이디 중복확인
	function id_duplicate(){
		$.ajax({
			// 컨트롤러 경로
			url : 'idCheck.do',
			type : 'post',
			dateType : 'json',
			// 사용자가 입력한 아이디를 컨트롤러로 보내줌
			data : {'id' : $('#id').val()},
			// 중복된 아이디면 1 반환, 사용가능한 아이디면 0을 반환
			success : function(data){
				if(data == 1){
					alert('중복된 아이디입니다.');
				}else if(data == 0){
					alert('사용가능한 아이디입니다');
				}
			}
		})
	}
</script>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
</head>

<body>
<div class="container" role="main">
<h2>회원가입</h2>
<form action="createUser.do" method="post">
	<div class="mb-3">
		<label>아이디</label>
			<input type="text" class="form-control" name="id" id="id" placeholder="아이디을 입력해 주세요">
			<!-- 버튼 클릭시  id_duplicate() 메서드 실행 -->
			<button type="button" class="btn btn-sm btn-primary" id="idCheck" onclick='id_duplicate();' >중복확인</button>
	</div>
	
	<div class="mb-3">
		<label>패스워드</label>
		<input type="password" class="form-control" name="password" id="password" placeholder="패스워드를 입력해 주세요">
	</div>
	
	<div class="mb-3">
		<label>이름</label>
			<input type="text" class="form-control" name="name" id="name" placeholder="이름를 입력해 주세요">
	</div>
	
	<div class="mb-3">			
		<label>이메일</label>
			<input type="email" class="form-control" name="email" id="email" placeholder="이메일를 입력해 주세요">
			 <select id="select">
				<option value="" disabled selected>E-Mail 선택</option>
				<option value="@naver.com" id="naver.com">naver.com</option>
				<option value="@daum.net" id="hanmail.net">daum.net</option>
				<option value="@gmail.com" id="gmail.com">gmail.com</option>
				<option value="@nate.com" id="nate.com">nate.com</option>
				<option value="directly" id="textEmail">직접 입력하기</option>
			</select>
	</div>		
	<div class="mb-3">		
		<button type="submit" class="btn btn-sm btn-primary" id="uses">가입하기</button>
		<button type="button" class="btn btn-sm btn-primary" id="login">로그인</button>
	</div>		


</form>
</div>
</body>
</html>