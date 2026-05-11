// ChatDao.java (예시)
package acornAir.Chat.dao;

import java.sql.*;

public class ChatDao {
	public String getAnswer(String keyword) {
		String answer = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 1. DB 연결 (기존에 사용하시던 DB 연결 로직이나 Connection Pool을 사용하세요)
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// 이 방식은 리스너가 SID를 못 찾는 에러를 거의 완벽하게 해결합니다.
		    String url = "jdbc:oracle:thin:@localhost:1521:testdb";
			//String url = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SID=xe)))";
			conn = DriverManager.getConnection(url, "scott", "tiger");
			// 2. 쿼리 실행
			String sql = "SELECT answer FROM chatbot_data WHERE keyword = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, keyword);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				answer = rs.getString("answer");
			} else {
				answer = "죄송합니다. '" + keyword + "'에 대해 학습된 내용이 없습니다.";
			}
		} catch (Exception e) {
			e.printStackTrace();
			answer = "데이터베이스 연결 오류가 발생했습니다.";
		} finally {
			// 3. 자원 해제 (필수!)
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return answer;
	}
	
	
	public static void main(String[] args) {
		ChatDao dao = new ChatDao();
		String result = dao.getAnswer("기내식");
		
		System.out.println(result);
		
	}
}