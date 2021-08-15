<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" 
integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<script src="<c:url value="/vendor/jquery/jquery.min.js"/>"></script>
<script>
$(function(){	
	
	// 게시글 수정
	$('#updateBoardBtn').click(function(){
		location.href = "updateBoardView.do?boardseq=${board.boardseq}&page=${cri.page}"
	})
	
	// 게시글 삭제
	$('#deleteBoardBtn').click(function(){
		location.href = "deleteBoardView.do?boardseq=${board.boardseq}&page=${cri.page}"
	});
	
	// 게시글 추천 
	$('#upCountBoardBtn').click(function(){
		//var form = $("form[name='getBoard']");
		//form.attr("action", "upCountBoard.do");
		//form.submit();
		alert('${board.boardseq}번 게시글이 추천되었습니다.');
	});
	
	// 게시글 반대
	$('#downCountBoardBtn').click(function(){
		//var form = $("form[name='getBoard']");
		//form.attr("action", "downCountBoard.do");
		//form.submit();
		alert('${board.boardseq}번 게시글이 반대되었습니다.');
	});
	
	// 댓글 작성
	$('#insertreplyBtn').click(function(){
		
		if($('#replyWriter').val()==''){
			alert('작성자를 입력하세요.');
			$('#replyWriter').focus();
			return false;
		} 
		if($('#replyContent').val()==''){
			alert('내용을 입력하세요.');
			$('#content').focus();
			return false;
		}	
		if($('#replyPassword').val()==''){
			alert('암호을 입력하세요.');
			$('#replyPassword').focus();
			return false;
		}
		
		var form = $("form[name='insertreply']");
		form.attr('action', 'insertReply.do');
		form.submit(); 
		alert('댓글이 등록되었습니다.'); 
		
	});
	
	/*
	댓글 수정
	$('#updatereplyBtn').click(function(){
		location.href = "updateReplyView.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=" + $(this).attr("updateReply")
	});
	
	 댓글 삭제
	$('#deletereplyBtn').click(function(){
		//location.href = "deleteReplyView.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=" + $(this).attr("deleteReply")
	});
	
	 */
	 
	// 댓글 추천
	$('#upCountReplyBtn').click(function(){
		//location.href = "upCountReply.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=" + $(this).attr("upcount")
		alert('댓글이 추천되었습니다.');
	});
	
	// 댓글 반대
	$('#downCountReplyBtn').click(function(){
		//location.href = "downCountReply.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=" + $(this).attr("downcount")
		alert('댓글이 반대되었습니다.');
	});
	
	// 메인
	$('#mainBtn').click(function(){
		location.href = "main.do?page=${cri.page}"
	});
	
	
}); 
</script>
<meta charset="UTF-8"> 
<title>글 상세 보기</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
</head>
<body>
<div class="container" role="main">  
<h1>글 상세</h1>
<p>추천수 ${board.count }
<!-- 게시글 추천 -->
<a id="upCountBoardBtn" href="upCountBoard.do?boardseq=${board.boardseq}&page=${cri.page}">👍</a>
<!-- 게시글 반대 -->
&nbsp;<a id="downCountBoardBtn" href="downCountBoard.do?boardseq=${board.boardseq}&page=${cri.page}">👎</a></p>  

<!-- 글 상세보기 -->
<form action="getBoard.do" name="getBoard" method="post">
<!-- 게시판 글 상세보기  -->
<input type="hidden" name="boardseq" value="${board.boardseq }" />
<input type="hidden" name="page" id="page" value="${cri.page }" page = "${cri.page }" />
<input type="hidden" name="password" id="password" value="${board.password }" />

<button type="button" class="btn btn-outline-primary" id="mainBtn">메인</button>
<button type="button" class="btn btn-outline-primary" id="updateBoardBtn" boardseq = "${board.boardseq }">게시글 수정</button>
<button type="button" class="btn btn-outline-danger" id="deleteBoardBtn" boardseq = "${board.boardseq }">게시글 삭제</button>
		<div class="mb-3">
			<label>제목</label>
			<input type="text" class="form-control" readonly="readonly" value="${board.title }">
		</div>
		<div class="mb-3">
			<label>작성자</label>
			<input type="text" class="form-control" readonly="readonly" value="${board.writer }">
		</div>
		<div class="mb-3">
			<label>글 내용</label>
			<textarea class="form-control" rows="5" readonly="readonly">${board.content }</textarea>
		</div>
		<div class="mb-3">
			<img width=1110px, height=600px src="/img/${board.filename }"  onerror="this.style.display='none';"/>
		</div>
		<div class="mb-3">
			<label>작성날짜</label>
			<input type="text" class="form-control" readonly="readonly" value="${board.regdate }">
		</div>
</form>

<!-- 댓글 리스트  -->
<form name="replyList" method="post">
<h2>댓글</h2>
<table>
<c:forEach items ="${replyList }" var ="reply">
<input type="hidden" name="boardseq" value="${reply.boardseq }" />
<input type="hidden" name="replyseq" value="${reply.replyseq}" />
<input type="hidden" name="page" id="page" value="${cri.page }" page="${cri.page }" />
	<div class="mb-3">
		<label>${reply.writer } ${reply.regdate } 추천수 ${reply.count }
		<a href="upCountReply.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=${reply.replyseq}"  id="upCountReplyBtn" >👍</a>
		<a href="downCountReply.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=${reply.replyseq}"  id="downCountReplyBtn" >👎</a>
		<a href="updateReplyView.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=${reply.replyseq}">수정</a>
		<a href="deleteReplyView.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=${reply.replyseq}">삭제</a>
		</label>
	</div>
	<div class="mb-3">
		<label>${reply.content }</label>
	</div>
</c:forEach>
</table>
</form>

<!-- 댓글 작성 -->
<form name="insertreply" method="post"> 
<input type="hidden" name="boardseq" value="${board.boardseq }" />
<input type="hidden" name="page" id="page" value="${cri.page }" page = "${cri.page }" />

	
		
	<div class="mb-3">
		<label>댓글 작성자</label>
		<input type="text" class="form-control" id="replyWriter" name="writer" placeholder="작성자를 입력해 주세요">
	</div>
	<div class="mb-3">
		<label>댓글 내용</label>
		<input type="text" class="form-control" id="replyContent" name="content" placeholder="내용을 입력해 주세요">
	</div>
	<div class="mb-3">
		<label>암호</label>
		<input type="password" class="form-control" id="replyPassword" name="password" placeholder="암호를 입력해 주세요">
	</div>
	<div class="mb-3">
		<button type="button" class="btn btn-sm btn-primary" id="insertreplyBtn">댓글작성</button>
	</div>

</form>

</div>
</body>
</html>