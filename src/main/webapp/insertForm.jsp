<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="<%=request.getContextPath()%>/insertAction.jsp">
		<table border="1">
			<tr>
				<td>회원아이디</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>회원패스워드</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
			<tr>
				<td>회원이름</td>
				<td><input tpye="text" name="memberName"></td>
			</tr>			
		</table>
		<button type = "submit">회원가입완료</button>	
	</form>
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