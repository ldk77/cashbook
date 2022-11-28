<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder"%>
<%
	//한글처리
	request.setCharacterEncoding("utf-8");
	// Controller	
	Category category = new Category();
	// name null,공백 아니면
	if(request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
	} else {
		category.setCategoryKind(request.getParameter("categoryKind"));
		category.setCategoryName(request.getParameter("categoryName"));
	}	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();	
	if(categoryDao.insertCategory(category) == 1) {		
		String msg = URLEncoder.encode("작성 성공", "utf-8");
		String targetUrl = "/admin/categoryList.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl + "?msg="+msg);
		return;		
	}
%>