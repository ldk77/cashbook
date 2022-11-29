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
	
	int helpNo= Integer.parseInt(request.getParameter("helpNo"));
	Help help = new Help();
	help.setHelpNo(helpNo);
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String,Object>> list = helpDao.selectHelpOne(helpNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>답변작성</h1>
	<div>
		<table border ="1">
			<tr>
				<th>문의내용</th>				
			</tr>
			<%
				for(HashMap m : list){
			%>
					<tr>
						<td><%=m.get("helpMemo")%></td>						
					</tr>
			<%		
				}
			%>
		</table>		
	</div>
	<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
	<table border="1">
		<tr>
			<td>문의번호</td>
			<td>
				<input type= "text" name="helpNo" value="<%=helpNo%>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>답변내용</td>
			<td>
				<textarea rows="7" cols="100" name="commentMemo"></textarea>
			</td>
		</tr>
	</table>	
		<button type = "submit">완료</button>	
	</form>	
	<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">돌아가기</a>
</body>	
</body>
</html>