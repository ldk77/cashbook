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
	String commentMemo = request.getParameter("commentMemo");
	int helpNo= Integer.parseInt(request.getParameter("helpNo"));
	// Controller			
	Comment comment = new Comment();	
	comment.setCommentMemo(commentMemo);
	comment.setHelpNo(helpNo);
	comment.setMemberId(memberId);
	// memo가 null이거나 ""이면 
	if(request.getParameter("commentMemo") == null || request.getParameter("commentMemo").equals("")) {
		String msg = URLEncoder.encode("공백입니다", "utf-8");
		String targetUrl = "/admin/insertCommentForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	
	}
	// Model 호출
	CommentDao commentDao = new CommentDao();	
	if(commentDao.insertComment(comment) == 1) {		
		String msg = URLEncoder.encode("작성 성공", "utf-8");
		String targetUrl = "/admin/helpListAll.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	}
%>