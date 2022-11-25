<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");
	int memberLevel= Integer.parseInt(request.getParameter("memberLevel"));	
	String memberName = request.getParameter("memberName");
	String memberId = request.getParameter("memberId");
	// Controller			
	Member member = new Member();	
	member.setMemberId(memberId);
	member.setMemberLevel(memberLevel);
	member.setMemberName(memberName);
	// Model 호출
	MemberDao memberDao = new MemberDao();	
	if(memberDao.updateMemberLevel(member) == 1) {		
		String msg = URLEncoder.encode("변경 성공", "utf-8");
		String targetUrl = "/admin/memberList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	}
%>