<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/vendor/jquery/jquery.min.js"/>"></script>
<script>
$(function(){
	
	// 로그아웃
	$('#logout').click(function(){
		location.href = "logout.do"
	})
	// 회원정보수정
		$('#updateUser').click(function(){
		location.href = "updateUser.jsp"
	})
	// 회원탈퇴
		$('#deleteUser').click(function(){
		location.href = "deleteUser.jsp"
	})
	// 글작성
		$('#insertBoard').click(function(){
		location.href = "insertBoard.do"
	})
})
	/*
	// 검색 버튼 클릭
	$('#searchBtn').click(function(){
		alert('클릭됨');
		
		// 사용자가 입력한 검색어, 검색 타입
		var keyword = $('#keyword').val();
		var searchType = $('#searchType').val();
		// 사용자가 입력한 검색어, 검색타입을 각각 넣어준다
		$('#keyword').val(keyword);
		$('#searchType').val(searchType);
		
		//boardList();
	});
	*/

/*
// 게시글 리스트
function boardList(){
	
	var keyword = $('#keyword').val();
	var searchType = $('#searchType').val();
	
	
	var page = document.getElementById('page').value;
	
	$.ajax({
		// 게시글 리스트,페이징 경로
		url : 'ajaxMain.do?page=${cri.page}',
		post : 'post',
		dataType : 'json',
		success : function(data){
			data.cri.keyword += keyword
			data.cri.searchType += searchType
			
			var boardList = data.boardList;
			var cri = data.cri;
			var pageMaker = data.pageMaker;
			
			// 게시글 리스트에 들어갈 값
			boardList = '';
			// 페이징
			page = '';
			// List에 길이가 0이라면(게시글이 없다면)
			if(data.boardList.length < 0){
				// 출력
				boardList += '<P>등록된 게시글이 없습니다</p>';
			// List에 길이가 1이상이면 (등록된 게시글이 있을경우)
			}else{
				boardList += '<input type="hidden" name="page" id="page" value= ' + data.cri.page + ' />';
				// 테이블 상단
				boardList += '<table class="table table-hover">';
				boardList += '<tr>';
				boardList += '<th scope="col">번호</th>';
				boardList += '<th scope="col">제목</th>';
				boardList += '<th scope="col">작성자</th>';
				boardList += '<th scope="col">작성일</th>';
				boardList += '<th scope="col">조회수</th>';
				boardList += '</tr>';
				// List 길이만큼 반복문으로 출력
				$(data.boardList).each(function(key, value){
					boardList += '<tr>';
					boardList += '<td>' + value.boardseq + '</td>';
					boardList += '<td><a href="getBoard.do?boardseq=' + value.boardseq + '&page=' + data.cri.page +'">' + value.title + '</a> </td>';
					boardList += '<td>' + value.writer + '</td>';
					boardList += '<td>' + value.regdate + '</td>';
					boardList += '<td>' + value.boardcount + '</td>';
					boardList += '</tr>';
				});
				boardList += '</table>';
			}
			
			
			page += '<div class="paging-div">';
			page += '<ul class="pagination" display : inline-block;>';
			
			if(pageMaker.prev){
				page += '<li class="page-item><a aria-label="Previous" class="page-link" href="javascript:void(0);" onclick="boardList(' + pageMaker.startPage -1 + ');">〈</a></li>';
			}
			
			for(var pageNum = pageMaker.startPage; pageNum < pageMaker.endPage; pageNum++){
				page += '<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick="boardList('+ pageNum +');" >' + pageNum + '</a></li>';
			}
			
			if(pageMaker.next && pageMaker.endPage >0){
				page += '<li class="page-item"> <a aria-label="Previous" class="page-link" href="javascript:void(0);" onclick="boardList('+ pageMaker.endPage +1 +');"> 〉</a></li>';
			}
			
			page += '</ul>';
			page += '</div>';
			
			// boardList form에 데이터를 넣어준다
			//$('#boardList').html(boardList);
			// page form에 데이터 넣어주기
			//$('#pageMaker').html(page);

		}
	})
}
*/
</script>
<style>
.paging-div { padding: 15px 0 5px 10px; display: table; margin-left: auto; margin-right: auto; text-align: center; }
</style>
<meta charset="UTF-8">
<title>메인</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
</head>
<body>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
	<a class="navbar-brand" href="#">Board List</a>
</nav>
<div class="container" role="main">

<h1>게시글 리스트 </h1>
<p><b>${userName }</b>님으로 로그인 되었습니다.</p>
<center> 
<button type="button" class="btn btn-outline-dark" id="logout" >로그아웃</button>
<button type="button" class="btn btn-outline-primary" id="updateUser">회원정보수정</button>
<button type="button" class="btn btn-outline-danger" id="deleteUser">회원탈퇴</button>
<button type="button" class="btn btn-outline-success" id="insertBoard">글작성</button>
 
<form action="main.do" id="boardList" method="post">
<input type="hidden" name="page" id="page" value="${cri.page }" /> 

<table>
	<table class="table table-hover">
		<tr>
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">작성일</th>
			<th scope="col">조회수</th>
		</tr>
	<c:forEach items="${boardList }" var="list">
		<tr>
			<td>${list.boardseq }</td>
			<td><a href="getBoard.do?boardseq=${list.boardseq }&page=${cri.page}">${list.title }</a></td>
			<td>${list.writer }</td>
			<td>${list.regdate }</td>
			<td>${list.boardcount }</td>
		</tr>
	</c:forEach>
</table>

<select name="searchType">  
      <option value="t"<c:out value="${cri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
      <option value="c"<c:out value="${cri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
      <option value="w"<c:out value="${cri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
    </select>
    <input type="text" name="keyword" value="${cri.keyword}"/>
    <button type="submit" class="btn btn-outline-dark">검색</button>

	<div class="paging-div">
		<ul class="pagination" display : inline-block;  >
 			 <c:if test="${pageMaker.prev }">    
     			  <li class="page-item"> <a  aria-label="Previous" class="page-link" href='<c:url value="main.do?page=${pageMaker.startPage-1 }"/>'>〈</a> </li>
    		</c:if>
    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">   
         <li class="page-item"><a class="page-link" href='<c:url value="main.do?page=${pageNum }"/>'>${pageNum }</a></li>
    </c:forEach> 
    	<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
       		<li class="page-item"> <a  aria-label="Previous" class="page-link" href='<c:url value="main.do?page=${pageMaker.endPage+1 }"/>'>〉</a></li>
    	</c:if>
		</ul>
	</div>
    
</form>
</center>
</div>
</body>
</html>
