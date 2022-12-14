<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="reset.css" />
<style>	
.content:after {
  width: 100%;
  height: 100%;
  content: "";
  background: url("./loginboot/images/dg_5.jpg");
  position: absolute;
  top: 0;
  left: 0;
  z-index: -1;
  opacity: 0.5;
}	
</style>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="./loginboot/fonts/icomoon/style.css">

    <link rel="stylesheet" href="./loginboot/css/owl.carousel.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="./loginboot/css/bootstrap.min.css">
    
    <!-- Style -->
    <link rel="stylesheet" href="./loginboot/css/style.css">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<body class="content">	
    <div>
   	<br>
   	<br>
   	<br>
   	<br>
   	<br>
   	<br>
   	<br>
   	<br>
   	<br>
      <div class="container">
        <div class="row align-items-center">
          <div class="col-md-3">		
          </div>
          <div class="col-md-5 contents">	
    	<div class="form-block">
	     	<div class="mb-12">
	            <h1>회원가입</h1>           
	        </div>
	        	<form id="signinForm" action="<%=request.getContextPath()%>/insertAction.jsp" method="post">
		          	<div class="form-group first">		            	
		            	ID: <input type="text" class="form-control" id="memberId"  name="memberId" value="">
		            </div>
		            <div class="form-group last mb-4">		            	
		                PW: <input type="password" class="form-control" id="memberPw" name="memberPw" value="">                    
		            </div>                  
		          	<div class="form-group first">
		            	NAME: <input type="text" class="form-control" id="memberName"  name="memberName" value="">
		            </div>
	                  	<button type="button" id="signinBtn" class="btn btn-pill text-white btn-block btn-primary">
                  		회원가입
                  		</button> 
               	</form>
               	<a href="<%=request.getContextPath()%>/loginForm.jsp">로그인화면</a>  
			 </div>
          </div>
         </div>
        </div>  
         	<%
          		if(request.getParameter("msg")!= null){
         	%>
				<div><%=request.getParameter("msg") %></div>
			<%
			}
			%>
		    <script src="js/jquery-3.3.1.min.js"></script>
		    <script src="js/popper.min.js"></script>
		    <script src="js/bootstrap.min.js"></script>
		    <script src="js/main.js"></script>	
			<script>
		    let signinBtn = document.querySelector('#signinBtn');
		    
		    signinBtn.addEventListener('click', function(){
		       // 디버깅
		       console.log('siginBtn clik!');        		
		       
		       
		       // ID 폼 유효성 검사
		       let memberId = document.querySelector('#memberId');
		       if(memberId.value == '') {
		          alert('id를 입력하세요');
		          memberId.focus(); // 브라우저의 커스를 id태그로 이동
		          return;
		       }
		       
		       // PW 폼 유효성 검사
		       let memberPw = document.querySelector('#memberPw');       
		       if(memberPw.value == '' ) {
		          alert('pw를 확인하세요');
		          memberPw.focus();
		          return;
		       }      
		       // name 폼 유효성검사
		    	let memberName = document.querySelector('#memberName');       
		       if(memberName.value == '' ) {
		          alert('이름을 확인하세요');
		          memberName.focus();
		          return;
		       }      
		       
		       let signinForm = document.querySelector('#signinForm');
		       signinForm.submit(); // action="./signinAction.jsp"
		    });
		    </script>	
	</body>	
</html>