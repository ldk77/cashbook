package dao;

import vo.Category;
import java.util.*;
import java.util.*;
import java.sql.*;
import util.DBUtil;
import vo.*;


public class CategoryDao {
	
	// admin -> 수정폼에서 보여줄 카테고리목록 updateCategoryForm
	public Category selectCategoryOne(int categoryNo) {
		Category category = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT category_no categoryNo,category_name categoryName,category_kind categoryKind"
					+ " FROM category"
					+ " WHERE cateogry_no =?";
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryName(rs.getString("categoryName"));
				category.setCategoryKind(rs.getString("categoryKind"));			
			}
		} catch(Exception e) {
			e.printStackTrace();
			}finally{
				try {
					rs.close();
					stmt.close();
					conn.close();	
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		return category;
	
	}		
	
	// admin -> 카테고리 수정 updateCategoryAction.jsp 
	public int updateCategory(Category category) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql = "UPDATE category SET "
					+ "category_kind = ?"
					+ ", category_name = ?"
					+ ", updatedate = CURDATE()"
					+" WHERE category_no = ?";
			DBUtil dbUtil = new DBUtil();
			conn =  null;
			stmt = null;
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
			stmt.setInt(3 , category.getCategoryNo());
			row = stmt.executeUpdate();		
			} catch(Exception e) {
				e.printStackTrace();
				}finally{
					try {					
						stmt.close();
						conn.close();	
					} catch(Exception e) {
						e.printStackTrace();
					}
				}		
		return row;
	
	}
	
	// admin -> 카테고리 삭제 deleteCategoryAction.jsp
	public int deleteCategory(int categoryNo) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql = "DELETE FROM category WHERE category_no=?";
			DBUtil dbUtil = new DBUtil();
			conn =  null;
			stmt = null;
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			row = stmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
				}finally{
					try {					
						stmt.close();
						conn.close();	
					} catch(Exception e) {
						e.printStackTrace();
					}
				}		
		
		return row;
	}
	
	
	// admin -> 카테고리추가 insertCategoryAction.jsp
	public int insertCategory(Category category) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			String sql = "INSERT INTO category ("
					+ " category_kind"
					+ " , category_name"
					+ ", updatedate"
					+ ", createdate"
					+ ") VALUES (?,?, CURDATE(),CURDATE())";
			DBUtil dbUtil = new DBUtil();
			conn =  null;
			stmt = null;
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
			row = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
			}finally{
				try {					
					stmt.close();
					conn.close();	
				} catch(Exception e) {
					e.printStackTrace();
				}
			}		

		return row;
	}
	//admin -> 카테고리관리 -> 카테고리목록 
	public ArrayList<Category> selectCategoryListByAdmin() {
		ArrayList<Category> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
		list = new ArrayList<Category>();
		
		String sql = "SELECT "
				+ " category_no categoryNo"
				+ ", category_kind categoryKind"
				+ ", category_name categoryName"
				+ ", updatedate"
				+ ", createdate"
				+ " FROM category";
		
		DBUtil dbUtil = new DBUtil();		
		// db자원(jdbc api자원) 초기화	
		// executeQuery는 보통 셀렉트쿼리문에서 사용 update로 사용해도되긴하지만 거의 안사용
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery(); // 쿼리로 받으면 resultSet을 반환 (보이는테이블형식), 업데이트로 받으면 행을 반환함
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updatedate"));
			c.setCreatedate(rs.getString("createdate"));
			list.add(c);
			}
		} catch(Exception e) {
			e.printStackTrace();
			}finally{
				try {
					rs.close();
					stmt.close();
					conn.close();	
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		return list;
	}
	
	public ArrayList<Category> selectCategoryList() {
		ArrayList<Category> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			//  DB 연결
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();	
			String sqlSelect = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category";
			stmt = conn.prepareStatement(sqlSelect);
			rs = stmt.executeQuery();		
			//  list에 추가
			list = new ArrayList<Category>();		
			while(rs.next())
			{
				Category category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryKind(rs.getString("categoryKind"));
				category.setCategoryName(rs.getString("categoryName"));
				
				list.add(category);
			}
		} catch(Exception e) {
			e.printStackTrace();
			}finally{
				try {
					rs.close();
					stmt.close();
					conn.close();	
				} catch(Exception e) {
					e.printStackTrace();
				}
			}		
		return list;	
	}
}