<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%	
	//  받아온 값이 null 또는 공백이면 회원가입폼으로 리턴
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null ||
		request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("")) {
		String msg = URLEncoder.encode("정보를 모두 입력해주세요", "utf-8");		
		String targetUrl = "/cash/deleteMemberForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;
	}	
	// insertMember에 저장
	Member deleteMember = new Member();
	deleteMember.setMemberId(request.getParameter("memberId"));
	deleteMember.setMemberPw(request.getParameter("memberPw"));
	deleteMember.setMemberName(request.getParameter("memberName"));	
	// Model 호출
	MemberDao memberDao = new MemberDao();	
	int row = memberDao.deleteMember(deleteMember);
	if(row == 1){
		String msg= URLEncoder.encode("회원탈퇴가 되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/logout.jsp"+"?msg="+msg);
	} else {
		String msg= URLEncoder.encode("id또는pw가 일치하지않습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/deleteMemberForm.jsp"+"?msg="+msg);
	}
%>