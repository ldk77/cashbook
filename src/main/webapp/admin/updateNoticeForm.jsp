<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//요청분석
	int noticeNo= Integer.parseInt(request.getParameter("noticeNo"));
%>


<!DOCTYPE html>
<html>
</head>
<body>
	<h1>공지 수정</h1>
	<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp">
		<table border="1">
			<tr>
				<td>공지번호</td>
				<td>
					<input type= "text" name="noticeNo" value="<%=noticeNo%>" readonly="readonly">
				</td>
			</tr>
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