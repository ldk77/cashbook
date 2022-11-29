<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");
	int helpNo= Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	// Controller			
	Help help = new Help();	
	help.setHelpMemo(helpMemo);
	help.setHelpNo(helpNo);
	// Memo가 null이거나 ""이면 
	if(request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")) {
		String msg = URLEncoder.encode("공백입니다", "utf-8");
		String targetUrl = "/help/updateHelpForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	
	}
	// Model 호출
	HelpDao helpDao = new HelpDao();	
	if(helpDao.updateHelp(help) == 1) {		
		String msg = URLEncoder.encode("작성 성공", "utf-8");
		String targetUrl = "/help/helpList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	}
%>
	