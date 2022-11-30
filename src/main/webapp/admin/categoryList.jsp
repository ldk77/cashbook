<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginFrom.jsp");
		return;
	} 
	// model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> list = categoryDao.selectCategoryListByAdmin();
	 
	
	//view


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<jsp:include page="/admin/nav.jsp"></jsp:include>
	<div>
		<!-- category contents,, -->
		<h1>카테고리목록</h1>
		<a href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가</a>
		<table>
			<tr>
				<th>번호</th>
				<th>수입/지출</th>
				<th>이름</th>
				<th>수정날짜</th>
				<th>생성날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		<%
			for(Category c : list){
		%>
			<tr>
				<td><%=c.getCategoryNo()%></td>
				<td><%=c.getCategoryKind() %></td>
				<td><%=c.getCategoryName()%></td>
				<td><%=c.getUpdatedate()%></td>
				<td><%=c.getCreatedate() %></td>
				<td><a href="<%=request.getContextPath()%>/admin/updateCategryForm.jsp?categoryNo=<%=c.getCategoryNo()%>&categoryName=<%=c.getCategoryName()%>&categoryKind=<%=c.getCategoryKind()%>">수정</a></td>
				<td><a href="<%=request.getContextPath()%>/admin/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
			</tr>
		<%	
			} 
		%>	
			<!-- 모델데이터 카테고리리스트 출력 -->
		</table>
	</div>
</body>
</html>
