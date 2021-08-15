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
	$('#updateReplyBtn').click(function(){
		
		if($('#content').val()==''){
			alert('댓글 내용을 입력해주세요.');
			$('#content').focus();		
			return false;
		}
		if($('#password').val()==''){
			alert('암호를 입력해주세요.');
			$('#password').focus();
			return false;
		}
	})
}); 
</script>
<meta charset="UTF-8">
<title>댓글 수정</title>
</head>
<body>
<div class="container" role="main">
<h1>댓글 수정</h1>

<form action="updateReply.do" method="post">

<input type="hidden" id="replyseq" name="replyseq" value="${updateReply.replyseq }" />
<input type="hidden" id="boardseq" name="boardseq" value="${updateReply.boardseq }" />
<input type="hidden" name="page" id="page" value="${cri.page }" page = "${cri.page }" />

	<div class="mb-3">
		<label>댓글 내용</label>
		<input type="text"  class="form-control" id="content" name="content" value="${updateReply.content }"  placeholder="댓글 내용을 입력해 주세요"/>
	</div>
		<div class="mb-3">
			<label>암호</label>
			<input type="password" class="form-control" name="password" id="password" placeholder="암호를 입력해 주세요">
		</div>
		<div class="mb-3">
			<button type="submit"  class="btn btn-sm btn-primary" id="updateReplyBtn">댓글 수정</button>
		</div>

</form>

</body>
</html>