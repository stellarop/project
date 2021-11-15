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
	// 로그인
	$('#login').click(function(){
		location.href = "login.do"
	})
	
	// 회원가입 유효성 검사
	$('#uses').click(function(){
		if($('#id').val()==''){
			alert('아이디를 입력하세요.');
			$('#id').focus();
			return false;
		}
		if($('#password1').val()==''){
			alert('패스워드를 입력하세요.');
			$('#password1').focus();
			return false;
		}
		if($('#password2').val()==''){
			alert('패스워드를 입력하세요.');
			$('#password2').focus();
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
		
		$.ajax({
			// 회원가입 경로
			url : 'createUser.do',
			type : 'post',
			dataType : 'json',
			// 사용자가 입력한 회원가입 정보
			data : $('#createUser').serializeArray(),
			success : function(data){
				// 사용 가능한 아이디면(컨트롤러에서 반환돠는 값이 true일시)회원가입 진행
				if(data == true){
					// 폼 안에 있는 회원 정보가 컨트롤러로 전송됨
					$('#createUser').submit();
					alert('회원가입이 완료 되었습니다.');
					// 로그인 창으로 보내줌
					window.location.href = "login.do";	
				// 중복된 아이디 일때(컨트롤러에서 반환되는 값이 false일시)
				}else if(data == false){
					alert('중복된 아이디로는 회원가입을 진행 할 수 없습니다.');
					// 회원가입 창으로 보내줌
					window.location.href = "createUser.jsp";
				}
			}
		})
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
	
	// 패스워드 일치 불일치 구문
	$('#truepassword').hide();
	$('#falsepassword').hide();
	
	//패스워드 값 확인
	$('#pwdCheck').click(function(){
		// 패스워드 유효성 검사
		if($('#password1').val()==''){
			alert('패스워드를 입력하세요.');
			$('#password1').focus();
			return false;
		}
		if($('#password2').val()==''){
			alert('패스워드를 입력하세요.');
			$('#password2').focus();
			return false;
		}
		// 사용자가 입력한 패스워드 값 
		var password1 =$('#password1').val();
		var password2 =$('#password2').val();
		
		// 사용자가 입력한 두 개의 패스워드 값 비교
		if(password1 == password2){
			// 값이 맞으면 일치 구문 출력
			$('#truepassword').show();
			$('#falsepassword').hide();
		}else{
			// 값이 틀리면 불일치 구문 출력
			$('#truepassword').hide();
			$('#falsepassword').show();
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
<form action="createUser.do" id="createUser" method="post">
	<div class="mb-3">
		<label>아이디</label>
			<input type="text" class="form-control" name="id" id="id" placeholder="아이디을 입력해 주세요">
			<br>
			<!-- 버튼 클릭시  id_duplicate() 메서드 실행 -->
			<button type="button" class="btn btn-sm btn-primary" id="idCheck" onclick='id_duplicate();'>아이디 확인</button>
	</div>
	
	<div class="mb-3">
		<label>패스워드</label>
		<input type="password" class="form-control" name="password" id="password1" placeholder="패스워드를 입력해 주세요">
	</div>
	
	<div class="mb-3">
		<label>패스워드 재입력</label>
		<input type="password" class="form-control"  id="password2" placeholder="패스워드를 입력해 주세요">
	</div>
	
	<button type="button" class="btn btn-sm btn-primary" id="pwdCheck">패스워드 확인</button>
	<br>
	<br>
	<div class="alert alert-success" id="truepassword">패스워드가 일치합니다.</div>
	<div class="alert alert-danger" id="falsepassword">패스워드가 일치하지 않습니다. 다시 입력 해주세요.</div>
	
	<div class="mb-3">
		<label>이름</label>
			<input type="text" class="form-control" name="name" id="name" placeholder="이름를 입력해 주세요">
	</div>
	
	<div class="mb-3">			
		<label>이메일</label>
			<input type="email" class="form-control" name="email" id="email" placeholder="이메일를 입력해 주세요">
			<br>
			 <select id="select" class="form-control">
				<option value="" disabled selected>E-Mail 선택</option>
				<option value="@naver.com" id="naver.com">naver.com</option>
				<option value="@daum.net" id="hanmail.net">daum.net</option>
				<option value="@gmail.com" id="gmail.com">gmail.com</option>
				<option value="@nate.com" id="nate.com">nate.com</option>
				<option value="directly" id="textEmail">직접 입력하기</option>
			</select>
	</div>		
	<div class="mb-3">		
		<button type="button" class="btn btn-sm btn-primary" id="uses">가입하기</button>
		<button type="button" class="btn btn-sm btn-primary" id="login">로그인</button>
	</div>		


</form>
</div>
</body>
</html>