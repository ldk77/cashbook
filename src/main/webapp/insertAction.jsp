<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	
	//  받아온 값이 null 또는 공백이면 회원가입폼으로 리턴
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberName") == null ||
		request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberName").equals("")) {
		String msg = URLEncoder.encode("회원가입에 필요한 정보를 모두 입력해주세요", "utf-8");		
		String targetUrl = "/insesrtForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}	
	// insertMember에 저장
	Member insertMember = new Member();
	insertMember.setMemberId(request.getParameter("memberId"));
	insertMember.setMemberPw(request.getParameter("memberPw"));
	insertMember.setMemberName(request.getParameter("memberName"));	
	MemberDao memberDao = new MemberDao();	
	// 회원 가입 전 ID중복 확인
	if(memberDao.memberIdCheck(insertMember.getMemberId())) { 
		String msg = URLEncoder.encode("중복된 ID가 존재합니다.", "utf-8");
		String targetUrl = "/insertForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	} else if(memberDao.insertMember(insertMember)) {
		// 중복되는 ID가 DB에 존재하지 않을 경우 -> 회원가입 진행
		String msg = URLEncoder.encode("회원가입 성공", "utf-8");
		String targetUrl = "/loginForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	}
%>