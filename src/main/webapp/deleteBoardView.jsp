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
			location.href = "main.do?boardseq=${deleteBoard.boardseq}&page=${cri.page}"
		});
		
		$('#deleteBoardBtn').click(function(){
			if($('#password').val()==''){
				alert('암호를 입력하세요.');
				$('#password').focus();
				return false;
			}
			
			$.ajax({
				url : 'boardPwdCheck.do',
				type : 'post',
				datetype : 'json',
				data : $('#deleteBoard').serializeArray(),
				success : function(date){
					if(date == 0){
						alert('암호가 일치하지 않습니다.');
						return;
					}else{
						if(confirm('삭제하시겠습니까?')){
							$('#deleteBoard').submit();
							alert('게시글이 삭제되었습니다.');
						}
					}
				}
			})
		})
	});
</script>
<meta charset="UTF-8">
<title>글 삭제 암호</title>
</head>
<body>
<div class="container" role="main">
<h2>글 삭제</h2>
<form action="deleteBoard.do" id="deleteBoard" method="post">
	<input type="hidden" name="boardseq" value="${deleteBoard.boardseq }"/>
	<input type="hidden" name="page" value="${cri.page }" />
	
		<div class="mb-3">
			<label>암호</label>
			<input type="password" class="form-control" name="password" id="password" placeholder="암호를 입력해주세요" />
		</div>
		
		<div class="mb-3">
			<button type="button"  class="btn btn-sm btn-primary" id="deleteBoardBtn">확인</button>
			<button type="button"  class="btn btn-sm btn-primary" id="mainBtn">목록</button>
		</div>
</div>
</form>
</body>
</html>