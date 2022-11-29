<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
		}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String helpMemo = request.getParameter("helpMemo");	
	// Controller			
	Help help = new Help();	
	help.setHelpMemo(helpMemo);
	help.setMemberId(memberId);
	// memo가 null이거나 ""이면 
	if(request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")) {
		String msg = URLEncoder.encode("공백입니다", "utf-8");
		String targetUrl = "/help/insertHelpForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	
	}
	// Model 호출
	HelpDao helpDao = new HelpDao();	
	if(helpDao.insertHelp(help) == 1) {		
		String msg = URLEncoder.encode("작성 성공", "utf-8");
		String targetUrl = "/help/helpList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	}
%>