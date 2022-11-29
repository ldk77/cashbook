<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginFrom.jsp");
		return;
	}
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>카테고리 작성</h1>
	<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
		<!--  -->
		<table>
			<tr>
				<td>수입/지출</td>
				<td>	
					<input type="radio" name="categoryKind" value="수입">수입
					<input type="radio" name="categoryKind" value="지출">지출
				</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>
					<input type="text" name="categoryName">
				</td>	
			</tr>		
		</table>
		<button type = "submit">완료</button>
	</form>
	<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">돌아가기</a>	
</body>
</html>