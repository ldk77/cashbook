package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.*;

public class HelpDao {
	//마지막페이지를 구하려면 전체 row수가 필요 
	public int selectHelpCount() throws Exception {
		int cnt = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT COUNT(*) cnt FROM help";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { // 전체 행의수
			cnt = rs.getInt("cnt");
		}		
		return cnt;
	}	
	// 관리자가 호출
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo"
					+"		, h.help_memo helpMemo"
					+ "		, h.member_id memberId"
					+"		, h.createdate helpCreatedate"
					+ "		, c.comment_no commentNo"
					+"		, c.comment_memo commentMemo"
					+"		, c.createdate commentCreatedate"
					+" FROM help h LEFT JOIN comment c"
					+" ON h.help_no = c.help_no"
					+" WHERE h.member_id = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
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
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	// 문의내용 출력
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo"
					+"		, h.help_memo helpMemo"
					+"		, h.createdate helpCreatedate"
					+"		, c.comment_memo commentMemo"
					+"		, c.createdate commentCreatedate"
					+" FROM help h LEFT JOIN comment c"
					+" ON h.help_no = c.help_no"
					+" WHERE h.member_id = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
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
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	//문의내용 추가
	public int insertHelp(Help help) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT help(help_memo,member_id, updatedate, createdate)"
					+"VALUES(?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getMemberId());
		int row = stmt.executeUpdate();	
		dbUtil.close(null, stmt, conn);;
		return row;				
	}
	//문의내용 삭제 
	public int deleteHelp(int helpNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql="DELETE FROM help WHERE help_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);		
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;			
	}
	//문의내용 수정
	public int updateHelp(Help help) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE help SET help_memo = ?"
					+" WHERE help_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setInt(2, help.getHelpNo());
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
}