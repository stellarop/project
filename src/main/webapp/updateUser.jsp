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
		
		$('#updateUserBtn').click(function(){
			
			if($('#password').val()==''){
				alert('패스워드를 입력하세요.');
				$('#password').focus();
				return false;
			}
			alert('수정되었습니다.');
	});
})
</script>
<meta charset="UTF-8">
<title>회원정보 수정</title>
</head>
<body>
<div class="container" role="main">
<h1>회원정보수정</h1>
<p>가입날짜 : ${userTime }</p>
<form action="updateUser.do" method="post" id="updateUser">
		<div class="mb-3">
			<label>아이디</label>
			<input name="id" class="form-control" value="${userId }" readonly="readonly"/></td> <!--readonly <= 읽기만되는 속성  -->
		</div>
		<div class="mb-3">
			<label>패스워드</label>
		<input type="password" name="password" class="form-control" id="password" />
		</div>
		<div class="mb-3">
			<label>이름</label>
			<input type="text" name="name" class="form-control" value="${userName }" readonly="readonly"/>
		</div>
	<div class="mb-3">
		<td><button type="submit"  class="btn btn-sm btn-primary" id="updateUserBtn">회원정보수정</button></td>	
	</div>
	
</form>
</div>
</center>
</body>
</html>