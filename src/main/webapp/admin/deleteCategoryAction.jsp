<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %> 

<%
//  받아온 값이 null 또는 공백이면리턴
if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")) {
	String msg = URLEncoder.encode("정보받아오기실패", "utf-8");		
	String targetUrl = "/admin/categoryList.jsp";
	response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
	return;
}
	
	//요청 분석 
	int categoryNo= Integer.parseInt(request.getParameter("categoryNo"));
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	if(categoryDao.deleteCategory(categoryNo) == 1){
		String msg = URLEncoder.encode("삭제 성공", "utf-8");
		String targetUrl = "/admin/categoryList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	};
%>   
