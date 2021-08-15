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
	
	// 목록
	$('#mainBtn').click(function(){
		location.href = "main.do"
	})
	
	// 빈값 검사
	$('#insertBoardBtn').click(function(){
		
		if($('#title').val()==''){
			alert('제목을 입력하세요.');
			$('#title').focus();
			return false;
		}
		
		if($('#writer').val()==''){
			alert('작성자를 입력하세요.');
			$('#writer').focus();
			return false;
		} 
		
		if($('#content').val()==''){
			alert('내용을 입력하세요.');
			$('#content').focus();
			return false;
		}
		
		if($('#password').val()==''){
			alert('암호를 입력하세요.');
			$('#password').focus();
			return false;
		}
		
		alert('글이 등록되었습니다.');
	});
});
</script>
<meta charset="UTF-8">


<title>게시글 등록</title>
</head>
<body>
<div class="container" role="main">
<h2>글 작성</h2>
<form action="insertBoard.do" method="post" enctype="multipart/form-data">
		<div class="mb-3">
			<label>제목</label>
			<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
		</div>

		<div class="mb-3">
			<label>작성자</label>
			<input type="text" class="form-control" name="writer" id="writer" placeholder="작성자를 입력해 주세요">
		</div>
	
		<div class="mb-3">
			<label>내용</label>
			<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요" ></textarea>
		</div>
				
		<div class="mb-3">
			<label>암호</label>
			<input type="password" class="form-control" name="password" id="password" placeholder="암호를 입력해주세요"/>
		</div>

		<div class="mb-3">
			<label>파일</label>
			<input type="file" class="form-control" name="uploadFile" id="uploadFile">
		</div>		
				
		<div>
			<button type="submit" class="btn btn-sm btn-primary" id="insertBoardBtn">저장</button>
			<button type="button" class="btn btn-sm btn-primary" id="mainBtn">목록</button>
		</div>	
</div>
</form>
</body>
</html>