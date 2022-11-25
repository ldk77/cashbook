<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");
	// Controller	
	Notice notice = new Notice();
	// noticeMemo가 null이거나 ""이면 
	if(request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")) {
	} else {
		notice.setNoticeMemo(request.getParameter("noticeMemo"));		
	}	
	// Model 호출
	NoticeDao noticeDao = new NoticeDao();	
	if(noticeDao.insertNotice(notice)==1) {		
		String msg = URLEncoder.encode("작성 성공", "utf-8");
		String targetUrl = "/admin/noticeList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	}
%>
	
