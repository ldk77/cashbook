package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.*;

public class HelpDao {
	// 답변시 보여줄 문의내용
	public ArrayList<HashMap<String, Object>> selectHelpOne(int helpNo) {
		ArrayList<HashMap<String, Object>> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;	
		try {
		list = new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "SELECT help_no helpNo, help_memo helpMemo"
				+ " FROM help WHERE help_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
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
	//마지막페이지를 구하려면 전체 row수가 필요 
	public int selectHelpCount() {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) cnt FROM help";
		stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { // 전체 행의수
			cnt = rs.getInt("cnt");
		}		
		}catch(Exception e) {
				e.printStackTrace();
				}finally{
					try {					
						stmt.close();
						conn.close();	
					} catch(Exception e) {
						e.printStackTrace();
					}
				}
		return cnt;
	}	
	// 관리자가 호출
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) {
		ArrayList<HashMap<String, Object>> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;	
		try {
		list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo"
					+"		, h.help_memo helpMemo"
					+ "		, h.member_id memberId"
					+"		, h.createdate helpCreatedate"
					+ "		, c.comment_no commentNo"
					+"		, c.comment_memo commentMemo"
					+"		, c.createdate commentCreatedate"
					+" FROM help h LEFT JOIN comment c"
					+" ON h.help_no = c.help_no "
					+ "ORDER BY helpCreatedate DESC"										
					+ "	LIMIT ?,?";
		
		DBUtil dbUtil = new DBUtil();		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("memberId", rs.getString("memberId"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentNo", rs.getInt("commentNo"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
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
	// 문의내용 출력
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) {
		ArrayList<HashMap<String, Object>> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;	
		try {
		list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo"
					+"		, h.help_memo helpMemo"
					+"		, h.createdate helpCreatedate"
					+"		, c.comment_memo commentMemo"
					+"		, c.createdate commentCreatedate"
					+" FROM help h LEFT JOIN comment c"
					+" ON h.help_no = c.help_no"
					+" WHERE h.member_id = ?";
		
		DBUtil dbUtil = new DBUtil();
		conn = null;
		stmt = null;
		rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
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
	//문의내용 추가
	public int insertHelp(Help help) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "INSERT help(help_memo,member_id, updatedate, createdate)"
					+"VALUES(?,?,now(),now())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getMemberId());
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
	//문의내용 삭제 
	public int deleteHelp(int helpNo){
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();		
		String sql="DELETE FROM help WHERE help_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);		
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
	//문의내용 수정
	public int updateHelp(Help help) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "UPDATE help SET help_memo = ?"
					+" WHERE help_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setInt(2, help.getHelpNo());
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
	
}