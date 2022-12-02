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

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Register</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body class="bg-gradient-primary">>
	<!-- cash 수정 폼 -->
    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">               
                    <div class="col-lg-7">
                        <div class="p-5">	
	
	<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<input type="hidden" name="year" value="<%=year%>"> 
		<input type="hidden" name="month" value="<%=month%>"> 
		<input type="hidden" name="date" value="<%=date%>"> 
		<input type="hidden" name="cashNo" value="<%=cashNo%>"> 			
		<table class="table table-bordered">
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
</div>
</div>
</div>
</div>
</div>
</div>



</body>
</html>