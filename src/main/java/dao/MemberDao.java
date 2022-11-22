package dao;
import java.sql.*;
import util.*;
import vo.*;
public class MemberDao { // 2. Model
	public Member login(Member paramMember) throws Exception { // 로그인
		Member resultMember = null; // 반환할 변수초기화
		DBUtil dbUtil = new DBUtil(); 
		Connection conn = dbUtil.getConnection(); // db연결 메서드
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()==false) { // 디버깅
			//System.out.println("로그인 실패");
		}else {
			//System.out.println("로그인 성공");
			resultMember = new Member(); // 로그인 성공시에 객체 생성
			resultMember.setMemberId(rs.getString("memberId"));  
			resultMember.setMemberName(rs.getString("memberName"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return resultMember;
	}
	// memberId 중복 확인 메서드
	public Boolean memberIdCheck(String memberId) throws Exception {
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sqlSelect = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect);
		stmtSelect.setString(1, memberId);
		
		ResultSet rsSelect = stmtSelect.executeQuery();
		
		if(rsSelect.next())
		{
			rsSelect.close();
			stmtSelect.close();
			conn.close();
			return true;
			
		} else {
			rsSelect.close();
			stmtSelect.close();
			conn.close();
			return false;
			
		}	
	}
	
	// 회원가입 메서드
	public Boolean insertMember(Member paramMember) throws Exception {
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sqlInsert = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES (?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		PreparedStatement stmtInsert = conn.prepareStatement(sqlInsert);
		stmtInsert.setString(1, (String)paramMember.getMemberId());
		stmtInsert.setString(2, (String)paramMember.getMemberPw());
		stmtInsert.setString(3, (String)paramMember.getMemberName());		
		int row = stmtInsert.executeUpdate();		
		if(row==1) {
			System.out.println("회원가입 성공");
			stmtInsert.close();
			conn.close();
			return true;
		} else {
			System.out.println("회원가입 실패");
			stmtInsert.close();
			conn.close();
			return false;
		}
	}
}
