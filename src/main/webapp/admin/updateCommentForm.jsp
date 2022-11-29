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
	
	int commentNo= Integer.parseInt(request.getParameter("commentNo"));
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	CommentDao commentDao = new CommentDao();
	ArrayList<HashMap<String,Object>> list = commentDao.selectCommentOne(commentNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>답변수정</h1>
	<h2>기존답변내용</h2>
	<div>
		<table border ="1">
			<tr>
				<th>기존답변내용</th>				
			</tr>
			<%
				for(HashMap m : list){
			%>
					<tr>
						<td><%=m.get("commentMemo")%></td>						
					</tr>
			<%		
				}
			%>
		</table>		
	</div>
	<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp" method="post">
	<table border="1">
		<tr>
			<td>답변번호</td>
			<td>
				<input type= "text" name="commentNo" value="<%=commentNo%>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>답변내용수정</td>
			<td>
				<textarea rows="7" cols="100" name="commentMemo"></textarea>
			</td>
		</tr>
		<button type = "submit">수정완료</button>	
	</table>
</body>
</html>