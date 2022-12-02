<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%	//세션정보	
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
		}
	// Controller	
	Member loginMember = (Member)session.getAttribute("loginMember");
	// M호출 
	MemberDao memberDao = new MemberDao();
	ArrayList<HashMap<String, Object>> list = memberDao.selectMemberList(loginMember.getMemberId());

%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Register</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body class="bg-gradient-primary">>
	<!-- cash 수정 폼 -->
    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">               
                    <div class="col-lg-7">
                        <div class="p-5">	
	<h1>회원정보 수정</h1>
	<div>
		사용자 : <%=loginMember.getMemberName() %>
	</div>
	<form action = "<%=request.getContextPath()%>/cash/updateLoginAction.jsp">
	<table>
		<tr>
			<td>ID</td>
			<td>
				<input type ="text" name="memberId" value=<%=loginMember.getMemberId() %> readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>기존이름</td>
			<td>
				<input type ="text" name="memberName" value=<%=loginMember.getMemberName() %> readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>변경할 이름</td>
			<td>
				<input type= "text" name="memberNewName">
			</td>			
		</tr>
		<tr>
			<td>비밀번호확인</td>
			<td>
				<input type= "password" name="memberPw">
			</td>
		</tr>
		<tr>		
			<td>
		    <button type="submit">수정완료</button>
			</td>
		</tr>
	</table>
	</form>
	<a href = "<%=request.getContextPath()%>/cash/cashList.jsp">[이전화면]</a>
	<%
		if(request.getParameter("msg")!= null)
		{
	%>
			<div><%=request.getParameter("msg") %></div>
	<%		
		}
	%>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>