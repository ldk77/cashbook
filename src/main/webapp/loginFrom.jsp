<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<h1>로그인</h1>
	<form action="<%=request.getContextPath()%>/loginAction.jsp">
		<div>
			ID:
			<input type="text" name="memberId">
		</div>
		<div>
			PW:
			<input type="text" name="memberPw">
		</div>
		<div>
			<button type="submit">로그인</button>
		</div>
	</form>
</body>
</html>