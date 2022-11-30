<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
		}
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table {
		border: 1px #a39485 solid;
		font-size: .9em;
		box-shadow: 0 2px 5px rgba(0,0,0,.25);
		border-collapse: collapse;
		border-radius: 5px;
		margin-left: auto; 
		margin-right: auto;
		width: 80%;
		}
	th{text-align : center; font-size: 25px
		}			
	textarea {
		width: 100%;
		}		
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="text-center">
	<h1>문의하기</h1>
	<br>
	<br>
	<br>
	<br>
	<br>
	</div>
	<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp">
	<table class="table table-bordered">
		<tr>
			<th>문의내용</th>
		</tr>
		<tr>			
			<td>
				<textarea rows="7" cols="100" name="helpMemo"></textarea>
			</td>
		</tr>
	</table>
		<div class="position-relative" Style="padding: 1em;">
			<button type="submit"  class="position-absolute top-100 start-50 translate-middle"><h2>등록</h2></button>
		</div>
	</form>
	<a href="<%=request.getContextPath()%>/help/helpList.jsp"><h5>돌아가기</h5></a>	
</body>
</html>