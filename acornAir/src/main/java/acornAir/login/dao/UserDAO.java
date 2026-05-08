package acornAir.login.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import acornAir.login.dto.UserDTO;
import acornAir.util.DBUtil;

public class UserDAO {

	DBUtil db = new DBUtil();

	public int insertUser(UserDTO user, String userPw) {
		String sql = "INSERT INTO TB_USER " + "(USER_ID, USER_PW, ENG_FIRST_NAME, ENG_LAST_NAME, "
				+ " KOR_FIRST_NAME, KOR_LAST_NAME, BIRTH_DATE, GENDER, "
				+ " PHONE_COUNTRY, USER_PHONE, USER_EMAIL, COUNTRY, " + " AGREE_SERVICE, AGREE_MILEAGE, AGREE_PRIVACY, "
				+ " AGREE_MARKETING, AGREE_NEWSLETTER, AGREE_PROMO, " + " AGREE_EMAIL, AGREE_SMS, REG_DATE) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, " + " 'Y', 'Y', 'Y', 'N', 'N', 'N', 'N', 'N', SYSDATE)";
		Connection con = null;
		PreparedStatement pst = null;
		int result = 0;

		try {
			con = db.dbcon();
			pst = con.prepareStatement(sql);

			pst.setString(1, user.getUserId());
			pst.setString(2, userPw);
			pst.setString(3, user.getEngFirstName());
			pst.setString(4, user.getEngLastName());
			pst.setString(5, user.getKorFirstName());
			pst.setString(6, user.getKorLastName());

			if (user.getBirthDate() != null) {
				pst.setDate(7, new java.sql.Date(user.getBirthDate().getTime()));
			} else {
				pst.setNull(7, java.sql.Types.DATE);
			}

			pst.setString(8, user.getGender());
			pst.setString(9, user.getPhoneCountry());
			pst.setString(10, user.getUserPhone());
			pst.setString(11, user.getUserEmail());
			pst.setString(12, user.getCountry());

			result = pst.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pst != null)
					pst.close();
			} catch (Exception e) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}

		return result;
	}

	public UserDTO login(String userId, String userPw) {
//        String sql = "SELECT USER_ID, ENG_LAST_NAME, ENG_FIRST_NAME, "
//                + "KOR_LAST_NAME, KOR_FIRST_NAME, USER_EMAIL, "
//                + "PHONE_COUNTRY, USER_PHONE, BIRTH_DATE, GENDER, COUNTRY "
//                + "FROM TB_USER "
//                + "WHERE USER_ID = ? AND USER_PW = ?";
		String sql = "SELECT USER_ID, ENG_LAST_NAME, ENG_FIRST_NAME, " + "KOR_LAST_NAME, KOR_FIRST_NAME, USER_EMAIL, "
				+ "PHONE_COUNTRY, USER_PHONE, BIRTH_DATE, GENDER, COUNTRY, USER_ROLE " + "FROM TB_USER "
				+ "WHERE USER_ID = ? AND USER_PW = ?";

		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		UserDTO user = null;

		try {
			con = db.dbcon();
			pst = con.prepareStatement(sql);
			pst.setString(1, userId);
			pst.setString(2, userPw);
			rs = pst.executeQuery();

			if (rs.next()) {
				user = new UserDTO();
				user.setUserId(rs.getString(1));
				user.setEngLastName(rs.getString(2));
				user.setEngFirstName(rs.getString(3));
				user.setKorLastName(rs.getString(4));
				user.setKorFirstName(rs.getString(5));
				user.setUserEmail(rs.getString(6));
				user.setPhoneCountry(rs.getString(7));
				user.setUserPhone(rs.getString(8));
				user.setBirthDate(rs.getDate(9));
				user.setGender(rs.getString(10));
				user.setCountry(rs.getString(11));
				user.setUserRole(rs.getString(12));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
			}
			try {
				if (pst != null)
					pst.close();
			} catch (Exception e) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}

		return user;
	}

	public int checkId(String userId) {
		String sql = "SELECT COUNT(*) FROM TB_USER WHERE USER_ID = ?";

		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		int count = 0;

		try {
			con = db.dbcon();
			pst = con.prepareStatement(sql);
			pst.setString(1, userId);
			rs = pst.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
			}
			try {
				if (pst != null)
					pst.close();
			} catch (Exception e) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}

		return count;
	}

	public int deleteUser(String userId) {
		Connection con = null;
		PreparedStatement pst = null;
		int result = 0;

		try {
			con = db.dbcon();
			con.setAutoCommit(false);

			String sql1 = "DELETE FROM TB_BAGGAGE WHERE BOOKING_ID IN "
					+ "(SELECT BOOKING_ID FROM TB_BOOKING WHERE USER_ID = ?)";
			pst = con.prepareStatement(sql1);
			pst.setString(1, userId);
			pst.executeUpdate();
			pst.close();

			String sql2 = "DELETE FROM TB_SEAT WHERE BOOKING_ID IN "
					+ "(SELECT BOOKING_ID FROM TB_BOOKING WHERE USER_ID = ?)";
			pst = con.prepareStatement(sql2);
			pst.setString(1, userId);
			pst.executeUpdate();
			pst.close();

			String sql3 = "DELETE FROM TB_PASSENGER WHERE BOOKING_ID IN "
					+ "(SELECT BOOKING_ID FROM TB_BOOKING WHERE USER_ID = ?)";
			pst = con.prepareStatement(sql3);
			pst.setString(1, userId);
			pst.executeUpdate();
			pst.close();

			String sql4 = "DELETE FROM TB_BOOKING WHERE USER_ID = ?";
			pst = con.prepareStatement(sql4);
			pst.setString(1, userId);
			pst.executeUpdate();
			pst.close();

			String sql5 = "DELETE FROM TB_USER WHERE USER_ID = ?";
			pst = con.prepareStatement(sql5);
			pst.setString(1, userId);
			result = pst.executeUpdate();

			con.commit();

		} catch (Exception e) {
			try {
				if (con != null)
					con.rollback();
			} catch (Exception ex) {
			}
			e.printStackTrace();
		} finally {
			try {
				if (pst != null)
					pst.close();
			} catch (Exception e) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}

		return result;
	}
	
	public java.util.List<UserDTO> getAllUsers() {
		String sql = "SELECT u.USER_ID, u.ENG_LAST_NAME, u.ENG_FIRST_NAME, "
		        + "u.KOR_LAST_NAME, u.KOR_FIRST_NAME, u.USER_EMAIL, "
		        + "u.PHONE_COUNTRY, u.USER_PHONE, u.BIRTH_DATE, u.GENDER, "
		        + "u.COUNTRY, u.USER_ROLE, "
		        + "NVL(COUNT(b.BOOKING_ID), 0) AS RES_COUNT "
		        + "FROM TB_USER u "
		        + "LEFT JOIN TB_BOOKING b ON u.USER_ID = b.USER_ID "
		        + "GROUP BY u.USER_ID, u.ENG_LAST_NAME, u.ENG_FIRST_NAME, "
		        + "u.KOR_LAST_NAME, u.KOR_FIRST_NAME, u.USER_EMAIL, "
		        + "u.PHONE_COUNTRY, u.USER_PHONE, u.BIRTH_DATE, u.GENDER, "
		        + "u.COUNTRY, u.USER_ROLE, u.REG_DATE "
		        + "ORDER BY u.REG_DATE DESC";

	    Connection con = null;
	    PreparedStatement pst = null;
	    ResultSet rs = null;
	    java.util.List<UserDTO> list = new java.util.ArrayList<>();

	    try {
	        con = db.dbcon();
	        pst = con.prepareStatement(sql);
	        rs = pst.executeQuery();

	        while (rs.next()) {
	            UserDTO user = new UserDTO();
	            user.setUserId(rs.getString("USER_ID"));
	            user.setEngLastName(rs.getString("ENG_LAST_NAME"));
	            user.setEngFirstName(rs.getString("ENG_FIRST_NAME"));
	            user.setKorLastName(rs.getString("KOR_LAST_NAME"));
	            user.setKorFirstName(rs.getString("KOR_FIRST_NAME"));
	            user.setUserEmail(rs.getString("USER_EMAIL"));
	            user.setPhoneCountry(rs.getString("PHONE_COUNTRY"));
	            user.setUserPhone(rs.getString("USER_PHONE"));
	            user.setBirthDate(rs.getDate("BIRTH_DATE"));
	            user.setGender(rs.getString("GENDER"));
	            user.setCountry(rs.getString("COUNTRY"));
	            user.setUserRole(rs.getString("USER_ROLE"));

	            list.add(user);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { if (rs != null) rs.close(); } catch (Exception e) {}
	        try { if (pst != null) pst.close(); } catch (Exception e) {}
	        try { if (con != null) con.close(); } catch (Exception e) {}
	    }

	    return list;
	}

//mypage getUserById 추가

	public UserDTO getUserById(String userId) {

		// 1. SQL 수정: login 활용
		String sql = "SELECT USER_ID, ENG_LAST_NAME, ENG_FIRST_NAME, " + "KOR_LAST_NAME, KOR_FIRST_NAME, USER_EMAIL, "
				+ "PHONE_COUNTRY, USER_PHONE, BIRTH_DATE, GENDER, COUNTRY " + "FROM TB_USER " + "WHERE USER_ID = ?"; // ID만으로
																														// 조회

		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		UserDTO user = null;

		try {
			con = db.dbcon();
			pst = con.prepareStatement(sql);
			pst.setString(1, userId); // 파라미터도 ID 하나만 설정
			rs = pst.executeQuery();

			if (rs.next()) {
				user = new UserDTO();
				// 기존 login 메서드의 Mapping 로직 그대로 사용
				user.setUserId(rs.getString(1));
				user.setEngLastName(rs.getString(2));
				user.setEngFirstName(rs.getString(3));
				user.setKorLastName(rs.getString(4));
				user.setKorFirstName(rs.getString(5));
				user.setUserEmail(rs.getString(6));
				user.setPhoneCountry(rs.getString(7));
				user.setUserPhone(rs.getString(8));
				user.setBirthDate(rs.getDate(9));
				user.setGender(rs.getString(10));
				user.setCountry(rs.getString(11));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 해제 로직 (login 메서드와 동일)
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
			}
			try {
				if (pst != null)
					pst.close();
			} catch (Exception e) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}

		return user;
	}

}
