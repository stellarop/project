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
		$('#deleteReplyBtn').click(function(){
			if($('#password').val()==''){
				$('#password').focus();
				alert('암호를 입력해주세요.');
			}
		});
	})
</script>
<meta charset="UTF-8">
<title>댓글 삭제 암호</title>
</head>
<body>
<div class="container" role="main">
<h1>댓글 암호</h1>
<p>댓글 암호를 입력하세요</p>
<form action="deleteReply.do" method="post">
<input type="hidden" name="boardseq" value="${deleteReply.boardseq }" />
<input type="hidden" name="replyseq" value="${deleteReply.replyseq }" />
<input type="hidden" name="page" id="page" value="${cri.page }" page = "${cri.page }" />
		<div class="mb-3">
			<label>암호</label>
			<input type="password" class="form-control" name="password" id="password" placeholder="암호를 입력해 주세요">
		</div>
		<div class="mb-3">
			<button type="submit" class="btn btn-sm btn-primary" id="deleteReplyBtn">확인</button>
		</div>
</form>
</body>
</html>