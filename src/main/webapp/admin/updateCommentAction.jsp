<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");
	int commentNo= Integer.parseInt(request.getParameter("commentNo"));
	String commentMemo = request.getParameter("commentMemo");
	// Controller			
	Comment comment = new Comment();	
	comment.setCommentMemo(commentMemo);
	comment.setCommentNo(commentNo);
	// Memo가 null이거나 ""이면 
	if(request.getParameter("commentMemo") == null || request.getParameter("commentMemo").equals("")) {
		String msg = URLEncoder.encode("공백입니다", "utf-8");
		String targetUrl = "/admin/updateCommentForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	
	}
	// Model 호출
	CommentDao commentDao = new CommentDao();	
	if(commentDao.updateComment(comment) == 1) {		
		String msg = URLEncoder.encode("수정 성공", "utf-8");
		String targetUrl = "/admin/helpListAll.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	}
%>
	