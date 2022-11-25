<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>공지 작성</h1>
	<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp">
		<table border="1">
			<tr>
				<td>공지내용</td>
				<td>
					<textarea rows="3" cols="50" name="noticeMemo"></textarea>
				</td>
			</tr>			
		</table>
		<button type = "submit">입력</button>
	</form>
</body>
</html>