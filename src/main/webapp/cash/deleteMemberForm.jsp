<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원탈퇴</h1>
	<form action="<%=request.getContextPath()%>/cash/deleteMemberAction.jsp">
		<table border="1">
			<tr>
				<td>회원아이디</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>회원패스워드</td>
				<td><input type="password" name="memberPw"></td>
			</tr>					
		</table>
		<button type = "submint">회원탈퇴</button>	
	</form>
</body>
</html>