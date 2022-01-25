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
// myList 함수
// 작성자 클릭 시 실행 / 매개변수로 작성자 받아줌
function myList(writer){
	// myList.jsp로 보낼 작성자 값
	localStorage.setItem('writer',writer);
	// myList.jsp로 이동
	location.href = "myList.jsp"
}


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
			<td><a href="javascript:void(0);" onclick="myList('${list.writer}');" vaule="${list.writer }">${list.writer }</a></td>
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
