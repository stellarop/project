<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/vendor/jquery/jquery.min.js"/>"></script>
<script> 
$(function(){
	// 로그인 유효성 검사
	$('#login').click(function(){
		if($('#id').val()==''){
			alert('아이디를 입력해주세요.');
			$('#id').focus();		
			return false;
		}
		if($('#password').val()==''){
			alert('패스워드를 입력해주세요.')
			$('#password').focus();	
			return false;
		}
		
		$.ajax({
			//컨트롤러 경로
			url : 'login.do',
			type : 'post',
			dataType : 'json',
			// 사용자가 입력한 아이디, 패스워드
			data : {'id' : $('#id').val(),
			'password' : $('#password').val()},
			success : function(data){
				// 컨트롤러에서 반환되는 값이 true 일시
				if(data == true){
					alert('로그인 성공');
					// 메인 페이지로
					location.href = "main.do";
				// 컨트롤러에서 반환되는 값이 false 일시
				}else if(data == false){
					alert('로그인 실패');
					// 로그인 페이지로
					location.href = "login.jsp";
				}
			}
		})
	}); 
	
	/*
	if(login == false){
		$('#id').css('border-color', 'red');
		$('#password').css('border-color', 'red');
		return false;
	}
	*/
})
</script>
<style>
	body{
    background-color:#5286F3;
    font-size:14px;
    color:#fff;
}
.simple-login-container{
    width:300px;
    max-width:100%;
    margin:50px auto;
}
.simple-login-container h2{
    text-align:center;
    font-size:20px;
}

.simple-login-container .btn-login{
    background-color:#FF5964;
    color:#fff;
}
a{
    color:#fff;
}
</style>
<meta charset="UTF-8">
<title>로그인페이지</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
</head>
<body>

<form action="login.do" method="post">
<center>
<div class="simple-login-container">
<h1>로그인</h1>
    <div class="row">
        <div class="col-md-12 form-group">
            <input type="text" name="id" id="id" class="form-control" placeholder="ID" value="${user.id }">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group">
            <input type="password" name="password" id="password" placeholder="PASSWORD" class="form-control" value="${user.password }">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-group">
           	<button type="submit" id="login" class="btn btn-block btn-login" >로그인</button>
        </div>
    </div>
    
    <c:if test="${login == false}">
		<div class="alert alert-danger">로그인에 실패했습니다.<br> 아이디와 비밀번호를 확인해주세요.</div>
	</c:if>
	
    <div class="row">
         <div class="col-md-12">
           	<a href="findId.jsp">아이디를 잊으셨나요?</a>
        </div>
         <div class="col-md-12">
           	<a href="findPassword.jsp">비밀번호를 잊으셨나요?</a>
        </div>
        <div class="col-md-12">
           	<a href="createUser.jsp">회원가입하기 </a>
        </div>
    </div>
</div>
</center>
</form>
</body>
</html>