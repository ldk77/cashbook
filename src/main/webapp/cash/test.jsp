<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
		// 로그인 유효성 검사
		if(session.getAttribute("loginMember") == null){
			response.sendRedirect(request.getContextPath()+"loginForm.jsp");
			return;
		}
		
		// 로그인정보 
		Member loginMember = (Member)session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		
		// 파라메터 유효성 검사
		int year = 0;
		if(request.getParameter("year") == null){
			Calendar c = Calendar.getInstance();
			year = c.get(Calendar.YEAR);
		} else {
			year = Integer.parseInt(request.getParameter("year"));
		}

	
	// Model 호출 : 월별 수입,지출 합계 및 평균 리스트
	CashDao cashDao = new CashDao();	
	ArrayList<HashMap<String, Object>> list1 = cashDao.selectCashByMonth(loginMember.getMemberId(), year);
	// 데이터있는 최대년도,최소년도 
	HashMap<String, Object> minMaxYear = cashDao.selectMinMaxYear();
	int minYear = (Integer)minMaxYear.get("minYear");
	int maxYear = (Integer)minMaxYear.get("maxYear");

	// View : 달력출력 + 일별 cash 목록 출력
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

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>CASHLIST</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <!-- 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<%=request.getContextPath()%>/cash/cashList.jsp">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">CashList</div>
            </a>
            <!-- Divider -->
            <hr class="sidebar-divider my-0">
            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>HOME</span></a>
            </li>
             <!-- Divider -->
             <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
                    aria-expanded="true" aria-controls="collapseUtilities">
                     <i class="fas fa-fw fa-table"></i>
                    <span>가계부(수입/지출)</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">cash page:</h6>
                        <a class="collapse-item" href="<%=request.getContextPath()%>/cash/cashYearList.jsp">연도별 리스트</a>
                        <a class="collapse-item" href="<%=request.getContextPath()%>/cash/cashMonthList.jsp">월별 리스트</a>                        
                    </div>
                </div>
            </li>            
            <!-- Divider -->
            <hr class="sidebar-divider">    
            <!-- Nav Item - Charts -->
            <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/help/helpList.jsp">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>고객센터</span></a>
            </li>
            <!-- 관리자 Menu -->            
           <%
           	if(loginMember.getMemberLevel() > 0){                    		
           %>
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
                    aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="fas fa-fw fa-wrench"></i>
                    <span>관리자페이지</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">admin page:</h6>
                        <a class="collapse-item" href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a>
                        <a class="collapse-item" href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a>
                        <a class="collapse-item" href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리</a>
                        <a class="collapse-item" href="<%=request.getContextPath()%>/admin/helpListAll.jsp">고객센터관리</a>
                    </div>
                </div>
            </li>
            <%
           	}
            %>
            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">
            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>
        </ul> 
   
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
           <div id="content">
                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">                               
                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=loginMember.getMemberName() %></span>
                                <img class="img-profile rounded-circle"
                                    src="img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="<%=request.getContextPath()%>/cash/updateLoginForm.jsp">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                   개인정보수정
                                </a>
                                <a class="dropdown-item" href="<%=request.getContextPath()%>/cash/deleteMemberForm.jsp">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    회원탈퇴
                                </a>
                            	<!-- 관리자페이지 -->
                            	 <%                               
                    				if(loginMember.getMemberLevel() > 0){                    		
                                %>
                                <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/adminMain.jsp">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                   	관리자페이지
                                </a>
                                <%
                    				}
                                %>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="<%=request.getContextPath()%>/logout.jsp" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <!-- 내용 -->
                
						<div class="text-center">
					<h1><%=year%>년 수입/지출 리스트</h1>
				</div>
				<br>
				<br>
				<br>
				<br>
				<br>
				<div class="col-md-10" style="margin: auto;">
				<table class = "table table-hover w-100 rounded" style="table-layout: auto; width: 100%; table-layout: fixed;">
					<tr>
						<th>월</th>
						<th>수입 횟수</th>
						<th>수입 평균</th>
						<th>수입 합계</th>
						<th>지출 횟수</th>
						<th>지출 평균</th>
						<th>지출 합계</th>
					</tr>
					<%
						for(HashMap<String, Object> m1 : list1){
					%>
						<tr>
							<td><%=m1.get("month") %></td>
							<td><%=m1.get("importCnt") %></td>
							<td><%=m1.get("importAvgPrice") %></td>
							<td><%=m1.get("importSumPrice") %></td>
							<td><%=m1.get("exportCnt") %></td>
							<td><%=m1.get("exportAvgPrice") %></td>
							<td><%=m1.get("exportSumPrice") %></td>				
						</tr>
					<%		
						}
					%>
				</table>				
				<div class="position-relative">
						<%
							if(year > minYear){
						%>
							<a href="<%=request.getContextPath()%>/cash/cashMonthList.jsp?year=<%=year-1%>">이전년도</a>
						<%
							}
							if(year < maxYear){
						%>	
							<a href="<%=request.getContextPath()%>/cash/cashMonthList.jsp?year=<%=year+1%>">다음년도</a>
						<%
							}
						%>			
				</div>
        <!-- End of Content Wrapper -->
	</div>
    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="<%=request.getContextPath()%>/logout.jsp">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="js/demo/chart-area-demo.js"></script>
    <script src="js/demo/chart-pie-demo.js"></script>

</body>

</html>