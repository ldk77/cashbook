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
	// model : notice list 
	//페이징 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	
	
	NoticeDao noticeDao = new NoticeDao();	
	int cnt = noticeDao.selectNoticeCount();	
	int lastPage = (int)(Math.ceil((double)cnt / (double)rowPerPage));
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	// View 
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
		<!-- notice contents,, -->
		<h1>공지</h1>
		<a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지입력</a>
		<table border ="1">
			<tr>
				<th>공지내용</th>
				<th>공지날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(Notice n : list){
			%>
					<tr>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>						
						<td><a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/admin/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>						
					</tr>
			<%		
				}
			%>
		</table>		
	</div>
		<!-- 페이징 -->
	<div>
		<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>			
		<%
			if(currentPage > 1){
		%>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
		}
		%>
				<a><%=currentPage%></a>			
		<%
			if(currentPage < lastPage){
		%>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
		}
		%>
				<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>	
</body>
</html>
