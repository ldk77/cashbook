package dao;

import vo.*;
import java.sql.*;
import java.util.*;
import util.*;

import util.DBUtil;

public class CashDao {
	//해당년도 수입,지출 list
		public ArrayList<HashMap<String, Object>> selectCashByYear(String memberId){
			ArrayList<HashMap<String, Object>> list1 = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				list1 = new ArrayList<HashMap<String, Object>>();	
				DBUtil dbUtil = new DBUtil();	
				conn = dbUtil.getConnection();
				String sql = "SELECT "
						+ "		YEAR(t2.cashDate) 년"
						+ "		, COUNT(t2.importCash) 수입카운트"
						+ "		, ifnull(SUM(t2.importCash),0) 수입합계"
						+ "		, ifnull(ROUND(AVG(t2.importCash)),0) 수입평균"
						+ "		, COUNT(t2.exportCash) 지출카운트"
						+ "		, ifnull(SUM(t2.exportCash),0) 지출합계"
						+ "		, ifnull(ROUND(AVG(t2.exportCash)),0) 지출평균"
						+ " FROM"
						+ "	(SELECT "
						+ "			memberId"
						+ "			, cashNo"
						+ "			, cashDate"
						+ "			, IF(categoryKind = '수입', cashPrice, null) importCash"
						+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash"
						+ "	 FROM (SELECT cs.cash_no cashNo"
						+ "			, cs.cash_date cashDate"
						+ "			, cs.cash_price cashPrice"
						+ "			, cg.category_kind categoryKind"
						+ "			, cs.member_id memberId"
						+ "	FROM cash cs "
						+ "	INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
						+ " WHERE t2.memberId = ?"
						+ " GROUP BY YEAR(t2.cashDate)";
					
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, memberId);						
				rs = stmt.executeQuery();
				while(rs.next()) {
					HashMap<String, Object> m1 = new HashMap<String, Object>();	
					m1.put("year", rs.getString("년"));
					m1.put("importCnt", rs.getString("수입카운트"));
					m1.put("importSumPrice", rs.getString("수입합계"));
					m1.put("exportSumPrice", rs.getString("지출합계"));
					m1.put("importAvgPrice", rs.getString("수입평균"));
					m1.put("exportCnt", rs.getString("지출카운트"));
					m1.put("exportAvgPrice", rs.getString("지출평균"));		
					list1.add(m1);
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
			return list1;
		}
		
	
	// 데이터가있는 최대년도,최소년도
	public HashMap<String, Object> selectMinMaxYear() {
		HashMap<String, Object> year = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT MIN(YEAR(cash_date)) minYear, MAX(YEAR(cash_date)) maxYear FROM cash";
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				year = new HashMap<String, Object>();
				year.put("minYear", rs.getInt("minYear"));
				year.put("maxYear", rs.getInt("maxYear"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return year;
	}	

	
	//해당년도 월별 수입,지출 list
	public ArrayList<HashMap<String, Object>> selectCashByMonth(String memberId, int year){
		ArrayList<HashMap<String, Object>> list1 = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			list1 = new ArrayList<HashMap<String, Object>>();	
			DBUtil dbUtil = new DBUtil();	
			conn = dbUtil.getConnection();
			String sql = "SELECT MONTH(t2.cashDate) 월"
					+ "		, COUNT(t2.importCash) 수입카운트"
					+ "		, ifnull(SUM(t2.importCash),0) 수입합계"
					+ "		, ifnull(ROUND(AVG(t2.importCash)),0) 수입평균"
					+ "		, COUNT(t2.exportCash) 지출카운트"
					+ "		, ifnull(SUM(t2.exportCash),0) 지출합계"
					+ "		, ifnull(ROUND(AVG(t2.exportCash)),0) 지출평균"
					+ " FROM"
					+ "	(SELECT "
					+ "			memberId"
					+ "			, cashNo"
					+ "			, cashDate"
					+ "			, IF(categoryKind = '수입', cashPrice, null) importCash"
					+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ "	 FROM (SELECT cs.cash_no cashNo"
					+ "			, cs.cash_date cashDate"
					+ "			, cs.cash_price cashPrice"
					+ "			, cg.category_kind categoryKind"
					+ "			, cs.member_id memberId"
					+ "	FROM cash cs "
					+ "	INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?"
					+ " GROUP BY MONTH(t2.cashDate)";
				
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);			
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m1 = new HashMap<String, Object>();	
				m1.put("month", rs.getString("월"));
				m1.put("importCnt", rs.getString("수입카운트"));
				m1.put("importSumPrice", rs.getString("수입합계"));
				m1.put("exportSumPrice", rs.getString("지출합계"));
				m1.put("importAvgPrice", rs.getString("수입평균"));
				m1.put("exportCnt", rs.getString("지출카운트"));
				m1.put("exportAvgPrice", rs.getString("지출평균"));		
				list1.add(m1);
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
		return list1;
	}
	
	
	
	// 월 수입,지출 
	public ArrayList<HashMap<String, Object>> selectCashPriceByMonth(String memberId, int year, int month){
		ArrayList<HashMap<String, Object>> list1 = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			list1 = new ArrayList<HashMap<String, Object>>();	
			DBUtil dbUtil = new DBUtil();	
			conn = dbUtil.getConnection();
			String sql = "SELECT MONTH(t2.cashDate) 월"
					+ "		, COUNT(t2.importCash) 수입카운트"
					+ "		, ifnull(SUM(t2.importCash),0) 수입합계"
					+ "		, ifnull(ROUND(AVG(t2.importCash)),0) 수입평균"
					+ "		, COUNT(t2.exportCash) 지출카운트"
					+ "		, ifnull(SUM(t2.exportCash),0) 지출합계"
					+ "		, ifnull(ROUND(AVG(t2.exportCash)),0) 지출평균"
					+ " FROM"
					+ "	(SELECT "
					+ "			memberId"
					+ "			, cashNo"
					+ "			, cashDate"
					+ "			, IF(categoryKind = '수입', cashPrice, null) importCash"
					+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ "	 FROM (SELECT cs.cash_no cashNo"
					+ "			, cs.cash_date cashDate"
					+ "			, cs.cash_price cashPrice"
					+ "			, cg.category_kind categoryKind"
					+ "			, cs.member_id memberId"
					+ "	FROM cash cs "
					+ "	INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ? AND MONTH(t2.cashDate) = ?"
					+ " GROUP BY MONTH(t2.cashDate)";
				
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m1 = new HashMap<String, Object>();				
				m1.put("importSumPrice", rs.getString("수입합계"));
				m1.put("exportSumPrice", rs.getString("지출합계"));
				m1.put("importAvgPrice", rs.getString("수입평균"));
				m1.put("exportAvgPrice", rs.getString("지출평균"));		
				list1.add(m1);
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
		return list1;
	}
	


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


