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
	
	$('#mainBtn').click(function(){
		location.href = "main.do"
	})
	
	$('#deleteUserBtn').click(function(){
		if($('#password').val()==''){
			alert('패스워드를 입력하세요.');
			$('#password').focus();
			return false;
		}
		
		// 패스워드 확인
		$.ajax({
			// 컨트롤러 경로
			url : 'passwordCheck.do',
			type : 'post',
			dateType : 'json',
			// 폼에서 사용자가 입력한 패스워드를 컨트롤러로 보내줌
			data : $('#deleteUser').serializeArray(),
			// 일치하면 1을 반환, 일치하지 않으면 0을 반환
			success : function(data){
				if(data == 0){
					alert('패스워드가 일치하지 않습니다.');
					return;
				}else{
					if(confirm("회원탈퇴하시겠습니까?")){
						// 예를 누르면 사용자가 입력한 패스워드가 컨트롤러로 전송됨
						$('#deleteUser').submit();
						alert('탈퇴가 완료되었습니다.');
					}
				}
			} 
		})
		
	});	
})

</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container" role="main">
<h1>회원탈퇴</h1>
<p>회원탈퇴를 하시려면 패스워드를 입력해주세요.</p>
<form action="deleteUser.do" method="post" id="deleteUser">
	
	<div class="mb-3">
		<label>이름</label>
		<input type="text" class="form-control" name="name" id="name" value="${userName }" readonly="readonly"/></td>
	</div>
	<div class="mb-3">
		<td>아이디</td>
		<td><input type="text" class="form-control" name="id" id="id" value="${userId }" readonly="readonly" /></td>
	</div>
	<div class="mb-3">
		<td>패스워드</td>
		<td><input type="password" class="form-control" name="password" id="password" /></td>
	</div>
	<div class="mb-3">
		<button type="button" class="btn btn-sm btn-primary" id="deleteUserBtn">탈퇴</button>
		<button type="button" class="btn btn-sm btn-primary" id="mainBtn">목록</button>
	</div>
	

</form>
</div>
</body>
</html>