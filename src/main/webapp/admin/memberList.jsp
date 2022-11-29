<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
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
	//페이징		
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	// model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	int memberCount = memberDao.selectMemberCount();// ->lastPage
	int lastPage = (int)(Math.ceil((double)memberCount / (double)rowPerPage));	


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
		<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a></li>
	</ul>
	<div>
		<!-- member contents,, -->
		<h1>멤버목록</h1>
		<table border="1">
			<tr>
				<th>멤버번호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막수정일자</th>
				<th>생성일자</th>
				<th>레벨수정</th>
				<th>강제탈퇴</th>
			</tr>
			<%
				for(Member m : list){
			%>
				<tr>	
					<td><%=m.getMemberNo()%></td>
					<td><%=m.getMemberId()%></td>
					<td><%=m.getMemberLevel()%></td>
					<td><%=m.getMemberName()%></td>
					<td><%=m.getUpdatedate()%></td>
					<td><%=m.getCreatedate()%></td>
					<td><a href="<%=request.getContextPath()%>/admin/updateMemberLevelForm.jsp?memberName=<%=m.getMemberName()%>&memberId=<%=m.getMemberId()%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/admin/deleteMemberAction.jsp?memberId=<%=m.getMemberId()%>">강퇴</a></td>
				</tr>	
			<%			
				}
			%>			
		</table>		
	</div>
		<div>
		<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>			
		<%
			if(currentPage > 1){
		%>
				<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
		}
		%>
				<a><%=currentPage%></a>			
		<%
			if(currentPage < lastPage){
		%>
				<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
		}
		%>
				<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>	
</body>
</html>
