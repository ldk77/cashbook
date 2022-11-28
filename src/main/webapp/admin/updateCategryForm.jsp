<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginFrom.jsp");
		return;
	}
	//요청분석
	int categoryNo= Integer.parseInt(request.getParameter("categoryNo"));
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>카테고리 수정</h1>
	<div>
		<table>
			<tr>
				<td>기존 수입/지출</td>
				<td>[<%=categoryKind%>]</td>
			</tr>
			<tr>
				<td>기존이름</td>
				<td>[<%=categoryName%>]</td>
			</tr>
		</table>
	</div>
	<div>
	<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp" method="post">
		<!--  -->
		<table border="1">
			<tr> 
				<td>categoryNo</td>
				<td>
					<input type="text" name="categoryNo" value="<%=categoryNo%>" readonly="readonly">
				</td>	 
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
	</div>
</body>
</html>