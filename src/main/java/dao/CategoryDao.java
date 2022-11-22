package dao;

import java.sql.Connection;
import java.util.*;
import java.sql.*;
import util.DBUtil;
import vo.*;


public class CategoryDao {
	public ArrayList<Category> selectCategoryList() throws Exception {
		//  DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		String sqlSelect = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category";
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		ResultSet rsSelect = stmtSelect.executeQuery();		
		//  list에 추가
		ArrayList<Category> list = new ArrayList<Category>();		
		while(rsSelect.next())
		{
			Category category = new Category();
			category.setCategoryNo(rsSelect.getInt("categoryNo"));
			category.setCategoryKind(rsSelect.getString("categoryKind"));
			category.setCategoryName(rsSelect.getString("categoryName"));
			
			list.add(category);
		}		
		return list;	
	}
}