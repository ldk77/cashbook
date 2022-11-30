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
  background: url("./images/dg_5.jpg");
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

    <link rel="stylesheet" href="fonts/icomoon/style.css">

    <link rel="stylesheet" href="css/owl.carousel.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    
    <!-- Style -->
    <link rel="stylesheet" href="css/style.css">

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
	        	<form action="<%=request.getContextPath()%>/insertAction.jsp" method="post">
		          	<div class="form-group first">
		            	<label for="username">UserId</label>
		            	<input type="text" class="form-control" id="username"  name="memberId">
		            </div>
		            <div class="form-group last mb-4">
		            	<label for="password">Password</label>
		                <input type="password" class="form-control" id="password" name="memberPw">                    
		            </div>                  
		          	<div class="form-group first">
		            	<label for="username">UserName</label>
		            	<input type="text" class="form-control" id="username"  name="memberName">
		            </div>
	                  	<input type="submit" value="회원가입" class="btn btn-pill text-white btn-block btn-primary">   
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
	</body>
</html>