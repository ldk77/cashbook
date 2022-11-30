<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
Member loginMember = (Member)session.getAttribute("loginMember");
%>
<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">   
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-3">     
        <%
			if(loginMember.getMemberLevel() > 0){
		%>
			<li class="nav-item">
          	<a class="nav-link" href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자페이지</a>
          	</li>
        <%		
			}
		%>       
        <li class="nav-item">
        	<a class="nav-link" href="<%=request.getContextPath()%>/help/helpList.jsp">고객센터</a>
        </li>
  		<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            사용자 : <%=loginMember.getMemberName() %>
          </a>
          	<ul class="dropdown-menu">
            	<li><a class="dropdown-item" href="<%=request.getContextPath()%>/cash/updateLoginForm.jsp">개인정보수정</a></li>
            	<li><a class="dropdown-item" href="<%=request.getContextPath()%>/cash/deleteMemberForm.jsp">회원탈퇴</a></li>
            	<li><a class="dropdown-item" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>	</li>
          	</ul>
       </li>      
      </ul> 
    </div>
  </div>
</nav>     