<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//세션정보	
	
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
		}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();

	
	// Model 호출	
	HelpDao helpDao = new HelpDao(); 
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);				
%>
<!DOCTYPE html>
<html>
<head>
<style>
table {
	border: 1px #a39485 solid;
	font-size: .9em;
	box-shadow: 0 2px 5px rgba(0,0,0,.25);
	width: 100%;
	border-collapse: collapse;
	border-radius: 5px;
	overflow: hidden;
	}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>고객센터</title>
</head>
<body>
	<div class="text-center">
		<h1>고객센터</h1>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<table class = "table table-hover w-100 rounded" style="table-layout: auto; width: 100%; table-layout: fixed;">
		<tr>
			<th>문의내용</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list){
		%>
				<tr>
					<td><%=m.get("helpMemo")%></td>
					<td><%=m.get("helpCreatedate")%></td>
					<td>
						<%
							if(m.get("commentMemo") == null){
						%>
								답변대기
						<%		
							} else{
						%>
								<%=m.get("commentMemo")%>	
						<%									
							}
						%>					
					</td>
					<td>
						<%
							if(m.get("commentCreatedate") == null){
						%>
								답변대기
						<%		
							} else{
						%>
								<%=m.get("commentCreatedate")%>	
						<%									
							}
						%>
					</td>			
					<td>
						<%
							if(m.get("commentMemo") == null){
						%>
								<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>">수정</a>
						<%		
							} else{
						%>
								&nbsp;
						<%									
							}
						%>	
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null){
						%>
								<a href="<%=request.getContextPath()%>/help/deleteHelpAction.jsp?helpNo=<%=m.get("helpNo")%>">삭제</a>
						<%		
							} else{
						%>
								&nbsp;
						<%									
							}
						%>	
					</td>
				</tr>
		<%		
			}
		%>
	</table>
	<a href="<%=request.getContextPath()%>/cash/cashList.jsp">이전화면</a>
	<div class="position-relative">
		<a class = "position-absolute top-0 end-0" href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의하기</a>		
	</div>
</body>
</html>