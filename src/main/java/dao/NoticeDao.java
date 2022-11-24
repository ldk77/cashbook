package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	//마지막페이지를 구하려면 전체 row수가 필요 
	public int selectNoticeCount() throws Exception {
		int cnt = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String cntSql = "SELECT COUNT(*) cnt FROM notice";
		PreparedStatement cntStmt = conn.prepareStatement(cntSql);
		ResultSet cntRs = cntStmt.executeQuery();
		if(cntRs.next()) { // 전체 행의수
			cnt = cntRs.getInt("cnt");
		}		
		return cnt;
	}
	// loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
				+ " FROM notice ORDER BY createdate DESC"
				+ " LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1 , beginRow);
		stmt.setInt(2 , rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		return list;
	}
}
