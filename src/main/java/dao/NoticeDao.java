package dao;

import vo.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Notice;
	
public class NoticeDao {
	
	//notice 삭제
	public int deleteNotice(int noticeNo) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql ="DELETE FROM notice WHERE notice_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
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
	//notice 수정
	public int updateNotice(Notice notice) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "UPDATE notice SET notice_memo = ?"
					+" WHERE notice_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
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
	
	//notice 작성
	public int insertNotice(Notice notice) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "INSERT notice(notice_memo, updatedate, createdate)"
					+"VALUES(?,now(),now())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
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
	
	//마지막페이지를 구하려면 전체 row수 필요 
	public int selectNoticeCount() throws Exception {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement cntStmt = null;
		ResultSet cntRs = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String cntSql = "SELECT COUNT(*) cnt FROM notice";
		cntStmt = conn.prepareStatement(cntSql);
		cntRs = cntStmt.executeQuery();
		if(cntRs.next()) { // 전체 행의수
			cnt = cntRs.getInt("cnt");
		}
		} catch(Exception e) {
			e.printStackTrace();
			}finally{
				try {
					cntRs.close();
					cntStmt.close();
					conn.close();	
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		return cnt;
	}
	// loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
		ArrayList<Notice> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;	
		try {
		list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
				+ " FROM notice ORDER BY createdate DESC"
				+ " LIMIT ?,?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1 , beginRow);
		stmt.setInt(2 , rowPerPage);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
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
}
