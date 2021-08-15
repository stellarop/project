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
			location.href = "main.do?page=${cri.page}"
		})
		
		$('#updateBoardBtn').click(function(){
			
			if($('#title').val()==''){
				alert('제목을 입력하세요.');
				$('#title').focus();
				return false;
			}
			
			if($('#content').val()==''){
				alert('내용을 입력하세요.');
				$('#content').focus();
				return false;
			}
			
			if($('#password').val()==''){
				alert('암호을 입력하세요.');
				$('#password').focus();
				return false;
			}
			
			// ajax 들어가야함
			$.ajax({
				url : 'boardPwdCheck.do',
				type : 'post',
				datetype : 'json',
				data : $('#updateBoard').serializeArray(),
				success : function(date){
					if(date == 0){
						alert('암호가 일치하지 않습니다.');
						return;
					}else{
						if(confirm('수정하시겠습니까?')){
							$('#updateBoard').submit();
							alert('게시글이 수정되었습니다.');
						}
					}
				}
			})
		})
		
	})
</script>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
<div class="container" role="main">
<h2>글 수정</h2>
<form action="updateBoard.do" id="updateBoard" method="post">
<input type="hidden" name="boardseq" value="${updateBoard.boardseq }" />
<input type="hidden" name="page" id="page" value="${cri.page }" />   
		<div class="mb-3">
			<label>제목</label>
			<input type="text" class="form-control" name="title" id="title" value="${updateBoard.title }">
		</div>
		
		<div class="mb-3">
			<label>작성자</label>
			<input type="text" class="form-control" name="writer" id="writer" value="${updateBoard.writer}" readonly="readonly"/>
		</div>
		
		<div class="mb-3">
			<label>글내용</label>
			
			<textarea type="text"  name="content" id="content" class="form-control" rows="5">${updateBoard.content }</textarea>
		</div>
		
		<div class="mb-3">
			<label>작성날짜</label>
			<input type="text" class="form-control" value="${updateBoard.regdate}" readonly="readonly"/>
		</div>	
		
		<div class="mb-3">
			<label>암호</label>
			<input type="password" class="form-control" name="password" id="password" placeholder="암호를 입력해주세요" />
		</div>
		
		<div class="mb-3">
			<button type="button"  class="btn btn-sm btn-primary" id="updateBoardBtn" >수정</button>
			<button type="button" class="btn btn-sm btn-primary" id="mainBtn">목록</button>
		</div>
</form>
</div> 
</body>
</html>