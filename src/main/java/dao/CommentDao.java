package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.*;

public class CommentDao {
	//문의내용 답변추가
	public int insertComment(Comment comment) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT comment(help_no,comment_memo,member_id, updatedate, createdate)"
					+"VALUES(?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getHelpNo());
		stmt.setString(2, comment.getCommentMemo());
		stmt.setString(3, comment.getMemberId());
		int row = stmt.executeUpdate();	
		return row;				
	}
	// 해당번호 내용출력
	public ArrayList<HashMap<String, Object>> selectCommentOne(int commentNo) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT comment_no commentNo, comment_memo commentMemo"
				+ " FROM comment WHERE comment_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("commentNo", rs.getInt("commentNo"));
			m.put("commentMemo", rs.getString("commentMemo"));
			list.add(m);
		}
		dbUtil.close(rs, stmt, conn);
		return list;		
	}
	// 내용수정
	public int updateComment(Comment comment) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE comment SET comment_memo = ?"
					+" WHERE comment_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, comment.getCommentMemo());
		stmt.setInt(2, comment.getCommentNo());
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 삭제
	public int deleteComment(int commentNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql="DELETE FROM comment WHERE comment_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);		
		int row = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;			
	}	
}
	

