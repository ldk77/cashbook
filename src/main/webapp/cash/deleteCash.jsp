<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="vo.*"%>
<%@page import="dao.*" %> 
<%@page import="java.util.*" %>
<%@page import="java.net.URLEncoder" %> 

<%
	//요청 분석 
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo= Integer.parseInt(request.getParameter("cashNo"));
	// Model 호출
	CashDao cashdao= new CashDao();
	if(cashdao.deleteCash(cashNo)){
		String msg = URLEncoder.encode("삭제 성공", "utf-8");
		String targetUrl = "/cash/cashDateList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg+"&year="+year+"&month="+(month-1)+"&date="+date);
		return;		
	};
%>   
