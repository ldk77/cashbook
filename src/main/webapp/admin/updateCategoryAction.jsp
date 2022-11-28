<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");
	int categoryNo= Integer.parseInt(request.getParameter("categoryNo"));
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	// Controller			
	Category category = new Category();	
	category.setCategoryNo(categoryNo);
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	// categoryName가 null이거나 ""이면 
	if(request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		String msg = URLEncoder.encode("공백입니다", "utf-8");
		String targetUrl = "/admin/updateCategoryForm.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	
	}
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	if(categoryDao.updateCategory(category) == 1) {		
		String msg = URLEncoder.encode("작성 성공", "utf-8");
		String targetUrl = "/admin/categoryList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	}
%>
	