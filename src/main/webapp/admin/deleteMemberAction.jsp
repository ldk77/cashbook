<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	// Controller			
	Member member = new Member();	
	member.setMemberId(memberId);
	// Model 호출
	MemberDao memberDao = new MemberDao();	
	if(memberDao.deleteMemberByAdmin(member) == 1) {		
		String msg = URLEncoder.encode("강퇴 성공", "utf-8");
		String targetUrl = "/admin/memberList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	}
%>