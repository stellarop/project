<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
	$('#insertBoardBtn').click(function(){
		
		// 게시글 작성 유효성 검사
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
		
		/*
		const title = $('#title').val().trim();
		const writer = $('#writer').val().trim();
		const content = $('#content').val().trim();
		const password = $('#password').val().trim();
		const uploadFile = $('uploadFile')[0].files[0];
		*/
		
		// form 전체의 데이터를 보낼때(파일 업로드)
		var formData = new FormData($('#form')[0]);
		
		$.ajax({
			// ajax로 파일 업로드 할때 (submit으로 파일 업로드를 할 시 form에 입력)
			enctype : 'multipart/form-data',
			//=== ajax에서 파일 업로드를 할 시 필수로 입력 해야 하는 것 ===
			processData : false,
			contentType : false,
			cache: false,
			//==========================================
			// 게시글 작성 경로
			url : 'ajaxinsertBoard.do',
			// form 전체의 데이터
			data : formData,	
			//dataType : 'json',
			// @RequestBody로 데이터를 전달 받음
			//contentType : 'application/json;charset=UTF-8',
			// Body로 데이터가 전달 되지 않음 => @RequestParam, @ModelAttribute로 받아야 함
			//contentType : 'application/x-www-form-urlencoded',
			type : 'post',
			success : function(data){
				// form에 있는 데이터를 컨트롤러로 전송
				$('#form').submit();
				alert('게시글이 등록 되었습니다.');
				location.href = "main.do";
			},
			error : function(data){
				alert('게시글 등록에 실패 하였습니다.');
			}
		})
	})
});
</script>
<meta charset="UTF-8">
<title>게시글 등록</title>
</head>
<body>
<div class="container" role="main">
<h2>글 작성</h2>
<form action="ajaxinsertBoard.do" id="form" method="post" > <!--  enctype="multipart/form-data" -->
		<div class="mb-3">
			<label>제목</label>
			<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
		</div>
		
		<div class="mb-3">
			<label>작성자</label>
			<input type="text" class="form-control" name="writer" id="writer" value="${sessionScope.userId }" readonly="readonly" />
		</div>
	
		<div class="mb-3">
			<label>내용</label>
			<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요" ></textarea>
		</div>
				
		<div class="mb-3">
			<label>파일</label>
			<input type="file" class="form-control" name="uploadFile" id="uploadFile">
		</div>		
				
		<div>
			<button type="button" class="btn btn-sm btn-primary" id="insertBoardBtn">글작성</button>
			<button type="button" class="btn btn-sm btn-primary" id="mainBtn">목록</button>
		</div>	
</form>
</div>
</body>
</html>