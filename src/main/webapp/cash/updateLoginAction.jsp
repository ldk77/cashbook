<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller : seesion, request
	if(session.getAttribute("loginMember")==null)
	{
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	// session에 저장된 멤버(현재 로그인)
	Member loginMember = (Member)session.getAttribute("loginMember");
	// udateMember에 저장 
	Member udateMember = new Member();
	udateMember.setMemberId(request.getParameter("memberId"));
	udateMember.setMemberPw(request.getParameter("memberPw"));
	udateMember.setMemberName(request.getParameter("memberNewName"));	
	MemberDao memberDao = new MemberDao();
	
	if(memberDao.udateMember(udateMember)) {		
		String msg = URLEncoder.encode("정보수정 성공", "utf-8");
		String targetUrl = "/logout.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	} else {
		String msg = URLEncoder.encode("정보수정 실패", "utf-8");
		String targetUrl = "/cash/updateLoginForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;			
	}
%>