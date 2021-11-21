<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" 
integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<script src="<c:url value="/vendor/jquery/jquery.min.js"/>"></script>
<script>
$(function(){
	// 로그인
	$('#login').click(function(){
		location.href = "login.do"
	})
	
	// 회원가입 유효성 검사
	$('#uses').click(function(){
		if($('#id').val()==''){
			alert('아이디를 입력하세요.');
			$('#id').focus();
			return false;
		}
		if($('#password1').val()==''){
			alert('패스워드를 입력하세요.');
			$('#password1').focus();
			return false;
		}
		if($('#password2').val()==''){
			alert('패스워드를 입력하세요.');
			$('#password2').focus();
			return false;
		}
		if($('#name').val()==''){
			alert('이름을 입력하세요.');
			$('#name').focus();
			return false;
		} 
		if($('#email').val()==''){
			alert('이메일을 입력하세요.');
			$('#email').focus();
			return false;
		}
		if($('#address').val()==''){
			alert('주소를 입력하세요.');
			$('#address').focus();
			return false;
		}
		if($('#address2').val()==''){
			alert('상세 주소를 입력하세요.');
			$('#address2').focus();
			return false;
		}
		
		$.ajax({
			// 회원가입 경로
			url : 'createUser.do',
			type : 'post',
			dataType : 'json',
			// 사용자가 입력한 회원가입 정보
			data : $('#createUser').serializeArray(),
			success : function(data){
				// 사용 가능한 아이디면(컨트롤러에서 반환돠는 값이 true일시)회원가입 진행
				if(data == true){
					// 폼 안에 있는 회원 정보가 컨트롤러로 전송됨
					$('#createUser').submit();
					alert('회원가입이 완료 되었습니다.');
					// 로그인 창으로 보내줌
					window.location.href = "login.do";	
				// 중복된 아이디 일때(컨트롤러에서 반환되는 값이 false일시)
				}else if(data == false){
					alert('중복된 아이디로는 회원가입을 진행 할 수 없습니다.');
					// 회원가입 창으로 보내줌
					window.location.href = "createUser.jsp";
				}
			}
		})
	});
	
	// 이메일  받기
	$('#select').change(function() {
        if ($('#select').val() == 'directly') {
            $('#email').attr('disabled', false);
            $('#email').val('');
            $('#email').focus();
        } else {
            $('#email').val($('#select').val());
        }
    });	
	
	// 패스워드 일치 불일치 구문
	$('#truepassword').hide();
	$('#falsepassword').hide();
	
	//패스워드 값 확인
	$('#pwdCheck').click(function(){
		// 패스워드 유효성 검사
		if($('#password1').val()==''){
			alert('패스워드를 입력하세요.');
			$('#password1').focus();
			return false;
		}
		if($('#password2').val()==''){
			alert('패스워드를 입력하세요.');
			$('#password2').focus();
			return false;
		}
		// 사용자가 입력한 패스워드 값 
		var password1 =$('#password1').val();
		var password2 =$('#password2').val();
		
		// 사용자가 입력한 두 개의 패스워드 값 비교
		if(password1 == password2){
			// 값이 맞으면 일치 구문 출력
			$('#truepassword').show();
			$('#falsepassword').hide();
		}else{
			// 값이 틀리면 불일치 구문 출력
			$('#truepassword').hide();
			$('#falsepassword').show();
		}
	});

})
	// 아이디 중복확인
	function id_duplicate(){
		$.ajax({
			// 컨트롤러 경로
			url : 'idCheck.do',
			type : 'post',
			dateType : 'json',
			// 사용자가 입력한 아이디를 컨트롤러로 보내줌
			data : {'id' : $('#id').val()},
			// 중복된 아이디면 1 반환, 사용가능한 아이디면 0을 반환
			success : function(data){
				if(data == 1){
					alert('중복된 아이디입니다.');
				}else if(data == 0){
					alert('사용가능한 아이디입니다');
				}
			}
		})
	}
	

</script>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
</head>
<body>
<!-- 카카오 지도 API -->
<!-- 카카오에서 받은 인증키를 반드시 넣어줘야함 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c3d7f3ce0b10e40411a3b129c7539bc8&libraries=services,clusterer,drawing"></script>

<div class="container" role="main">
<h2>회원가입</h2>
<form action="createUser.do" id="createUser" method="post">

	<div class="mb-3">
		<label>아이디</label>
			<input type="text" class="form-control" name="id" id="id" placeholder="아이디을 입력해 주세요">
			<br>
			<!-- 버튼 클릭시  id_duplicate() 메서드 실행 -->
			<button type="button" class="btn btn-sm btn-primary" id="idCheck" onclick='id_duplicate();'>아이디 확인</button>
	</div>
	
	<div class="mb-3">
		<label>패스워드</label>
		<input type="password" class="form-control" name="password" id="password1" placeholder="패스워드를 입력해 주세요">
	</div>
	
	<div class="mb-3">
		<label>패스워드 재입력</label>
		<input type="password" class="form-control"  id="password2" placeholder="패스워드를 입력해 주세요">
	</div>
	
	<button type="button" class="btn btn-sm btn-primary" id="pwdCheck">패스워드 확인</button>
	<br>
	<br>
	<div class="alert alert-success" id="truepassword">패스워드가 일치합니다.</div>
	<div class="alert alert-danger" id="falsepassword">패스워드가 일치하지 않습니다. 다시 입력 해주세요.</div>
	
	<div class="mb-3">
		<label>이름</label>
		<input type="text" class="form-control" name="name" id="name" placeholder="이름를 입력해 주세요">
	</div>
	
	<div class="mb-3">
		<label>주소</label>
		<input type="text" class="form-control" name="address" id="address" placeholder="주소를 입력해 주세요"/>
	</div>
	
	<div id="map" style="width:500px;height:400px;"></div>
	
	<div class="mb-3">
		<label>상세 주소</label>
		<input type="text" class="form-control" name="address2" id="address2" placeholder="상세 주소를 입력해 주세요"/>
	</div>
	
	<div class="mb-3">			
		<label>이메일</label>
			<input type="email" class="form-control" name="email" id="email" placeholder="이메일를 입력해 주세요">
			<br>
			 <select id="select" class="form-control">
				<option value="" disabled selected>E-Mail 선택</option>
				<option value="@naver.com" id="naver.com">naver.com</option>
				<option value="@daum.net" id="hanmail.net">daum.net</option>
				<option value="@gmail.com" id="gmail.com">gmail.com</option>
				<option value="@nate.com" id="nate.com">nate.com</option>
				<option value="directly" id="textEmail">직접 입력하기</option>
			</select>
	</div>		
	<div class="mb-3">		
		<button type="button" class="btn btn-sm btn-primary" id="uses">가입하기</button>
		<button type="button" class="btn btn-sm btn-primary" id="login">로그인</button>
	</div>		


</form>
</div>
</body>
</html>

<!-- 카카오 주소 찾기 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function(){
	/*
	주소 클릭시 주소 검색
	
	// 주소 클릭시 주소 검색 팝업창
	$('#address').click(function(){
		// 카카오 주소 검색
		new daum.Postcode({
			// 사용자가 검색한 주소
			oncomplete : function(data){
				// 사용자가 검색한 주소를 주소칸에 넣어준다
				$('#address').val(data);
				// 사용자가 주소 검색을 다 끝나면 자동으로 상세 주소로 이동
				$('#address2').focus();
			}
		}).open();
	})
	*/
	
	
	
	// 주소 클릭시 주소 검색 & 지도에 해당 주소 표시
	// 지도 영역
	var divMap = document.getElementById('map')
		
		// 위도 경도 기본 설정
		mapOption = {
			// 지도의  좌표 (서울 시청을 기본으로 설정)
           center: new daum.maps.LatLng(37.5666805, 126.9784147), 
            // 지도 확대 레벨
            level: 5 
       	}; 
	   
	// 지도 영역에 실제 지도 넣기
	var map = new daum.maps.Map(divMap, mapOption);
	 // 주소 => 좌표로 변환
	var geocoder = new daum.maps.services.Geocoder();
	
	 // 지도 마커를 생성
    var marker = new daum.maps.Marker({
        map: map
    });
	
	 // 지도를 사용자가 검색하기 전에  숨기기
	  $('#map').hide();
	 
	// 주소 클릭 시 발동
	$('#address').click(function(){
	// 클릭 시 	주소 검색 팝업창  
	new daum.Postcode({
		// 사용자가 입력한 주소(실제 주소 이름,위도,경도)
		oncomplete : function(data){
			// data값 자체를 넣어주면 실제 주소와,위도,경도 여러가지 값이 넣어지기 때문에 data안에 있는 주소만 널어준다
			var address = (data.address);
			// 주소 이름을 주소에 넣어주기
			$('#address').val(address);
			// 사용자가 입력한 주소를 검색한다
			 geocoder.addressSearch(address, function(results, status){
				 // 주소 검색에 성공하면 status == ok
				 if (status == daum.maps.services.Status.OK){
					console.log(results);
					// 사용자가 검색한 주소 정보(구주소,도로명 주소, 해당 주소에 해당하는 좌표)
					 var result = results[0];
					 // 사용자가 검색한 주소의 좌표
					 var coords = new daum.maps.LatLng(result.y, result.x);
                     // 주소의 위도, 경도의 중심으로 이동한다.
                     map.setCenter(coords);
                     // 지도 마커를 좌표 중심에 설정해준다.
                     marker.setPosition(coords)
                     // 검색이 완료되면 지도를 나타내준다
                     $('#map').show();
				 }
				// 사용자가 주소 검색을 끝내면 상세 주소로 이동
				$('#address2').focus();
			 })
		}
	}).open();	
})	
	
})
</script>

