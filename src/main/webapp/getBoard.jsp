<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- 부트스트랩 -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" 
integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<script src="<c:url value="/vendor/jquery/jquery.min.js"/>"></script>
<script>
$(function(){	
	// 댓글 리스트 
	replyList();
	
	// 게시글 수정
	$('#updateBoardBtn').click(function(){
		location.href = "updateBoardView.do?"
				+"boardseq=${board.boardseq}"
				+"&page=${cri.page}"
	})
	
	// 게시글 삭제
	$('#deleteBoardBtn').click(function(){
		$.ajax({
		// 게시글 삭제 경로
		url : 'deleteBoard.do',
		type : 'post',
		// 삭제할 해당 게시글 번호
		data : {'boardseq' : $('#boardseq').val()},
		success : function(data){
			if(confirm('삭제 하시겠습니까?')){
				alert('삭제가 완료되었습니다.');
				// 메인
				location.href = "main.do?page=${cri.page}"
			}
		}
	})
});
	
	
	// 댓글 작성
	$('#insertreplyBtn').click(function(){
		if($('#replyContent').val()==''){
			alert('댓글 내용을 입력하세요.');
			$('#replyContent').focus();
			return false;
		}	
		$.ajax({
			url : 'insertReply.do',
			type : 'post',
			dataType : 'json',
			data : $('#insertReply').serializeArray(),
			success : function(data){
				alert('댓글이 등록되었습니다.');
				$('#insertReply').submit();
				location.href = "getBoard.do?boardseq=${board.boardseq}&page=${cri.page}";
			},
			error : function(data){
				alert('댓글 등록에 실패하였습니다.');
			}
		})
		
	});
	
	// 메인
	$('#mainBtn').click(function(){
		location.href = "main.do?page=${cri.page}"
	})
	
}); 

//댓글 리스트
function replyList(){
	$.ajax({
		// 해당 게시글의 댓글 리스트 
		url : 'replyList.do?boardseq=${board.boardseq}',
		type : 'post',
		dataType : 'json',
		success : function(data){
			replyList = '<h2>댓글</h2>';
			// 댓글 리스트에 길이가 0 이면 (댓글이 없으면)
			if(data.reply.length < 1){
				// 출력
				replyList += '<p>등록된 댓글이 없습니다.</p>';
			// 댓글 리스트에 길이가 1 이상이면(댓글이 등록되어 있으면)
			}else{
				// 댓글 리스트 길이만큼 댓글 출력
				$(data.reply).each(function(key, value){
					replyList += '<input type="hidden" name="boardseq" id="boardseq" value=' + value.boardseq + '>';
					replyList += '<input type="hidden" name="replyseq" id="replyseq" value=' + value.replyseq + '>';
					replyList += '<div class="mb-3">';
					replyList += '<label>' + '작성자 : ' + '<b>' + value.writer + '</b>' + '&nbsp' + '작성날짜 : ' + value.regdate + '&nbsp';
					// 로그인한 유저 아이디와 작성자가 일치하면 수정,삭제 가능
					if(data.user == value.writer){
					replyList += '<a href="updateReplyView.do?replyseq=' + value.replyseq + '">수정</a>' + '&nbsp';
					// 삭제하려는 댓글 번호를 deleteReply()함수로 보내야 한다 (List에서 댓글 삭제 시 어떤 댓글을 삭제 해주어야 할지 정해야 하기 때문에)
					replyList += '<a href="javascript:void(0);" onclick="deleteReply(' + value.replyseq + ');">삭제</a>';
					}
					replyList += '</div>';
					replyList += '<div class="mb-3">';
					// 댓글 내용
					replyList += '<label>' + value.content + '</label>';
					replyList += '</div>';
				});
			}
			// replyList form에 댓글 목록 추가
			$('#replyList').html(replyList);
		}
	});
}

//댓글 삭제
function deleteReply(replyseq){
	// onclick으로 받은 댓글 번호로 해당 댓글 삭제
	$.ajax({
		// 댓글 리스트에서 받은 해당 댓글 번호 삭제
		url : 'deleteReply.do?replyseq=' + replyseq,
		type : 'post', 
		success : function(data){	
				alert('삭제가 완료되었습니다.');
				location.href = "getBoard.do?boardseq=${board.boardseq}&page=${cri.page}";
			
		},
		error : function(data){
			alert('댓글 삭제에 실패하였습니다.');
		}
	})
}
	
//좋아요 버튼 클릭 시 like 함수 실행
function like(){
	// 게시판 번호
	var boardseq = ${board.boardseq}
	// 유저 아이디
	var id = "${userId}"
	
	$.ajax({
		url : 'Like.do',
		type : 'post',
		dataType : 'json',
		// controller로 보낼 데이터
		data : {'boardseq' : boardseq,
			'id' : id},
		success : function(data){
			// 좋아요 개수 변수 선언
			likeNum = '';
			// count 조회 후 controller에서 리턴 된 값이 1이면 좋아요
			if(data.likeCount == 1){
				alert(boardseq + '번 게시글에 좋아요를 눌렀습니다.');
				// 좋아요 버튼 클릭 시 빨간색으로 변경
				$('#likebtn').attr('class','btn btn-danger');
			// count 조회 후 controller에서 리턴 된 값이 0이면 좋아요 취소
			}else if(data.likeCount == 0){
				alert(boardseq + '번 게시글에 좋아요를 취소했습니다.');
				// 좋아요 취소 시 기존 버튼 색상으로 변경
				$('#likebtn').attr('class','btn btn-outline-primary');
			}
			// 좋아요 개수 넣기
			likeNum +='<p>' + boardseq + '번 게시글의 좋아요 수 : ' + data.likeNum + '</p>';
			// 좋아요 개수 likeNum 영역에 표시함
			$('#likeNum').html(likeNum);
		},
		error : function(data){
			alert('실패.');	
		}
		
	})
}
</script>
<meta charset="UTF-8"> 
<title>글 상세 보기</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
</head>
<body>
<div class="container" role="main">
<h1>글 상세</h1>
<p>작성일 : <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate }"/></p>
<!-- 추천 / 반대 개수 -->
<form id="count" method="post">

</form>
<!-- 글 상세보기 -->
<form action="getBoard.do" name="getBoard" id="" method="post">
<!-- 게시판 글 상세보기  -->
<input type="hidden" name="boardseq" id="boardseq" value="${board.boardseq }" />
<input type="hidden" name="page" id="page" value="${cri.page }" page = "${cri.page }" />
<br>
<!-- 좋아요 개수 위치 -->
<div id="likeNum">
</div>
<button type="button" class="btn btn-outline-primary" id="mainBtn">메인</button>

<!-- 좋아요 버튼 -->
<button type="button" class="btn btn-outline-primary" id="likebtn" onclick="like();">좋아요</button>
<!-- 세션으로 로그인된 아이디와 작성자와 일치하면 수정,삭제  -->
<c:if test="${sessionScope.userId == board.writer }">
	<button type="button" class="btn btn-outline-primary" id="updateBoardBtn" boardseq = "${board.boardseq }">게시글 수정</button>
	<button type="button" class="btn btn-outline-danger" id="deleteBoardBtn" boardseq = "${board.boardseq }">게시글 삭제</button>
</c:if>

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
		
</form>

<!-- 댓글 리스트  -->
<form name="replyList" id="replyList" method="post">

</form>

<!-- 댓글 작성 -->
<form name="insertreply" id="insertReply" method="post"> 
<input type="hidden" name="boardseq" value="${board.boardseq }" />
<input type="hidden" name="page" id="page" value="${cri.page }" page = "${cri.page }" />

	<div class="mb-3">
		<label>댓글 작성자</label>
		<input type="text" class="form-control" name="writer" id="writer" value="${sessionScope.userId }" readonly="readonly" />
	</div>
	<div class="mb-3">
		<label>댓글 내용</label>
		<textarea class="form-control" rows="5" id="replyContent" name="content" placeholder="댓글을 작성 해주세요."></textarea>
	</div>
	<div class="mb-3">
		<button type="button" class="btn btn-sm btn-primary" id="insertreplyBtn">댓글작성</button>
	</div>

</form>

</div>
</body>
</html>
