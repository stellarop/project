<div align=center><h1> 댓글 게시판 프로그램 - 개인 프로젝트</h1></div>

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fstellarop%2Fhit-counter&count_bg=%2379C83D&title_bg=%23555555&icon=litecoin.svg&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

안녕하세요 웹 개발자를 지망하는 이연재 입니다.
제 포트폴리오를 보러 와주셔서 감사드립니다.
제가 만든 포트폴리오는 게시판 기반 포트폴리오 입니다.
게시판 기반 포트폴리오를 만든 이유는 모든 기능이 CRUD 응용이라는 점과
기본 소양이 게시판이라고 생각하기 때문입니다.
게시판 기반 포트폴리오를 제작해보면서 기본기에 충실하고 싶었기 때문에 게시판 기반 포트폴리오를 제작하게 되었습니다.

포트폴리오 소개는 기능 별로 묶어서 설명 드리려고 합니다.

그럼 지금부터 포트폴리오 소개를 시작 하겠습니다.



<div align=center><h2>개발환경</h2></div>

|  <center>개발 환경 분류</center> |  <center>사용 기술</center> |  <center>비고</center> |
|:--------|:--------:|--------:|
|**Develop Tools** | <center> Eclipse v4.12.0  &nbsp; MySQLWorkbench v8.0  </center> |*-* |
|**Develop Language For Front end** | <center> HTML5  &nbsp;  JSP &nbsp;   JavaScript  &nbsp;  jQuery v3.6.0  &nbsp;  Bootstrap v4.0.0 </center> |*-* |
|**Develop Language For Back end** | <center> Java v1.8  &nbsp;  Spring Framework v4.2.4 &nbsp; Mybatis 3.4.1 </center> |*-* |
|**Data Base** | <center> MySQL 8.0 </center> |*-* |
|**Server** | <center> Apache Tomcat v8.0 </center> |*Tomcat v9.0 버전도 사용함* |
|**Web** | <center> Chrome v95.0.4638.5  &nbsp;  Microsoft Edge v95.0.1020.30 </center> |*-* |

<div align=center><h2>프로젝트 구조</h2>

![프로젝트 구조 1](https://user-images.githubusercontent.com/93149034/141842473-dfb7e5a8-3a50-4974-ab9f-d127a4e72fb3.png)
![프로젝트 구조 2](https://user-images.githubusercontent.com/93149034/141842482-91fcb060-d039-4e9e-a45e-2d2f5e4ebae7.png)
</div>
<div align=center><h2>ERD</h2>

![ERD](https://user-images.githubusercontent.com/93149034/142772745-51282138-525b-4923-82ba-a52faea23958.png)
</div>

<div align=center><h2>로그인 기능</h2>

로그인 기능에선 유효성 검사와 아이디나 패스워드가 일치하지 않을시
아이디,패스워드 불일치 구문을 출력해주게 구현하였습니다.

![로그인 gif](https://user-images.githubusercontent.com/88939199/135759759-6b8f1df1-0c5a-41c2-8610-9b3db077dc4b.gif)	
</div>


```JavaScript
$(function(){
   $('#login').click(function(){
      
      if($('#id').val()==''){
         alert('아이디를 입력해주세요.');
         $('#id').focus();
         return false;
      }
      
      if($('#password').val()==''){
         alert('패스워드를 입력해주세요.')
         $('#password').focus();
         return false;
      }
      
   $.ajax({
         //컨트롤러 경로
         url : 'login.do',
         type : 'post',
         dateType : 'json',
         // 사용자가 입력한 아이디, 패스워드
         data : {'id' : $('#id').val(),
         'password' : $('#password').val()},
         success : function(data){
            // 컨트롤러에서 가져온 값이 true 일시
            if(data == true){
               alert('로그인 성공');
               // 메인 페이지로 이동
               window.location.href = "main.do";
            // 컨트롤러에서 가져온 값이 false 일시
            }else if(data == false){
               alert('로그인 실패')
               // 로그인 페이지로 이동
               window.location.href = "login.jsp";
            }
         }
      })
   });
```

로그인 페이지에선 아이디,패스워드 유효성 검사와 사용자가 아이디, 패스워드를 입력 후 로그인 버튼을 누를 시 
사용자가 입력한 아이디, 패스워드 값이 서버로 전송됩니다.

```Java
// 로그인
@ResponseBody
@RequestMapping(value = "/login.do", method = RequestMethod.POST)
public boolean login(@ModelAttribute("user") UserVO vo, HttpSession session) {
   
   // 사용자가 입력한 아이디 패스워드 == 유저 테이블에 저장된 사용자 아이디, 패스워드 값 대조 
   UserVO user = userservice.login(vo);
      // 두 값이 일치하지 않다면 true
      if(user != null) {
         session.setAttribute("userId", user.getId());
         session.setAttribute("userName", user.getName());
	 session.setAttribute("userPassword", user.getPassword()); 
         return true;
      }else {
         // 로그인 실패 구문을 띄우기위해 false 지정
         session.setAttribute("login", false);
         return false;
      }    
   }
```


로그인 페이지에서 사용자가 입력한 아이디,패스워드 값이 컨트롤러로 전송되면
 UserVO user = userservice.login(vo);
사용자가 입력한 아이디,패스워드의 값과 DB에 있는 아이디, 패스워드 값과 비교합니다.

두 값이 일치하면 로그인 페이지에 true를 반환하고 일치하지 않다면 false를 반환합니다.

success에 true를 controller에서 리턴 받으면 로그인에 성공 = 게시판 메인 페이지로 이동합니다.

success에 false controller에서 리턴 받으면 로그인에 실패 = 로그인 페이지로 돌아온 후 로그인 실패 구문을 출력 해줍니다.

session.setAttribute에 사용자에 아이디와 이름을 저장한것은 추후 아이디 찾기, 패스워드 찾기, 회원탈퇴,
작성자를 사용자 아이디로 사용하는것도 있지만
수정, 삭제 처리 시 본인이 작성한 게시글과 댓글을 수정, 삭제 처리하기 때문입니다.

session.setAttribute로 false를 로그인 페이지에 보내주는것은 로그인 실패시 로그인페이지 아래에 로그인 실패 구문을 나타내주기 때문입니다.
alert으로 로그인 실패를 알려줘도 되지만 확실하게 로그인 페이지 아래에 구문으로 알려주는게 좋다고 판단되어 넣은 기능입니다.



<div align=center><h2>회원가입 기능</h2>
	
	
회원가입은 기본적인 사용자 정보(아이디, 패스워드, 이름, 이메일, 주소, 상세주소)로 가입이 이루어지며 ajax를 이용한 아이디 체크
중복된 아이디로 회원가입을 진행할 시 controller에서 중복된 아이디인지 확인한 후 중복된 아이디면 회원가입을 진행하지 못하게 막아두었습니다.(추후 작성자로 사용자의 아이디를 넣기 위함입니다.)

사용자가 주소창 클릭 시 주소 검색 api를 활용하여 편리하게 주소 검색을 할수있게 구현하였고 검색한 주소의 좌표를 이용하여 사용자가 입력한 주소를 지도로 나타내주는 지도 api도 활용 해보았습니다.

![회원가입 gif](https://user-images.githubusercontent.com/93149034/143124175-06900ea5-12e3-4319-8497-841376d830ea.gif)
	


</div>

```JavaScript
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
            if(confirm('회원가입 하시겠습니까?')){
               // 폼 안에 있는 회원 정보가 컨트롤러로 전송됨
               $('#createUser').submit();
               alert('회원가입이 완료 되었습니다.');
               // 로그인 창으로 보내줌
               window.location.href = "login.do";
            }
         // 중복된 아이디 일때(컨트롤러에서 반환되는 값이 false일시)
         }else if(data == false){
            alert('중복된 아이디로는 회원가입을 진행 할 수 없습니다.');
            // 회원가입 창으로 보내줌
            window.location.href = "createUser.jsp";
         }
      }
   })      
```

사용자가 입력한 회원가입 데이터(form 태그 내부의 값)를 배열(name,key)로 controller에 보내줍니다.

이때 사용자가 입력한 아이디가 중복된 아이디라면 controller에서 중복된 아이디인지 확인한 후

중복된 아이디라면 회원가입을 못하게 막아두고

사용 가능한 아이디면 정상적으로 회원가입을 진행시키도록 구현하였습니다.

	

```Java
// 회원가입
@ResponseBody
@RequestMapping(value = "/createUser.do", method = RequestMethod.POST)
public boolean createUser(UserVO vo) {
   
   // 아이디 중복 체크
   int result = userservice.idCheck(vo);
   
   // 중복된 아이디 인지 확인
   if(result == 1) {
      // 중복된 아이디면 false 반환
      return false;
   // 사용 가능한 아이디 일시  회원가입 진행
   }else if(result == 0) {
      userservice.createUser(vo);
   }
   // 사용 가능한 아이디 일시 true 반환
   return true;
}
```	

사용자가 입력한 회원가입 데이터가 들어오는 controller 입니다.

아이디 중복 체크는 (select count(*) from users where id ="아이디") 사용자가 입력한 아이디를 DB에서 확인한 후

중복된 아이디면 =1 사용 가능한 아이디면 =0 의 값을 가지고 오게 됩니다.

중복된 아이디면 해당 ajax 로직으로 false를 리턴 후 중복된 아이디로 회원가입 진행이 안된다고 alert으로 알려주고

사용 가능한 아이디면 true 리턴과 함께 회원가입을 정상적으로 진행 시켜줍니다.
	

```Java
// 아이디 체크
@ResponseBody
@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
public int idCheck(UserVO vo) {
   int result = userservice.idCheck(vo);
   return result;
}
```

```JavaScript
// 아이디 중복확인
function id_duplicate(){
   $.ajax({
      // 컨트롤러 경로
      url : 'idCheck.do',
      type : 'post',
      dateType : 'json',
      // 사용자가 입력한 아이디를 컨트롤러로 보내줌
      data : {'id' : $('#id').val()},
      // 중복된 아이디면 1, 사용 가능한 아이디면 0
      success : function(data){
         if(data == 1){
            alert('중복된 아이디입니다.');
         }else if(data == 0){
            alert('사용가능한 아이디입니다');
         }
      }
   })
}
```

사용자가 아이디를 입력 후 아이디 확인 버튼을 클릭하면 (onclick='id_duplicate();')  id_duplicate(); 함수가 실행됩니다.

이때 사용자가 입력한 아이디를 아이디 체크 controller로 보내준 후 입력한 아이디와 DB에 있는 아이디를 조회한 후 

사용자가 입력한 아이디 == DB에 있는 아이디 = 1
중복된 아이디면 1를 해당 ajax 로직에 리턴 시켜주고

사용자가 입력한 아이디 != DB에 있는 아이디 = 0
사용 가능한 아이디면 0을 해당 ajax 로직에 리턴 시켜줍니다.


```
<!-- 카카오 주소 찾기 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
```

```
<!-- 카카오 지도 API -->
<!-- 카카오에서 받은 인증키를 반드시 넣어줘야함 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=여기에 인증키가 들어갑니다.&libraries=services,clusterer,drawing"></script>
```


사용자가 주소 입력을 어떻게 하면 사용자가 간편하게 자신의 주소를 검색할수 있을까 고민하던중 주소를 검색해주는 api를 활용하게 되었습니다.

더 나아가서 사용자가 검색한 주소를 지도로 나타내주는 기능도 지도api를 이용해서 활용하게 되었습니다.
 
 
주소 검색 같은 경우 api 호출만 해주면 되지만 지도는 개발자 등록과 사이트 도메인 등록, 스크립트 경로에 카카오에서 발급받은 api 인증키를 넣어주고 사용자가 입력한 주소를 좌표로 변환하여
지도로 나타내주어야 하기 때문에 스크립트 경로에 지도 라이브러리도 같이 추가 해주었습니다.


```JavaScript
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
	
	 // 지도 마커 생성
    	var marker = new daum.maps.Marker({
        map: map
    });
	
	 // 사용자가 검색하기 전 지도 숨기기
	  $('#map').hide();
```

지도는 미리 만들어준 후 사용자가 주소 검색을 하면 사용자가 검색한 주소 좌표를 지도에 나타내주는 형식으로 구현하였습니다.

우선 지도의 영역을 만들어 주고 지도의 영역에 기본으로 설정한 지도의 자표, 지도 영역에 실제 지도를 넣어주었습니다.

사용자가 주소 검색에 성공할 시 사용자가 검색한 주소의 자표를 지도로 변환하는 geocoder,

지도 중심에 마커를 생성하는 marker를 선언해주고 사용자가 주소 검색을 하기전에 $('#map').hide(); 으로 지도를 숨겨주었습니다.


![주소검색 gif](https://user-images.githubusercontent.com/93149034/143127339-1a6a7ebb-7513-4120-a651-a23246693fa0.gif)

사용자가 주소 입력 칸을 클릭하면 나오는 주소 검색 팝업창 입니다. 

사용자가 주소 검색에 성공하고 지도로 그 주소를 변환하여 나타내주는 코드는 아래에서 설명드리겠습니다.

```JavaScript
	// 주소 입력 칸 클릭 시 발동
	$('#address').click(function(){
	// 주소 검색 팝업창  
	new daum.Postcode({
		// 사용자가 입력한 주소(실제 주소 이름,위도,경도)
		oncomplete : function(data){
		// data값 자체를 넣어주면 실제 주소와,위도,경도 여러가지 값이 넣어지기 때문에 data안에 있는 실제 주소 이름만 넣어준다
		var address = (data.address);
		// 주소 입력 칸에 사용자가 검색한 실제 주소 이름 넣어주기
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
 ```

사용자가 주소 입력 칸을 클릭 시 주소 검색 팝업창이 나오게 됩니다.

사용자가 주소 검색을 완료하면 주소 입력 칸에 사용자가 검색한 주소를 넣어주고 위에서 선언한 geocoder,marker는 이떄 쓰이게 됩니다.

 geocoder.addressSearch(address, function(results, status) 주소의 이름과, 해당 주소의 좌표를 넣어줍니다.
 
 if (status == daum.maps.services.Status.OK)  

주소 검색에 성공하면 var result = results[0]; 사용자가 검색한 주소 정보만 따로 변수에 담아주고 

var coords = new daum.maps.LatLng(result.y, result.x); 검색한 주소를 지도로 나타내주기 위해 따로 주소의 좌표값을 넣어주었습니다.

 map.setCenter(coords); 좌표값을 받은 변수를 넣어주고 지도 중심으로 이동하고 marker.setPosition(coords) 좌표의 중심에 마커를 생성 해줍니다.
 
$('#map').show(); 사용자가 검색하기전 숨긴 지도 영역을 나타내주고 마지막으로 $('#address2').focus(); 상세 주소 칸으로 자동으로 이동하게 됩니다.
 
 

<div align=center><h2>아이디 찾기 기능</h2>

아이디 찾기 기능은 사용자가 회원가입시 입력한 이메일로 찾게 구현하였습니다.

입력한 이메일이 맞다면 아이디를 출력해주고 입력한 이메일이 아니라면 해당 이메일로 등록된 회원정보가 없다고 알려주는 형식입니다.

![아이디 찾기 gif](https://user-images.githubusercontent.com/93149034/141844299-a3aceb27-142f-4869-a329-df8e24c0888c.gif)
</div>


```JavaScript
$(function(){

      $.ajax({
         // 아이디 찾기 경로 
         url : 'findId.do',
         type : 'post',
         dataType : 'json',
         // 사용자가 입력한 이메일 값
         data : {'email' : $('#email').val()},
         success : function(data){
            // 조회 되는 이메일 일시
            if(data == 0){
               // 기존 페이지로 보내주고 아이디 구문 나타내줌
               window.location.href = "findId.jsp";
            // 없는 이메일 이면 alert으로 알려주고 기존 페이지로
            }else if(data == 1){
               alert('사용자의 이메일로 등록된 아이디가 없습니다.');
               window.location.href = "findId.jsp";
            }
         }
      })     
});
```

== 설명 들어가야 함 ==
```Java
// 아이디 찾기
@ResponseBody
@RequestMapping(value = "/findId.do", method = RequestMethod.POST)
public int findId(@ModelAttribute("user") UserVO vo, HttpSession session) {

   UserVO id = userservice.findId(vo);
   
   if (id != null) {
      // 사용자 이름과 아이디를 보내줌
      session.setAttribute("userName", id.getName());
      session.setAttribute("userId", id.getId());
      // 일치 하면 구문 출력
      session.setAttribute("getId", true);
      return 0;
   } else {
      return 1;
   }
} 
```

사용자가 이메일을 입력하고 찾기 버튼을 누르게 되면 사용자가 입력한 이메일이 controller로 이동합니다.

 UserVO id = userservice.findId(vo); 사용자가 입력한 이메일과 쿼리문(select * from users where email="이메일")으로 DB에서 조회를 합니다.
 
 두 값을 비교한 변수 if(id != null)로 사용자가 입력한 이메일과 DB에서 조회한 이메일이 일치하다면 아이디 찾기 페이지로 보내준 후 
 
 session.setAttribute으로 해당 이메일로 조회되는 사용자의 이름과, 패스워드를 저장합니다. (아이디 찾기 페이지에서 사용자의 이름과 아이디를 나타내주어야 하기 때문입니다)
 session.setAttribute("getId", true);로 사용자가 입력한 이메일과 DB에서 조회한 이메일이 일치하다면 ("getId", true)를 저장합니다 (getId 값으로 이메일이 맞다면
 사용자의 이름과,아이디를 출력해주기 때문입니다.)
 
 ```
 <c:if test="${getId == true}">
	<div class="alert alert-primary">${userName }님의 아이디는 <b>${userId }</b>입니다.</div>
 </c:if>
```
 
그 후 일치하면 = 0 불일치하면 = 1을 해당 ajax로직에 리턴시켜주고

0이 리턴되면 사용자의 이름과 아이디를 출력해주고 1이 리턴된다면 alert('사용자의 이메일로 등록된 아이디가 없습니다.');

등록된 이메일이 없다고 알려준 후 아이디 찾기 페이지로 넘어가게 됩니다.


패스워드 찾기 기능도 위와 같은 형식으로 구현하여서 패스워드 찾기 기능은 생략하겠습니다.


<div align=center><h2>회원탈퇴 기능</h2>

회원탈퇴 기능은 사용자의 아이디와 패스워드가 일치하면 탈퇴되게 처리하였고

패스워드 확인시 0과1을 반환받는 ajax로 처리하였습니다.

![회원탈퇴 gif](https://user-images.githubusercontent.com/88939199/136686776-660fa240-fb91-4aa3-ae36-1f1977df6af2.gif)
</div>

```Java
// 패스워드 체크
@ResponseBody
@RequestMapping(value = "/passwordCheck.do", method = RequestMethod.POST)
public int passwordCheck(UserVO vo) {
	int result = userservice.passwordCheck(vo);
	return result;
}
```

```JavaScript
      $.ajax({
         // 회원탈퇴 경로
         url : 'passwordCheck.do',
         type : 'post',
         dataType : 'json',
         // 폼 안에 있는 데이터 (사용자가 입력한 패스워드 값)
         data : $('#deleteUser').serializeArray(),
         success : function(data){
            // 패스워드가 맞으면 = 1 맞지 않다면 0
            if(data == 1){
               if(confirm('회원 탈퇴 하시겠습니까?')){
               // 사용자가 입력한 패스워드가 컨트롤러로 전송
               $('#deleteUser').submit();
               alert('탈퇴가 완료되었습니다.');
               }
            }else if(data == 0){
               alert('패스워드가 일치하지 않습니다.');
            }
         }
      })   
```

로그인에서 session.setAttribute로 저장시킨 사용자 아이디, 이름을 회원탈퇴 form에 나타내주고

사용자가 패스워드를 입력하면 ajax를 통해 DB에서 조회를 합니다.

패스워드 체크 쿼리문은(select count(*) from users where id="아이디" and password="패스워드")로 작성하였습니다.

아이디와 패스워드가 일치한다면 = 1 을 리턴 후 사용자 아이디, 이름, 패스워드가 controller로 이동하고

일치하지 않는다면 = 0 "패스워드가 일치하지 않습니다" 를 알려주는 형식으로 구현하였습니다.


```Java
// 회원탈퇴 
@RequestMapping(value = "/deleteUser.do", method = RequestMethod.POST)
public String deleteUser(UserVO vo, HttpSession session) {

   // 세션에 있는 패스워드
   String sessionPwd = (String) session.getAttribute("userPassword");
   // 사용자가 입력한 패스워드 
   String voPwd = vo.getPassword();
   
   // 두 값을 비교 후 일치하면 삭제, 세션을 끊어줌
   if (sessionPwd.equals(voPwd)) {
      userservice.deleteUser(vo);
      session.invalidate();
      return "login.jsp";
   }else {
      return "deleteUser.jsp";
   }      
}
```

회원탈퇴 데이터가 정상적으로 controller로 이동하게 되면 로그인시 저장한 패스워드를 

session.getAttribute("userPassword")로 가져옵니다

그 후 사용자가 입력한 패스워드와 세션에 있는 패스워드를 equals(문자열 비교) 를 하여 두 패스워드의 값이 맞으면 정상적으로 회원탈퇴 처리와
session.invalidate(); 세션을 끊어준 후 로그인 페이지로 이동 시켜주고

두 패스워드의 값이 일치하지 않는다면 회원탈퇴 페이지로 이동시켜 주는 형식으로 구현하였습니다.


<div align=center><h2>게시글 작성 기능</h2>

![글 작성 테스트 gif](https://user-images.githubusercontent.com/93149034/143153447-d8e43a2c-08d6-4ed1-8815-674bd790ad3c.gif)
</div>

```JavaScript
// form 전체의 데이터를 보낼때(파일 업로드)
var formData = new FormData($('#insertBoard')[0]);
		
$.ajax({
	// 게시글 작성 경로
	url : 'ajaxinsertBoard.do',
	enctype : 'multipart/form-data',
	//=== ajax에서 파일 업로드를 할 시 필수로 입력 해야 하는 것 ===
	// false로 선언 시 formData를 string으로 변환하지 않음
	processData : false,
	// false 로 선언 시 content-type 헤더가 multipart/form-data로 전송되게 함
	contentType : false,
	cache: false,
	//==========================================
	data : formData,
	dataType : 'json',
	//async: false,
	type : 'post',
	success : function(data){
	alert('게시글이 등록 되었습니다.');
		$('#insertBoard').submit();
		location.href = "main.do";
	},
	error : function(data){
		console.log(data);
		alert('게시글 등록에 실패 하였습니다.');
	}
})
```

게시글 작성 기능은 ajax로 이미지 등록까지 해주기 위하여 FromData을 활용해서 구현하였습니다.

var formData = new FormData($('#insertBoard')[0]); ajax로 form 전체의 데이터를 보내기 위해 FormData 객체를 생성,

게시글 작성 폼(insertBoard)을 FormData 객체 안에 넣어주었습니다.

ajax로 파일 업로드 시 필수로 설정 해야하는 사항 2가지가 있는데 processData, contentType를 false로 선언해야 한다는 점입니다.

processData는 서버에 전달되는 데이터는 쿼리 스트링 형식으로 전송 됩니다.

파일 전송에 경우 쿼리 스트링 형식으로 전송하지 않아서 processData를 false로 선언

contentType은 디폴트 값이 application/x-www-form-urlencoded; 입니다.

파일 전송 시 multipart/form-data 로 전송 해주어야 하기 때문에 contentType를 false로 선언해주었습니다.


```Java
// 게시글 작성 
@ResponseBody
@RequestMapping(value = "/ajaxinsertBoard.do", method = RequestMethod.POST)
public Map<String, Object> insertBoard(BoardVO vo, HttpSession session) throws IOException{
	Map<String, Object> result = new HashMap<String, Object>();
	// 로그인 한 유저 아이디 getAttribute로 가져오기
	String user = (String)session.getAttribute("userId");
	
	// vo에 있는 UploadFile을 파일 형식으로 변경
	MultipartFile uploadFile = vo.getUploadFile();
	// 업로드하는 파일의 실제 이름를 반환
	String fileName = uploadFile.getOriginalFilename();
	
	// 업로드한 파일의 존재여부
	if(!uploadFile.isEmpty()) {
		String originalFilename = uploadFile.getOriginalFilename();
		// 업로드한 파일을 C:\\Project 파일 업로드 에 저장
		uploadFile.transferTo(new File("C:\\Project 파일 업로드\\" + fileName));
	}	
	// 파일 이름을 데이터베이스에 저장
	vo.setFilename(fileName);
	// 게시글 작성자에 유저 아이디 저장
	vo.setWriter(user);
	result.put("fileName", fileName);
	//게시글 작성
	result.put("insertBoard", boardservice.insertBoard(vo));
	return result;
}
```

게시글 작성자를 유저에 아이디로 저장하기 위해 String user = (String)session.getAttribute("userId") 로그인 시 저장한 유저 아이디를 가져옵니다.

MultipartFile uploadFile = vo.getUploadFile() VO 칼럼에 있는 uploadFile 칼럼을 파일 형식으로 변경 후 

String fileName = uploadFile.getOriginalFilename() 업로드 하려는 파일에 이름을 구하기 위해서 fileName 변수에 파일 이름을 넣어주고 

if(!uploadFile.isEmpty() 업로드한 파일이 있으면 uploadFile.transferTo(new File("C:\\Project 파일 업로드\\" + fileName))

C:\\Project 파일 업로드 에 사용자가 첨부한 파일을 넣어주고

vo.setFilename(fileName) DB에 파일에 이름을 저장, vo.setWriter(user); 로그인 시 저장한 유저 아이디를 작성자로 설정 해줍니다.

그 후 $('#insertBoard').submit(); 폼 전송을 한 뒤 메인 페이지로 이동합니다.



<div align=center><h2>게시글 수정 기능</h2>

![글 수정 테스트 gif](https://user-images.githubusercontent.com/93149034/143154199-48828e0f-125e-4469-a5ef-ae2f52fb8eb2.gif)
</div>

```
<!-- 세션으로 로그인된 아이디와 작성자와 일치하면 수정,삭제  -->
<c:if test="${sessionScope.userId == board.writer }">
	<button type="button" class="btn btn-outline-primary" id="updateBoardBtn" boardseq = "${board.boardseq }">게시글 수정</button>
	<button type="button" class="btn btn-outline-danger" id="deleteBoardBtn" boardseq = "${board.boardseq }">게시글 삭제</button>
</c:if>
```

게시글 수정 기능, 삭제 기능은 작성자 본인만 수정,삭제가 가능하고

로그인시 세션에 저장된 유저 아이디(userId)와 작성자(writer)가 일치해야만 게시글 수정, 삭제 버튼이 보이게 구현하였고

수정 데이터를 보여주는 JSP, 실제 데이터 수정을 담당하는 메서드 두 개로 나뉘어져 있습니다.

```Java
// 게시글 수정 view
@RequestMapping(value = "/updateBoardView.do", method = RequestMethod.GET)
public String updateBoardView(BoardVO vo, Criteria cri, Model model) {
	// 페이징 유지
	model.addAttribute("cri", cri);
	// 어떤 수정된 게시글을 보여줄지
	model.addAttribute("updateBoard", boardservice.getBoard(vo.getBoardseq()));
	return "updateBoardView.jsp";
}		
```

```JavaScript
// 게시글 수정
	$('#updateBoardBtn').click(function(){
		location.href = "updateBoardView.do?"
				+"boardseq=${board.boardseq}"
				+"&page=${cri.page}"
	})
```

게시글 수정 버튼을 클릭하면 해당 게시글의 데이터를 보여주는 JSP 화면으로 이동합니다.


```JavaScript
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
		
	$.ajax({
		url : 'updateBoard.do',
		type : 'post',
		dataType : 'json',
		data : $('#updateBoard').serializeArray(),
		success : function(data){
			if(confirm('수정 하시겠습니까?')){
				$('#updateBoard').submit();
				alert('게시글 수정이 완료되었습니다.');
				location.href = "main.do?page=${cri.page}";
			}
		},
		error : function(data){
			alert('게시글 수정에 실패 하였습니다.');
			location.href = "updateBoardView.do?boardseq=${board.boardseq}&page=${cri.page}"
			}
	})
})
```

ajax url 경로를 실제 수정을 담당하는 메서드 경로로 지정하고 updateBoard form 안에 수정된 데이터를 controller로 전송됩니다.


```Java
// 게시글 수정
@ResponseBody
@RequestMapping(value = "/updateBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
public Map<String, Object> updateBoard(BoardVO vo, Model model, Criteria cri) {
	Map<String, Object> result = new HashMap<String,Object>();
	// 페이지 유지
	result.put("cri", cri);
	// 어떤 게시글을 수정할지
	result.put("updateBoard", boardservice.getBoard(vo.getBoardseq()));
	// 게시글 수정
	boardservice.updateBoard(vo);
	return result;
}
```
수정된 게시글의 데이터를 정상적으로 수정해주고 해당 ajax 로직으로 리턴, $('#updateBoard').submit(); 폼 전송과 동시에 

location.href = "main.do?page=${cri.page}"; 메인 페이지로 이동합니다.

<div align=center><h2>게시글 삭제 기능</h2>

![게시글 삭제 gif](https://user-images.githubusercontent.com/93149034/143155001-6e62199d-2a78-461b-8335-c8344d7f9971.gif)
</div>

```Java   
// 게시글 삭제 
@ResponseBody
@RequestMapping(value = "/deleteBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
public String  deleteBoardView(BoardVO vo) {
	boardservice.deleteBoard(vo);
	return "main.do";
} 
```

```JavaScript
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
```

사용자가 게시글 삭제 버튼을 누르면 게시글 삭제 ajax 로직이 실행되고

삭제를 누를 시 해당 게시글 번호가 controller로 전달됩니다. 

삭제된 게시글 번호가 게시글 삭제 메서드로 들어가면 (delete from board where boardseq =게시글번호) 해당 게시글이 삭제되고 

location.href = "main.do?page=${cri.page}" 메인 페이지로 이동합니다.




<div align=center><h2>검색 기능</h2>

![검색 gif](https://user-images.githubusercontent.com/93149034/143157208-a74b15d3-c7b7-46ac-b131-a2818dde4b28.gif)
</div>

```
<!-- 게시글 수 -->
<select id="selectCount" resultType="int">
   SELECT COUNT(*) FROM BOARD
   <include refid="search"></include>
</select>
```

검색 기능은 검색 조건(제목,작성자,작성내용)에 따라 달라집니다.

검색을 하지 않을 시 총 게시글 개수를 구하여  총 게시글을 JSP에 출력해줍니다.

검색 조건에 따라 일치하는 값을 찾아서 일치하는 값이 있는 게시글의 개수를 구하여 JSP로 출력해주고

검색을 하지 않으면 총 게시글 개수를 구해주고  <include refid="search"> 검색 조건이 들어갈 시 검색 조건에 맞는 게시글 개수를 구해주었습니다.

	
```
<!-- 검색 -->
<sql id="search">
   <if test="searchType != null">
      <if test="searchType == 't'.toString()">WHERE TITLE LIKE CONCAT('%',#{keyword},'%')</if>
      <if test="searchType == 'c'.toString()">WHERE CONTENT LIKE CONCAT('%',#{keyword},'%')</if>
      <if test="searchType == 'w'.toString()">WHERE WRITER LIKE CONCAT('%',#{keyword},'%')</if>
   </if>
</sql>
```
	
<if test="searchType != null"> 검색 조건이 들어가면 

 <if test="searchType == 't'.toString()">WHERE TITLE LIKE CONCAT('%',#{keyword},'%')</if> 해당 검색 조건에 맞는 값을 조회 합니다.
	
```Java
// 게시글 리스트
@RequestMapping(value = "/main.do", method = {RequestMethod.GET,RequestMethod.POST}) 
public String boardList(Model model,  @ModelAttribute("cri") Criteria cri) {
   // 게시글 리스트
   model.addAttribute("boardList", boardservice.selectBoardList(cri));      
   // 페이징
   PageMaker pageMaker = new PageMaker();
   pageMaker.setCri(cri);
   model.addAttribute("pageMaker", pageMaker);
   // 게시글 수 
   pageMaker.setTotalCount(boardservice.selectCount(cri));
   return "main.jsp";
}
```

Criteria 클래스 필드에는 현재 페이지 번호, 1개의 페이지당 보여줄 게시글 개수, 검색 키워드, 검색 타입 4개의 필드가 선언되어있고
	
검색 키워드와 검색 타입으로 조회되는 게시글을 한페이지당 10개씩 JSP에 출력해주었습니다.


<div align=center><h2>댓글 리스트</h2>

![댓글 리스트 gif](https://user-images.githubusercontent.com/93149034/143158465-323908cf-a39c-4974-bd40-50e7121e2d6e.gif)
</div>

댓글 리스트는 해당 게시글에 댓글의 길이만큼 출력하게 구현하였습니다.

```Java
// 댓글 리스트
@ResponseBody
@RequestMapping(value = "/replyList.do",method = RequestMethod.POST)
public Map<String, Object> getBoard(BoardVO vo, ReplyVO rvo,HttpSession session){
	Map<String, Object> result = new HashMap<String, Object>();
	// 로그인한 유저 아이디 getAttribute로 가져오기
	String userId = (String) session.getAttribute("userId");
	// 댓글 리스트
	result.put("reply", replyservice.replyList(rvo));
	// 유저 아이디
	result.put("user", userId);
	return result;
}
```

로그인시 저장된 아이디를 session.getAttribute("userId")로 가져와서 댓글 리스트와 같이 리턴 해주었습니다.
(댓글 수정, 삭제시 유저아이디(user.id)와 작성자(writer)가 일치해야 수정, 삭제 처리가 가능하게 구현했기 때문입니다.)

```JavaScript
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
		// replyList form에 댓글 추가
		$('#replyList').html(replyList);
	}
});
```

리턴 받은 댓글 리스트를 if(data.reply.length < 1) 길이가 1 미만이면 등록된 댓글이 없습니다. 를 출력해주고

댓글 리스트에 길이가 1 이상이면 등록된 댓글을 댓글에 길이만큼 출력시켜줍니다($(data.reply).each(function(key, value))
				  
댓글 수정, 삭제는 댓글의 작성자와 controller에서 리턴 시켜준 유저 아이디가 일치하면 if(data.user == value.writer) 수정, 삭제 처리되게 구현하였고 

댓글 삭제는 삭제하고자 하는 댓글 번호를 deleteReply() 함수로 보내서 해당 댓글을 삭제 처리하였고

마지막으로 댓글을 출력해줄 id를 replyList로 지정해준 div에 출력 시켜주었습니다.
				       
				       
<div align=center><h2>댓글 등록</h2>

![댓글 등록 gif](https://user-images.githubusercontent.com/93149034/143910807-043f41c2-59ef-4f26-92b4-1d3a966bfd20.gif)
</div>

```Java
// 댓글 작성
@ResponseBody
@RequestMapping(value = "/insertReply.do", method = RequestMethod.POST)
public Map<String, Object> insertReply(ReplyVO rvo, Criteria cri,HttpSession session){
	Map<String, Object> result = new HashMap<String, Object>();
	// 로그인한 유저 아이디 getAttribute로 가져오기
	String user = (String) session.getAttribute("userId");
	// 댓글 작성자에 로그인한 유저 아이디를 넣어준다
	rvo.setWriter(user);
	// 댓글 작성
	result.put("insertReply", replyservice.insertReply(rvo));
	return result;
}
```

댓글 작성 또한 작성자를 아이디로 넣어주기 위해 session.getAttribute("userId") 저장된 아이디를 가져와서

rvo.setWriter(user); 작성자에 넣어주었습니다.

```JavaScript
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

```
insertReply form 안에 있는 댓글을 controller로 보내준 후 $('#insertReply').submit(); 폼에 있는 댓글을 전송 합니다.

댓글을 등록 후 location.href = "getBoard.do?boardseq=${board.boardseq}&page=${cri.page}" 해당 페이지, 해당 게시글로 이동합니다.

<div align=center><h2>댓글 등록</h2>

![댓글 수정 gif](https://user-images.githubusercontent.com/93149034/143158987-bdcf3593-e163-4264-baab-d24fb9dfe27a.gif)
</div>

댓글 수정도 게시글 수정과 마찬가지로 두 개의 메서드로 이루어져 있습니다.

수정 데이터를 보여주는 JSP, 실제 데이터 수정을 담당하는 메서드 두 개로 나뉘어져 있습니다.


```Java
// 댓글 수정 view
@RequestMapping(value = "/updateReplyView.do" , method = {RequestMethod.GET,RequestMethod.POST})
public String updateReplyView(ReplyVO rvo, Model model, Criteria cri) {
	model.addAttribute("cri", cri);
	model.addAttribute("updateReply", replyservice.selectReply(rvo.getReplyseq()));
	return "updateReplyView.jsp";
}
```

```<a href="updateReplyView.do?replyseq=' + value.replyseq + '">수정</a>``` 수정을 클릭 하면 댓글 수정 JSP로 이동합니다.


```Java
// 댓글 수정
@ResponseBody
@RequestMapping(value = "/updateReply.do", method = RequestMethod.POST)
public Map<String, Object> updateReply(ReplyVO rvo){
	Map<String, Object> result = new HashMap<String, Object>();
	
	// 어떤 댓글을 수정할지
	result.put("updateReply", replyservice.selectReply(rvo.getReplyseq()));
	// 댓글 수정
	replyservice.updateReply(rvo);
	return result;
}
```

1. 

```JavaScript
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
		
		$.ajax({
		url : 'updateReply.do',
		type : 'post',
		dataType : 'json',
		data : $('#updateReply').serializeArray(),
		success : function(data){
			alert('수정이 완료되었습니다.');
			location.href = "getBoard.do?boardseq=${updateReply.boardseq}&replyseq=${updateReply.replyseq}";
		}
	})
})
```
ajax url을 실제 댓글 수정을 담당하는 메서드로 지정해준 후

updateReply form에 수정된 데이터를 controller로 보내줍니다.

controller에서 정상적으로 수정 처리 후 페이징 유지와 함께 댓글 수정을 했던 게시글로 되돌아옵니다.




<div align=center><h2>댓글 삭제</h2>

![댓글 삭제 gif](https://user-images.githubusercontent.com/93149034/143159466-1ac7fadb-7522-4e12-aed8-36925d659cdc.gif)
</div>
	
	
```JavaScript<a href="javascript:void(0);" onclick="deleteReply(' + value.replyseq + ');".>삭제</a>```


댓글 삭제를 할 시 deleteReply(); 함수가 실행되고 매개변수에 삭제할 댓글 번호를 같이 보내주었습니다.

```JavaScript
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
```

삭제할 댓글 번호를 매개변수에 넣어주고 deleteReply.do?replyseq=' + replyseq  댓글 삭제 url에 삭제할 댓글을 넣어주었습니다.

댓글 삭제 쿼리문에 의해(delete from reply where replyseq="삭제할 댓글번호") 삭제를 누를 시 해당 댓글이 삭제되고 다시 기존 페이지로 되돌아오게 구현하였습니다.

<div align=center><h2>마무리</h2>
이상 포트폴리오 기능 설명을 마치겠습니다.

긴 글 읽어주셔서 감사합니다.
</div>
