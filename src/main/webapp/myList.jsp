<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- 부트스트랩 -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" 
integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<script src="<c:url value="/vendor/jquery/jquery.min.js"/>"></script>
<script>
$(function(){
	// myList 함수 실행
	myList();
	
	// 메인 버튼 클릭 시 메인으로 이동
	$('#main').click(function(){
		location.href = "main.do"
	})
});

// myList 함수 
function myList(){
	
	// writer로 보낸 작성자가 있으면 if문 실행
	if(localStorage.getItem('writer')){
		// 작성자를 받아서 변수에 저장
		var writer = localStorage.getItem('writer')
	}
	
	$.ajax({
		// 해당 사용자가 작성한 게시글 조회
		url : 'myList.do?writer=' + writer,
		type : 'post',
		dataType : 'json',
		success : function(data){
			myList = '';
			count = '<h1>' + writer +  '님의 List' + '</h1>'
			// 작성한 게시글이 없으면
			if(data.myList.length < 1){
				myList +='<p>' + writer + '님이 작성한 게시글이 없습니다.' + '</p>';
			// 작성한 게시글이 있으면
			}else{
				// 작성 게시글 수, 작성 댓글 수 
				count +='<h6>' + '작성한 게시글 : ' + '<b>' + data.myList.length + '</b>' + '</p>'
				count +='<h6>' + '작성한 댓글 : ' + '<b>' + data.replyCount + '</b>' + '</p>'
				
				// 게시판 헤더
				myList += '<table class="table table-hover">';
				myList += '<tr>';
				myList += '<th scope="col">번호</th>';
				myList += '<th scope="col">제목</th>';
				myList += '<th scope="col">작성자</th>';
				myList += '<th scope="col">작성일</th>';
				myList += '<th scope="col">조회수</th>';
				myList += '</tr>';
				// list 길이만큼 게시글 출력
				$(data.myList).each(function(key, value){
					myList += '<tr>';
					myList += '<td>' + value.boardseq + '</td>';
					myList += '<td><a href="getBoard.do?boardseq=' + value.boardseq + '">' + value.title + '</a> </td>';
					myList += '<td>' + value.writer + '</td>';
					myList += '<td>' + value.regdate + '</td>';
					myList += '<td>' + value.boardcount + '</td>';
					myList += '</tr>';
				});
			}
		// 게시판 영역에 게시글 추가
		$('#myList').html(myList);
		// 작성자, 작성 게시글, 작성 댓글 추가
		$('#count').html(count);
		}
	})
}

</script>
<meta charset="UTF-8">
<title>작성 게시글 목록</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
</head>
<body>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
	<h3 style="color:#fff;">myList</h1>
</nav>
<div class="container" role="main">
<!-- 게시판 위 작성자,게시글 작성 수, 댓글 작성 수 -->
<div id="count">
</div>
<!-- 메인 이동 버튼 -->
<button type="button" class="btn btn-outline-primary" id="main">메인</button>
<center>

	<!-- 이 부분에 작성 게시글 목록 들어감  -->
	<div id="myList">
	</div>
</div>
</center>  
</body>
</html>
