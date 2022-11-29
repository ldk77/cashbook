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
<meta charset="UTF-8">
<title>고객센터</title>
</head>
<body>
	<h1>고객센터</h1>
	<div>
		<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의하기</a>		
	</div>
	<table border="1">
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
</body>
</html>