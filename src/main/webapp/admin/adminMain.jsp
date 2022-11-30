<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dao.*"%>
<%@ page import = "vo.*" %>
<%
	request.setCharacterEncoding("UTF-8"); 
	// Controller 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginFrom.jsp");
		return;
	} 
	int beginRow = 0;
	int rowPerPage = 5;	
	//Model 호출
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	HelpDao helpDao = new HelpDao();	
	//최근 공지사항 5개, 최근 가입한 멤버 5명, 최근 문의사항
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);	
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);	
	ArrayList<HashMap<String,Object>> helpList = helpDao.selectHelpList(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/admin/nav.jsp"></jsp:include>
	<div>
		<h2>최신공지</h2>
		<table class="table table-bordered text-center">
			<tr>
				<th>공지내용</th>
				<th>공지일자</th>
			</tr>			
			<%
				for(Notice n : noticeList) {
			%>
				<tr>
					<td><%=n.getNoticeMemo() %></td>
					<td><%=n.getCreatedate() %></td>
				</tr>
			<%
			}
			%>		
		</table>
	</div>
	<div>
		<h2>신규 가입회원</h2>
		<table class="table table-bordered text-center">
			<tr>
				<th>회원 이름</th>
				<th>회원 가입일</th>
			</tr>			
			<%
				for(Member m : memberList) {
			%>
				<tr>
					<td><%=m.getMemberName() %></td>
					<td><%=m.getCreatedate() %></td>
				</tr>	
			<%
			}
			%>			
		</table>
	</div>		
	<div>
		<h2>최근 문의사항</h2>
		<table class="table table-bordered text-center">
			<tr>
				<th>문의 내용</th>
				<th>문의한 날짜</th>
			</tr>			
			<%
				for(HashMap<String,Object> m : helpList) {
			%>
				<tr>
					<td><%=m.get("helpMemo") %></td>
					<td><%=m.get("helpCreatedate") %></td>
				</tr>
			<%
			}
			%>			
		</table>
	</div>		
</body>
</html>
