<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %> 

<%
//  받아온 값이 null 또는 공백이면 회원가입폼으로 리턴
if(request.getParameter("commentNo") == null || request.getParameter("commentNo").equals("")) {
	String msg = URLEncoder.encode("정보받아오기실패", "utf-8");		
	String targetUrl = "/admin/helpListAll.jsp";
	response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
	return;
}
	
	//요청 분석 
	int commentNo= Integer.parseInt(request.getParameter("commentNo"));
	// Model 호출
	CommentDao commentDao= new CommentDao();
	if(commentDao.deleteComment(commentNo) == 1){
		String msg = URLEncoder.encode("삭제 성공", "utf-8");
		String targetUrl = "/admin/helpListAll.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	};
%>   