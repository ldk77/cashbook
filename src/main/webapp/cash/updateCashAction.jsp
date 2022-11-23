<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");
	// Controller	
	Cash updateCash = new Cash();
	// updateCashForm.jsp에서 받아온 값들이 null 또는 ""일 경우
	if(request.getParameter("categoryNo") == null || request.getParameter("cashDate") == null || request.getParameter("cashPrice") == null || request.getParameter("cashMemo") == null ||
		request.getParameter("categoryNo").equals("") || request.getParameter("cashDate").equals("") || request.getParameter("cashPrice").equals("") 
		|| request.getParameter("cashMemo").equals("")) {
	} else { 
		updateCash.setMemberId(request.getParameter("memberId"));
		updateCash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
		updateCash.setCashDate(request.getParameter("cashDate"));
		updateCash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
		updateCash.setCashMemo(request.getParameter("cashMemo"));
		updateCash.setCashNo(Integer.parseInt(request.getParameter("cashNo")));
	}	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));	
	// Model 호출
	
	CashDao cashDao = new CashDao();	
	cashDao.updateCash(updateCash);
	if(cashDao.updateCash(updateCash)) {		
		String msg = URLEncoder.encode("수정 성공", "utf-8");
		String targetUrl = "/cash/cashDateList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg+"&year="+year+"&month="+(month-1)+"&date="+date);
		return;		
	} else {
		String msg = URLEncoder.encode("수정 실패", "utf-8");
		String targetUrl = "/cash/updateCashForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg+"&year="+year+"&month="+(month-1)+"&date="+date);
		return;		
	}
%>