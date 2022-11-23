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

	// Controller
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));	
	
	// Model 호출
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> dateList = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);	
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>수정</h1>
	<!-- cash 수정 폼 -->
	<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<input type="hidden" name="year" value="<%=year%>"> 
		<input type="hidden" name="month" value="<%=month%>"> 
		<input type="hidden" name="date" value="<%=date%>"> 
		<input type="hidden" name="cashNo" value="<%=cashNo%>"> 			
		<table border="1">
			<tr>
				<td>categoryNo</td>				
				<td>
					<select name = "categoryNo">
						<%
							for(Category c : categoryList) {
						%>
								<option value="<%=c.getCategoryNo()%>">
									<%=c.getCategoryKind()%> <%=c.getCategoryName()%>
								</option>
						<%
							}
						%>
					</select>					
				</td>				
			</tr>		
			<tr>
				<td>cashDate</td>
				<td>
					<input type="text" name="cashDate" 
						value="<%=year%>-<%=month-1%>-<%=date%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>cashPrice</td>
				<td><input type="number" name="cashPrice" min="10000" max="100000"></td>
			</tr>
			<tr>
				<td>cashMemo</td>
				<td>
					<textarea rows="3" cols="50" name="cashMemo"></textarea>
				</td>
			</tr>			
		</table>
		<button type="submit">입력</button>
	</form>	
	<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month-1%>&date=<%=date%>&cashNo=<%=cashNo%>">이전화면</a>	
</body>
</html>