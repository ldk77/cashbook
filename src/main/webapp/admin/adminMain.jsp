<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	// Controller 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginFrom.jsp");
		return;
	} 
	// model 호출
	
	// 최근공지 5개, 최근멤버 5명 
	
	//view


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">맴버관리(목록,레벨수정,강제탈퇴)</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">고객센터관리</a></li>
	</ul>
	<div>
		<!-- adminMain contents,, -->
	</div>
	<a href="<%=request.getContextPath()%>/cash/cashList.jsp">가계부리스트</a>
</body>
</html>
