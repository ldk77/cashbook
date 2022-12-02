package dao;
import vo.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import util.*;


public class MemberDao {
	//관리자 : 멤버레벨수정
	public int updateMemberLevel(Member member) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql="UPDATE member SET member_level= ? WHERE member_id= ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberLevel());
		stmt.setString(2, member.getMemberId());		
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
	// 관리자 : 멤버수
	public int selectMemberCount() {
		int cnt = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs =null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String cntSql = "SELECT COUNT(*) cnt FROM member";
		stmt = conn.prepareStatement(cntSql);
		rs = stmt.executeQuery();
		if(rs.next()) { // 전체 행의수
			cnt = rs.getInt("cnt");
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
		return cnt;
	}
	//관리자 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) {
		ArrayList<Member> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;	
		try {
		list = new ArrayList<Member>();
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "SELECT * FROM member ORDER BY createdate DESC LIMIT ?,?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1 , beginRow);
		stmt.setInt(2 , rowPerPage);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Member m = new Member();
			m.setMemberId(rs.getString("member_id"));
			m.setMemberLevel(rs.getInt("member_level"));
			m.setMemberName(rs.getString("member_name"));
			m.setCreatedate(rs.getString("createdate"));
			m.setMemberNo(rs.getInt("member_no"));
			m.setUpdatedate(rs.getString("updatedate"));
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
	//관리자 멤버 강퇴
	public int deleteMemberByAdmin(Member member) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "DELETE FROM MEMBER WHERE member_id=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
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
	
	
	// 2. Model
	public Member login(Member paramMember) { // 로그인
		Member resultMember = null; // 반환할 변수초기화
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;	
		try {
		DBUtil dbUtil = new DBUtil(); 
		conn = dbUtil.getConnection(); // db연결 메서드
		String sql = "SELECT member_id memberId,member_level memberLevel, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		rs = stmt.executeQuery();
		if(rs.next()==false) { // 디버깅
			//System.out.println("로그인 실패");
		}else {
			//System.out.println("로그인 성공");
			resultMember = new Member(); // 로그인 성공시에 객체 생성
			resultMember.setMemberId(rs.getString("memberId"));  
			resultMember.setMemberName(rs.getString("memberName"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
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
		return resultMember;
	}
	// memberId 중복 확인 메서드	
	public Boolean memberIdCheck(String memberId) throws Exception {
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		
		ResultSet rs = stmt.executeQuery();
		// 반환값 중복된 ID가 있으면 true 
		if(rs.next())
		{
			dbUtil.close(rs, stmt, conn);
			return true;
			
		} else {
			dbUtil.close(rs, stmt, conn);
			return false;
			
		}	
	}
	
	// 회원가입 메서드
	public Boolean insertMember(Member paramMember) throws Exception {
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES (?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, (String)paramMember.getMemberId());
		stmt.setString(2, (String)paramMember.getMemberPw());
		stmt.setString(3, (String)paramMember.getMemberName());		
		int row = stmt.executeUpdate();		
		if(row==1) {
			System.out.println("회원가입 성공");
			dbUtil.close(null, stmt, conn);
			return true;
		} else {
			System.out.println("회원가입 실패");
			dbUtil.close(null, stmt, conn);
			return false;
		}
	}

	//정보수정	
	public Boolean udateMember(Member paramMember) throws Exception {
		
		// 1. DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql = "UPDATE MEMBER SET member_name = ? WHERE member_id= ? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, (String)paramMember.getMemberName());
		stmt.setString(2, (String)paramMember.getMemberId());
		stmt.setString(3, (String)paramMember.getMemberPw());	
		int row = stmt.executeUpdate();		
		if(row==1) {		
			System.out.println("회원수정 성공");
			dbUtil.close(null, stmt, conn);		
			return true;
		} else {
			System.out.println("회원수정 실패");
			dbUtil.close(null, stmt, conn);	
			return false;
		}
	}	
	
	//멤버정보 확인
	public ArrayList<HashMap<String, Object>> selectMemberList(String memberId) {
		ArrayList<HashMap<String, Object>> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;	
		try {
		list = new ArrayList<HashMap<String, Object>>();
		//db접속
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, member_name memberName FROM member";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("memberId", rs.getString("memberId"));
			m.put("memberName", rs.getString("memberName"));
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
	//회원탈퇴 
	public int deleteMember(Member paramMember) {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
		//1.DB 연결		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();		
		String sql = "DELETE FROM MEMBER WHERE member_id=? AND member_pw = PASSWORD(?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, (String)paramMember.getMemberId());
		stmt.setString(2, (String)paramMember.getMemberPw());
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
