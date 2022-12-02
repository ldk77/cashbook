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
	public int insertComment(Comment comment) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "INSERT comment(help_no,comment_memo,member_id, updatedate, createdate)"
						+"VALUES(?,?,?,now(),now())";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
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
	// 해당번호 내용출력
	public ArrayList<HashMap<String, Object>> selectCommentOne(int commentNo) {
		ArrayList<HashMap<String, Object>> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;		
		try {
			list = new ArrayList<HashMap<String,Object>>();
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			String sql = "SELECT comment_no commentNo, comment_memo commentMemo"
					+ " FROM comment WHERE comment_no=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("commentNo", rs.getInt("commentNo"));
				m.put("commentMemo", rs.getString("commentMemo"));
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
	// 내용수정
	public int updateComment(Comment comment) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "UPDATE comment SET comment_memo = ?"
					+" WHERE comment_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, comment.getCommentMemo());
		stmt.setInt(2, comment.getCommentNo());
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
	
	// 삭제
	public int deleteComment(int commentNo) throws Exception {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();		
		String sql="DELETE FROM comment WHERE comment_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);		
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
	

