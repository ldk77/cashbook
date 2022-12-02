package dao;

import vo.*;
import java.sql.*;
import java.util.*;
import util.*;

import util.DBUtil;

public class CashDao {
	
	private String memberId;

	// 일별 가계부 출력
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date){
	ArrayList<HashMap<String, Object>> list = null;
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	try {
		list = new ArrayList<HashMap<String, Object>>();	
		DBUtil dbUtil = new DBUtil();	
		conn = dbUtil.getConnection();
		String sql = "SELECT "
				+ "		c.cash_no cashNo"
				+ "		, c.cash_date cashDate"
				+ "		, ct.category_kind categoryKind"
				+ "		, ct.category_name categoryName"
				+ "		, c.cash_price cashPrice"
				+ "		, c.cash_memo cashMemo"
				+ "		, c.updatedate"
				+ "		, c.createdate"
				+ "	FROM cash c INNER JOIN category ct"
				+ "	ON c.category_no = ct.category_no"
				+ "	WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?"
				+ " AND DAY(c.cash_date) = ?"			
				+ "	ORDER BY c.cash_date ASC, ct.category_kind";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("updatedate", rs.getString("updatedate"));
			m.put("createdate", rs.getString("createdate"));
			list.add(m);
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


	
	// 호출 : cashList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
			ArrayList<HashMap<String, Object>> list = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
			list = new ArrayList<HashMap<String,Object>>();
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT"
					+ "		c.cash_no cashNo"
					+ "		, c.cash_date cashDate"
					+ "		, c.cash_price cashPrice"
					+ "		, c.category_no categoryNo"
					+ "		, ct.category_kind categoryKind"
					+ "		, ct.category_name categoryName"
					+ "	FROM cash c INNER JOIN category ct"
					+ "	ON c.category_no = ct.category_no"
					+ "	WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?"
					+ "	ORDER BY c.cash_date ASC, ct.category_kind ASC"; 
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("categoryNo", rs.getInt("categoryNo"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
				list.add(m);
				}
			}catch(Exception e) {
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
	// cash 추가 
	public Boolean insertCash(Cash cash) throws Exception {
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sqlInsert = "INSERT INTO cash (category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES (?, ?, ?, ?, ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sqlInsert);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setString(2,cash.getMemberId());
		stmt.setString(3,cash.getCashDate());
		stmt.setLong(4,cash.getCashPrice());
		stmt.setString(5,cash.getCashMemo());		
		// 4. sql 실행, 결과에 따라 True false 반환
		int row = stmt.executeUpdate();		
		if(row==1) {
			System.out.println("cash추가 성공");
			dbUtil.close(null, stmt, conn);
			return true;
		} else {
			System.out.println("cash추가 실패");
			dbUtil.close(null, stmt, conn);
			return false;
		}
	}	
	// cash 수정 
	public Boolean updateCash(Cash updateCash) throws Exception {
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sqlUpdate = "UPDATE CASH SET category_no = ?, member_id = ?, cash_date = ?, cash_memo =?, cash_price = ? where cash_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sqlUpdate);
		stmt.setInt(1, updateCash.getCategoryNo());
		stmt.setString(2,updateCash.getMemberId());
		stmt.setString(3,updateCash.getCashDate());
		stmt.setString(4,updateCash.getCashMemo());		
		stmt.setLong(5,updateCash.getCashPrice());
		stmt.setInt(6, updateCash.getCashNo());
		// 4. sql 실행, 결과에 따라 True false 반환
		int row = stmt.executeUpdate();		
		if(row==1) {
			System.out.println("cash수정 성공");
			dbUtil.close(null, stmt, conn);
			return true;
		} else {
			System.out.println("cash수정 실패");
			dbUtil.close(null, stmt, conn);			
			return false;
		}
	}	
	
	//cash 삭제 
	public Boolean deleteCash(int cashNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql="DELETE FROM cash WHERE cash_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);		
		int row = stmt.executeUpdate();
		if(row==1) {
			System.out.println("cash삭제 성공");
			dbUtil.close(null, stmt, conn);			
			return true;
		} else {
			System.out.println("cash 실패");
			dbUtil.close(null, stmt, conn);		
			return false;
		}
		
	}

}


