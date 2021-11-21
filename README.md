# 댓글 게시판 프로그램 - 개인 프로젝트

신입 개발자의 기본 소양인 게시판 & 댓글 프로그램을 만들었습니다.
들어가는 기능은 로그인, 로그아웃,회원가입, 아이디 찾기, 비밀번호 찾기, 회원정보수정, 회원탈퇴, 게시판crud, 댓글 crud, 이미지 등록, 게시글 페이징, 검색기능 입니다.

## 개발환경

Front

1. Bootstrap 4
2. Jquery 3.6

Back

1. JDK1.8
2. Mysql 8.0.22
3. Mybatis 3.4.1
4. Spring 4.2.4
5. Tomcat 8

## 프로젝트 구조

![프로젝트 구조 1](https://user-images.githubusercontent.com/93149034/141842473-dfb7e5a8-3a50-4974-ab9f-d127a4e72fb3.png)
![프로젝트 구조 2](https://user-images.githubusercontent.com/93149034/141842482-91fcb060-d039-4e9e-a45e-2d2f5e4ebae7.png)

## ERD 

![ERD](https://user-images.githubusercontent.com/93149034/141842497-98b89514-61ba-42d0-b24e-f21cf93658d4.png)

boardseq 칼럼을 외래키로 지정하여 on delete cascade 게시글이 삭제되면 댓글도 삭제되게 처리하였습니다.

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

![회원가입 gif](https://user-images.githubusercontent.com/88939199/136156549-9d65c7cd-6c3f-498d-9b2e-bff47be9b0f7.gif)


```
<!-- 회원가입  -->
<insert id="createuser" parameterType="user">
   INSERT INTO USERS(ID,PASSWORD,NAME,EMAIL) VALUES(#{id},#{password},#{name},#{email})
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

6. 패스워드 일치, 불일치 구문을 hide으로 숨기고 사용자가 입력한 패스워드와 패스워드 재확인을 변수로 받아서
  두 값이 맞으면 일치구문 출력, 두 값이 틀리다면 불일치 구문을 출력해줍니다.

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
```
// 패스워드 체크
@ResponseBody
@RequestMapping(value = "/passwordCheck.do", method = RequestMethod.POST)
public int passwordCheck(UserVO vo) {
   int result = userservice.passwordCheck(vo);
   return result;
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
4. 사용자가 입력한 패스워드와 세션에 있는 패스워드를 비교 후 두 값이 맞으면 로그인 창으로 보내주고 틀리다면 해당 페이지에 머무릅니다
5. 컨트롤러에서 반환받은 값에 따라 탈퇴 여부가 결정 됩니다

## 글 작성

![글작성 gif](https://user-images.githubusercontent.com/88939199/136687130-05e1e8c7-7e9e-4c5f-b033-601c6749c6e3.gif)


```
<!-- 게시글 작성 -->
<insert id="insertBoard">
   INSERT INTO BOARD (TITLE,WRITER,CONTENT,PASSWORD,FILENAME) VALUES (#{title},#{writer},#{content},#{password},#{filename})
</insert>
```

```
// 게시글 입력
@RequestMapping(value = "/insertBoard.do", method = RequestMethod.POST)
public String insertBoard(BoardVO vo) throws IOException {      
   MultipartFile uploadFile = vo.getUploadFile();
   // 업로드하는 파일의 실제 이름를 반환
   String fileName = uploadFile.getOriginalFilename();
   
   // 업로드한 파일의 존재여부
   if(!uploadFile.isEmpty()) {
      String originalFilename = uploadFile.getOriginalFilename();
      // 업로드한 파일의 데이터를 저장
      uploadFile.transferTo(new File("C:\\Project 파일 업로드\\" + fileName));
   }   
   // 파일 이름을 db에 저장
   vo.setFilename(fileName);
   boardservice.insertBoard(vo);
   return "main.do"; 
}
```

글 작성에 파일첨부를 할 수 있도록 하였습니다
BoardVO 필드에 MultipartFile uploadFile 를 추가 해줍니다.

```
private MultipartFile uploadFile;
```

servlet-context.xml에서 파일 업로드 빈을 등록 해주고 파일 사이즈를 정해줍니다.

```
<!-- 파일 업로드  -->
   <beans:bean id ="multipartResolver" class ="org.springframework.web.multipart.commons.CommonsMultipartResolver">
      <beans:property name="maxUploadSize" value="10000000"></beans:property>
   </beans:bean>
```

servlet-context.xml에서 파일이 저장된 경로를 설정해줍니다.

```
<resources mapping="/img/**" location="C:\Project 파일 업로드" />
```

server.xml에서 이미지 파일 경로를 지정해줍니다.

```
  <!-- 이미지 파일 경로 -->
   <Context docBase="C:\Project 파일 업로드" path="/img" reloadable="true"/>
```

form태그에서 파일을 입력받습니다.

```
<form action="insertBoard.do" method="post" enctype="multipart/form-data">
```

이미지를 불러올때 /img/ +  db에 저장된 파일이름 으로 불러옵니다.
```
<img width=1110px, height=600px src="/img/${board.filename }"  onerror="this.style.display='none';"/>
```

## 글 수정

![글수정 gif](https://user-images.githubusercontent.com/88939199/136687428-84cad32e-09f7-474f-abe0-a5220828b086.gif)

글 수정 페이지는 글 작성때 등록한 암호를 입력하지 않으면 수정이 안되게 만들었습니다.

```
<!-- 게시글 수정 -->
<update id="updateBoard">
   UPDATE BOARD SET TITLE=#{title},CONTENT=#{content} WHERE BOARDSEQ=#{boardseq} AND PASSWORD =#{password}
</update>
```
```
<!-- 글 수정 삭제 패스워드 체크 -->
<select id="boardPwdCheck" resultType="int">
   SELECT COUNT(*) FROM BOARD WHERE BOARDSEQ=#{boardseq} AND PASSWORD =#{password}
</select>
```

```
// 게시글 수정 뷰
@RequestMapping(value = "/updateBoardView.do", method = {RequestMethod.GET,RequestMethod.POST})
public String updateBoardView(BoardVO vo, Model model, Criteria cri) {
   model.addAttribute("cri", cri);
   model.addAttribute("updateBoard", boardservice.getBoard(vo.getBoardseq()));
   return "updateBoardView.jsp";
}
   
// 게시글 수정 
@RequestMapping(value = "/updateBoard.do", method = RequestMethod.POST)
public String updateBoard(BoardVO vo) {
   // 해당 게시글 데이터
   BoardVO getBoard = boardservice.getBoard(vo.getBoardseq());
   // 해당 게시글 비밀번호
   String getBoardpassword = getBoard.getPassword();
   // 사용자가 입력한 비밀번호
   String password = vo.getPassword();
   
   if(getBoardpassword.equals(password)) {
      boardservice.updateBoard(vo);
      return "main.do";
      }
   return "updateBoardView.do";
}
```

글 작성때 입력한 비밀번호를 가져와서 사용자가 입력한 비밀번호와 equals로 문자열 비교를 합니다.
맞으면 글 수정 처리, 게시글list로 보내주고 맞지 않으면 글 수정 페이지에 머무릅니다.

```
$('#mainBtn').click(function(){
      location.href = "main.do?page=${cri.page}"
   })
      
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
         
      if($('#password').val()==''){
         alert('암호을 입력하세요.');
         $('#password').focus();
         return false;
      }
      
      $.ajax({
         url : 'boardPwdCheck.do',
         type : 'post',
         datetype : 'json',
         data : $('#updateBoard').serializeArray(),
         success : function(date){
            if(date == 0){
               alert('암호가 일치하지 않습니다.');
               return;
            }else{
               if(confirm('수정하시겠습니까?')){
                  $('#updateBoard').submit();
                  alert('게시글이 수정되었습니다.');
               }
            }
         }
      })
   })
```

해당 게시글 번호와 암호가 일치하지 않으면 0 두 값이 일치하면 1을 반환 해줍니다.

컨트롤러로 보내는 암호는 equals로 문자열 비교를 해서 맞으면 글 수정 처리를 하고 맞지 않으면 그 페이지에 머무릅니다.

# 글 삭제

![게시글 삭제 gif](https://user-images.githubusercontent.com/88939199/136689314-30385b6b-74e0-4ab4-b56b-ed61ddcf9742.gif)


글 삭제도 수정과 같이 암호를 입력하지 않으면 삭제되지 않게 만들었습니다.

```
<!-- 게시글 삭제 -->
<delete id="deleteBoard">
   DELETE FROM BOARD WHERE BOARDSEQ=#{boardseq} AND PASSWORD =#{password}
</delete>
```

게시글 번호와 패스워드가 맞으면 삭제됩니다.

```
// 게시글 삭제 뷰
@RequestMapping(value = "/deleteBoardView.do", method = {RequestMethod.GET,RequestMethod.POST})
public String deleteBoardView(BoardVO vo, Model model, Criteria cri) {
   model.addAttribute("cri", cri);
   model.addAttribute("deleteBoard", boardservice.getBoard(vo.getBoardseq()));
   return "deleteBoardView.jsp";
}
   
// 게시글 삭제 
@RequestMapping(value = "/deleteBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
public String deleteBoard(BoardVO vo) {
   // 해당 게시글 데이터
   BoardVO getBoard = boardservice.getBoard(vo.getBoardseq());
   // 해당 게시글 비밀번호
   String getBoardpassword = getBoard.getPassword();
   // 사용자가 입력한 비밀번호
   String password = vo.getPassword();
   
   if(getBoardpassword.equals(password)) {
      boardservice.deleteBoard(vo);
      return "main.do";
   }
   return "deleteBoardView.do";
}
```

글 작성때 입력한 비밀번호를 가져와서 사용자가 입력한 비밀번호와 equals로 문자열 비교를 합니다.
맞으면 글 삭제 처리, 메인으로 보내줍니다.
맞지 않으면 암호 페이지에 머무릅니다.

```
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
```

## 게시글 검색, 페이징

![검색 페이징 gif](https://user-images.githubusercontent.com/88939199/136689594-baa63a7b-e994-4639-9f2d-7aeed8bf965b.gif)

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

## 글 추천,반대

![게시글 추천반대 GIF](https://user-images.githubusercontent.com/88939199/136690724-a5edcef3-c728-4e6e-a99b-7b730b40f86d.gif)

```
<!-- 게시글 추천 -->
<update id="upCountBoard" parameterType="int">
   UPDATE BOARD SET COUNT = COUNT + 1 WHERE BOARDSEQ =#{boardseq}
</update>
```
```
<!-- 게시글 반대 -->
<update id="downCountBoard" parameterType="int">
   UPDATE BOARD SET COUNT = COUNT - 1 WHERE BOARDSEQ =#{boardseq}
</update>
```
```
// 게시글 추천
@RequestMapping(value = "/upCountBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
public String upCountBoard(BoardVO vo) {
   boardservice.upCount(vo.getBoardseq());
   return "getBoard.do";
}
```
```
// 게시글 반대
@RequestMapping(value = "/downCountBoard.do", method = {RequestMethod.GET,RequestMethod.POST})
public String downCountBoard(BoardVO vo) {
   boardservice.downCount(vo.getBoardseq());
   return "getBoard.do";
}
```


```
<p>추천수 ${board.count }
<!-- 게시글 추천 -->
<a id="upCountBoardBtn" href="upCountBoard.do?boardseq=${board.boardseq}&page=${cri.page}">👍</a>
<!-- 게시글 반대 -->
&nbsp;<a id="downCountBoardBtn" href="downCountBoard.do?boardseq=${board.boardseq}&page=${cri.page}">👎</a></p> 
```
추천과 반대를 클릭하면 글 수정, 글 삭제와 같이 페이징 유지가 되도록 만들었습니다. 

👍,👎를 누르게 되면 해당 컨트롤러로 이동하여 추천수가 변하도록 만들었습니다.


## 댓글 등록

![댓글등록 gif](https://user-images.githubusercontent.com/88939199/136691126-430cd119-2f13-47ff-963f-8646ebc47774.gif)

```
<!-- 댓글 입력 -->
<insert id="insertreply">
   INSERT INTO REPLY (BOARDSEQ,WRITER,CONTENT,PASSWORD) VALUES (#{boardseq},#{writer},#{content},#{password})
</insert>
```

```
// 댓글 등록
@RequestMapping(value = "/insertReply.do" , method = {RequestMethod.GET, RequestMethod.POST})
public String insertReply(ReplyVO rvo, Model model, Criteria cri) {
   model.addAttribute("cri", cri);
   replyservice.insertReply(rvo);
   return "getBoard.do";
  }
```
```
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
```
글 상세 보기의 폼을 두 개로 나누어서(글 상세보기, 댓글 리스트 폼 과 댓글 폼) 
댓글 작성을 하고 댓글 작성 버튼을 누르게 되면 댓글작성 폼 안에 있는 내용들이 컨트롤러로 이동하게 됩니다.

글 리스트에서 게시글번호, 페이징번호를 같이 넘겨주어서 댓글을 작성하게 되면 해당 게시글로 이동하고 페이징 유지가 되게 만들었습니다.


## 댓글 수정

![댓글 수정 gif](https://user-images.githubusercontent.com/88939199/136736637-24ea7086-6de8-470a-9298-7bbdf9a3a833.gif)

```
<!-- 댓글 수정 -->
<update id="updatereply">
   UPDATE REPLY SET CONTENT=#{content} WHERE REPLYSEQ =#{replyseq} AND PASSWORD =#{password}
</update>
```
```
// 댓글 수정 뷰
   @RequestMapping(value = "/updateReplyView.do" , method = {RequestMethod.GET,RequestMethod.POST})
   public String updateReplyView(ReplyVO rvo, Model model, Criteria cri) {
      model.addAttribute("cri", cri);
      model.addAttribute("updateReply", replyservice.selectReply(rvo.getReplyseq()));
      return "updateReplyView.jsp";
   }
      
   // 댓글 수정
   @RequestMapping(value = "/updateReply.do", method = {RequestMethod.GET,RequestMethod.POST})
   public String updateReply(ReplyVO rvo) {
      
      ReplyVO selectreply = replyservice.selectReply(rvo.getReplyseq()); 
      
      String replypassword = selectreply.getPassword();
      String password = rvo.getPassword();
      
      if(replypassword.equals(password)) {
         replyservice.updateReply(rvo);
         return "getBoard.do";
      }
      return "updateReplyView.do";
   }
```

댓글작성시 입력한 암호를 통해서 댓글수정,댓글삭제 하도록 하였습니다.

db에 저장된 댓글 암호와 사용자가 입력한 댓글 암호를 비교하여 맞으면 수정처리, 맞지 않으면 댓글 수정에 머무르게 만들었습니다.

```
$(function(){
   $('#updateReplyBtn').click(function(){
      
      if($('#content').val()==''){
         alert('댓글 내용을 입력해주세요.');
         $('#content').focus();      
         return false;
      }
      if($('#password').val()==''){
         alert('암호를 입력해주세요.');
         $('#password').focus();
         return false;
      }
      alert('댓글 수정이 완료되었습니다.');
   })
   
}); 
```

## 댓글 삭제 

![댓글 삭제 gif](https://user-images.githubusercontent.com/88939199/136737168-749371a1-1a99-4c93-900d-a60a8a8fe5f7.gif)

```
<!-- 댓글 삭제 -->
<delete id="deletereply">
   DELETE FROM REPLY WHERE REPLYSEQ = #{replyseq} AND PASSWORD =#{password}
</delete>
```

```
   // 댓글 삭제 뷰
   @RequestMapping(value = "/deleteReplyView.do", method = {RequestMethod.GET,RequestMethod.POST})
   public String deleteReplyView(ReplyVO rvo, Model model, Criteria cri) {
      model.addAttribute("cri", cri);
      model.addAttribute("deleteReply", replyservice.selectReply(rvo.getReplyseq()));
      return "deleteReplyView.jsp";
   }
   
   // 댓글 삭제
   @RequestMapping(value = "/deleteReply.do", method = {RequestMethod.GET,RequestMethod.POST})
   public String deleteReply(ReplyVO rvo){      
      
      ReplyVO selectreply = replyservice.selectReply(rvo.getReplyseq()); 
      
      String replypassword = selectreply.getPassword();
      String password = rvo.getPassword();
      
      if(replypassword.equals(password)) {
         replyservice.deleteReply(rvo);
         return "getBoard.do";
      }
      return "deleteReplyView.do";
   }
```

댓글 삭제도 댓글 작성시 입력한 암호를 통해서 삭제되게 만들었습니다.

## 댓글 추천,반대

![댓글 추천 반대 gif](https://user-images.githubusercontent.com/88939199/136737723-7eb70ed2-24f6-4bb1-854b-0e272c5eb3c9.gif)

```
<!-- 댓글 추천 -->
<update id="upCountReply" parameterType="int">
   UPDATE REPLY SET COUNT = COUNT + 1 WHERE REPLYSEQ =#{replyseq}
</update>

<!-- 댓글 비추천 -->
<update id="downCountReply"  parameterType="int">
   UPDATE REPLY SET COUNT = COUNT - 1 WHERE REPLYSEQ =#{replyseq}
</update>
```

```
   // 댓글 추천
   @RequestMapping(value = "/upCountReply.do", method = {RequestMethod.GET,RequestMethod.POST})
   public String upCountReply(ReplyVO rvo) {
      replyservice.upCountReply(rvo.getReplyseq());
      return "getBoard.do";
   }
   
   // 댓글 반대
   @RequestMapping(value = "/downCountReply.do", method = {RequestMethod.GET,RequestMethod.POST})
   public String downCountReply(ReplyVO rvo) {
      replyservice.downCountReply(rvo.getReplyseq());
      return "getBoard.do";
   }
```

댓글 추천과 반대는 게시글 추천 반대와 마찬가지로 a태그에 해당 메서드 경로와 게시글 번호, 페이징 번호, 댓글번호를 설정하여 추천,반대를 눌렀을때도 해당 게시글 번호로 돌아오고 페이징 유지도 되게 만들었습니다.

```
<label>${reply.writer } ${reply.regdate } 추천수 ${reply.count }
   <a href="upCountReply.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=${reply.replyseq}"  id="upCountReplyBtn" >👍</a>
   <a href="downCountReply.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=${reply.replyseq}"  id="downCountReplyBtn" >👎</a>
   <a href="updateReplyView.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=${reply.replyseq}">수정</a>
   <a href="deleteReplyView.do?boardseq=${board.boardseq}&page=${cri.page}&replyseq=${reply.replyseq}">삭제</a>
</label>
```
