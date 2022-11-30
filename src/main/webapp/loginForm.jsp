<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	//로그인이 되어 있을때는 접근불가
	if(session.getAttribute("loginMember") != null)
	{
		response.sendRedirect(request.getContextPath()+"/logout.jsp");
		return;
	}
	
	//페이징 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	
	
	NoticeDao noticeDao = new NoticeDao();	
	int cnt = noticeDao.selectNoticeCount();	
	int lastPage = (int)(Math.ceil((double)cnt / (double)rowPerPage));
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);

%>
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
 th{font-size: 25px}
 td{font-size: 20px}
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

    <title>Login #10</title>
<meta charset="UTF-8">
<title>loginForm</title>
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
          <div class="col-md-6">          
			<table class="table">
				<tr>
					<th>공지내용</th>
					<th>공지일</th>
				</tr>
				<%
					for(Notice n : list){
				%>
						<tr>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getCreatedate()%></td>
						</tr>
				<%		
					}
				%>
			</table>
				<!-- 페이징 -->
				<br>
				<div style = "float: right;">
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1"><span style="color: #000000">처음</span></a>			
					<%
						if(currentPage > 1){
					%>
							<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">
							<span style="color: #000000">이전</span></a>
					<%
					}
					%>
							<a><%=currentPage%></a>			
					<%
						if(currentPage < lastPage){
					%>
							<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>"><span style="color: #000000">다음</span></a>
					<%
					}
					%>
							<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>"><span style="color: #000000">마지막</span></a>
				</div>			
			
          </div>
          <div class="col-md-6 contents">
            <div class="form-block">
	            <div class="mb-10">
	                  <h3>Sign In to <strong>CashList</strong></h3>                 
	            </div>
	                <form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
	                  <div class="form-group first">
	                    <label for="username">Username</label>
	                    <input type="text" class="form-control" id="username"  name="memberId">
	                  </div>
	                  <div class="form-group last mb-4">
	                    <label for="password">Password</label>
	                    <input type="password" class="form-control" id="password" name="memberPw">                    
	                  </div>                  
	                  <div class="d-flex mb-5 align-items-center">
	                    <label class="control control--checkbox mb-0"><span class="caption">Remember me</span>
	                      <input type="checkbox" checked="checked"/>
	                      <div class="control__indicator"></div>
	                    </label>                    
                  	</div>
                  		<input type="submit" value="Log In" class="btn btn-pill text-white btn-block btn-primary">    
                	</form>               
                		<a href="<%=request.getContextPath()%>/insertForm.jsp" metohd="post">
                		회원가입
                		</a>          
             </div>
          </div>
        </div>
      </div>
  	</div>
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
  </body>
</html>