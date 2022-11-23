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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
</body>
</html>