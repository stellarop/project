[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fstellarop%2Fhit-counter&count_bg=%2379C83D&title_bg=%23555555&icon=litecoin.svg&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

<div align=center><h1>👋 Hi, I’m @ohbyul </h1></div>


# 댓글 게시판 프로그램 - 개인 프로젝트

신입 개발자의 기본 소양인 게시판 & 댓글 프로그램을 만들었습니다.
들어가는 기능은 로그인, 로그아웃,회원가입, 아이디 찾기, 비밀번호 찾기, 회원정보수정, 회원탈퇴, 게시판crud, 댓글 crud, 이미지 등록, 게시글 페이징, 검색기능 입니다.



## 개발환경

|  <center>개발 환경 분류</center> |  <center>사용 기술</center> |  <center>비고</center> |
|:--------|:--------:|--------:|
|**Develop Tools** | <center> Eclipse v4.12.0  &nbsp; MySQLWorkbench v8.0  </center> |*-* |
|**Develop Language For Front end** | <center> HTML5  &nbsp;  JSP &nbsp;   JavaScript  &nbsp;  jQuery v3.6.0  &nbsp;  Bootstrap v4.0.0 </center> |*-* |
|**Develop Language For Back end** | <center> Java v1.8  &nbsp;  Spring Framework v4.2.4 &nbsp; Mybatis 3.4.1 </center> |*-* |
|**Data Base** | <center> Mysql 8.0 </center> |*-* |
|**Server** | <center> Apache Tomcat v8.0 </center> |*Tomcat v9.0 버전도 사용함* |
|**Web** | <center> Chrome v95.0.4638.5  &nbsp;  Microsoft Edge v95.0.1020.30 </center> |*-* |

## 프로젝트 구조

![프로젝트 구조 1](https://user-images.githubusercontent.com/93149034/141842473-dfb7e5a8-3a50-4974-ab9f-d127a4e72fb3.png)
![프로젝트 구조 2](https://user-images.githubusercontent.com/93149034/141842482-91fcb060-d039-4e9e-a45e-2d2f5e4ebae7.png)

## ERD 

![ERD](https://user-images.githubusercontent.com/93149034/142772745-51282138-525b-4923-82ba-a52faea23958.png)

게시글 번호 칼럼을 외래키로 지정하여 on delete cascade 게시글이 삭제되면 댓글도 삭제되게 처리하였습니다.

## 로그인 기능

![로그인 gif](https://user-images.githubusercontent.com/88939199/135759759-6b8f1df1-0c5a-41c2-8610-9b3db077dc4b.gif)

```
<!-- 로그인  -->
<select id="login" resultType="user" parameterType="user">
   SELECT * FROM USERS WHERE ID =#{id} AND PASSWORD=#{password}
</select>
```

```
// 로그인
@ResponseBody
@RequestMapping(value = "/login.do", method = RequestMethod.POST)
public boolean login(@ModelAttribute("user") UserVO vo, HttpSession session,RedirectAttributes rttr) {
      
   UserVO user = userservice.login(vo);

      if(user != null) {
         session.setAttribute("userId", user.getId());
         session.setAttribute("userName", user.getName());
         session.setAttribute("userTime", user.getRegdate());
         session.setAttribute("userPassword", user.getPassword()); 
         return true;
      }else {
         session.setAttribute("login", false);
         return false;
      }    
   }
```

```
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
         // 입력한 값이 컨트롤러로 보내진다
         data : {'id' : $('#id').val(),
         'password' : $('#password').val()},
         success : function(data){
            // 컨트롤러에서 가져온 값이 true 일시
            if(data == true){
               alert('로그인 성공');
               // 메인 페이지로
               window.location.href = "main.do";
            // 컨트롤러에서 가져온 값이 false 일시
            }else if(data == false){
               alert('로그인 실패')
               // 로그인 페이지에 머무름
               window.location.href = "login.jsp";
            }
         }
      })
   });
```
1. 로그인 요청 시 사용자가 입력한 값이 컨트롤러로 보내집니다.
2. 이후 컨트롤러에서 DB에 저장된 사용자 아이디와 비밀번호를 사용자가 입력한 아이디 비밀번호 값과 비교합니다. 
3. 값이 맞으면 true 맞지 않으면 false를 반환 후 반환 받은 값에 따라 로그인 성공, 실패 여부를 알려주고 해당 페이지로 이동합니다

```
<c:if test="${login == false}">
   <div class="alert alert-danger">로그인에 실패했습니다.<br> 아이디와 비밀번호를 확인해주세요.</div>
</c:if>
```
4. 로그인에 실패했을 시(컨트롤러에서 로그인에 실패하면 login = false) 다시 로그인 페이지로 이동 후 로그인 실패 구문을 나타내줍니다

## 회원가입

![회원가입 gif](https://user-images.githubusercontent.com/93149034/143124175-06900ea5-12e3-4319-8497-841376d830ea.gif)

주소 클릭 시 나오는 팝업창 입니다.
주소 검색을 완료하면 검색한 주소를 지도로 나타내줍니다.

![주소검색 gif](https://user-images.githubusercontent.com/93149034/143127339-1a6a7ebb-7513-4120-a651-a23246693fa0.gif)


```
<!-- 회원가입  -->
<insert id="createuser" parameterType="user">
	INSERT INTO USERS(ID,PASSWORD,NAME,EMAIL,ADDRESS,ADDRESS2) VALUES(#{id},#{password},#{name},#{email},#{address},#{address2})
</insert>

<!-- 회원가입 아이디 체크 -->
<select id="idcheck" resultType="int">
   SELECT COUNT(*) FROM USERS WHERE ID =#{id}
</select>
```

```
// 아이디 체크
@ResponseBody
@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
public int idCheck(UserVO vo) {
   int result = userservice.idCheck(vo);
   return result;
}
```

```
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

1. 사용자가 아이디를 입력하고 아이디확인 버튼을 클릭하면 아이디 중복확인 함수가 실행됩니다.
2. 사용자가 입력한 아이디 값이 중복된 아이디면 1, 사용 가능한 아이디면 0을 반환받습니다.
3. 반환 받은 숫자에 따라 중복된 아이디 인지, 사용 가능한 아이디 인지 알려줍니다.

```
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
```
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
```
```
<select id="select" class="form-control">
   <option value="" disabled selected>E-Mail 선택</option>
   <option value="@naver.com" id="naver.com">naver.com</option>
   <option value="@daum.net" id="hanmail.net">daum.net</option>
   <option value="@gmail.com" id="gmail.com">gmail.com</option>
   <option value="@nate.com" id="nate.com">nate.com</option>
   <option value="directly" id="textEmail">직접 입력하기</option>
</select>
```
4. 사용자가 입력한 회원가입 데이터를 컨트롤러로 보내준 후 중복된 아이디면 회원가입 진행을 할 수 없도록 기존 페이지로 보내주고 
5. 사용 가능한 아이디라면 회원가입을 진행시키고 로그인 페이지로 보내줍니다.
 
```
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
```
```
<div class="alert alert-success" id="truepassword">패스워드가 일치합니다.</div>
<div class="alert alert-danger" id="falsepassword">패스워드가 일치하지 않습니다. 다시 입력 해주세요.</div>
```


6. 패스워드 일치, 불일치 구문을 hide으로 숨기고 사용자가 입력한 패스워드와 패스워드 재확인을 비교해서
  두 값이 맞으면 일치구문 출력, 두 값이 틀리다면 불일치 구문을 출력해줍니다.
  
 
 
```
<!-- 카카오 주소 찾기 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
```

```
<!-- 카카오 지도 API -->
<!-- 카카오에서 받은 인증키를 반드시 넣어줘야함 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=여기에 인증키가 들어갑니다.&libraries=services,clusterer,drawing"></script>
```
 
 
7. 주소 검색 같은 경우 api 호출만 해주면 되지만 지도는 개발자 등록과 사이트 도메인 등록, 스크립트 경로에 카카오에서 발급받은 api 인증키를 넣어주고 사용자가 입력한 주소를 좌표로 변환하여
지도로 나타내주어야 하기 때문에 스크립트 경로에 지도 라이브러리도 같이 추가 해주었습니다.


```
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


8. html 에 지도 영역을 만들어주고 기본 지도 좌표를 입력 해줍니다.  
9. html 지도 영역에 실제 지도와 기본으로 설정한 지도 좌표를 넣어주고 사용자가 입력한 주소를 좌표로 변경하는 지도 라이브러리를 선언 해줍니다.
10. 사용자가 주소 검색을 하면 지도 중심에 마커를 나타내주는 마커를 생성합니다.
11. 서울시청으로 설정한 지도를 사용자가 주소 검색을 할 때까지 hide() 으로 지도를 숨겨줍니다.
12. 사용자가 주소 입력 칸을 클릭 하면 주소 검색 팝업창이 나오고 사용자가 검색한 주소에 이름을 주소 입력 칸에 넣어줍니다.
13. 주소 이름을 검색 후 해당 주소 좌표를 지도 영역에 넣어주고 좌표 중심에 마커를 생성해주고 지도를 표시 해줍니다.
14. 지도를 나타내준 후 상세 주소 칸으로 이동합니다.

## 아이디 찾기

![아이디 찾기 gif](https://user-images.githubusercontent.com/93149034/141844299-a3aceb27-142f-4869-a329-df8e24c0888c.gif)

```
<!-- 아이디 찾기 -->
<select id="findid" resultType="user" parameterType="user">
   SELECT * FROM USERS WHERE EMAIL =#{email}
</select>
```

```
$(function(){

   // 로그인
   $('#login').click(function(){
      location.href = "login.do"
   })
   
   // 패스워드 찾기
   $('#findPwn').click(function(){
      location.href = "findPassword.jsp"
   })
   
   $('#id').click(function(){
   
      // 아이디 찾기 유효성 검사
      if($('#email').val()==''){
         alert('이메일을 입력하세요.');
         $('#email').focus();
         return false;
      }
      
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
   })   
});
```

```
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

1. 사용자가 이메일을 입력하면 입력한 이메일 값이 컨트롤러로 이동합니다 사용자가 입력한 이메일값으로 회원가입이 되있다면 0을 반환
2. 사용자가 입력한 이메일 값으로 조회가 안된다면 1을 반환 받습니다 이후에 ajax에서 컨트롤러로 반환 받은 값이 0이면 사용자 이름과 아이디를 나타내주고 
3. 반환 받은 값이 1 이면 등록된 아이디가 없다고 알려줍니다.

```
<c:if test="${getId == true}">
   <div class="alert alert-primary">${userName }님의 아이디는 <b>${userId }</b>입니다.</div>
   <button type="button" class="btn btn-sm btn-primary" id="login">로그인</button>
   <button type="button" class="btn btn-sm btn-primary" id="findPwn">패스워드 찾기</button>
</c:if>
```

4. 사용자가 입력한 이메일로 회원가입이 되있다면(getId == true) 다시 기존 페이지로 되돌아간후 회원정보를 구문으로 알려줍니다

## 패스워드 찾기

![패스워드 찾기 gif](https://user-images.githubusercontent.com/93149034/141845315-89fae9ae-91f7-4242-baad-d2dfe781697f.gif)

```
<!-- 패스워드 찾기  -->
<select id="findpassword" resultType="user" parameterType="user">
   SELECT * FROM USERS WHERE ID =#{id}
</select>
```

```
$(function(){
   
   // 로그인
   $('#login').click(function(){
      location.href = "login.do"
   })
   
   // 아이디 찾기
   $('#findId').click(function(){
      location.href = "findId.jsp"
   })
   
   $('#find').click(function(){
      
      // 패스워드 찾기 유효성 검사
      if($('#id').val()==''){
         alert('아이디를 입력하세요.');
         $('#id').focus();
         return false;
      }
      
      $.ajax({
         // 패스워드 찾기 경로
         url : 'findPassword.do',
         type : 'post',
         dataType : 'json',
         // 사용자가 입력한 아이디 값
         data : {'id' : $('#id').val()},
         success : function(data){
            // 조회되는 아이디 일시 
            if(data == 0){
               // 기존 페이지로 보내주고 패스워드 구문 출력
               window.location.href = "findPassword.jsp";
            // 조회되지 않은 아이디 일시
            }else if(data == 1){
               alert('등록되지 않은 아이디 입니다.');
               window.location.href = "findPassword.jsp";
            }
         }
      })
   })
});
```

```
// 패스워드  찾기
@ResponseBody
@RequestMapping(value = "/findPassword.do", method = RequestMethod.POST)
public int findPassword(@ModelAttribute("user") UserVO vo, HttpSession session) {
   
   UserVO password = userservice.findPassword(vo);
   
   if (password != null) {
      // 사용자 이름과 패스워드를 보내줌
      session.setAttribute("userName", password.getName());
      session.setAttribute("userPassword", password.getPassword());
      // 일치 하면 구문 출력 
      session.setAttribute("getPassword", true);
      return 0;
   } else {
      return 1;
   }
}
```

1. 사용자가 아이디 값을 입력하면 아이디 값이 컨트롤러로 이동합니다.
2. 아이디 값을 조회 후 회원가입이 된 아이디라면 0, 회원가입 이력이 없는 아이디 라면 1을 반환해줍니다.
3. 컨트롤러에서 반환 받은 값에 따라 ajax에서 0이면 사용자 패스워드를 알려주고 1이면 등록되지 않은 아이디란걸 알려줍니다
4. 회원가입된 아이디면(getPassword = true) 다시 기존 페이지로 되돌아간후 사용자 패스워드 값을 알려줍니다

```
<c:if test="${getPassword == true}">
   <div class="alert alert-primary">${userName }님의 패스워드는 <b>${userPassword }</b>입니다.</div>
   <button type="button" class="btn btn-sm btn-primary" id="login">로그인</button>
   <button type="button" class="btn btn-sm btn-primary" id="findId">아이디 찾기</button>
</c:if>
```
  
## 회원탈퇴

![회원탈퇴 gif](https://user-images.githubusercontent.com/88939199/136686776-660fa240-fb91-4aa3-ae36-1f1977df6af2.gif)

```
<!-- 회원탈퇴  -->
<delete id="deleteuser" >
   DELETE FROM USERS WHERE ID =#{id} AND PASSWORD =#{password}
</delete>
```

```

// 패스워드 체크
@ResponseBody
@RequestMapping(value = "/passwordCheck.do", method = RequestMethod.POST)
public int passwordCheck(UserVO vo) {
	int result = userservice.passwordCheck(vo);
	return result;
}

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

1. 로그인에서 session.setAttribute 로 넘겨준 비밀번호를 getAttribute 로 가져옵니다 .
2. 로그인에서 가져온 패스워드와 사용자가 입력한 비밀번호를 equals 문자열 비교를 해서 맞으면 세션을 끊어준 후 로그인 창으로 틀리다면 기존 페이지에 머무릅니다.

```
$(function(){
   
   // 메인으로 가기
   $('#mainBtn').click(function(){
      location.href = "main.do"
   })
   
   // 회원탈퇴 유효성 검사
   $('#deleteUserBtn').click(function(){
      if($('#password').val()==''){
         alert('패스워드를 입력하세요.');
         $('#password').focus();
         return false;   
      }
      
      
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
   })
});
```


3. 사용자가 패스워드를 입력하고 탈퇴 버튼을 클릭하면 사용자가 입력한 패스워드가 컨트롤러로 보내집니다.
4. 패스워드가 일치하지 않는다면 패스워드가 일치하지 않는다는 알림을 알려줍니다.
5. 패스워드가 일치하다면 사용자가 입력한 패스워드를 deleteUser.do 경로로 보내줍니다.
6. 사용자가 입력한 패스워드와 세션에 있는 패스워드를 비교 후 두 값이 맞으면 로그인 창으로 보내주고 틀리다면 해당 페이지에 머무릅니다.

## 글 작성

![글 작성 테스트 gif](https://user-images.githubusercontent.com/93149034/143153447-d8e43a2c-08d6-4ed1-8815-674bd790ad3c.gif)

```
<!-- 게시글 작성 -->
<insert id="insertBoard">
	INSERT INTO BOARD (TITLE,WRITER,CONTENT,FILENAME) VALUES (#{title},#{writer},#{content},#{filename})
</insert>
```

```
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
	// 게시글 작성자에 로그인 한 유저 아이디 넣어주기
	vo.setWriter(user);
	result.put("fileName", fileName);
	//게시글 작성
	result.put("insertBoard", boardservice.insertBoard(vo));
	return result;
}
```

1. 글 작성시 작성자를 유저 아이디로 넣어주기 위해 로그인시 넘겨준 유저 아이디를 가져옵니다.
2. 업로드한 파일을 경로에 넣어주고 파일 이름을 저장합니다.
3. 작성자가 입력한 글 작성 데이터를 클라이언트로 리턴 시켜줍니다.

```
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

4. ajax로 파일 업로드 할 시 form 안에 있는 내용 전체를 전송하기위해 formData 객체를 사용하였습니다.
5. formData(insertBoard) 안에 있는 데이터를 서버로 보내준 후 메인 페이지로 보내줍니다.

6. BoardVO 필드에 MultipartFile uploadFile 를 추가 해줍니다.

```
private MultipartFile uploadFile;
```

7. servlet-context.xml에서 파일 업로드 빈을 등록 해주고 파일 사이즈를 정해줍니다.

```
<!-- 파일 업로드  -->
   <beans:bean id ="multipartResolver" class ="org.springframework.web.multipart.commons.CommonsMultipartResolver">
      <beans:property name="maxUploadSize" value="10000000"></beans:property>
   </beans:bean>
```

8. servlet-context.xml에서 파일이 저장된 경로를 설정해줍니다.

```
<resources mapping="/img/**" location="C:\Project 파일 업로드" />
```

9. server.xml에서 이미지 파일 경로를 지정해줍니다.

```
  <!-- 이미지 파일 경로 -->
   <Context docBase="C:\Project 파일 업로드" path="/img" reloadable="true"/>
```


10. 이미지를 불러올때 /img/ +  db에 저장된 파일이름 으로 불러옵니다.

```
<img width=1110px, height=600px src="/img/${board.filename }"  onerror="this.style.display='none';"/>
```

## 글 수정

![글 수정 테스트 gif](https://user-images.githubusercontent.com/93149034/143154199-48828e0f-125e-4469-a5ef-ae2f52fb8eb2.gif)

```
<!-- 세션으로 로그인된 아이디와 작성자와 일치하면 수정,삭제  -->
<c:if test="${sessionScope.userId == board.writer }">
	<button type="button" class="btn btn-outline-primary" id="updateBoardBtn" boardseq = "${board.boardseq }">게시글 수정</button>
	<button type="button" class="btn btn-outline-danger" id="deleteBoardBtn" boardseq = "${board.boardseq }">게시글 삭제</button>
</c:if>
```
1. 글 수정과 글 삭제는 아이디와 작성자가 일치해야 수정,삭제 버튼이 보이게 만들었습니다.

```
<!-- 게시글 수정 -->
<update id="updateBoard">
	UPDATE BOARD SET TITLE=#{title},CONTENT=#{content} WHERE BOARDSEQ=#{boardseq}
</update>
```

```
// 게시글 수정 view
@RequestMapping(value = "/updateBoardView.do", method = RequestMethod.GET)
public String updateBoardView(BoardVO vo, Criteria cri, Model model) {
	model.addAttribute("cri", cri);
	model.addAttribute("updateBoard", boardservice.getBoard(vo.getBoardseq()));
	return "updateBoardView.jsp";
}		
	
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

```
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

2. 사용자가 글 수정 버튼을 클릭하면 수정 form 안에 있는 데이터가 컨트롤러로 전송 됩니다.

3. 수정 데이터를 submit() 저장시켜 준 후 메인 페이지로 이동합니다.


# 글 삭제

![게시글 삭제 gif](https://user-images.githubusercontent.com/93149034/143155001-6e62199d-2a78-461b-8335-c8344d7f9971.gif)

```
<!-- 게시글 삭제 -->
<delete id="deleteBoard">
   DELETE FROM BOARD WHERE BOARDSEQ=#{boardseq} AND PASSWORD =#{password}
</delete>
```


```   
// 게시글 삭제 
@ResponseBody
@RequestMapping(value = "/deleteBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
public String  deleteBoardView(BoardVO vo) {
	boardservice.deleteBoard(vo);
	return "main.do";
} 
```

```
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
1. 글 삭제 버튼을 클릭하면 글 상세에 있는 게시글 번호를 컨트롤러로 전송합니다.
2. 글 상세에서 보내준 게시글 번호를 삭제하고 메인 페이지로 보내줍니다.

## 게시글 검색, 페이징

![검색 gif](https://user-images.githubusercontent.com/93149034/143157208-a74b15d3-c7b7-46ac-b131-a2818dde4b28.gif)

```
// 현재 페이지 번호
   private Criteria cri;
   // 총 게시글 갯수
   private int totalCount;
   private int startPage;
   private int endPage;
   private boolean prev;
   private boolean next;
   // 화면 하단에 보여지는 페이지 버튼의 수
   private int displayPageNum = 5;

   public Criteria getCri() {
      return cri;
   }

   public void setCri(Criteria cri) {
      this.cri = cri;
   }

   public int getTotalCount() {
      return totalCount;
   }

   public void setTotalCount(int totalCount) {
      this.totalCount = totalCount;
      calcData();
   }

   private void calcData() {
      // 끝 페이지 번호 = (현재 페이지 번호 / 화면에 보여질 페이지 번호의 갯수) * 화면에 보여질 페이지 번호의 갯수
      endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
      // 시작 페이지 번호 = (끝 페이지 번호 - 화면에 보여질 페이지 번호의 갯수) + 1
      startPage = (endPage - displayPageNum) + 1;
      if (startPage <= 0)
         startPage = 1;
      
      //마지막 페이지 번호 = 총 개시글 수 / 한 페이지당 보여줄 개시글의 갯수
      int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
      if (endPage > tempEndPage) {
         endPage = tempEndPage;
      }
      // 이전 버튼 생성 여부 = 시작 페이지 번호 == 1 ? false : true
      prev = startPage == 1 ? false : true;
      // 다음 버튼 생성 여부 = 끝 페이지 번호 * 한 페이지당 보여줄 게시글의 갯수 < 총 게시글의 수 ? true : false
      next = endPage * cri.getPerPageNum() < totalCount ? true : false;
      
   } 
```
```
// 현재 페이지 번호
   private int page;
   // 한 페이지당 보여줄 게시글의 갯수
   private int perPageNum;
   // 검색 키워드 
   private String keyword;
   // 검색 타입
   private String searchType;
   
   
   // 특정 페이지의 게시글 시작 번호, 게시글 시작 행 번호
   public int getPageStart() {
      return (this.page - 1) * perPageNum;
   }
   // 한개의 페이지에 게시글을 10개 보여줌
   public Criteria() {
      this.page = 1;
      this.perPageNum = 10;
   }

   public int getPage() {
      return page;
   }

   public void setPage(int page) {
      if (page <= 0) {
         this.page = 1;
      } else {
         this.page = page;
      }
   }
   
   public int getPerPageNum() {
      return perPageNum;
   }

   public void setPerPageNum(int pageCount) {
      int cnt = this.perPageNum;
      if (pageCount != cnt) {
         this.perPageNum = cnt;
      } else {
         this.perPageNum = pageCount;
      }
   }
```

```
// 게시글 리스트
@RequestMapping(value = "/main.do", method = {RequestMethod.GET,RequestMethod.POST}) 
public String boardList(Model model,  @ModelAttribute("cri") Criteria cri) {
   // 게시글 리스트
   model.addAttribute("boardList", boardservice.selectBoardList(cri));      
   // 페이징
   PageMaker pageMaker = new PageMaker();
   pageMaker.setCri(cri);
   model.addAttribute("pageMaker", pageMaker);
   // 게시글 수 넣어주기
   pageMaker.setTotalCount(boardservice.selectCount(cri));
   return "main.jsp";
}
```

```
<!-- 게시글리스트 + 페이징 -->
<select id="selectBoardList" resultMap="boardResult">
   SELECT * FROM BOARD
      <include refid="search"></include>
      ORDER BY BOARDSEQ DESC
   LIMIT #{pageStart},#{perPageNum}
</select>
```

게시글 번호를 내림차순으로 1페이지당 10개의 게시글을 보여줍니다.

```
<!-- 게시글 수 -->
<select id="selectCount" resultType="int">
   SELECT COUNT(*) FROM BOARD
   <include refid="search"></include>
</select>
```

게시판의 게시글이 몇개인지 구하고 검색 키워드에 값이 들어가면 검색 키워드에 맞는 게시글을 구해서 view로 나타내줍니다.
검색되는 내용이 없으면 총 게시글이 몇개인지 구해서 view로 10개의 게시글을 보여줍니다. 

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
searchType(검색키워드)를 view에서 선택합니다.

```
 <select name="searchType">  
      <option value="t"<c:out value="${cri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
      <option value="c"<c:out value="${cri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
      <option value="w"<c:out value="${cri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
    </select>
    <input type="text" name="keyword" value="${cri.keyword}"/>
    <button type="submit" class="btn btn-outline-dark">검색</button>
```
searchType(검색키워드)가 null이 아니라면 사용자가 설정한 해당 searchType과 검색한 내용이 게시글리스트 + 페이징 쿼리문에 적용됩니다.
searchType(검색키워드)가 없을 시 총 게시글 수를 구해서 view로 나타내줍니다.


## 댓글 리스트

![댓글 리스트 gif](https://user-images.githubusercontent.com/93149034/143158465-323908cf-a39c-4974-bd40-50e7121e2d6e.gif)


```
<!-- 댓글 리스트 -->
<select id="replyList" resultMap="replyResult">
	SELECT * FROM REPLY WHERE BOARDSEQ =#{boardseq}
</select>
```

```
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
1. 댓글 수정, 댓글 삭제 버튼을 작성자만 보이게 만들기 위하여 로그인 성공 시 유저 아이디를 가져옵니다.

2. 댓글 리스트와 유저 아이디를 클라이언트로 리턴 시켜줍니다.
```
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
```

3. url을 해당하는 게시글 번호에 댓글 리스트로 설정해줍니다.
4. 컨트롤러에서 리턴받은 댓글 리스트에 길이(length)가 0이면 댓글이 없음을 알려주고 리스트의 길이가 1이상이면 리스트에 길이만큼 출력 해줍니다. 
5. 컨트롤러에서 리턴받은 유저 아이디는 댓글 수정, 댓글 삭제 시 자신의 댓글만 수정, 삭제 처리하기 때문입니다.
6. 작성자가 유저 아이디로 들어가기 때문에 user == writer 유저 아이디와 작성자가 일치하면 댓글 수정, 삭제 버튼이 보이게 만들었습니다.
7. replyList form에 댓글 리스트를 넣어주고 replyList(); 리스트 함수를 실행시켜서 글 상세에 들어오면 댓글이 보이게 만들었습니다.

## 댓글 등록

![댓글 등록 gif](https://user-images.githubusercontent.com/93149034/143910807-043f41c2-59ef-4f26-92b4-1d3a966bfd20.gif)

```
<!-- 댓글 작성 -->
<insert id="insertreply">
	INSERT INTO REPLY (BOARDSEQ,WRITER,CONTENT) VALUES (#{boardseq},#{writer},#{content})
</insert>
```

```
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

1. 작성자를 유저 아이디로 하기 위해 유저 아이디를 가져옵니다.
2. 댓글 작성자에 유저 아이디를 넣어주고 댓글 작성을 클라이언트로 리턴 시킵니다.

```
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

3. 컨트롤러에서 리턴받은 데이터를 submit() 저장 시킨 후 등록된 페이지로 보내줍니다.


## 댓글 수정

![댓글 수정 gif](https://user-images.githubusercontent.com/93149034/143158987-bdcf3593-e163-4264-baab-d24fb9dfe27a.gif)

```
<!-- 댓글 수정 -->
<update id="updatereply">
   UPDATE REPLY SET CONTENT=#{content} WHERE REPLYSEQ =#{replyseq}
</update>
```
```
// 댓글 수정 view
@RequestMapping(value = "/updateReplyView.do" , method = {RequestMethod.GET,RequestMethod.POST})
public String updateReplyView(ReplyVO rvo, Model model, Criteria cri) {
	model.addAttribute("cri", cri);
	model.addAttribute("updateReply", replyservice.selectReply(rvo.getReplyseq()));
	return "updateReplyView.jsp";
}

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

```
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

1. 댓글 수정을 클릭하면 사용자가 입력한 댓글 수정 페이지로 이동합니다.
2. 댓글 수정 후 수정 버튼을 누르면 댓글 수정 form에 있는 내용이 컨트롤러로 전송됩니다.
3. 전송 후 댓글 수정을 한 페이지로 이동합니다.

## 댓글 삭제 

![댓글 삭제 gif](https://user-images.githubusercontent.com/93149034/143159466-1ac7fadb-7522-4e12-aed8-36925d659cdc.gif)

```
<!-- 댓글 삭제 -->
<delete id="deletereply">
   DELETE FROM REPLY WHERE REPLYSEQ = #{replyseq}
</delete>
```

```
  // 댓글 삭제
@ResponseBody
@RequestMapping(value = "/deleteReply.do", method = RequestMethod.POST)
public String deleteReply(ReplyVO rvo){
	replyservice.deleteReply(rvo);
	return "getBoard.do";
}
```

```
replyList += '<a href="javascript:void(0);" onclick="deleteReply(' + value.replyseq + ');">삭제</a>';
```

1. 댓글 리스트에서 삭제를 클릭하면 deleteReply() 함수를 실행시킵니다.
2. deleteReply() 함수 파라미터에 삭제할 댓글 번호를 같이 보내줍니다.

```
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

3. url에 댓글 삭제 경로와 삭제할 댓글 번호를 같이 지정하여 해당 댓글이 삭제되게 지정하였습니다.
4. 댓글 삭제가 완료되면 해당 게시글로 이동합니다.

## error

### no serializer found for class

파일에 이름을 저장하는 과정에서 발견

#### 해결 방법 

Json으로 변환할 필드에 @JsonIgnore 를 선언 해주는 것

@JsonIgnore
private MultipartFile uploadFile;
	
### 댓글이 순차적으로 삭제

댓글 삭제를 클릭하면 클릭한 댓글이 삭제되는것이 아니라 첫번째 댓글부터 순차적으로 삭제되는 현상

#### 해결 방법

댓글 삭제(deleteReply() ) 함수에 댓글 번호(replyseq)를 같이 보내주어서 클릭한 댓글만 삭제되게 구현하였습니다.

### 파일 업로드 & 게시글 한글 깨짐

게시글 작성에서 파일 업로드를 할 시 업로드가 안되는 현상과 콘솔에 게시글 title이 문자 인코딩 실패(한글이 깨져서 출력)

#### 해결 방법

contentType을 false로 지정해주었습니다. 
contentType을 지정 하지 않을시 기본값이 application/x-www-form-urlencoded 로 지정됩니다.
application/x-www-form-urlencoded 으로 지정 시 Body로 데이터가 전달되지 않아서 RequestParam으로 데이터를 받아야 합니다.
contentType을 false 지정해주면 multipart/fprm-data로 지정되서 파일 업로드가 가능해집니다.

### 지도를 좌표로 변경이 안되는 현상

사용자가 검색한 주소를 좌표로 변환이 안되는 현상입니다.

#### 해결 방법

libraries=services

지도 api 스크립트 선언 시 인증키 옆에 주소를 좌표로 변환하는 라이브러리를 추가하여 해결하였습니다.

