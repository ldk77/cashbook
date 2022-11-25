<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String memberName = request.getParameter("memberName");
	String memberId = request.getParameter("memberId");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 레벨 변경</h1>
	<form action="<%=request.getContextPath()%>/admin/updateMemberAction.jsp">
		<table>
			<tr>
				<td>ID</td>
				<td><input type = "text" name="memberId" value= "<%=memberId%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>회원이름</td>
				<td><input type = "text" name="memberName" value= "<%=memberName%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>회원레벨</td>
				<td>
					<input type = "radio" value="0" name="memberLevel">0 (일반회원)
					<input type = "radio" value="1" name="memberLevel">1 (관리자)
				</td>
			</tr>
		</table>
		<button type="submit">완료</button>
	</form>
</body>
</html>