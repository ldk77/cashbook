<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginFrom.jsp");
		return;
	}
	
	//페이징 
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	
	
	HelpDao helpDao = new HelpDao();	
	int cnt = helpDao.selectHelpCount();
	int lastPage = (int)(Math.ceil((double)cnt / (double)rowPerPage));
	
	ArrayList<HashMap<String,Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
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
		<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a></li>
	</ul>
	<!-- 고객센터 문의 목록 -->	
	<table border="1">
		<tr>
			<th>문의내용</th>
			<th>회원ID</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>답변추가/ 수정 / 삭제</th>
		</tr>
		<%
			for(HashMap m : list){
		%>
			<tr>
				<td><%=m.get("helpMemo")%></td>
				<td><%=m.get("memberId") %></td>
				<td><%=m.get("helpCreatedate") %></td>
				<td><%=m.get("commentMemo")%></td>
				<td><%=m.get("commentCreatedate")%></td>
				<td>
					<%
						if(m.get("commentMemo") == null){
					%>
							<a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">
								답변입력
							</a>
					<%	
						} else{
					%>
							<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">답변수정</a>
							<a href="<%=request.getContextPath()%>/admin/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>">답변삭제</a>
					<%		
						}
					%>
				</td>
			</tr>
			
		<%	
			}
		%>
	</table>
	<!-- 페이징 -->
	<div>
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a>			
		<%
			if(currentPage > 1){
		%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
		}
		%>
				<a><%=currentPage%></a>			
		<%
			if(currentPage < lastPage){
		%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
		}
		%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>	
	<!-- footer include -->	
</body>
</html>