<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// Controller : seesion, request
	 if(session.getAttribute("loginMember")==null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	// session에 저장된 멤버(현재 로그인)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// request 년 + 월
	int year = 0;
	int month = 0;
	
	if((request.getParameter("year") == null) || request.getParameter("month") == null) 
	{
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} 
	else 
	{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1, month -> 12 일경우
		if(month == -1) 
		{
			month = 11;
			year -= 1;
		}
		if(month == 12) 
		{
			month = 0;
			year += 1;
		}
	}
	
	// 출력하고자 하는 년,월과 월의 1일의 요일(일 1, 월 2, 화 3, ... 토 7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일(일 1, 월 2, 화 3, ... 토 7)
	// begin blank개수는 firstDay - 1
	
	// 마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE); // 
	
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // beginBlank + lastDate + endBlank --> 7로 나누어 떨어진다 --> totalTd
	if((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank;
	
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	
	// View : 달력출력 + 일별 cash 목록 출력
%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="reset.css">
<style>	

.content:after {
  width: 20%;
  height: 60%;
  content: "";
  background: url("../images/apple.jpg");
  position: absolute;
  top: 40%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: -1;
  opacity: 0.1;
}
	table{border-collapse: collapse;}
	td{border: 1px solid gray; padding: 3px; width: 400px; height: 150px;}
	th:nth-child(1) {color:red;}
	th:nth-last-child(1) {color:blue;}
	th{background-color : #dddddd; border: 1px solid gray; font-weight : bold; height: 30px;}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>cashList</title>
</head>
<body class="content">
	<jsp:include page="/menuNav.jsp"></jsp:include>	
	<div style = text-align:center;>
		<h2><%=year%>년 <%=month+1%> 월</h2>	
	</div>
	<div>
		<ul class="pagination justify-content-end" style="margin:20px 0">
			<li class="page-item">	
				<a class="page-link" href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>"><h4>이전달</h4></a>
			</li>
			<li class="page-item">	
				<a class="page-link" href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>"><h4>다음달</h4></a>
			</li>
		</ul>	
	</div>	
	<div>
		<!-- 달력 -->
		<table border="1">
			<tr>
				<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
			</tr>
			
			<tr>
				<%
					for(int i=1; i<=totalTd; i++) {
				%>
						<td>
				<%
							int date = i-beginBlank;
							if(date > 0 && date <= lastDate) {
				%>
								<div>
									<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
										<%=date%>
									</a>
								</div>
								<div>
									<%
										for(HashMap<String, Object> m : list) {
											String cashDate = (String)(m.get("cashDate"));
											if(Integer.parseInt(cashDate.substring(8)) == date) {
									%>
												[<%=(String)(m.get("categoryKind"))%>]
												<%=(String)(m.get("categoryName"))%>
												&nbsp;
												<%=(Long)(m.get("cashPrice"))%>원
												<br>
									<%
											
											}
										}
									%>
								</div>
				<%				
							}
				%>
						</td>
				<%
						
						if(i%7 == 0 && i != totalTd) {
				%>
							</tr><tr> <!-- td7개 만들고 테이블 줄바꿈 -->
				<%			
						}
					}
				%>
			</tr>
		</table>
	</div>
</body>
</html>
