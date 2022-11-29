<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
		}
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>문의하기</h1>
	<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp">
	<table border="1">
		<tr>
			<td>답변내용</td>
			<td>
				<textarea rows="7" cols="100" name="helpMemo"></textarea>
			</td>
		</tr>
	</table>	
		<button type = "submit">문의하기</button>	
	</form>
	<a href="<%=request.getContextPath()%>/help/helpList.jsp">돌아가기</a>	
</body>
</html>